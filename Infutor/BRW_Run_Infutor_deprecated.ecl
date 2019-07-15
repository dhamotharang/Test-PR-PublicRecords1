import orbit3;
filedate := trim(infutor.version_dev, all);
#workunit('protect',true);
#workunit('name','Yogurt:Trackerplus (Infutor) Build 20180529');
#workunit('priority','high');
#option('multiplePersistInstances',FALSE);
a := infutor.Prep_For_New;
b := infutor.Proc_Clean_and_DID;
c := infutor.proc_build_best;
d := Infutor.proc_build_key_knowx;
e := Infutor.proc_despray_header_nv;
f := Orbit3.proc_Orbit3_CreateBuild('Tracker Name & Address Resource',filedate,'N|B');
sequential(a,b,c,d,e,f);



