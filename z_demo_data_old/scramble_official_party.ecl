import _control,official_records;

file_in := dataset('~thor::base::demo_data_file_official_party_prodcopy',official_records.Layout_Base_Party,flat);

rs(string sval) := function
sep := if(sval<>'','/','');
return sep;
end;


recordof(file_in) reformat(file_in L):= TRANSFORM

scrambled_lname1	:= if(l.lname1<>'',demo_data_scrambler.fn_scrambleLastName(l.lname1),'');
scrambled_lname2	:= if(l.lname2<>'',demo_data_scrambler.fn_scrambleLastName(l.lname2),'');
scrambled_lname3  := if(l.lname3<>'',demo_data_scrambler.fn_scrambleLastName(l.lname3),'');
scrambled_lname4	:= if(l.lname4<>'',demo_data_scrambler.fn_scrambleLastName(l.lname4),'');
scrambled_lname5	:= if(l.lname5<>'',demo_data_scrambler.fn_scrambleLastName(l.lname5),'');
//
scrambled_pname1	:= trim(l.fname1)+' '+trim(l.mname1)+' '+trim(scrambled_lname1);
scrambled_pname2	:= trim(l.fname2)+' '+trim(l.mname2)+' '+trim(scrambled_lname2);
scrambled_pname3	:= trim(l.fname3)+' '+trim(l.mname3)+' '+trim(scrambled_lname3);
scrambled_pname4	:= trim(l.fname4)+' '+trim(l.mname4)+' '+trim(scrambled_lname4);
scrambled_pname5	:= trim(l.fname5)+' '+trim(l.mname5)+' '+trim(scrambled_lname5);
//
scrambled_cname1 := if(l.cname1<>'',demo_data_scrambler.fn_scrambleBizName(l.cname1),'');
scrambled_cname2 := if(l.cname2<>'',demo_data_scrambler.fn_scrambleBizName(l.cname2),'');
scrambled_cname3 := if(l.cname3<>'',demo_data_scrambler.fn_scrambleBizName(l.cname3),'');
scrambled_cname4 := if(l.cname4<>'',demo_data_scrambler.fn_scrambleBizName(l.cname4),'');
scrambled_cname5 := if(l.cname5<>'',demo_data_scrambler.fn_scrambleBizName(l.cname5),'');
//
self.lname1 := scrambled_lname1;
self.lname2 := scrambled_lname2;
self.lname3 := scrambled_lname3;
self.lname4 := scrambled_lname4;
self.lname5 := scrambled_lname5;
//
self.cname1 := scrambled_cname1;
self.cname2 := scrambled_cname2;
self.cname3 := scrambled_cname3;
self.cname4 := scrambled_cname4;
self.cname5 := scrambled_cname5;
//
self.entity_nm:=trim(trim(scrambled_cname1)+rs(scrambled_cname2)+trim(scrambled_cname2)+rs(scrambled_cname3)+trim(scrambled_cname3)+rs(scrambled_cname4)+trim(scrambled_cname4)+rs(scrambled_cname5)+trim(scrambled_cname5)+
                     trim(scrambled_pname1)+rs(scrambled_pname2)+trim(scrambled_pname2)+rs(scrambled_pname3)+trim(scrambled_pname3)+rs(scrambled_pname4)+trim(scrambled_pname4)+rs(scrambled_pname5)+trim(scrambled_pname5));
//
self.doc_instrument_or_clerk_filing_num := 'X'+stringlib.stringfindreplace(l.doc_instrument_or_clerk_filing_num[2..],'1','2');;
self.doc_filed_dt := fn_scramblepii('DOB',l.doc_filed_dt);
//
self.entity_dob := demo_data_scrambler.fn_scramblePII('DOB',l.entity_dob);
self.entity_ssn := '';
//
self:=l;
END;


export scramble_official_party :=  dedup(sort(project(file_in,reformat(LEFT)),record),all);


