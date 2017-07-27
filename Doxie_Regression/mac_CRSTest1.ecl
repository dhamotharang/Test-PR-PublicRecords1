export mac_CRSTest1 := macro
a := 'doxie_regression.mac_CRSTest1';
#stored('DID',88696438)
//output(doxie.UCC_Records);
doxie.Comprehensive_Report_Service()
//doxie_crs.zztemp_testcrs()
 :	success(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'Finished'))
 ,	failure(ut.fRunAndNotify_SendEmail(doxie_regression.crs_email, a, 'FAILED',failmessage))
endmacro;