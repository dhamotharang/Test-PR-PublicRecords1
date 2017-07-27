import ut;

//layout_matchcandidates
export fn_match_candidates(
	dataset(header.layout_matchcandidates) sd3,
	dataset(header.Layout_Header) head,
	string persist_suffix = '',
	boolean new_version = false) := 
FUNCTION

boolean NoPersist := header.DoSkipPersist(persist_suffix);

only4wb := header.fn_StripExpiredDOBs(sd3,head);

wbna_pre := header.well_behaved_name_address(only4wb, new_version);
wbna_pst := wbna_pre;// : persist('good_name_address' + persist_suffix);
wbna := if(NoPersist, wbna_pre, wbna_pst);

bbs_pre := header.badly_behaved_ssns(only4wb);
bbs_pst := bbs_pre  : persist('bad_ssns' + persist_suffix);
bbs :=  if(NoPersist, bbs_pre, bbs_pst);

by_ssn := sd3((unsigned8)ssn<>0);

typeof(sd3)  add_ssn_flag(sd3 le,bbs ri) := transform
  self.good_ssn := ri.ssn='';
  self := le;
  end; 

ssns_app := join(by_ssn,bbs,
								 left.ssn=right.ssn and
								 (right.fname = '' or left.fname = right.fname),
								 add_ssn_flag(left,right),hash, left outer);

ssns_done := ssns_app + sd3((unsigned8)ssn=0);

//by_nmaddr := distribute(ssns_done,hash(fname,lname,zip,prim_range,prim_name));
by_nmaddr := ssns_done;

typeof(sd3)  add_addr_flag(sd3 le,wbna ri,boolean safeFnameInitial = false) := transform
  self.good_nmaddr := MAP( 	ri.lname = '' and safeFnameInitial	=> le.good_nmaddr,  //this to handle non hits in the second join
														ri.dob_min=0 												=> -1, 
														ri.dob_min=99999999 								=> 0, 
														not safeFnameInitial			 					=> 1,
																																	 2);	//score 2 if the first character is safe
  self := le;
  end; 

addrs_app1 := join(by_nmaddr,wbna(length(trim(fname)) > 1),
																					 left.fname=right.fname and 
                                           left.lname=right.lname and
                                           left.zip=right.zip and
                                           left.prim_range=right.prim_range and
                                           left.prim_name=right.prim_name
                   ,add_addr_flag(left,right),hash,left outer);	
	
	
	

addrs_app := join(addrs_app1,wbna(length(trim(fname)) = 1),
										metaphonelib.DMetaPhone1(left.fname)[1]= right.fname and 
                    left.lname=right.lname and
                    left.zip=right.zip and
                    left.prim_range=right.prim_range and
                    left.prim_name=right.prim_name
                   ,add_addr_flag(left,right,true),hash,left outer);

rare_names := header.fn_rare_names(sd3);

typeof(sd3)  add_rare_flag(sd3 le,rare_names ri) := transform
  self.rare_name := if(ri.cnt=0,255,ri.cnt);
  self := le;
  end; 

nm_add := join(addrs_app,rare_names,left.fname=right.fname and
                                    left.lname=right.lname,
                                    add_rare_flag(left,right),hash,left outer);
nm_add_pst := nm_add : persist('match_candidates' + persist_suffix);

outf := if(NoPersist, nm_add, nm_add_pst);

return outf;

END;