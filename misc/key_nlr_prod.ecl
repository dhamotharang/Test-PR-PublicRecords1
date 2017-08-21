import doxie,header,header_quick,experiancred,ut;
//
// See the following for hints on fuzzy field rules and transformations rules on match(map) to header:
// 	MDR.MAC_BasicMatch
// 	header.fn_bm_lr_commonality
//

boolean test_return:=false;
boolean dev_output:= true;

//testing with did%10=1 on dataland;


hdr_in	:= distribute(Header.file_headers,hash(did))
					(src in ['EQ','EN'] and did%10=1);
eq_in 	:= distribute(Header_quick.file_header_quick,hash(did)) 
					(did<>0 and did%10=1);
en_in 	:= distribute(Experiancred.files.base_file_out,hash(did)) 
					(did<>0 and did%10=1 and (delete_flag=0 or (delete_flag<>0 and suppression_code not in [41,50,99])));


layout_temp := record
	string1 eq_did_flag		:= '';
	string1 eq_name_flag	:= '';
	string1 eq_addr_flag	:= '';
	string1 eq_dob_flag		:= '';
	string1 eq_phone_flag	:= '';
	string1 eq_ssn_flag		:= '';
	string1 eq_lname_flag := '';
	//
	string1 en_did_flag		:= '';
	string1 en_name_flag	:= '';
	string1 en_addr_flag	:= '';
	string1 en_dob_flag		:= '';
	string1 en_ssn_flag		:= '';
	string1 en_phone_flag	:= '';
	string1 en_lname_flag := '';
	//
	header.layout_header_v2;
	//
	unsigned4 not_in_bureau := 0;
end;
	
layout_slim := record
	unsigned6    did;
	//
	boolean 		 src_is_eq:=false;
	boolean			 src_is_en:=false;
	unsigned		 en_current_rec_flag:=0; 	// for "current" ssn and dob from experian files
	//
	qstring10    phone;
	qstring9     ssn;
	integer4     dob;
	//
	qstring20    fname;
	qstring20    mname;
	qstring20    lname;
	qstring5     name_suffix;
	//
	qstring10    prim_range;
	string2      predir;
	qstring28    prim_name;
	qstring4     suffix;
	string2      postdir;
	qstring8     sec_range;
	qstring25    city_name;
	string2      st;
	qstring5     zip;
	//
end;


// header.layout_header_v2 to_rollup_hdr (hdr_in l, hdr_in r) := transform
 // // set src blank for now
 // self.src := '';
	// // ?? rollup seems required, set rid=min?, rid is unique and would defeat rollup on src
	// //?? other fields may go also, so rollup is in-place for changes
 // self.rid := ut.min2(l.rid, r.rid);		
  
 // self.dt_first_seen							:= ut.min2(l.dt_first_seen, r.dt_first_seen);
 // self.dt_last_seen							:= ut.max2(l.dt_last_seen,  r.dt_last_seen);
 // self.dt_vendor_first_reported	:= ut.min2(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
 // self.dt_vendor_last_reported		:= ut.max2(l.dt_vendor_last_reported,  r.dt_vendor_last_reported);
 // self.dt_nonglb_last_seen 			:= ut.max2(l.dt_nonglb_last_seen,  r.dt_nonglb_last_seen);
 // self := l;
// end;

// hdr_r 	:= rollup(
  					// sort(hdr_in,
											// did,
											// phone,ssn,dob,
											// fname,mname,lname,name_suffix,
											// prim_range,predir,prim_name,suffix,postdir,sec_range,city_name,st,zip,local),
	  			  // to_rollup_hdr(left,right),
										  // did,
											// phone,ssn,dob,
											// fname,mname,lname,name_suffix,
											// prim_range,predir,prim_name,suffix,postdir,sec_range,city_name,st,zip,local);				

hdr_r := hdr_in; // take all input records for now without knowing more

								
layout_slim to_slim_eq(eq_in l) := transform
	self.src_is_eq:=true;
	self := l;
end;
eq_s := project(eq_in,to_slim_eq(left));

layout_slim to_slim_en(en_in l) := transform
	self.src_is_en:=true;
	self.en_current_rec_flag := l.current_rec_flag;	// added to allow filter for current SSN & DOB in incremental update EN data
	self.phone := l.telephone;
	self.ssn := l.social_security_number;
	self.dob := (integer) l.date_of_birth;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name;
	self := l;
end;
en_s := project(en_in,to_slim_en(left));

