IMPORT doxie, doxie_cbrs;

EXPORT proflic_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                           doxie.IDataAccess mod_access
                          ) := FUNCTION

prp := doxie_cbrs.proflic_records(bdids,mod_access);

rec := RECORD
  prp.did;
  prp.date_first_seen;
  prp.date_last_seen;
  prp.profession_or_board;
  prp.orig_license_number;
  prp.license_number;
  prp.license_type;
  prp.status;
  prp.source_st;
  prp.issue_date;
  prp.expiration_date;
END;

RETURN TABLE(prp, rec);
END;
