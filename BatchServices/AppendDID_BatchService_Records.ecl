Import Batchservices, DidVille, risk_indicators, suppress, ut, AutoStandardI, STD;
EXPORT APPendDID_batchService_Records := MODULE
	EXPORT Search(DATASET (  BatchServices.AppendDid_BatchService_Layouts.layout_did_InbatchWithAcctnoWithDID) Ds_batchInProcessed,
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
												 STRING6 	 ssnMaskVal,
                      unsigned8 MaxResultsPerAcct,
                      boolean IncludeRanking,
                      boolean DoPartialSuppression
            ) := FUNCTION

recs := PROJECT(Ds_batchInProcessed,
               TRANSFORM(DidVille.Layout_Did_OutBatch,							    
							    SELF.seq :=  (unsigned4) LEFT.acctno;
									SELF.SSN :=  std.str.filter(LEFT.ssn,'0123456789');
									SELF := LEFT));
											
IndustryClass := ut.IndustryClass.Get();
Limit_MaxResultsPerAcct := BatchServices.Constants.Didville.Limit_MaxResultsPerAcct;

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
inLimit :=if(MaxResultsPerAcct > Limit_MaxResultsPerAcct,Limit_MaxResultsPerAcct,MaxResultsPerAcct);
// call common did function here.
res1TMP := didville.did_service_common_function(recs, appends, verify, fuzzy, dedup_results, 
                                            thresh_num, GLB, patriotproc, false, 
																						false, hhidplus, edabest, glb_purpose_value, 
																						include_minors,,UseNonBlankKey, appType, soap_xadl_version_value,
																						inLimit,IndustryClass_val := IndustryClass
																						);																																												
 ResultsRanking_pre := Didville.fn_GetRankedAddress(UNGROUP(res1TMP), params_mod);
   
 ResultsRanking := IF(IncludeRanking, GROUP(SORT(ResultsRanking_pre, seq, -score), seq), 
                                        SORT(res1TMP, seq, -score));
			
// appends adl_category and changes the Seq# back to acctno so that it
// is back into subset of the layout that was passed in
BatchServices.AppendDid_BatchService_Layouts.layout_did_outBatchAdlCatWacctno add_adl_cat(res1Tmp L, risk_indicators.key_ADL_Risk_Table_v4 R) := transform			
	category := TRIM(stringlib.stringtouppercase(R.adl_category));		
	self.adl_Category := Risk_Indicators.iid_constants.adlCategory(category);
	SELF.Acctno := (STRING20) L.SEQ;
	self := L;
end;
	
ds_batchResults := JOIN(ResultsRanking, risk_indicators.key_ADL_Risk_Table_v4, left.did != 0 and keyed(left.did=right.did), 
												add_adl_cat(LEFT,RIGHT), left outer,limit(0),KEEP(1));												
		
// a temporary layout for partial suppression :
 layout_did_outBatchAdlCatWacctno_plus := 
          record(BatchServices.AppendDid_BatchService_Layouts.layout_did_outBatchAdlCatWacctno)
                 unsigned row_counter 
          end;
        
// add a row counter 
layout_did_outBatchAdlCatWacctno_plus AddCounter(BatchServices.AppendDid_BatchService_Layouts.layout_did_outBatchAdlCatWacctno l,
                                                 integer c ) := transform
           self.row_counter := c;
           self := l ;
      end;     
                                          
ds_batchResults_with_numbers := project(UNGROUP(ds_batchResults),AddCounter(left,counter));
 
// do suppression of DID and then masking of SSN
Suppress.MAC_Suppress(ds_batchResults_with_numbers,ResultsSuppressedFully,appType,Suppress.Constants.LinkTypes.DID,DID,
                       batch := true,use_acctno := true,retainField:= row_counter);
ResultsSuppressedPartialy :=  join(ds_batchResults_with_numbers,ResultsSuppressedFully,
                                   left.row_counter = right.row_counter,
                                   transform(layout_did_outBatchAdlCatWacctno_plus,
                                             self.did := left.did,
                                             self.hhid := left.hhid,
                                             self.score := left.score,
                                             self := right)
                                   );
                                   
ResultsSuppressed := project(if(DoPartialSuppression,ResultsSuppressedPartialy,ResultsSuppressedFully),
                              BatchServices.AppendDid_BatchService_Layouts.layout_did_outBatchAdlCatWacctno   
                             );                       
Suppress.MAC_Mask(ResultsSuppressed,ResultsMasked, ssn, null, true, false, maskVal:=ssnMaskVal);	
    
 //output(ds_batchResults_with_numbers,named('ds_batchResults_with_numbers'));
 
	RETURN (ResultsMasked);
	END;
END;