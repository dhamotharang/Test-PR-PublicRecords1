Import _Control, InsuranceHeader_PostProcess, InsuranceHeader_BestOfBest, Risk_Indicators, riskwise, drivers;
onThor := _Control.Environment.OnThor;

//*************************************************************************************************
//This function searches Insurance Header information, we can't return that raw data to customers!!
//DO NOT REPRODUCE THE SEARCH OF THIS DATA, ALL ACCESS NEEDS TO BE DONE THROUGH THIS FUNCTION
//Access to this data has to be autorized by FDN team
//When accessing this data, royalty tracking is required, such as the following:
//		Boolean TrackInsuranceRoyalties := Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);
//		insurance := If(TrackInsuranceRoyalties, Royalty.RoyaltyFDNDLDATA.GetWebRoyalties(UNGROUP(ret), did, insurance_dl_used, true));
//*************************************************************************************************

EXPORT search_Insurance_DL_by_DID(grouped DATASET(InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input) indata, integer dppa, boolean isFCRA=false,
																 string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := function

// check that user has permissible purpose to see DL data
	//dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);
	dl_ok	:= Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);

//Inquiries and Insurance contributory sources don't have to be filtered by the codes v3 table
	Contributory_Sources := ['IVS','ICA'];

InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Did_Output get_IndsuranceDL_by_DID(indata le, InsuranceHeader_PostProcess.AncillaryKeys().did.qa ri) := TRANSFORM
	self.DL_Data_Used := if(ri.dl_nbr<>'', 1, 0);
	self:=le;
	self:=ri;
END;

InsuranceDL_by_DID_roxie := join(indata, InsuranceHeader_PostProcess.AncillaryKeys().did.qa, 
											((StringLib.StringToUpperCase(right.src[1..3]) in Contributory_Sources or StringLib.StringToUpperCase(right.src) = 'MVRINQ') or drivers.state_dppa_ok(left.dl_st,dppa)) and
											dl_ok and
											left.did<>0 and                                                                 
											keyed(left.did=right.did),
											get_IndsuranceDL_by_DID(LEFT,RIGHT),
											left outer, atmost(riskwise.max_atmost), keep(100));
											
InsuranceDL_by_DID_thor_pre := join(distribute(indata(did<>0), hash64(did)), 
											distribute(pull(InsuranceHeader_PostProcess.AncillaryKeys().did.qa), hash64(did)), 
											((StringLib.StringToUpperCase(right.src[1..3]) in Contributory_Sources or StringLib.StringToUpperCase(right.src) = 'MVRINQ') or drivers.state_dppa_ok(left.dl_st,dppa)) and
											dl_ok and
											(left.did=right.did),
											get_IndsuranceDL_by_DID(LEFT,RIGHT),
											left outer, atmost(left.did=right.did, riskwise.max_atmost), keep(100), LOCAL);

InsuranceDL_by_DID_thor := InsuranceDL_by_DID_thor_pre + project(indata(did=0), transform(InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Did_Output, self := left, self := []));

#IF(onThor)
  InsuranceDL_by_DID := group(InsuranceDL_by_DID_thor, did);
#ELSE
  InsuranceDL_by_DID := InsuranceDL_by_DID_roxie;
#END

return InsuranceDL_by_DID;

end;