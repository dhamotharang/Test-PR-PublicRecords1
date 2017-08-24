import watchdog,Orbit3,RoxieKeyBuild;
export BWR_Run_Best( boolean isnewheader = false, string build_type = '') := function

send_bad_email := fileservices.SendEmail('sudhir.kasavajjala@lexisnexis.com; wenhong.ma@lexisnexis.com; michael.gould@lexisnexis.com','FCRA list Build Failed',thorlib.wuid());

out_all :=  watchdog.BWR_Best(isnewheader,build_type) : FAILURE(send_bad_email);

build_key := FCRA_List.Proc_build_key();

update_dops := RoxieKeyBuild.updateversion('FCRA_Prospect_Lis_GenKeys',watchdog.RunDate_build,'Sudhir.Kasavajjala@lexisnexisrisk.com; Michael.Gould@lexisnexisrisk.com; Wenhong.Ma@lexisnexisrisk.com',,'F');

update_orbit := Orbit3.proc_Orbit3_CreateBuild ( 'FCRA Prospect List Generation', watchdog.RunDate_build ,'F');


return sequential(out_all, build_key, update_dops, update_orbit);
end;
