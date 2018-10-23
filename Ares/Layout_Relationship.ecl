membership_ := record
	string membership {xpath('membershipType')};
end;

ownership_ := record 
	string ownerType{xpath('ownerType')} :='';
	string percentage{xpath('percentage')} :='';
end;

regulator_ := record 
	string regulatorType {xpath('regulatorType')} :='';
end;

auditor_ := record 
	string auditorType{xpath('auditorType')} :='';
end;

stockExchange_ := record 
	string primary{xpath('primary')} :='';
	string tickerSymbol{xpath('tickerSymbol')} :='';
end;

roles_ :=record
	string role{xpath('./')} :='';
end;

types_ := record
	string department_types_type{xpath('./')} :='';
end;

department_types := record
	dataset (types_) types {xpath('type')};
end;

department_name := record
	string department_name_type{xpath('type')} :='';
	string department_name_value{xpath('value')} :='';
end;

department_ := record
		department_name name {xpath('name')};
		department_types types {xpath('types')};
end;

positions_ := record
	string positionCategory {xpath('positionCategory')} :='';
	dataset (Ares.Layouts.layout_link) office {xpath('office/link')};
	department_ department {xpath('department')};
	string jobTitle {xpath('jobTitle')} :='';
	string jobTitleType {xpath('jobTitleType')} :='';
end;

telecoms_ := record
	layouts.layout_link entityReference {xpath('link')};
	string telecom_fid {xpath('@fid')} :='';
	string type {xpath('type')} :='';
	string phoneCountryCode {xpath('phoneCountryCode')} :='';
	string phoneAreaCode {xpath('phoneAreaCode')} :='';
	string phoneNumber {xpath('phoneNumber')} :='';
	string phoneNumberRangeLimit {xpath('phoneNumberRangeLimit')} :='';
	string phoneExtension {xpath('phoneExtension')} :='';
	string value {xpath('value')} :='';
end;

employment_ :=record
	dataset (roles_) roles {xpath('roles/role')};
	dataset (positions_) positions {xpath('positions/position')};
	dataset (telecoms_) telecoms {xpath('telecoms/telecom')};
end;

contact_ := record
	string contactType {xpath('contactType')} :='';
	string username {xpath('username')} :='';
	dataset (positions_) positions {xpath('positions/position')};
	dataset(layouts.address) address {xpath('addresses/address')};
	dataset (telecoms_) telecoms {xpath('telecoms/telecom')};
end;

layout_details := record
	dataset (ownership_) ownership {xpath('ownership')};
	regulator_ regulator {xpath('regulator')};
	auditor_ auditor {xpath('auditor')};
	membership_ membership {xpath('membership')};
	stockExchange_ stockExchange {xpath('stockExchange')};
	employment_ employment {xpath('employment')};
	contact_ contact {xpath('contact')};
end;

layout_provider := record
	layouts.layout_link entityReference {xpath('link')};
	string legalName{xpath('legalName')};
end;

party := record
	string partyType {xpath('partyType')};
	string entityType {xpath('entityType')};
	dataset (Ares.Layouts.layout_link) entityReference {xpath('entityReference/link')};
	string description {xpath('description')};
end;

layout_parties := record
	dataset (party) party {xpath('party')};
end;

EXPORT Layout_Relationship := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	string relationshipType {xpath('relationshipType')};
	string status {xpath('status')};
	string dateBegan {xpath('dateBegan')};
	string dateEnded {xpath('dateEnded')};
	string validationDate {xpath('validationDate')};
	layout_provider provider {xpath('provider')};
	string extendedSource {xpath('extendedSource')};
	layout_parties parties {xpath('parties')};
	layout_details details {xpath('details')};
end;