#option('skipFileFormatCrcCheck', 1);
import RoxieKeyBuild, ut, doxie, doxie_build, promotesupers;

export proc_build_PersonHeaderLookupKey(string filedate) := function

pop_sf := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0,
							output('Nothing added to thor_data400::Base::HeaderKey_Building'),
							fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true));
							
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Doxie.Key_Did_Lookups_v2,'~thor_data400::key::header::'+filedate+'::lookups_v2','',build_);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::header::'+filedate+'::lookups_v2','~thor_data400::key::header_lookups_v2',mv_built);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::header_lookups_v2','Q',mv_qa);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(Doxie_build.Key_prep_D2C_Lookup(),'~thor_data400::key::D2C::'+filedate+'::lookups','',build2_);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::D2C::'+filedate+'::lookups','~thor_data400::key::D2C_lookups',mv2_built);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::D2C_lookups','Q',mv2_qa);

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	
email := fileservices.sendemail('cthompson@seisint.com',
								'Person Header Lookup v2: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::header_lookups_v2_qa(thor_data400::key::header::'+ filedate +'::lookups_v2),\n' +
						        '         have been built and ready to be deployed to QA.'); 
/* ***************************************************************************************************************************************** */

return sequential(
								  pop_sf
								 ,build_,mv_built,mv_qa
	            ,build2_,mv2_built,mv2_qa
								,fileservices.clearsuperfile('~thor_data400::Base::HeaderKey_Building')
								,email
								);
end;