/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface Handcrafted ***/
/*===================================================*/


export healthcare_orgaccurint := MODULE
			
export t_HealthCareAccurintHCOSearchOption := record (iesp.healthcare_accurintcommon.t_HCSearchOption) 
	boolean IncludeCLIA {xpath('IncludeCLIA')};
	boolean IncludeNCPDP {xpath('IncludeNCPDP')};
	boolean IncludeFein {xpath('IncludeFein')};
	boolean IncludeFullNCPDPInfo {xpath('IncludeFullNCPDPInfo')};//hidden[internal]
end;
export t_HealthCareAccurintHCOSearchBy := record (iesp.healthcare_accurintcommon.t_HCSearchBy)
	string acctno {xpath('acctno')}; 
	string BDid {xpath('BDid')};
	string FEIN {xpath('FEIN')};
	string80 CompanyName {xpath('CompanyName')};
	string15 CLIANumber {xpath('CLIANumber')};
	string15 ncpdpnumber {xpath('ncpdpnumber')};
	string15 MedicareNumber {xpath('MedicareNumber')};
end;
		
export t_HCOName := record
	integer   nameSeq {xpath('nameSeq')};
	STRING120 CompanyName {xpath('CompanyName')};
end;
EXPORT t_bdid := record
	integer bdid {xpath('bdid')};
end;
EXPORT t_fein := record
	string11 fein {xpath('fein')};
end;
EXPORT t_bipkeys := record
	integer	DotID {xpath('DotID')};
	integer	EmpID {xpath('EmpID')};
	integer	POWID {xpath('POWID')};
	integer	ProxID {xpath('ProxID')};
	integer	SELEID {xpath('SELEID')};
	integer	OrgID {xpath('OrgID')};
	integer	UltID {xpath('UltID')};
end;
EXPORT t_clianumber := record
	String15 clianumber {xpath('clianumber')};
	string1  clia_cert_type_code {xpath('clia_cert_type_code')};
	string10 clia_end_date {xpath('clia_end_date')};
	STRING50 clia_lab_type_description {xpath('clia_lab_type_description')};
	STRING2	 clia_lab_term_code {xpath('clia_lab_term_code')};
	string 	 clia_TermCodeDesc  {xpath('clia_TermCodeDesc')};
end;
export t_CLIARecord := record
	string   	businessid {xpath('businessid')};
	string15 	clianumber {xpath('clianumber')};
	iesp.share.t_date expirationdate {xpath('expirationdate')};
	string75 	certificatetype {xpath('certificatetype')};
	string50 	laboratorytype {xpath('laboratorytype')};
	string2  	terminationcode {xpath('terminationcode')};
	string75 	terminationcodedesc {xpath('terminationcodedesc')};
	string75 	companyname {xpath('companyname')};
	string75 	companyname2 {xpath('companyname2')};
	iesp.healthcare_accurintcommon.t_HCAddress cliaprovideraddress {xpath('cliaprovideraddress')};
	string10 	phone10 {xpath('phone10')};
	string1  	recordtype {xpath('recordtype')};
	iesp.share.t_date datefirstseen {xpath('datefirstseen')};
	iesp.share.t_date datelastseen {xpath('datelastseen')};
END;	
export t_pharmacyinformation := record
	string15 	pharmacyproviderid {xpath('pharmacyproviderid')};
	string12 	businessid {xpath('businessid')};
	string60 	companyname {xpath('companyname')};
	string60 	dbaname {xpath('dbaname')};
	string10 	storenumber {xpath('storenumber')};
	string25 	dispenserclass {xpath('dispenserclass')};
	string70 	dispensertype {xpath('dispensertype')};
	string70 	secondarydispensertype {xpath('secondarydispensertype')};
	string70 	tertiarydispensertype {xpath('tertiarydispensertype')};
	iesp.share.t_date opendate {xpath('opendate')};
	iesp.share.t_date closuredate {xpath('closuredate')};
	string15 	fein {xpath('fein')};
	string9  	deanumber {xpath('deanumber')};
	string15 	npinumber {xpath('npinumber')};
	string20 	licensenumber {xpath('licensenumber')};
	string10 	medicareproviderid {xpath('medicareproviderid')};
	iesp.share.t_date datefirstreported {xpath('datefirstreported')};
	iesp.share.t_date datelastreported {xpath('datelastreported')};
END;	
export t_pharmacyaddress := record
	iesp.healthcare_accurintcommon.t_HCAddress;
	string10 	phone10 {xpath('phone10')};
	// string10 	faxnumber {xpath('faxnumber')};
	string60 	email {xpath('email')};
END;	
export t_pharmacycontactaddress := record
	t_pharmacyaddress;
	string20 	uniqueid {xpath('')};
	iesp.healthcare_accurintcommon.t_HCCommonName contactname {xpath('contactname')};
	string60 	contacttitle {xpath('contacttitle')};
