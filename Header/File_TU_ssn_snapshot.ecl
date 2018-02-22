import data_services;

r:=RECORD
  unsigned6 did;
  data16 frid;
  string2 src;
  qstring9 ssn;
  integer4 dob;
 END;
 
export File_TU_ssn_snapshot := dataset(Data_Services.Data_location.person_header + 'thor_data400::base::tu_ssn_snapshot',r,flat);
