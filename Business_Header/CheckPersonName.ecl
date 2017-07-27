// Function returns TRUE if person name does not appear to be a company name
EXPORT BOOLEAN CheckPersonName(STRING20 fname, STRING20 mname, STRING20 lname, STRING5 suffix = '') :=
  Datalib.CompanyClean(TRIM(fname) + ' ' + TRIM(mname) + ' ' + TRIM(lname) + ' ' + suffix)[41..120] = '';