import AutoStandardI, MDR, BIPV2;

export Functions := module

export fn_fetchLevel(string1 level) :=  function
  fetchLevel := map(level = 'D' => BIPV2.IDconstants.Fetch_Level_DotID,
								    Level = 'E' => BIPV2.IDconstants.Fetch_Level_EmpID,
										Level = 'W' => BIPV2.IDconstants.Fetch_Level_PowID,
										Level =	'P' => BIPV2.IDconstants.Fetch_Level_ProxID,
									  Level =	'S' => BIPV2.IDconstants.Fetch_Level_SELEID,
										Level =	'O' => BIPV2.IDconstants.Fetch_Level_OrgID,
										Level =	'U' => BIPV2.IDconstants.Fetch_Level_UltID,
											BIPV2.IDconstants.Fetch_Level_SELEID);
    return fetchLevel;
end;
	// NOTE :
	//
	// this macro assumes that the field containing source_field is the two letter field
	// inDs - in dataset
	// outDs - out dataset
	// sourceField - name of the field in incoming/outgoing layout that has the 'source' field
	// in_mod - contains all the DRM/glb/dppa values
	// Ln_branded - some wonderful boolean
	// internal_testing -- testing override flag
	//
	EXPORT MAC_IsRestricted(inDS,outDS,source_field,vl_id,in_mod,
	 ln_Branded,
	 internal_testing,dt_first_seen) := MACRO

  #uniquename(outrec)
	
	%outrec% :=  record
		recordof(inDS);
  end;
								
  DRM := AutoStandardI.DataRestrictionI.val(in_mod);
	DPPA := AutoStandardI.PermissionI_Tools.val(in_mod).DPPA;
	GLB := AutoStandardI.PermissionI_tools.val(in_mod).GLB;
	
  tmpOutDS := project(inDS, transform(%outrec%,
	                    	                           
	rowIsRestrictedTmp := map(
			internal_testing                                                         => false,
			//MDR.sourceTools.SourceIsDunn_Bradstreet(left.source_field)                     => true,
			DRM.FARES      and MDR.sourceTools.SourceIsProperty(left.source_field) and left.vl_id[1] in ['R']    
													                                                     => true,
			DRM.EBR        and MDR.sourceTools.SourceIsEBR(left.source_field)              => true,
			DRM.Fidelity   and MDR.sourceTools.SourceIsProperty(left.source_field) and left.vl_id[1] in ['O','D'] 
																																							 => true,
			not ln_branded and 
			 MDR.sourceTools.SourceIsProperty(left.source_field) and left.vl_id[1] in ['D']    
																																							 => true,			
			MDR.sourceTools.SourceIsDPPA(left.source_field)
			          and not DPPA.state_ok(MDR.SourceTools.DPPAOriginState(left.source_field),DPPA.stored_value,,left.source_field) 
								                                                               => true,
			/* otherwise                                                             => */ false);
	  // now deal with GLB access
    rowIsRestrictedGLB :=  MDR.SourceTools.SourceIsGLB(left.source_field) AND 
			                        (~GLB.ok(in_mod.GLBPurpose) OR
																GLB.HeaderIsPreGLB(0,left.dt_first_seen,left.source_field)); 
    // have to keep GLB and DPPA separate ....and separate the GLB logic outside map statement
		// so that both restrictions can be made if necessary.
		// thus the additional RowIsRestrictedGLB Boolean
		// if either of these is true then we want to leave that row out
		// of the result set.
    rowIsRestricted := rowIsRestrictedTmp  OR rowIsRestrictedGLB;
		
		self := if (~(rowIsRestricted), left);
		)
		);				
	 outDS := tmpOutDS(source_field != '');
	 
