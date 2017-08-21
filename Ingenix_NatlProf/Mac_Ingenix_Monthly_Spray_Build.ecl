//###########################
// Spray process : Ingenix_NatlProf.Mac_Ingenix_Monthly_Spray attribute is called from unix script which sprays files from each of the 3 sources
//                 Allied Health,Dental and Physicians.


export Mac_Ingenix_Monthly_Spray_Build(EnclarityDate, IngenixDate,filedate, pUseProd,pout, pIsIngenix = FALSE) := macro
import RoxieKeyBuild,doxie_build;

wl:=nothor(WorkunitServices.WorkunitList('',jobname:='Enclarity Build*'))(state in ['blocked','running','wait']);

  if(exists(wl),fail('Enclarity Build is running'));

emailsuccess := ingenix_natlprof.mac_Email_Local(filedate).email_success;
emailfailure := ingenix_natlprof.mac_Email_Local(filedate).email_failure;

// Wrappping these 2 lines in the #IF is overkill, but I'm doing it anyway.
#IF(pIsIngenix)
  prebuild := Ingenix_NatlProf.fspray_allsrc(IngenixDate) : SUCCESS(OUTPUT('spray and add super file...'));
  preinput := Ingenix_NatlProf.Proc_build_ingenix_input(IngenixDate);
#END

build_ingenix_base := ingenix_natlprof.proc_build_ingenix_base(EnclarityDate,pUseProd);
build_ingenix_keys := doxie_build.proc_build_ingenix_keys(filedate);
build_ingenix_prov_v2_autokeys := Ingenix_NatlProf.Proc_provider_Autokeybuild(filedate);
build_ingenix_sanc_v2_autokeys := Ingenix_NatlProf.Proc_Sanctions_Autokeybuild(filedate);
build_ingenix_Prov_booleankeys := Ingenix_NatlProf.Proc_Provider_Boolean_Keys(filedate);
build_ingenix_Sanc_booleankeys := Ingenix_NatlProf.Proc_Sanction_Boolean_Keys(filedate);
accept_keys := ingenix_natlprof.Proc_AcceptSK_ToQA :success(emailsuccess),failure(emailfailure);
qa_samples  := Ingenix_NatlProf.Samples_Ingenix_QA(filedate);
build_strata := Ingenix_NatlProf.Strata_Population_All(filedate);
ingenix_dops_update := RoxieKeybuild.updateversion('IngenixKeys',filedate,'skasavajjala@seisint.com',,'N|B');


pout := sequential(
#IF(pIsIngenix)
  sequential(prebuild, preinput),
#END
build_ingenix_base
,build_ingenix_keys
,parallel(build_ingenix_prov_v2_autokeys, build_ingenix_sanc_v2_autokeys)
,parallel(build_ingenix_Prov_booleankeys, build_ingenix_Sanc_booleankeys)
,accept_keys
,qa_samples
,build_strata
,ingenix_dops_update

);
endmacro;