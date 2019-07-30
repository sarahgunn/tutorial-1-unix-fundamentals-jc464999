#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub05"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}
}

teardown(){
	chmod -R u+rwx ${TEST_TEMP_DIR}
 	rm -r "$TEST_TEMP_DIR"
}

@test "Q5 assert_success()" {
	assert_success
}

@test "Q5 learn directory should exist" {
	answer_result=$(question_${qst})
    assert [ -d learn ]
}

@test "Q5 assert_success() attempting to make the directory should not generate an error" {
	mkdir learn
	answer_result=$(question_${qst})
	assert_success
}