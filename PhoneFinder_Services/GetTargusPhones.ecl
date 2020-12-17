IMPORT doxie, Gateway, ut, MDR;

lBatchIn   := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon    := PhoneFinder_Services.Layouts.PhoneFinder.Common;
modPenalty := PhoneFinder_Services.GetPenalty;

// Targus gateway data
EXPORT GetTargusPhones( DATASET(lBatchIn)                        dIn,
												PhoneFinder_Services.iParam.SearchParams inMod,
												BOOLEAN                                  doPhoneOnlySearch = FALSE,
												Gateway.Layouts.Config                   pGateway) :=
FUNCTION
	// doOnlyPhoneSearch - check to search by only phone number or not
	lBatchIn tKeepPhoneOnly(dIn pInput) :=
	TRANSFORM
		SELF.seq       := pInput.seq;
		SELF.acctno    := pInput.acctno;
		SELF.homephone := pInput.homephone;
		SELF           := [];
	END;

	dInReformat := IF(doPhoneOnlySearch,
										PROJECT(dIn,tKeepPhoneOnly(LEFT)),
										dIn);

	// Temporary layout
	rTargus_Layout :=
	RECORD
		DATASET(doxie.layout_pp_raw_common) targus_recs;
		lBatchIn batch_in;
	END;

  mod_access := PROJECT(inMod, doxie.IDataAccess);

	rTargus_Layout tGetTargusData(dInReformat pInput) :=
	TRANSFORM
		SELF.targus_recs := doxie.MAC_Get_GLB_DPPA_Targus(TRUE,
																											pInput.homephone,pInput.name_first,pInput.name_middle,pInput.name_last,
																											pInput.prim_range,pInput.predir,pInput.prim_name,pInput.addr_suffix,
																											pInput.postdir,pInput.unit_desig,pInput.sec_range,pInput.p_city_name,pInput.st,
																											pInput.z5,pInput.zip4,mod_access,
																											inMod.ScoreThreshold,pGateway,pInput.comp_name,TRUE,
                                                      PhoneFinder_Services.Constants.GatewayMaxTimeout.Targus_RequestTimeout);
		SELF.batch_in    := pInput;
	END;

	dTargusRecs := PROJECT(dInReformat,tGetTargusData(LEFT));

	// NORMALIZE the targus records to flatten the child DATASET
	lCommon tNormTargusRecs(rTargus_Layout le,doxie.layout_pp_raw_common ri) :=
	TRANSFORM
		SELF              := ri;
		SELF              := le;
		SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.TargusGateway;
		SELF.phn_src_all  := []; // had to blank this out since we are accounting targus in getPhones
	END;

	dNormTargusRecs := NORMALIZE(dTargusRecs,LEFT.targus_recs,tNormTargusRecs(LEFT,RIGHT));

	// Calculate penalty
	lCommon tGetPenalty(dNormTargusRecs pInput) :=
	TRANSFORM
		SELF.penalt := IF(doPhoneOnlySearch,
											modPenalty.GetPhonePenalty(pInput),
											modPenalty.GetPhonePenalty(pInput) +
											modPenalty.GetAddrPenalty(pInput) +
											modPenalty.GetNamePenalty(pInput) +
											modPenalty.GetDIDPenalty(pInput) +
											modPenalty.GetDOBPenalty(pInput) +
											modPenalty.GetSSNPenalty(pInput) +
											modPenalty.GetcountyPenalty(pInput) +
											IF(pInput.batch_in.comp_name != '',ut.CompanySimilar(pInput.batch_in.comp_name,pInput.listed_name)+3,0));
		SELF        := pInput;
	END;

	dTargusPenalty := PROJECT(dNormTargusRecs,tGetPenalty(LEFT));

	// Filter out records which don't meet the penalty threshold
	dTargusPenaltyFilter := dTargusPenalty(phone <> '',penalt <= inMod.PenaltyThreshold);

	// Debug
	#IF(PhoneFinder_Services.Constants.Debug.Targus)
		OUTPUT(dIn,NAMED('dTargus_In'),EXTEND);
		OUTPUT(dInReformat,NAMED('dTargus_InReformat'),EXTEND);
		OUTPUT(dTargusRecs,NAMED('dTargusRecs'),EXTEND);
		OUTPUT(dNormTargusRecs,NAMED('dNormTargusRecs'),EXTEND);
		OUTPUT(dTargusPenalty,NAMED('dTargusPenalty'),EXTEND);
	#END

	RETURN dTargusPenaltyFilter;
END;
