import watercraft,roxiekeybuild,doxie;

export proc_build_keys(string file_date) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_cid()   			 ,'~thor_data400::key::watercraft_cid'    			,'~thor_data400::key::watercraft::'+file_date+'::cid'    			  ,cid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_bdid   			 ,'~thor_data400::key::watercraft_bdid'   			,'~thor_data400::key::watercraft::'+file_date+'::bdid'   			  ,bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_did()    		 ,'~thor_data400::key::watercraft_did'    			,'~thor_data400::key::watercraft::'+file_date+'::did'    			  ,did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid()    		 ,'~thor_data400::key::watercraft_sid'    			,'~thor_data400::key::watercraft::'+file_date+'::sid'    			  ,sid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_wid()   			 ,'~thor_data400::key::watercraft_wid'    			,'~thor_data400::key::watercraft::'+file_date+'::wid'    			  ,wid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_hullnum			 ,'~thor_data400::key::watercraft_hullnum'			,'~thor_data400::key::watercraft::'+file_date+'::hullnum'			  ,hullnum_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_offnum 			 ,'~thor_data400::key::watercraft_offnum' 			,'~thor_data400::key::watercraft::'+file_date+'::offnum' 			  ,offnum_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_vslnam 			 ,'~thor_data400::key::watercraft_vslnam'       ,'~thor_data400::key::watercraft::'+file_date+'::vslnam' 			  ,vslnam_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Watercraft.Key_LinkIds.key 						 ,'~thor_data400::Key::watercraft_linkids' 		  ,'~thor_data400::key::watercraft::'+file_date+'::linkids' 		  ,linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid_linkids() ,'~thor_data400::key::watercraft_sid::linkids' ,'~thor_data400::key::watercraft::'+file_date+'::sid::linkids'  ,sid_key_linkids);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Watercraft.key_watercraft_SourceRecId 	 ,'~thor_data400::key::watercraft_Source_Rec_Id','~thor_data400::key::watercraft::'+file_date+'::Source_Rec_Id' ,Source_Rec_Id_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_cid'    		   ,'~thor_data400::key::watercraft::'+file_date+'::cid'           ,mv_cid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_bdid'   		   ,'~thor_data400::key::watercraft::'+file_date+'::bdid'          ,mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_did'    		   ,'~thor_data400::key::watercraft::'+file_date+'::did'           ,mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_sid'    		   ,'~thor_data400::key::watercraft::'+file_date+'::sid'           ,mv_sid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_wid'    		   ,'~thor_data400::key::watercraft::'+file_date+'::wid'           ,mv_wid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_hullnum'		   ,'~thor_data400::key::watercraft::'+file_date+'::hullnum'       ,mv_hullnum_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_offnum' 		   ,'~thor_data400::key::watercraft::'+file_date+'::offnum'        ,mv_offnum_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_vslnam' 		   ,'~thor_data400::key::watercraft::'+file_date+'::vslnam'        ,mv_vslnam_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::Key::watercraft_linkids'       ,'~thor_data400::key::watercraft::'+file_date+'::linkids'       ,mv_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_sid::linkids'  ,'~thor_data400::key::watercraft::'+file_date+'::sid::linkids'  ,mv_sid_key_linkids);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_Source_Rec_Id' ,'~thor_data400::key::watercraft::'+file_date+'::Source_Rec_Id' ,mv_Source_Rec_Id);

// FCRA 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_cid(true)    ,'~thor_data400::key::watercraft::fcra::cid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::cid'    ,fcra_cid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_did(true)    ,'~thor_data400::key::watercraft::fcra::did'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::did'    ,fcra_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid(true)   	,'~thor_data400::key::watercraft::fcra::sid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::sid'    ,fcra_sid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_wid(true)    ,'~thor_data400::key::watercraft::fcra::wid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::wid'    ,fcra_wid_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::cid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::cid'    ,mv_fcra_cid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::did'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::did'    ,mv_fcra_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::sid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::sid'    ,mv_fcra_sid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::wid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::wid'    ,mv_fcra_wid_key);

bk := sequential(parallel(cid_key,bdid_key,did_key,sid_key,wid_key,hullnum_key,offnum_key,vslnam_key,linkids_key,sid_key_linkids,Source_Rec_Id_key,fcra_cid_key,fcra_wid_key,fcra_did_key,fcra_sid_key),
								 parallel(mv_cid_key,mv_bdid_key,mv_did_key,mv_sid_key,mv_wid_key,mv_hullnum_key,mv_offnum_key,mv_vslnam_key,mv_linkids_key,mv_sid_key_linkids,mv_Source_Rec_Id,mv_fcra_cid_key,mv_fcra_wid_key,mv_fcra_sid_key,mv_fcra_did_key)
								 );
					
return bk;

end;

