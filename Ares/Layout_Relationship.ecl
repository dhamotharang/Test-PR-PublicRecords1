import Layouts;
membershipType := record
	string membership {xpath('membershipType')};
end;

layout_details := record
	dataset (membershipType) membership {xpath('membership')};
end;

layout_provider := record
	// string link_href{xpath('link/@href')};
  // string link_rel{xpath('link/@rel')};
	Ares.Layouts.layout_link entityReference {xpath('provider/link')};
	string legalName{xpath('legalName')};
end;

party := record
	string partyType {xpath('partyType')};
	string entityType {xpath('entityType')};
	dataset (Ares.Layouts.layout_link) entityReference {xpath('entityReference/link')};
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
	layout_details details {xpath('details')};
	layout_parties parties {xpath('parties')};
	string extendedSource {xpath('extendedSource')};
	

end;