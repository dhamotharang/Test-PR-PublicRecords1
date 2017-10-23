﻿/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identity_contact_resolution.xml. ***/
/*===================================================*/

import iesp;

export identity_contact_resolution := MODULE
			
export t_ICRDebtor := record
	iesp.share.t_Name name {xpath('Name')};
	iesp.share.t_Address address {xpath('Address')};
	dataset(iesp.share.t_StringArrayItem) phones {xpath('Phones/Phone10'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxDebtorPhones)};
end;
		
export t_ICRReportBy := record
	string9 ssn {xpath('SSN')};
	string12 uniqueid {xpath('UniqueId')};
	iesp.share.t_Name name {xpath('Name')};
	iesp.share.t_Address address {xpath('Address')};
end;
		
export t_ICRReportOption := record (iesp.share.t_BaseReportOption)
	integer returncount {xpath('ReturnCount')};
	integer startingrecord {xpath('StartingRecord')};
end;
		
export t_ICRReportRecord := record
	string12 uniqueid {xpath('UniqueId')};
	string9 ssn {xpath('SSN')};
	iesp.share.t_Date dob {xpath('DOB')};
	iesp.share.t_Name name {xpath('Name')};
	iesp.share.t_Address address {xpath('Address')};
	string8 conf_score {xpath('ConfidenceScore')};
	string100 conf_score_desc {xpath('ConfidenceScoreDescription')};
	iesp.share.t_Name best_name {xpath('BestName')};
	string9 best_ssn {xpath('BestSSN')};
	iesp.share.t_Address best_address {xpath('BestAddress')};
	dataset(iesp.share.t_StringArrayItem) aka_names {xpath('AKAs/AKA60'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReportAKAs)};
	string1 poss_shared_ssn {xpath('PossibleSharedSSN')};
	string1 ssn_match {xpath('SSNMatch')};
	string9 expanded_ssn {xpath('ExpandedSSN')};
	string1 fn_ln_match {xpath('FnLnMatch')};
	string1 address_match {xpath('AddressMatch')};
	string2 hri_code {xpath('HRICode')};
	string50 hri_desc {xpath('HRIDescription')};
	iesp.share.t_Date date_last_seen {xpath('DateLastSeen')};
	iesp.share.t_Date input_addr_date {xpath('InputAddressDate')};
	string2 addr_in_out_of_home_state {xpath('AddressInOutOfHomeState')};
	dataset(iesp.share.t_StringArrayItem) phones {xpath('Phones/Phone10'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReportPhones)};
	string1 deceased_indicator {xpath('DeceasedIndicator')};
	iesp.share.t_Date dod {xpath('DOD')};
	string20 deceased_matchcode {xpath('DeceasedMatchcode')};
	iesp.share.t_Address dl_address {xpath('DLAddress')};
	iesp.share.t_Date dl_exp_date {xpath('DLExpirationDate')};
	dataset(t_ICRDebtor) debtors {xpath('Debtors/Debtor'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReportDebtors)};
	string50 record_err_msg {xpath('RecordErrorMessage')};
	boolean is_rejected_rec {xpath('IsRejectedRecord')};
	string6 err_addr {xpath('ErrorAddress')};
	unsigned8 err_search {xpath('ErrorSearch')};
	integer8 error_code {xpath('ErrorCode')};
end;
		
export t_ICRReportResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(t_ICRReportRecord) reportRow {xpath('Reports/Report'), MAXCOUNT(iesp.Constants.IdentityContactResolution.MaxReports)};
end;
		
export t_IdentityContactResolutionReportRequest := record (iesp.share.t_BaseRequest)
	t_ICRReportOption Options {xpath('Options')};
	t_ICRReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_IdentityContactResolutionReportResponseEx := record
	t_ICRReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from identity_contact_resolution.xml. ***/
/*===================================================*/

