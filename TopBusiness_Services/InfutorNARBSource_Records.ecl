// ================================================================================
// ===== RETURNS Infutur NARB Source Count Info and source docs
// ================================================================================
IMPORT BIPV2, iesp,Address ,TopBusiness_Services;

EXPORT InfutorNARBSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for infutor narb to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	SHARED in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));									
	// *** Key fetch to get infutor Narb data.		
     SHARED ds_infutorNarbRecs := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                               inoptions.fetch_level,TopBusiness_Services.Constants.SlimKeepLimit
																									      ).ds_infutor_narb_linkidskey_recs;
																												
   // sort by linkids and then by 'C' for current to get the more current source docs
   SHARED ds_infutorNarbRecsSlim :=  DEDUP(SORT(ds_infutorNarbRecs, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), record_id,IF(record_type = 'C', 0, 1), -dt_last_seen),
	                                                                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), record_id);
																												
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
	SHARED infutorNarb_idValue := JOIN(ds_infutorNarbRecsSlim,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										((trim(LEFT.pid,left,right) + TRIM(LEFT.record_ID,left,right)) =trim(right.IdValue,left,right) OR right.IdValue = ''),  
										TRANSFORM(LEFT));
	
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(infutorNarb_idValue) L) := TRANSFORM
		self.Name.First  				:= L.first_name;
	     self.Name.Middle 			:= L.middle_name;
		self.Name.Last 			     := L.surname;  
		self.Name.Suffix 				:= L.name_suffix;  	
		self.Name.Prefix 				:= L.title;		
		self := [];
  end;
	
	SHARED UNSIGNED1 region := address.Components.Country.US; // default
	
	SHARED iesp.topbusinessOtherSources.t_otherSICCode xform_sic(recordof(infutorNarb_idValue) L, INTEGER C) := TRANSFORM
		self.Code  := CHOOSE(C,L.sic1,L.sic2,L.sic3,L.sic4,L.sic5)[1..4];			
		SELF.Description := CHOOSE(C, L.heading1, L.heading2, L.heading3, L.heading4, L.heading5);									
	end;
	 
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(infutorNarb_idValue) L) := TRANSFORM
	      // shortcut way to set all linkids
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue 								:= trim(L.pid,left,right) + trim(L.record_id,left,right); // had to use both fields as that is what in the industry key (source_docid) and bipv2 header key(vl_id)
		SELF.Source 								:= L.source;
		SELF.CompanyName        		:= L.Clean_company_Name;
		SELF.ParentCompany                 := L.Parent_company;
		SELF.Phone									:= L.clean_phone;		
		SELF.IncorpDate                                         := iesp.ecl2esp.toDatestring8(L.year_started+'0000');
		SELF.URL										:= L.url;
		SELF.Fein                                                     := L.ein;    
		SELF.IndustryDescription                        := L.heading1;		
		SELF.Address := iesp.ECL2ESP.setAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
           	
		addr2 := Address.Addr2FromComponents(L.Parent_city, L.Parent_state, L.Parent_zip);
		
		cleanAddr := Address.GetCleanAddress(L.Parent_Address, addr2, region).results;															
            SELF.ParentCompanyAddress := iesp.ecl2esp.setAddress(cleanAddr.prim_name, cleanAddr.prim_range, 
						                                                        cleanAddr.predir, cleanAddr.postdir ,
						                                                        cleanAddr.suffix, cleanAddr.unit_desig ,cleanAddr.sec_range ,  
																   L.Parent_city,  L.Parent_state, L.Parent_zip,'','');
		
		// Create a dataset from the 5 sic code fields
		SELF.SICCodes := NORMALIZE(DATASET(L),5,xform_sic(LEFT, COUNTER));
		
		SELF.Contacts := PROJECT(L,xform_contacts(LEFT));
		SELF := [];
	END;
	
	SHARED infutorNarb_idValue_slim := DEDUP( infutorNarb_idValue, ALL);
	// output(infutorNarb_idValue, named('infutorNarb_idValue'));
	// output(infutorNarb_idValue_slim, named('infutorNarb_idValue_slim'));
	
	EXPORT SourceView_Recs := PROJECT(infutorNarb_idValue_slim, toOut(LEFT));
     EXPORT SourceView_RecCount := COUNT(infutorNarb_idValue_slim);

END;
