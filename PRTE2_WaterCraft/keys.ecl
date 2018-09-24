IMPORT doxie, bipv2, ut, Data_Services, autokeyb2, PRTE2_Watercraft, Watercraft, fcra, AutoStandardI, mdr;

EXPORT keys := MODULE
	
	//BDID
	base_slim_bid 	:= TABLE(PRTE2_Watercraft.Files.df_main_slim,{bdid,state_origin,watercraft_key,sequence_key});
	base_srt_bid 		:= SORT(base_slim_bid, RECORD);
	base_ded_bid 		:= DEDUP(base_srt_bid, RECORD);
	
	EXPORT key_watercraft_bdid := INDEX(base_ded_bid ,{l_bdid := (UNSIGNED6) bdid},{state_origin, watercraft_key,sequence_key},
																			Constants.KEY_PREFIX + doxie.Version_SuperKey + '::bdid');
																												
	//CID
	EXPORT key_watercraft_cid (BOOLEAN IsFCRA = FALSE) := FUNCTION

  // fcra-restricted states:
	base_cid 			:= PRTE2_Watercraft.Files.CoastGuard(~IsFCRA OR state_origin NOT IN Constants.states);
	
	// DF-21901 Blank out specified fields in prte::key::watercraft::fcra::cid_qa
	ut.MAC_CLEAR_FIELDS(base_cid, base_cid_cleared, constants.fields_to_clear_cid);
	
	base_file_cid := if(IsFCRA, base_cid_cleared, base_cid);   
	
       
  RETURN INDEX(base_file_cid, 
							{state_origin,watercraft_key,sequence_key},{base_file_cid},
               if(IsFCRA, 
												PRTE2_Watercraft.Constants.KEY_PREFIX + 'fcra::',
												PRTE2_Watercraft.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::cid');
END;

	//DID
	EXPORT key_watercraft_did (BOOLEAN isFCRA = FALSE) := FUNCTION

  base_slim_did	:= TABLE (PRTE2_Watercraft.Files.Search((UNSIGNED6)did<>0), {did,state_origin,watercraft_key,sequence_key});

  // fcra-restricted states:
	base_srt_did	:= SORT(base_slim_did(~isFCRA OR state_origin NOT IN Constants.states),RECORD);
	
  base_ded_did	:= DEDUP(base_srt_did, RECORD);

  RETURN INDEX(base_ded_did,
							{l_did := (UNSIGNED6)did},{state_origin, watercraft_key,sequence_key},
              if(IsFCRA, 
											PRTE2_Watercraft.Constants.KEY_PREFIX + 'fcra::',
											PRTE2_Watercraft.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::did');
END;

	//HULLNUM
	hullnum_rec := RECORD
		STRING30  hull_number;
		STRING2  	state_origin;
		STRING30  watercraft_key;
		STRING30  sequence_key;
	END;

	hullnum_rec slim_main(PRTE2_Watercraft.Files.Main l) := TRANSFORM
		SELF.hull_number	:= Stringlib.StringCleanSpaces(l.hull_number);
		SELF 							:= l;
	END;

	mn_slim 						:= PROJECT(PRTE2_Watercraft.Files.Main, slim_main(LEFT));

	hullnum_rec slim_coastguard(PRTE2_Watercraft.Files.CoastGuard l) := TRANSFORM
		SELF.hull_number	:= Stringlib.StringCleanSpaces(l.hull_number);
		SELF 							:= l;
	END;

	cg_slim 						:= PROJECT(PRTE2_Watercraft.Files.CoastGuard, slim_coastguard(LEFT));

	hullnum_slim 				:= DEDUP(SORT(mn_slim + cg_slim,record),record);

	hullnum_rec check_search(hullnum_slim l) := TRANSFORM
		SELF 							:= l;
	END;
	
	hullnum_slim_vld 		:= JOIN(hullnum_slim(hull_number<>''), PRTE2_Watercraft.Files.Search_ded,
														LEFT.state_origin			= RIGHT.state_origin AND
														LEFT.watercraft_key		= RIGHT.watercraft_key AND
														LEFT.sequence_key			= RIGHT.sequence_key, 
														check_search(LEFT));

	EXPORT key_watercraft_hullnum := INDEX(hullnum_slim_vld,
																			{hull_number},{state_origin,watercraft_key,sequence_key},
																			PRTE2_Watercraft.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::hullnum');
																			
	//OFFNUM
	cg_slim_rec 				:= RECORD
		PRTE2_Watercraft.Files.CoastGuard.official_number;
		PRTE2_Watercraft.Files.CoastGuard.state_origin;
		PRTE2_Watercraft.Files.CoastGuard.watercraft_key;
		PRTE2_Watercraft.Files.CoastGuard.sequence_key;
	END;

	cg_slim 						:= TABLE(PRTE2_Watercraft.Files.CoastGuard, cg_slim_rec);
	cg_slim_ded 				:= DEDUP(SORT(cg_slim(official_number<>''),record),record);

	cg_slim_rec check_search(cg_slim_ded l) := TRANSFORM
		SELF 							:= l;
	END;

	cg_slim_vld 				:= JOIN(cg_slim_ded, PRTE2_Watercraft.Files.Search_ded,
														LEFT.state_origin		= RIGHT.state_origin AND		
														LEFT.watercraft_key	=	RIGHT.watercraft_key AND
														LEFT.sequence_key		=	RIGHT.sequence_key, 
														check_search(LEFT));

	EXPORT key_watercraft_offnum := INDEX(cg_slim_vld,
																			{official_number},{state_origin,watercraft_key,sequence_key},
																			PRTE2_Watercraft.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::offnum');
																			
	//SID
	EXPORT key_watercraft_sid (BOOLEAN IsFCRA = FALSE) := FUNCTION

  // fcra-restricted states:
  base_sid 					:= PRTE2_Watercraft.Files.Search_Ph_Supressed_bdid (~IsFCRA OR state_origin NOT IN Constants.states);
	
	// DF-21901 Blank out specified fields in prte::key::watercraft::fcra:sid
	ut.MAC_CLEAR_FIELDS(base_sid, base_sid_cleared, constants.fields_to_clear_sid);
	
	base_file_sid := if(IsFCRA, base_sid_cleared, base_sid);   


  RETURN INDEX(base_file_sid, 
							{state_origin, watercraft_key, sequence_key}, 
							{base_file_sid}-{Layouts.Exclusions},
              if(IsFCRA, 
												PRTE2_Watercraft.Constants.KEY_PREFIX + 'fcra::',
												PRTE2_Watercraft.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::sid');

	END;

//SID LINKIDS
	psid_linkids := 	project(PRTE2_Watercraft.Files.Search_Ph_Supressed_bdid,
												transform({Watercraft.Layout_Watercraft_Search_Base_slim ,BIPV2.IDlayouts.l_xlink_ids},
												self.bdid := left.bdid,
												self := left));
	
	EXPORT key_watercraft_sid_linkids := INDEX(psid_linkids,{state_origin, watercraft_key, sequence_key},
																					{psid_linkids}-{Layouts.Exclusions},
																					PRTE2_Watercraft.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::sid::linkids');

	//SourceRecID
	EXPORT key_watercraft_SourceRecID := INDEX(PRTE2_Watercraft.Files.Search,{source_rec_id},{state_origin,watercraft_key,sequence_key},
																						PRTE2_Watercraft.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::source_rec_id');
																						
	//vslnam
	vslnam_rec := RECORD
		STRING50 		vessel_name;
		STRING2 		state_origin;
		STRING30		watercraft_key;
		STRING30		sequence_key;
	END;

	vslnam_rec slim_main(PRTE2_Watercraft.Files.Main l) := TRANSFORM
		SELF.vessel_name:= l.watercraft_name;
		SELF 						:= l;
	end;

	mn_slim 					:= PROJECT(PRTE2_Watercraft.Files.Main, slim_main(left));

	vslnam_rec slim_coastguard(PRTE2_Watercraft.Files.CoastGuard l) := TRANSFORM
		SELF.vessel_name:= l.name_of_vessel;
		SELF 						:= l;
	END;

	cg_slim 					:= PROJECT(PRTE2_Watercraft.Files.CoastGuard, slim_coastguard(left));

	vslnam_slim 			:= mn_slim + cg_slim;
																			
	vslnam_slim_ded 	:= DEDUP(sort(vslnam_slim(vessel_name<>''), record), record);

	vslnam_rec check_search(vslnam_slim_ded l) := TRANSFORM
		SELF 						:= l;
	END;

	vslnam_slim_vld 	:= JOIN(vslnam_slim_ded, PRTE2_Watercraft.Files.Search_ded,
													LEFT.state_origin		=	RIGHT.state_origin AND
													LEFT.watercraft_key	=	RIGHT.watercraft_key AND
													LEFT.sequence_key		=	RIGHT.sequence_key, 
													check_search(LEFT));

	EXPORT key_watercraft_vslnam  := INDEX(vslnam_slim_vld,
																			{vessel_name},{state_origin,watercraft_key,sequence_key},
																			PRTE2_Watercraft.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::vslnam');
																			
	//WID
	EXPORT key_watercraft_wid(BOOLEAN IsFCRA = FALSE) := FUNCTION

  // fcra-restricted states:
	base_wid 		:= PRTE2_Watercraft.Files.Main(~IsFCRA OR state_origin NOT IN Constants.states);
	
	// DF-21920 Blank out specified fields in prte::key::watercraft::fcra:wid
	ut.MAC_CLEAR_FIELDS(base_wid, base_wid_cleared, constants.fields_to_clear_wid);
	
	base_file_wid := if(IsFCRA, base_wid_cleared, base_wid);  

  RETURN INDEX(base_file_wid, 
							{state_origin,watercraft_key,sequence_key},
              {base_file_wid},
              if(IsFCRA, 
											PRTE2_Watercraft.Constants.KEY_PREFIX + 'fcra::',
											PRTE2_Watercraft.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::wid');
	END;

	EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= PRTE2_Watercraft.Constants.KEY_PREFIX + doxie.Version_SuperKey + '::linkids'; //SuperKeyName

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(PRTE2_Watercraft.Files.Search, k, out_SuperKeyName)
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out_fetch, Level, joinLimit, JoinType);
		//the vl_id parameter is not applicable to DPPA sources
		ds_restricted := out_fetch(BIPV2.mod_sources.isPermitted(in_mod).bySource(MDR.sourceTools.fWatercraft(source_code,state_origin),''));
	  return ds_restricted;
	END;
		
	END;

END;
