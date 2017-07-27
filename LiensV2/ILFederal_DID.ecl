////////////////////////////////////////////////////////////////////////
// Attribute 	: ILFederal_DID

// DEPENDENT ON : liensV2.Mapping_ILFDLN_party,
//				  liensv2.Layout_Liens_party,
//				  did_Add.MAC_Match_Flex,
//				  Business_Header_SS.MAC_Add_BDID_FLEX,
//				  liensV2.Layout_liens_party_SSN_bid,
//				  did_add.MAC_Add_SSN_By_DID
//					TopBusiness_External

// PURPOSE	 	: Bid,DID, BDID and append_ssn daily ILFDLN file 
//			      and add to the distributed full file to create
//				  a new persist file.
////////////////////////////////////////////////////////////////////////

import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog,mdr,header,TopBusiness_External;

file_in := liensV2.Mapping_ILFDLN_party;

PreDID_Rec
 :=
  record
	liensv2.Layout_Liens_party_bid;
	qstring34   vendor_id := '';
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	:= 0;
	
  end ;


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

DID_ADD.Mac_Set_Source_Code(preDID, src_rec, MDR.sourceTools.src_Liens_v2, PreDID_src)

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
								 false,MDR.sourceTools.src_Liens_v2,	// watercraft is 'AW' everywhere else
								 TRUE, vendor_id,
								 cname,
								 prim_range,prim_name,sec_range,zip,
								 true,phone,
								 true,tax_id,
								 TRUE, vendor_id);
								 
dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::ILFederal_PostSourceMatch');

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


//reformat DID and BDID

liensV2.Layout_liens_party_bid tBdid(post_DID_BDID L)
 :=
  transform
    self.DID		:=	intformat(L.temp_DID,12,1);
    self.BDID		:=	intformat(L.temp_BDID,12,1);
    
	self                := L;
	
	end;


proj_tbdid := project(post_DID_BDID, tbdid(left));

rec_temp := record
	liensV2.Layout_liens_party_SSN_bid;
	integer8  temp_DID;
	integer8  temp_bdid;
end;

rec_temp tappendSSN(liensV2.Layout_liens_party_bid L) := transform

self := L;
self.temp_did := (unsigned6)L.did;
self.temp_bdid := (unsigned6)L.bdid;
end;

file_party_SSN_temp := project(proj_tbdid,tappendSSN(left)); 

//Append SSN 

did_add.MAC_Add_SSN_By_DID(file_party_SSN_temp, temp_did, app_ssn, file_party_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_party_ssn, temp_bdid, app_tax_id, file_party_fein)

liensV2.Layout_liens_party_ssn_bid tremovetempDID(rec_temp L) := transform
self := L;

end;

post_append_ssn := project(file_party_fein,tremovetempDID(left));

post_append_ssn_dist := distribute(post_append_ssn,hash(tmsid)); // Distribute full daily file by tmsid

// Full File - Distributed

Full_ILFDLN_Party_nondist := dataset('~thor_data400::base::Liens::party::ILFDLN',liensv2.layout_liens_party_SSn_bid,thor);

Full_ILFDLN_Party := distribute(Full_ILFDLN_Party_nondist,hash(tmsid));

// Add Full File and Daily Party File (distributed)

daily_plus_full := post_append_ssn_dist + Full_ILFDLN_Party;

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
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type,local);

liensv2.Layout_liens_party_SSN_bid rollup_records(liensv2.Layout_liens_party_SSN_bid L, Liensv2.Layout_liens_party_SSN_bid R) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;


full_dedup := rollup(full_sort,  rollup_records(left, right),record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, local);


	
export ILFederal_DID := full_dedup :persist('~thor_data400::persist::Liens::ILFederal_DID');



