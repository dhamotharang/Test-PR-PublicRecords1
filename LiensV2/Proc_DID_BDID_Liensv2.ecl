import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog, mdr,header,TopBusiness_External;

export Proc_DID_BDID_Liensv2(dataset(LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags) ds,string sourcename) := function

file_in := ds;

PreDID_Rec
 :=
  record
	LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags;
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

DID_ADD.Mac_Set_Source_Code(preDID, src_rec, MDR.sourceTools.src_Liens_v2, PreDID_src)

//append DID
matchset :=['A', 'Z','S','P','4'];

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
								 
dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::' + sourcename + '_PostSourceMatch');

preBDID_src	:=	project(dPostSourceMatch, transform(src_rec_BDID, self.source	:=	MDR.sourceTools.src_Liens_v2; self := left;));

myset := ['A', 'N','F','P'];

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
						,source										// Source Â– MDR.sourceTools
						,persistent_record_id			//Source_Record_Id
						,true											//Src_Matching_is_priorty
						);
					
postBDID 		:= 	project(postBDID_src, transform(PreDID_Rec, self := left));
						
post_DID_BDID := postbdid +  postDID;//reformat DID and BDID

//reformat DID and BDID

preDID_rec tBdid(post_DID_BDID L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	self.temp_did := (unsigned6)intformat(L.temp_DID,12,1); // doing this to avoid additional project
	self.temp_bdid := (unsigned6)intformat(L.temp_BDID,12,1); // doing this to avoid additional project commented below
	self := L;
	
	
	end;

file_party_SSN_temp := project(post_DID_BDID, tbdid(left));

//Append SSN 

did_add.MAC_Add_SSN_By_DID(file_party_SSN_temp, temp_did, app_ssn, file_party_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_party_ssn, temp_bdid, app_tax_id, file_party_fein)

LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags tremovetempDID(preDID_rec L) := transform
self := L;
end;

post_append_ssn := project(file_party_fein,tremovetempDID(left));

post_append_ssn_dist := distribute(post_append_ssn,hash(tmsid)); // Distribute full daily file by tmsid

// Sort and Dedup locally

full_sort := sort(post_append_ssn_dist,record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type,local);

// Removed rollup because it is not necessary to do so during full file reDID
			   
retval := full_sort : persist('~thor_data400::persist::Liens::'+ sourcename +'_DID');

return retval;

end;