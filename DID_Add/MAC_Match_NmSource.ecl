import ut;

export Mac_Match_NmSource(infile,outfile,id_field,
					did_field,did_score,low_score_threshold,src_field,
					fname_field,mname_field,lname_field,suffix_field,
					prim_range_field,prim_name_field,sec_range_field,
					zip_field,ssn_field,dob_field,
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
	
%inf_improved_dist%  := distribute(%inf_improved%,hash(src_field,fname_field,lname_field,	                                                  
	                           prim_range_field,prim_name_field,							
							   zip_field));
                       
%nmsrc_dist% := distribute(%f_nmsrc%,hash(src,fname,lname,prim_range,prim_name,zip));

//seperate nmsrc file to DIDs possibility 1 and more than 1							   
							   
#uniquename(nmsrc_DID_cnt_only_one)
%nmsrc_DID_cnt_only_one%   := %nmsrc_dist%(dids_with_this_nm_addr=1);
#uniquename(nmsrc_dive_the_rest)
%nmsrc_dive_the_rest%      := %nmsrc_dist%(~(dids_with_this_nm_addr=1));
//to append the lowest did
#uniquename(nmsrc_dive_the_rest_sort)
%nmsrc_dive_the_rest_sort% := sort(%nmsrc_dive_the_rest%,src,fname,lname,prim_range,prim_name,zip,did,local);
//if the name_source file has no matching name+address we can stop here
//should only be the case for data new to the external file
typeof(%inf_improved_dist%) %t_in_external%(%inf_improved_dist% le, %nmsrc_dist% ri) := transform
 self := le;
end;

#uniquename(inf_external_only)
%inf_external_only% := join(%inf_improved_dist%,%nmsrc_dist%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and
left.zip_field =right.zip and left.src_field = right.src,%t_in_external%(left,right),left only,local);

#uniquename(inf_nmsrc_need)		 

%inf_nmsrc_need%            := join(%inf_improved_dist%,%nmsrc_dist%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and
left.zip_field =right.zip and left.src_field = right.src,%t_in_external%(left,right),keep(1),local);

#uniquename(r_nmAddr)

%r_nmAddr% := record
 %inf_nmsrc_need%;
 unsigned6 nm_addr_did;
 integer   nm_addr_did_score;
end;

//if a DID gets assigned here we don't have to look any further
//this is saying there is only 1 possibility
%r_nmAddr% t_nmAddr(%inf_nmsrc_need% le, %nmsrc_DID_cnt_only_one% ri) := transform
 
 //saw a case of JR / SR where only SR was in the header
 self.nm_addr_did_score := if(ri.did>0,
                            if(ut.nneq(le.suffix_field,ri.name_suffix),100,-1),0);

 self.nm_addr_did       := if(self.nm_addr_did_score=-1,0,ri.did);
 self                   := le;

end;

add_nmAddr := join(%inf_nmsrc_need%,%nmsrc_DID_cnt_only_one%,
left.fname_field =right.fname and left.lname_field =right.lname and 
left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and
left.zip_field =right.zip and left.src_field = right.src,t_nmAddr(left,right),left outer,keep(1),local);

#uniquename(no_need_to_look_further)
%no_need_to_look_further% := add_nmAddr(~(nm_addr_did=0 and nm_addr_did_score<>-1));

#uniquename(continue_looking)
%continue_looking%        := add_nmAddr(  nm_addr_did=0 and nm_addr_did_score<>-1);
//continue assigning DID from source matching
//Add name suffix score and DID
#uniquename(r_nmSuffix)
%r_nmSuffix% := record
 %continue_looking%;
 unsigned6 suffix_did;
 integer   suffix_score;
end;

%r_nmSuffix% t_nmSuffix(%continue_looking% le, %nmsrc_dive_the_rest_sort% ri) := transform
 self.suffix_did       := ri.did;
 self.suffix_score     := if(le.suffix_field =ri.name_suffix and le.suffix_field <>'' and ri.suffix_cnt_with_this_nm_addr>=2,100,
                          if((le.suffix_field =ri.name_suffix and le.suffix_field <>'') or (le.suffix_field ='' and ri.suffix_cnt_with_this_nm_addr<2),50
					  ,0));
 self                  := le;
					  
end;

add_nmSuffix := join(%continue_looking%,%nmsrc_dive_the_rest_sort%,
               left.fname_field =right.fname and left.lname_field =right.lname and 
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and		   
			   left.zip_field =right.zip and left.src_field = right.src
               and ((left.suffix_field =right.name_suffix and left.suffix_field <>'') or (left.suffix_field ='' and right.suffix_cnt_with_this_nm_addr<2))
				,t_nmSuffix(left,right),left outer,local);				

did_add.MAC_Dedup_DIDs(add_nmSuffix, id_field, suffix_did, suffix_score, add_nmSuffix_dedup)

add_nmsuffix_dist := distribute(add_nmSuffix_dedup, hash(src_field,fname_field,lname_field,	                                                  
	                           prim_range_field,prim_name_field,							
							   zip_field));


//Add SSN score and DID
			   
#uniquename(r_nmSSN)

%r_nmSSN% := record
 add_nmSuffix;
 unsigned6 ssn_did;
 integer   ssn_score;
end;

#uniquename(t_nmSSN)
%r_nmSSN% %t_nmSSN%(add_nmSuffix_dedup le, %nmsrc_dive_the_rest_sort% ri) := transform
 self.ssn_did   := ri.did;
 self.ssn_score := if(le.ssn_field =ri.ssn and le.ssn_field <>'' and ri.ssn_cnt_with_this_nm_addr>=2,100,
                   if((le.ssn_field =ri.ssn and le.ssn_field <>'') or (le.ssn_field ='' and ri.ssn_cnt_with_this_nm_addr<2),50,
				   0));
 self           := le;
				   
end;

#uniquename(add_nmSSN)
%add_nmSSN% := join(add_nmSuffix_dist,%nmsrc_dive_the_rest_sort%,
               left.fname_field =right.fname and left.lname_field =right.lname and          
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and             		   
			   left.zip_field =right.zip and left.src_field = right.src
               and ((left.ssn_field =right.ssn and left.ssn_field <>'') or (left.ssn_field ='' and right.ssn_cnt_with_this_nm_addr<2))
				,%t_nmSSN%(left,right),left outer,local);
add_nmSSN_p := project(%add_nmSSN%, transform(%r_nmSSN%, self.ssn_did := if(left.ssn_score <= left.suffix_score, left.suffix_did,
left.SSN_did),self.ssn_score := IF (left.ssn_score > left.suffix_score, left.ssn_score, left.suffix_score ), self := left));

did_add.MAC_Dedup_DIDs(add_nmSSN_p, id_field, ssn_did, ssn_score,add_nmSSN_dedup)

add_nmSSN_dist := distribute(add_nmSSN_dedup, hash(src_field,fname_field,lname_field,	                                                  
	                           prim_range_field,prim_name_field,							
							   zip_field));				
//Add DOB score and DID
				
#uniquename(r_nmDOB)
%r_nmDOB% := record
 %add_nmSSN%;
 unsigned6 dob_did;
 integer   dob_score;
end;

#uniquename(t_nmDOB)
%r_nmDOB% %t_nmDOB%(%add_nmSSN% le, %nmsrc_dive_the_rest_sort% ri) := transform
 self.dob_did   := ri.did;
 self.dob_score := if(le.dob_field = ri.dob and le.dob_field >0 and ri.dob_cnt_with_this_nm_addr >= 2,100,
                   if((le.dob_field = ri.dob and le.dob_field >0) or (le.dob_field =0 and ri.dob_cnt_with_this_nm_addr<2),50,
				   0));
 self           := le;
				   
end;

#uniquename(add_nmDOB)
%add_nmDOB% := join(add_nmSSN_dist,%nmsrc_dive_the_rest_sort%,
                left.fname_field =right.fname and left.lname_field =right.lname and  
                left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and     				
				left.zip_field =right.zip and left.src_field = right.src
                and ((left.dob_field = right.dob and left.dob_field >0) or (left.dob_field =0 and right.dob_cnt_with_this_nm_addr<2))
				,%t_nmDOB%(left,right),left outer,local);

add_nmDOB_p := project(%add_nmDOB%, transform(%r_nmDOB%, self.dob_did := if(left.dob_score <= left.ssn_score, left.ssn_did,
left.dob_did),self.dob_score := IF (left.dob_score > left.ssn_score, left.dob_score, left.ssn_score ), self := left));
did_add.MAC_Dedup_DIDs(add_nmDOB_p, id_field, dob_did, dob_score,add_nmDOB_dedup)


add_nmDOB_dist := distribute(add_nmDOB_dedup, hash(src_field,fname_field,lname_field,	                                                  
	                           prim_range_field,prim_name_field,							
							   zip_field));


//Add sec range score and DID
				
#uniquename(r_secRange)
%r_secRange% := record
 %add_nmDOB%;
 unsigned6 sec_range_did;
 integer   sec_range_score;
end;

%r_secRange% t_secRange(%add_nmDOB% le, %nmsrc_dive_the_rest_sort% ri) := transform
 self.sec_range_did   := ri.did;
 self.sec_range_score := if(le.sec_range_field =ri.sec_range and le.sec_range_field<>'' and ri.sec_range_cnt_with_this_nm_addr >= 2,100,
                         if((le.sec_range_field =ri.sec_range and le.sec_range_field<>'') or (le.sec_range_field ='' and ri.sec_range_cnt_with_this_nm_addr<2),50
						 ,0));
 self                 := le;
						 
end;

add_secRange := join(add_nmDOB_dist,%nmsrc_dive_the_rest_sort%,
               left.fname_field =right.fname and left.lname_field =right.lname and 
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and
               ((left.sec_range_field =right.sec_range and left.sec_range_field <>'') or (left.sec_range_field ='' and right.sec_range_cnt_with_this_nm_addr<2)) and	   
			   left.zip_field =right.zip and left.src_field = right.src               
			   ,t_secRange(left,right),left outer,local);


add_secRange_p := project(add_secRange, transform(%r_secRange%, self.sec_range_did := if(left.sec_range_score <= left.dob_score, left.dob_did,
left.sec_range_did),self.sec_range_score := IF (left.dob_score > left.sec_range_score, left.dob_score, left.sec_range_score ), self := left));
did_add.MAC_Dedup_DIDs(add_secRange_p, id_field, sec_range_did, sec_range_score, add_secRange_dedup)

add_secRange_dist := distribute(add_secRange_dedup, hash(src_field,fname_field,lname_field,	                                                  
	                           prim_range_field,prim_name_field,							
							   zip_field));//Add mname score and DID

#uniquename(r_nmMname)
%r_nmMname% := record
 add_secRange;
 unsigned6 mname_did;
 integer   mname_score;
end;

%r_nmMname% t_nmMname(add_secRange le, %nmsrc_dive_the_rest_sort% ri) := transform
 self.mname_did   := ri.did;
 self.mname_score := if(le.mname_field =ri.mname and le.mname_field <>'' and ri.mname_cnt_with_this_nm_addr >= 2,100,
                     if((le.mname_field =ri.mname and le.mname_field <>'') or (le.mname_field ='' and ri.mname_cnt_with_this_nm_addr<2),50,
					 0));
 self             := le;
					 
end;

add_nmMname := join(add_secRange_dist,%nmsrc_dive_the_rest_sort%,
               left.fname_field =right.fname and left.lname_field =right.lname and 
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and	   
			   left.zip_field =right.zip and left.src_field = right.src
               and ((left.mname_field =right.mname and left.mname_field <>'') or (left.mname_field ='' and right.mname_cnt_with_this_nm_addr<2))
				,t_nmMname(left,right),left outer,local);


add_nmMname_p := project(add_nmMname, transform(%r_nmMname%, self.mname_did := if(left.sec_range_score >= left.mname_score, left.sec_range_did,
left.mname_did),self.mname_score := IF (left.mname_score > left.sec_range_score, left.mname_score, left.sec_range_score ), self := left));
did_add.MAC_Dedup_DIDs(add_nmMname_p, id_field, mname_did, mname_score,add_nmMname_dedup)


//Add all results back to outfile

#uniquename(t_final2a)
typeof(infile) %t_final2a%(%no_need_to_look_further% le) := transform
 self.did_score   := if(le.nm_addr_did = 0, le.did_score, 100);
 self.did_field   := if(le.nm_addr_did = 0, le.did_field, le.nm_addr_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nm_addr_did = 0, le.score_n_field, 
 DID_Add.fn_nmsrc_score(le.did_field,le.nm_addr_did,le.did_score,low_score_threshold)); 
 #end
 self := le;
end;

#uniquename(t_final2b)
typeof(infile) %t_final2b%(add_nmMname_dedup le) := transform
 self.did_score   := if(le.mname_score = 100, 100, le.did_score);
 self.did_field   := if(le.mname_score = 100, le.mname_did, le.did_field);
 #if(bool_indiv_score)
 self.score_n_field := if(le.mname_did = 0, le.score_n_field, 
                       DID_Add.fn_nmsrc_score(le.did_field,le.mname_did,le.did_score,low_score_threshold));
 #end
 self := le;
end;

#uniquename(t_final2c)
typeof(infile) %t_final2c%(%inf_external_only% le) := transform
 self.did_field := le.did_field;
 self           := le;
end;

#uniquename(p_final_a)
%p_final_a% := project(%no_need_to_look_further%,%t_final2a%(left));

#uniquename(p_final_b)
%p_final_b% := project(add_nmMname_dedup,%t_final2b%(left));

#uniquename(p_final_c)
%p_final_c% := project(%inf_external_only%,%t_final2c%(left));

//-------------------
//output(outfile);
//-------------------	 

outfile := %p_final_a%+%p_final_b%+%p_final_c%;

endmacro;