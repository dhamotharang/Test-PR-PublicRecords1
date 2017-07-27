import ut, doxie_cbrs;

export business_registration_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

br := doxie_cbrs.business_registration_records(bdids);

return sort(br,company_name,-file_date_decode,filing_num,status);
END;