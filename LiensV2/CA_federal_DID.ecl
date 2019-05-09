////////////////////////////////////////////////////////////////////////
// Attribute 	: CA_FEDERAL_DID

// DEPENDENT ON : liensV2.Mapping_CA_federal_party,
//				  liensv2.Layout_Liens_party,
//				  did_Add.Mac_Match_Flex_V2,
//				  Business_Header_SS.MAC_Add_BDID_FLEX,
//				  liensV2.Layout_liens_party_SSN_bid,
//				  did_add.MAC_Add_SSN_By_DID,
//					TopBusiness_External

// PURPOSE	 	: BID, DID, BDID and append_ssn daily ca_federal file 
//			      and add to the distributed full file to create
//				  a new persist file.
////////////////////////////////////////////////////////////////////////

import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog,mdr,header,TopBusiness_External;

file_in := liensV2.Mapping_CA_federal_party;

PreDID_Rec
 :=
  record
	liensv2.Layout_Liens_party_BIPV2;
	qstring34   vendor_id := '';

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

DID_ADD.Mac_Set_Source_Code(preDID,  src_rec, MDR.sourceTools.src_Liens_v2, PreDID_src);

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
postDID 		:= 	project(postDID_src, transform(PreDID_Rec, self := left));

//append BDID

business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
								 false,temp_BDID,
								 false,MDR.sourceTools.src_Liens_v2,
								 TRUE, vendor_id,
								 cname,
								 prim_range,prim_name,sec_range,zip,
								 true,phone,
								 true,tax_id,
								 TRUE, vendor_id);
								 
dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::CA_federal_PostSourceMatch');

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


//reformat DID and BDID

liensV2.Layout_liens_party_BIPV2 tBdid(post_DID_BDID L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	self := L;
	
	
	end;

proj_tbdid := project(post_DID_BDID, tbdid(left));

//Append SSN 

rec_temp := record
	liensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags;
	integer8  temp_DID;
	integer8  temp_bdid;
end;

rec_temp tappendSSN(liensV2.Layout_liens_party_BIPV2 L) := transform

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

liensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags tremovetempDID(rec_temp L) := transform
self := L;
end;

post_append_ssn := project(file_party_fein,tremovetempDID(left));

// Full File

Full_CA_Party_nondist := dataset('~thor_data400::base::Liens::party::CA_federal',liensv2.Layout_liens_party_SSN_BIPV2_with_LinkFlags,thor);

// Add Full File and Daily Party File

daily_plus_full := distribute((post_append_ssn + Full_CA_Party_nondist),hash(tmsid)); 

full_sort := sort(daily_plus_full,record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type,local);

liensv2.Layout_liens_party_SSN_BIPV2_with_LinkFlags rollup_records(liensv2.Layout_liens_party_SSN_BIPV2_with_LinkFlags L, Liensv2.Layout_liens_party_SSN_BIPV2_with_LinkFlags R) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self.zip4  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.zip4, l.zip4);
		self.cart  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.cart, l.cart);
		self.lot  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.lot, l.lot);
		self.lot_order  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.lot_order, l.lot_order);
		self.dbpc  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.dbpc, l.dbpc);
		self.chk_digit  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.chk_digit, l.chk_digit);
		self.rec_type  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.rec_type, l.rec_type);
		self.geo_lat  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.geo_lat, l.geo_lat);
		self.geo_long  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.geo_long, l.geo_long);
		self.cr_sort_sz  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.cr_sort_sz , l.cr_sort_sz );
		self.err_stat  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.err_stat , l.err_stat );
		self := l;
end;

full_dedup := rollup(full_sort,  rollup_records(left, right),record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, 
			   zip4, cart, lot, lot_order, dbpc, chk_digit, rec_type, geo_lat, geo_long,cr_sort_sz,err_stat,
			   local);
	
export CA_federal_DID := full_dedup : persist('~thor_data400::persist::Liens::CA_federal_DID');