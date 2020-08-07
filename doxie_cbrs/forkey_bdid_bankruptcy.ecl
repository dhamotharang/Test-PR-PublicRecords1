IMPORT bankrupt;

mf := bankrupt.file_bk_main;
bdids_file := Bankrupt.file_bk_search((INTEGER)bdid > 0);

//slim the bdids for join
bdids_rec := RECORD
  bdids_file.case_number;
  bdids_file.bdid;
END;

bf := table(bdids_file, bdids_rec);


//get my bdids on the main file
outrec := RECORD
  UNSIGNED6 bdid;
  mf;
END;

outrec addbdid(mf l, bf r) := TRANSFORM
  SELF.bdid := (UNSIGNED6) r.bdid;
  SELF := l;
END;

wbdid := JOIN(mf, bf, LEFT.case_number = RIGHT.case_number, 
  addbdid(LEFT, RIGHT), hash);

EXPORT forkey_bdid_bankruptcy := wbdid;
