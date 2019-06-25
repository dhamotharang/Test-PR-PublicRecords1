import property,ut,RoxieKeyBuild,Risk_Indicators,VersionControl,promotesupers;

export proc_build_forclosure_key(string filedate) := 
function

//pre := ut.SF_MaintBuilding('~thor_data400::base::foreclosure');

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosures_FID,'~thor_data400::key::foreclosure_fid','~thor_data400::key::foreclosure::'+filedate+'::fid',do1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosure_DID,'~thor_data400::key::foreclosures_did','~thor_data400::key::foreclosure::'+filedate+'::did',do2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosures_BDID,'~thor_data400::key::foreclosure_bdid','~thor_data400::key::foreclosure::'+filedate+'::bdid',do3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosures_Addr,'~thor_data400::key::foreclosure_address','~thor_data400::key::foreclosure::'+filedate+'::address',do4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosures_FID_Linkids,'~thor_data400::key::foreclosure_fid::linkids','~thor_data400::key::foreclosure::'+filedate+'::fid::linkids',do9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(property.Key_Foreclosure_ParcelNum,'~thor_data400::key::foreclosure_parcelNum','~thor_data400::key::foreclosure::'+filedate+'::parcelNum',do10);

// Bug# 48040
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.Key_FI_Module.Key_FI_Geo11,'~thor_data400::key::foreclosure::@version@::index_geo11','~thor_data400::key::foreclosure::'+filedate+'::index_geo11',do5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.Key_FI_Module.Key_FI_Geo12,'~thor_data400::key::foreclosure::@version@::index_geo12','~thor_data400::key::foreclosure::'+filedate+'::index_geo12',do6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.Key_FI_Module.Key_FI_fips,'~thor_data400::key::foreclosure::@version@::index_fips','~thor_data400::key::foreclosure::'+filedate+'::index_fips',do7);

// Build LinkIDS
VersionControl.macBuildNewLogicalKeyWithName(property.Key_Foreclosure_Linkids.Key,	Property._Dataset().thor_cluster_files + 'key::'	+ property._Dataset().Name + '::' + filedate +'::linkids', do8);

// Move keys to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_fid','~thor_data400::key::foreclosure::'+filedate+'::fid',do21);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosures_did','~thor_data400::key::foreclosure::'+filedate+'::did',do22);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_bdid','~thor_data400::key::foreclosure::'+filedate+'::bdid',do23);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_address','~thor_data400::key::foreclosure::'+filedate+'::address',do24);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_fid::linkids','~thor_data400::key::foreclosure::'+filedate+'::fid::linkids',do29);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_parcelNum','~thor_data400::key::foreclosure::'+filedate+'::parcelNum',do30);

// Bug# 48040
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::index_geo11','~thor_data400::key::foreclosure::'+filedate+'::index_geo11',do25);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::index_geo12','~thor_data400::key::foreclosure::'+filedate+'::index_geo12',do26);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::index_fips','~thor_data400::key::foreclosure::'+filedate+'::index_fips',do27);

// Move LinkIDS to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::linkids','~thor_data400::key::foreclosure::'+filedate+'::linkids',do28);

// Move keys to QA superfile
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_fid','Q',do31,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosures_did','Q',do32,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_bdid','Q',do33,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_address','Q',do34,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_fid::linkids','Q',do39,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_parcelNum','Q',do40,2);
// Bug# 48040
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::index_geo11','Q',do35,2);
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::index_geo12','Q',do36,2);
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::index_fips','Q',do37,2);

// Move LinkIDS to QA superfile
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::linkids','Q',do38,2);

//post := ut.SF_MaintBuilt('~thor_Data400::base::foreclosure');

