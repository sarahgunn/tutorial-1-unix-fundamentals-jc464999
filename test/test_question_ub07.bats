#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub07"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}
	ln -s ${BATS_TEST_DIRNAME}/../data .
}

teardown(){
	chmod -R u+rwx ${TEST_TEMP_DIR}
 	rm -r "$TEST_TEMP_DIR"
}

@test "Q7 assert_success()" {
	assert_success
}

@test "Q7 assert_equal() should correctly list all AA files in the data directory" {
	output=$(question_${qst})
	assert_equal "${output}" "$(cd ${BATS_TEST_DIRNAME}/..; ls data/*AA.fasta)"
}
