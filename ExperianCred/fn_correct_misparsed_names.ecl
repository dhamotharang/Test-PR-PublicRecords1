import idl_header;

export fn_correct_misparsed_names(dataset(recordof(experiancred.files.file_history)) in_exp_cred) := function

idl_name := idl_header.name_count_ds(length(trim(name))>1);//filter initials

r1 := record

 in_exp_cred;
 
 decimal6_3 surname_as_fname    :=0;
 decimal6_3 first_name_as_fname :=0;
 decimal6_3 surname2_as_fname   :=0;
 decimal6_3 first_name2_as_fname:=0;
 decimal6_3 surname3_as_fname   :=0;
 decimal6_3 first_name3_as_fname:=0;
 decimal6_3 surname4_as_fname   :=0;
 decimal6_3 first_name4_as_fname:=0;

 integer    lname_as_fname_cnt  :=0;
 integer    fname_as_fname_cnt  :=0;
 integer    lname_placement_cnt :=0;
 integer    fname_placement_cnt :=0;

 integer    lname_as_fname_cnt2 :=0;
 integer    fname_as_fname_cnt2 :=0;
 integer    lname_placement_cnt2:=0;
 integer    fname_placement_cnt2:=0;

 integer    lname_as_fname_cnt3 :=0;
 integer    fname_as_fname_cnt3 :=0;
 integer    lname_placement_cnt3:=0;
 integer    fname_placement_cnt3:=0;

 integer    lname_as_fname_cnt4 :=0;
 integer    fname_as_fname_cnt4 :=0;
 integer    lname_placement_cnt4:=0;
 integer    fname_placement_cnt4:=0;
 
 typeof(in_exp_cred.first_name)       reparsed_first_name  :='';
 typeof(in_exp_cred.middle_name)      reparsed_middle_name :='';
 typeof(in_exp_cred.surname)          reparsed_surname     :='';
 typeof(in_exp_cred.generation_code)  reparsed_generation  :='';

 typeof(in_exp_cred.first_name2)      reparsed_first_name2 :='';
 typeof(in_exp_cred.middle_name2)     reparsed_middle_name2:='';
 typeof(in_exp_cred.surname2)         reparsed_surname2    :='';
 typeof(in_exp_cred.generation_code2) reparsed_generation2 :='';
 
 typeof(in_exp_cred.first_name3)      reparsed_first_name3 :='';
 typeof(in_exp_cred.middle_name3)     reparsed_middle_name3:='';
 typeof(in_exp_cred.surname3)         reparsed_surname3    :='';
 typeof(in_exp_cred.generation_code3) reparsed_generation3 :='';

 typeof(in_exp_cred.first_name4)      reparsed_first_name4 :='';
 typeof(in_exp_cred.middle_name4)     reparsed_middle_name4:='';
 typeof(in_exp_cred.surname4)         reparsed_surname4    :='';
 typeof(in_exp_cred.generation_code4) reparsed_generation4 :='';
 
 boolean rule1_name1:=false;
 boolean rule1_name2:=false;
 boolean rule1_name3:=false;
 boolean rule1_name4:=false;
 
 boolean rule2_name1:=false;
 boolean rule2_name2:=false;
 boolean rule2_name3:=false;
 boolean rule2_name4:=false;
 
 boolean rule3_name2:=false;
 boolean rule3_name3:=false;
 boolean rule3_name4:=false;
 
 boolean rule4_name2:=false;
 boolean rule4_name3:=false;
 boolean rule4_name4:=false;

 boolean rule5_name2:=false;
 boolean rule5_name3:=false;
 boolean rule5_name4:=false;

 boolean rule6_name2:=false;
 boolean rule6_name3:=false;
 boolean rule6_name4:=false;
end;

r1 x1(in_exp_cred le, idl_name ri) := transform
 self.surname_as_fname   := ri.pct_fname;
 self.lname_as_fname_cnt := ri.fname_cnt;
 self.lname_placement_cnt:= ri.placement_cnt;
 self := le;
end;

j1 := join(in_exp_cred,idl_name,left.surname=right.name,x1(left,right),lookup,left outer);

r1 x2(j1 le, idl_name ri) := transform
 self.first_name_as_fname := ri.pct_fname;
 self.fname_as_fname_cnt  := ri.fname_cnt;
 self.fname_placement_cnt := ri.placement_cnt;
 self := le;
end;

