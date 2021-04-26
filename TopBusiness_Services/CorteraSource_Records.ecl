﻿// ================================================================================
// ===== RETURNS Cortera Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT BIPV2, Doxie, dx_Cortera, iesp, MDR, TopBusiness_Services;

EXPORT CorteraSource_Records (
  DATASET(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  Doxie.IDataAccess mod_access,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	BOOLEAN IsFCRA = FALSE) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));																																		
	// *** Key fetch to get cortera data from linkids key
  SHARED ds_corterakeys := PROJECT(TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                               inoptions.fetch_level,topbusiness_services.constants.SlimKeepLimit
																									      ).ds_cortera_linkidskey_recs,
																TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids_wSrc,
																             SELF.IdValue := (STRING) LEFT.link_id;
																						 SELF := LEFT;
																						 SELF := []
																						 ));
  SHARED cortera_key_combined := in_docids(IdValue <> '') + ds_corterakeys;		
  SHARED cortera_key_combinedSlim := DEDUP(SORT(cortera_key_combined, idValue),idValue);
																																													 									 
  SHARED cortera_payload_all := JOIN(cortera_key_combinedSlim,dx_Cortera.Key_Header_Link_Id,	                                     
                                     KEYED((INTEGER4)LEFT.IDValue = RIGHT.link_id),
                                     TRANSFORM(RIGHT),
                                     KEEP(20)); // To handle the delta updates for the same link_id, later the records will be rolled up


  dx_cortera.mac_incremental_rollup(cortera_payload_all, SHARED cortera_payload_rolledup_recs);
  
  dx_cortera.mac_append_contacts(cortera_payload_rolledup_recs, SHARED cortera_payload, mod_access, /*append_contacts*/ TRUE);
	       
   // name not cleaned into subpart so just using name last field for whole name														 
	 iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(cortera_payload) L, INTEGER C) := TRANSFORM
		self.Name.Full  				:= CHOOSE(C,L.executive_name1, L.executive_name2, L.executive_name3, L.executive_name4, L.executive_name5
		                                  , L.executive_name6, L.executive_name7, L.executive_name8, L.executive_name9, L.executive_name10);
																			
		self.Title							:= CHOOSE(C,L.title1,L.title2,L.title3,L.title4,L.title5,
		                                  L.title6,L.title7,L.title8,L.title9,L.title10);
		self := [];
  end;
	
	iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(cortera_payload) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue 								:= (STRING) L.link_id;
		SELF.Source 								:= MDR.sourceTools.src_Cortera; // payload had no value for l.source thus this.
		SELF.CompanyName        		:= L.name;
		SELF.Fein                   := L.Fein;
		SELF.Phone									:= L.clean_phone;		
		
		SELF.URL										:= L.url;
		
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
		
		// Create a dataset from the primary sic code fields		
		SELF.SICCodes := DATASET([{l.primary_sic,l.sic_desc}],iesp.topbusinessOtherSources.t_OtherSICCode);
		SELF.NAICSCodes := DATASET([{l.primary_naics,l.naics_desc}],iesp.topbusinessOtherSources.t_otherNAICSCodes);
		SELF.Contacts := NORMALIZE(DATASET(L),10,xform_contacts(LEFT,COUNTER));
		SELF := [];
	END;
	//output(cortera_recs, named('cortera_recs'));
	EXPORT SourceView_Recs := PROJECT(cortera_payload, toOut(left));
  EXPORT SourceView_RecCount := COUNT(cortera_payload);

END;