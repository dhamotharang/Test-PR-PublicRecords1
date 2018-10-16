name := record
  string type {xpath('type')};
	string value {xpath('value')};
end;

date := record
	string dateBegan  {xpath('dateBegan')};
	string dateCeased {xpath('dateCeased')};
end;

identifier := record
  string transferable{xpath('identifier/@transferable')};
  string type {xpath('type')};
	string value {xpath('value')};
	string status {xpath('status')};
end;

metric := record
	string name{xpath('name')};
	string value {xpath('value')};
	string unit {xpath('unit')};
	string date {xpath('date')};
end;

additionalInfo := record
  string additionalInfo {xpath('additionalInfo')};
end;

layout_place := record
	string link_href{xpath('link/@href')};
  string link_rel{xpath('link/@rel')};
end;

layout_redirectTo := record
	dataset(layout_place) place{xpath('place')};
end;

layout_summary := record
	string type{xpath('type')};
	dataset(name) names{xpath('names/name')};
	string citySortKey{xpath('names/citySortKey')};
	string status {xpath('status')};
	dataset(date) dates{xpath('dates/date')};
	dataset (layout_redirectTo) rediretTo{xpath('redirectTo')};
	dataset(identifier) identifiers{xpath('identifiers/identifier')};
	dataset(metric) demographics{xpath('demographics/metric')};
  dataset(additionalInfo) additionalInfos{xpath('additionalInfos/additionalInfo')};
	string useInAddress{xpath('useInAddress')};
end;


export layout_city := record
 
		layout_summary summary{xpath('summary')};
end;