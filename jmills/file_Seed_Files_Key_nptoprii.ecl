// Output(Seed_Files.Key_nptoprii);

// Output(FCRA.Key_Override_Student_FFID);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.Key_nptoprii;

layout_out := RECORD
   string3 prodnum;
  string9 social;
  string account_out;
  string riskwiseid;
  string socsverlevel;
  string phoneverlevel;
  string correctdob;
  string correcthphone;
  string correctsocs;
  string score;
  string score2;
  string score3;
  string reason1;
  string reason2;
  string reason3;
  string reason4;
  string reason5;
  string reason6;
  string action1;
  string action2;
  string action3;
  string action4;
  string altlast;
  string altlast2;
  string altlast3;
  string altareacode;
  string splitdate;
  string socllowissue;
  string soclhighissue;
  string soclstate;
  string hriskalerttable;
  string hriskalertnum;
  string alertfirst;
  string alertlast;
  string alertaddr;
  string alertcity;
  string alertstate;
  string alertzip;
  string alertentity;
  string dirsfirst;
  string dirslast;
  string dirsaddr;
  string dirscity;
  string dirsstate;
  string dirszip;
  string nameaddrphone;
  string eqfsfirst;
  string eqfslast;
  string eqfsaddr;
  string eqfscity;
  string eqfsstate;
  string eqfszip;
  string eqfsphone;
  string eqfsaddr2;
  string eqfscity2;
  string eqfsstate2;
  string eqfszip2;
  string eqfsphone2;
  string eqfsaddr3;
  string eqfscity3;
  string eqfsstate3;
  string eqfszip3;
  string eqfsphone3;
  unsigned8 __internal_fpos__;
 END;

 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_Key_nptoprii := project(key_in,makelayout(left));