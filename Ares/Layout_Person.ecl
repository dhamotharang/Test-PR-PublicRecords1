name := record
  string prefix {xpath('prefix')};
	string givenName {xpath('givenName')};
	string surname_value {xpath('surname')};
	string formattedName {xpath('formattedName')};
end;

layout_summary := record 
	string personSortKey {xpath('personSortKey')};
	dataset(name) names{xpath('names/name')};
end;

layout_relatedEntities := record
	dataset(Layouts.layout_link) relation_link{xpath('relation')};
end;

layout_link := Record
	string href{xpath('@href')};
	string rel{xpath('@rel')};
End;

EXPORT Layout_Person := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	layout_summary summary{xpath('summary')};
	//layout_relatedEntities relatedEntities{xpath('relatedEntities/relation')};
	//layout_relatedEntities relatedEntities{xpath('relatedEntities/relation')};
	dataset(layout_link) relation_link{xpath('relatedEntities/relation')};
end;