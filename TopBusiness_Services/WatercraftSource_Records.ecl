//=================================================================================
// ====== RETURNS WATERCRAFT DATA FOR A GIVEN WATERCRAFT_KEY & SEQUENCE_KEY  ======
// ====== IN ESP-COMPLIANT WAY.                                              ======
// ================================================================================
//
// This attribute was created by copying PersonReports.Watercraft_Records and 
// modified for use by TopBusiness_Services.SourceService_Records.
import iesp, TopBusiness_Services, Watercraft, WatercraftV2_Services, BIPV2;

export WatercraftSource_Records(
	dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
	boolean IsFCRA = false) 
 := MODULE

	SHARED water_keys_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		watercraftV2_services.Layouts.search_watercraftkey;
	END;
	
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get vehicle_keys from linkids
  ds_LinkWaterkeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly, // input ids to join key with
                                                               inoptions.fetch_level
																															).ds_wc_linkidskey_recs,
																TRANSFORM(water_keys_wLinkIds,
																					SELF.state_origin := LEFT.state_origin,
																					SELF.Watercraft_Key := LEFT.Watercraft_Key,
																					SELF.Sequence_Key := LEFT.Sequence_key,
																					SELF := LEFT,
																					SELF := []));
	
	// For records with an id value assigned and an Id type of watercraftsrcrec, then get key parts via sourcerec key
	in_docs_SourceRec := in_docids(IdValue != '' and Idtype = constants.watercraftsrcrec);
	ds_SrcRecWaterkeys := JOIN(in_docs_SourceRec, Watercraft.key_watercraft_SourceRecID, 
													     KEYED((INTEGER) LEFT.IdValue = RIGHT.source_rec_id), 
													   TRANSFORM(water_keys_wLinkIds,
																		SELF.state_origin   := RIGHT.state_origin,
																		SELF.Watercraft_Key := RIGHT.Watercraft_Key,
																		SELF.Sequence_Key   := RIGHT.Sequence_key,
																		SELF := LEFT,
																		SELF := []),
												     LIMIT(TopBusiness_Services.Constants.defaultJoinLimit,SKIP));
	
	// For records with an id value assigned and an Id type of watercraftkeys, then parse the idvalue to get the key parts
	in_docs_Parse := in_docids(IdValue != '' and Idtype = constants.watercraftkeys);
	ds_ParseWaterkeys := PROJECT(in_docs_Parse,TRANSFORM(water_keys_wLinkIds,
																	delim1 := StringLib.StringFind(LEFT.IdValue,'//',1);
																	delim2 := StringLib.StringFind(LEFT.IdValue,'//',2);
																	SELF.state_origin := LEFT.IdValue[1..delim1-1],
																	SELF.Watercraft_Key := LEFT.IdValue[delim1+2..delim2-1],
																	SELF.Sequence_Key := LEFT.IdValue[delim2+2..],
																	SELF := LEFT,
																	SELF := []));
										
	water_keys_comb := ds_LinkWaterkeys+ds_ParseWaterkeys+ds_SrcRecWaterkeys;
	
	// Get the raw data from the appropriate view.
	water_keys := PROJECT(water_keys_comb,TRANSFORM(watercraftV2_services.Layouts.search_watercraftkey,SELF := LEFT,SELF:=[]));

	water_keys_dedup := DEDUP(water_keys,ALL);
			
	water_sourceview := WatercraftV2_Services.WatercraftV2_raw.Report_View.by_Watercraftkey(water_keys_dedup,inoptions.ssn_mask,TRUE,IsFCRA);

	water_sourceview_iesp := project(water_sourceview, WatercraftV2_Services.Transforms.FormatReport2Record_plus(Left));

	// Add linkids to the output.
	SHARED water_sourceview_wLinkIds := JOIN(water_sourceview_iesp,water_keys_comb,
																					LEFT.Registration.StateOrigin = RIGHT.state_origin AND
																					LEFT.WaterCraftKey = RIGHT.Watercraft_Key AND
																					LEFT.sequence_key = RIGHT.Sequence_Key,
																					TRANSFORM(iesp.watercraft.t_WaterCraftReport2Record,
																									SELF.BusinessIds.DotID 		:= RIGHT.DotID;
																									SELF.BusinessIds.EmpID 		:= RIGHT.EmpID;
																									SELF.BusinessIds.POWID 		:= RIGHT.POWID;
																									SELF.BusinessIds.ProxID 	:= RIGHT.ProxID;
																									SELF.BusinessIds.SELEID 	:= RIGHT.SELEID;  
																									SELF.BusinessIds.OrgID 		:= RIGHT.OrgID;
																									SELF.BusinessIds.UltID 		:= RIGHT.UltID;
																									SELF.IdValue	:= RIGHT.IdValue;
																									SELF := LEFT,
																									SELF := []),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(iesp.watercraft.t_WaterCraftReport2Record L) := TRANSFORM
			normDate_iesp(iesp.share.t_Date d) := (unsigned)(d.Year*10000 + d.Month*100 + d.Day);
			
			self.src			:= 'WATERCRAFT';
			self.src_desc := 'Watercraft Registrations';
			self.hasName 	:= exists(L.owners(name.full <>'' or CompanyName <>''));
			self.hasSSN  	:= exists(L.owners(ssn <>''));
			self.hasDOB  	:=  exists(L.owners(dob.year<>0));
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= exists(L.owners(address.state <>'' or address.zip5 <>''));
		  self.hasPhone := false;
			self.dt_first_seen := normDate_iesp(L.DateLastSeen); //no first seen field
			self.dt_last_seen := normDate_iesp(L.DateLastSeen); 
			self := [];
	END;
		
	EXPORT SourceDetailInfo := project(water_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := water_sourceview_wLinkIds;
  EXPORT SourceView_RecCount := COUNT(water_sourceview_wLinkIds);

END;
