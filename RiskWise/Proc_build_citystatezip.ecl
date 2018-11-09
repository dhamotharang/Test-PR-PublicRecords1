import  RoxieKeyBuild,ut,Data_Services, doxie,_control, Orbit3,Scrubs_CityStateZip;
export Proc_build_citystatezip(string filedate) := function

//Spray file to Thor
spray_add_file	:=fspray_add_citystatezip(filedate); 

//Build thor_data400::key::citystzip::ccyymmdd::citystzip
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(RiskWise.Key_CityStZip,'','~thor_data400::key::citystzip::'+filedate+'::citystzip',a_key1);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::citystzip','~thor_data400::key::citystzip::'+filedate+'::citystzip',mv_a_key1);
ut.mac_sk_move_v2('~thor_data400::key::citystzip', 'Q',mv_a_key_qa1, 2);

//Build thor_data400::key::zipcityst::ccyymmdd::zipcityst
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(RiskWise.Key_ZipCitySt,'','~thor_data400::key::zipcityst::'+filedate+'::zipcityst',a_key2);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ZipCitySt','~thor_data400::key::zipcityst::'+filedate+'::zipcityst',mv_a_key2);
ut.mac_sk_move_v2('~thor_data400::key::ZipCitySt', 'Q',mv_a_key_qa2, 2);

//DOPs update, QA Sample, STRATA, E-Mail
UpdateRoxiePage         := Roxiekeybuild.updateversion('CityStZipKeys',filedate,'Randy.Reyes@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'N|F');
sample_citystatezip 		:= CityStateZip_Sample;
STRATA                  := STRATA_City_State_Zip;
send_email              := fileservices.sendemail('Randy.Reyes@lexisnexisrisk.com; Manuel.Tarectecan@lexisnexisrisk.com; Abednego.Escobal@lexisnexisrisk.com','City State Zip','\nCity State Zip file received on ' + filedate);
orbit_update 						:= sequential(Orbit3.proc_Orbit3_CreateBuild_AddItem('CityStateZip',filedate,'N')
																																	,Orbit3.proc_Orbit3_CreateBuild_AddItem('CityStateZip',filedate,'F'));

//Run build on Thor
return sequential(spray_add_file, a_key1, mv_a_key1, mv_a_key_qa1, a_key2, mv_a_key2, mv_a_key_qa2, UpdateRoxiePage, sample_citystatezip, STRATA(filedate), Scrubs_CityStateZip.fnRunScrubs(filedate,''),orbit_update, send_email);
end;
