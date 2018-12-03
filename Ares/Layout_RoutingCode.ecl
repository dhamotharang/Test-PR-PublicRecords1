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
	layouts.layout_link presence_link {xpath('presence/link')};
	layouts.layout_link department_link {xpath('department/link')};
end;
attribute_layout := Record
	string name {xpath('name')};
	string value {xpath('value')};
end;
Layout_paymentSystem := Record
		layouts.layout_link product {xpath('./product/link')};
    STRING10 useCodeForm {xpath('useCodeForm')};
    STRING20 codeSystemMembership {xpath('codeSystemMembership')};
    STRING8 codeSystemStatus {xpath('codeSystemStatus')};
    string dateBegan {xpath('dateBegan')};
    layouts.layout_link  routeVia {xpath('./routeVia/link')};
    Dataset(attribute_layout) attributes {xpath('attributes/attribute')};
    // Layout_paymentSystems_paymentSystem_contactLocations contactLocations;
    // Layout_paymentSystems_paymentSystem_correspondents correspondents;
    string dateEnded {xpath('dateEnded')};
End;

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
	string codeCheckDigit;
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
	dataset(Layout_paymentSystem) paymentSystems {xpath('paymentSystems/paymentSystem')};
end;