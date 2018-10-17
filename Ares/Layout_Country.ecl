name := record
	string type {xpath('type')};
	string value {xpath('value')};
end;

layout_names := record
	dataset(name) names{xpath('name')};
	String countrySortKey {xpath('countrySortKey')};
end;	

summaries := record
	string summary {xpath('summary')};
end;

layout_metric := record
	string name {xpath('name')};
	string value {xpath('value')};
	string unit {xpath('unit')};
end;

layout_currency := record
	string link_href {xpath('link/@href')};
  string link_rel {xpath('link/@rel')};
	string name	{xpath('name')};
	string primary {xpath('primary')};	
	string status {xpath('status')};
	string startDate {xpath('startDate')};
	string startDate_accuracy {xpath('startDate/@accuracy')};
	//string endDate {xpath('endDate')};
	//string endDate_accuracy {xpath('endDate/@accuracy')};
end;

holiday := record
	string holidayType {xpath('holidayType')};
	string date {xpath('date')}; 
	string date_accuracy {xpath('date/@accuracy')};
	string name {xpath('name')};
end;

rating := record
	string agencyName {xpath('agencyName')};
	string type {xpath('type')};
	string value {xpath('value')};
end;

place_relation := record
	string type {xpath('type')};
	string details {xpath('details/detail')};
	string place_link_href {xpath('place/link/@href')};
	string place_link_rel {xpath('place/link/@rel')};
end;

presence_relation := record
	string type {xpath('type')};
	string presence_link_href {xpath('presence/link/@href')};
	string presence_link_rel {xpath('presence/link/@rel')};
end;


layout_summary := record
	string iso2 {xpath('iso2')};	
	string iso3 {xpath('iso3')};	
	layout_names names {xpath('names')};
	string status {xpath('status')};
	dataset(summaries) timeZones {xpath('timeZones/summaries')};
	dataset(summaries) businessHours {xpath('businessHours/summaries')};	
	dataset(layout_metric) demographics{xpath('demographics/metric')};
	string politicalStructure {xpath('politicalStructure')};	
	string primaryExports {xpath('primaryExports')};	
	string primaryImports {xpath('primaryImports')};	
	string telephoneCode {xpath('telephoneCode')};	
	string postalCodePosition {xpath('postalCodePosition')};	
	string useInAddress{xpath('useInAddress')};
end;
export layout_country := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string tfpid {xpath('@tfpid')};
	string source {xpath('@source')};
	layout_summary summary {xpath('summary')};
	dataset(summaries) languages {xpath('languages/summaries')};	
	dataset(layout_currency) currencies {xpath('currencies/currency')};	
	string iban_registered {xpath('iban/registered')};
	dataset(holiday) holidays {xpath('holidays/holiday')};
	dataset(rating) creditRatings {xpath('creditRatings/rating')};
	dataset(name) alternativeRegions {xpath('alternativeRegions/region')};
	dataset(place_relation) relatedPlaces {xpath('relatedPlaces/relation')};
	dataset(presence_relation) relatedPresences {xpath('relatedPresences/relation')};
end;
