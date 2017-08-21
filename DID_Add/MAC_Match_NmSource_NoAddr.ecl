/*2009-01-07T15:53:00Z (Wendy Ma)
improve the code
*/
import ut;

export Mac_Match_NmSource_NoAddr(infile,outfile,id_field,
					did_field,did_score,low_score_threshold,src_field,
					fname_field,mname_field,lname_field,suffix_field,
					prim_range_field,prim_name_field,sec_range_field,zip_field,ssn_field,dob_field,
					bool_indiv_score='false',score_n_field='score_n') := macro


#uniquename(infile_src)
#uniquename(f_nmsrc)

//restrict the set of records to the file being adl'd
%infile_src% := table(infile, {src},src,few); 
%f_nmsrc%  := join(Header_SlimSort.File_Name_Source, %infile_src%,left.src = right.src, transform(header_slimsort.layout_name_source,
self := left), lookup);

//*********improve infile fields

#uniquename(inf_improved)
DID_Add.Mac_Improve_Infile(infile,src_field,fname_field,mname_field,lname_field,prim_range_field,
prim_name_field, sec_range_field,zip_field,ssn_field,dob_field, %inf_improved%)
	 
#uniquename(inf_improved_dist)		 
#uniquename(nmsrc_dist)		 
#uniquename(t_in_external)		 
	
%inf_improved_dist%  := distribute(%inf_improved%,hash(src_field,fname_field,lname_field));
	                       
%nmsrc_dist% := distribute(%f_nmsrc%(ssn <> ''),hash(src,fname,lname));

//seperate nmsrc file to DIDs possibility 1 and more than 1	name + SSN						   
							   
#uniquename(nmsrc_DID_cnt_only_one)
%nmsrc_DID_cnt_only_one%   := %nmsrc_dist%(dids_with_this_nm_ssn=1);
#uniquename(nmsrc_dive_the_rest)
%nmsrc_dive_the_rest%      := %nmsrc_dist%(~(dids_with_this_nm_ssn=1));
//to append the lowest did
#uniquename(nmsrc_dive_the_rest_sort)
%nmsrc_dive_the_rest_sort% := sort(%nmsrc_dive_the_rest%,src,fname,lname,ssn,did,local);

//if the name_source file has no matching name+ssn we can stop here
//should only be the case for data new to the external file
typeof(%inf_improved_dist%) %t_in_external%(%inf_improved_dist% le, %nmsrc_dist% ri) := transform
 self := le;
end;

#uniquename(inf_external_only)
%inf_external_only% := join(%inf_improved_dist%,%nmsrc_dist%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.ssn_field =right.ssn and left.src_field = right.src,%t_in_external%(left,right),left only,local);

#uniquename(inf_nmsrc_need)		 

%inf_nmsrc_need%            := join(%inf_improved_dist%,%nmsrc_dist%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.ssn_field =right.ssn and left.src_field = right.src,%t_in_external%(left,right),keep(1),local);

#uniquename(r_nmSSN)

%r_nmSSN% := record
 %inf_nmsrc_need%;
 unsigned6 nm_ssn_DID;
 integer   nm_ssn_score;
end;

//if a DID gets assigned here we don't have to look any further
//this is saying there is only 1 possibility on name + SSN 
#uniquename(t_nmSSN)
%r_nmSSN% %t_nmSSN%(%inf_nmsrc_need% le, %nmsrc_DID_cnt_only_one% ri) := transform
 self.nm_ssn_DID      := ri.DID;
 self.nm_ssn_score := if(self.nm_ssn_DID>0,100,0);
 self                   := le;

end;

#uniquename(add_nmSSN)
%add_nmSSN% := join(%inf_nmsrc_need%,%nmsrc_DID_cnt_only_one%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.ssn_field =right.ssn and left.src_field = right.src,%t_nmSSN%(left,right),left outer,keep(1),local);

#uniquename(no_need_to_look_further)
%no_need_to_look_further% := %add_nmSSN%(nm_ssn_DID >0);
#uniquename(continue_looking)
%continue_looking%        := %add_nmSSN%(nm_ssn_DID =0);

//continue assigning DID from source matching			   
//Add DOB score and DID
				
#uniquename(r_nmDOB)
%r_nmDOB% := record
 %continue_looking%;
 unsigned6 dob_did;
 integer   dob_score;
end;

#uniquename(t_nmDOB)
%r_nmDOB% %t_nmDOB%(%continue_looking% le, %nmsrc_dive_the_rest_sort% ri) := transform
 self.dob_did   := ri.did;
 self.dob_score := if(le.dob_field = ri.dob and le.dob_field >0,100,
                   if(le.dob_field =0 and ri.dob_cnt_with_this_nm_ssn<2,50,
				   0));
 self           := le;
				   
