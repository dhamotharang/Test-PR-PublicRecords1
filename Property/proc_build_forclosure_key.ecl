IMPORT property,ut,RoxieKeyBuild,Risk_Indicators,VersionControl,promotesupers, dx_Property;

EXPORT proc_build_forclosure_key(string filedate) := FUNCTION

RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosures_FID,																//index
																						property.file_building_bdid(TRIM(deed_category)IN Category_filter.Foreclosure),	//dataset
																						'~thor_data400::key::foreclosure_fid_@version@',								//superfile
																						'~thor_data400::key::foreclosure::'+filedate+'::fid',						//key logical file
																						do1);			
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosure_DID,
																						Property.file_LexID_Key(did != 0),
																						'~thor_data400::key::foreclosures_did_@version@',
																						'~thor_data400::key::foreclosure::'+filedate+'::did',
																						do2);
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosures_BDID,
																						Property.file_LexID_Key(bdid != 0),
																						'~thor_data400::key::foreclosure_bdid_@version@',
																						'~thor_data400::key::foreclosure::'+filedate+'::bdid',
																						do3);
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosures_Addr,
																						Property.file_Addr_Key,
																						'~thor_data400::key::foreclosure_address_@version@',
																						'~thor_data400::key::foreclosure::'+filedate+'::address',
																						do4);
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosures_FID_Linkids,
																						property.File_building_Linkids(TRIM(deed_category)IN Category_filter.Foreclosure),
																						'~thor_data400::key::foreclosure_fid::linkids_@version@',
																						'~thor_data400::key::foreclosure::'+filedate+'::fid::linkids',
																						do9);
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosure_ParcelNum,
																						property.file_ParcelNum_Key,
																						'~thor_data400::key::foreclosure_parcelNum_@version@',
																						'~thor_data400::key::foreclosure::'+filedate+'::parcelNum',
																						do10);
																						
//Build Delta RID keys DF-28049
dDelta_rid  := dataset([], dx_Property.Layouts.i_Delta_Rid); 

RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosure_Delta_Rid,
																						dDelta_rid,
																						'~thor_Data400::key::foreclosure::@version@::delta_rid',
																						'~thor_data400::key::foreclosure::' + filedate +'::delta_rid',
																						do11);
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Normalized_Delta_Rid,
																						dDelta_rid,
																						'~thor_Data400::key::foreclosure_normalized::@version@::delta_rid',
																						'~thor_data400::key::foreclosure_normalized::' + filedate +'::delta_rid',
																						do12);																						

// Bug# 48040
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.Key_FI_Module.Key_FI_Geo11,'~thor_data400::key::foreclosure::@version@::index_geo11','~thor_data400::key::foreclosure::'+filedate+'::index_geo11',do5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.Key_FI_Module.Key_FI_Geo12,'~thor_data400::key::foreclosure::@version@::index_geo12','~thor_data400::key::foreclosure::'+filedate+'::index_geo12',do6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.Key_FI_Module.Key_FI_fips,'~thor_data400::key::foreclosure::@version@::index_fips','~thor_data400::key::foreclosure::'+filedate+'::index_fips',do7);

// Build LinkIDS
RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Property.Key_Foreclosure_Linkids.Key,
																						property.fn_file_bip('foreclosure'),
																						'~thor_data400::key::foreclosure::@version@::linkids',
																						'~thor_data400::key::foreclosure::' + filedate +'::linkids',
																						do8);

// Move keys to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_fid_@version@','~thor_data400::key::foreclosure::'+filedate+'::fid',do21);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosures_did_@version@','~thor_data400::key::foreclosure::'+filedate+'::did',do22);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_bdid_@version@','~thor_data400::key::foreclosure::'+filedate+'::bdid',do23);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_address_@version@','~thor_data400::key::foreclosure::'+filedate+'::address',do24);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_fid::linkids_@version@','~thor_data400::key::foreclosure::'+filedate+'::fid::linkids',do29);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_parcelNum_@version@','~thor_data400::key::foreclosure::'+filedate+'::parcelNum',do30);

//Move Delta RID to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::delta_rid','~thor_data400::key::foreclosure::'+filedate+'::delta_rid',do31);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure_normalized::@version@::delta_rid','~thor_data400::key::foreclosure_normalized::'+filedate+'::delta_rid',do32);

// Bug# 48040
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::index_geo11','~thor_data400::key::foreclosure::'+filedate+'::index_geo11',do25);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::index_geo12','~thor_data400::key::foreclosure::'+filedate+'::index_geo12',do26);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::index_fips','~thor_data400::key::foreclosure::'+filedate+'::index_fips',do27);

// Move LinkIDS to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::foreclosure::@version@::linkids','~thor_data400::key::foreclosure::'+filedate+'::linkids',do28);

// Move keys to QA superfile
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_fid','Q',do41,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosures_did','Q',do42,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_bdid','Q',do43,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_address','Q',do44,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_fid::linkids','Q',do49,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::foreclosure_parcelNum','Q',do50,2);

//Move Delta RID to QA
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::delta_rid','Q',do51,2);
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure_normalized::@version@::delta_rid','Q',do52,2);

// Bug# 48040
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::index_geo11','Q',do45,2);
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::index_geo12','Q',do46,2);
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::index_fips','Q',do47,2);

// Move LinkIDS to QA superfile
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::foreclosure::@version@::linkids','Q',do48,2);

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
					parallel(do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12),
					parallel(do21,do22,do23,do24,do25,do26,do27,do28,do29,do30,do31,do32),
					parallel(do41,do42,do43,do44,do45,do46,do47,do48,do49,do50,do51,do52),
					ak) : 
			success(bldsucc),
			failure(bldfail);
					
return buildkey;

end;