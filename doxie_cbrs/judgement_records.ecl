import doxie,business_header;
doxie_cbrs.MAC_Selection_Declare()

export judgement_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION
return doxie_cbrs.Liens_Judments_records(bdids)(doxie_cbrs.getLorJ(filetypeid, filingtype_desc) = 'J' and Include_Judgments_val);
END;