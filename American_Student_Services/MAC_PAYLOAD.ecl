
export MAC_PAYLOAD (IDS, DS_RECS,KEY_FIELD_LEFT, KEY_FIELD_RIGHT, KEY) := MACRO

  #UNIQUENAME(get_results)
  iesp.student.t_StudentRecordEx %get_results%(key L) := transform
    self.uniqueId := intformat((unsigned6)L.did,12,1);
    self.FirstReported := iesp.ECL2ESP.toDate ((integer4) l.date_vendor_first_reported);
    self.LastReported := iesp.ECL2ESP.toDate ((integer4) l.date_vendor_last_reported);
    self.CollegeName := L.college_name;
    self.CollegeMajor := if(L.college_major <> '',codes.Key_Codes_V3(file_name='AMERICAN_STUDENT_LIST' AND field_name='COLLEGE_MAJOR' AND code=L.college_major)[1].long_desc,'');
    self.CollegeCode := L.college_code_exploded;
    self.CollegeType := L.college_type_exploded;
    SELF.CollegePhone := l.telephone;
    SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix, l.title) ;
    SELF.CollegeAddress := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
                         l.addr_suffix, l.unit_desig, l.sec_range, l.p_city_name,
                         l.state, l.zip, l.zip4, '') ;
    SELF.HighSchoolGradYear := l.class;
    SELF.SSN := l.SSN;
    SELF.DOB := iesp.ECL2ESP.toMaskableDatestring8(l.dob_formatted);
    SELF := [];
  end;
  
  ds_recs := join(ids,KEY,
                  keyed(left.KEY_FIELD_LEFT=right.KEY_FIELD_RIGHT),
                  %get_results%(right),
                  LIMIT(Constants.MAX_RECS_ON_JOIN, fail(203, doxie.ErrorCodes(203))));
  
ENDMACRO;

