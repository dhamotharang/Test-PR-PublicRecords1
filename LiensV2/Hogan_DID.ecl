////////////////////////////////////////////////////////////////////////
// Attribute 	: HOGAN_DID

// DEPENDENT ON : liensV2.Mapping_Hogan_party,
//				  liensv2.Layout_Liens_party,
//				  did_Add.Mac_Match_Flex_V2,
//				  Business_Header_SS.MAC_Add_BDID_FLEX,
//				  liensV2.Layout_liens_party_SSN,
//				  did_add.MAC_Add_SSN_By_DID
//					TopBusiness_External

// PURPOSE	 	: BId,DID, BDID and append_ssn daily Hogan file 
//			      and add to the distributed full file to create
//				  a new persist file.
////////////////////////////////////////////////////////////////////////

import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog,mdr,header,TopBusiness_External;

file_in := liensV2.Mapping_Hogan_party;

PreDID_Rec
 :=
  record
  
    string1 ADDDELFLAG := '';
	qstring34   vendor_id := '';
	LiensV2.layout_liens_party_for_hogan_BIPV2;
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

DID_ADD.Mac_Set_Source_Code(preDID, src_rec, 'L2', PreDID_src)

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
								 false,'L2',	// watercraft is 'AW' everywhere else
								 TRUE, vendor_id,
								 cname,
								 prim_range,prim_name,sec_range,zip,
								 true,phone,
								 true,tax_id,
								 TRUE, vendor_id);
								 
dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::Hogan_PostSourceMatch');

preBDID_src	:=	project(dPostSourceMatch, transform(src_rec_BDID, self.source	:=	'L2'; self := left;));

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
liensV2.Layout_liens_party_for_hogan_BIPV2;
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
		liensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags;
		integer8  temp_DID;
		integer8  temp_bdid;
end;

rec_temp tappendSSN(temp_rec L) := transform

self := L;
self.temp_did := (unsigned6)L.did;
self.temp_bdid := (unsigned6)L.bdid;
end;

file_party_SSN_temp := project(proj_tbdid,tappendSSN(left)); 

//Append SSN 

did_add.MAC_Add_SSN_By_DID(file_party_SSN_temp, temp_did, app_ssn, file_party_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_party_ssn, temp_bdid, app_tax_id, file_party_fein)

// FILTER CHANGE,ADD RECORDS

file_party_fein_adds :=  file_party_fein(ADDDELFLAG != 'D'); 

// FILTER DELETE RECORDS

file_party_fein_delete := DEDUP(SORT(file_party_fein(ADDDELFLAG in ['C','D']),orig_rmsid),orig_rmsid); //DF-29287 delete update prev record

// FULL FILE 
/*cng change delete pull from the file with orig_rmids not deduped*/
Full_hogan_Party_nondist := LiensV2.file_Hogan_party_full;


liensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags tjoin(Full_hogan_Party_nondist  L, file_party_fein_delete  R) := transform

self := L ;
end;

// REMOVES DELETE RECORDS FROM FULL BASE FILE 

Full_hogan_remove_Delete	:=	JOIN(
																DISTRIBUTE(Full_hogan_Party_nondist,HASH(orig_rmsid)), 
																DISTRIBUTE(file_party_fein_delete,HASH(orig_rmsid)), 
																	LEFT.orig_rmsid	=	RIGHT.orig_rmsid,
																tjoin(LEFT,RIGHT),
																LEFT ONLY,
																LOCAL,
																LOOKUP
															);


// REFORMAT TO PARTY SSN LAYOUT

liensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags tremovetempDID(rec_temp L) := transform  
self := L;
end;

hogan_party_update := project(file_party_fein_adds,tremovetempDID(left));

// Add Full File and Daily Party File (distributed)

daily_plus_full := distribute((Full_hogan_remove_Delete  + hogan_party_update),hash(tmsid));

// Sort and Dedup locally
//DF-27482
full_sort := sort(daily_plus_full,tmsid,rmsid,bCBFlag, eviction,orig_full_debtorname, orig_name ,orig_lname,orig_fname,orig_mname,orig_suffix,DOB,
tax_id,ssn,title,fname,mname,lname,name_suffix,name_score,cname,orig_address1,orig_address2 ,orig_city ,orig_state ,orig_zip5 ,orig_zip4,orig_county,orig_country,
prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,phone,DID,BDID,persistent_record_id, TMSID_old,RMSID_old,global_sid,record_sid,app_SSN ,app_tax_id,DotID,DotScore,DotWeight,
EmpID,EmpScore,EmpWeight,POWID,POWScore,POWWeight,ProxID,ProxScore,ProxWeight,SELEID,SELEScore,SELEWeight,OrgID,OrgScore,OrgWeight,UltID,UltScore,
UltWeight,xadl2_keys_used,xadl2_keys_desc,xadl2_weight,xadl2_Score,xadl2_distance,xadl2_matches,xadl2_matches_desc,-Date_Vendor_Last_Reported,-orig_rmsid,local);
//DF-27482
// full_sort := sort(daily_plus_full,record,except Date_First_Seen, Date_Last_Seen, 
			   // Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, orig_rmsid,local);

/*cng change output file with orig_rmids not deduped*/
output(full_sort,,'~thor_data400::base::liens::party::Hogan_full_temp', overwrite);

/*cng change fix bad ssn rollups*/
liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags rollup_records(liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags L, Liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags R) := transform
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
				record,except Date_First_Seen, Date_Last_Seen, Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, orig_rmsid, local) 
				;

export Hogan_DID := full_dedup : persist('~thor_data400::persist::Liens::Hogan_DID');
