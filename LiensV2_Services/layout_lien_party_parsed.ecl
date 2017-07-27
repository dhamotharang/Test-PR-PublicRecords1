import BIPV2,FFD;
export layout_lien_party_parsed := record
  string12 did;
  string12 bdid;
	BIPV2.IDlayouts.l_header_ids;
	string9 ssn;
	string9 tax_id;
	string person_filter_id := '';
  layout_lien_party_name;
  boolean hasCriminalConviction;
  boolean isSexualOffender;
	FFD.Layouts.CommonRawRecordElements;
end;