end;

#uniquename(add_nmDOB)
%add_nmDOB% := join(%continue_looking%,%nmsrc_dive_the_rest_sort%,
                left.fname_field =right.fname and left.lname_field =right.lname and  
                left.ssn_field =right.ssn and left.src_field = right.src
                and ((left.dob_field = right.dob and left.dob_field >0) or (left.dob_field =0 and right.dob_cnt_with_this_nm_ssn<2))
				,%t_nmDOB%(left,right),left outer, keep(1));

//determine nmsrc DID from SSN and DOB DID
#uniquename(r_nmsrc_final)
%r_nmsrc_final% := record
 %add_nmDOB%;
 unsigned6 nmsrc_did;
end;

#uniquename(t_determine_nmsrc_did)
%r_nmsrc_final% %t_determine_nmsrc_did%(%add_nmDOB% le) := transform

 self.nmsrc_did := if(le.dob_score > 0 ,le.dob_did, 0);
 self := le;
end;

#uniquename(p_nmsrc_final_hasSSN)
%p_nmsrc_final_hasSSN% := project(%add_nmDOB%,%t_determine_nmsrc_did%(left));

//Add all results from the records have SSN back to outfile
#uniquename(t_final2a)
typeof(infile) %t_final2a%(%no_need_to_look_further% le) := transform
 self.did_score   := if(le.nm_ssn_did = 0, le.did_score, 100);
 self.did_field   := if(le.nm_ssn_did = 0, le.did_field, le.nm_ssn_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nm_ssn_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.nm_ssn_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

#uniquename(t_final2b)
typeof(infile) %t_final2b%(%p_nmsrc_final_hasSSN% le) := transform
 self.did_score   := if(le.nmsrc_did = 0, le.did_score, 100);
 self.did_field   := if(le.nmsrc_did = 0, le.did_field, le.nmsrc_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nmsrc_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.nmsrc_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

#uniquename(p_final_a)
%p_final_a% := project(%no_need_to_look_further%,%t_final2a%(left));
#uniquename(p_final_b)
%p_final_b% := project(%p_nmsrc_final_hasSSN%,%t_final2b%(left));


//if the name_source file has no matching name+ssn we can check name + dob match
//should only be the case for data new to the external file
#uniquename(nmsrc_dob_dist)
#uniquename(inf_external_has_SSN)
#uniquename(inf_external_has_no_SSN)

%nmsrc_dob_dist% := distribute(%f_nmsrc%(dob > 0),hash(src,fname,lname));

//split infile external only has SSN and no SSN, stop to look further if infile only has SSN available
%inf_external_has_SSN% := %inf_external_only%(ssn_field <> '');
%inf_external_has_no_SSN% := %inf_external_only%(ssn_field = '');

//seperate nmsrc file to DIDs possibility 1 and more than 1	on name + dob						   
							   
#uniquename(nmsrc_DID_cnt_only_one_extend)
%nmsrc_DID_cnt_only_one_extend%   := %nmsrc_dob_dist%(dids_with_this_nm_dob=1);
#uniquename(nmsrc_dive_the_rest_extend)
%nmsrc_dive_the_rest_extend%      := %nmsrc_dob_dist%(~(dids_with_this_nm_dob=1));
//to append the lowest did
#uniquename(nmsrc_dive_the_rest_extend_sort)
%nmsrc_dive_the_rest_extend_sort% := sort(%nmsrc_dive_the_rest_extend%,src,fname,lname,dob,did,local);
/*
typeof(inf_external_only_extend) %t_in_external%(inf_external_only_extend le, %nmsrc_dob_dist% ri) := transform
 self := le;
end;
*/
#uniquename(inf_external_only_extend)		 
%inf_external_only_extend% := join(%inf_external_has_no_SSN%,%nmsrc_dob_dist%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.dob_field =right.dob and left.src_field = right.src,%t_in_external%(left,right),left only,local);

#uniquename(inf_nmsrc_need_extend)		 
%inf_nmsrc_need_extend%            := join(%inf_external_has_no_SSN%,%nmsrc_dob_dist%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.dob_field =right.dob and left.src_field = right.src,%t_in_external%(left,right),keep(1),local);

#uniquename(r_nmDOB_extend)
%r_nmDOB_extend% := record
 %inf_nmsrc_need_extend%;
 unsigned6 nm_DOB_DID;
 integer   nm_DOB_score;
end;

//if a DID gets assigned here we don't have to look any further
//this is saying there is only 1 possibility on name + DOB
#uniquename(t_nmDOB_extend)
%r_nmDOB_extend% %t_nmDOB_extend%(%inf_nmsrc_need_extend% le, %nmsrc_DID_cnt_only_one_extend% ri) := transform
 self.nm_DOB_DID      := ri.DID;
 self.nm_DOB_score := if(self.nm_DOB_DID>0,100,0);
 self                   := le;

end;

#uniquename(add_nmDOB_extend)
%add_nmDOB_extend% := join(%inf_nmsrc_need_extend%,%nmsrc_DID_cnt_only_one_extend%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.dob_field =right.dob and left.src_field = right.src,%t_nmDOB_extend%(left,right),left outer,keep(1),local);

#uniquename(no_need_to_look_further_extend)
%no_need_to_look_further_extend% := %add_nmDOB_extend%(nm_DOB_DID >0);
#uniquename(continue_looking_extend)
%continue_looking_extend%        := %add_nmDOB_extend%(nm_DOB_DID =0);

//continue assigning DID from source matching			   
//Add DOB score and DID
				
#uniquename(r_nmZIP)
%r_nmZIP% := record
 %continue_looking_extend%;
 unsigned6 zip_did;
 integer   zip_score;
end;

#uniquename(t_nmZIP)
%r_nmZIP% %t_nmZIP%(%continue_looking_extend% le, %nmsrc_dive_the_rest_extend_sort% ri) := transform
 self.zip_did   := ri.did;
 self.zip_score := if(le.zip_field = ri.zip and (unsigned)le.zip_field >0,100,
                   if((unsigned)le.zip_field =0 and ri.zip_cnt_with_this_nm_dob<2,50,
				   0));
 self           := le;
				   
end;

#uniquename(add_nmZIP)
%add_nmZIP% := join(%continue_looking_extend%,%nmsrc_dive_the_rest_extend_sort%,
                left.fname_field =right.fname and left.lname_field =right.lname and  
                left.dob_field =right.dob and left.src_field = right.src
                and ((left.zip_field = right.zip and (unsigned)left.zip_field >0) or ((unsigned)left.zip_field =0 and right.zip_cnt_with_this_nm_dob<2))
				,%t_nmZIP%(left,right),left outer, keep(1));

//determine nmsrc DID from DOB and ZIP DID
#uniquename(r_nmsrc_final_extend)
%r_nmsrc_final_extend% := record
 %add_nmZIP%;
 unsigned6 nmsrc_did;
end;

#uniquename(t_determine_nmsrc_did_extend)
%r_nmsrc_final_extend% %t_determine_nmsrc_did_extend%(%add_nmZIP% le) := transform

 self.nmsrc_did := if(le.zip_score > 0 ,le.zip_did, 0);
 self := le;
end;

#uniquename(p_nmsrc_final_hasDOB)
%p_nmsrc_final_hasDOB% := project(%add_nmZIP%,%t_determine_nmsrc_did_extend%(left));

//Add all results back to outfile
#uniquename(t_final2c)
typeof(infile) %t_final2c%(%no_need_to_look_further_extend% le) := transform
 self.did_score   := if(le.nm_dob_did = 0, le.did_score, 100);
 self.did_field   := if(le.nm_dob_did = 0, le.did_field, le.nm_dob_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nm_dob_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.nm_dob_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

#uniquename(t_final2d)
typeof(infile) %t_final2d%(%p_nmsrc_final_hasDOB% le) := transform
 self.did_score   := if(le.nmsrc_did = 0, le.did_score, 100);
 self.did_field   := if(le.nmsrc_did = 0, le.did_field, le.nmsrc_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nmsrc_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.nmsrc_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

#uniquename(t_final2e)
typeof(infile) %t_final2e%(%inf_external_only_extend% le) := transform
 self.did_field := le.did_field;
 self           := le;
end;

#uniquename(p_final_c)
%p_final_c% := project(%no_need_to_look_further_extend%,%t_final2c%(left));
#uniquename(p_final_d)
%p_final_d% := project(%p_nmsrc_final_hasDOB%,%t_final2d%(left));

#uniquename(p_final_e)
%p_final_e% := project(%inf_external_only_extend% + %inf_external_has_SSN%,%t_final2e%(left));


//-------------------
//output(outfile);
//-------------------	 

outfile := %p_final_a%+%p_final_b%+%p_final_c%+%p_final_d%+%p_final_e%;

endmacro;