j2 := join(j1,idl_name,left.first_name=right.name,x2(left,right),lookup,left outer);

r1 x3(j2 le, idl_name ri) := transform
 self.surname2_as_fname  := ri.pct_fname;
 self.lname_as_fname_cnt2 := ri.fname_cnt;
 self.lname_placement_cnt2:= ri.placement_cnt;
 self := le;
end;

j3 := join(j2,idl_name,left.surname2=right.name,x3(left,right),lookup,left outer);

r1 x4(j3 le, idl_name ri) := transform
 self.first_name2_as_fname := ri.pct_fname;
 self.fname_as_fname_cnt2  := ri.fname_cnt;
 self.fname_placement_cnt2 := ri.placement_cnt;
 self := le;
end;

j4 := join(j3,idl_name,left.first_name2=right.name,x4(left,right),lookup,left outer);

r1 x5(j4 le, idl_name ri) := transform
 self.surname3_as_fname   := ri.pct_fname;
 self.lname_as_fname_cnt3 := ri.fname_cnt;
 self.lname_placement_cnt3:= ri.placement_cnt;
 self := le;
end;

j5 := join(j4,idl_name,left.surname3=right.name,x5(left,right),lookup,left outer);

r1 x6(j5 le, idl_name ri) := transform
 self.first_name3_as_fname := ri.pct_fname;
 self.fname_as_fname_cnt3  := ri.fname_cnt;
 self.fname_placement_cnt3 := ri.placement_cnt;
 self := le;
end;

j6 := join(j5,idl_name,left.first_name3=right.name,x6(left,right),lookup,left outer);

r1 x7(j6 le, idl_name ri) := transform
 self.surname4_as_fname   := ri.pct_fname;
 self.lname_as_fname_cnt4 := ri.fname_cnt;
 self.lname_placement_cnt4:= ri.placement_cnt;
 self := le;
end;

j7 := join(j6,idl_name,left.surname4=right.name,x7(left,right),lookup,left outer);

r1 x8(j6 le, idl_name ri) := transform
 self.first_name4_as_fname := ri.pct_fname;
 self.fname_as_fname_cnt4  := ri.fname_cnt;
 self.fname_placement_cnt4 := ri.placement_cnt;
 self := le;
end;

j8 := join(j7,idl_name,left.first_name4=right.name,x8(left,right),lookup,left outer);

//bring in the counts of the names so that rare names are excluded
boolean rule1_boolean(decimal6_3 v_lname_as_fname_pct, decimal6_3 v_fname_as_fname_pct, string v_fn, string v_mn, string v_ln, integer v_lname_as_fname_cnt, integer v_fname_as_fname_cnt, integer v_fname_placement_cnt, integer v_lname_placement_cnt) := function
 is_rule1 :=    length(trim(v_fn))>1
            and length(trim(v_ln))>1
			and length(trim(v_mn))<2 
			//skip dual first names AND skip dual last names
			and (v_lname_as_fname_pct>=.75 and v_fname_as_fname_pct>=.75)=false
			and (v_lname_as_fname_pct<=.15 and v_fname_as_fname_pct<=.15)=false
			//generally consider the greater the percentage the fewer instances we need to see
			//conversely, the lower the percentage the greater the number of instances
			and (   (v_lname_as_fname_pct=1 and v_lname_placement_cnt>100000)
			     or (v_lname_as_fname_pct>=.65 and v_fname_as_fname_pct=0 and v_lname_placement_cnt>250000)
				 or (v_fname_as_fname_pct=0 and v_fname_placement_cnt>10000)
				 //if there's a 70% gap between fname_as_fname and lname_as_fname flip them
				 or (v_lname_as_fname_pct-v_fname_as_fname_pct>=.75 and v_fname_placement_cnt>50 and v_lname_as_fname_cnt>100000)
				 or ((v_lname_as_fname_pct between .85 and .999) and (v_fname_as_fname_pct between .001 and .15) and v_lname_placement_cnt>15000 and v_fname_placement_cnt>15000)
				)
			;
			
 return is_rule1;
end;