ENDMACRO;

	// export boolean isRestricted(
		// string2 source,
		// string1 source_docid_1,
		// boolean ln_branded,
		// boolean internal_testing) := function
	
		// return map(
			// internal_testing                                                                                   => false,
			                   // MDR.sourceTools.SourceIsDunn_Bradstreet(source)                                 => true,
			// DRM.FARES      and MDR.sourceTools.SourceIsProperty(source)        and source_docid_1 in ['R']     => true,
			// DRM.EBR        and MDR.sourceTools.SourceIsEBR(source)                                             => true,
			// DRM.Fidelity   and MDR.sourceTools.SourceIsProperty(source)        and source_docid_1 in ['O','D'] => true,
			// not ln_branded and MDR.sourceTools.SourceIsProperty(source)        and source_docid_1 in ['D']     => true,
			// MDR.sourceTools.SourceIsDPPA(source)
			          // and not DPPA.state_ok(MDR.SourceTools.DPPAOriginState(source),DPPA.stored_value,,source) => true,
			// /* otherwise                                                                                    => */ false);
	
	// end;
	
	
	// TODO add back in the sourcedoc field check when propety comes into report.
	export MAC_RemoveRestricted(inds,my_mod,source_field,source_docid_1_field,ln_branded,internal_testing,outds) := macro
		import AutoStandardI,MDR,Codes;
		
		#uniquename(DRM)
		%DRM% := AutoStandardI.DataRestrictionI.val(my_mod);
		#uniquename(DPPA)
		%DPPA% := AutoStandardI.PermissionI_Tools.val(my_mod).DPPA;

		#uniquename(RemoveBySource)
		%RemoveBySource% := inds(not map(
			internal_testing                                                                                               
			=> false,
			MDR.sourceTools.SourceIsDunn_Bradstreet(source_field)                              
													 => true,
			%DRM%.FARES      and MDR.sourceTools.SourceIsProperty(source_field)      //  and source_docid_1_field in ['R']    
			=> true,
			%DRM%.EBR        and MDR.sourceTools.SourceIsEBR(source_field)                                               
			=> true,
			%DRM%.Fidelity   and MDR.sourceTools.SourceIsProperty(source_field)       // and source_docid_1_field in ['O','D']
			 => true,
			not ln_branded   and MDR.sourceTools.SourceIsProperty(source_field)      //  and source_docid_1_field in ['D']    
			=> true,
			false));
		
		#uniquename(RemoveDPPA)
		%RemoveDPPA% :=
			%RemoveBySource%(internal_testing or not MDR.sourceTools.SourceIsDPPA(source_field)) +
			join(
				%RemoveBySource%(not internal_testing and MDR.sourceTools.SourceIsDPPA(source_field) and %DPPA%.ok(%DPPA%.stored_value)),
				Codes.Key_Codes_V3,
				keyed(right.file_name = 'GENERAL') and
				keyed(right.field_name = map(
					MDR.SourceTools.SourceIsExperianVehicle(left.source_field) or MDR.SourceTools.SourceIsExperianDL(left.source_field) =>
						'EXPERIAN-DL-PURPOSE',
						'DL-PURPOSE')) and
				keyed(right.field_name2 = MDR.SourceTools.DPPAOriginState(left.source_field)) and
				keyed(right.code = (string1)%DPPA%.stored_value),
				transform(left),
				left only);
		
		outds := %RemoveDPPA%;

	endmacro;

	// EBR SALES CONVERSION (code and comments taken straight from TopBusiness_Services.FinanceSection)
	export convert_EBR_sales(string sales_actual) := 
	FUNCTION
		 // Convert EBCDIC signed (+/-) byte value if present in the last (7th) position.
       //  for left.sales_actual, convert position 7 which is an EBCDIC signed value
       //         "{" & "A" thru "I" to +0 thru +9 AND "}" & "J" thru "R" to -0 thru -9.
			 //  (Look into using ECL "ASCII" built-in function???)
			 // Put the sign at the front of the string since that is what ECL needs when converting 
			 // to integer.
       string8  temp_sales1 := 
			                   map(sales_actual[7] = '{' => '+' + sales_actual[1..6] + '0',
                             sales_actual[7] = 'A' => '+' + sales_actual[1..6] + '1',
                             sales_actual[7] = 'B' => '+' + sales_actual[1..6] + '2',
                             sales_actual[7] = 'C' => '+' + sales_actual[1..6] + '3',
                             sales_actual[7] = 'D' => '+' + sales_actual[1..6] + '4',
                             sales_actual[7] = 'E' => '+' + sales_actual[1..6] + '5',
                             sales_actual[7] = 'F' => '+' + sales_actual[1..6] + '6',
                             sales_actual[7] = 'G' => '+' + sales_actual[1..6] + '7',
                             sales_actual[7] = 'H' => '+' + sales_actual[1..6] + '8',
                             sales_actual[7] = 'I' => '+' + sales_actual[1..6] + '9',
														 sales_actual[7] = '}' => '-' + sales_actual[1..6] + '0',
                             sales_actual[7] = 'J' => '-' + sales_actual[1..6] + '1',
                             sales_actual[7] = 'K' => '-' + sales_actual[1..6] + '2',
                             sales_actual[7] = 'L' => '-' + sales_actual[1..6] + '3',
                             sales_actual[7] = 'M' => '-' + sales_actual[1..6] + '4',
                             sales_actual[7] = 'N' => '-' + sales_actual[1..6] + '5',
                             sales_actual[7] = 'O' => '-' + sales_actual[1..6] + '6',
                             sales_actual[7] = 'P' => '-' + sales_actual[1..6] + '7',
                             sales_actual[7] = 'Q' => '-' + sales_actual[1..6] + '8',
                             sales_actual[7] = 'R' => '-' + sales_actual[1..6] + '9',
														 // if none of the values from above, output as is ???
														 '0' + sales_actual[1..7]); //default
			 // Watch out for: "0" followed by spaces or 00000000 or +0000000 or -0000000 ???
			 // Convert all other values from string to integer4
			 integer4 temp_sales2 := if(temp_sales1 = '0       ' or 
			                            temp_sales1 = '00000000' or 
			                            temp_sales1 = '+0000000' or 
			                            temp_sales1 = '-0000000',
																	0, (integer4) temp_sales1);
       //v--- per the product requirements document, "... data is in hundreds(?) of thousands",
			 //     but on 09/21/12 Debra Winkleman in Risk Data Receiving contacted the data  
			 //     supplier and their contact person says it is in thousands.
			 // RQ-14844 - Sales is now in 100s;	
	     annual_sales_amount:= temp_sales2 * 100;	
	
		return annual_sales_amount;
	END;
  
  // Create business ids dataset from stored values
  export create_business_ids_dataset(TopBusiness_Services.iParam.BIDParams inMod) :=
  function
    boolean isBIDPopulated := inMod.UltID > 0 or inMod.OrgID > 0 or inMod.SeleID > 0 or inMod.ProxID > 0 or inMod.PowID > 0 or inMod.EmpID > 0 or inMod.DotID > 0;
    
    dBIDs := dataset([{inMod.UltID,inMod.OrgID,inMod.SeleID,inMod.ProxID,inMod.PowID,inMod.EmpID,inMod.DotID}],BIPV2.IDLayouts.l_key_ids_bare);
    
    // Format to link ids layout
    dBIDsFormat2Search := project(dBIDs,BIPV2.IDLayouts.l_xlink_ids);
    
    dSearchBIDs := if(isBIDPopulated,dBIDsFormat2Search);
    
    return dSearchBIDs;
  end;
	
	EXPORT fn_SourceDocSetIdType(STRING2 source, BOOLEAN OtherDirectoriesSource) := 
	  FUNCTION
	    RETURN(
	    if (MDR.sourceTools.SourceIsWC(source),
															               TopBusiness_Services.Constants.watercraftsrcrec,
																						 if (MDR.sourceTools.SourceIsVehicle(source),
																								TopBusiness_Services.Constants.vehiclesrcrec,
																								if (MDR.SourceTools.SourceIsLiens(source),
																										TopBusiness_Services.Constants.liensrcrec,
																										if (OtherDirectoriesSource OR MDR.sourcetools.SourceIsBusiness_Registration(source)
																										  OR MDR.SourceTools.SourceIsINFOUSA_ABIUS_USABIZ(source),
																											
																												TopBusiness_Services.Constants.sourcerecid,
																											  if (MDR.sourceTools.SourceIsBankruptcy(source),
																									          'source_docid',
															                        'vl_id')))))
	   );
	END;
	
	EXPORT fn_SourceDocSetIdValue(STRING2 source, 
	                              UNSIGNED8 source_record_id, 
	                              STRING source_docid, 
																STRING vl_id, BOOLEAN OtherDirectoriesSource) := 
	  FUNCTION
																
     RETURN(  if (MDR.sourceTools.SourceIsWC(source) OR
															                    MDR.sourceTools.SourceIsVehicle(source) OR
																									MDR.SourceTools.SourceIsLiens(source) OR
																									MDR.sourcetools.SourceIsBusiness_Registration(source) OR
																									OtherDirectoriesSource OR
																									MDR.SourceTools.SourceIsINFOUSA_ABIUS_USABIZ(source),
															                    (STRING100) source_record_id, 
																									if (MDR.sourceTools.SourceIsBankruptcy(source),
																									   source_docid,
																									vl_id))
			);																
	
	END;
	 // export DATASET(bankruptcyv2_services.layouts.layout_party_ext) 
	 // fn_mask_CHILDDS_ssns(DATASET(bankruptcyv2_services.layouts.layout_party_ext) parties,
							     // string6 in_ssn_mask) := FUNCTION
				
			// DATASET(bankruptcyv2_services.layouts.layout_name) maskPartySSNs(DATASET(bankruptcyv2_services.layouts.layout_name) ptys) := FUNCTION				
				// Suppress.MAC_Mask(ptys1, ptys_masked, ssn, null, true, false, maskVal:=in_ssn_mask);
				// RETURN ptys_masked;
			// END;
				
			// bankruptcyv2_services.layouts.layout_party_ext xt(bankruptcyv2_services.layouts.layout_party_ext l) := TRANSFORM
				// SELF.names := maskPartySSNs(l.names);
				// SELF := l
			// END;

			// Mask the SSNs in the child dataset (names)
			// parties_masked := project(parties, xt(LEFT));

			//Mask the top level SSNs
			// Suppress.MAC_Mask(parties_masked, parties_masked1, app_ssn, null, true, false, maskVal:=in_ssn_mask);
			// Suppress.MAC_Mask(parties_masked1, all_masked, ssn, null, true, false, maskVal:=in_ssn_mask);

			// return all_masked;
//END;
end;
