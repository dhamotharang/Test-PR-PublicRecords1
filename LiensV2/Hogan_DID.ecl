////////////////////////////////////////////////////////////////////////
// Attribute 	: HOGAN_DID

// DEPENDENT ON : liensV2.Mapping_Hogan_party,
//				  liensv2.Layout_Liens_party,
//				  did_Add.MAC_Match_Flex,
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
	LiensV2.layout_liens_party_for_hogan_bid;
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

DID_ADD.Mac_Set_Source_Code(preDID, src_rec, 'L2', PreDID_src)

//append DID
matchset :=['A', 'Z', 'S', 'P'];

did_Add.MAC_Match_Flex(PreDID_src, matchset,
	 ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone,
	 temp_did,   			
	 src_rec, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID_src, true, src)
	 
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

dWithSourceMatch		:=	dPostSourceMatchPersist(temp_BDID != 0);
dWithNoSourceMatch		:=	dPostSourceMatchPersist(temp_BDID = 0);

myset := ['A', 'N', 'F', 'P'];

Business_Header_SS.MAC_Add_BDID_FLEX(dWithNoSourceMatch,myset,
						cname,
                        prim_range,prim_name,zip,sec_range,
						st,
						phone,tax_id,
						temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid);

						
post_DID_BDID := postbdid +  postDID + dWithSourceMatch;//reformat DID and BDID

//inlude flag

temp_rec := record
string1 ADDDELFLAG := '';
liensV2.Layout_liens_party_for_hogan;
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
	liensV2.Layout_liens_party_SSN_for_hogan_bid;
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

file_party_fein_delete := file_party_fein(ADDDELFLAG = 'D');

// FULL FILE 
/*cng change delete pull from the file with orig_rmids not deduped*/
Full_hogan_Party_nondist := LiensV2.file_Hogan_party_full_bid;


liensV2.Layout_liens_party_ssn_for_hogan_bid tjoin(Full_hogan_Party_nondist  L, file_party_fein_delete  R) := transform

self := L ;
end;

// REMOVES DELETE RECORDS FROM FULL BASE FILE 

Full_hogan_remove_Delete:= join(Full_hogan_Party_nondist, file_party_fein_delete , left.orig_rmsid = right.orig_rmsid and left.tmsid = right.tmsid,
                                                                  tjoin(left,right),left only);


Full_Hogan_Party := distribute(Full_hogan_remove_Delete,hash(tmsid));

// REFORMAT TO PARTY SSN LAYOUT

liensV2.Layout_liens_party_ssn_for_hogan_bid tremovetempDID(rec_temp L) := transform  
self := L;
end;

hogan_party_update := distribute(project(file_party_fein_adds,tremovetempDID(left)),hash(tmsid));

// Add Full File and Daily Party File (distributed)

daily_plus_full := Full_hogan_Party  + hogan_party_update ;

	//** BID Macro call
TopBusiness_External.MAC_External_BID(
	 daily_plus_full											// The input file to have BIDs appended
	,postBID												// The output file to write to
	,bid						// The field into which the BID should be populated
	,bid_score				// The field into which the BID score should be populated
	, MDR.sourceTools.src_Liens_v2						// The field in which the source value is populated
	,trim(tmsid,left,right)			// The field in which the source_docid value is populated
	,name_type[1] + intformat(hash32(cname,orig_address1,orig_address2,orig_city,orig_state,orig_zip5) % 1000000000,9,1)			// The field in which the source_party value is populated
	,cname			// The field in which the company_name value is populated
	,zip					// The field in which the ZIP value is populated
	,prim_name			// The field in which the prim_name value is populated
	,prim_range				// The field in which the prim_range value is populated
	,tax_id						// The field in which the FEIN value is populated
	,phone						// The field in which the phone value is populated
	,false		// Do we want to return a BID score at all?
) ;

// Sort and Dedup locally

full_sort := sort(postBID,record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, orig_rmsid,local);

/*cng change output file with orig_rmids not deduped*/
output(full_sort,,'~thor_data400::base::liens::party::Hogan_full_temp', overwrite);

/*cng change fix bad ssn rollups*/
liensv2.Layout_liens_party_SSN_for_hogan_bid rollup_records(liensv2.Layout_liens_party_SSN_for_hogan_bid L, Liensv2.Layout_liens_party_SSN_for_hogan_bid R) := transform
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
