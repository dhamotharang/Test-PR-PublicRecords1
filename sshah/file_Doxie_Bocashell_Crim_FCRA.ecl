//EXPORT file_Doxie_Bocashell_Crim_FCRA := 'todo';

import Doxie_files;

Key_in:=doxie_files.key_bocashell_crim_fcra;

layout_out:= record
  unsigned6 did;
  string4 date;
  string60 offender_key;
  string35 case_num;
  string1 fcra_conviction_flag;
  string1 fcra_traffic_flag;
  string2 offense_score;
 END;
 
 layout_out makerecord (Key_in L) := transform
 self.did:= l.did;
 self.date:='date';
 self.offender_key:= 'offender_key';
 self.case_num:= 'Case Number';
 self.fcra_traffic_flag:= 'fcra conviction flag';
 self.fcra_conviction_flag:= 'fcra traffic flag';
 self.offense_score:= 'offense score';
 end;
 
export file_Doxie_Bocashell_Crim_FCRA:= project(key_in,makerecord(left));


