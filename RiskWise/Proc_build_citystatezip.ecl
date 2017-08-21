import  RoxieKeyBuild,ut,Data_Services, doxie,_control;
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
UpdateRoxiePage         := Roxiekeybuild.updateversion('CityStZipKeys',filedate,'randy.reyes@lexisnexis.com,john.freibaum@lexisnexis.com',,'N|F|BN');
sample_citystatezip 		:= CityStateZip_Sample;
STRATA                  := STRATA_City_State_Zip;
send_email              := fileservices.sendemail('randy.reyes@lexisnexis.com; john.freibaum@lexisnexis.com; Michael.Gould@lexisnexis.com','City State Zip','\nCity State Zip file received on ' + filedate);

//Run build on Thor
return sequential(spray_add_file, a_key1, mv_a_key1, mv_a_key_qa1, a_key2, mv_a_key2, mv_a_key_qa2, UpdateRoxiePage, sample_citystatezip, STRATA(filedate), send_email);
end;
