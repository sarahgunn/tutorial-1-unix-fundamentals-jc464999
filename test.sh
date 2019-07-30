#!/bin/bash

question=$1

awk -v qst=${question} -f ./test/extract_answers.awk exercises.Rmd > test/answer_${question}.sh

export BATS_LIBDIR=${HOME}/.local/lib/

eval bats test/test_question_${question}.bats
