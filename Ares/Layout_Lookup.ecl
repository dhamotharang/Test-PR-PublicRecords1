lookup_field := record
	string lookup_label{xpath('@label')}:='';
	string lookup_length{xpath('@length')}:='';
  string lookup_required{xpath('@required')}:='';
end;

lookup_usages := record
	string lookup_usage_matches{xpath('@matches')}:='';
	string lookup_usage_path{xpath('@path')}:='';
end;

lookup_lookupBody := record
	string id {xpath('./@id')}:='';
	string fid {xpath('./@fid')};
	string fdbDescription {xpath('./@fdbDescription')};
	string fdbDescriptionPlural {xpath('./@fdbDescriptionPlural')};
	string tfpid {xpath('./@tfpid')};
	string tfpDescription {xpath('./@tfpDescription')};
	string tfpDescriptionAbbr {xpath('./@tfpDescriptionAbbr')};
	string workGroup {xpath('./@workGroup')};
	string seq {xpath('./@seq')};
	string completeText {xpath('./@completeText')}:='';
	string abbreviatedText {xpath('./@abbreviatedText')}:='';
end;

EXPORT Layout_Lookup := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};	
	string id {xpath('@id')};
	string resource {xpath('@resource')};
  string source {xpath('@source')};
	string lookupName {xpath('lookupName')}:='';
	dataset(lookup_field) lookupFields{xpath('lookupFields/field')};
	dataset(lookup_usages) lookupUsage{xpath('lookupUsage/use')};
	dataset(lookup_lookupBody) lookupBody{xpath('lookupBody/entry')};
end;