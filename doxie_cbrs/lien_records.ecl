IMPORT doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()

EXPORT lien_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

RETURN doxie_cbrs.Liens_Judments_records(bdids)(doxie_cbrs.getLorJ(filetypeid, filingtype_desc) = 'L' AND Include_liens_val);

END;
