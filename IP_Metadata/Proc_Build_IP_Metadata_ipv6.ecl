﻿import _Control, BuildLogger, PromoteSupers, RoxieKeybuild, Scrubs_IP_Metadata, Std, Orbit3;

EXPORT Proc_Build_IP_Metadata_ipv6(string version ='20200519'
	, const varstring eclsourceip = '10.121.149.192', string srcdir = '/data/Builds/builds/ip_metadata/data/processing/', string suffixF = 'ip_metadata_header.csv'
		):= function

	#workunit('name', 'IP Metadata Build IPv6 - ' + version);

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Spray IP_Metadata Files to Thor////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		sprayRaw 				:= IP_Metadata.Spray_IP_Metadata_ipv6(version, eclsourceip, srcdir, suffixF);
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move IP_Metadata Base////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		bldBase					:= output(IP_Metadata.Map_IP_Metadata_ipv6(version),,$.File_IP_Metadata.base_path_ipv6+'_'+version, overwrite, __compressed__);

		clrDelete 			:= sequential(nothor(fileservices.clearsuperfile($.File_IP_Metadata.base_path_ipv6+'_delete', true)),
																	nothor(fileservices.clearsuperfile($.File_IP_Metadata.history_path_ipv6+'_delete', true)));		
		
		mvBase					:= Std.File.PromoteSuperFileList([$.File_IP_Metadata.base_path_ipv6,
																											$.File_IP_Metadata.base_path_ipv6+'_father',
																											$.File_IP_Metadata.base_path_ipv6+'_grandfather',
																											$.File_IP_Metadata.base_path_ipv6+'_delete'], 
																											$.File_IP_Metadata.base_path_ipv6+'_'+version, true);		
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Raw IP_Metadata History Files///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
		reformDaily 		:= project(distribute(IP_Metadata.File_IP_Metadata.Raw_ipv6), IP_Metadata.Layout_IP_Metadata.Raw_ipv6);													
		ccatRawHistory	:= output(dedup(sort(distribute(reformDaily + $.File_IP_Metadata.History_ipv6, hash(ip_rng_beg, ip_rng_end)), record, local), record, local),,$.File_IP_Metadata.history_path_ipv6+'_'+version,__compressed__);
	
		mvRawHistory		:= Std.File.PromoteSuperFileList([$.File_IP_Metadata.history_path_ipv6,
																											$.File_IP_Metadata.history_path_ipv6+'_father',
																											$.File_IP_Metadata.history_path_ipv6+'_grandfather',
																											$.File_IP_Metadata.history_path_ipv6+'_delete'], $.File_IP_Metadata.history_path_ipv6+'_'+version, true);																					
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build IP_Metadata Keys/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(IP_Metadata.Key_IP_Metadata_IPv6
																								,$.File_IP_Metadata.key_ipv6()
																								,$.File_IP_Metadata.key_ipv6(version)
																								,bldIPMetadata);	

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Move IP_Metadata Keys to Superfiles////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		RoxieKeybuild.Mac_SK_Move_to_Built_v2($.File_IP_Metadata.key_ipv6()
																					,$.File_IP_Metadata.key_ipv6(version)
																					,mvBldIPMetadata);
	
		PromoteSupers.Mac_SK_Move_v2($.File_IP_Metadata.key_ipv6(),'Q',mvQAIPMetadata,'3');

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Update DOPs Page///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		dopsUpdate 			:= RoxieKeybuild.updateversion('IP_MetadataKeys_IPV6', version, _control.MyInfo.EmailAddressNotify + ';alan.jaramillo@lexisnexis.com', , 'N');
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Orbit Update ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('IP Metadata_IPV6',version,'N'); 

	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Strata Reports for Build/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		IP_Metadata.Out_Strata_Population_Stats(IP_Metadata.File_IP_Metadata.Base
																						,version
																						,buildStrata);
																						
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Scrubs Reports for Build/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
																						
		scrubsRuns		:= sequential(Scrubs_IP_Metadata.RawFileScrubs(version, _control.MyInfo.EmailAddressNotify + ';alan.jaramillo@lexisnexis.com'), 
																Scrubs_IP_Metadata.BaseFileScrubs(version, _control.MyInfo.EmailAddressNotify + ';alan.jaramillo@lexisnexis.com')
																);

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Run Build, Add Logger, & Provide Email on Build Status/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		sendEmail			:=  sequential(
																				BuildLogger.BuildStart(false),
																				BuildLogger.PrepStart(false), 
																				sprayRaw, 
																				BuildLogger.PrepEnd(false),
																				BuildLogger.BaseStart(False), 
																				bldBase, 
																				BuildLogger.BaseEnd(False),
																				clrDelete, mvBase, ccatRawHistory, mvRawHistory,
																				BuildLogger.KeyStart(false), 
																				bldIPMetadata, mvBldIPMetadata, mvQAIPMetadata, 
																				BuildLogger.KeyEnd(false),
																				BuildLogger.PostStart(False),
																				dopsUpdate, orbit_update, 
																				//buildStrata, scrubsRuns, 
																				BuildLogger.PostEnd(False), 
																				BuildLogger.BuildEnd(false)):
																										Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';alan.jaramillo@lexisnexis.com', 'PhonesInfo Ported & Metadata Key Build Succeeded', workunit + ': Build complete.')),
																										Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';alan.jaramillo@lexisnexis.com', 'PhonesInfo Ported & Metadata Key Build Failed', workunit + '\n' + FAILMESSAGE)
		);					
																												
	return sendEmail;

end;