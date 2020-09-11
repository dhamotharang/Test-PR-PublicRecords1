IMPORT DriversV2, doxie, ut, STD;

EXPORT wildcard := MODULE;

  EXPORT params := INTERFACE
    EXPORT QSTRING24 dl_num := '';
    EXPORT STRING DLState := '';
    EXPORT STRING1 gender := '';
    EXPORT UNSIGNED1 agelow := 0;
    EXPORT UNSIGNED1 agehigh := 0;
  END;

  EXPORT get_seq_from_num(params input) := FUNCTION
    wildfile := DriversV2.File_DL_Wildcard;
    wild_dl_number := ut.mod_WildSimplify.do(input.dl_num);
    UNSIGNED1 state := IF(input.DLState='',-1,ut.St2Code(STD.STR.ToUpperCase(input.DLState)));
    hasWild := LENGTH(STD.STR.Filter(input.dl_num,'*?'))>0;
    driverLicenseMatch := MAP(input.dl_num='' => FALSE,
      hasWild => stringlib.StringWildMatch(wildfile.dl_number,wild_dl_number,TRUE),
      wild_dl_number=wildfile.dl_number);
    currentYear := (INTEGER)(STD.Date.Today()[1..4]);
    ageFrom1900 := currentYear-(1900+wildfile.years_since_1900);
    ageMatch := input.agelow=0 OR input.agehigh=0 OR
      (input.agelow<=ageFrom1900 AND input.agehigh+1>=ageFrom1900);
    // Only filter by gender for inputs of 'M','F', ignore all other inputs and no gender in record
    genderMatch := input.gender NOT IN ['M','F'] OR input.gender=wildfile.gender OR wildfile.gender='';
    wild_recs := LIMIT(wildfile(
      KEYED(input.DLState='' OR orig_state=state),
      driverLicenseMatch,ageMatch,genderMatch,
      TRUE),10000,FAIL(11,doxie.ErrorCodes(11)));
    by_wild := PROJECT(wild_recs,TRANSFORM(layouts.seq,SELF:=LEFT));
    RETURN DEDUP(SORT(by_wild,dl_seq),dl_seq);
  END;

END;
