import orbit3,infutor;

export BWR_Infutor_Build_All (STRING9 cversion) := function

shared STRING9 cversion_dev := (STRING9)cversion;

a := Infutor._config.set_v_version(cversion_dev);
b := infutor.BRW_Infutor_Spray(cversion_dev);
c := infutor.Prep_For_New;
d := infutor.Proc_Clean_and_DID;
e := infutor.proc_build_best;
f := Infutor.proc_build_key_knowx;
g := Infutor.proc_despray_header_nv;
h := Orbit3.proc_Orbit3_CreateBuild('Tracker Name & Address Resource',cversion_dev,'N|B');
i := Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Tracker Name & Adress Resource',cversion_dev,'N|B',runaddcomponentsonly := true); 
  return sequential(a,b,c,d,e,f,g,h,i);
end;
