/*2009-01-28T07:08:26Z (Wendy Ma)
add rollup on infile
*/
/*2009-01-07T15:53:00Z (Wendy Ma)
improve the code
*/
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
	
%inf_improved_dist%  := distribute(%inf_improved%,hash(src_field,fname_field,lname_field,	                                                  
	                           prim_range_field,prim_name_field,							
							   zip_field));
	                       
%nmsrc_dist% := distribute(%f_nmsrc%,hash(src,fname,lname,prim_range,prim_name,zip));

//seperate nmsrc file to DIDs possibility 1 and more than 1							   
							   
#uniquename(nmsrc_DID_cnt_only_one)
%nmsrc_DID_cnt_only_one%   := %nmsrc_dist%(dids_with_this_nm_addr=1);
nmsrc_dive_the_rest        := %nmsrc_dist%(~(dids_with_this_nm_addr=1));
//to append the lowest did
nmsrc_dive_the_rest_sort := sort(nmsrc_dive_the_rest,src,fname,lname,prim_range,prim_name,zip,did,local);

//if the name_source file has no matching name+address we can stop here
//should only be the case for data new to the external file
typeof(%inf_improved_dist%) %t_in_external%(%inf_improved_dist% le, %nmsrc_dist% ri) := transform
 self := le;
end;

