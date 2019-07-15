lookup_field := record
	string lookup_label{xpath('@label')}:='';
	string lookup_length{xpath('@length')}:='';
  string lookup_required{xpath('@required')}:='';
end;

lookup_usages := record
	string lookup_usage_matches{xpath('@matches')}:='';
	string lookup_usage_path{xpath('@path')}:='';
end;
entry_layout := record
	string id {xpath('./@id')};
	string tfpid {xpath('./@tfpid')};
end;
category_layout := record
	string id {xpath('./@id')};
	string paymentSystem {xpath('./@paymentSystem')};
	dataset(entry_layout) entries {xpath('entry')};
end;
lookup_lookupBody := record
	string id {xpath('./@id')}:='';
	string fid {xpath('./@fid')};
	string databank_type {xpath('./@databank_type')};
	
	string intl_type {xpath('./@intl_type')};
	string inst_type {xpath('./@inst_type')};
	string rtn_type {xpath('./@rtn_type')};
	string tfpSubcategory {xpath('./@tfpSubcategory')};
	
	string fdbDescription {xpath('./@fdbDescription')};
	string fdbDescriptionPlural {xpath('./@fdbDescriptionPlural')};
	string fdbFormat {xpath('./@fdbFormat')};
	string format {xpath('./@format')};
	string ibanFormat {xpath('./@ibanFormat')};
	string tfpFormat {xpath('./@tfpFormat')};
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
	dataset(category_layout) categories {xpath('lookupBody/category')};
end;