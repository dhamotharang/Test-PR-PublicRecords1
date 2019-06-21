import doxie,header,dx_header,header_quick,experiancred,ut,TransunionCred,doxie_build;

hdr_in	:= distribute(Header.file_headers(src in ['EQ','EN'] )
										+ doxie_build.file_header_building(src='TN')
										,hash(did));
eq_in 	:= distribute(header_quick.file_header_quick_skip_PID(src in ['WH', 'QH'],did>0)
										,hash(did));
en_in   := distribute(Experiancred.files.base_file_out(did>0, current_experian_pin=1,(delete_flag=0 or (delete_flag<>0 and suppression_code not in [41,50,99])))
										,hash(did));
tn_in 	:= distribute(TransunionCred.Files.Base(did>0,~IsDelete,IsUpdating)
										,hash(did));

layout_temp := record
	string1 eq_did_flag		:= '';
	string1 eq_name_flag	:= '';
	string1 eq_addr_flag	:= '';
	string1 eq_dob_flag		:= '';
	string1 eq_phone_flag	:= '';
	string1 eq_ssn_flag		:= '';
	string1 eq_lname_flag := '';

	string1 en_did_flag		:= '';
	string1 en_name_flag	:= '';
	string1 en_addr_flag	:= '';
	string1 en_dob_flag		:= '';
	string1 en_ssn_flag		:= '';
	string1 en_phone_flag	:= '';
	string1 en_lname_flag := '';

	string1 tn_did_flag		:= '';
	string1 tn_name_flag	:= '';
	string1 tn_addr_flag	:= '';
	string1 tn_dob_flag		:= '';
	string1 tn_ssn_flag		:= '';
	string1 tn_phone_flag	:= '';
	string1 tn_lname_flag := '';

	dx_header.layout_header;
end;
	
layout_slim := record
	unsigned6    did;
	string2      src;
	string18    vendor_id;

	boolean 		 src_is_eq:=false;
	boolean			 src_is_en:=false;
	boolean			 src_is_tn:=false;
	unsigned		 en_current_rec_flag:=0; 	// for "current" ssn and dob from experian files

	qstring10    phone;
	qstring9     ssn;
	integer4     dob;

	qstring20    fname;
	qstring20    mname;
	qstring20    lname;
	qstring5     name_suffix;

	qstring10    prim_range;
	string2      predir;
	qstring28    prim_name;
	qstring4     suffix;
	string2      postdir;
	qstring8     sec_range;
	qstring25    city_name;
	string2      st;
	qstring5     zip;

end;


hdr_r := hdr_in; // take all input records for now without knowing more

fn_rollem(dataset(layout_temp) ds) := function

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

	self.tn_did_flag		:= if(l.tn_did_flag<>'',  l.tn_did_flag,  r.tn_did_flag);
	self.tn_name_flag		:= if(l.tn_name_flag<>'', l.tn_name_flag, r.tn_name_flag);
	self.tn_addr_flag		:= if(l.tn_addr_flag<>'', l.tn_addr_flag, r.tn_addr_flag);
	self.tn_dob_flag		:= if(l.tn_dob_flag<>'',  l.tn_dob_flag,  r.tn_dob_flag);
	self.tn_ssn_flag		:= if(l.tn_ssn_flag<>'',  l.tn_ssn_flag,  r.tn_ssn_flag);
	self.tn_phone_flag		:= if(l.tn_phone_flag<>'',l.tn_phone_flag,r.tn_phone_flag);
	self.tn_lname_flag		:= if(l.tn_lname_flag<>'',l.tn_lname_flag,r.tn_lname_flag);
	
	self := l;
end;
	
return
	rollup(
		sort(ds,
			 except	en_did_flag,en_name_flag,en_addr_flag,en_dob_flag,en_ssn_flag,en_phone_flag,en_lname_flag,
			        eq_did_flag,eq_name_flag,eq_addr_flag,eq_dob_flag,eq_ssn_flag,eq_phone_flag,eq_lname_flag,
								tn_did_flag,tn_name_flag,tn_addr_flag,tn_dob_flag,tn_ssn_flag,tn_phone_flag,tn_lname_flag,
			 local),
	    to_rollup_jx(left,right),
			 except	en_did_flag,en_name_flag,en_addr_flag,en_dob_flag,en_ssn_flag,en_phone_flag,en_lname_flag,
			        eq_did_flag,eq_name_flag,eq_addr_flag,eq_dob_flag,eq_ssn_flag,eq_phone_flag,eq_lname_flag,
								tn_did_flag,tn_name_flag,tn_addr_flag,tn_dob_flag,tn_ssn_flag,tn_phone_flag,tn_lname_flag,
			 local);
