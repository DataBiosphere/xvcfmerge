test: lint cromwell.jar
	java -jar cromwell.jar run vcf_merge.wdl --inputs test.json

lint: womtool.jar
	java -jar womtool.jar validate vcf_merge.wdl

womtool.jar:
	wget -O womtool.jar https://github.com/broadinstitute/cromwell/releases/download/52/womtool-52.jar

cromwell.jar:
	wget -O cromwell.jar https://github.com/broadinstitute/cromwell/releases/download/52/cromwell-52.jar

clean:
	git clean -dfx

.PHONY: test lint clean
