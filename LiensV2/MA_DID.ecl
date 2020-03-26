////////////////////////////////////////////////////////////////////////
// Attribute 	: MA_DID

// DEPENDENT ON : liensV2.Mapping_MA_party,
//				  did_Add.Mac_Match_Flex_V2,
//				  Business_Header_SS.MAC_Add_BDID_FLEX,
//				  did_add.MAC_Add_SSN_By_DID,

// PURPOSE	 	: DID, BDID and append_ssn daily Hogan file 
//			      and add to the distributed full file to create
//				  a new persist file.
////////////////////////////////////////////////////////////////////////

import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog, mdr, header,TopBusiness_External;

file_in := liensV2.Mapping_MA_party;

PreDID_Rec
 :=
  record
  
    string1 ADDDELFLAG := '';
	qstring34   vendor_id := '';
	liensv2.Layout_Liens_party_BIPV2;
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	    := 0;
	
	
  end
 ;

PreDID_Rec taddDID(file_in L)
 :=
  transform
	self			:=	L;
  end
 ;

Prefile	:= project(file_in,taddDID(left));

preDID  := prefile(cname  = '');
preBDID := prefile(cname <> '');

//append src
src_rec := record
header_slimsort.Layout_Source;
PreDID_Rec;
end;

src_rec_BDID := record
string2 source;
PreDID_Rec;
end;

DID_ADD.Mac_Set_Source_Code(preDID, src_rec, MDR.sourceTools.src_Liens_v2, PreDID_src)

//append DID
matchset :=['A', 'Z', 'S', 'P'];

did_Add.Mac_Match_Flex_V2(
	PreDID_src,				//	infile
	matchset,					//	matchset
	ssn,							//	ssn_field
	'',								//	dob_field
	fname,						//	fname_field
	mname,						//	mname_field
	lname,						//	lname_field
	name_suffix,			//	suffix_field
	prim_range,				//	prange_field
	prim_name,				//	pname_field
	sec_range,				//	srange_field
	zip,							//	zip_field
	st,								//	state_field
	phone,						//	phone_field
	temp_did,					//	DID_field
	src_rec,					//	outrec
	FALSE,						//	bool_outrec_has_score
	did_score_field,	//	DID_Score_field
	75,								//	low_score_threshold
	postDID_src,			//	outfile
	TRUE,							//	bool_infile_has_name_source
	src,							//	src_field
	,									//	bool_outrec_has_indiv_scores
	,									//	score_n_field
	,									//	bool_clean_addr
	,									//	predir_field
	,									//	addr_suffix_field
	,									//	postdir_field
	,									//	udesig_field
	,									//	city_field
	,									//	zip4_field
	TRUE,							//	bool_switch_priority
	,									//	weight_threshold
	,									//	distance
	FALSE							//	segmentation
);

//remove src
postDID := project(postDID_src, transform(PreDID_Rec, self := left));

//append BDID

business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
								 false,temp_BDID,
								 false,MDR.sourceTools.src_Liens_v2,	// watercraft is 'AW' everywhere else
								 TRUE, vendor_id,
								 cname,
								 prim_range,prim_name,sec_range,zip,
								 true,phone,
								 true,tax_id,
								 TRUE, vendor_id);
								 
dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::MA_PostSourceMatch');

preBDID_src	:=	project(dPostSourceMatch, transform(src_rec_BDID, self.source	:=	MDR.sourceTools.src_Liens_v2; self := left;));

myset := ['A', 'N', 'F', 'P'];

Business_Header_SS.MAC_Add_BDID_FLEX(preBDID_src,myset,
						cname,
            prim_range,prim_name,zip,sec_range,
						st,
						phone,tax_id,
						temp_bdid,
						src_rec_BDID,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid_src
						,													// default threshold
						,													// use prod version of superfiles
						,													// default is to hit prod from dataland, and on prod hit prod.
						,BIPV2.xlink_version_set 	// Create BIP Keys only
						,   											// Url
						,													// Email
						,p_City_name							// City
						,fname										// fname
						,mname										// mname
						,lname										// lname
						,													// Contact_SSN
						,source										// Source Ã‚â€“ MDR.sourceTools
						,persistent_record_id			//Source_Record_Id
						,true											//Src_Matching_is_priorty
						);
						
