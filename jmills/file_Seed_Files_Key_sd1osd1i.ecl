// Output(Seed_Files.Key_sd1osd1i);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.Key_sd1osd1i;

layout_out := RECORD
  string3 prodnum;
  string9 social;
  string account_out;
  string riskwiseid;
  string firstcount;
  string lastcount;
  string cmpycount;
  string addrcount;
  string socscount;
  string hphonecount;
  string wphonecount;
  string dobcount;
  string drlccount;
  string emailcount;
  string socsverlvl;
  string numelever;
  string numsource;
  string verfirst;
  string verlast;
  string vercmpy;
  string veraddr;
  string vercity;
  string verstate;
  string verzip;
  string versocs;
  string verdob;
  string verhphone;
  string verwphone;
  string verdrlc;
  string veremail;
  string firstcount2;
  string lastcount2;
  string cmpycount2;
  string addrcount2;
  string socscount2;
  string hphonecount2;
  string wphonecount2;
  string dobcount2;
  string drlccount2;
  string emailcount2;
  string socsverlvl2;
  string numelever2;
  string numsource2;
  string verfirst2;
  string verlast2;
  string vercmpy2;
  string veraddr2;
  string vercity2;
  string verstate2;
  string verzip2;
  string versocs2;
  string verdob2;
  string verhphone2;
  string verwphone2;
  string verdrlc2;
  string veremail2;
  string versummary;
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


EXPORT file_Seed_Files_Key_sd1osd1i := project(key_in,makelayout(left));