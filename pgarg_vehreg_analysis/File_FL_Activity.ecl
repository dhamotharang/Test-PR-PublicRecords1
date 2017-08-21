Layout_activity :=  RECORD
  string8 activity_datexbg6;
  integer8 total;
  string8 has_max;
  string8 has_min;
 END;


export File_FL_Activity := dataset('~thor_data400::out::file_activity_date_fl',Layout_activity,flat);