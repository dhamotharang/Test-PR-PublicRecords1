IMPORT sexoffender, AutoStandardI, doxie, STD;

EXPORT Functions := MODULE

  //Add functions related to formatting the new sex offender optional code.
  //Do not comment out this function or change to Doxie version
  //this version has special data filtering for sex offenders
  EXPORT fnBestIsNewer(STRING so_date_file, STRING so_report_date, STRING best_date) := FUNCTION
    so_date := IF (LENGTH(so_report_date)>0,so_report_date,so_date_file);//Use the file date IF the report date is missing
    RETURN IF (best_date>so_date AND LENGTH(best_date)>1,TRUE,FALSE);
  END;
  EXPORT fnBestIsDifferent(STRING so_prim_name, STRING so_prim_range, STRING so_predir, STRING so_postdir,
                           STRING so_addr_suffix, STRING so_unit_desig, STRING so_sec_range, STRING so_p_city_name,
                           STRING so_st, STRING so_zip5, STRING so_zip4,
                           STRING ba_prim_name, STRING ba_prim_range, STRING ba_predir, STRING ba_postdir,
                           STRING ba_addr_suffix, STRING ba_unit_desig, STRING ba_sec_range, STRING ba_p_city_name,
                           STRING ba_st, STRING ba_zip5, STRING ba_zip4) := FUNCTION
    prim_name := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_prim_name))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_prim_name)),TRUE,FALSE);
    prim_range := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_prim_range))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_prim_range)),TRUE,FALSE);
    predir := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_predir))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_predir)),TRUE,FALSE);
    postdir := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_postdir))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_postdir)),TRUE,FALSE);
    addr_suffix := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_addr_suffix))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_addr_suffix)),TRUE,FALSE);
    unit_desig := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_unit_desig))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_unit_desig)),TRUE,FALSE);
    sec_range := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_sec_range))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_sec_range)),TRUE,FALSE);
    p_city_name := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_p_city_name))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_p_city_name)),TRUE,FALSE);
    st := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_st))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_st)),TRUE,FALSE);
    zip5 := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_zip5))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_zip5)),TRUE,FALSE);
    zip4 := IF(STD.STR.ToUpperCase(STD.STR.CleanSpaces(so_zip4))=STD.STR.ToUpperCase(STD.STR.CleanSpaces(ba_zip4)),TRUE,FALSE);
    rtnIsDifferent := IF(prim_name AND prim_range AND predir AND postdir AND addr_suffix AND unit_desig AND sec_range AND p_city_name AND st AND zip5 AND zip4,FALSE,TRUE);
    RETURN rtnIsDifferent;
  END;

  EXPORT streetAddress1Value(STRING prim_name, STRING prim_range, STRING predir, STRING addr_suffix, STRING postdir) :=
    STD.STR.CleanSpaces (prim_range + ' ' + predir + ' ' + prim_name + ' ' + addr_suffix + ' ' + postdir);
  
  EXPORT stateCityZipValue(STRING p_city_name, STRING st, STRING zip) :=
    STD.STR.CleanSpaces (p_city_name + ' ' + st + ' ' + zip);

  EXPORT is_zip_only_search(BOOLEAN isFCRA = FALSE) := FUNCTION
    SexOffender.MAC_Header_Field_Declare(isFCRA);
    RETURN is_zip_only_search;
   END;
  
  EXPORT penalize_offender(SexOffender_Services.Layouts.layout_inBatchMaster_for_penalties l,
                           SexOffender_Services.Layouts.rec_offender_plus_acctno r) :=
    FUNCTION

      offenders_to_compare :=
        MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, OPT))

          // The 'input' name:
          EXPORT lastname := l._name_last;
          EXPORT middlename := l._name_middle;
          EXPORT firstname := l._name_first;
          EXPORT ssn := l._ssn;
          EXPORT dob := (INTEGER)l._dob;
          
          // The 'input' address:
          EXPORT predir := l._predir;
          EXPORT prim_name := l._prim_name;
          EXPORT prim_range := l._prim_range;
          EXPORT postdir := l._postdir;
          EXPORT addr_suffix := l._addr_suffix;
          EXPORT sec_range := l._sec_range;
          EXPORT p_city_name := l._p_city_name;
          EXPORT st := l._st;
          EXPORT z5 := l._z5;
    
          // The name in the matching record:
          EXPORT lname_field := r.lname;
          EXPORT mname_field := r.mname;
          EXPORT fname_field := r.fname;
          EXPORT ssn_field := r.ssn_appended;
          EXPORT dob_field := r.dob;

          // The address in the matching record:
          EXPORT allow_wildcard := FALSE;
          EXPORT city_field := r.p_city_name;
          EXPORT city2_field := '';
          EXPORT pname_field := r.prim_name;
          EXPORT postdir_field := r.postdir;
          EXPORT prange_field := r.prim_range;
          EXPORT predir_field := r.predir;
          EXPORT sec_range_field:= r.sec_range;
          EXPORT state_field := IF(r.st != r.orig_state_code OR r.orig_state_code = '',
                                   IF(r.orig_state_code = l._st,
                                      r.orig_state_code,
                                      l._st),
                                   r.st);
          EXPORT zip_field := r.zip5;
          
          EXPORT county_field := '';
          EXPORT DID_field := '';
          EXPORT phone_field := '';
          EXPORT suffix_field := r.addr_suffix;
          
          EXPORT useGlobalScope := FALSE;
        END;
             
      RETURN AutoStandardI.LIBCALL_PenaltyI_Indv.val(offenders_to_compare);

    END;
END;
