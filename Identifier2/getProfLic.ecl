import doxie, iesp, ut, risk_indicators, suppress;

export getProfLic(dataset(identifier2.layout_Identifier2) indata, 
	boolean Include_proflic_Data=false,
	unsigned1 dob_mask_value = suppress.Constants.dateMask.NONE
		) := function 
	doxie.layout_references getDIDs( indata le, integer picker ) := TRANSFORM
		self.did := choose( picker, le.did, le.did2, le.did3 );
	END;
	dids := normalize(indata, 3, getDIDS(left,counter) )( did != 0 );
	
	Provider_r := doxie.ING_provider_report_recordsbyDid(dids);
	t_Provider_r := iesp.transform_medproviders(Provider_r);


	// if the termination date is not populated, don't filter it out
	goodOne := t_Provider_r(exists(licenseInfos(
		(integer)ut.GetDate < ID2Common.fromESDLDate(terminationDate)
		or terminationDate.year=0
		))
	);
	expired := exists(t_Provider_r) and not exists(goodOne);
	details := if (exists(goodOne), choosen(goodOne,iesp.constants.identifier2c.maxProflic));

	iesp.share.t_Date maskDOBs( iesp.share.t_Date le ) := TRANSFORM
		DOB := intformat(le.year,4,1) + intformat(le.month,2,1) + intformat(le.day,2,1);
		maskedDOB := risk_indicators.iid_constants.mask_dob(DOB, dob_mask_value);
		
		self.year  := (integer)maskedDOB[1..4];
		self.month := (integer)maskedDOB[5..6];
		self.day   := (integer)maskedDOB[7..8];
	END;

	iesp.proflicense.t_ProviderRecord maskDOB(details le) := transform
		self.dobs := project( le.dobs, maskDOBs(left) );
		self := le;
	end;
	mDOB := project(details, maskDOB(left));
	
	found := exists(t_Provider_r);

	identifier2.layout_Identifier2 add_proflic(indata le) := TRANSFORM
		self.ProfessionalLicense.HasValidProfessionalLicense := if (found and not expired, true, false); 
		self.ProfessionalLicense.ProviderRecord := if (found and Include_ProfLic_Data, mDOB[1]);
		self.ProfessionalLicense.RiskIndicators := MAP (
			not found => dataset([iesp.ECL2ESP.setRiskIndicator('PN',Identifier2.getRiskStatusDesc('PN'))], iesp.share.t_RiskIndicator),
			expired => dataset([iesp.ECL2ESP.setRiskIndicator('PE',Identifier2.getRiskStatusDesc('PE'))], iesp.share.t_RiskIndicator),   												
			dataset([], iesp.share.t_RiskIndicator)
		);
		self.ProfessionalLicense.StatusIndicators := IF (found and not expired,
			dataset([iesp.ECL2ESP.setStatusIndicator('PF',Identifier2.getRiskStatusDesc('PF'))], iesp.share.t_RiskIndicator),
			dataset([], iesp.share.t_RiskIndicator)
		);
		self := le;
	end;

	with_proflic := project(indata, add_proflic(left));

	return with_proflic;

end;