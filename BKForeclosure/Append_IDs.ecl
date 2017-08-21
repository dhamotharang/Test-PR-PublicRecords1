// import ut, header_slimsort, did_add, didville, header,address, Business_Header_SS,Business_Header;
IMPORT address, ut, bipv2,header_slimsort, did_add, didville,watchdog,business_header, business_header_ss, TopBusiness_External, MDR, BIPv2;
EXPORT Append_IDs := MODULE

EXPORT Append_NOD(DATASET(RECORDOF(Layout_BK.ClnAddr_NOD)) dClnFile) := FUNCTION
// Input File
    prepDID_nod  := dClnFile(cname = '');  // individual record
    prepBDID_nod := dClnFile(cname!= '');  // business record

		inFile_nod_did  := PROJECT(prepDID_nod,layout_BK.did_nod);
		inFile_nod_bdid := PROJECT(prepBDID_nod,layout_BK.did_nod);		
//-----------------------------------------------------------------
//APPEND BIP
//-----------------------------------------------------------------
	/*	
			'A' = Address
			'F' = FEIN
			'P'	= phone
				* company name will always be part of the match if any of
					the above flags are set.
			'N' = Allow match on company name only.
	*/
	
BIP_Matchset := ['A'];
	
Business_Header_SS.MAC_Add_BDID_Flex(	inFile_nod_bdid	// Input Dataset
																			 ,BIP_Matchset     														 // BDID Matchset what fields to match on
																			 ,Company_name					     				          // company_name
																			 ,prim_range       													 // prim_range
																			 ,prim_name	        												// prim_name
																			 ,zip             												 // zip5
																			 ,sec_range         											// sec_range
																			 ,st	              										 // state
																			 ,foo                     							// phone
																			 ,fein            										 // fein
																			 ,''					        					      // bdid
																			 ,layout_BK.did_nod_plus             // Output Layout
																			 ,FALSE              								// output layout has bdid score field?
																			 ,''								       				 // bdid_score
																			 ,dbase_temp_nod  								// Output Dataset
																			 ,															 // default threshold
																			 ,													 		// use prod version of superfiles
																			 ,														 // default is to hit prod from dataland, and on prod hit prod.		
																			 ,[BIPV2.IDconstants.xlink_version_BIP]	// Create BIP Keys only
																			 ,           		             // Url
																			 ,													// Email
																			 ,p_city_name							 // City
																			 );	
	
	dBase_BIP_nod := dbase_temp_nod;	
//Append DID
/* matchset := [ 'A' 	// Address
								,'D'	// DOB
								,'S'	// ssn
								,'P'	// phone
								,'Q'	// Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
								,'4'	// ssn4 matching (last 4 digits of ssn)
								,'G'	// age matching
								,'Z'	// zip code matching];		
*/								   
matchset := ['A','Z'];




did_add.MAC_Match_Flex
	(inFile_nod_did , matchset,					
	 foo, foo, cln_fname, cln_mname, cln_lname, cln_suffix,
	 prim_range, prim_name, sec_range, zip, st,foo, 
	 DID, layout_BK.did_nod_plus, 
	 FALSE, DID_Score,
	 75, dBase_DID_nod);
	
	bip_out_nod   := dBase_BIP_nod:persist('~thor_data400::persist::BKForeclosure_Append_LinkID_NOD');
	did_out_nod   := dBase_DID_nod:persist('~thor_data400::persist::BKForeclosure_Append_Base_DID_nod');	
//----------------------------------------------------------------
//BUILD 
//-----------------------------------------------------------------
 nod_IDs := did_out_nod + bip_out_nod;
 ds_nod  := PROJECT(nod_IDs, TRANSFORM(layout_BK.did_nod_plus,
                           SELF:=LEFT)):persist('~thor_data400::BKForeclosure_Append_ID_NOD');
													 

RETURN ds_nod;
END;


EXPORT Append_REO(DATASET(RECORDOF(Layout_BK.ClnAddr_REO)) dClnFile) := FUNCTION

    prepDID_reo  := dClnFile(cname = ''); // individual records
    prepBDID_reo := dClnFile(cname!= ''); // business records

		inFile_reo_did  := PROJECT(prepDID_reo,layout_BK.did_reo);
		inFile_reo_bdid := PROJECT(prepBDID_reo,layout_BK.did_reo);

//-----------------------------------------------------------------
//APPEND BIP
//-----------------------------------------------------------------
	/*	
			'A' = Address
			'F' = FEIN
			'P'	= phone
				* company name will always be part of the match if any of
					the above flags are set.
			'N' = Allow match on company name only.
	*/
	
	BIP_Matchset := ['A'];
	Business_Header_SS.MAC_Add_BDID_Flex(	inFile_reo_bdid	// Input Dataset
																			 ,BIP_Matchset     														 // BDID Matchset what fields to match on
																			 ,Company_name					     				          // company_name
																			 ,prim_range       													 // prim_range
																			 ,prim_name	        												// prim_name
																			 ,zip             												 // zip5
																			 ,sec_range         											// sec_range
																			 ,st	              										 // state
																			 ,foo                     							// phone
																			 ,fein            										 // fein
																			 ,''					        					      // bdid
																			 ,layout_BK.did_reo_plus             // Output Layout
																			 ,FALSE              								// output layout has bdid score field?
																			 ,''								       				 // bdid_score
																			 ,dbase_temp_reo  								// Output Dataset
																			 ,															 // default threshold
																			 ,													 		// use prod version of superfiles
																			 ,														 // default is to hit prod from dataland, and on prod hit prod.		
																			 ,[BIPV2.IDconstants.xlink_version_BIP]	// Create BIP Keys only
																			 ,           		             // Url
																			 ,													// Email
																			 ,p_city_name							 // City
																			 );
	
	dBase_BIP_reo := dbase_temp_reo;			

//Append DID
/* matchset := [ 'A' 	// Address
								,'D'	// DOB
								,'S'	// ssn
								,'P'	// phone
								,'Q'	// Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
								,'4'	// ssn4 matching (last 4 digits of ssn)
								,'G'	// age matching
								,'Z'	// zip code matching];		
*/								   
matchset := ['A','Z'];

did_add.MAC_Match_Flex
	(inFile_reo_did , matchset,					
	 foo, foo, cln_fname, cln_mname, cln_lname, cln_suffix,
	 prim_range, prim_name, sec_range, zip, st,foo, 
	 DID, layout_BK.did_reo_plus, 
	 FALSE, DID_Score,
	 75, dBase_DID_reo);

	
	bip_out_reo   := dBase_BIP_reo:persist('~thor_data400::persist::BKForeclosure_Append_LinkID_REO');
	did_out_reo   := dBase_DID_reo:persist('~thor_data400::persist::BKForeclosure_Append_Base_DID_reo');

//-----------------------------------------------------------------
//BUILD 
//-----------------------------------------------------------------
 reo_IDs := did_out_reo + bip_out_reo;

 ds_reo  := PROJECT(reo_IDs, TRANSFORM(layout_BK.did_reo_plus,SELF:=LEFT)):persist('~thor_data400::BKForeclosure_Append_ID_REO');

RETURN ds_reo;													 
END;


END;