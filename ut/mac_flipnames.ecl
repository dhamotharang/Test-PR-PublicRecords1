import idl_header;

export mac_flipnames(file_in,fname_field,mname_field,lname_field,file_out) := MACRO

IMPORT idl_header;

#uniquename(input)
#uniquename(idl_name)
#uniquename(layout_score)
#uniquename(layout_flags)
#uniquename(layout_out)
#uniquename(layout_table)
#uniquename(t_get_lname_as_fname_pct)
#uniquename(t_get_fname_as_fname_pct)
#uniquename(t_set_flag1)
#uniquename(t_set_flag2)
#uniquename(j_get_lname_as_fname_pct)
#uniquename(j_get_fname_as_fname_pct)
#uniquename(p_set_flag1)
#uniquename(p_set_flag2)
#uniquename(p_file_out)
#uniquename(rule1_boolean)
#uniquename(rule2_boolean)
#uniquename(tab1)
%input%    := file_in;
%idl_name% := idl_header.name_count_ds(length(trim(name))>1);//filter initials

%layout_score% := record
 %input%;
 decimal6_3 lname_as_fname     :=0;
 decimal6_3 fname_as_fname     :=0;
 integer    lname_as_fname_cnt :=0;
 integer    fname_as_fname_cnt :=0;
 integer    lname_placement_cnt:=0;
 integer    fname_placement_cnt:=0;
end;

%layout_score% %t_get_lname_as_fname_pct%(%input% le, %idl_name% ri) := transform
 self.lname_as_fname     := ri.pct_fname;
 self.lname_as_fname_cnt := ri.fname_cnt;
 self.lname_placement_cnt:= ri.placement_cnt;
 self                    := le;
end;

%j_get_lname_as_fname_pct%:= join(%input%,%idl_name%,left.lname_field=right.name,%t_get_lname_as_fname_pct%(left,right),lookup,left outer);

%layout_score% %t_get_fname_as_fname_pct%(%j_get_lname_as_fname_pct% le, %idl_name% ri) := transform
 self.fname_as_fname     := ri.pct_fname;
 self.fname_as_fname_cnt := ri.fname_cnt;
 self.fname_placement_cnt:= ri.placement_cnt;
 self                    := le;
end;

%j_get_fname_as_fname_pct% := join(%j_get_lname_as_fname_pct%,%idl_name%,left.fname_field=right.name,%t_get_fname_as_fname_pct%(left,right),lookup,left outer);

%layout_flags% := record
 %j_get_fname_as_fname_pct%;
 boolean rule1_name1;
 boolean rule2_name1:=false;

end;

//bring in the counts of the names so that rare names are excluded
boolean %rule1_boolean%(decimal6_3 v_lname_as_fname_pct, decimal6_3 v_fname_as_fname_pct, string v_fn, string v_mn, string v_ln, integer v_lname_as_fname_cnt, integer v_fname_as_fname_cnt, integer v_fname_placement_cnt, integer v_lname_placement_cnt) := function
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

%layout_flags% %t_set_flag1%(%j_get_fname_as_fname_pct% le) := transform

 //middle_name condition is so i don't flip records where possibly the first_name and middle_name are flipped
 boolean rule1_for_name1 := %rule1_boolean%(le.lname_as_fname, le.fname_as_fname,le.fname_field,le.mname_field,le.lname_field,le.lname_as_fname_cnt,le.fname_as_fname_cnt,le.fname_placement_cnt,le.lname_placement_cnt);

 self.lname_field := if(rule1_for_name1,le.fname_field,le.lname_field);
 self.fname_field := if(rule1_for_name1,le.lname_field,le.fname_field);
 self.mname_field := le.mname_field;

 self.rule1_name1 := rule1_for_name1;

 self := le;
end;

%p_set_flag1% := project(%j_get_fname_as_fname_pct%,%t_set_flag1%(left));

//output(count(%p_set_flag1%(rule1_name1=true)),named('rule1_count'));
//output(choosen(%p_set_flag1%(rule1_name1=true),5000),named('rule1_sample'));

//this is intended to resolve
//last_name=JASON
//first_name=E
//middle_name=<empty>
boolean %rule2_boolean%(boolean passed_rule1, decimal6_3 v_lname_as_fname_pct, string v_fname, string v_mname) := function

 is_rule2 := passed_rule1=false
         and v_lname_as_fname_pct>.995
		 and length(trim(v_fname))=1
		 and trim(v_mname)='';

 return is_rule2;
end;



%layout_flags% %t_set_flag2%(%p_set_flag1% le) := transform

  rule2_for_name1 := %rule2_boolean%(le.rule1_name1,le.lname_as_fname,le.fname_field,le.mname_field);

  self.lname_field := if(rule2_for_name1,'',le.lname_field);
  self.fname_field := if(rule2_for_name1,le.lname_field,le.fname_field);
  self.mname_field := if(rule2_for_name1,le.fname_field,le.mname_field);

  self.rule2_name1 := rule2_for_name1;
  self := le;
end;

%p_set_flag2% := project(%p_set_flag1%,%t_set_flag2%(left));

//output(count(%p_set_flag2%(rule2_name1=true)),named('rule2_count'));
//output(choosen(%p_set_flag2%(rule2_name1=true),5000),named('rule2_sample'));

%p_file_out% := project(%p_set_flag2%,recordof(%input%));

//%layout_table% := record
// %p_file_out%.src;
// count_ := count(group);
//end;

//%tab1% := sort(table(%p_file_out%,%layout_table%,src,few),-count_);
//output(%tab1%,all);

file_out := %p_file_out%;

endmacro;