bldsucc := fileservices.sendemail(Property.Roxie_Email_List,
							  'Foreclosure Weekly Roxie Keybuild Succeeded - ' + filedate,
								'Keys:\n' +
								'				1) thor_data400::key::foreclosure::autokey::qa::address(thor_data400::key::foreclosure::'+filedate+'::autokey::address)\n' +
								'				2) thor_data400::key::foreclosure::autokey::qa::addressb2(thor_data400::key::foreclosure::'+filedate+'::autokey::addressb2)\n' +
								'				3) thor_data400::key::foreclosure::autokey::qa::citystname(thor_data400::key::foreclosure::'+filedate+'::autokey::citystname)\n' +
								'				4) thor_data400::key::foreclosure::autokey::qa::citystnameb2thor_data400::key::foreclosure::'+filedate+'::autokey::citystnameb2)\n' +	
								'				5) thor_data400::key::foreclosure::autokey::qa::name(thor_data400::key::foreclosure::'+filedate+'::autokey::name)\n' +
								'				6) thor_data400::key::foreclosure::autokey::qa::nameb2(thor_data400::key::foreclosure::'+filedate+'::autokey::nameb2)\n' +
								'				7) thor_data400::key::foreclosure::autokey::qa::namewords2(thor_data400::key::foreclosure::'+filedate+'::autokey::namewords2)\n' +
								'				8) thor_data400::key::foreclosure::autokey::qa::payload(thor_data400::key::foreclosure::'+filedate+'::autokey::payload)\n' +
								'				9) thor_data400::key::foreclosure::autokey::qa::ssn2(thor_data400::key::foreclosure::'+filedate+'::autokey::ssn2)\n' +
								'			 10) thor_data400::key::foreclosure::autokey::qa::stname(thor_data400::key::foreclosure::'+filedate+'::autokey::stname)\n' +
								'			 11) thor_data400::key::foreclosure::autokey::qa::stnameb2(thor_data400::key::foreclosure::'+filedate+'::autokey::stnameb2)\n' +
								'			 12) thor_data400::key::foreclosure::autokey::qa::zip(thor_data400::key::foreclosure::'+filedate+'::autokey::zip)\n' +
								'			 13) thor_data400::key::foreclosure::autokey::qa::zipb2(thor_data400::key::foreclosure::'+filedate+'::autokey::zipb2)\n' +
								'			 14) thor_data400::key::foreclosure::qa::index_fips(thor_data400::key::foreclosure::'+filedate+'::index_fips)\n' +
								'			 15) thor_data400::key::foreclosure::qa::index_geo11(thor_data400::key::foreclosure::'+filedate+'::index_geo11)\n' +
								'			 16) thor_data400::key::foreclosure::qa::index_geo12(thor_data400::key::foreclosure::'+filedate+'::index_geo12)\n' +
								'			 17) thor_data400::key::foreclosure::qa::linkids(thor_data400::key::foreclosure::'+filedate+'::linkids)\n' +
								'			 18) thor_data400::key::foreclosures_did_qa(thor_data400::key::foreclosure::'+filedate+'::did)\n' +
								'			 19) thor_data400::key::foreclosure_address_qa(thor_data400::key::foreclosure::'+filedate+'::address)\n' +
								'			 20) thor_data400::key::foreclosure_bdid_qa(thor_data400::key::foreclosure::'+filedate+'::bdid)\n'+
								'			 21) thor_data400::key::foreclosure_fid_qa(thor_data400::key::foreclosure::'+filedate+'::fid)\n' +								
								'			 22) thor_data400::key::foreclosure_fid::linkids_qa(thor_data400::key::foreclosure::'+filedate+'::fid::linkids)\n' +
								'			 23) thor_data400::key::foreclosures_parcelNum_qa(thor_data400::key::foreclosure::'+filedate+'::parcelNum)\n' +
								'have been built and ready to be deployed to QA.');

bldfail := fileservices.sendemail('kgummadi@seisint.com;vniemela@seisint.com',
							  'Foreclosure Weekly Roxie Keybuild Failed - ' + filedate,
							  failmessage);

// autokeys
ak := Property.Proc_Build_Autokeys(filedate);

buildkey := sequential(
					parallel(do1,do2,do3,do4,do5,do6,do7,do8,do9,do10),
					parallel(do21,do22,do23,do24,do25,do26,do27,do28,do29,do30),
					parallel(do31,do32,do33,do34,do35,do36,do37,do38,do39,do40),
					ak) : 
			success(bldsucc),
			failure(bldfail);
					
return buildkey;

end;