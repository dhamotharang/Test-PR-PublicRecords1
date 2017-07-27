
//Compares the positional differences of 2 SSN's already within the same record
//Rules for over-laying the Candidate SSN with the Suspect SSN:
//1) Only 1 number is off -> any position 1 thru 9
//2) 2 or 3 consecutive numbers (same digits positionally)
//   are off but the sub-sets, collectively, each have the
//   same numbers.
//   Ex: 
//   SUSPECT:   123-45-6789
//   CANDIDATE: 312-45-6789

export mac_ssn_diffs(infile, suspect_ssn, candidate_ssn, outfile) := macro

comparative_set := infile(  candidate_ssn<>'' and suspect_ssn<>candidate_ssn);
skip_these      := infile(~(candidate_ssn<>'' and suspect_ssn<>candidate_ssn));

r_ssn_diffs := record
 string9 ssn_pos_diff:='';
 comparative_set;
end;

r_ssn_diffs t_find_pos_diff(comparative_set le) := transform
  
 boolean v1 := le.suspect_ssn[1]=le.candidate_ssn[1];
 boolean v2 := le.suspect_ssn[2]=le.candidate_ssn[2];
 boolean v3 := le.suspect_ssn[3]=le.candidate_ssn[3];
 boolean v4 := le.suspect_ssn[4]=le.candidate_ssn[4];
 boolean v5 := le.suspect_ssn[5]=le.candidate_ssn[5];
 boolean v6 := le.suspect_ssn[6]=le.candidate_ssn[6];
 boolean v7 := le.suspect_ssn[7]=le.candidate_ssn[7];
 boolean v8 := le.suspect_ssn[8]=le.candidate_ssn[8];
 boolean v9 := le.suspect_ssn[9]=le.candidate_ssn[9];
 
 string1 v1a := if(v1=true,' ','1');
 string1 v2a := if(v2=true,' ','2');
 string1 v3a := if(v3=true,' ','3');
 string1 v4a := if(v4=true,' ','4');
 string1 v5a := if(v5=true,' ','5');
 string1 v6a := if(v6=true,' ','6');
 string1 v7a := if(v7=true,' ','7');
 string1 v8a := if(v8=true,' ','8');
 string1 v9a := if(v9=true,' ','9');
 
 self.ssn_pos_diff := v1a
                     +v2a
				     +v3a
				     +v4a
				     +v5a
				     +v6a
				     +v7a
				     +v8a
				     +v9a
				     ;
 
 self := le;
end;

p_ssn_diffs := project(comparative_set,t_find_pos_diff(left));

r_ssn_switch := record
 string1 ssn_switch      :='';
 string3 suspect_sorted  :='';
 string3 candidate_sorted:='';
 p_ssn_diffs;
end;

r_ssn_switch t_ssn_switch(p_ssn_diffs le) := transform

 string v_ssn_pos_diff := trim(le.ssn_pos_diff,left,right);
 
 boolean nbrs_off_1 := length(v_ssn_pos_diff)=1;
 boolean nbrs_off_2 := length(v_ssn_pos_diff)=2;
 boolean nbrs_off_3 := length(v_ssn_pos_diff)=3;
 
 integer v1 := (integer)trim(le.ssn_pos_diff,left,right)[1];
 integer v2 := (integer)trim(le.ssn_pos_diff,left,right)[2];
 integer v3 := (integer)trim(le.ssn_pos_diff,left,right)[3];
  
 string3 v_suspect_3   := if(nbrs_off_2=true,le.suspect_ssn[v1..v2],  le.suspect_ssn[v1..v3]);
 string3 v_candidate_3 := if(nbrs_off_2=true,le.candidate_ssn[v1..v2],le.candidate_ssn[v1..v3]);
 
 string v_suspect_pos1 := v_suspect_3[1];
 string v_suspect_pos2 := v_suspect_3[2];
 string v_suspect_pos3 := v_suspect_3[3];
 
 string v_candidate_pos1 := v_candidate_3[1];
 string v_candidate_pos2 := v_candidate_3[2];
 string v_candidate_pos3 := v_candidate_3[3];

 string3 v_suspect_sorted := if(nbrs_off_2=true or nbrs_off_3=true,
                             if(v_suspect_pos1<=v_suspect_pos2 and v_suspect_pos2<=v_suspect_pos3,
                              v_suspect_pos1+v_suspect_pos2+v_suspect_pos3,
							 if(v_suspect_pos1<=v_suspect_pos3 and v_suspect_pos3<=v_suspect_pos2,
                              v_suspect_pos1+v_suspect_pos3+v_suspect_pos2,
							 if(v_suspect_pos2<=v_suspect_pos1 and v_suspect_pos1<=v_suspect_pos3,
                              v_suspect_pos2+v_suspect_pos1+v_suspect_pos3,
							 if(v_suspect_pos2<=v_suspect_pos3 and v_suspect_pos3<=v_suspect_pos1,
                              v_suspect_pos2+v_suspect_pos3+v_suspect_pos1,
							 if(v_suspect_pos3<=v_suspect_pos1 and v_suspect_pos1<=v_suspect_pos2,
                              v_suspect_pos3+v_suspect_pos1+v_suspect_pos2,
							 if(v_suspect_pos3<=v_suspect_pos2 and v_suspect_pos2<=v_suspect_pos1,
                              v_suspect_pos3+v_suspect_pos2+v_suspect_pos1,
							 '')))))),'');

 string3 v_candidate_sorted := if(nbrs_off_2=true or nbrs_off_3=true,
                             if(v_candidate_pos1<=v_candidate_pos2 and v_candidate_pos2<=v_candidate_pos3,
                              v_candidate_pos1+v_candidate_pos2+v_candidate_pos3,
							 if(v_candidate_pos1<=v_candidate_pos3 and v_candidate_pos3<=v_candidate_pos2,
                              v_candidate_pos1+v_candidate_pos3+v_candidate_pos2,
							 if(v_candidate_pos2<=v_candidate_pos1 and v_candidate_pos1<=v_candidate_pos3,
                              v_candidate_pos2+v_candidate_pos1+v_candidate_pos3,
							 if(v_candidate_pos2<=v_candidate_pos3 and v_candidate_pos3<=v_candidate_pos1,
                              v_candidate_pos2+v_candidate_pos3+v_candidate_pos1,
							 if(v_candidate_pos3<=v_candidate_pos1 and v_candidate_pos1<=v_candidate_pos2,
                              v_candidate_pos3+v_candidate_pos1+v_candidate_pos2,
							 if(v_candidate_pos3<=v_candidate_pos2 and v_candidate_pos2<=v_candidate_pos1,
                              v_candidate_pos3+v_candidate_pos2+v_candidate_pos1,
							 '')))))),'');
 
 self.ssn_switch       := if(nbrs_off_1=true or ((nbrs_off_2 or nbrs_off_3) and v_suspect_sorted=v_candidate_sorted),'Y','N');
 self.suspect_sorted   := v_suspect_sorted;
 self.candidate_sorted := v_candidate_sorted;
 self                  := le;
 
end;

p_ssn_switch         := project(p_ssn_diffs,t_ssn_switch(left));
skip_these_projected := project(project(skip_these,r_ssn_diffs),r_ssn_switch);

bad_ssns := p_ssn_switch(ssn_switch='Y');// : persist('persist::conflicted_ssns');
//output(choosen(bad_ssns,1000),named('conflicted_ssns_sample'));

outfile := p_ssn_switch + skip_these_projected;
 
endmacro;