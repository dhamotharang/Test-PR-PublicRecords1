// ================================================================================
// ===== RETURNS Equifax businesss Data Source Count Info and source docs
// ================================================================================
IMPORT BIPV2, iesp,Address ,TopBusiness_Services, dx_Equifax_business_data;

EXPORT EquifaxBusinessDataSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
      // There isn't any unique id key file for Equifax Bus Data to build the source doc from, for this reason
     // the payload file of the linkid key file will be used.
  SHARED in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
                    SELF := LEFT,
                    SELF := []));
									
   SHARED layout_ds_equifaxBusinessDatalinkidsKey := dx_Equifax_business_data.Layout_Keybase;
   
   // *** Key fetch to get Equifax Bus Data.
   SHARED ds_EquifaxBusinessDataRecs := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													           inoptions.fetch_level,TopBusiness_Services.Constants.SmallKeepLimit
                                                                               ).ds_equifax_bus_data_linkidskey_recs;
																												
   SHARED ds_EquifaxBusinessDataRecsSlim := DEDUP(SORT(ds_EquifaxBusinessDataRecs, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), efx_id,IF(record_type = 'C', 0, 1), -dt_last_seen),
                                                                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), efx_id);
	 	                                                   																																																				
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
   SHARED EquifaxBusinessDataRecs_idValue := JOIN(ds_EquifaxBusinessDataRecsSlim,in_docids,
                                                     BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
                                                     (TRIM(LEFT.efx_id,LEFT,RIGHT) = TRIM(RIGHT.IdValue,left,right) OR RIGHT.IdValue = ''),                                                    
  								           TRANSFORM(layout_ds_equifaxBusinessDatalinkidsKey, SELF := LEFT;));
     UNSIGNED1 region := address.Components.Country.US; // default
	
       iesp.topbusinessOtherSources.t_otherSICCode xform_sic(layout_ds_equifaxBusinessDatalinkidsKey L, INTEGER C) := TRANSFORM     
           SELF.Code  := CHOOSE(C,L.efx_primsic,L.efx_secsic1,L.efx_secsic2,L.efx_secsic3,L.efx_secsic4);
           SELF.Description := CHOOSE(C,L.efx_primsicdesc, L.efx_secsicdesc1,  L.efx_secsicdesc2, L.efx_secsicdesc3, L.efx_secsicdesc4);
      END;
	
     iesp.topbusinessOtherSources.t_otherNAICSCodes xform_naics( layout_ds_equifaxBusinessDatalinkidsKey L, INTEGER C) := TRANSFORM      
         SELF.Code  := CHOOSE(C,L.efx_primnaicscode,L.efx_secnaics1,L.efx_secnaics2,L.efx_secnaics3,L.efx_secnaics4);
         SELF.Description := CHOOSE(C,L.efx_primnaicsdesc, L.efx_secnaicsdesc1,  L.efx_secnaicsdesc2, L.efx_secnaicsdesc3, L.efx_secnaicsdesc4);
      END;
  
      iesp.topbusinessOtherSources.t_OtherContact xform_contacts( layout_ds_equifaxBusinessDatalinkidsKey L) := TRANSFORM
           SELF.Name.FIRST  				:= L.Contact_fname;
           SELF.Name.Middle 				:= L.Contact_mname;
           SELF.Name.Last 					:= L.Contact_lname;
           SELF.Name.Suffix 				:= L.Contact_name_suffix;
           SELF.Name.Prefix 				:= L.Contact_title;
           SELF.Title							:= L.EFX_TitleDesc;
           SELF := [];
      END;
	
  iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(  layout_ds_equifaxBusinessDatalinkidsKey L) := TRANSFORM
	      // shortcut way to set all linkids
		TopBusiness_Services.IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
           SELF.IdValue 								:= L.efx_id;
           SELF.Source 								:= L.source;
           SELF.CompanyName        		:= L.Clean_company_Name;		
           SELF.Phone									:= L.clean_phone;		
           SELF.IncorpDate                                         := iesp.ecl2esp.toDatestring8(L.efx_yrest+'0000');
           SELF.URL										:= L.efx_web;	     
		SELF.Address := iesp.ECL2ESP.setAddress(
                             L.prim_name,L.prim_range,L.predir,L.postdir,
                             L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
                             L.st,L.zip,L.zip4,'');

          addr2 := Address.Addr2FromComponents(L.efx_seccty, L.efx_secstat, L.efx_seczip);	
          cleanAddr := Address.GetCleanAddress(L.efx_secadr, addr2, region).results;															
            SELF.SecondaryCompanyAddress := iesp.ecl2esp.setAddress(cleanAddr.prim_name, cleanAddr.prim_range, 
                     cleanAddr.predir, cleanAddr.postdir ,
                     cleanAddr.suffix, cleanAddr.unit_desig ,cleanAddr.sec_range ,  
                     L.efx_seccty,  L.efx_secstat, L.efx_seczip,'','');															
           	
		// Create a dataset from the 5 sic code fields for both sic and naics codes
           SELF.SICCodes := NORMALIZE(DATASET(L),5,xform_sic(LEFT, COUNTER));
           SELF.NAICSCodes := NORMALIZE(DATASET(L),5, xform_naics(LEFT,COUNTER));		    	
           SELF.Contacts :=  PROJECT(L,xform_contacts(LEFT));
           SELF.Sales := (STRING15) ((UNSIGNED4)L.EFX_corpamount * 1000);
           SELF.RecordDate := iesp.ecl2esp.toDate(l.clean_extract_date);
           SELF.RecordUpdateDate := iesp.ecl2esp.toDate(L.clean_record_update_refresh_date);
           SELF := [];
    END;
	
	// output(EquifaxBusinessDataRecs_idValue, named('EquifaxBusinessDataRecs_idValue'));
	
     EXPORT SourceView_Recs := PROJECT(EquifaxBusinessDataRecs_idValue, toOut(left));
     EXPORT SourceView_RecCount := COUNT(EquifaxBusinessDataRecs_idValue);

END;
