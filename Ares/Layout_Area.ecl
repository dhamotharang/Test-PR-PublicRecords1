name := record
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
layout_summary := record
	string type{xpath('type')};
	dataset(name) names{xpath('names/name')};
	string status {xpath('status')};
	string useInAddress{xpath('useInAddress')};
end;
export layout_area := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource{xpath('@resource')};
	string source{xpath('@source')};
	layout_summary summary{xpath('summary')};
	layout_within within{xpath('within')};
end;
