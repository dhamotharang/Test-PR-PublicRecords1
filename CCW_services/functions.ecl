IMPORT Census_Data, codes, CCW_services, iesp, D2C;

EXPORT Functions := MODULE

  EXPORT fnCCWSearchVal (DATASET (CCW_services.Layouts.rawrec) in_recs) := FUNCTION
    STATES_WITH_ONLY_YEAR := 'LA';

    Layouts.t_CCWRecordWithPenalty xform(CCW_services.Layouts.rawrec l,
                                         Census_Data.Key_Fips2County r
                                        ) := TRANSFORM
      self.StateName  := codes.St2Name (l.source_state),                                                              
      self.stateCode  := l.source_state,
      self.Occupation :=l.occupation,                  
      self.Sex        := Codes.General.Gender(l.gender),
      self.SSN        := l.best_ssn,
      self.UniqueID   := l.did_out,
      self.Race       := l.race,                      
      self.Permit.PermitNumber := l.ccwpermnum,
      self.Permit.PermitType   := l.ccwpermtype,
      self.Permit.WeaponType   := l.ccwweapontype,
      // LA data has only the year populated for the registration date.
      self.Permit.RegistrationDate := if (l.st<>STATES_WITH_ONLY_YEAR, iesp.ECL2ESP.toDate ((integer4) l.ccwregdate),
                                                   iesp.ECL2ESP.toDateString8 (l.ccwregdate)),
      self.Permit.ExpirationDate   := iesp.ECL2ESP.toDate ((integer4) l.ccwexpdate),
      self.DOB := iesp.ECL2ESP.toDate((integer4) l.dob),
      Self.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, l.title);
      Self.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.suffix,
                                    l.unit_desig, l.sec_range, l.p_city_name,
                                    l.st, l.zip, l.zip4, r.county_name);
      self._penalty  := l.penalt,
      self.AlsoFound := l.isDeepDive,
			self.statementids := l.statementids,
			self.isDisputed   := l.isDisputed
    END;
      
	   temp_filter_search_tmp := JOIN (in_recs, Census_Data.Key_Fips2County,
                                    (LEFT.st<>'') AND (LEFT.county<>'') AND
                                    KEYED (LEFT.st = RIGHT.state_code) AND
                                    KEYED (LEFT.county = RIGHT.county_fips), 
                                    xform (LEFT, RIGHT),
                                    LEFT OUTER, KEEP(1), LIMIT(0));

     // needed to put in the blank field_name2 in this join to make
     // keyed part work field_name2 not needed currently in the EMERGES_HVC data
     temp_filter_search := JOIN (temp_filter_search_tmp, codes.key_Codes_V3,
                                 KEYED (RIGHT.file_name = 'EMERGES_HVC') AND
                                 KEYED (RIGHT.field_name = 'RACEETHNICITY') AND
                                 KEYED (RIGHT.field_name2 = '') AND KEYED (right.code = left.race),
                                 TRANSFORM (Layouts.t_CCWRecordWithPenalty,
                                            SELF.race := RIGHT.long_desc,
                                            SELF      := LEFT), 
                                 LEFT OUTER, LIMIT (0), KEEP (1));
    
    filter := DEDUP(SORT(temp_filter_search,RECORD), RECORD);

    RETURN(filter);         
  END;
	
	EXPORT isRestricted(boolean is_cnsmr, string Source_Code) := is_cnsmr AND Source_Code in D2C.Constants.CCWRestrictedSources; // D2C - consumer restriction
  
END;