layout_slim to_rs(layout_slim l, layout_slim r) := transform
	self.src_is_eq := if(l.src_is_eq, l.src_is_eq, r.src_is_eq);
	self.src_is_en := if(l.src_is_en, l.src_is_en, r.src_is_en);
	self.en_current_rec_flag := if(l.en_current_rec_flag<>0, l.en_current_rec_flag, r.en_current_rec_flag);
	self := l;
	end;
	
bb_did	:= rollup(
					sort(eq_s+en_s,
					 did,local),
				 	to_rs(left,right),
					 did,local);

bb_name := rollup(
					sort(eq_s+en_s,
					 did,lname,fname,mname,name_suffix,local),
				 	to_rs(left,right),
					 did,lname,fname,mname,name_suffix,local);
					 
bb_addr := rollup(
					sort(eq_s+en_s,
					 did,prim_range,predir,prim_name,suffix,postdir,sec_range, city_name,st,zip,local),
				 	to_rs(left,right),
					 did,prim_range,predir,prim_name,suffix,postdir,sec_range, city_name,st,zip,local);

bb_dob := rollup(
					sort(eq_s(dob<>0)+en_s(dob<>0),
					 did,dob,en_current_rec_flag,local),
				 	to_rs(left,right),
					 did,dob,en_current_rec_flag,local);
					 
bb_ssn := rollup(
					sort(eq_s(ssn<>'')+en_s(ssn<>''),
					 did,ssn,en_current_rec_flag,local),
				 	to_rs(left,right),
					 did,ssn,en_current_rec_flag,local);
					
bb_phone := rollup(
					sort(eq_s(phone<>'')+en_s(phone<>''),
					 did,phone,local),
				 	to_rs(left,right),
					 did,phone,local);

bb_lname := rollup(
					sort(eq_s(lname<>'')+en_s(lname<>''),
					 did,lname,local),
				 	to_rs(left,right),
					 did,lname,local);

layout_temp j1_xx_did(hdr_r l, layout_slim r) := transform 
  boolean did_is_same := l.did=r.did;
	self.eq_did_flag := if(r.src_is_eq and did_is_same,'X','');
	self.en_did_flag := if(r.src_is_en and did_is_same,'X','');
	self.eq_dob_flag := if(l.dob=0,'D','');
	self.en_dob_flag := if(l.dob=0,'D','');
	self.eq_ssn_flag := if(l.ssn='','S','');
	self.en_ssn_flag := if(l.ssn='','S','');
	self.eq_phone_flag := 'P'; // if(l.phone='','P','');	// all phones are ok 6/24/2010
	self.en_phone_flag := 'P'; // if(l.phone='','P','');	// all phones are ok 6/24/2010
	self.eq_lname_flag := if(l.lname='','L','');
	self.en_lname_flag := if(l.lname='','L','');
	self := l;
end;
r1_xx_did := join(hdr_r, 
									bb_did,
									left.did=right.did,
									j1_xx_did(left,right),local,left outer);

r1_did_not_in_both := r1_xx_did(eq_did_flag='' and en_did_flag='');	// these can be skipped for subsequent joins and added at end;

r1_to_do 	:= r1_xx_did(eq_did_flag='X' or en_did_flag='X');	

// all phones are ok - 6/24/2010 commented out following
// layout_temp j2_xx_phone(layout_temp l, layout_slim r) := transform
	// boolean	phone_is_same	:=	l.phone='' or (l.phone<>'' and r.phone<>'' and l.phone=r.phone);	// ut.nneq_phone ??
	// self.eq_phone_flag := if(r.src_is_eq and phone_is_same,'P','');
	// self.en_phone_flag := if(r.src_is_en and phone_is_same,'P','');
	// self := l;
// end;
// r2_xx_phone := r1_to_do(phone='') + 
				 // join(r1_to_do(phone<>''), 
							// bb_phone,
							// left.did=right.did and left.phone=right.phone,
							// j2_xx_phone(left,right), local, left outer);

r2_xx_phone := r1_to_do;

layout_temp j3_xx_ssn(layout_temp l, layout_slim r) := transform
	boolean	ssn_is_same		:=	l.ssn='' or (l.ssn<>'' and r.ssn<>'' and l.ssn=r.ssn); // ut.nneq_ssn ?? 
	self.eq_ssn_flag := if(r.src_is_eq and ssn_is_same,'S','');
	self.en_ssn_flag := if(r.src_is_en and r.en_current_rec_flag=1 and ssn_is_same,'S','');
	self := l;
end;
r3_xx_ssn :=  r2_xx_phone(ssn='') +  
				 join(r2_xx_phone(ssn<>''), 
							bb_ssn,
							left.did=right.did and left.ssn=right.ssn,
							j3_xx_ssn(left,right), local, left outer);