r1 x9(j8 le) := transform
  
 //middle_name condition is so i don't flip records where possibly the first_name and middle_name are flipped
 boolean rule1_for_name1 := rule1_boolean(le.surname_as_fname, le.first_name_as_fname, le.first_name ,le.middle_name ,le.surname ,le.lname_as_fname_cnt ,le.fname_as_fname_cnt, le.fname_placement_cnt ,le.lname_placement_cnt );
 boolean rule1_for_name2 := rule1_boolean(le.surname2_as_fname,le.first_name2_as_fname,le.first_name2,le.middle_name2,le.surname2,le.lname_as_fname_cnt2,le.fname_as_fname_cnt2,le.fname_placement_cnt2,le.lname_placement_cnt2);
 boolean rule1_for_name3 := rule1_boolean(le.surname3_as_fname,le.first_name3_as_fname,le.first_name3,le.middle_name3,le.surname3,le.lname_as_fname_cnt3,le.fname_as_fname_cnt3,le.fname_placement_cnt3,le.lname_placement_cnt3);
 boolean rule1_for_name4 := rule1_boolean(le.surname4_as_fname,le.first_name4_as_fname,le.first_name4,le.middle_name4,le.surname4,le.lname_as_fname_cnt4,le.fname_as_fname_cnt4,le.fname_placement_cnt4,le.lname_placement_cnt4);

 self.reparsed_surname      := if(rule1_for_name1,le.first_name,le.surname);
 self.reparsed_first_name   := if(rule1_for_name1,le.surname,le.first_name);
 self.reparsed_middle_name  := le.middle_name;
 self.reparsed_generation   := le.generation_code;

 self.reparsed_surname2     := if(rule1_for_name2,le.first_name2,le.surname2);
 self.reparsed_first_name2  := if(rule1_for_name2,le.surname2,le.first_name2);
 self.reparsed_middle_name2 := le.middle_name2;
 self.reparsed_generation2  := le.generation_code2;

 self.reparsed_surname3     := if(rule1_for_name3,le.first_name3,le.surname3);
 self.reparsed_first_name3  := if(rule1_for_name3,le.surname3,le.first_name3);
 self.reparsed_middle_name3 := le.middle_name3;
 self.reparsed_generation3  := le.generation_code3;

 self.reparsed_surname4     := if(rule1_for_name4,le.first_name4,le.surname4);
 self.reparsed_first_name4  := if(rule1_for_name4,le.surname4,le.first_name4);
 self.reparsed_middle_name4 := le.middle_name4;
 self.reparsed_generation4  := le.generation_code4;
 
 self.rule1_name1 := rule1_for_name1;
 self.rule1_name2 := rule1_for_name2;
 self.rule1_name3 := rule1_for_name3;
 self.rule1_name4 := rule1_for_name4;
 
 self := le;
end;

p1 := project(j8,x9(left));

boolean rule2_boolean(boolean passed_rule1, decimal6_3 v_lname_as_fname_pct, string v_fname, string v_mname) := function
 
 is_rule2 := passed_rule1=false 
         and v_lname_as_fname_pct>.995
		 and length(trim(v_fname))=1
		 and trim(v_mname)='';
 
 return is_rule2;
end;

r1 x10(p1 le) := transform
 
  rule2_for_name1 := rule2_boolean(le.rule1_name1,le.surname_as_fname ,le.first_name, le.middle_name);
  rule2_for_name2 := rule2_boolean(le.rule1_name2,le.surname2_as_fname,le.first_name2,le.middle_name2);
  rule2_for_name3 := rule2_boolean(le.rule1_name3,le.surname3_as_fname,le.first_name3,le.middle_name3);
  rule2_for_name4 := rule2_boolean(le.rule1_name4,le.surname4_as_fname,le.first_name4,le.middle_name4);
  
  self.reparsed_surname      := if(rule2_for_name1,'',le.reparsed_surname);
  self.reparsed_first_name   := if(rule2_for_name1,le.reparsed_surname,le.reparsed_first_name);
  self.reparsed_middle_name  := if(rule2_for_name1,le.reparsed_first_name,le.reparsed_middle_name);

  self.reparsed_surname2     := if(rule2_for_name2,'',le.reparsed_surname2);
  self.reparsed_first_name2  := if(rule2_for_name2,le.reparsed_surname2,le.reparsed_first_name2);
  self.reparsed_middle_name2 := if(rule2_for_name2,le.reparsed_first_name2,le.reparsed_middle_name2);
  
  self.reparsed_surname3     := if(rule2_for_name3,'',le.reparsed_surname3);
  self.reparsed_first_name3  := if(rule2_for_name3,le.reparsed_surname3,le.reparsed_first_name3);
  self.reparsed_middle_name3 := if(rule2_for_name3,le.reparsed_first_name3,le.reparsed_middle_name3);

  self.reparsed_surname4     := if(rule2_for_name4,'',le.reparsed_surname4);
  self.reparsed_first_name4  := if(rule2_for_name4,le.reparsed_surname4,le.reparsed_first_name4);
  self.reparsed_middle_name4 := if(rule2_for_name4,le.reparsed_first_name4,le.reparsed_middle_name4);
  
  self.rule2_name1 := rule2_for_name1;
  self.rule2_name2 := rule2_for_name2;
  self.rule2_name3 := rule2_for_name3;
  self.rule2_name4 := rule2_for_name4;
  
  self := le;
