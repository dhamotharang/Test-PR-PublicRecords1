name := record
  string prefix {xpath('prefix')};
	string givenName {xpath('givenName')};
	string surname_seg {xpath('@seq')};
	string surname_value {xpath('surname')};
	string formattedName {xpath('formattedName')};
end;

layout_summary := record 
	string personSortKey {xpath('personSortKey')};
	dataset(name) names{xpath('names/name')};
end;



EXPORT Layout_Person := record
	layout_summary summary{xpath('summary')};

end;