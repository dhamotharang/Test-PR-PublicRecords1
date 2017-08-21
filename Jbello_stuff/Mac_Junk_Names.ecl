import idl_header,ut;
export Mac_Junk_Names(hdr,oHdr,sffx) := macro

#uniquename(vowels2)
%vowels2%    := 'AEIOUY';
#uniquename(numbers2)
%numbers2%   := '1234567890';

#uniquename(fn_remove_chars)
%fn_remove_chars%(string in_value) := function

 string out_value := stringlib.stringfilterout(in_value,%vowels2%+%numbers2%);

 return out_value;
 
end;

#uniquename(exceptions_)
%exceptions_% := ['CMSGT'];


#uniquename(bad_name_candidate)
#uniquename(bad_name_compare_to)
#uniquename(r1)
%r1% := record
 hdr;
 string20 %bad_name_candidate%;
 string20 %bad_name_compare_to%;
end;

#uniquename(t1a)
%r1% %t1a%(hdr le) := transform
 
 boolean v1 := length(trim(le.fname))>2 and length(trim(le.fname))=length(trim(%fn_remove_chars%(le.fname)));
 
 self.%bad_name_candidate%  := if(v1=true,le.fname,'');
 self.%bad_name_compare_to% := if(v1=false,%fn_remove_chars%(le.fname),''); 
 self                     := le;
end;

#uniquename(t1b)
%r1% %t1b%(hdr le) := transform
 
 boolean v1 := length(trim(le.lname))=length(trim(%fn_remove_chars%(le.lname)));
 
 self.%bad_name_candidate%  := if(v1=true,le.lname,'');
 self.%bad_name_compare_to% := if(v1=false,%fn_remove_chars%(le.lname),'');
 self                     := le;
end;

#uniquename(p1a)
%p1a%    := project(hdr,%t1a%(left));
#uniquename(p1b)
%p1b%    := project(hdr,%t1b%(left));
#uniquename(concat)
%concat% := %p1a%+%p1b%;

#uniquename(r2a)
%r2a% := record
 %concat%.%bad_name_candidate%;
 count_bad_name_candidate := count(group);
end;

#uniquename(r2b)
%r2b% := record
 %concat%.%bad_name_compare_to%;
 count_bad_name_compare_to := count(group);
end;

#uniquename(ta1a)
%ta1a% := table(%concat%(%bad_name_candidate%<>''), %r2a%,%bad_name_candidate%, few);
#uniquename(ta1b)
%ta1b% := table(%concat%(%bad_name_compare_to%<>''),%r2b%,%bad_name_compare_to%,few);

//some of the potentially good names, good deemed by having a vowel(s), are false positives
//apply some logic to say that we need to see it "enough" times for it to be valid
#uniquename(ta1_f)
%ta1_f%  := %ta1b%(count_bad_name_compare_to>=5);

//then filter these false positives?
#uniquename(t1b_fp)
%t1b_fp% := %ta1b%(count_bad_name_compare_to<5);

#uniquename(t5)
%r1% %t5%(%concat% le, %t1b_fp% ri) := transform
 self := le;
end;

#uniquename(j2)
%j2% := join(%concat%,%t1b_fp%,left.%bad_name_compare_to%=right.%bad_name_compare_to%,%t5%(left,right),lookup);

#uniquename(r3)
%r3% := record
 string20 bad_name_candidate;
end;

#uniquename(t6)
%r3% %t6%(%j2% le) := transform
 self.bad_name_candidate := if(%fn_remove_chars%(le.fname)=le.%bad_name_compare_to%,%fn_remove_chars%(le.fname),
                            if(%fn_remove_chars%(le.lname)=le.%bad_name_compare_to%,%fn_remove_chars%(le.lname),
       ''));
 self := le;
end;

#uniquename(p2)
%p2% := project(%j2%,%t6%(left));

#uniquename(t2)
%r3% %t2%(%r2a% le, %r2b% ri) := transform
 self.bad_name_candidate := le.%bad_name_candidate%;
 self := le;
end;

#uniquename(j1)
%j1% := join(%ta1a%,%ta1_f%,left.%bad_name_candidate%=right.%bad_name_compare_to%,%t2%(left,right),left only);

#uniquename(set_of_bad_names0)
%set_of_bad_names0% := dedup(%j1%+%p2%,record,all);
#uniquename(set_of_bad_names)
%set_of_bad_names%  := %set_of_bad_names0%(trim(bad_name_candidate) not in %exceptions_%);

