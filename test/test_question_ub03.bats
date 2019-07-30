#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub03"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}
	answer=$(question_${qst})
	correct_answer=$(echo ~)
}

teardown(){
	chmod -R u+rwx ${TEST_TEMP_DIR}
 	rm -r "$TEST_TEMP_DIR"
}

@test "Q3 assert_success()" {
	assert_success
}

@test "Q3 assert_equal() should print the absolute path to your home directory" {
	assert_equal "${answer}" "${correct_answer}"
}
