#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub06"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}
}

teardown(){
	chmod -R u+rwx ${TEST_TEMP_DIR}
 	rm -r "$TEST_TEMP_DIR"
}

@test "Q6 assert_success()" {
	assert_success
}

@test "Q6 learn/nucleotide and learn/protein should both exist" {
	question_${qst}
    assert [ -d learn/protein ]
    assert [ -d learn/nucleotide ]
}


@test "Q6 assert_success() no errors should be generated" {
	question_${qst}
	assert_success
}