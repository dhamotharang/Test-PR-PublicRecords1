import idl_header,ut;

consonants2:= 'BCDFGHJKLMNPQRSTVWXZ';
vowels2    := 'AEIOUY';
numbers2   := '1234567890';

fn_remove_chars(string in_value) := function

 string out_value := stringlib.stringfilterout(in_value,vowels2+numbers2);

 return out_value;
 
end;

exceptions_ := ['CMSGT'];

export fn_junk_names(dataset(recordof(header.layout_header)) hdr) := function

r1 := record
 hdr;
 string20 bad_name_candidate;
 string20 bad_name_compare_to;
end;

r1 t1a(hdr le) := transform
 
 boolean v1 := length(trim(le.fname))>2 and length(trim(le.fname))=length(trim(fn_remove_chars(le.fname)));
 
 self.bad_name_candidate  := if(v1=true,le.fname,'');
 self.bad_name_compare_to := if(v1=false,fn_remove_chars(le.fname),''); 
 self                     := le;
end;

r1 t1b(hdr le) := transform
 
 boolean v1 := length(trim(le.lname))=length(trim(fn_remove_chars(le.lname)));
 
 self.bad_name_candidate  := if(v1=true,le.lname,'');
 self.bad_name_compare_to := if(v1=false,fn_remove_chars(le.lname),'');
 self                     := le;
end;

p1a    := project(hdr,t1a(left));
p1b    := project(hdr,t1b(left));
concat := p1a+p1b;

r2a := record
 concat.bad_name_candidate;
 count_bad_name_candidate := count(group);
end;

r2b := record
 concat.bad_name_compare_to;
 count_bad_name_compare_to := count(group);
end;

ta1a := table(concat(bad_name_candidate<>''), r2a,bad_name_candidate, few);
ta1b := table(concat(bad_name_compare_to<>''),r2b,bad_name_compare_to,few);

//some of the potentially good names, good deemed by having a vowel(s), are false positives
//apply some logic to say that we need to see it "enough" times for it to be valid
ta1_f  := ta1b(count_bad_name_compare_to>=5);

//then filter these false positives?
t1b_fp := ta1b(count_bad_name_compare_to<5);

r1 t5(concat le, t1b_fp ri) := transform
 self := le;
end;

j2 := join(concat,t1b_fp,left.bad_name_compare_to=right.bad_name_compare_to,t5(left,right),lookup);

r3 := record
 string20 bad_name_candidate;
end;

r3 t6(j2 le) := transform
 self.bad_name_candidate := if(fn_remove_chars(le.fname)=le.bad_name_compare_to,fn_remove_chars(le.fname),
                            if(fn_remove_chars(le.lname)=le.bad_name_compare_to,fn_remove_chars(le.lname),
       ''));
 self := le;
end;

p2 := project(j2,t6(left));

r3 t2(r2a le, r2b ri) := transform
 self := le;
end;

j1 := join(ta1a,ta1_f,left.bad_name_candidate=right.bad_name_compare_to,t2(left,right),left only);

set_of_bad_names0 := dedup(j1+p2,record,all);
set_of_bad_names  := set_of_bad_names0(trim(bad_name_candidate) not in exceptions_);

r4 := record
 hdr;
 boolean bad_fname:=false;
 boolean bad_lname:=false;
end;

is_junky(string in_name) := function

 name_exception_set := ['II','III','IIII'];

 is_true := length(trim(stringlib.stringfilterout(in_name,' ')))>ut.fn_count_unique_characters_in_a_string(in_name)*4
            or
		    (length(trim(stringlib.stringfilterout(in_name,' ')))>2 and ut.fn_count_unique_characters_in_a_string(in_name)=1 and in_name not in name_exception_set);
 return is_true;
end;



r4 t3(hdr le, set_of_bad_names ri) := transform
 self.bad_fname := if(le.fname=ri.bad_name_candidate or is_junky(le.fname)=true,true,false);
 self           := le;
end;

j3 := join(hdr,set_of_bad_names,left.fname=right.bad_name_candidate,t3(left,right),left outer,lookup);

r4 t4(j3 le, set_of_bad_names ri) := transform 
 self.bad_lname := if(le.lname=ri.bad_name_candidate or (is_junky(le.lname)=true),true,false);
 self           := le;
end;

j4      := join(j3,set_of_bad_names,left.lname=right.bad_name_candidate,t4(left,right),left outer,lookup);
j4_dist := distribute(j4,hash(did));

adl_segmentation := Header.fn_ADLSegmentation_v2(header.file_headers).core_check;

r5 := record
 j4_dist;
 adl_segmentation.ind;
 integer did_ct:=0;
end;

//with fn_junk_names current placement in header_joined it is possible that new DID are in here
//DID's that don't get ANY segmentation we can conclude are new and therefore should not consider removing
r5 t7(j4_dist le, adl_segmentation ri) := transform
 self := le;
 self := ri;
end;

j5 := join(j4_dist,adl_segmentation,left.did=right.did,t7(left,right),left outer,local);

rec_counts_per_did := header.counts_per_did(header.file_headers);

r5 t8(j5 le, rec_counts_per_did ri) := transform
 self.did_ct := ri.did_ct;
 self        := le;
end;

j6 := join(j5,rec_counts_per_did,left.did=right.did,t8(left,right),keep(1),left outer,local);

idl_name := idl_header.name_count_ds(fname_cnt>50 and length(trim(name))>1);//filter initials

r6 := record
 j6;
 idl_name.pct_fname;
end;

r6 t9(j6 le, idl_name ri) := transform
 self := le;
 self := ri;
end;

j7 := join(j6,idl_name,left.fname=right.name,t9(left,right),lookup,left outer);
 
these_are_bad := j7(
                    ( bad_fname=true and bad_lname=true)
				 or ((bad_fname=true or  bad_lname=true) and ssn='')
                 or ((bad_fname=true or  bad_lname=true) and did_ct=1 and ind in ['NOISE','H_MERGE'] and  dob=0 and pct_fname<.5)
				 );

these_are_good := j7(~(
                    ( bad_fname=true and bad_lname=true)
				 or ((bad_fname=true or  bad_lname=true) and ssn='')
                 or ((bad_fname=true or  bad_lname=true) and did_ct=1 and ind in ['NOISE','H_MERGE'] and  dob=0 and pct_fname<.5)
				 ));				 


prj_to_orig := project(these_are_good,recordof(hdr));

return prj_to_orig;

end;