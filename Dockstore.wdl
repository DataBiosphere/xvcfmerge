workflow xVCFMergeWorkflow {
	call xVCFMerge
}

task xVCFMerge {
	String bucket
	String output_key
	Array[String] input_keys
	runtime {
	    docker: "xbrianh/xvcfmerge"
		memory: "64G"
		cpu: "8"
	}
	command {
		python3 /home/xvcfmerge/merge_vcfs.py ${bucket} ${output_key} ${sep=' ' input_keys}
	}
}