end;

p2 := project(p1,x10(left));

//problem with using "newer" previous names is that they too could be incorrect (e.g. PIN AAASG0010130015)
boolean rule3_boolean(boolean passed_rule1, boolean passed_rule2, 
                      decimal6_3 current_fname_as_fname_pct,
                      string20 current_fname,   /*string20 current_mname,*/   string20 current_lname,
					  string20 candidate_fname, string20 candidate_mname, string20 candidate_lname
					 ) := function

 is_rule3 := passed_rule1=false and passed_rule2=false and
             candidate_lname=current_lname    and
			 candidate_mname=current_fname    and
			 candidate_fname<>candidate_lname and
			 candidate_fname<>candidate_mname and
			 current_fname_as_fname_pct>.85
			 ;

 return is_rule3;
end;

//routine for catching instances of the first_name appearing in the middle_name field
//this 3rd rule doesn't consider percentages at all - it assumes that the "current" name is correctly parsed
//mname's also have a tendency to appear as a high percentage'd fname
r1 x11(p2 le) := transform
 
  rule3_for_name2 := rule3_boolean(le.rule1_name2, le.rule2_name2, le.first_name_as_fname, le.reparsed_first_name, le.reparsed_surname, le.reparsed_first_name2, le.reparsed_middle_name2, le.reparsed_surname2);
  rule3_for_name3 := rule3_boolean(le.rule1_name3, le.rule2_name3, le.first_name_as_fname, le.reparsed_first_name, le.reparsed_surname, le.reparsed_first_name3, le.reparsed_middle_name3, le.reparsed_surname3);
  rule3_for_name4 := rule3_boolean(le.rule1_name4, le.rule2_name4, le.first_name_as_fname, le.reparsed_first_name, le.reparsed_surname, le.reparsed_first_name4, le.reparsed_middle_name4, le.reparsed_surname4);
					 
  self.reparsed_first_name2  := if(rule3_for_name2,le.reparsed_middle_name2,le.reparsed_first_name2);
  self.reparsed_middle_name2 := if(rule3_for_name2,le.reparsed_first_name2,le.reparsed_middle_name2);
  					 
  self.reparsed_first_name3  := if(rule3_for_name3,le.reparsed_middle_name3,le.reparsed_first_name3);
  self.reparsed_middle_name3 := if(rule3_for_name3,le.reparsed_first_name3,le.reparsed_middle_name3);

  self.reparsed_first_name4  := if(rule3_for_name4,le.reparsed_middle_name4,le.reparsed_first_name4);
  self.reparsed_middle_name4 := if(rule3_for_name4,le.reparsed_first_name4,le.reparsed_middle_name4);
    
  self.rule3_name2 := rule3_for_name2;
  self.rule3_name3 := rule3_for_name3;
  self.rule3_name4 := rule3_for_name4;
 
  self := le;
    
end;

p3 := project(p2,x11(left));

rule4_boolean(boolean passed_rule1, boolean passed_rule2, boolean passed_rule3,
             decimal6_3 fname_as_fname_pct,
			 string20 current_fname,   string20 current_mname,   string20 current_lname,
			 string20 candidate_fname, string20 candidate_mname, string20 candidate_lname
			) := function
			 
 boolean is_rule4 := passed_rule1=false and passed_rule2=false and passed_rule3=false
                 and current_fname = candidate_lname 
				 and current_mname = candidate_fname
				 and current_lname = candidate_mname
				 and length(trim(current_mname))<2
				 and fname_as_fname_pct>.85
				 ;

 return is_rule4;
end;
						
