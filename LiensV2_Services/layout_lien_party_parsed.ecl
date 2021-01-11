IMPORT BIPV2,FFD;
EXPORT layout_lien_party_parsed := RECORD
  STRING12 did;
  STRING12 bdid;
  BIPV2.IDlayouts.l_header_ids;
  STRING9 ssn;
  STRING9 tax_id;
  STRING person_filter_id := '';
  layout_lien_party_name;
  BOOLEAN hasCriminalConviction;
  BOOLEAN isSexualOffender;
  FFD.Layouts.CommonRawRecordElements;
END;
