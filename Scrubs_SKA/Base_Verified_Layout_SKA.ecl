IMPORT busdata;

//SALT is not happy with a field named "id" so we must project into a different/valid layout
EXPORT Base_Verified_Layout_SKA := RECORD
  STRING7     ID_SKA;
  busdata.layout_ska_verified_bdid - id;
END;