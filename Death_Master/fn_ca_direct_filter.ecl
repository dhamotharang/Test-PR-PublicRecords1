import header,mdr;

//CA Direct has a lot of bad SSN's
//compare name+SSN pairs to the Header
//to keep a record the following must be met:
//1) we filter minors from the Header. if a name+SSN in deaths is not in the Header
//   it's intentionally removed.  keep all minor death records.
//-OR-
//2) calculated valid_ssn (below) is grouped within name+SSN pair -> if any record
//   says it's valid, keep the record
//-OR-
//3) if the SSN is only found within a Death record (irregardless of name) keep it
//   even if it's not flagged as a good SSN
export fn_ca_direct_filter(dataset(recordof(header.layout_death_master_plus)) in_file) := function

work_with_these := in_file  (state='CA' and fname<>'' and lname<>'' and length(trim(ssn))=9 and state_death_id<>death_master.fn_fake_state_death_id(ssn,lname,dod8));
ignore_these    := in_file(~(state='CA' and fname<>'' and lname<>'' and length(trim(ssn))=9 and state_death_id<>death_master.fn_fake_state_death_id(ssn,lname,dod8)));

ds  := distribute(work_with_these,hash(ssn,fname[1],lname[1..5]));

hdr0 := header.File_Headers(length(trim(ssn,left,right))=9);
hdr  := project(hdr0,header.Layout_Header_Strings);

r1 := record
 string1 fname_init;
 //trying to account for last_name mis-spellings on long last names
 string5 lname_1st_5;
 hdr.ssn;
 boolean name_ssn_in_death_header;
 boolean name_ssn_in_other_header;
 boolean valid_ssn;
 boolean ssn_in_death_header_only:=false
end;

r1 t1(hdr le) := transform
 self.fname_init               := le.fname[1];
 self.lname_1st_5              := le.lname[1..5];
 self.name_ssn_in_death_header :=    mdr.sourceTools.sourceisdeath(le.src);
 self.name_ssn_in_other_header := (~(mdr.sourceTools.sourceisdeath(le.src)));
 self.valid_ssn                := le.valid_ssn in ['G','O'];
 self                          := le;
end;

p1      := project   (hdr,t1(left));
p1_dist := distribute(p1,hash(ssn,fname_init,lname_1st_5));
p1_sort := sort      (p1_dist,ssn,fname_init,lname_1st_5,local);

r1 t2(p1_sort le, p1_sort ri) := transform
 self.name_ssn_in_death_header := if(le.name_ssn_in_death_header=true,true,ri.name_ssn_in_death_header);
 self.name_ssn_in_other_header := if(le.name_ssn_in_other_header=true,true,ri.name_ssn_in_other_header);
 self.valid_ssn                := if(le.valid_ssn=true,true,ri.valid_ssn);
 self                          := le;
end;

p2 := rollup(p1_sort,left.ssn=right.ssn and left.fname_init=right.fname_init and left.lname_1st_5=right.lname_1st_5,t2(left,right),local);

p2_ssn_sort := sort(distribute(p2,hash(ssn)),ssn,local);

r2 := record
 p2_ssn_sort.ssn;
 p2_ssn_sort.name_ssn_in_death_header;
 p2_ssn_sort.name_ssn_in_other_header;
end;

ta1      := table(p2_ssn_sort,r2);
ta1_sort := sort(distribute(ta1,hash(ssn)),ssn,local);

r2 t3(ta1_sort le, ta1_sort ri) := transform
 self.name_ssn_in_death_header := if(le.name_ssn_in_death_header=true,true,ri.name_ssn_in_death_header);
 self.name_ssn_in_other_header := if(le.name_ssn_in_other_header=true,true,ri.name_ssn_in_other_header);
 self := le;
end;

p3 := rollup(ta1_sort,left.ssn=right.ssn,t3(left,right),local);
//find SSN's only in death sources
p3_filt := p3(name_ssn_in_death_header=true and name_ssn_in_other_header=false);
 
r1 t4(p2 le, p3_filt ri) := transform
 self.ssn_in_death_header_only := if(le.ssn=ri.ssn,true,false);
 self                          := le;
end;

p4      := join(p2_ssn_sort,p3_filt,left.ssn=right.ssn,t4(left,right),left outer,local);
p4_dist := distribute(p4,hash(ssn));

r3 := record
 ds;
 string1 name_ssn_in_death_header:='';
 string1 name_ssn_in_other_header:='';
 string1 ssn_in_death_header_only:='';
 p2.valid_ssn;
end;

r3 t5(ds le, p2 ri) := transform
 self.name_ssn_in_death_header := if(ri.name_ssn_in_death_header=true,'Y','');
 self.name_ssn_in_other_header := if(ri.name_ssn_in_other_header=true,'Y','');
 self.valid_ssn                := ri.valid_ssn;
 self                          := le;
end;

p5 := join(ds,p2,
           left.ssn=right.ssn and left.fname[1]=right.fname_init and left.lname[1..5]=right.lname_1st_5,
		   t5(left,right),
           left outer,
		   local
		  );

p5_dist := distribute(p5,hash(ssn));

r3 t6(p5_dist le, p4_dist ri) := transform
 self.ssn_in_death_header_only := if(ri.ssn_in_death_header_only=true,'Y','');
 self                          := le;
end;

p6 := join(p5_dist,p4,
           left.ssn=right.ssn,
		   t6(left,right),
		   left outer,keep(1),
		   local
		  );



p6_to_keep := p6((trim(name_ssn_in_death_header)='' and trim(name_ssn_in_other_header)='')
              or (ssn_in_death_header_only='Y')
			  or (valid_ssn=true)
			    );

p6_to_drop := p6(~((trim(name_ssn_in_death_header)='' and trim(name_ssn_in_other_header)='')
              or (ssn_in_death_header_only='Y')
			  or (valid_ssn=true)
			    ));


				
r_stat := record
 p6.name_ssn_in_death_header;
 p6.name_ssn_in_other_header;
 p6.ssn_in_death_header_only;
 p6.valid_ssn;
 count_ := count(group);
end;

ta2 := table(p6,r_stat,name_ssn_in_death_header,name_ssn_in_other_header,ssn_in_death_header_only,valid_ssn,few);

project_back := project(p6_to_keep,recordof(in_file));

concat := project_back+ignore_these;

output(count(p6_to_keep),named('p6_to_keep'));
output(choosen(p6_to_keep,200));

output(count(p6_to_drop),named('p6_to_drop'));
output(choosen(p6_to_drop,200));
return concat;

end;