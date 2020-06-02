workflow xVCFMergeWorkflow {
	call xVCFMerge
}

task xVCFMerge {
	String inputs
	String output
	runtime {
	    docker: "xbrianh/xvcfmerge"
		memory: "64G"
		cpu: "8"
	}
	command {
		xsamtools vcf merge --inputs ${inputs} --output ${output}
	}
}
