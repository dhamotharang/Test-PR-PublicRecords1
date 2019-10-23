IMPORT busdata;

//SALT is not happy with a field named "id" so we must project into a different/valid layout
EXPORT Base_Nixie_Layout_SKA := RECORD
  STRING7     ID_SKA;
  busdata.layout_ska_nixie_bdid - id;
END;