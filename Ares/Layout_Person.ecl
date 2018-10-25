name := record
  string prefix {xpath('prefix')};
	string givenName {xpath('givenName')};
	string surname_value {xpath('surname')};
	string formattedName {xpath('formattedName')};
end;

layout_summary := record 
	string personSortKey {xpath('names/personSortKey')};
	dataset(name) names{xpath('names/name')};
end;

layout_link := Record
	string href{xpath('link/@href')};
	string rel{xpath('link/@rel')};
End;

layout_relatedEntities := record
	dataset(layout_link) relation_link{xpath('relation')};
end;

EXPORT Layout_Person := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	layout_summary summary{xpath('summary')};
	layout_relatedEntities relatedEntities{xpath('relatedEntities')};
end;