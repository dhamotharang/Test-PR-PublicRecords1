// ================================================================================
// ===== RETURNS Gong Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT iesp, BIPV2, TopBusiness_Services;

EXPORT GongSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get gong data
  SHARED gong_recs := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                             inoptions.fetch_level,
																											 TopBusiness_Services.Constants.GongKfetchMaxLimit
																										  ).ds_gong_linkidskey_recs;

	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
   SHARED gong_idValue := JOIN(gong_recs,in_docids,
															 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
															 (((string) left.persistent_record_id = right.IdValue AND 
													     right.IdType = Constants.sourcerecid) OR 
															 (right.IdValue = left.bell_id + '-' + left.sequence_number AND
															 right.IdType = Constants.busvlid) OR
                               right.IdValue = ''),
                               TRANSFORM(LEFT));

	iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(gong_idValue) L) := TRANSFORM
	
		string PhoneType := MAP(L.listing_type_gov = 'G' => 'G',
																			 L.listing_type_bus = 'B' => 'B',
																			 L.listing_type_res = 'R' => 'R',
																			 '');
																			 
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.CompanyName        		:= L.listed_name;
		SELF.Phone									:= L.phone10;
		SELF.PhoneType							:= PhoneType;
		SELF.PhoneTypeDescription		:= CASE(PhoneType,
																		'G' => TopBusiness_Services.Constants.PhoneTypeDescription.Government,	
																		'B' => TopBusiness_Services.Constants.PhoneTypeDescription.Business,
																		'R' => TopBusiness_Services.Constants.PhoneTypeDescription.Residential,
																		'');
																		
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.z5,L.z4,'');
		SELF.IdValue 								:= L.bell_id + '-' + L.sequence_number;
		SELF := [];
	END;
	
	SourceView_RecsIesp := PROJECT(gong_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;
