#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"


setup(){
	qst="ub01"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}
	answer=$(question_${qst})
	correct_answer=$(pwd)
}

teardown(){
	chmod -R u+rwx ${TEST_TEMP_DIR}
 	rm -r "$TEST_TEMP_DIR"
}

@test "Q1 assert_success() should not produce errors" {
	assert_success
}

@test "Q1 assert_equal() should print the current working directory" {
	assert_equal "${answer}" "${correct_answer}"
}