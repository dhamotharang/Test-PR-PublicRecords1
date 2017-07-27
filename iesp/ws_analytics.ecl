export ws_analytics := MODULE
			
export t_SmallBusinessRiskOptions := record (share.t_BaseSearchOptionEx)
end;
		
export t_BusinessInfo := record
	string Name {xpath('Name')};
	string AlternateName {xpath('AlternateName')};
	share.t_Address Address {xpath('Address')};
	string FEIN {xpath('FEIN')};
	string Phone10 {xpath('Phone10')};
end;
		
export t_OwnerAgentInfo := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string SSN {xpath('SSN')};
	share.t_Date DOB {xpath('DOB')};
	string Phone10 {xpath('Phone10')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string DriverLicenseState {xpath('DriverLicenseState')};
end;
		
export t_SmallBusinessRiskSearchBy := record
	t_BusinessInfo Business {xpath('Business')};
	t_OwnerAgentInfo OwnerAgent {xpath('OwnerAgent')};
end;
		
export t_SmallBusinessScoreHRI := record
	string _Type {xpath('Type')};
	integer Value {xpath('Value')};
	integer Index {xpath('Index')};//hidden[internal]
	dataset(share.t_RiskIndicator) BusinessHighRiskIndicators {xpath('BusinessHighRiskIndicators/HighRiskIndicator'), MAXCOUNT(Constants.MaxCountSmallBusinessHRI)};
	dataset(share.t_RiskIndicator) OwnerAgentHighRiskIndicators {xpath('OwnerAgentHighRiskIndicators/HighRiskIndicator'), MAXCOUNT(Constants.MaxCountSmallBusinessHRI)};
end;
		
export t_SmallBusinessModelHRI := record
	string Name {xpath('Name')};
	string Description {xpath('Description')};
	dataset(t_SmallBusinessScoreHRI) Scores {xpath('Scores/Score'), MAXCOUNT(1)};
end;
		
export t_SmallBusinessRiskResult := record
	t_SmallBusinessRiskSearchBy InputEcho {xpath('InputEcho')};
	dataset(t_SmallBusinessModelHRI) Models {xpath('Models/Model'), MAXCOUNT(Constants.MaxCountSmallBusinessModels)};
end;
		
export t_SmallBusinessRiskResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_SmallBusinessRiskResult Result {xpath('Result')};
end;
		
export t_SmallBusinessRiskRequest := record (share.t_BaseRequest)
	t_SmallBusinessRiskOptions Options {xpath('Options')};
	t_SmallBusinessRiskSearchBy SearchBy {xpath('SearchBy')};
end;
		
export t_SmallBusinessRiskResponseEx := record
	t_SmallBusinessRiskResponse response {xpath('response')};
end;
		

end;

