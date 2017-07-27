export mac_CRSTest2 := macro
a := 'doxie_regression.mac_CRSTest2';
#stored('DID',1829)
//output(doxie.dea_records);
doxie.Comprehensive_Report_Service()
//doxie_crs.zztemp_testcrs()
 :	success(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'Finished'))
 ,	failure(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'FAILED',failmessage))
endmacro;