import doxie, iesp, personReports, risk_indicators;

export getImposters(dataset(identifier2.layout_Identifier2) indata,
                    doxie.IDataAccess mod_access, 
                    boolean Include_Imposter_Data,
										boolean IsFCRA,
										PersonReports.IParam.personal personParams) := function 

  dids := project(indata, transform(doxie.layout_references, self.did := left.did));
  pers := PersonReports.Person_records(dids, mod_access, personParams, IsFCRA);
  imposters := pers.imposters;
  found := exists(imposters);
	ADLCount := count(dedup(sort(imposters.akas, uniqueid), uniqueid));
	LastNameCount := count(dedup(sort(imposters.akas,name.last),name.last));
	details := choosen (imposters,  iesp.constants.identifier2c.maxImposter);
	
	
	iesp.bps_share.t_BpsReportDriverLicense maskDOB(iesp.bps_share.t_BpsReportDriverLicense le) := transform
		dlDOB := intformat(le.dob.year,4,1) + intformat(le.dob.month,2,1) + intformat(le.dob.day,2,1);
		maskedDLdob := risk_indicators.iid_constants.mask_dob(dlDOB, mod_access.dob_mask);
		self.dob.year := (integer)maskedDLdob[1..4];
		self.dob.month := (integer)maskedDLdob[5..6];
		self.dob.day := (integer)maskedDLdob[7..8];
		
		self := le;
	end;
	iesp.bps_share.t_BpsReportIdentity maskDOB2(iesp.bps_share.t_BpsReportIdentity le) := transform
		self.driverlicenses := project(le.driverlicenses, maskDOB(left));
		akaDOB := intformat(le.dob.year,4,1) + intformat(le.dob.month,2,1) + intformat(le.dob.day,2,1);
		maskedAKAdob := risk_indicators.iid_constants.mask_dob(akaDOB, mod_access.dob_mask);
		self.dob.year := (integer)maskedAKAdob[1..4];
		self.dob.month := (integer)maskedAKAdob[5..6];
		self.dob.day := (integer)maskedAKAdob[7..8];
		self := le;
	end;
	maskedAKAs := dataset([{project(details[1].akas, maskDOB2(LEFT))}], iesp.bps_share.t_bpsreportimposter);
	 
	 
identifier2.layout_Identifier2 add_imposters(indata le) := TRANSFORM	
	self.AdditionalIdentities.HasImposters := if (found,true, false);             //a record containing a child recset
	self.AdditionalIdentities.UniqueADLCount := if (found, ADLCount, 0);   
	self.AdditionalIdentities.UniqueLastNameCount := if (found, LastNameCount, 0);   
	self.AdditionalIdentities.Imposters := if (found and Include_Imposter_Data, maskedAKAs[1]);
	self.AdditionalIdentities.RiskIndicators :=if (~found,dataset([iesp.ECL2ESP.setRiskIndicator('MU',Identifier2.getRiskStatusDesc('MU'))], iesp.share.t_RiskIndicator) ,dataset([], iesp.share.t_RiskIndicator)) ;	
	self.AdditionalIdentities.StatusIndicators :=if (found,dataset([iesp.ECL2ESP.setStatusIndicator('MF',Identifier2.getRiskStatusDesc('MF'))], iesp.share.t_RiskIndicator) ,dataset([], iesp.share.t_RiskIndicator)) ;

	self := le;
end;

with_imposters := project(indata, add_imposters(left));

return with_imposters;

end;
