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
%infile_src% := table(infile, {src},src); 
%f_nmsrc%  := join(Header_SlimSort.File_Name_Source, %infile_src%,left.src = right.src, transform(header_slimsort.layout_name_source,
self := left), lookup);

//*********improve infile fields

#uniquename(inf_improved)
DID_Add.Mac_Improve_Infile(infile,src_field,fname_field,mname_field,lname_field,prim_range_field,
prim_name_field, sec_range_field,zip_field,ssn_field,dob_field, %inf_improved%)
	 
#uniquename(inf_improved_dist)		 
#uniquename(nmsrc_dist)		 
#uniquename(t_in_external)		 
	
%inf_improved_dist%  := distribute(%inf_improved%,hash(src_field,fname_field,lname_field,ssn_field));
	                       
%nmsrc_dist% := distribute(%f_nmsrc%,hash(src,fname,lname,ssn));

//seperate nmsrc file to DIDs possibility 1 and more than 1							   
							   
#uniquename(nmsrc_DID_cnt_only_one)
%nmsrc_DID_cnt_only_one%   := %nmsrc_dist%(dids_with_this_nm_ssn=1);
nmsrc_dive_the_rest        := %nmsrc_dist%(~(dids_with_this_nm_ssn=1));
//to append the lowest did
nmsrc_dive_the_rest_sort := sort(nmsrc_dive_the_rest,src,fname,lname,ssn,did,local);

//if the name_source file has no matching name+ssn we can stop here
//should only be the case for data new to the external file
typeof(%inf_improved_dist%) %t_in_external%(%inf_improved_dist% le, %nmsrc_dist% ri) := transform
 self := le;
end;

inf_external_only := join(%inf_improved_dist%,%nmsrc_dist%,
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
//this is saying there is only 1 possibility
%r_nmSSN% t_nmSSN(%inf_nmsrc_need% le, %nmsrc_DID_cnt_only_one% ri) := transform
 self.nm_ssn_DID      := ri.DID;
 self.nm_ssn_score := if(self.nm_ssn_DID>0,100,0);
 self                   := le;

end;

add_nmSSN := join(%inf_nmsrc_need%,%nmsrc_DID_cnt_only_one%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.ssn_field =right.ssn and left.src_field = right.src,t_nmSSN(left,right),left outer,keep(1),local);

no_need_to_look_further := add_nmSSN(nm_ssn_DID >0);
continue_looking        := add_nmSSN(nm_ssn_DID =0);

//continue assigning DID from source matching			   
//Add DOB score and DID
				
#uniquename(r_nmDOB)
%r_nmDOB% := record
 continue_looking;
 unsigned6 dob_did;
 integer   dob_score;
end;

%r_nmDOB% t_nmDOB(continue_looking le, nmsrc_dive_the_rest_sort ri) := transform
 self.dob_did   := ri.did;
 self.dob_score := if(le.dob_field = ri.dob and le.dob_field >0,100,
                   if(le.dob_field =0 and ri.dob_cnt_with_this_nm_ssn<2,50,
				   0));
 self           := le;
				   
end;

add_nmDOB := join(continue_looking,nmsrc_dive_the_rest_sort,
                left.fname_field =right.fname and left.lname_field =right.lname and  
                left.ssn_field =right.ssn and left.src_field = right.src
                and ((left.dob_field = right.dob and left.dob_field >0) or (left.dob_field =0 and right.dob_cnt_with_this_nm_ssn<2))
				,t_nmDOB(left,right),left outer, keep(1));

//determine nmsrc DID from SSN and DOB DID
#uniquename(r_nmsrc_final)
%r_nmsrc_final% := record
 add_nmDOB;
 unsigned6 nmsrc_did;
end;

%r_nmsrc_final% t_determine_nmsrc_did(add_nmDOB le) := transform

 self.nmsrc_did := if(le.dob_score > 0 ,le.dob_did, 0);
 self := le;
end;

p_nmsrc_final := project(add_nmDOB,t_determine_nmsrc_did(left));

//Add all results back to outfile
typeof(infile) t_final2a(no_need_to_look_further le) := transform
 self.did_score   := if(le.nm_ssn_did = 0, le.did_score, 100);
 self.did_field   := if(le.nm_ssn_did = 0, le.did_field, le.nm_ssn_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nm_ssn_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.nm_ssn_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

typeof(infile) t_final2b(p_nmsrc_final le) := transform
 self.did_score   := if(le.nmsrc_did = 0, le.did_score, 100);
 self.did_field   := if(le.nmsrc_did = 0, le.did_field, le.nmsrc_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nmsrc_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.nmsrc_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

typeof(infile) t_final2c(inf_external_only le) := transform
 self.did_field := le.did_field;
 self           := le;
end;

p_final_a := project(no_need_to_look_further,t_final2a(left));
p_final_b := project(p_nmsrc_final,t_final2b(left));
p_final_c := project(inf_external_only,t_final2c(left));


//-------------------
//output(outfile);
//-------------------	 

outfile := p_final_a+p_final_b+p_final_c;

endmacro;