end;


layout_slim to_slim_eq(eq_in l) := transform
	self.src_is_eq:=true;
	self.src:='EQ';
	self := l;
end;
eq_s := project(eq_in,to_slim_eq(left));

layout_slim to_slim_en(en_in l) := transform
	self.src_is_en:=true;
	self.src:='EN';
	self.vendor_id:=l.Encrypted_Experian_PIN;
	self.en_current_rec_flag := l.current_rec_flag;	// added to allow filter for current SSN & DOB in incremental update EN data
	self.phone := l.telephone;
	self.ssn := l.social_security_number;
	self.dob := (integer) l.date_of_birth;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name;
	self := l;
end;
en_s := project(en_in,to_slim_en(left));

layout_slim to_slim_tn(tn_in l) := transform
	self.src_is_tn:=true;
	self.src:='TN';
	self.vendor_id:=l.party_id;
	self.dob := (integer) l.date_of_birth;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name;
	self := l;
end;
tn_s := project(tn_in,to_slim_tn(left));

layout_slim to_rs(layout_slim l, layout_slim r) := transform
	self.src_is_eq := if(l.src_is_eq, l.src_is_eq, r.src_is_eq);
	self.src_is_en := if(l.src_is_en, l.src_is_en, r.src_is_en);
	self.src_is_tn := if(l.src_is_tn, l.src_is_tn, r.src_is_tn);
	self.en_current_rec_flag := if(l.en_current_rec_flag<>0, l.en_current_rec_flag, r.en_current_rec_flag);
	self := l;
	end;

bb_did	:= rollup(
					sort(eq_s+en_s+tn_s,
					 did,local),
				 	to_rs(left,right),
					 did,local);

bb_name := rollup(
					sort(eq_s+en_s+tn_s,
					 did,lname,fname,mname,name_suffix,local),
				 	to_rs(left,right),
					 did,lname,fname,mname,name_suffix,local);
					 
bb_addr := rollup(
					sort(eq_s+en_s+tn_s,
					 did,prim_range,predir,prim_name,suffix,postdir,sec_range, city_name,st,zip,local),
				 	to_rs(left,right),
					 did,prim_range,predir,prim_name,suffix,postdir,sec_range, city_name,st,zip,local);

bb_dob := rollup(
					sort(eq_s(dob<>0)+en_s(dob<>0)+tn_s(dob<>0),
					 did,dob,en_current_rec_flag,local),
				 	to_rs(left,right),
					 did,dob,en_current_rec_flag,local);
					 
bb_ssn := rollup(
					sort(eq_s(ssn<>'')+en_s(ssn<>'')+tn_s(ssn<>''),
					 did,ssn,en_current_rec_flag,local),
				 	to_rs(left,right),
					 did,ssn,en_current_rec_flag,local);
					
bb_phone := rollup(
					sort(eq_s(phone<>'')+en_s(phone<>'')+tn_s(phone<>''),
					 did,phone,local),
				 	to_rs(left,right),
					 did,phone,local);

bb_lname := rollup(
					sort(eq_s(lname<>'')+en_s(lname<>'')+tn_s(lname<>''),
					 did,lname,local),
				 	to_rs(left,right),
					 did,lname,local);


