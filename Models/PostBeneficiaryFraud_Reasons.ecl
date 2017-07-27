IMPORT Risk_Indicators;

EXPORT PostBeneficiaryFraud_Reasons(Layout_PostBeneficiaryFraud.Final_Plus pbf) := MODULE

	EXPORT makeRC(STRING4 code) := DATASET(
	                                 [
																	   {code, Risk_Indicators.getHRIDesc(code)}
																	 ],
																	 Risk_Indicators.Layout_Desc);

  // Reason Codes for the Post Beneficiary Fraud product (PBF)
  EXPORT rcPBF000 := Risk_Indicators.rcSet.isCodePBF000(TRUE); // Only call this when nothing is found
  EXPORT rcPBF010 := Risk_Indicators.rcSet.isCodePBF010((UNSIGNED)pbf.UCCFiling);
  EXPORT rcPBF020 := Risk_Indicators.rcSet.isCodePBF020((UNSIGNED)pbf.BankruptcyCount);
  EXPORT rcPBF030 := Risk_Indicators.rcSet.isCodePBF030((UNSIGNED)pbf.LiensorJudgments);
  EXPORT rcPBF040 := Risk_Indicators.rcSet.isCodePBF040(pbf.BusinessAffiliations);
  EXPORT rcPBF050 := Risk_Indicators.rcSet.isCodePBF050(pbf.ProfLicIssued);
  EXPORT rcPBF060 := Risk_Indicators.rcSet.isCodePBF060(pbf.PossibleIncarceration, pbf.PossibleSOFR);
  EXPORT rcPBF070 := Risk_Indicators.rcSet.isCodePBF070(pbf.PossibleWorkLocation);
  EXPORT rcPBF080 :=
	         Risk_Indicators.rcSet.isCodePBF080(pbf.CurrentBestAddressHighRisk, pbf.CurrentBestAddressBusiness,
		                                          pbf.CurrentBestAddressVacant, pbf.CurrAddrPrison);
  EXPORT rcPBF090 := Risk_Indicators.rcSet.isCodePBF090((UNSIGNED)pbf.WatercraftCount,
	                                                      (UNSIGNED)pbf.AircraftCount);
  EXPORT rcPBF100 := Risk_Indicators.rcSet.isCodePBF100(pbf.MVRvaluegreaterthanthreshold, pbf.MVRCommercial);
  EXPORT rcPBF110 := Risk_Indicators.rcSet.isCodePBF110((UNSIGNED)pbf.NumUnreportedMVR);
  EXPORT rcPBF120 := Risk_Indicators.rcSet.isCodePBF120((UNSIGNED)pbf.NumMultipleProperties);
  EXPORT rcPBF130 := Risk_Indicators.rcSet.isCodePBF130(pbf.MultipleProperties);
  EXPORT rcPBF140 := Risk_Indicators.rcSet.isCodePBF140((UNSIGNED)pbf.NumofAdults);
  EXPORT rcPBF150 := Risk_Indicators.rcSet.isCodePBF150(pbf.PossibleIncarceration, pbf.CurrAddrPrison);
  EXPORT rcPBF160 := Risk_Indicators.rcSet.isCodePBF160(pbf.IdentityValid);
  EXPORT rcPBF170 := Risk_Indicators.rcSet.isCodePBF170(pbf.DLnumoutofState);
  EXPORT rcPBF180 := Risk_Indicators.rcSet.isCodePBF180(pbf.castate, pbf.input_state);
  EXPORT rcPBF190 := Risk_Indicators.rcSet.isCodePBF190(pbf.DuplicateEntry);
  EXPORT rcPBF200 := Risk_Indicators.rcSet.isCodePBF200(pbf.matchcode);
  EXPORT rcPBF210 := Risk_Indicators.rcSet.isCodePBF210(pbf.matchcode);
  EXPORT rcPBF220 := Risk_Indicators.rcSet.isCodePBF220(pbf.matchcode);

END;