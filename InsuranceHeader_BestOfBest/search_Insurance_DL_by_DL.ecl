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

EXPORT search_Insurance_DL_by_DL(grouped DATASET(InsuranceHeader_BestOfBest.Layouts.InsuranceDL_Layout_Input) indata, integer dppa, boolean isFCRA=false,
																 string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := function

// check that user has permissible purpose to see DL data
	//dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);
	dl_ok	:= Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);
	
//Inquiries and Insurance contributory sources don't have to be filtered by the codes v3 table
	Contributory_Sources := ['IVS','ICA'];

InsuranceHeader_BestOfBest.Layouts.InsuranceDL_DL_Output get_DL(indata le, InsuranceHeader_PostProcess.AncillaryKeys().dln.qa ri) := TRANSFORM
	self.DL_Data_Used := if(ri.dl_nbr<>'', 1, 0);
	self:=le;
	self:=ri;
END;

InsuranceDL_by_DL_roxie := join(indata, InsuranceHeader_PostProcess.AncillaryKeys().dln.qa, 
										((StringLib.StringToUpperCase(right.src[1..3]) in Contributory_Sources or StringLib.StringToUpperCase(right.src) = 'MVRINQ') or drivers.state_dppa_ok(left.dl_st,dppa)) and 
										dl_ok and 
										left.dl_number<>'' and  left.dl_st<>'' and 
										left.Firstname<>'' and left.LastName<>'' and 
										keyed(left.dl_number=right.dl_nbr),
										get_DL(LEFT,RIGHT),
										left outer, atmost(riskwise.max_atmost), keep(100));

InsuranceDL_by_DL_thor_pre := join(distribute(indata(dl_number<>'' and  dl_st<>''), hash64(dl_number)), 
										distribute(pull(InsuranceHeader_PostProcess.AncillaryKeys().dln.qa), hash64(dl_nbr)), 
										left.Firstname<>'' and left.LastName<>'' and 
										((StringLib.StringToUpperCase(right.src[1..3]) in Contributory_Sources or StringLib.StringToUpperCase(right.src) = 'MVRINQ') or drivers.state_dppa_ok(left.dl_st,dppa)) and 
										dl_ok and 
										(left.dl_number=right.dl_nbr),
										get_DL(LEFT,RIGHT),
										left outer, atmost(left.dl_number=right.dl_nbr, riskwise.max_atmost), keep(100), LOCAL);
										
InsuranceDL_by_DL_thor := group(InsuranceDL_by_DL_thor_pre + project(indata(dl_number='' or  dl_st=''), 
										transform(InsuranceHeader_BestOfBest.Layouts.InsuranceDL_DL_Output, SELF := LEFT, SELF := [])), seq);

#IF(onThor)
	InsuranceDL_by_DL := InsuranceDL_by_DL_thor;
#ELSE
	InsuranceDL_by_DL := InsuranceDL_by_DL_roxie;
#END

return InsuranceDL_by_DL;

end;