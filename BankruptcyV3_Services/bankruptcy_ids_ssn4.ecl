IMPORT $, bankruptcyV3, AutoStandardI, STD;
EXPORT bankruptcy_ids_ssn4(
  UNSIGNED inLimit = $.consts.MAX_SSN4,
  STRING4 inSSN4,
  STRING2 inState ='',
  STRING1 inPartyType = '',
  STRING50 inLast = '',
  STRING50 inFirst = '',
  BOOLEAN isFCRA = FALSE
  ):= FUNCTION
       
  outrec := $.layouts.layout_tmsid_ext;
      
  //index to use, contains only DEBTORS.
  ssn4key := bankruptcyV3.key_bankruptcyV3_ssn4st(isFCRA);
    
  //state key, not required
  sFilter := IF (LENGTH(TRIM(inState)) > 0, ssn4Key.state=inState,TRUE);
  
  //lastname filter, not required
    lFilter := IF (LENGTH(TRIM(inLast)) > 0,
      IF (LENGTH(TRIM(ssn4key.lname)) > 0, TRIM(ssn4key.lname) = inLast,
        STD.STR.Find(ssn4key.lname, TRIM(inLast), 1) > 0),
      TRUE);
  //firstname filter, not required
  fFilter := 
    IF (LENGTH(TRIM(inFirst)) > 0,
      IF (LENGTH(TRIM(ssn4key.fname)) > 0, TRIM(ssn4key.fname) = inFirst,
        STD.STR.Find(ssn4key.lname, TRIM(inFirst), 1) > 0),
      TRUE);
            
  choosen_cnt := IF (((inLimit > 0) AND (inlimit < $.consts.MAX_SSN4)), inLimit, $.consts.MAX_SSN4);

  tmsids := CHOOSEN(ssn4key(KEYED(ssnLast4=inSSN4 AND sFilter) AND LFilter AND FFilter),choosen_cnt);
  tmsids_sorted := SORT(tmsids,tmsid);
  tmsids_nodup := DEDUP(tmsids_sorted,tmsid);
  tmsids_raw := PROJECT(tmsids_nodup, TRANSFORM(outrec, SELF.isdeepdive := FALSE; SELF := LEFT));
  RETURN tmsids_raw;
END;
