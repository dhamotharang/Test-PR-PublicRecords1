import orbit3,infutor;

export BWR_Infutor_Build_All (STRING9 cversion) := function

shared STRING9 cversion_dev := (STRING9)cversion;

b := infutor.BRW_Infutor_Spray(cversion_dev);
c := infutor.Prep_For_New(cversion_dev);
d := infutor.Proc_Clean_and_DID;
e := infutor.proc_build_best(cversion_dev).all;
f := Infutor.proc_build_key_knowx(cversion_dev).all;
g := Infutor.proc_despray_header_nv(cversion_dev).despray;
h := Orbit3.proc_Orbit3_CreateBuild('Tracker Name and Address Resource',cversion_dev,'N|B');
i := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Tracker Name and Address Resource',cversion_dev,'N|B',runaddcomponentsonly := true); 
  return sequential(b,c,d,e,f,g,h,i);
end;
