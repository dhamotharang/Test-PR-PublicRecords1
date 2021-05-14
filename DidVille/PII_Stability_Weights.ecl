﻿IMPORT InsuranceHeader_xLink,UT,IDLExternalLinking, InsuranceHeader_PostProcess;

/*
This module is for the statistical analysis team to be able to run searches 
against the header to be able to get weight values back for different PII. 

This module runs small batch searchs on the header 
and gets back the weight values of the different search stats used. 

To run, just give the function below a dataset in the layout of
DidVille.Layout_Did_InBatch. 
*/

EXPORT PII_STABILITY_WEIGHTS := MODULE
	
	SHARED PII_weight_interm_layout := RECORD
		UNSIGNED6 UniqueID;
		STRING5 SSN5;
		STRING4 SSN4;
		DidVille.Layout_Did_InBatch_v2;
		DATASET(InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases) ZIP_cases;
	END; 

	EXPORT PII_weight_output_layout := RECORD
		UNSIGNED8 reference;
		UNSIGNED8 did;
		INTEGER2 weight;
		INTEGER2 dobweight;
		INTEGER2 fnameweight;
		INTEGER2 lnameweight;
		INTEGER2 phoneweight;
		INTEGER2 prim_nameweight;
		INTEGER2 prim_rangeweight; 
		INTEGER2 ssn4weight;
		INTEGER2 ssn5weight;
	END; 
	
	EXPORT PII_STABILITY_WEIGHTS(DATASET(DidVille.Layout_Did_InBatch_v2) INPUT) := FUNCTION

		//code for getting data W20161109-135923
		//Example W20161216-103856
		interm := PROJECT(INPUT,TRANSFORM(PII_weight_interm_layout,
											SELF.UniqueID := LEFT.seq; SELF.SSN5 := LEFT.SSN[1..5]; 
											SELF.SSN4 := LEFT.SSN[6..9]; 
											SELF.ZIP_cases := Dataset([{LEFT.Z5, 100}],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases) ;
											SELF:= LEFT));

		InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch(interm, 
																						UniqueID, 
																						, // did
																						suffix, 
																						fname,
																						mname,
																						lname,
																						, // gender
																						prim_range,
																						prim_name,
																						sec_range,
																						p_city_name,
																						st,
																						ZIP_cases,
																						ssn5,
																						ssn4,
																						dob, 
																						phone10,
																						dl_state,
																						dl_nbr,
																						,// src
																						,// src_rid
																						relative_fname,
																						relative_lname,
																						,// vin
																						outfile
																						);


				// remove insurance LexIDs
		resNorm := NORMALIZE(outfile,LEFT.results,
									TRANSFORM(PII_weight_output_layout,SELF:=RIGHT));

		resPR := JOIN(resNorm,InsuranceHeader_PostProcess.segmentation_keys.key_did_ind,
                     KEYED(left.did = right.did),
                        transform(RECORDOF(LEFT),
                            lexID_type := right.lexID_type;
														self.did := IF(LexID_type<>IDLExternalLinking.Constants.INSURANCE_LEXID_TYPE and
																					left.did<IDLExternalLinking.Constants.INSURANCE_LEXID, left.did, 0);
                            self := left), left outer, keep(1));
		RETURN resPR(not(did=0 and weight>0));
	END;
END;