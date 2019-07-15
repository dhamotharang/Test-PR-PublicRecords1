name := record
  string type {xpath('type')};
	string value {xpath('value')};
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

region := record
	string type {xpath('type')};
	string value {xpath('value')};
end;

layout_place := record
	string link_href{xpath('link/@href')};
  string link_rel{xpath('link/@rel')};
end;

layout_within := record
	dataset(layout_place) place{xpath('place')};
end;

layout_name := record
	dataset(name) names{xpath('name')};
	string citySortKey{xpath('citySortKey')};
end;

layout_summary := record
	layout_name names{xpath('names')};
	string status {xpath('status')};
	dataset(identifier) identifiers{xpath('identifiers/identifier')};
	dataset(metric) demographics{xpath('demographics/metric')};
  string useInAddress{xpath('useInAddress')};
end;

layout_alternativeRegions := record
 dataset(region) alternativeRegions{xpath('region')};
end;
export layout_city := record
    string id {xpath('@id')};
		string fid {xpath('@fid')};
    string tfpid {xpath('@tfpid')};
		layout_summary summary{xpath('summary')};
		layout_within within{xpath('within')};
		layout_alternativeRegions alternativeRegions{xpath('alternativeRegions')};
end;