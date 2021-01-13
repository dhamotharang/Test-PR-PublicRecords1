IMPORT Census_Data, codes, CCW_services, iesp, D2C;

EXPORT Functions := MODULE

  EXPORT fnCCWSearchVal (DATASET (CCW_services.Layouts.rawrec) in_recs) := FUNCTION
    STATES_WITH_ONLY_YEAR := 'LA';

    Layouts.t_CCWRecordWithPenalty xform(CCW_services.Layouts.rawrec l,
                                         Census_Data.Key_Fips2County r
                                        ) := TRANSFORM
      SELF.StateName := codes.St2Name (l.source_state);
      SELF.stateCode := l.source_state;
      SELF.Occupation :=l.occupation;
      SELF.Sex := Codes.General.Gender(l.gender);
      SELF.SSN := l.best_ssn;
      SELF.UniqueID := l.did_out;
      SELF.Race := l.race;
      SELF.Permit.PermitNumber := l.ccwpermnum;
      SELF.Permit.PermitType := l.ccwpermtype;
      SELF.Permit.WeaponType := l.ccwweapontype;
      // LA data has only the year populated for the registration date.
      SELF.Permit.RegistrationDate := IF (l.st<>STATES_WITH_ONLY_YEAR, 
        iesp.ECL2ESP.toDate ((INTEGER4) l.ccwregdate),
        iesp.ECL2ESP.toDateString8 (l.ccwregdate));
      SELF.Permit.ExpirationDate := iesp.ECL2ESP.toDate ((INTEGER4) l.ccwexpdate),
      SELF.DOB := iesp.ECL2ESP.toDate((INTEGER4) l.dob),
      SELF.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, l.title);
      SELF.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, 
        l.predir, l.postdir, l.suffix,
        l.unit_desig, l.sec_range, l.p_city_name,
        l.st, l.zip, l.zip4, r.county_name);
      SELF._penalty := l.penalt;
      SELF.AlsoFound := l.isDeepDive;
      SELF.statementids := l.statementids;
      SELF.isDisputed := l.isDisputed;
    END;
      
     temp_filter_search_tmp := 
      JOIN (in_recs, Census_Data.Key_Fips2County,
        (LEFT.st<>'') AND (LEFT.county<>'') AND
        KEYED (LEFT.st = RIGHT.state_code) AND
        KEYED (LEFT.county = RIGHT.county_fips),
        xform (LEFT, RIGHT),
      LEFT OUTER, KEEP(1), LIMIT(0));

     // needed to put in the blank field_name2 in this join to make
     // keyed part work field_name2 not needed currently in the EMERGES_HVC data
     temp_filter_search := 
      JOIN (temp_filter_search_tmp, codes.key_Codes_V3,
        KEYED (RIGHT.file_name = 'EMERGES_HVC') AND
        KEYED (RIGHT.field_name = 'RACEETHNICITY') AND
        KEYED (RIGHT.field_name2 = '') AND KEYED (RIGHT.code = LEFT.race),
        TRANSFORM (Layouts.t_CCWRecordWithPenalty,
          SELF.race := RIGHT.long_desc,
          SELF := LEFT),
        LEFT OUTER, LIMIT (0), KEEP (1));

    filter := DEDUP(SORT(temp_filter_search,RECORD), RECORD);

    RETURN(filter);
  END;
  
  EXPORT isRestricted(BOOLEAN is_cnsmr, STRING Source_Code) := 
    is_cnsmr AND Source_Code IN D2C.Constants.CCWRestrictedSources; // D2C - consumer restriction
  
END;
