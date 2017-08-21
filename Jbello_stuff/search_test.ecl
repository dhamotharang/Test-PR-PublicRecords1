EXPORT	search_test(integer p_key,integer a_key,integer b_key, integer c_key)	:=	FUNCTION


r := record
	unsigned6	did;
	string9		ssn1;
	string9		ssn2;
	boolean		other_src_exist_with_ssn;
	boolean		ssn1_found_in_other_sources;
	boolean		ssn2_found_in_other_sources;
	string9		pos_diff;
	integer		p_diff;
	integer		distinct_ssn_cnt;
	integer		distinct_conbinations;
	integer		intersect_ratio;
end;

x := dataset('~thor_data400::persist::jbello_death_final_plus',{r,UNSIGNED8 RecPos{VIRTUAL(FilePosition)}},flat);

abckey := INDEX(x,
				{p_diff
				,distinct_ssn_cnt
				,distinct_conbinations
				,intersect_ratio
				,RecPos}
			,'~thor_data400::persist::key::jbello_death_final_plus');

		RETURN FETCH(x, abckey(	p_diff					=	p_key
								,distinct_ssn_cnt		=	a_key
								,distinct_conbinations	>=	b_key
								,intersect_ratio		>=	c_key)
						,RIGHT.RecPos);

END;	