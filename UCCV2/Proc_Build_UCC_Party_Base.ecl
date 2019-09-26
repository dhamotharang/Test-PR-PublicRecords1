IMPORT Address, AID, BIPV2, Business_Header, Business_Header_SS, DID_Add, MDR, NID, UCCV2;

export  Proc_Build_UCC_Party_Base(boolean bvalue) := function
 
	NID_Clean_Name_Parsed(DATASET(UCCV2.Layout_UCC_Common.Layout_Party_with_AID) pInput) := FUNCTION

    NID.Mac_CleanParsedNames(pInput, cleaned_names, orig_fname, orig_mname, orig_lname, orig_suffix, useV2:=true);

		RETURN cleaned_names;

	END;

	ds_has_orig_name := UCCV2.File_UCC_Party_Base_AID(orig_name != '');
	ds_no_orig_name := UCCV2.File_UCC_Party_Base_AID(orig_name = '');

  NID.Mac_CleanFullNames(ds_has_orig_name, CleanNameRecs, orig_name, useV2:=true);

	person_flags   := ['P', 'D'];
	// V2 replaced the Unclassified('U') category with the Trust ('T') category, what used to be a U should become a T or I with V2.
	business_flags := ['B', 'I', 'T'];

	UCCV2.Layout_UCC_Common.Layout_Party_with_AID trfCleanName(CleanNameRecs L) := TRANSFORM
		SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
		SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
		SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
		SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
		SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
	  SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.orig_name), '');

		SELF := L;
	END;

  // This line must use the NID as a function to avoid getting a side-effect error.  Even moving the
	// ds_no_orig_name assignement just above this line did not stop the error.
	CleanNamePartsRecs := NID_Clean_Name_Parsed(ds_no_orig_name);

	// Because the vendor will sometimes send a company name as a person's last name only, we need to make
	// sure what they sent is a person.
	UCCV2.Layout_UCC_Common.Layout_Party_with_AID trfCleanNameParts(CleanNamePartsRecs L) := TRANSFORM
		SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
		SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
		SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
		SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
		SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
		SELF.company_name := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.orig_lname), '');

		SELF := L;
	END;

	dCleanBase := PROJECT(CleanNameRecs, trfCleanName(LEFT)) +
					      PROJECT(CleanNamePartsRecs, trfCleanNameParts(LEFT));

   dParty    :=	if (bvalue,
      										dCleanBase + File_UCC_Party_name,
      										File_UCC_Party_name);	

HasAddress	:= 	trim(dParty.prep_addr_last_line, left,right)	!= '';
												
dWith_address			:= 	dParty(HasAddress);
dWithout_address	:= 	dParty(not(HasAddress));
										
unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, RawAID, dAddressCleaned, lAIDAppendFlags);
	
UCC_with_AID	:=	project(dAddressCleaned,transform(Layout_UCC_Common.Layout_Party_With_AID,
	self.ACEAID							:= left.aidwork_acecache.aid;
	self.RawAID							:= left.aidwork_rawaid;
	self.prim_range					:= left.aidwork_acecache.prim_range;
	self.predir							:= left.aidwork_acecache.predir;
	self.prim_name					:= left.aidwork_acecache.prim_name;
	self.suffix							:= left.aidwork_acecache.addr_suffix;
	self.postdir						:= left.aidwork_acecache.postdir;
	self.unit_desig					:= left.aidwork_acecache.unit_desig;
	self.sec_range					:= left.aidwork_acecache.sec_range;
	self.p_city_name				:= left.aidwork_acecache.p_city_name;
	self.v_city_name				:= left.aidwork_acecache.v_city_name;
	self.st									:= left.aidwork_acecache.st;
	self.zip5								:= left.aidwork_acecache.zip5;
	self.zip4								:= left.aidwork_acecache.zip4;
	self.cart								:= left.aidwork_acecache.cart;
	self.cr_sort_sz					:= left.aidwork_acecache.cr_sort_sz;
	self.lot								:= left.aidwork_acecache.lot;
	self.lot_order					:= left.aidwork_acecache.lot_order;
	self.dpbc								:= left.aidwork_acecache.dbpc;
	self.chk_digit					:= left.aidwork_acecache.chk_digit;
	self.rec_type						:= left.aidwork_acecache.rec_type;
	self.ace_fips_st				:= left.aidwork_acecache.county[1..2];
	self.ace_fips_county		:= left.aidwork_acecache.county[3..5];
	self.county							:= left.aidwork_acecache.county[3..5];
	self.geo_lat						:= left.aidwork_acecache.geo_lat;
	self.geo_long						:= left.aidwork_acecache.geo_long;
	self.msa								:= left.aidwork_acecache.msa;
	self.geo_blk						:= left.aidwork_acecache.geo_blk;
	self.geo_match					:= left.aidwork_acecache.geo_match;
	self.err_stat						:= left.aidwork_acecache.err_stat;
	self										:= left;)
				) + dWithout_address : INDEPENDENT;		
				
 dPartyc   :=UCC_with_AID(company_name<>'');
 dPartyp   :=UCC_with_AID(company_name='');


							 
