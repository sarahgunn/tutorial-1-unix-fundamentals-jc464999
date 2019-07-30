#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub10"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}
	cp -r ${BATS_TEST_DIRNAME}/../data .
	chmod -R +w data 
}

teardown(){
 	rm -r "$TEST_TEMP_DIR"
}


@test "Q10 assert_equal() should print the correct number of sequences" {
	assert_equal "$(ls data/*_AA.fasta | wc -l)" "$(question_${qst})"
}

@test "Q10 assert_success() no errors should be generated" {
	assert_success
}