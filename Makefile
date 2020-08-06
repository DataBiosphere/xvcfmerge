test: lint cromwell.jar
	java -jar cromwell.jar run vcf_merge.wdl --inputs test.json

lint: wdltool.jar
	java -jar wdltool.jar validate vcf_merge.wdl

wdltool.jar:
	wget -O wdltool.jar https://github.com/broadinstitute/wdltool/releases/download/0.14/wdltool-0.14.jar

cromwell.jar:
	wget -O cromwell.jar https://github.com/broadinstitute/cromwell/releases/download/52/cromwell-52.jar

clean:
	git clean -dfx

.PHONY: test lint clean