postBDID 		:= 	project(postBDID_src, transform(PreDID_Rec, self := left));
						
post_DID_BDID := postbdid +  postDID;//reformat DID and BDID

//inlude flag

temp_rec := record
string1 ADDDELFLAG := '';
liensv2.Layout_Liens_party_BIPV2;
end;

temp_rec tBdid(post_DID_BDID L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	
	self := L;
	
	
	end;

proj_tbdid := project(post_DID_BDID, tbdid(left));


rec_temp := record
    string1 ADDDELFLAG := '';
	liensv2.Layout_Liens_party_SSN_BIPV2_with_LinkFlags;
	integer8  temp_DID;
	integer8  temp_bdid;
end;

rec_temp tappendSSN(temp_rec L) := transform

self := L;
self.temp_did := (unsigned6)L.did;
self.temp_bdid := (unsigned6)L.bdid;
self := [];
end;

file_party_SSN_temp := project(proj_tbdid,tappendSSN(left)); 

//Append SSN 

did_add.MAC_Add_SSN_By_DID(file_party_SSN_temp, temp_did, app_ssn, file_party_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_party_ssn, temp_bdid, app_tax_id, file_party_fein)

liensv2.Layout_Liens_party_SSN_BIPV2_with_LinkFlags tremovetempDID(rec_temp L) := transform  
self := L;
end;

MA_party_update := distribute(project(file_party_ssn,tremovetempDID(left)),hash(tmsid));

// Add Full File and Daily Party File (distributed)

daily_plus_full := MA_party_update ;

full_sort := sort(daily_plus_full,record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type,local);

/*cng change fix bad ssn rollups*/
liensv2.Layout_Liens_party_SSN_BIPV2_with_LinkFlags rollup_records(liensv2.Layout_Liens_party_SSN_BIPV2_with_LinkFlags L, liensv2.Layout_Liens_party_SSN_BIPV2_with_LinkFlags R) := transform
		self.ssn := if(r.ssn = '', l.ssn, if(l.ssn > r.ssn and stringlib.stringfind(l.ssn[6..9], r.ssn[6..9], 1) > 0, l.ssn, r.ssn));
		self.did := if(r.ssn = '', l.did, if(l.ssn > r.ssn and stringlib.stringfind(l.ssn[6..9], r.ssn[6..9], 1) > 0, l.did, r.did));
		self.bdid := if(r.ssn = '', l.bdid, if(l.ssn > r.ssn and stringlib.stringfind(l.ssn[6..9], r.ssn[6..9], 1) > 0, l.bdid, r.bdid));
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

////////////////ROLLS UP REGARDLESS OF ORIG_RMSID. UNIQUE ORIG_RMSIDs LOST
full_rollup := rollup(full_sort, 
				left.tmsid = right.tmsid and
				left.rmsid = right.rmsid and
				left.orig_full_debtorname = right.orig_full_debtorname and
				left.orig_name = right.orig_name and
				left.orig_lname = right.orig_lname and
				left.orig_fname = right.orig_fname and
				left.orig_mname = right.orig_mname and
				left.orig_suffix = right.orig_suffix and
				left.tax_id = right.tax_id and
				left.ssn <> right.ssn and 
				((left.ssn[1..5]='00000' or right.ssn[1..5]='00000') or (left.ssn[1..5]='' or right.ssn[1..5]='')) and
				left.cname = right.cname and
				left.orig_address1 = right.orig_address1 and
				left.orig_address2 = right.orig_address2 and
				left.orig_city = right.orig_city and
				left.orig_state = right.orig_state and
				left.orig_zip5 = right.orig_zip5 and
				left.orig_zip4 = right.orig_zip4 and
				left.orig_county = right.orig_county and
				left.orig_country = right.orig_country and
				left.phone = right.phone, rollup_records(left, right), local);

full_dedup := rollup(full_rollup, rollup_records(left, right), 
				record,except Date_First_Seen, Date_Last_Seen, Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type,local) 
				;

export MA_DID := full_dedup : persist('~thor_data400::persist::Liens::MA_DID');
