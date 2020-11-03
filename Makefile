include common.mk

test: lint plugin
	###############################################################
	# "This does NOT test DRS resolved VCF workflows."            #
	# "Please make sure `make test_drs` passes prior to release." #
	###############################################################
	gsutil cp tests/fixtures/a.vcf.gz gs://fc-9169fcd1-92ce-4d60-9d2d-d19fd326ff10/test_merge_vcfs/a.vcf.gz
	gsutil cp tests/fixtures/b.vcf.gz gs://fc-9169fcd1-92ce-4d60-9d2d-d19fd326ff10/test_merge_vcfs/b.vcf.gz
	miniwdl run --verbose --copy-input-files vcf_merge.wdl --input tests/gs_input.json

test_drs: lint plugin
	miniwdl run --verbose --copy-input-files vcf_merge.wdl --input tests/drs_input.json

plugin:
	pip install --upgrade --no-cache-dir tests/infra/inject_gs_credentials

lint:
	miniwdl check --strict vcf_merge.wdl

clean:
	git clean -dfx

.PHONY: test test_drs plugin lint clean
