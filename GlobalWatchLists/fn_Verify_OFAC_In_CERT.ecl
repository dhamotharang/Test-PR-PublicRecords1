import dops,ut;

EXPORT fn_Verify_OFAC_In_CERT := function


emailsToNotify 	:= 'Sudhir.Kasavajjala@lexisnexis.com';
prod_version 		:= dops.GetBuildVersion('GlobalWatchListKeys','B','N','P'); // boca, non-FCRA,production

cert_version 		:= dops.GetBuildVersion('GlobalWatchListKeys','B','N','C'); // cert

certAndProdVersionsAreTheSame := (prod_version=cert_version);

ds := nothor(FileServices.SuperFileContents('~thor_data400::key::globalwatchlists::globalwatchlists_key_qa'))[1].name ;

Latestbuildvs := ds[StringLib.StringFind( ds , '::',3)+2..StringLib.StringFind( ds , '::',4)-1];

aNewVersionIsReadytodeploy := (cert_version <> Latestbuildvs );

good_to_run_gwl_weekly := (certAndProdVersionsAreTheSame AND not(aNewVersionIsReadytodeploy));

actionMsg := if(good_to_run_gwl_weekly,Output('Go Ahead with build'),FAIL('New OFAC Build is in cert and so Hold off running GWL Weekly'));

return actionMsg;
end;