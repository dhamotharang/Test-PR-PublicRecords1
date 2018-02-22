Import Batchservices, DidVille, risk_indicators, suppress, ut, AutoStandardI, STD;
EXPORT APPendDID_batchService_Records := MODULE
	EXPORT Search(DATASET (  BatchServices.AppendDid_BatchService_Layouts.Layout_did_inBatchWithAcctnoBatchShare) Ds_batchInProcessed,
												 STRING120 Appends,
												 STRING120 verify, 
												 STRING120 fuzzy,
												 boolean 	 dedup_results,
												 unsigned2 thresh_num,																														
												 boolean   GLB_data,
												 boolean 	 patriotproc,												
												 unsigned1 glb_purpose_value,											
												 boolean 	 Include_minors,
												 boolean 	 useNonBlankKey,
												 STRING32  appType,		
												 unsigned1 soap_xadl_version_value,
												 STRING6 	 ssnMaskVal
            ) := FUNCTION

recs := PROJECT(Ds_batchInProcessed,
               TRANSFORM(DidVille.Layout_Did_OutBatch,							    
							    SELF.seq :=  (unsigned4) LEFT.acctno;
									SELF.SSN :=  std.str.filter(LEFT.ssn,'0123456789');
									SELF := LEFT));
											
IndustryClass := ut.IndustryClass.Get();

params_mod := module(AutoStandardI.PermissionI_Tools.params)
	export boolean 	 AllowAll 					 := false;
	export boolean 	 AllowGLB     			 := false;
	export boolean 	 AllowDPPA 					 := false;
	export unsigned1 DPPAPurpose         := 0;
	export unsigned1 GLBPurpose 				 := glb_purpose_value;
	export boolean   IncludeMinors       := include_minors;
END;

GLB := AutoStandardI.PermissionI_Tools.val(params_mod).glb.ok(glb_purpose_value) OR GLB_data;
hhidplus := std.str.find(appends,'HHID_PLUS',1)<>0;
edabest := std.str.find(appends,'BEST_EDA',1)<>0;
// call common did function here.
res1TMP := didville.did_service_common_function(recs, appends, verify, fuzzy, dedup_results, 
                                            thresh_num, GLB, patriotproc, false, 
																						false, hhidplus, edabest, glb_purpose_value, 
																						include_minors,,UseNonBlankKey, appType, soap_xadl_version_value,
																						IndustryClass_val := IndustryClass
																						);																																												

// do supporession of DID and then masking of SSN
Suppress.MAC_Suppress(res1Tmp,res1TmpPulled,appType,Suppress.Constants.LinkTypes.DID,DID);
Suppress.MAC_Mask(res1TmpPulled,ResultsSuppressed, ssn, null, true, false, maskVal:=ssnMaskVal);	
			
// appends adl_category and changes the Seq# back to acctno so that it
// is back into subset of the layout that was passed in
BatchServices.AppendDid_BatchService_Layouts.layout_did_outBatchAdlCatWacctno add_adl_cat(res1Tmp L, risk_indicators.key_ADL_Risk_Table_v4 R) := transform			
	category := TRIM(stringlib.stringtouppercase(R.adl_category));		
	self.adl_Category := Risk_Indicators.iid_constants.adlCategory(category);
	SELF.Acctno := (STRING20) L.SEQ;
	self := L;
end;
	
ds_batchResults := JOIN(ResultsSuppressed, risk_indicators.key_ADL_Risk_Table_v4, left.did != 0 and keyed(left.did=right.did), 
												add_adl_cat(LEFT,RIGHT), left outer,limit(0),KEEP(1));												
		
// output(recs, named('recs'));
// output(res1TMP, named('res1TMP'));								
	RETURN (Ds_batchResults);
	END;
END;