export merchantvessel := MODULE
			
export t_VesselSearchBy := record
	string CompanyName {xpath('CompanyName')};
	string OfficialNumber {xpath('OfficialNumber')};
	string HullNumber {xpath('HullNumber')};
	string VesselName {xpath('VesselName')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_VesselOption := record (share.t_BaseSearchOption)
	integer ReturnCount {xpath('ReturnCount')};
	integer StartingRecord {xpath('StartingRecord')};
end;
		
export t_VesselRecord := record
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
	string OfficialNumber {xpath('OfficialNumber')};
	string HullNumber {xpath('HullNumber')};
	string VesselNumber {xpath('VesselNumber')};
	string VesselName {xpath('VesselName')};
	string VesselDatabaseKey {xpath('VesselDatabaseKey')};
	string CurrentFlag {xpath('CurrentFlag')};
	string CompanyName {xpath('CompanyName')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
end;
		
export t_VesselSearchResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_VesselRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_VesselReportVesselIdKey := record
	string VesselNumber {xpath('VesselNumber')};
	string VesselDatabaseKey {xpath('VesselDatabaseKey')};
end;
		
export t_VesselReportBy := record
	t_VesselReportVesselIdKey VesselIdKey {xpath('VesselIdKey')};
end;
		
export t_VesselReportOption := record (share.t_BaseReportOption)
end;
		
export t_VesselReportRecord := record
	share.t_Name Name {xpath('Name')};
	string Gender {xpath('Gender')};
	string CompanyName {xpath('CompanyName')};
	share.t_Address Address {xpath('Address')};
	share.t_Date DateLastSeen {xpath('DateLastSeen')};
	string OfficialNumber {xpath('OfficialNumber')};
	string HullNumber {xpath('HullNumber')};
	string VesselId {xpath('VesselId')};
	string VesselName {xpath('VesselName')};
	string VesselDatabaseKey {xpath('VesselDatabaseKey')};
	boolean SelfPropelled {xpath('SelfPropelled')};
	string VesselServiceType {xpath('VesselServiceType')};
	string RegisteredLength {xpath('RegisteredLength')};
	string RegisteredBreadth {xpath('RegisteredBreadth')};
	string RegisteredDepth {xpath('RegisteredDepth')};
	string RegisteredGrossTons {xpath('RegisteredGrossTons')};
	string RegisteredNetTons {xpath('RegisteredNetTons')};
	integer VesselBuildYear {xpath('VesselBuildYear')};
	string DocCertificateStatus {xpath('DocCertificateStatus')};
	string HailingPort {xpath('HailingPort')};
	string CallSign {xpath('CallSign')};
	string ShipYard {xpath('ShipYard')};
	string HomePortName {xpath('HomePortName')};
	string CurrentFlag {xpath('CurrentFlag')};
	string VesselCompleteBuildCity {xpath('VesselCompleteBuildCity')};
	string VesselCompleteBuildState {xpath('VesselCompleteBuildState')};
	string VesselCompleteBuildCountry {xpath('VesselCompleteBuildCountry')};
	string VesselCompleteBuildProvince {xpath('VesselCompleteBuildProvince')};
	string HullBuilderName {xpath('HullBuilderName')};
	string HullMaterial {xpath('HullMaterial')};
end;
		
export t_VesselReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_VesselReportRecord) MerchantVessels {xpath('MerchantVessels/MerchantVessel'), MAXCOUNT(1)};
end;
		
export t_VesselSearchRequest := record (share.t_BaseRequest)
	t_VesselSearchBy SearchBy {xpath('SearchBy')};
	t_VesselOption Options {xpath('Options')};
end;
		
export t_VesselReportRequest := record (share.t_BaseRequest)
	t_VesselReportOption Options {xpath('Options')};
	t_VesselReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_VesselSearchResponseEx := record
	t_VesselSearchResponse response {xpath('response')};
end;
		
export t_VesselReportResponseEx := record
	t_VesselReportResponse response {xpath('response')};
end;
		

end;