layout_temp j4_xx_dob(layout_temp l, layout_slim r) := transform
	boolean	dob_is_same	:=	 l.dob=0 or (l.dob<>0 and r.dob<>0 and l.dob=r.dob);  // ut.nneq_date ??
	self.eq_dob_flag := 'D';		// if(r.src_is_eq and dob_is_same,'D','');  eq doesn't provide DOB anymore, leave as OK
	self.en_dob_flag := if(r.src_is_en and r.en_current_rec_flag=1 and dob_is_same,'D','');
	self := l;
end;
r4_xx_dob := 	 r3_xx_ssn(dob=0) +
			  	join(r3_xx_ssn(dob<>0), 
							bb_dob,
							left.did=right.did and left.dob=right.dob,		
							j4_xx_dob(left,right), local, left outer);

layout_temp j5_xx_name(layout_temp  l, layout_slim r) := transform
	boolean name_is_same := l.fname=r.fname and 		// ut.Firstname_Match=3 ??
												 (l.mname='' or r.mname='' or l.mname=r.mname) and   // ut.Firstname_Match>=1 ??
													l.lname=r.lname and 
												 (l.name_suffix='' or r.name_suffix='' or l.name_suffix=r.name_suffix); // ut.nneq_suffix /ut.u??
	boolean lname_is_same := l.lname=r.lname;
	self.eq_name_flag := if(r.src_is_eq and name_is_same,'N','');
	self.en_name_flag := if(r.src_is_en and name_is_same,'N','');
	self.eq_lname_flag := if(r.src_is_eq and lname_is_same,'L','');
	self.en_lname_flag := if(r.src_is_en and lname_is_same,'L','');
	self := l;
end;
r5_xx_name := join(r4_xx_dob, 
							bb_name,
							left.did=right.did and left.lname=right.lname,
							j5_xx_name(left,right),local, left outer);
							
layout_temp j6_xx_addr(layout_temp  l, layout_slim r) := transform
	boolean	addr_is_same	:= 	l.prim_range=r.prim_range and
														l.predir=r.predir and
														l.prim_name=r.prim_name and
														l.suffix=r.suffix and
														l.postdir=r.postdir and
														(l.sec_range='' or r.sec_range='' or l.sec_range=r.sec_range) and // ut.nneq_sec ??
														l.city_name=r.city_name and
														l.st=r.st and
														l.zip=r.zip;
	self.eq_addr_flag := if(r.src_is_eq and addr_is_same,'A','');
	self.en_addr_flag := if(r.src_is_en and addr_is_same,'A','');
	self := l;
end;
r6_xx_addr := join(r5_xx_name, 
							bb_addr,
							left.did=right.did and left.city_name=right.city_name and left.prim_name=right.prim_name,
							j6_xx_addr(left,right), local, left outer);
			
r7 := r1_did_not_in_both + r6_xx_addr;


layout_temp to_rollup_jx (layout_temp l, layout_temp r) := transform
	self.en_did_flag		:= if(l.en_did_flag<>'',  l.en_did_flag,  r.en_did_flag);
	self.en_name_flag		:= if(l.en_name_flag<>'', l.en_name_flag, r.en_name_flag);
	self.en_addr_flag		:= if(l.en_addr_flag<>'', l.en_addr_flag, r.en_addr_flag);
	self.en_dob_flag		:= if(l.en_dob_flag<>'',  l.en_dob_flag,  r.en_dob_flag);
	self.en_ssn_flag		:= if(l.en_ssn_flag<>'',  l.en_ssn_flag,  r.en_ssn_flag);
	self.en_phone_flag	:= if(l.en_phone_flag<>'',l.en_phone_flag,r.en_phone_flag);
	self.en_lname_flag	:= if(l.en_lname_flag<>'',l.en_lname_flag,r.en_lname_flag);

	
	self.eq_did_flag		:= if(l.eq_did_flag<>'',  l.eq_did_flag,  r.eq_did_flag);
	self.eq_name_flag		:= if(l.eq_name_flag<>'', l.eq_name_flag, r.eq_name_flag);
	self.eq_addr_flag		:= if(l.eq_addr_flag<>'', l.eq_addr_flag, r.eq_addr_flag);
	self.eq_dob_flag		:= if(l.eq_dob_flag<>'',  l.eq_dob_flag,  r.eq_dob_flag);
	self.eq_ssn_flag		:= if(l.eq_ssn_flag<>'',  l.eq_ssn_flag,  r.eq_ssn_flag);
	self.eq_phone_flag	:= if(l.eq_phone_flag<>'',l.eq_phone_flag,r.eq_phone_flag);
	self.eq_lname_flag	:= if(l.eq_lname_flag<>'',l.eq_lname_flag,r.eq_lname_flag);
	self := l;
	end;
