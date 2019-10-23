
import Prof_License, Prof_LicenseV2, Lib_FileServices, STRATA, orbit_report, RoxieKeybuild, Orbit3;

 EXPORT proc_build_base_keys( string filedate) := function 

#option('skipFileFormatCrcCheck', 1);  

#workunit('name','Yogurt: Professional Licenses ' + filedate);


leMailTarget := 'skasavajjala@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
 
STRATA.CreateAsHeaderStats(Prof_License.proflic_as_header(Prof_License.File_prof_license_base_AID),
                           'Professional Licenses',
					       'data',
					       filedate,
					       '',
                           runAsHeaderStats
                          );
						  
STRATA.CreateAsBusinessHeaderStats(Prof_License.fProf_License_As_Business_Header(Prof_License.File_prof_license_base_AID),
                           'Professional Licenses',
					       'data',
					       filedate,
					       '',
                           runAsBusinessHeaderStats
                          );
													
dops_up := RoxieKeyBuild.updateversion('ProfLicKeys',filedate,'skasavajjala@seisint.com',,'N|B');
fcra_dops_up := RoxieKeyBuild.updateversion('FCRA_ProfLicKeys',filedate,'skasavajjala@seisint.com',,'F');
nfcra_orbit := Orbit3.proc_Orbit3_CreateBuild('Professional Licenses',filedate,'N|B');
fcra_orbit := Orbit3.proc_Orbit3_CreateBuild('FCRA Professional Licenses',filedate,'F');




zSetupBuilding
 := sequential(
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount('~thor_data400::base::prof_licenses_aid_building') > 0,
			output('Nothing added to BUILDING Superfile'),
			fileservices.addsuperfile('~thor_data400::base::prof_licenses_aid_building','~thor_data400::base::prof_licenses_AID',0,true)),
		fileservices.finishsuperfiletransaction()
		);

zSetupBuilt
 := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::prof_licenses_aid_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::prof_licenses_aid_BUILT','~thor_data400::base::prof_licenses_aid_building',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::prof_licenses_aid_BUILDING'),
		fileservices.finishsuperfiletransaction()
		);

orbit_report.prolic_stats(getretval);

return sequential
 (
  Prof_License.fn_ValidateInput, 
	Prof_License.proc_build_base,
	Prof_License.Scrub_Prof_License(filedate),
	zSetupBuilding,
/*	parallel(
				Prof_License.proc_build_moxie_fpos_Data_Key,
				Prof_License.proc_build_moxie_keys
		 ),
	*/
	fSendMail('Professional Licenses 1 of 2','Professional License Build:  Data complete ... Begin Roxie Keys and process'),
	parallel(
				//Prof_License.proc_build_roxie_keys, - this V1 keys are not using any more 
				//instead iof V1 we are using V2 keys but V1 base will useful. Because V2 base is derived from V1 Base.
				Prof_LicenseV2.Proc_Build_ProfLic(filedate),
				Prof_License.professional_licenses_stats,
				Prof_License.Prof_License_NewRelease_stats,
				Prof_License.Prof_License_QA_SAMPLE_records,
				Prof_License.Out_Base_Stats_Population,
				runAsHeaderStats,
				runAsBusinessHeaderStats
			 ),
	zSetupBuilt,
	getretval,
  dops_up,
  fcra_dops_up,

	fSendMail('Professional Licenses 2 of 2','Professional License Build:  Keys built & Stats Complete')
 );
 
 end;
