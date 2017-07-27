////////////////////////////////////////////////////////////////////////
// Attribute 	: Service_Abstract_DID

// DEPENDENT ON : liensV2.Mapping_Service_Abstract_party,
//				  liensv2.Layout_Liens_party_bid,
//				  did_Add.MAC_Match_Flex,
//				  Business_Header_SS.MAC_Add_BDID_FLEX,
//				  liensV2.Layout_liens_party_ssn_bid,
//				  did_add.MAC_Add_SSN_By_DID,TopBusiness_External

// PURPOSE	 	: BID,DID, BDID and append_ssn daily service_abstract file 
//			      and add to the distributed full file to create
//				  a new persist file.
////////////////////////////////////////////////////////////////////////

import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog,TopBusiness_External;

file_in := LiensV2.Mapping_Service_Abstract_Party;

PreDID_Rec
 :=
  record
	liensv2.Layout_Liens_party_bid;
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	    := 0;
	
  end
  ;
 

PreDID_Rec taddDID(file_in L)
 :=
  transform
	
	self			:=	L;
  end ;
 

Prefile	:= project(file_in,taddDID(left));

preDID  := prefile(cname  = '');
preBDID := prefile(cname <> '');

//append DID 
matchset :=['A', 'z', 'S', 'P'];

did_Add.MAC_Match_Flex(PreDID, matchset,
	 ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone,
	 temp_did,   			
	 PreDID_Rec, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID)

//append BDID

myset := ['A', 'F', 'P'];

Business_Header_SS.MAC_Add_BDID_FLEX(preBDID,myset,
						cname,
                        prim_range,prim_name,zip,sec_range,
						st,
						phone,tax_id,
						temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid);
						

					
post_DID_BDID := postbdid +  postDID;//reformat DID and BDID

liensv2.Layout_Liens_party_bid tBdid(post_DID_BDID L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	
	self := L;

	end;

proj_tbdid := project(post_DID_BDID, tbdid(left));

rec_temp := record
	liensV2.Layout_liens_party_ssn_bid;
	integer8  temp_DID;
	integer8  temp_bdid;
end;

rec_temp tappendSSN(liensv2.Layout_Liens_party_bid L) := transform

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

Full_SA_Party_nondist := dataset('~thor_data400::base::Liens::party::SA',liensV2.Layout_liens_party_ssn_bid,thor);

Full_SA_Party := distribute(Full_SA_Party_nondist,hash(tmsid));

// Add Full File and Daily Party File (distributed)

//daily_plus_full := post_append_ssn_dist + Full_SA_Party;
daily_plus_full := post_append_ssn_dist ; 

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

liensV2.Layout_liens_party_ssn_bid rollup_records(liensV2.Layout_liens_party_ssn_bid L, liensV2.Layout_liens_party_ssn_bid R) := transform
		self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
		self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;


full_dedup := rollup(full_sort,  rollup_records(left, right),record,except Date_First_Seen, Date_Last_Seen,
			   Date_Vendor_First_Reported, Date_Vendor_Last_Reported,name_type, local);
	
export Service_Abstract_DID := full_dedup :persist('~thor_data400::persist::Liens::Service_Abstract_DID') ;

