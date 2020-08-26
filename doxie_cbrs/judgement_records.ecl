IMPORT doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()

EXPORT judgement_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION
RETURN doxie_cbrs.Liens_Judments_records(bdids)(doxie_cbrs.getLorJ(filetypeid, filingtype_desc) = 'J' AND Include_Judgments_val);
END;
