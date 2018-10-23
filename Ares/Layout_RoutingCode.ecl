codeAlternateForm_layout := record
	string form_type {xpath('./@type')};
	string form {xpath('./')};
end;
relation_layout := record
	string routingCode_href {xpath('routingCode/link/@href')};
	string context {xpath('routingCode/context')};
end;
usageLocation_layout := record
	string primaryAssignee {xpath('@primaryAssignee')};
	string rankAtLocation {xpath('@rankAtLocation')};
	dataset(relation_layout) relatedCodes {xpath('relatedCodes/relation')};
end;

export layout_routingCode := record,  MAXLENGTH(350000)
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	string tfpid {xpath('@tfpid')};
	string codeType {xpath('codeType')};
	string codeTypeDescription {xpath('codeTypeDescription')};
	string codeSubtype {xpath('codeSubtype')};
	string codeValue {xpath('codeValue')};
	dataset(codeAlternateForm_layout) codeAlternateForms {xpath('codeAlternateForms/codeAlternateForm')};
	string codeStatus {xpath('codeStatus')};
	string accountEligible {xpath('accountEligible')};
	string validFrom {xpath('dates/validFrom')};
	string validTo {xpath('dates/validTo')};
	string retireAt {xpath('dates/retireAt')};
	string confirmed {xpath('dates/confirmed')};
	dataset(relation_layout) relatedCodes {xpath('relatedCodes/relation')};
	string assignedInstitution_href {xpath('assignedInstitution/link/@href')};
	string assignedInstitution_src {xpath('assignedInstitution/link/@src')};
	dataset(usageLocation_layout) usageLocations {xpath('usageLocations/usageLocation')};
end;