r7_rolled := 
			rollup(
					sort(r7,
 					 except	en_did_flag,en_name_flag,en_addr_flag,en_dob_flag,en_ssn_flag,en_phone_flag,en_lname_flag,
					        eq_did_flag,eq_name_flag,eq_addr_flag,eq_dob_flag,eq_ssn_flag,eq_phone_flag,eq_lname_flag,
									not_in_bureau,
					 local),
 			    to_rollup_jx(left,right),
 					 except	en_did_flag,en_name_flag,en_addr_flag,en_dob_flag,en_ssn_flag,en_phone_flag,en_lname_flag,
					        eq_did_flag,eq_name_flag,eq_addr_flag,eq_dob_flag,eq_ssn_flag,eq_phone_flag,eq_lname_flag,
									not_in_bureau,
					 local);


layout_result := record
	header.layout_header_v2;
	unsigned4 not_in_bureau := 0;
end;

layout_result to_not(layout_temp l) := transform

	string1 not_en_did_flag		:= if(l.en_did_flag<>'','','x');
	string1 not_en_name_flag 	:= if(l.en_name_flag<>'' or l.en_did_flag='','','x');
	string1 not_en_addr_flag 	:= if(l.en_addr_flag<>'' or l.en_did_flag='','','x');
	string1 not_en_dob_flag 	:= if(l.en_dob_flag<>'' or l.en_did_flag='','','x');
	string1 not_en_ssn_flag 	:= if(l.en_ssn_flag<>'' or l.en_did_flag='','','x');
	string1 not_en_phone_flag	:= if(l.en_phone_flag<>'' or l.en_did_flag='','','x');
	string1 not_en_lname_flag	:= if(l.en_lname_flag<>'' or l.en_did_flag='','','x');
	//
	string1 not_eq_did_flag		:= if(l.eq_did_flag<>'','','x');
	string1 not_eq_name_flag 	:= if(l.eq_name_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_addr_flag 	:= if(l.eq_addr_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_dob_flag 	:= if(l.eq_dob_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_ssn_flag 	:= if(l.eq_ssn_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_phone_flag	:= if(l.eq_phone_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_lname_flag	:= if(l.eq_lname_flag<>'' or l.eq_did_flag='','','x');
	//
	self.not_in_bureau	
		:=	 	if(not_en_did_flag<>''  	and l.src='EN',	  header.constants.no_longer_reported.did_not_in_en   ,0b) |
					if(not_en_name_flag<>'' 	and l.src='EN',   header.constants.no_longer_reported.name_not_in_en  ,0b) |
					if(not_en_addr_flag<>'' 	and l.src='EN',   header.constants.no_longer_reported.addr_not_in_en  ,0b) |
					if(not_en_dob_flag<>'' 		and l.src='EN',   header.constants.no_longer_reported.dob_not_in_en   ,0b) |
					if(not_en_ssn_flag<>'' 		and l.src='EN',   header.constants.no_longer_reported.ssn_not_in_en   ,0b) |
					if(not_en_phone_flag<>'' 	and l.src='EN',   header.constants.no_longer_reported.phone_not_in_en ,0b) |
					if(not_en_lname_flag<>'' 	and l.src='EN',   header.constants.no_longer_reported.lname_not_in_en ,0b) |
		  	 	if(not_eq_did_flag<>'' 		and l.src='EQ',	  header.constants.no_longer_reported.did_not_in_eq   ,0b) |
					if(not_eq_name_flag<>'' 	and l.src='EQ',   header.constants.no_longer_reported.name_not_in_eq  ,0b) |
					if(not_eq_addr_flag<>'' 	and l.src='EQ',   header.constants.no_longer_reported.addr_not_in_eq  ,0b) |
					if(not_eq_dob_flag<>'' 		and l.src='EQ',   header.constants.no_longer_reported.dob_not_in_eq   ,0b) |
					if(not_eq_ssn_flag<>'' 		and l.src='EQ',   header.constants.no_longer_reported.ssn_not_in_eq   ,0b) |
					if(not_eq_phone_flag<>'' 	and l.src='EQ',   header.constants.no_longer_reported.phone_not_in_eq ,0b) |
					if(not_eq_lname_flag<>'' 	and l.src='EQ',   header.constants.no_longer_reported.lname_not_in_eq ,0b);
	self := l;
end;

r7_not := project(r7_rolled,to_not(left));

r7_filtered := r7_not(not_in_bureau<>0);

export key_NLR_prod := INDEX (r7_filtered, {did,rid}, {r7_filtered},
  ut.foreign_prod+'thor_data400::key::header_nlr::did.rid_qa');

