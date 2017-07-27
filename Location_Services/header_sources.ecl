import header, doxie, doxie_raw;

export header_sources(DATASET(header.Layout_Header) headerRecs) := FUNCTION

doxie.MAC_Header_Field_Declare()

Doxie.Layout_ref_rid getRids(headerRecs L) := TRANSFORM
	SELF := L;
END;

allRids := PROJECT(headerRecs, getRids(LEFT));
bestRids := dedup(sort(allRids, did, rid), RECORD);

srcChildren := doxie_raw.ViewSourceRid(bestRids,dateVal,DPPA_Purpose,GLB_Purpose,,,,BankruptcyVersion,JudgmentLienVersion,,,,,application_type_value);

RETURN srcChildren;
END;