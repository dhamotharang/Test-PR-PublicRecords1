EXPORT fn_calc_person_filter_id(STRING did = '', STRING bdid = '',
                                STRING ssn = '', STRING tax_id = '',
                                STRING cname = '', STRING lname = '',
                                STRING fname = '')
                                := FUNCTION
  person_filter_id := (STRING) (hash32(did, bdid, ssn, tax_id, cname, lname, fname));
  RETURN person_filter_id;
END;
