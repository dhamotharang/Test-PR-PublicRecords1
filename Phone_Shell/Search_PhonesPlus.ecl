/* ************************************************************************
 * This function searches Phones Plus by:																	*
 * - Address, Same First Name:: Source: PPFA															*
 * - Address, Same Last Name:: Source: PPLA																*
 * - Address, Same First and Last Name:: Source: PPFLA										*
 * - Address, Swapped First and Last Name:: Source: PPLFA									*
 * - Address, Unique Addresses by DID in last 6 months:: Source: PPCA			*
 * - DID, Above the Line (Confidence Score >= 11):: Source: PPDID					*
 * - DID, Below the Line (Confidence Score < 11):: Source: PPTH						*
 ************************************************************************ */

IMPORT Autokey, Data_Services, Doxie, Phone_Shell, Phones, PhonesPlus_V2, RiskWise, UT, STD;

DEBUG_IGNORE_ALLOW_LIST := FALSE; // Set to TRUE if you do NOT want to filter by allow list

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_PhonesPlus (
       DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, 
			 DATASET(Phone_Shell.Layouts.layoutUniqueAddresses) HeaderAddresses, 
			 UNSIGNED1 GLBPurpose, 
			 UNSIGNED1 DPPAPurpose, 
			 BOOLEAN IncludeLastResort, 
			 UNSIGNED1 PhoneRestrictionMask, 
			 STRING50 DataPermissionMask, 
			 STRING30 IndustryClass, 
			 STRING DataRestrictionMask
			 ) := FUNCTION	

	 AddressAutoKey := AutoKey.Key_Address(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_');
	 
	 /* ***************************************************************
		* 							Get the Phones Plus Data by DID									*
	  *************************************************************** */
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus searchByDID(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phonesplus_V2.Key_PhonesPlus_DID ri) := TRANSFORM
		
		SElf.Gathered_Phone := TRIM(ri.cellphone);
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.P_City_Name,			ri.State,							ri.Zip5,						 ri.dob,										 '',							   ri.DID, ri.Cellphone);
		
		Source_List_Temp := IF((INTEGER)ri.confidencescore >= 11, 'PPDID', 'PPTH');
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), Source_List_Temp,	'');
																				
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate(IF(ri.DateFirstSeen <> 0, (STRING)ri.DateFirstSeen, (STRING)ri.DateVendorFirstReported));
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(IF(ri.DateLastSeen <> 0, (STRING)ri.DateLastSeen, (STRING)ri.DateVendorLastReported));
		
		SELF.Sources.Source_Owner_Name_First := ri.fname; 
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
		SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;
		
		listType := TRIM(ri.listingtype);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := MAP(TRIM(ri.append_phone_type) = 'CELL' 	=> 'M',
																														listType = 'R' 											=> 'R',
																														listType = 'B' 											=> 'B',
																														listType = 'RB' 										=> 'B',
																														listType = 'M' 											=> 'M',
																																																	 'U');
                                                                                                   
		#if(not DEBUG_IGNORE_ALLOW_LIST)
  // 'mask' the key src_all field to only have a 1 in the allowed sources, use bitwise AND with the allowed mask
  Src_All_Masked := ri.src_all & ut.BinaryStringToInteger(Phone_Shell.Constants.PhonesPlus_AllowedSourcesMask);
  // now we need to check and see if our filtered src_all actually changed from the original
  src_chgd := not(src_all_masked = ri.src_all);
  // and if it did, we need to update what we use for Vendor to match the new src_all (Src will be updated in Get_Attributes_Phones_Plus)
  first_src := Phone_Shell.Common.PhonePlusFirstSource(src_all_masked);
  adjusted_vendor := if(src_chgd,
                        if(Phone_Shell.Common.PhonesPlusSrcIsHeader(first_src),'HD',phonesplus_v2.translation_codes.fGet_all_sources(first_src)),
                        ri.Vendor);
  #else
  adjusted_vendor := ri.Vendor;
  //src_all_masked := ri.src_all; // only needed for debug below
  #end
  // just adding this here for testing/debug
  // self.phonesplus_characteristics.phonesplus_src_all := trim(STD.Str.Reverse(ut.IntegerToBinaryString(src_all_masked,false)));
  // self.phonesplus_characteristics.phonesplus_src := ri.src;
  //
  SELF.PhonesPlus_Characteristics.PhonesPlus_Source := TRIM(adjusted_vendor);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := TRIM(ri.append_ocn);
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := TRIM(ri.append_place_name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := TRIM(ri.state);
		
		SELF := le;
	END;
	
	byDID := JOIN(Input, Phonesplus_V2.Key_PhonesPlus_DID, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.L_DID) AND 
																													Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																																														 GLBPurpose, 
																																														 DPPAPurpose, 
																																														 IndustryClass,
																																														 ,
																																														 RIGHT.datefirstseen,
																																														 RIGHT.dt_nonglb_last_seen,
																																														 RIGHT.rules,
																																														 RIGHT.src_all,
																																														 DataRestrictionMask
																																														) = FALSE AND
																													(INTEGER)RIGHT.cellphone <> 0 
                       #if(not DEBUG_IGNORE_ALLOW_LIST)                                   
                             AND Phone_Shell.Common.PhonesPlusSourceAllowed(RIGHT.src_all)
                       #end
                              ,
																			searchByDID(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	 /* ***************************************************************
		* 				Get the Phones Plus LastResort Data by DID						*
	  *************************************************************** */
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus searchByDIDRoyalty(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phonesplus_V2.Key_PhonesPlus_DID ri) := TRANSFORM
		
		SELF.Gathered_Phone := TRIM(ri.cellphone);
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.P_City_Name,			ri.State,							ri.Zip5,						 ri.dob,										 '',							   ri.DID, ri.Cellphone);
		
		// Only include Royalty phones that we have confidence in...
		Source_List_Temp := IF((INTEGER)ri.confidencescore >= 11, 'PPDID', '');
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), Source_List_Temp,	'');
																				
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate(IF(ri.DateFirstSeen <> 0, (STRING)ri.DateFirstSeen, (STRING)ri.DateVendorFirstReported));
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(IF(ri.DateLastSeen <> 0, (STRING)ri.DateLastSeen, (STRING)ri.DateVendorLastReported));
	
		SELF.Sources.Source_Owner_Name_First := ri.fname; 
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
		SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;
		
		// This is a Royalty phone, make sure to return this output so that we can properly track royalty information
		SELF.Royalties.LastResortPhones_Royalty := 1;
		
		// While we are searching Phones Plus, append these Phones Plus Attributes
		listType := TRIM(ri.listingtype);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := MAP(TRIM(ri.append_phone_type) = 'CELL' 	=> 'M',
																														listType = 'R' 											=> 'R',
																														listType = 'B' 											=> 'B',
																														listType = 'RB' 										=> 'B',
																														listType = 'M' 											=> 'M',
																																																	 'U');
                                                                                                   
  #if(not DEBUG_IGNORE_ALLOW_LIST)
  // 'mask' the key src_all field to only have a 1 in the allowed sources, use bitwise AND with the allowed mask
  Src_All_Masked := ri.src_all & ut.BinaryStringToInteger(Phone_Shell.Constants.PhonesPlus_AllowedSourcesMask);
  // now we need to check and see if our filtered src_all actually changed from the original
  src_chgd := not(src_all_masked = ri.src_all);
  // and if it did, we need to update what we use for Vendor to match the new src_all
  first_src := Phone_Shell.Common.PhonePlusFirstSource(src_all_masked);
  adjusted_vendor := if(src_chgd,
                        if(Phone_Shell.Common.PhonesPlusSrcIsHeader(first_src),'HD',phonesplus_v2.translation_codes.fGet_all_sources(first_src)),
                        ri.Vendor);
  #else
  adjusted_vendor := ri.Vendor;
  //src_all_masked := ri.src_all; // only needed for debug below
  #end     
  // just adding this here for testing/debug 
  // self.phonesplus_characteristics.phonesplus_src_all := trim(STD.Str.Reverse(ut.IntegerToBinaryString(src_all_masked,false)));
  // self.phonesplus_characteristics.phonesplus_src := ri.src;
  //
		SELF.PhonesPlus_Characteristics.PhonesPlus_Source := TRIM(adjusted_vendor);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := TRIM(ri.append_ocn);
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := TRIM(ri.append_place_name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := TRIM(ri.state);
		
		SELF := le;
	END;
	
	byDIDRoyaltyTemp := JOIN(Input, Phonesplus_v2.Key_Royalty_Did, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.L_DID) AND 
																													Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																																														 GLBPurpose, 
																																														 DPPAPurpose, 
																																														 IndustryClass,
																																														 ,
																																														 RIGHT.datefirstseen,
																																														 RIGHT.dt_nonglb_last_seen,
																																														 RIGHT.rules,
																																														 RIGHT.src_all,
																																														 DataRestrictionMask
                                                                                            ) = FALSE AND
																													(INTEGER)RIGHT.cellphone <> 0 AND (INTEGER)RIGHT.confidencescore >= 11 
                     #if(not DEBUG_IGNORE_ALLOW_LIST)
                          AND Phone_Shell.Common.PhonesPlusSourceAllowed(RIGHT.src_all)
                     #end
                             ,
																			searchByDIDRoyalty(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');
	
	// Only use Royalty Phones if Include Last Resort is turned on and the Data Permission Mask has the LastResort bit set to TRUE
	byDIDRoyalty := IF(IncludeLastResort AND DataPermissionMask[6] NOT IN ['0', ''], byDIDRoyaltyTemp, DATASET([], Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus));

	 /* ***************************************************************
		* 		Get the Phones Plus Data by Unique Header Addresses				*
    * Since we are using Autokeys - need to do 2 joins for payload  *
	  *************************************************************** */
	layoutUniqueAddrTemp := RECORD
		UNSIGNED8 fdid := 0; // Fake DID - used in Autokey lookups
		Phone_Shell.Layouts.layoutUniqueAddresses;
	END;
	layoutUniqueAddrTemp getFDID(Phone_Shell.Layouts.layoutUniqueAddresses le, AddressAutoKey ri) := TRANSFORM
		SELF.fdid := ri.did;
		SELF := le;
	END;
	getAddressFDID1 := JOIN(HeaderAddresses ((INTEGER)DateLastSeen >= (INTEGER)(ut.date_math((string)STD.Date.Today(), -1 * Phone_Shell.Constants.HeaderSixMonthsDate)[1..6])), AddressAutoKey,
																								TRIM(LEFT.Prim_Range) <> '' AND TRIM(LEFT.Prim_Name) <> '' AND TRIM(LEFT.Zip5) <> '' AND 
																								KEYED(RIGHT.prim_name = LEFT.Prim_Name) AND KEYED(RIGHT.prim_range = LEFT.Prim_Range) AND KEYED(RIGHT.st = LEFT.State) AND 
																								KEYED(RIGHT.city_code IN doxie.Make_CityCodes(LEFT.City).rox) AND KEYED(RIGHT.zip = LEFT.Zip5) AND KEYED(RIGHT.sec_range = LEFT.Sec_Range),
																				getFDID(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus searchByUniqueAddresses(layoutUniqueAddrTemp le, Phonesplus_v2.Key_Phonesplus_Fdid ri) := TRANSFORM
		
		SELF.Clean_Input.seq := le.seq; // Need to save this to join back to the input data in a moment
		SELF.Gathered_Phone := TRIM(ri.cellphone);
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.FirstName, le.LastName, '', le.Prim_Range, le.Prim_Name, le.Addr_Suffix, le.City, 				le.State, le.Zip5,	le.DateOfBirth, le.SSN, le.DID, le.HomePhone, le.WorkPhone, 
																											ri.fname, 		ri.lname, 	 '', ri.Prim_Range,	ri.Prim_Name,	ri.Addr_Suffix,	ri.P_City_Name,	ri.State,	ri.Zip5,	ri.dob,					'',			ri.DID, ri.Cellphone);
		
		// Only include the phones that we have decent confidence in
		Source_List_Temp := IF((INTEGER)ri.confidencescore >= 11, 'PPCA', '');
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.LastName, ri.lname), Source_List_Temp,	'');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate(IF(ri.DateFirstSeen <> 0, (STRING)ri.DateFirstSeen, (STRING)ri.DateVendorFirstReported));
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(IF(ri.DateLastSeen <> 0, (STRING)ri.DateLastSeen, (STRING)ri.DateVendorLastReported));
		
		SELF.Sources.Source_Owner_Name_First := ri.fname; 
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
		SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
	  SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
	
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															addrMatch										=> 'Associate By Address',
																															ssnMatch										=> 'Associate By SSN',
																																														 'Associate'
																															);
		
		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;
		
		// While we are searching Phones Plus, append these Phones Plus Attributes
		listType := TRIM(ri.listingtype);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := MAP(TRIM(ri.append_phone_type) = 'CELL' 	=> 'M',
																														listType = 'R' 											=> 'R',
																														listType = 'B' 											=> 'B',
																														listType = 'RB' 										=> 'B',
																														listType = 'M' 											=> 'M',
																																																	 'U');
                                                                                                   
  #if(not DEBUG_IGNORE_ALLOW_LIST)
  // 'mask' the key src_all field to only have a 1 in the allowed sources, use bitwise AND with the allowed mask
  Src_All_Masked := ri.src_all & ut.BinaryStringToInteger(Phone_Shell.Constants.PhonesPlus_AllowedSourcesMask);
  // now we need to check and see if our filtered src_all actually changed from the original
  src_chgd := not(src_all_masked = ri.src_all);
  // and if it did, we need to update what we use for Vendor to match the new src_all
  first_src := Phone_Shell.Common.PhonePlusFirstSource(src_all_masked);
  adjusted_vendor := if(src_chgd,
                        if(Phone_Shell.Common.PhonesPlusSrcIsHeader(first_src),'HD',phonesplus_v2.translation_codes.fGet_all_sources(first_src)),
                        ri.Vendor);
  #else
  adjusted_vendor := ri.Vendor;
  //src_all_masked := ri.src_all; // only needed for debug below
  #end 
  // just adding this here for testing/debug
  // self.phonesplus_characteristics.phonesplus_src_all := trim(STD.Str.Reverse(ut.IntegerToBinaryString(src_all_masked,false)));
  // self.phonesplus_characteristics.phonesplus_src := ri.src;
  //
		SELF.PhonesPlus_Characteristics.PhonesPlus_Source := TRIM(adjusted_vendor);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := TRIM(ri.append_ocn);
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := TRIM(ri.append_place_name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := TRIM(ri.state);
		
		SELF := [];
	END;
	// Only search for addresses seen within the last 6 months
	uniqueAddressSearchResults := JOIN(getAddressFDID1, Phonesplus_v2.Key_Phonesplus_Fdid, LEFT.fdid <> 0 AND KEYED(LEFT.fdid = RIGHT.fdid) AND
																											  	Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																																														 GLBPurpose, 
																																														 DPPAPurpose, 
																																														 IndustryClass,
																																														 ,
																																														 RIGHT.datefirstseen,
																																														 RIGHT.dt_nonglb_last_seen,
																																														 RIGHT.rules,
																																														 RIGHT.src_all,
																																														 DataRestrictionMask
																																														) = FALSE AND
																														(INTEGER)RIGHT.cellphone <> 0 AND (INTEGER)RIGHT.confidencescore >= 11 
                      #if(not DEBUG_IGNORE_ALLOW_LIST)                          
                          AND Phone_Shell.Common.PhonesPlusSourceAllowed(RIGHT.src_all)
                      #end
                              ,
																																				searchByUniqueAddresses(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus combineInputAndUnique(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
		
		SELF.Gathered_Phone := ri.Gathered_Phone;
		
		SELF.Sources := ri.Sources;
		
		SELF.Raw_Phone_Characteristics := ri.Raw_Phone_Characteristics;
		
		SELF.PhonesPlus_Characteristics := ri.PhonesPlus_Characteristics;
		
		SELF := le;
	END;
	
	byUniqueAddresses := JOIN(Input, uniqueAddressSearchResults, LEFT.Clean_Input.seq = RIGHT.Clean_Input.seq, combineInputAndUnique(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	
	 /* ***************************************************************
		* 		       Get the Phones Plus Data by Address				        *
    * Since we are using Autokeys - need to do 2 joins for payload  *
	  *************************************************************** */
	layoutAddrTemp := RECORD
		UNSIGNED8 fdid := 0; // Fake DID - used in Autokey lookups
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
	END;
	layoutAddrTemp getFDID2(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, AddressAutoKey ri) := TRANSFORM
		SELF.fdid := ri.did;
		SELF := le;
	END;
	getAddressFDID2 := JOIN(Input, AddressAutoKey,
																	TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND 
																	KEYED(RIGHT.prim_name = LEFT.Clean_Input.Prim_Name) AND KEYED(RIGHT.prim_range = LEFT.Clean_Input.Prim_Range) AND KEYED(RIGHT.st = LEFT.Clean_Input.State) AND 
																	KEYED(RIGHT.city_code IN doxie.Make_CityCodes(LEFT.Clean_Input.City).rox) AND KEYED(RIGHT.zip = LEFT.Clean_Input.Zip5) AND KEYED(RIGHT.sec_range = LEFT.Clean_Input.Sec_Range),
															getFDID2(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus searchByInputAddress(layoutAddrTemp le, Phonesplus_v2.key_phonesplus_fdid ri) := TRANSFORM
		SELF.Gathered_Phone := TRIM(ri.cellphone);
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone,
																											ri.fname, 								ri.lname, 	 							'', 													ri.Prim_Range,							ri.Prim_Name,							ri.Addr_Suffix,							ri.P_City_Name,			ri.State,							ri.Zip5,							ri.dob,											'',									ri.DID, ri.Cellphone);
		
		// We only want to keep the phones we are confident about - the PPTH level is for the phones we aren't certain about
		Source_List_Temp := MAP(le.Clean_Input.FirstName = ri.fname AND le.Clean_Input.LastName = ri.lname AND (INTEGER)ri.confidencescore >= 11 	=> 'PPFLA',
														le.Clean_Input.FirstName = ri.lname AND le.Clean_Input.LastName = ri.fname AND (INTEGER)ri.confidencescore >= 11 	=> 'PPLFA',
														le.Clean_Input.FirstName = ri.fname AND le.Clean_Input.LastName <> ri.lname AND (INTEGER)ri.confidencescore >= 11	=> 'PPFA',
														le.Clean_Input.FirstName <> ri.fname AND le.Clean_Input.LastName = ri.lname AND (INTEGER)ri.confidencescore >= 11	=> 'PPLA',
																																																																								 '');
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok																																		 
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), Source_List_Temp,	'');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate(IF(ri.DateFirstSeen <> 0, (STRING)ri.DateFirstSeen, (STRING)ri.DateVendorFirstReported));
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(IF(ri.DateLastSeen <> 0, (STRING)ri.DateLastSeen, (STRING)ri.DateVendorLastReported));
		
		SELF.Sources.Source_Owner_Name_First := ri.fname; 
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
		SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch								=> Phone_Shell.Constants.Phone_Subject_Level.Subject, 
																															didMatch AND addrMatch								=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																															Source_List_Temp IN ['PPFA', 'PPLA']	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																																			 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															Source_List_Temp IN ['PPFA', 'PPLA'] => 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);
																															
		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;
		
		// While we are searching Phones Plus, append these Phones Plus Attributes
		listType := TRIM(ri.listingtype);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := MAP(TRIM(ri.append_phone_type) = 'CELL' 	=> 'M',
																														listType = 'R' 											=> 'R',
																														listType = 'B' 											=> 'B',
																														listType = 'RB' 										=> 'B',
																														listType = 'M' 											=> 'M',
																																																	 'U');
                                                                                                   
  #if(not DEBUG_IGNORE_ALLOW_LIST)
  // 'mask' the key src_all field to only have a 1 in the allowed sources, use bitwise AND with the allowed mask
  Src_All_Masked := ri.src_all & ut.BinaryStringToInteger(Phone_Shell.Constants.PhonesPlus_AllowedSourcesMask);
  // now we need to check and see if our filtered src_all actually changed from the original
  src_chgd := not(src_all_masked = ri.src_all);
  // and if it did, we need to update what we use for Vendor to match the new src_all
  first_src := Phone_Shell.Common.PhonePlusFirstSource(src_all_masked);
  adjusted_vendor := if(src_chgd,
                        if(Phone_Shell.Common.PhonesPlusSrcIsHeader(first_src),'HD',phonesplus_v2.translation_codes.fGet_all_sources(first_src)),
                        ri.Vendor);
  #else
  adjusted_vendor := ri.Vendor;
  //src_all_masked := ri.src_all; // only needed for debug below
  #end             
  // just adding this here for testing/debug
  // self.phonesplus_characteristics.phonesplus_src_all := trim(STD.Str.Reverse(ut.IntegerToBinaryString(src_all_masked,false)));
  // self.phonesplus_characteristics.phonesplus_src := ri.src;
  //
		SELF.PhonesPlus_Characteristics.PhonesPlus_Source := TRIM(adjusted_vendor);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := TRIM(ri.append_ocn);
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := TRIM(ri.append_place_name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := TRIM(ri.state);
		
		SELF := le;
	END;
	 
	byAddressAll := JOIN(getAddressFDID2, Phonesplus_v2.key_phonesplus_fdid, LEFT.fdid <> 0 AND KEYED(LEFT.fdid = RIGHT.fdid) AND
																											Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																																												 GLBPurpose, 
																																												 DPPAPurpose, 
																																												 IndustryClass,
																																												 ,
																																												 RIGHT.datefirstseen,
																																												 RIGHT.dt_nonglb_last_seen,
																																												 RIGHT.rules,
																																												 RIGHT.src_all,
																																												 DataRestrictionMask
																																												) = FALSE AND
																											(INTEGER)RIGHT.cellphone <> 0 
                  #if(not DEBUG_IGNORE_ALLOW_LIST)
                       AND Phone_Shell.Common.PhonesPlusSourceAllowed(RIGHT.src_all)
                  #end
                           ,
																											searchByInputAddress(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
																											
	// Don't keep the phones which didn't match on some part of the name
	byAddress := byAddressAll (TRIM(Sources.Source_List) <> '');
	
	final := DEDUP(SORT((byDID + byDIDRoyalty + byUniqueAddresses + byAddress), Clean_Input.seq, Gathered_Phone, Royalties.LastResortPhones_Royalty, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
 // debug outputs
 //output(byDID,named('searchPP_byDID'));
 //output(byDIDRoyalty,named('searchPP_byDIDRoyalty'));
 //output(byUniqueAddresses,named('searchPP_byUniqueAddresses'));
 //output(byAddress,named('searchPP_byAddress'));
 //output(SORT((byDID + byDIDRoyalty + byUniqueAddresses + byAddress), Clean_Input.seq, Gathered_Phone, Royalties.LastResortPhones_Royalty, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))),named('srchPP_beforeDeDup'));
 //output(final,named('searchPP_final'));
	//
 
 RETURN(final);
END;