matchset := ['A','Z'];

did_add.MAC_Match_Flex(
				dPartyp
			 ,matchset
			 ,foo
			 ,foo
			 ,fname
			 ,mname
			 ,lname
			 ,name_suffix
			 ,prim_range
			 ,prim_name
			 ,sec_range
			 ,zip5
			 ,st
			 ,''
			 ,did
			 ,recordof(dPartyp)
			 ,true
			 ,did_score
			 ,75
			 ,dPostDID);
				 
business_header.MAC_Source_Match(
		   dPartyc			   																	 // infile
			,dPostBusHdrSourceMatch														// outfile
			,FALSE																				   // bool_bdid_field_is_string12
			,BDID																	       	  // bdid_field
			,FALSE																		     // bool_infile_has_source_field
			,MDR.sourceTools.src_UCCV2         						// source_type_or_field
			,FALSE																	     // bool_infile_has_source_group
			,corp_key													          // source_group_field
			,company_name											         // company_name_field
			,prim_range											          // prim_range_field
			,prim_name										           // prim_name_field
			,sec_range									  					// sec_range_field
			,zip5										   						 // zip_field
			,false										            // bool_infile_has_phone
			,foo			                  				 // phone_field
			,false							                // bool_infile_has_fein
			,foo   				                     // fein_field
			,false						 								// bool_infile_has_vendor_id	 
			,corp_key	  									 	 // vendor_id_field
);

dPostSourceMatch_source  := table(dPostBusHdrSourceMatch,{dPostBusHdrSourceMatch, string source := MDR.sourceTools.src_UCCV2});
sBDIDMatchSet		   			 :=	['A'];
 
Business_Header_SS.MAC_Add_BDID_Flex(
			 dPostSourceMatch_source									 // Input Dataset						
			,sBDIDMatchSet                            // BDID Matchset           
			,company_name        		             		 // company_name	              
			,prim_range		                          // prim_range		              
			,prim_name		                         // prim_name		              
			,zip5 					                      // zip5					              
			,sec_range		                       // sec_range		              
			,st				                          // state				              
			,telephone_number				           // phone				              
			,fein                             // fein              
			,bdid											 			 // bdid												
			,recordof(dPostSourceMatch_source) 	      // Output Layout 
			,false                         // output layout has bdid score field?                       
			,BDID_Score                   // bdid_score                 
			,dPostBDID                   // Output Dataset   
			,														// deafult threscold
			,													 // use prod version of superfiles
			,													// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set // Create BIP Keys only
			,           						// Url
			,								       // Email
			,p_City_name					// City
			,fname							 // fname
			,mname							// mname
			,lname						 // lname
			,                 // ssn
			,source          //sourceField
			,source_rec_id  //persistent_rec_id
			,true          //Call sourceMatch macro before Flex 
);
dPostDIDandBDIDPersist	:=	dPostDID +project(dPostBDID, transform(recordof(UCC_with_AID), self := left));
 
did_add.MAC_Add_SSN_By_DID(dPostDIDandBDIDPersist, did, ssn, dAppendSSN, false);
					
retval   :=	dAppendSSN;

return retval;

end;