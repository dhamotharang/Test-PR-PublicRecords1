qid := eAuth.Constants.QID;

EXPORT unsigned1 GetQuestionID (string12 string_id) := FUNCTION
  string upp_case := trim (stringlib.StringToUpperCase (string_id));
  return MAP (upp_case = 'COUNTY1' => QID.COUNTY1,
              upp_case = 'CITY1' => QID.CITY1,
              upp_case = 'ZIP1' => QID.ZIP1,
              upp_case = 'CITY2' => QID.CITY2,
              upp_case = 'CITY3' => QID.CITY3,
              upp_case = 'CITY4' => QID.CITY4,
              upp_case = 'CITY5' => QID.CITY5,
              upp_case = 'PEOPLE1' => QID.PEOPLE1,
              upp_case = 'PROPERTY1' => QID.PROPERTY1,
              upp_case = 'PROPERTY2' => QID.PROPERTY2,
              upp_case = 'PROPERTY3' => QID.PROPERTY3,
              upp_case = 'PROPERTY4' => QID.PROPERTY4,
              upp_case = 'PROPERTY5' => QID.PROPERTY5,
              upp_case = 'PROPERTY6' => QID.PROPERTY6,
              upp_case = 'PROPERTY7' => QID.PROPERTY7,
              upp_case = 'VEHICLE1' => QID.VEHICLE1,
              upp_case = 'VEHICLE2' => QID.VEHICLE2,
              upp_case = 'VEHICLE3' => QID.VEHICLE3,
              upp_case = 'VEHICLE4' => QID.VEHICLE4,
              upp_case = 'VEHICLE5' => QID.VEHICLE5,
              upp_case = 'ADDRESS1' => QID.ADDRESS1,
              upp_case = 'SSN1' => QID.SSN1,
              upp_case = 'CITY6' => QID.CITY6,
              QID.NONE);
END;

