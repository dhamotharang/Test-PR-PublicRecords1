/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from gateway_eri_salaryreport.xml. ***/
/*===================================================*/

export gateway_eri_salaryreport := MODULE
			
export t_ERISalaryReportOptions := record (share.t_BaseOption)
end;
		
export t_ERISalaryReportBy := record
	string JobTitle {xpath('JobTitle')};
	string Employer {xpath('Employer')};
	boolean EmployerMatch {xpath('EmployerMatch')};
	integer JobExperience {xpath('JobExperience')};
	integer ProfessionalExperience {xpath('ProfessionalExperience')};
	integer AnnualIncome {xpath('AnnualIncome')};
	string SIC {xpath('SIC')};
	string NAICS {xpath('NAICS')};
	string SOC {xpath('SOC')};
	string BorrowerPostalCode {xpath('BorrowerPostalCode')};
end;
		
export t_ERIRecord := record
	string Employer {xpath('Employer')};
	string EmployerAddress {xpath('EmployerAddress')};
	string EmployerCity {xpath('EmployerCity')};
	string EmployerState {xpath('EmployerState')};
	string EmployerPostalCode {xpath('EmployerPostalCode')};
	string EmployerEstrev {xpath('EmployerEstrev')};
	string EmployerEsTempCount {xpath('EmployerEsTempCount')};
	string PositionPercentile {xpath('PositionPercentile')};
	string NationalMean {xpath('NationalMean')};
	string NationalMedian {xpath('NationalMedian')};
	string NationalHigh {xpath('NationalHigh')};
	string NationalLow {xpath('NationalLow')};
	string National90Percentile {xpath('National90Percentile')};
	string National75Percentile {xpath('National75Percentile')};
	string National25Percentile {xpath('National25Percentile')};
	string National10Percentile {xpath('National10Percentile')};
	string NationalTotalCompensation {xpath('NationalTotalCompensation')};
	string NationalStandardError {xpath('NationalStandardError')};
	string LocalMean {xpath('LocalMean')};
	string LocalMedian {xpath('LocalMedian')};
	string LocalHigh {xpath('LocalHigh')};
	string LocalLow {xpath('LocalLow')};
	string Local90Percentile {xpath('Local90Percentile')};
	string Local75Percentile {xpath('Local75Percentile')};
	string Local25Percentile {xpath('Local25Percentile')};
	string Local10Percentile {xpath('Local10Percentile')};
	string LocalTotalCompensation {xpath('LocalTotalCompensation')};
	string LocalStandardError {xpath('LocalStandardError')};
	string LocalBonusPercentage {xpath('LocalBonusPercentage')};
	string LocalBenefitsPercentage {xpath('LocalBenefitsPercentage')};
	string SicDescription {xpath('SicDescription')};
	string Authorized {xpath('Authorized')};
	string JobFamily {xpath('JobFamily')};
	string JobFamilyNationalMax {xpath('JobFamilyNationalMax')};
	string JobFamilyNationalMin {xpath('JobFamilyNationalMin')};
	string JobFamilyLocalMax {xpath('JobFamilyLocalMax')};
	string JobFamilyLocalMin {xpath('JobFamilyLocalMin')};
	string JobTitle {xpath('JobTitle')};
	string PostalCode {xpath('PostalCode')};
	string ErrorMessage {xpath('ErrorMessage')};
	string ErrorsReported {xpath('ErrorsReported')};
	string SizeSensitive {xpath('SizeSensitive')};
end;
		
export t_ERISummary := record
	string Message {xpath('Message')};
	string ResponseCode {xpath('ResponseCode')};
end;
		
export t_ERISalaryReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	t_ERISummary Summary {xpath('Summary')};
	dataset(t_ERIRecord) Records {xpath('Records/Record'), MAXCOUNT(1)};
end;
		
export t_ERISalaryReportRequest := record (share.t_BaseRequest)
	t_ERISalaryReportOptions Options {xpath('Options')};
	t_ERISalaryReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_ERISalaryReportResponseEx := record
	t_ERISalaryReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from gateway_eri_salaryreport.xml. ***/
/*===================================================*/