inf_external_only := join(%inf_improved_dist%,%nmsrc_dist%,
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

no_need_to_look_further := add_nmAddr(~(nm_addr_did=0 and nm_addr_did_score<>-1));

continue_looking        := add_nmAddr(  nm_addr_did=0 and nm_addr_did_score<>-1);

//continue assigning DID from source matching
//Add name suffix score and DID
#uniquename(r_nmSuffix)
%r_nmSuffix% := record
 continue_looking;
 unsigned6 suffix_did;
 integer   suffix_score;
end;

%r_nmSuffix% t_nmSuffix(continue_looking le, nmsrc_dive_the_rest_sort ri) := transform
 self.suffix_did       := ri.did;
 self.suffix_score     := if(le.suffix_field =ri.name_suffix and le.suffix_field <>'',100,
                          if(le.suffix_field ='' and ri.suffix_cnt_with_this_nm_addr<2,50
					  ,0));
 self                  := le;
					  
end;

add_nmSuffix := join(continue_looking,nmsrc_dive_the_rest_sort,
               left.fname_field =right.fname and left.lname_field =right.lname and 
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and		   
			   left.zip_field =right.zip and left.src_field = right.src
               and ((left.suffix_field =right.name_suffix and left.suffix_field <>'') or (left.suffix_field ='' and right.suffix_cnt_with_this_nm_addr<2))
				,t_nmSuffix(left,right),left outer,keep(1));
				
//Add sec range score and DID
				
#uniquename(r_secRange)
%r_secRange% := record
 add_nmSuffix;
 unsigned6 sec_range_did;
 integer   sec_range_score;
end;

%r_secRange% t_secRange(add_nmSuffix le, nmsrc_dive_the_rest_sort ri) := transform
 self.sec_range_did   := ri.did;
 self.sec_range_score := if(le.sec_range_field =ri.sec_range and le.sec_range_field<>'',100,
                         if(le.sec_range_field ='' and ri.sec_range_cnt_with_this_nm_addr<2,50
						 ,0));
 self                 := le;
						 
end;

add_secRange := join(add_nmSuffix,nmsrc_dive_the_rest_sort,
               left.fname_field =right.fname and left.lname_field =right.lname and 
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and
               ((left.sec_range_field =right.sec_range and left.sec_range_field <>'') or (left.sec_range_field ='' and right.sec_range_cnt_with_this_nm_addr<2)) and	   
			   left.zip_field =right.zip and left.src_field = right.src               
			   ,t_secRange(left,right),left outer, keep(1));

//Add SSN score and DID
			   
#uniquename(r_nmSSN)

%r_nmSSN% := record
 add_secRange;
 unsigned6 ssn_did;
 integer   ssn_score;
end;

%r_nmSSN% t_nmSSN(add_secRange le, nmsrc_dive_the_rest_sort ri) := transform
 self.ssn_did   := ri.did;
 self.ssn_score := if(le.ssn_field =ri.ssn and le.ssn_field <>'',100,
                   if(le.ssn_field ='' and ri.ssn_cnt_with_this_nm_addr<2,50,
				   0));
 self           := le;
				   
end;

add_nmSSN := join(add_secRange,nmsrc_dive_the_rest_sort,
               left.fname_field =right.fname and left.lname_field =right.lname and          
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and             		   
			   left.zip_field =right.zip and left.src_field = right.src
               and ((left.ssn_field =right.ssn and left.ssn_field <>'') or (left.ssn_field ='' and right.ssn_cnt_with_this_nm_addr<2))
				,t_nmSSN(left,right),left outer,keep(1));
				
//Add DOB score and DID
				
#uniquename(r_nmDOB)
%r_nmDOB% := record
 add_nmSSN;
 unsigned6 dob_did;
 integer   dob_score;
end;

%r_nmDOB% t_nmDOB(add_nmSSN le, nmsrc_dive_the_rest_sort ri) := transform
 self.dob_did   := ri.did;
 self.dob_score := if(le.dob_field = ri.dob and le.dob_field >0,100,
                   if(le.dob_field =0 and ri.dob_cnt_with_this_nm_addr<2,50,
				   0));
 self           := le;
				   
end;

add_nmDOB := join(add_nmSSN,nmsrc_dive_the_rest_sort,
                left.fname_field =right.fname and left.lname_field =right.lname and  
                left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and     				
				left.zip_field =right.zip and left.src_field = right.src
                and ((left.dob_field = right.dob and left.dob_field >0) or (left.dob_field =0 and right.dob_cnt_with_this_nm_addr<2))
				,t_nmDOB(left,right),left outer, keep(1));

//Add mname score and DID

#uniquename(r_nmMname)
%r_nmMname% := record
 add_nmDOB;
 unsigned6 mname_did;
 integer   mname_score;
end;

%r_nmMname% t_nmMname(add_nmDOB le, nmsrc_dive_the_rest_sort ri) := transform
 self.mname_did   := ri.did;
 self.mname_score := if(le.mname_field =ri.mname and le.mname_field <>'',100,
                     if(le.mname_field ='' and ri.mname_cnt_with_this_nm_addr<2,50,
					 0));
 self             := le;
					 
end;

add_nmMname := join(add_nmDOB,nmsrc_dive_the_rest_sort,
               left.fname_field =right.fname and left.lname_field =right.lname and 
               left.prim_range_field =right.prim_range and left.prim_name_field =right.prim_name and	   
			   left.zip_field =right.zip and left.src_field = right.src
               and ((left.mname_field =right.mname and left.mname_field <>'') or (left.mname_field ='' and right.mname_cnt_with_this_nm_addr<2))
				,t_nmMname(left,right),left outer,keep(1));

//normalize to get most common DID

#uniquename(r_norm)
%r_norm% := record
 add_nmMname.id_field;
 unsigned6 norm_did;
 integer   did_cnt:=1;
end;

%r_norm% t_norm(add_nmMname le, integer c) := transform
 self.norm_did := choose(c,le.suffix_did,le.sec_range_did,le.ssn_did,le.dob_did,le.mname_did);
 self          := le;
end;

p_norm      := normalize(add_nmMname,5,t_norm(left,counter));
p_norm_filt := p_norm(norm_did>0);
p_norm_sort := sort(distribute(p_norm_filt,hash(id_field,norm_did)),id_field,norm_did,local);

%r_norm% t_cnt_dids(%r_norm% le, %r_norm% ri) := transform
 self.did_cnt := le.did_cnt+1;
 self         := le;
end;

p_norm_rollup      := rollup(p_norm_sort,left.id_field =right.id_field and left.norm_did=right.norm_did,t_cnt_dids(left,right),local);
p_norm_rollup_sort := sort(distribute(p_norm_rollup,hash(id_field)),id_field,norm_did,-did_cnt,local);
p_norm_rollup_dupd := dedup(p_norm_rollup_sort,id_field,local);

#uniquename(r_most_common_did)
%r_most_common_did% := record
 add_nmMname;
 p_norm_rollup_dupd.norm_did;
 p_norm_rollup_dupd.did_cnt;
end;

%r_most_common_did% t_most_common_did(add_nmMname le, p_norm_rollup_dupd ri) := transform
 self := le;
 self := ri;
end;

add_most_common_did := join(sort(distribute(add_nmMname, hash(id_field)),id_field),
                       p_norm_rollup_dupd,left.id_field =right.id_field,t_most_common_did(left,right),left outer,local);

//determine nmsrc DID from nmAddr,nameSuffix,secrange,SSN,DOB and mname DID
#uniquename(r_nmsrc_final)
%r_nmsrc_final% := record
 add_most_common_did;
 unsigned6 nmsrc_did;
end;

int_nneq(did1,did2) := function

 boolean ret_val := did1=0 or did2=0 or did1=did2;

 return ret_val;
end;

%r_nmsrc_final% t_determine_nmsrc_did(add_most_common_did le) := transform
 
 unsigned6 v_suffix_did    := le.suffix_did;
 unsigned6 v_sec_range_did := le.sec_range_did;
 unsigned6 v_ssn_did       := le.ssn_did;
 unsigned6 v_dob_did       := le.dob_did;
 unsigned6 v_mname_did     := le.mname_did;

 integer cnt1_2 := if(int_nneq(v_suffix_did,v_sec_range_did),1,0);
 integer cnt2_2 := if(int_nneq(v_suffix_did,v_ssn_did),1,0);
 integer cnt3_2 := if(int_nneq(v_suffix_did,v_dob_did),1,0);
 integer cnt4_2 := if(int_nneq(v_suffix_did,v_mname_did),1,0);

 integer cnt1_3 := if(int_nneq(v_sec_range_did,v_ssn_did),1,0);
 integer cnt2_3 := if(int_nneq(v_sec_range_did,v_dob_did),1,0);
 integer cnt3_3 := if(int_nneq(v_sec_range_did,v_mname_did),1,0);

 integer cnt1_4 := if(int_nneq(v_ssn_did,v_dob_did),1,0);
 integer cnt2_4 := if(int_nneq(v_ssn_did,v_mname_did),1,0);

 integer cnt1_5 := if(int_nneq(v_dob_did,v_mname_did),1,0);
 
 integer v_dont_disagree := sum(
                                cnt1_2+cnt2_2+cnt3_2+cnt4_2+
								cnt1_3+cnt2_3+cnt3_3+
								cnt1_4+cnt2_4+
								cnt1_5
								);

 integer v_disagree := 10-v_dont_disagree;
 integer v_margin   := v_dont_disagree-v_disagree;
 
 self.nmsrc_did := //this assumes less fraudulent use of suffix information versus ssn's
                   if(le.suffix_score=100,le.suffix_did,
				   if(le.ssn_score=100,le.ssn_did,
				   if(le.sec_range_score = 100, le.sec_range_did,
				   if(v_dont_disagree>v_disagree,le.norm_did,
				   0))));
 self := le;
end;

p_nmsrc_final := project(add_most_common_did,t_determine_nmsrc_did(left));

//Add all results back to outfile
typeof(infile) t_final2a(no_need_to_look_further le) := transform
 self.did_score   := if(le.nm_addr_did = 0, le.did_score, 100);
 self.did_field   := if(le.nm_addr_did = 0, le.did_field, le.nm_addr_did);
 #if(bool_indiv_score)
 self.score_n_field := if(le.nm_addr_did = 0, le.score_n_field, 
 DID_Add.fn_nmsrc_score(le.did_field,le.nm_addr_did,le.did_score,low_score_threshold)); 
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