r1 x12(p3 le) := transform
 
 boolean rule4_for_name2 := rule4_boolean(le.rule1_name2, le.rule2_name2, le.rule3_name2,
                                          le.first_name_as_fname,
										  le.first_name, le.middle_name, le.surname,
										  le.first_name2,le.middle_name2,le.surname2
										 );

 boolean rule4_for_name3 := rule4_boolean(le.rule1_name3, le.rule2_name3, le.rule3_name3,
                                          le.first_name_as_fname,
										  le.first_name, le.middle_name, le.surname,
										  le.first_name3,le.middle_name3,le.surname3
										 );

 boolean rule4_for_name4 := rule4_boolean(le.rule1_name4, le.rule2_name4, le.rule3_name4,
                                          le.first_name_as_fname,
										  le.first_name, le.middle_name, le.surname,
										  le.first_name4,le.middle_name4,le.surname4
										 );

 self.reparsed_first_name2  := if(rule4_for_name2,le.reparsed_surname2,    le.reparsed_first_name2);
 self.reparsed_middle_name2 := if(rule4_for_name2,le.reparsed_first_name2, le.reparsed_middle_name2);
 self.reparsed_surname2     := if(rule4_for_name2,le.reparsed_middle_name2,le.reparsed_surname2);

 self.reparsed_first_name3  := if(rule4_for_name3,le.reparsed_surname3,    le.reparsed_first_name3);
 self.reparsed_middle_name3 := if(rule4_for_name3,le.reparsed_first_name3, le.reparsed_middle_name3);
 self.reparsed_surname3     := if(rule4_for_name3,le.reparsed_middle_name3,le.reparsed_surname3);

 self.reparsed_first_name4  := if(rule4_for_name4,le.reparsed_surname4,    le.reparsed_first_name4);
 self.reparsed_middle_name4 := if(rule4_for_name4,le.reparsed_first_name4, le.reparsed_middle_name4);
 self.reparsed_surname4     := if(rule4_for_name4,le.reparsed_middle_name4,le.reparsed_surname4);
 
 self.rule4_name2 := rule4_for_name2;
 self.rule4_name3 := rule4_for_name3;
 self.rule4_name4 := rule4_for_name4;
 
 self := le;
end;

p4 := project(p3,x12(left));

rule5_boolean(boolean passed_rule1, boolean passed_rule2, boolean passed_rule3, boolean passed_rule4,
              decimal6_3 candidate_fname_as_fname_pct, decimal6_3 candidate_lname_as_fname_pct,
			  string20   current_fname,   string20 current_mname,   string20 current_lname,
			  string20   candidate_fname, string20 candidate_mname, string20 candidate_lname
			 ) := function

 boolean is_rule5 := passed_rule1=false and passed_rule2=false and passed_rule3=false and passed_rule4=false
                 and candidate_fname_as_fname_pct<=.005 and candidate_lname_as_fname_pct>=.25
				 and current_lname=candidate_fname
				 and current_fname=candidate_lname
				 and current_mname[1]=candidate_mname[1]
				 ;

 return is_rule5;
end;

//rule 5 stems from neither first or last name looking like a first_name in the insurance file
//specifically resolves cases like last_name=LINDSTROM and first_name=MATHIAS
r1 x13(p4 le) := transform
 
 boolean rule5_for_name2 := rule5_boolean(le.rule1_name2,le.rule2_name2, le.rule3_name2, le.rule4_name2,
                                          le.first_name2_as_fname,le.surname2_as_fname,
										  le.first_name, le.middle_name,  le.surname,
										  le.first_name2,le.middle_name2, le.surname2
										 );
										 
 boolean rule5_for_name3 := rule5_boolean(le.rule1_name3,le.rule2_name3, le.rule3_name3, le.rule4_name3,
                                          le.first_name3_as_fname,le.surname3_as_fname,
										  le.first_name, le.middle_name,  le.surname,
										  le.first_name3,le.middle_name3, le.surname3
										 );

 boolean rule5_for_name4 := rule5_boolean(le.rule1_name4,le.rule2_name4, le.rule3_name4, le.rule4_name4,
                                          le.first_name4_as_fname,le.surname4_as_fname,
										  le.first_name, le.middle_name,  le.surname,
										  le.first_name4,le.middle_name4, le.surname4
										 );

 self.reparsed_first_name2  := if(rule5_for_name2,le.reparsed_surname2,   le.reparsed_first_name2);
 self.reparsed_surname2     := if(rule5_for_name2,le.reparsed_first_name2,le.reparsed_surname2);

 self.reparsed_first_name3  := if(rule5_for_name3,le.reparsed_surname3,   le.reparsed_first_name3);
 self.reparsed_surname3     := if(rule5_for_name3,le.reparsed_first_name3,le.reparsed_surname3);

 self.reparsed_first_name4  := if(rule5_for_name4,le.reparsed_surname4,   le.reparsed_first_name4);
 self.reparsed_surname4     := if(rule5_for_name4,le.reparsed_first_name4,le.reparsed_surname4);
 
 self.rule5_name2 := rule5_for_name2;
 self.rule5_name3 := rule5_for_name3;
 self.rule5_name4 := rule5_for_name4;
 
 self := le;
