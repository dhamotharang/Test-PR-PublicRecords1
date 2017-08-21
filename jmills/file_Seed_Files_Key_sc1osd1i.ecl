// Output(Seed_Files.Key_sc1osd1i);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.Key_sc1osd1i;

layout_out := RECORD
  string3 prodnum;
  string9 social;
  string account_out;
  string riskwiseid;
  string score;
  string reason11;
  string reason21;
  string reason31;
  string reason41;
  string score2;
  string reason12;
  string reason22;
  string reason32;
  string reason42;
  string score3;
  string reason13;
  string reason23;
  string reason33;
  string reason43;
  string score4;
  string reason14;
  string reason24;
  string reason34;
  string reason44;
  string reserved_out;
  unsigned8 __internal_fpos__;
 END;

 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_Key_sc1osd1i := project(key_in,makelayout(left));