IMPORT ut, doxie_cbrs;

EXPORT business_registration_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

br := doxie_cbrs.business_registration_records(bdids);

RETURN SORT(br,company_name,-file_date_decode,filing_num,status);
END;
