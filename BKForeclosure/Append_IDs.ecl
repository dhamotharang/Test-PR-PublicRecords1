IMPORT address, ut, bipv2,header_slimsort, did_add, didville,watchdog,business_header, business_header_ss, TopBusiness_External, MDR, BIPv2;

EXPORT Append_IDs := MODULE

EXPORT Append_NOD(DATASET(RECORDOF(Layout_BK.CleanFields_NOD)) dClnFile) := FUNCTION
// Input File
    prepDID_nod1  := dClnFile(cname = '' and cln_fname <> '' and cln_lname <> '');  // individual record
		prepDID_nod2  := dClnFile(cname = '' and cln_fname2 <> '');  // individual record(for dual names)
    prepBDID_nod := dClnFile(cname!= '');  // business record

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
	
Business_Header_SS.MAC_Match_Flex(	prepBDID_nod	// Input Dataset
																			 ,BIP_Matchset     														 // BDID Matchset what fields to match on
																			 ,cname									     				          // company_name
																			 ,prim_range       													 // prim_range
																			 ,prim_name	        												// prim_name
																			 ,zip             												 // zip5
																			 ,sec_range         											// sec_range
																			 ,st	              										 // state
																			 ,phone                    							// phone
																			 ,foo            										 	 // fein
																			 ,bdid				        					      // bdid
																			 ,Layout_BK.CleanFields_NOD          // Output Layout
																			 ,FALSE              								// output layout has bdid score field?
																			 ,bdid_score				       				 // bdid_score
																			 ,dbase_temp_nod  								// Output Dataset
																			 ,															 // keep count
																			 ,															// default threshold
																			 ,														 // use prod version of superfiles
																			 ,														// default is to hit prod from dataland, and on prod hit prod.
																			 ,BIPV2.xlink_version_set	 		// Create BIP Keys only
																			 ,           		             // Url
																			 ,													// Email
																			 ,p_city_name							 // City
																			 ,												// fname
																			 ,						 					 // mname
																			 ,											// lname
																			 ,										 // contact ssn
																			 ,src									// source
																			 ,									 // source_record_id
																			 ,false						  // if mac_Source_Match appears exists before flex macro
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
matchset := ['A','P','Z'];

did_add.MAC_Match_Flex
	(prepDID_nod1 , matchset,					
	 foo, foo, cln_fname, cln_mname, cln_lname, cln_suffix,
	 prim_range, prim_name, sec_range, zip, st,phone, 
	 DID, Layout_BK.CleanFields_NOD, 
	 FALSE, DID_Score,
	 75, dBase_DID_nod);
	 
did_add.MAC_Match_Flex
	(prepDID_nod2 , matchset,					
	 foo, foo, cln_fname2, cln_mname2, cln_lname2, cln_suffix2,
	 prim_range, prim_name, sec_range, zip, st,phone, 
	 DID, Layout_BK.CleanFields_NOD, 
	 FALSE, DID_Score,
	 75, dBase_DID_nod2);
	
	bip_out_nod   := dBase_BIP_nod:persist('~thor_data400::persist::BKForeclosure_Append_LinkID_NOD');
	did_out_nod   := dBase_DID_nod + dBase_DID_nod2:persist('~thor_data400::persist::BKForeclosure_Append_Base_DID_nod');	
//----------------------------------------------------------------
//BUILD 
//-----------------------------------------------------------------
 nod_IDs := did_out_nod + bip_out_nod;
 // ds_nod  := PROJECT(nod_IDs, TRANSFORM(layout_BK.did_nod_plus,
                           // SELF:=LEFT)):persist('~thor_data400::BKForeclosure_Append_ID_NOD');
 DID_Add.MAC_Add_SSN_By_DID(nod_IDs,did,ssn,appendSSN);

 dedNOD_IDs	:= DEDUP(appendSSN,ALL,RECORD);													 

RETURN dedNOD_IDs;
END;


EXPORT Append_REO(DATASET(RECORDOF(Layout_BK.CleanFields_REO)) dClnFile) := FUNCTION

    prepDID_reo1  := dClnFile(cname = '' and cln_fname <> '' and cln_lname <> ''); // individual records
		prepDID_reo2  := dClnFile(cname = '' and cln_fname2 <> ''); // individual record(for dual names)
    prepBDID_reo 	:= dClnFile(cname!= ''); // business records

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
	Business_Header_SS.MAC_Match_Flex(	prepBDID_reo	// Input Dataset
																			 ,BIP_Matchset     														 // BDID Matchset what fields to match on
																			 ,cname									     				          // company_name
																			 ,prim_range       													 // prim_range
																			 ,prim_name	        												// prim_name
																			 ,zip             												 // zip5
																			 ,sec_range         											// sec_range
																			 ,st	              										 // state
																			 ,foo                     							// phone
																			 ,foo	            										 // fein
																			 ,bdid				        					      // bdid
																			 ,Layout_BK.CleanFields_REO          // Output Layout
																			 ,FALSE              								// output layout has bdid score field?
																			 ,bdid_score				       				 // bdid_score
																			 ,dbase_temp_reo  								// Output Dataset
																			 ,															 // keep count
																			 ,															// default threshold
																			 ,														 // use prod version of superfiles
																			 ,														// default is to hit prod from dataland, and on prod hit prod.
																			 ,BIPV2.xlink_version_set	 		// Create BIP Keys only
																			 ,           		             // Url
																			 ,													// Email
																			 ,p_city_name							 // City
																			 ,												// fname
																			 ,						 					 // mname
																			 ,											// lname
																			 ,										 // contact ssn
																			 ,src									// source
																			 ,									 // source_record_id
																			 ,false						  // if mac_Source_Match appears exists before flex macro
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
	(prepDID_reo1 , matchset,					
	 foo, foo, cln_fname, cln_mname, cln_lname, cln_suffix,
	 prim_range, prim_name, sec_range, zip, st,foo, 
	 DID, Layout_BK.CleanFields_REO, 
	 FALSE, DID_Score,
	 75, dBase_DID_reo);
	 
did_add.MAC_Match_Flex
	(prepDID_reo2 , matchset,					
	 foo, foo, cln_fname2, cln_mname2, cln_lname2, cln_suffix2,
	 prim_range, prim_name, sec_range, zip, st,foo, 
	 DID, Layout_BK.CleanFields_REO, 
	 FALSE, DID_Score,
	 75, dBase_DID_reo2);

	
	bip_out_reo   := dBase_BIP_reo:persist('~thor_data400::persist::BKForeclosure_Append_LinkID_REO');
	did_out_reo   := dBase_DID_reo + dBase_DID_reo2:persist('~thor_data400::persist::BKForeclosure_Append_Base_DID_reo');

//-----------------------------------------------------------------
//BUILD 
//-----------------------------------------------------------------
 reo_IDs := did_out_reo + bip_out_reo;
 
 DID_Add.MAC_Add_SSN_By_DID(reo_IDs,did,ssn,appendSSN);
 
 dedReo_IDs	:= DEDUP(appendSSN,ALL,RECORD);

RETURN dedReo_IDs;													 
END;


END;