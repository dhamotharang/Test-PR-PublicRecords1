IMPORT header, ut;

ds_src := header.prepped_for_keys;

// fields are same as in Header.layout_prep_for_keys, but strings are used instead of qstrings
layout_slim := RECORD
  unsigned6 did;
  integer4  dob;
  string20  fname;
  string20  pfname; //preferred first name
  string2   st;
  string5   zip;
END;

// filter invalid DOBs
ds_filt := PROJECT (ds_src  (doxie.DOBTools (dob).IsValidDOB, length (trim ((string) fname)) > 1), layout_slim);

// input already distributed by did
// sorting by state/zip is important for further dedup (bringing non-blancs on top)
ds_grp := GROUP (SORT (ds_filt, did, dob, fname, pfname, -zip, -st, LOCAL), did, dob, fname, pfname, LOCAL);

// For every did: get rid of same zip (choosign whatever state); skip blank zips, if non-blank exists
ds_ready := DEDUP (ds_grp, ut.NNEQ(Left.zip, Right.zip) and ut.NNEQ(Left.st, Right.st));

EXPORT key_header_dob := INDEX (ds_ready, {dob, fname, pfname, st, zip}, {did}, 
                                     '~thor_data400::key::header.dob_' + doxie.version_superkey, OPT);
