workflow xVCFMergeWorkflow {
	call xVCFMerge
}

task xVCFMerge {
	Array[String] input_files
	String output_file
	String billing_project
	String workspace
	runtime {
	    docker: "xbrianh/xsamtools:v0.5.0"
		memory: "64G"
		cpu: "8"
	}
	command {
		export GOOGLE_PROJECT=${billing_project}
		export WORKSPACE_NAME=${workspace}
		xsamtools vcf merge --inputs ${sep="," input_files} --output ${output_file}
	}
}
