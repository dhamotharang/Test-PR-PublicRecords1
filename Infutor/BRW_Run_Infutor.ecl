import orbit3;
#workunit('protect',true);
#workunit('name','Trackerplus (Infutor) Build 20170726');
#workunit('priority','high');
#option('multiplePersistInstances',FALSE);
a := infutor.Prep_For_New;
b := infutor.Proc_Clean_and_DID;
c := infutor.proc_build_best;
d := Infutor.proc_build_key_knowx;
e := Infutor.proc_despray_header_nv;
f := Orbit3.proc_Orbit3_CreateBuild('Tracker Name & Address Resource','20170726','N|B');
sequential(a,b,c,d,e,f);

//W20170728-110419 - infutor.pre_for_new

