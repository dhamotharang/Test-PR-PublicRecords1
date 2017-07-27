export mac_CRSTest3 := macro
a := 'doxie_regression.mac_CRSTest3';
#stored('DID',652)
//output(doxie.Pilot_Records);
doxie.Comprehensive_Report_Service()
//doxie_crs.zztemp_testcrs()
 :	success(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'Finished'))
 ,	failure(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'FAILED',failmessage))
endmacro;