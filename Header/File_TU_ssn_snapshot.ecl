import ut;
r:=RECORD
  unsigned6 did;
  data16 frid;
  string2 src;
  qstring9 ssn;
  integer4 dob;
 END;
export File_TU_ssn_snapshot := dataset(ut.Data_Location.Person_header+'~thor_data400::base::tu_ssn_snapshot',r,flat);
