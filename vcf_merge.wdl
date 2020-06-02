workflow xVCFMergeWorkflow {
	call xVCFMerge
}

task xVCFMerge {
	String bucket
	String output_key
	String input_keys
	runtime {
	    docker: "xbrianh/xvcfmerge"
		memory: "64G"
		cpu: "8"
	}
	command {
		xsamtools vcf merge --inputs ${input_keys} --output ${output_key}
	}
}