layout_temp j1_xx_did(hdr_r l, layout_slim r) := transform 
  boolean did_is_same := l.did=r.did;
	self.eq_did_flag := if(r.src_is_eq and did_is_same,'X','');
	self.en_did_flag := if(r.src_is_en and did_is_same,'X','');
	self.tn_did_flag := if(r.src_is_tn and did_is_same,'X','');
	self.eq_dob_flag := if(l.dob=0,'D','');
	self.en_dob_flag := if(l.dob=0,'D','');
	self.tn_dob_flag := if(l.dob=0,'D','');
	self.eq_ssn_flag := if(l.ssn='','S','');
	self.en_ssn_flag := if(l.ssn='','S','');
	self.tn_ssn_flag := if(l.ssn='','S','');
	self.eq_phone_flag := 'P'; // if(l.phone='','P','');	// all phones are ok 6/24/2010
	self.en_phone_flag := 'P'; // if(l.phone='','P','');	// all phones are ok 6/24/2010
	self.tn_phone_flag := 'P';
	self.eq_lname_flag := if(l.lname='','L','');
	self.en_lname_flag := if(l.lname='','L','');
	self.tn_lname_flag := if(l.lname='','L','');
	self := l;
end;
r1_xx_did := join(hdr_r, 
						bb_did,
						left.did=right.did,
						j1_xx_did(left,right),local,left outer);

// both now mean any ($74029)
r1_did_not_in_both := r1_xx_did(eq_did_flag='', en_did_flag='', tn_did_flag='');	// these can be skipped for subsequent joins and added at end;

r1_to_do 	:= r1_xx_did(eq_did_flag='X' or en_did_flag='X' or tn_did_flag='X');	

r2_xx_phone := r1_to_do;

layout_temp j3_xx_ssn(layout_temp l, layout_slim r) := transform
	boolean	ssn_is_same		:=	l.ssn='' or (l.ssn<>'' and r.ssn<>'' and l.ssn=r.ssn); // ut.nneq_ssn ?? 
	self.eq_ssn_flag := if(r.src_is_eq and ssn_is_same,'S','');
	self.en_ssn_flag := if(r.src_is_en and r.en_current_rec_flag=1 and ssn_is_same,'S','');
	self.tn_ssn_flag := if(r.src_is_tn and ssn_is_same,'S','');
	self := l;
end;
r3_xx_ssn := fn_rollem(
									r2_xx_phone(ssn='') +  
								 join(r2_xx_phone(ssn<>''), 
											bb_ssn,
											left.did=right.did and left.ssn=right.ssn,
											j3_xx_ssn(left,right), local, left outer)
									);

layout_temp j4_xx_dob(layout_temp l, layout_slim r) := transform
	boolean	dob_is_same	:=	 l.dob=0 or (l.dob<>0 and r.dob<>0 and l.dob=r.dob);  // ut.nneq_date ??
	self.eq_dob_flag := 'D';		// if(r.src_is_eq and dob_is_same,'D','');  eq doesn't provide DOB anymore, leave as OK
	self.en_dob_flag := if(r.src_is_en and r.en_current_rec_flag=1 and dob_is_same,'D','');
	self.tn_dob_flag := if(r.src_is_tn and dob_is_same,'D','');
	self := l;
end;
r4_xx_dob := fn_rollem(
										r3_xx_ssn(dob=0) +
										join(r3_xx_ssn(dob<>0), 
												bb_dob,
												left.did=right.did and left.dob=right.dob,		
												j4_xx_dob(left,right), local, left outer)
									);

layout_temp j5_xx_name(layout_temp  l, layout_slim r) := transform
	boolean name_is_same := l.fname=r.fname and
												 (l.mname='' or r.mname='' or l.mname=r.mname) and
													l.lname=r.lname and 
												 (l.name_suffix='' or r.name_suffix='' or l.name_suffix=r.name_suffix);
	boolean lname_is_same := l.lname=r.lname;
	self.eq_name_flag := if(r.src_is_eq and name_is_same,'N','');
	self.en_name_flag := if(r.src_is_en and name_is_same,'N','');
	self.tn_name_flag := if(r.src_is_tn and name_is_same,'N','');
	self.eq_lname_flag := if(r.src_is_eq and lname_is_same,'L','');
	self.en_lname_flag := if(r.src_is_en and lname_is_same,'L','');
	self.tn_lname_flag := if(r.src_is_tn and lname_is_same,'L','');
	self := l;
end;
r5_xx_name := fn_rollem(
									join(r4_xx_dob, 
											bb_name,
											left.did=right.did and left.lname=right.lname,
											j5_xx_name(left,right),local, left outer)
									);

