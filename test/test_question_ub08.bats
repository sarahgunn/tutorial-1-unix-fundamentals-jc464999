#!/usr/local/bin/bats

load "${BATS_LIBDIR}/bats-support/load.bash"
load "${BATS_LIBDIR}bats-assert/load.bash"

setup(){
	qst="ub08"
	source ${BATS_TEST_DIRNAME}/answer_${qst}.sh
	TEST_TEMP_DIR="$(mktemp -d)"
	cd ${TEST_TEMP_DIR}	
	cp -r ${BATS_TEST_DIRNAME}/../data .
	chmod -R +w data 
	question_${qst}
	aa_expect=$(ls data/*_AA.fasta | xargs -I{} basename {} | sort)
	na_expect=$(ls data/*_NA.fasta | xargs -I{} basename {} | sort)
}

teardown(){
 	rm -r "$TEST_TEMP_DIR"
}


@test "Q8 learn/nucleotide and learn/protein should both exist" {
    assert [ -d learn/protein ]
    assert [ -d learn/nucleotide ]
}

@test "Q8 assert_equal() all AA files should be in learn/protein" {
	assert_equal "$(ls learn/protein/*_AA.fasta | xargs -I{} basename {} | sort)" "${aa_expect}"
}

@test "Q8 assert_equal() all NA files should be in learn/nucleotide" {
	assert_equal "$(ls learn/nucleotide/*_NA.fasta | xargs -I{} basename {} | sort)" "${na_expect}"
}

@test "Q8 assert_success() no errors should be generated" {
	assert_success
}