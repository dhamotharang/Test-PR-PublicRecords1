IMPORT BatchDatasets, iesp, Residency_Services, Risk_Indicators, RiskWise;

EXPORT fn_getIID(DATASET(Residency_Services.Layouts.IntermediateData) ds_input,
                 Residency_Services.IParam.BatchParams mod_params) := FUNCTION

	ds_input_projtd := PROJECT(ds_input, 
	                           TRANSFORM(BatchDatasets.Layouts.layout_batch_in_waddr_status,
													     SELF.AcctNo			:= (STRING8)LEFT.seq, // TO ensure we can join back properly
                               SELF.Did         := LEFT.did; 
													     SELF.Name_First 	:= LEFT.name_first,
													     SELF.Name_Middle := LEFT.name_middle,
													     SELF.Name_Last		:= LEFT.name_last,
													     SELF.Name_Suffix	:= LEFT.name_suffix,
													     SELF.Prim_Range 	:= LEFT.prim_range,
													     SELF.Predir			:= LEFT.predir,
													     SELF.Prim_Name		:= LEFT.prim_name,
													     SELF.Addr_Suffix	:= LEFT.addr_suffix,
													     SELF.Postdir			:= LEFT.postdir,
													     SELF.Unit_Desig	:= LEFT.unit_desig,
													     SELF.Sec_Range		:= LEFT.sec_range,
													     SELF.p_City_name	:= LEFT.p_city_name,
													     SELF.St					:= LEFT.st,
													     SELF.Z5					:= LEFT.z5,
													     SELF.SSN 				:= LEFT.ssn,
													     SELF.DOB					:= LEFT.dob,
														));

  // Get the Instant ID data
	ds_IID_recs := BatchDatasets.fetch_InstantID_recs(ds_input_projtd, mod_params );

	UNSIGNED1 NumReturnCodes := risk_indicators.iid_constants.DefaultNumCodes;
	BOOLEAN   IsInstantID := TRUE;
	UNSIGNED1 IIDVersion  := 0;	
	reasoncode_settings := DATASET([{IsInstantID, IIDVersion}],riskwise.layouts.reasoncode_settings);
  // From requirements document, req 4.3.5 ---v
	SET OF STRING2 ACCEPTABLE_HRI_CODES := ['04','07','25','CZ','PA','MS','29'];

	rec_hrichild:= RECORD
	  STRING8   acctno;
		UNSIGNED3 seq;		
    DATASET(risk_indicators.Layout_Desc) HRI;
  END;	
	
	//create dataset with seq and child dataset of codes and desc
	rec_hrichild tf_fillchildren(ds_IID_recs L) := TRANSFORM
		 reasonCodes := risk_indicators.reasonCodes(L, NumReturnCodes, reasoncode_settings);
		 fltrd_hri   := reasonCodes(hri IN ACCEPTABLE_HRI_CODES); 
	  SELF.acctno  := '';
	  SELF.seq     := L.seq;
	  SELF.hri     := fltrd_hri ;
	END;
	
	ds_hrichildren := PROJECT(ds_IID_recs, tf_fillchildren(LEFT));
	
	ds_IID_ret := JOIN(ds_input, ds_hrichildren,
									     LEFT.seq = RIGHT.seq,
									   TRANSFORM(Residency_Services.Layouts.IntermediateData,
											 // Split child dataset first 5 recs into a flat layout
	                     SELF.numhris         := COUNT(RIGHT.HRI);
		                   BOOLEAN Hrisk1_found := RIGHT.HRI[1].hri != '';
		                   BOOLEAN Hrisk2_found := RIGHT.HRI[2].hri != '';
		                   BOOLEAN Hrisk3_found := RIGHT.HRI[3].hri != '';
		                   BOOLEAN Hrisk4_found := RIGHT.HRI[4].hri != '';
		                   BOOLEAN Hrisk5_found := RIGHT.HRI[5].hri != '';
		                   SELF.hrisk_1      := IF(Hrisk1_found,RIGHT.HRI[1].hri,'');
		                   SELF.hrisk_desc_1 := IF(Hrisk1_found,RIGHT.HRI[1].desc,'');
		                   SELF.hrisk_2      := IF(Hrisk2_found,RIGHT.HRI[2].hri,'');
		                   SELF.hrisk_desc_2 := IF(Hrisk2_found,RIGHT.HRI[2].desc,'');
		                   SELF.hrisk_3      := IF(Hrisk3_found,RIGHT.HRI[3].hri,'');
		                   SELF.hrisk_desc_3 := IF(Hrisk3_found,RIGHT.HRI[3].desc,'');
		                   SELF.hrisk_4      := IF(Hrisk4_found,RIGHT.HRI[4].hri,'');
		                   SELF.hrisk_desc_4 := IF(Hrisk4_found,RIGHT.HRI[4].desc,'');
		                   SELF.hrisk_5      := IF(Hrisk5_found,RIGHT.HRI[5].hri,'');
		                   SELF.hrisk_desc_5 := IF(Hrisk5_found,RIGHT.HRI[5].desc,'');
											 SELF := LEFT),
									   LEFT OUTER);
  
	//OUTPUT(ds_input,        NAMED('ds_input'));
	//OUTPUT(ds_input_projtd, NAMED('ds_input_projtd'));
	//OUTPUT(ds_IID_recs,     NAMED('ds_IID_recs'));
	//OUTPUT(ds_hrichildren,  NAMED('ds_hrichildren'));
	//OUTPUT(ds_IID_ret,      NAMED('ds_IID_ret'));

	RETURN(ds_IID_ret);
	
END;
 