d:=distribute(Mod_CreditBureau_address.suppressed,hash(src,trim(vendor_id),addr));

ht:=dedup(distribute(table(r5_xx_name,{r5_xx_name,string72 addr:=stringlib.stringcleanspaces(
									trim(prim_range)
								+' '+trim(predir)
								+' '+trim(prim_name)
								+' '+trim(suffix)
								+' '+trim(postdir)
								+' '+trim(unit_desig)
								+' '+trim(sec_range)
								)}),hash(src,trim(vendor_id),addr)),record,all,local);

r6_xx_addr:=join(ht,d
		,left.src=right.src
		and left.vendor_id=right.vendor_id
		and left.addr=right.addr
		,transform({layout_temp,{d} anlr}
			,self.eq_addr_flag := if(left.src='EQ' and right.src='','A',if(left.src='EQ','','A'))
			,self.en_addr_flag := if(left.src='EN' and right.src='','A',if(left.src='EN','','A'))
			,self.tn_addr_flag := if(left.src='TN' and right.src='','A',if(left.src='TN','','A'))
			,self.anlr:=right
			,self:=left
			)
		,left outer
		,local
		);

r7 := fn_rollem(distribute(r1_did_not_in_both + project(r6_xx_addr,layout_temp),hash(did)));

layout_result := record
	dx_header.layout_header;
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

	string1 not_eq_did_flag		:= if(l.eq_did_flag<>'','','x');
	string1 not_eq_name_flag 	:= if(l.eq_name_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_addr_flag 	:= if(l.eq_addr_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_dob_flag 	:= if(l.eq_dob_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_ssn_flag 	:= if(l.eq_ssn_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_phone_flag	:= if(l.eq_phone_flag<>'' or l.eq_did_flag='','','x');
	string1 not_eq_lname_flag	:= if(l.eq_lname_flag<>'' or l.eq_did_flag='','','x');

	string1 not_tn_did_flag		:= if(l.tn_did_flag<>'','','x');
	string1 not_tn_name_flag 	:= if(l.tn_name_flag<>'' or l.tn_did_flag='','','x');
	string1 not_tn_addr_flag 	:= if(l.tn_addr_flag<>'' or l.tn_did_flag='','','x');
	string1 not_tn_dob_flag 	:= if(l.tn_dob_flag<>'' or l.tn_did_flag='','','x');
	string1 not_tn_ssn_flag 	:= if(l.tn_ssn_flag<>'' or l.tn_did_flag='','','x');
	string1 not_tn_phone_flag	:= if(l.tn_phone_flag<>'' or l.tn_did_flag='','','x');
	string1 not_tn_lname_flag	:= if(l.tn_lname_flag<>'' or l.tn_did_flag='','','x');

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
					if(not_eq_lname_flag<>'' 	and l.src='EQ',   header.constants.no_longer_reported.lname_not_in_eq ,0b) |

		  	 	if(not_tn_did_flag<>'' 		and l.src='TN',	  header.constants.no_longer_reported.did_not_in_tn   ,0b) |
					if(not_tn_name_flag<>'' 	and l.src='TN',   header.constants.no_longer_reported.name_not_in_tn  ,0b) |
					if(not_tn_addr_flag<>'' 	and l.src='TN',   header.constants.no_longer_reported.addr_not_in_tn  ,0b) |
					if(not_tn_dob_flag<>'' 		and l.src='TN',   header.constants.no_longer_reported.dob_not_in_tn   ,0b) |
					if(not_tn_ssn_flag<>'' 		and l.src='TN',   header.constants.no_longer_reported.ssn_not_in_tn   ,0b) |
					if(not_tn_phone_flag<>'' 	and l.src='TN',   header.constants.no_longer_reported.phone_not_in_tn ,0b) |
					if(not_tn_lname_flag<>'' 	and l.src='TN',   header.constants.no_longer_reported.lname_not_in_tn ,0b) 
				;
	self := l;
end;

r7_not := project(r7,to_not(left));

r7_filtered := r7_not(not_in_bureau<>0);

EXPORT Prep_NLR_key := header.fn_persistent_record_ID(r7_filtered);