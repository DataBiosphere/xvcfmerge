version 1.0

task xVCFMerge {
    input {
        Array[String] input_files
        String output_file
        String billing_project
        String workspace
        Boolean force_samples = false
        Boolean print_header = false
        Int addl_disk_space = 1
        Int cpu = 8
        Int memory = 64
        Int preemptible = 0
    }
    Int input_size = ceil(size(input_files, "GB"))
    Int final_disk_size = input_size + addl_disk_space
    runtime {
        docker: "ucsctlp/xsamtools:v0.5.9"
        disks: "local-disk " + final_disk_size + " HDD"
        memory: "${memory}G"
        cpu: "${cpu}"
        preemptible: "${preemptible}"
    }
    command {
        export GOOGLE_PROJECT=${billing_project}
        export WORKSPACE_NAME=${workspace}
        cmd_base="xsamtools vcf merge --inputs ${sep="," input_files} --output ${output_file}"
        cmd_force=""
        cmd_print=""
        if [ "${force_samples}" == "true" ]; then
            cmd_force=" --force-samples"
        fi
        if [ "${print_header}" == "true" ]; then
            cmd_print=" --print-header"
        fi
        cmd="$cmd_base$cmd_force$cmd_print"

        eval "$cmd"
    }
}

workflow xVCFMergeWorkflow {
    input {
        Array[String] input_files
        String output_file
        String billing_project
        String workspace
        Boolean? force_samples
        Boolean? print_header
        Int? cpu
        Int? memory
        Int? preemptible
    }
    call xVCFMerge { input: input_files=input_files,
                            output_file=output_file,
                            billing_project=billing_project,
                            workspace=workspace,
                            force_samples = force_samples,
                            print_header = print_header,
                            cpu=cpu,
                            memory=memory,
                            preemptible=preemptible }
}