end;

p5 := project(p4,x13(left));

rule6_boolean(boolean passed_rule1, boolean passed_rule2, boolean passed_rule3, boolean passed_rule4, boolean passed_rule5,
              decimal6_3 candidate_fname_as_fname_pct,
			  string20 candidate_lname, string5 candidate_name_suffix
			 ) := function

 boolean is_rule6 := passed_rule1=false and passed_rule2=false and passed_rule3=false and passed_rule4=false and passed_rule5=false and
                     candidate_lname=candidate_name_suffix                      and
					 candidate_lname in ['2','3','4','II','III','JR','SR','IV'] and
					 candidate_fname_as_fname_pct>=.50;

 return is_rule6;
end;

r1 x14(p5 le) := transform
 
 //a stat shows that Name1 doesn't have this problem
 //therefore let's use Name1 (the surname1) as a point of reference
										 
 boolean rule6_for_name2 := rule6_boolean(le.rule1_name2,le.rule2_name2, le.rule3_name2, le.rule4_name2, le.rule5_name2,
                                          le.first_name2_as_fname,
										  if(le.surname2 in ['2','JR'],'II',if(le.surname2='3','III',le.surname2)),if(le.generation_code2 in ['J','2'],'II',if(le.generation_code2='3','III',le.generation_code2))
										 );
										 
 boolean rule6_for_name3 := rule6_boolean(le.rule1_name3,le.rule2_name3, le.rule3_name3, le.rule4_name3, le.rule5_name3,
                                          le.first_name3_as_fname,
										  if(le.surname3 in ['2','JR'],'II',if(le.surname3='3','III',le.surname3)),if(le.generation_code3 in ['J','2'],'II',if(le.generation_code3='3','III',le.generation_code3))
										 );

 boolean rule6_for_name4 := rule6_boolean(le.rule1_name4,le.rule2_name4, le.rule3_name4, le.rule4_name4, le.rule5_name4,
                                          le.first_name4_as_fname,
										  if(le.surname4 in ['2','JR'],'II',if(le.surname4='3','III',le.surname4)),if(le.generation_code4 in ['J','2'],'II',if(le.generation_code4='3','III',le.generation_code4))
										 );

 self.reparsed_middle_name2  := if(rule6_for_name2,
                                 if(length(trim(le.middle_name2))>1 and le.middle_name2=le.reparsed_surname,'',le.reparsed_middle_name2),
								le.reparsed_middle_name2);
 self.reparsed_surname2      := if(rule6_for_name2,
                                 if(length(trim(le.middle_name2))>1 and le.middle_name2=le.reparsed_surname,le.reparsed_middle_name2,''),
								le.reparsed_surname2);

 self.reparsed_middle_name3  := if(rule6_for_name3,
                                 if(length(trim(le.middle_name3))>1 and le.middle_name3=le.reparsed_surname,'',le.reparsed_middle_name3),
								le.reparsed_middle_name3);
 self.reparsed_surname3      := if(rule6_for_name3,
                                 if(length(trim(le.middle_name3))>1 and le.middle_name3=le.reparsed_surname,le.reparsed_middle_name3,''),
								le.reparsed_surname3);

 self.reparsed_middle_name4  := if(rule6_for_name4,
                                 if(length(trim(le.middle_name4))>1 and le.middle_name4=le.reparsed_surname,'',le.reparsed_middle_name4),
								le.reparsed_middle_name4);
 self.reparsed_surname4      := if(rule6_for_name4,
                                 if(length(trim(le.middle_name4))>1 and le.middle_name4=le.reparsed_surname,le.reparsed_middle_name4,''),
								le.reparsed_surname4);
								 
 self.rule6_name2 := rule6_for_name2;
 self.rule6_name3 := rule6_for_name3;
 self.rule6_name4 := rule6_for_name4;
 
 self := le;
end;

p6 := project(p5,x14(left));

return p6;

end;