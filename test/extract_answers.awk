BEGIN { 
	in_q=0 
	q_pattern="```.*question_" qst
}

$0 ~ q_pattern {
	in_q=1;
	match($0,"question_[a-z]*[0-9]+")
	printf("%s(){\n",substr($0,RSTART,RLENGTH));
}

!/```/{
	if (in_q){
		printf("\t%s\n",$0)
	}
}

/^```$/{
	if (in_q){ 
		printf("}\n")
		in_q=0
	}
}