IMPORT InsuranceHeader_xLink,UT,IDLExternalLinking;

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
		DidVille.Layout_Did_InBatch;
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
	
	EXPORT PII_STABILITY_WEIGHTS(DATASET(DidVille.Layout_Did_InBatch) INPUT) := FUNCTION 

		//code for getting data W20161109-135923
		//Example W20161216-103856
		interm := PROJECT(INPUT,TRANSFORM(PII_weight_interm_layout,
											SELF.UniqueID := LEFT.seq; SELF.SSN5 := LEFT.SSN[1..5]; 
											SELF.SSN4 := LEFT.SSN[6..9]; SELF:= LEFT));
											
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
																						z5,
																						ssn5,
																						ssn4,
																						dob, 
																						phone10,
																						,//DL_STATE,
																						,//DL_NBR, 
																						,// src
																						,// src_rid
																						,// fname2
																						,// lname2																						
																						outfile
																						);			
																						
		RETURN NORMALIZE(outfile,LEFT.results,
									TRANSFORM(PII_weight_output_layout,SELF:=RIGHT))(did<IDLExternalLinking.Constants.INSURANCE_LEXID);
	END;
END;