END;	
export t_PharmacyHours := record
	string9  	dayofweek {xpath('dayofweek')};
	string20 	hours {xpath('hours')};
END;	
export t_PharmacyLanguage := record
	string20 	language {xpath('language')};
END;	
export t_pharmacyservices := record
	string15 	open24hours {xpath('open24hours')};
	dataset(t_PharmacyHours) hours {xpath('hours/hour'), MAXCOUNT(iesp.constants.HPR.Max_Small_Cnt)};
	string1  	acceptseprescriptions {xpath('acceptseprescriptions')};
	string1  	deliveryservice {xpath('deliveryservice')};
	string1  	compoundingservice {xpath('compoundingservice')};
	string1  	driveupwindow {xpath('driveupwindow')};
	string1  	durablemedicalequipment {xpath('durablemedicalequipment')};
	string1  	handicapaccess {xpath('handicapaccess')};
	dataset(t_PharmacyLanguage) languages {xpath('languages/language'), MAXCOUNT(iesp.constants.HPR.Max_Small_Cnt)};
END;	
export t_PharmacyReport := record
	t_pharmacyinformation entityinformation {xpath('entityinformation')};
	t_pharmacyaddress pharmacylocationaddress {xpath('pharmacylocationaddress')};
	t_pharmacycontactaddress pharmacymailingaddress {xpath('pharmacymailingaddress')};
	t_pharmacyservices pharmacyservices {xpath('pharmacyservices')};
END;	
		
export t_HealthCareAccurintHCOSearchOrganization := record 
		iesp.healthcare_accurintcommon.t_HCResultsHeader;
		boolean  isExactCLIA {xpath('isExactCLIA')};
		boolean  isExactNCPDP {xpath('isExactNCPDP')};
		string   medicare_fac_num {xpath('medicare_fac_num')};
		string20 FacilityType  {xpath('FacilityType')};
		string60 OrganizationType {xpath('OrganizationType')};
		dataset(t_HCOName) Names {xpath('Names/Name'), MAXCOUNT(iesp.constants.HPR.MAX_NAMES)};
		dataset(t_bdid) bdids {xpath('BDIDs/BDID'), MAXCOUNT(iesp.constants.HPR.Max_Small_Cnt)};
		dataset(t_bipkeys) bipkeys {xpath('BipKeys/BipKey'), MAXCOUNT(iesp.constants.HPR.Max_Small_Cnt)};
		dataset(t_fein) feins {xpath('Feins/Fein'), MAXCOUNT(iesp.constants.HPR.MAX_TAXIDS)};
		dataset(t_clianumber) clianumbers {xpath('CliaNumbers/CliaNumber'), MAXCOUNT(iesp.constants.HPR.MAX_TAXIDS)};
		iesp.healthcare_accurintcommon.t_HCResultsCommon;
		iesp.healthcare_accurintcommon.t_HCResultsRaw;
		dataset(t_CLIARecord)	CLIARaw {xpath('CLIARecords/CLIARecord'), MAXCOUNT(iesp.Constants.HPR.MaxCLIA)};
		dataset(t_PharmacyReport)	NCPDPRaw {xpath('PharmacyRecords/PharmacyRecord'), MAXCOUNT(iesp.Constants.HPR.Max_NCPDP_Report)};
		boolean 	isBestBIPResult {xpath('isBestBIPResult')};
		boolean	 	srcBusinessHeader {xpath('srcBusinessHeader')};
end;
		
export t_HealthCareAccurintHCOSearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_HealthCareAccurintHCOSearchBy SearchBy {xpath('SearchBy')};
	t_HealthCareAccurintHCOSearchOption Options {xpath('Options')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_HealthCareAccurintHCOSearchOrganization) healthcareorganizations {xpath('healthcareorganizations/Row'), MAXCOUNT(iesp.constants.HCOrganizationReport.MaxResults)};
end;
		
export t_HealthCareAccurintHCOSearchRequest := record (iesp.share.t_BaseRequest)
	t_HealthCareAccurintHCOSearchOption Options {xpath('Options')};
	t_HealthCareAccurintHCOSearchBy SearchBy {xpath('SearchBy')};
end;
export t_HealthCareAccurintHCOBatchSearchRequest := record (iesp.share.t_BaseRequest)
	t_HealthCareAccurintHCOSearchOption Options {xpath('Options')};
	dataset(t_HealthCareAccurintHCOSearchBy) SearchBy {xpath('SearchBy/row'), MAXCOUNT(100)};
end;
		
export t_HealthCareAccurintHCOSearchRequestEx := record
	t_HealthCareAccurintHCOSearchRequest criteria {xpath('criteria/row')};
end;
export t_HealthCareAccurintHCOBatchRequestEx := record
	t_HealthCareAccurintHCOBatchSearchRequest criteria {xpath('batch_in/row')};
end;
export t_HealthCareAccurintHCOSearchResponseEx := record
	t_HealthCareAccurintHCOSearchResponse response {xpath('response')};
end;
		

end;

/*===================================================*/

