
type_summary := record
	string type {xpath('type')};
	string type_abbreviation {xpath('type/@abbreviation')};
end;

name := record
	string type {xpath('type')};
	string value {xpath('value')};
end;

layout_names := record
		string departmentSortKey {xpath('departmentSortKey')};
		dataset(name) names {xpath('name')};
end;

layout_link := record
	string link_href {xpath('link/@href')};
  string link_rel {xpath('link/@rel')};
	string placeType {xpath('placeType')};
end;

layout_link_place := record
	string link_href {xpath('link/@href')};
  string link_rel {xpath('link/@rel')};
	string name {xpath('name')};
end;
layout_line_item := record
	string fid {xpath('@fid')};
	string calculated {xpath('@calculated')};
	string name {xpath('name')};
	string value{xpath('value')};
	string normalizedValue {xpath('normalizedValue')};
	string note {xpath('note')};	
end;


export layout_financialstatement := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	string owner_link_href {xpath('owner/link/@href')};
	string owner_link_rel {xpath('owner/link/@rel')};
//////////////
	STRING6 statementType {xpath('statementType')};
  string periodStart {xpath('periodStart')};
	string periodStart_accuracy {xpath('periodStart/@accuracy')};
	string periodEnd {xpath('periodEnd')};
	string periodEnd_accuracy {xpath('periodEnd/@accuracy')};
   
    // Layout_financialYearEnd financialYearEnd;
  layout_link currency {xpath('currency')};
    // UNSIGNED1 orderOfMagnitude;
    // Layout_exchangeRates exchangeRates;
    // STRING5 consolidated;
/////////////////

	dataset(layout_line_item) lineItems {xpath('lineItems/item')};
	
	
	//////////////////

    // Layout_missingReason missingReason;
    // STRING13 accountingStandards;
    // Layout_ns_md__ResourceMetadata ns_md__ResourceMetadata;
    // STRING5 excludeFromRankings;

end;
