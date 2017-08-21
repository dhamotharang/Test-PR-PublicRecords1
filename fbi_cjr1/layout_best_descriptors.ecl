export Layout_best_descriptors := RECORD
  unsigned6	did;
  unsigned4	dt_first_seen;
  unsigned4	dt_last_seen;
  string2   orig_state;
  string2	source_code;
  string10   source; // DriversLic,Offender,SexOffender
  string1   history :='';
  string5   height:='';
  string5	weight:='';
  string5   race_code:='';
  string25	race_desc:='';
  string5   gender_code:='';
  string10	gender_desc:='';
  string5   eye_color_code:='';
  string25	eye_color_desc:='';
  string5   hair_color_code:='';
  string25	hair_color_desc:='';
  //------------------------------------
  integer8  best_score_height:=0;
  integer8 	best_score_weight:=0;
  integer8 	best_score_race:=0;
  integer8 	best_score_gender:=0;
  integer8 	best_score_eye_color:=0;
  integer8 	best_score_hair_color:=0;
END;