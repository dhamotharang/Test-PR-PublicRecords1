import doxie, doxie_raw, header;

export header_sources(DATASET(header.Layout_Header) headerRecs) := FUNCTION

doxie.MAC_Header_Field_Declare();


Doxie.Layout_ref_rid getRids(headerRecs L) := TRANSFORM
	SELF := L;
END;

allRids := PROJECT(headerRecs, getRids(LEFT));
bestRids := dedup(sort(allRids, did, rid), RECORD);

mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModule())
END;

srcChildren := doxie_raw.ViewSourceRid(bestRids,mod_access,,
                                       BankruptcyVersion,JudgmentLienVersion);

RETURN srcChildren;
END;