#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub09"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}

	cp -r ${BATS_TEST_DIRNAME}/../data .
	chmod -R +w data 
	question_${qst}
	aa_expect=$(cat data/*_AA.fasta)
}

teardown(){
 	rm -r "$TEST_TEMP_DIR"
}


@test "Q9 the learn directory should exist" {
    assert [ -d learn ]
}

@test "Q9 learn/primates_AA.fasta should exist" {
	assert [ -f learn/primates_AA.fasta ] 
}

@test "Q9 assert_equal() learn/primates_AA.fasta should contain all AA sequences" {
	assert_equal "$(cat learn/primates_AA.fasta)" "${aa_expect}"
}

@test "Q9 assert_success() no errors should be generated" {
	assert_success
}