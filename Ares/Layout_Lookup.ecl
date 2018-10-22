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
	string lookup_body_entry_id {xpath('@id')}:='';
	string lookup_body_entry_tfpDescription {xpath('@tfpDescription')}:='';
	string lookup_body_entry_tfpid {xpath('@tfpid')}:='';
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