#uniquename(r4)
#uniquename(bad_fname)
#uniquename(bad_lname)
%r4% := record
 hdr;
 boolean %bad_fname%:=false;
 boolean %bad_lname%:=false;
end;

#uniquename(is_junky)
%is_junky%(string in_name) := function

 name_exception_set := ['II','III','IIII'];

 is_true := length(trim(stringlib.stringfilterout(in_name,' ')))>ut.fn_count_unique_characters_in_a_string(in_name)*4
            or
		    (length(trim(stringlib.stringfilterout(in_name,' ')))>2 and ut.fn_count_unique_characters_in_a_string(in_name)=1 and in_name not in name_exception_set);
 return is_true;
end;



#uniquename(t3)
%r4% %t3%(hdr le, %set_of_bad_names% ri) := transform
 self.%bad_fname% := if(le.fname=ri.bad_name_candidate or %is_junky%(le.fname)=true,true,false);
 self           := le;
end;

#uniquename(j3)
%j3% := join(hdr,%set_of_bad_names%,left.fname=right.bad_name_candidate,%t3%(left,right),left outer,lookup);

#uniquename(t4)
%r4% %t4%(%j3% le, %set_of_bad_names% ri) := transform 
 self.%bad_lname% := if(le.lname=ri.bad_name_candidate or (%is_junky%(le.lname)=true),true,false);
 self           := le;
end;

#uniquename(j4)
%j4%      := join(%j3%,%set_of_bad_names%,left.lname=right.bad_name_candidate,%t4%(left,right),left outer,lookup);
#uniquename(j4_dist)
%j4_dist% := distribute(%j4%,hash(did));

#uniquename(adl_segmentation)
%adl_segmentation% := header.fn_adlsegmentation(header.file_headers).core_check_pst;

#uniquename(r5)
#uniquename(did_ct)
%r5% := record
 %j4_dist%;
 %adl_segmentation%.ind;
 integer %did_ct%:=0;
end;

//with fn_junk_names current placement in header_joined it is possible that new DID are in here
//DID's that don't get ANY segmentation we can conclude are new and therefore should not consider removing
#uniquename(t7)
%r5% %t7%(%j4_dist% le, %adl_segmentation% ri) := transform
 self := le;
 self := ri;
end;

#uniquename(j5)
%j5% := join(%j4_dist%,%adl_segmentation%,left.did=right.did,%t7%(left,right),left outer,local);

#uniquename(rec_counts_per_did)
%rec_counts_per_did% := header.counts_per_did(header.file_headers);

#uniquename(t8)
%r5% %t8%(%j5% le, %rec_counts_per_did% ri) := transform
 self.%did_ct% := ri.did_ct;
 self        := le;
end;

#uniquename(j6)
%j6% := join(%j5%,%rec_counts_per_did%,left.did=right.did,%t8%(left,right),keep(1),left outer,local);

#uniquename(idl_name)
%idl_name% := idl_header.name_count_ds(fname_cnt>50 and length(trim(name))>1);//filter initials

#uniquename(r6)
%r6% := record
 %j6%;
 %idl_name%.pct_fname;
end;

#uniquename(t9)
%r6% %t9%(%j6% le, %idl_name% ri) := transform
 self := le;
 self := ri;
end;

#uniquename(j7)
%j7% := join(%j6%,%idl_name%,left.fname=right.name,%t9%(left,right),lookup,left outer);

#uniquename(these_are_bad)
%these_are_bad% := %j7%(
                    ( %bad_fname%=true and %bad_lname%=true)
				 or ((%bad_fname%=true or  %bad_lname%=true) and ssn='')
                 or ((%bad_fname%=true or  %bad_lname%=true) and %did_ct%=1 and ind in ['NOISE','H_MERGE'] and  dob=0 and pct_fname<.5)
				 );

#uniquename(these_are_good)
%these_are_good% := %j7%(~(
                    ( %bad_fname%=true and %bad_lname%=true)
				 or ((%bad_fname%=true or  %bad_lname%=true) and ssn='')
                 or ((%bad_fname%=true or  %bad_lname%=true) and %did_ct%=1 and ind in ['NOISE','H_MERGE'] and  dob=0 and pct_fname<.5)
				 ));				 

output(choosen(%these_are_bad%,5000),named('records_dropped_in_fn_junk_names_'+sffx));

#uniquename(prj_to_orig)
%prj_to_orig% := project(%these_are_good%,recordof(hdr));

oHdr := %prj_to_orig%;

endmacro;