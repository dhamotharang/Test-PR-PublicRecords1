// ================================================================================
// ===== RETURNS Crash Carrier Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT iesp, BIPV2, CrashCarrier;

EXPORT CrashCarrierSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for bus reg to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get bus reg data
  crash_recs_link := CrashCarrier.Key_LinkIds.KFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level);
 	
	crash_recs_Linkid := JOIN(crash_recs_link,in_docids(IdValue = ''),
															BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level),
															TRANSFORM(LEFT));

	crash_recs_VlIdValue := JOIN(crash_recs_link,in_docids(IdValue != '',idType='vl_id'),
														 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND
														 TRIM(left.raw.carrier_id,LEFT,RIGHT) + '|' + TRIM(left.raw.crash_id,LEFT,RIGHT) = right.IdValue,
														 TRANSFORM(LEFT));
	
	crash_recs_IdValue := JOIN(crash_recs_link,in_docids(IdValue != '',idType!='vl_id'),
														 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	
														 TRIM(left.raw.carrier_id,LEFT,RIGHT) + TRIM(left.raw.crash_id,LEFT,RIGHT) = right.IdValue,
														 TRANSFORM(LEFT));
														 
	SHARED crash_recs := DEDUP(crash_recs_Linkid+crash_recs_VlIdValue+crash_recs_IdValue,
														 ALL,EXCEPT #expand(BIPV2.IDmacros.mac_ListAllLinkids()));
	
	iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(crash_recs) L) := TRANSFORM
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue := L.raw.carrier_id + L.raw.crash_id;
		SELF.CompanyName        			:= L.cleaned_carrier_name;
		SELF.StateCensusNumber				:= L.raw.state_number;
		SELF.StateIssuingCensusNumber := L.raw.state_issuing_number;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,L.addr_suffix,L.unit_desig,
															L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,'');
		
		SELF := [];
	END;

	EXPORT SourceView_Recs := PROJECT(crash_recs, toOut(left));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;
