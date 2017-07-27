import ut,RoxieKeybuild;

export proc_build_abius_company_keys(string filedate) := function

pre := ut.SF_MaintBuilding('~thor_data400::base::ABIUS_Company');

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(InfoUSA.Key_ABIUS_Company_BDID,'~thor_data400::key::abius_company_bdid_qa','~thor_data400::key::abius::'+filedate+'::company::bdid',do1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(infousa.Key_ABIUS_Company_abi,'~thor_data400::key::abius_company_abi_qa','~thor_data400::key::abius::'+filedate+'::company::abi',do1a);


RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::abius_company_bdid','~thor_data400::key::abius::'+filedate+'::company::bdid',move1);
RoxieKeyBuild.Mac_SK_Move_to_built_v2('~thor_data400::key::abius_company_abi','~thor_data400::key::abius::'+filedate+'::company::abi',move1a);

/* ut.MAC_SK_BuildProcess_v2(InfoUSA.Key_ABIUS_Company_BDID,'~thor_data400::key::abius_company_bdid',do1);
   ut.MAC_SK_BuildProcess_v2(infousa.Key_ABIUS_Company_abi,'~thor_data400::key::abius_company_abi',do1a);
*/

ut.mac_sk_move_v2('~thor_data400::key::abius_company_bdid','Q',do2,2);
ut.MAC_SK_Move_v2('~thor_data400::key::abius_company_abi', 'Q', do2a, 2);

post := ut.SF_MaintBuilt('~thor_data400::base::ABIUS_Company');

jobComplete := FileServices.sendemail('roxiedeployment@seisint.com,tedman@seisint.com', 'ABIUS Roxie Key Build Succeeded - '+filedate,
               'Keys: 1) thor_data400::key::abius_company_bdid_qa(thor_data400::key::abius::'+filedate+'::company::bdid),\n' + 
			   '      2) thor_data400::key::abius_company_abi_qa(thor_data400::key::abius::'+filedate+'::company::abi),\n'  + 
		       '         have been built and moved to QA.');
							 
jobFailed := FileServices.sendemail('tedman@seisint.com', 'ABIUS Roxie Key Build Failed - '+filedate, failmessage);

retval := sequential(pre,do1,do1a,move1,move1a,do2,do2a,post,jobcomplete);

return retval;

end;
