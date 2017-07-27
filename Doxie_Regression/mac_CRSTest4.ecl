export mac_CRSTest4 := macro
a := 'doxie_regression.mac_CRSTest4';
#stored('DID',916832)
//output(doxie.atf_records77)
doxie.Comprehensive_Report_Service()
//doxie_crs.zztemp_testcrs()
 :	success(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'Finished'))
 ,	failure(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'FAILED',failmessage))
endmacro;