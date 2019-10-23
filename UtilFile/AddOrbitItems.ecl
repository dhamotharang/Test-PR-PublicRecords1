import STD,Orbit3;

#Workunit('name','Daily Utility Add Orbit PR Components Only');
string8 filedate := (STRING8)Std.Date.Today();
Orbit3.proc_Orbit3_CreateBuild_AddItem ( 'Utility',filedate,'N',runaddcomponentsonly := true) : when ( cron( '00 16 * * 1-5'));