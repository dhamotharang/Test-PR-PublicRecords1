import LiensV2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,watchdog,TopBusiness_External;

file_in := LiensV2.Mapping_Superior_Liens_party;

PreDID_Rec
 :=
  record
   	liensv2.Layout_Liens_party_bid;
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	    := 0;
	
  end;
  
 

PreDID_Rec taddDID(file_in L)
 :=
  transform
	self			:=	L;
  end ;
 

Prefile	:= project(file_in,taddDID(left));

preDID  := prefile(cname  = '');
preBDID := prefile(cname <> '');

//append DID 
matchset :=['A', 'z', 'S', 'P','4'];

did_Add.MAC_Match_Flex(PreDID, matchset,
	 ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone,
	 temp_did,   			
	 PreDID_Rec, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID)

//append BDID



myset := ['A','N', 'F', 'P'];

Business_Header_SS.MAC_Add_BDID_FLEX(preBDID,myset,
						cname,
                        prim_range,prim_name,zip,sec_range,
						st,
						phone,tax_id,
						temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid);
						
	
					
post_DID_BDID :=  postDID + postbdid  ;//reformat DID and BDID

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

//** BID Macro call
TopBusiness_External.MAC_External_BID(
	 file_party_fein											// The input file to have BIDs appended
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


liensV2.Layout_liens_party_ssn_bid tremovetempDID(rec_temp L) := transform
self := L;

end;

post_append_ssn := distribute(project(postBID,tremovetempDID(left)),hash(tmsid));


	
export Superior_DID := post_append_ssn :persist('~thor_data400::persist::Liens::superior_DID') ;


