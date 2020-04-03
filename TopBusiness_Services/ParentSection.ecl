import TopBusiness_Services, autostandardI, Doxie, iesp, BIPV2, BIPV2_Best, dx_Gong, MDR, Suppress;

export ParentSection := MODULE;

export fn_fullView (
	dataset(ParentSection_Layouts.rec_input) ds_in_data,
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod
	,dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_busHeaderRecs
  ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
	) := FUNCTION

  gm := AutoStandardI.GlobalModule();
  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm))
    export ln_branded := in_options.lnbranded;
    export glb := in_mod.GLBPurpose;
    export dppa := in_mod.DPPAPurpose;
    export show_minors := in_mod.IncludeMinors;
    export DataRestrictionMask := in_mod.DataRestrictionMask;
  END;

	FETCH_LEVEL := in_options.BusinessReportFetchLevel;
	ds_in_unique_ids_ForHeader := project(ds_in_data,
	                            transform(BIPV2.IDlayouts.l_xlink_ids,
															 self.proxweight := 0;
															 self.proxscore := 0;
															 self.ultscore := 0;
															 self.ultweight := 0;
															 self.dotscore := 0;
															 self.dotweight := 0;
															 self.orgscore := 0;
															 self.orgweight := 0;
															 self.powscore := 0;
															 self.powweight := 0;
															 self.empscore := 0;
															 self.empweight := 0;
															 self.selescore := 0;
															 self.seleweight := 0;
															 self := left,
															 ));

	BusHeaderRecs := dedup(sort(ds_busHeaderRecs,
		                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
													,record),
		                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
															 );

	 dsUltlinkIDInfo := project(ds_BusHeaderRecs(ParentAboveSELE = true),
	       transform({unsigned6 rcid; BIPV2.IDlayouts.l_xlink_ids;},
		 		                     self.rcid := left.rcid;
		                         self.ultid := 0;
														 self.orgid := 0;
														 self.seleid := 0;
                             self.proxid := left.ultimate_proxid;
														 self.powid := 0;
														 self.empid := 0;
														 self.dotid := 0;
														 self := [];
														 ));

      // now link go through each set of ultimate_proxid row and hit the
			// best key to get ultimate parent information
			// keeping linkids from the left side
			// should be very small join so hitting best key inside to get data
			// not a big inefficiency

		 ds_relative_rec := join(BusHeaderRecs,  dsUltlinkIDInfo,
		                  left.rcid = right.rcid,
		                  transform({unsigned6 orig_ultid; unsigned6 orig_orgid; unsigned6 orig_seleid; unsigned6 orig_proxid;
											           unsigned6 orig_powid; unsigned6 orig_empid; unsigned6 orig_dotid;
											 TopBusiness_Services.ParentSection_Layouts.rec_relative;},
											    tmpproxid := right.proxid;

                          BIPV2.IDlayouts.l_xlink_ids ProxXform() := TRANSFORM
													                  SELF.proxid := tmpProxid;
																						SELF := [];
                          END;

                          ParentDS := dataset([ ProxXform() ]);
                          // SPECIFICALLY use the proxid level fetch here since we want a specific parent
													// for a particular proxid
													// **********
													// this kfetch call to BIPV2 Best key is ALREADY doing the filter of the source = D recs already so
													// no need to filter the address parts and only show (cname/city/state/zip). as the prim_range, prim_name
													// come back empty as is.

												  ParentInfo := BIPV2_Best.Key_LinkIds.kfetch(parentDS, BIPV2.IDconstants.Fetch_Level_PROXID,,,false,TopBusiness_Services.Constants.BestKfetchMaxLimit);
													parentIndexToUse := if (ParentInfo[1].company_name[1].sources[1].source <> MDR.sourceTools.src_Dunn_Bradstreet and
													                           ParentInfo[1].company_name[1].sources[1].source <> '',
													                       1,
																								if (ParentInfo[1].company_name[1].sources[2].source <> MDR.sourceTools.src_Dunn_Bradstreet and
													                           ParentInfo[1].company_name[1].sources[2].source <> '',
																								     2,
																										 if (ParentInfo[1].company_name[1].sources[3].source <> MDR.sourceTools.src_Dunn_Bradstreet and
													                           ParentInfo[1].company_name[1].sources[3].source <> '',
																										 3,
																										 if (ParentInfo[1].company_name[1].sources[4].source <> MDR.sourceTools.src_Dunn_Bradstreet and
													                           ParentInfo[1].company_name[1].sources[4].source <> '',
																										   4,
																											 0 // default if not found a valid non source = D source is
																											   // to not index into the structure at all thus 0 here
                                                         ))));

												 okToDisplay := parentIndexToUse <> 0; // meaning that we have found a non-source D from
												                                          // from bestKfetch (either 1,2,3,4 above)
																																	// so that we have a source Doc to display
                         okToDisplayReportLink := parentIndexToUse <> 0;
												 // split this functionality out in case later we need to add further granular business Rules.

												// don't display linkids (which triggers the report LINK in GUI) if only source from best key
												// is source = D.
                         self.ultid := if (okToDisplayReportLink, ParentInfo[1].ultid, 0);
												 self.orgid := if (okToDisplayReportLink, ParentInfo[1].orgid, 0);
												 self.seleid := if (okToDisplayReportLink, ParentInfo[1].seleid, 0);
												 self.proxid := if (okToDisplayReportLink, ParentInfo[1].proxid, 0);
												 self.powid := if (okToDisplayReportLink, ParentInfo[1].powid, 0);
												 self.empid := if (okToDisplayReportLink, ParentInfo[1].empid, 0);
												 self.dotid := if (okToDisplayReportLink, ParentInfo[1].dotid, 0);
													//
													// setting here so I can join back the Acctno at the end
													//
												 self.orig_ultid := left.ultid;
												 self.orig_orgid := left.orgid;
												 self.orig_seleid := left.seleid;
												 self.orig_proxid := left.proxid;
												 self.orig_powid := left.powid;
												 self.orig_empid := left.empid;
												 self.orig_dotid := left.dotid;

												 self.CompanyName  := ParentInfo[1].company_name[1].company_name;
												 self.Name := iesp.ecl2esp.setName('','','','','','');
												 self.uniqueId := '';
												 self.BusinessIDs.ultid := if (okToDisplayReportLink, ParentInfo[1].ultid, 0);
												 self.businessIDs.orgid := if (okToDisplayReportLink, ParentInfo[1].orgid, 0);
												 self.BusinessIDs.seleid := if (okToDisplayReportLink, ParentInfo[1].seleid, 0);
												 self.BusinessIDs.proxid := if (okToDisplayReportLink, ParentInfo[1].proxid, 0);
												 self.BusinessIDs.powid :=  if (okToDisplayReportLink, ParentInfo[1].powid, 0);
												 self.BusinessIDs.empid := if (okToDisplayReportLink, ParentInfo[1].empid, 0);
												 self.BusinessIDs.dotid := if (okToDisplayReportLink, ParentInfo[1].dotid, 0);
												 // again don't need to worryabout Source = D filter in addr structure output
												 // cause info from best Kfetch already
												 // does filtering out of source = D address structure meaning streetName/StreetNum/zip/county/addr suffix
												 // are returned as null.
												 self.Address      := iesp.ECL2ESP.SetAddress(
																	ParentInfo[1].company_address[1].company_prim_name,ParentInfo[1].company_address[1].company_prim_range,ParentInfo[1].company_address[1].company_predir,ParentInfo[1].company_address[1].company_postdir,
																	ParentInfo[1].company_address[1].company_addr_suffix,ParentInfo[1].company_address[1].company_unit_desig,ParentInfo[1].company_address[1].company_sec_range,ParentInfo[1].company_address[1].address_v_city_name,
																	ParentInfo[1].company_address[1].company_st,ParentInfo[1].company_address[1].company_zip5,ParentInfo[1].company_address[1].company_zip4,ParentInfo[1].company_address[1].county_name,'','','',''); //,

												 self.phoneInfo.phone10        := if ( okToDisplay,
												               ParentInfo[1].company_phone[1].company_phone,'');
												 self.phone := if (okToDisplay,
												                ParentInfo[1].company_phone[1].company_phone,'');
												 src_code := ParentInfo[1].company_name[1].sources[parentIndexToUse].Source;
												 OtherDirectoriesSource :=
														 (not( src_code in TopBusiness_Services.SourceServiceInfo.SourceSectionSources));

												 IdType := topbusiness_services.functions.fn_SourceDocSetIdType(left.source,otherDirectoriesSource);
                         IDValue := topbusiness_services.functions.fn_SourceDocSetIdValue(left.source,
																																															 ParentInfo[1].company_name[1].sources[parentIndexToUse].source_record_id,
															                                                                 left.source_docid,
																																															 ParentInfo[1].company_name[1].sources[parentIndexToUse].vl_id,
																																															 otherDirectoriesSource);

													sourcedocs :=
														 dataset([{ParentInfo[1].dotid, // these 7 rows self explanatory
														           ParentInfo[1].empid,
																		   ParentInfo[1].powid,
																			 ParentInfo[1].proxid,
																			 ParentInfo[1].seleid,
																			 ParentInfo[1].orgid,
																			 ParentInfo[1].ultid,
                                       idType, // idtype
																			 idValue, //idvalue
																			 'parent', // section
																			 src_code, // source
																			 '','','','','', // starting t_address
																			 '','','','','', // .....
																			 '','','','','','', //...
																			 '','','','','','','' // starting t_nameandCompany
																			 }],iesp.topbusiness_share.t_TopBusinessSourceDocInfo);
                           emptySourceDocs := dataset([],iesp.topbusiness_share.t_TopBusinessSourceDocInfo);
														 // don't display linkids for source docs if nothing
														 // came back from best key other than Source = D.
                           self.sourceDocs := if (okToDisplay, sourceDocs,emptysourceDOcs);
                           self := [];
	                        ));
   ds_slim_relative := dedup(ds_relative_rec, all, except orig_dotid, orig_powid, orig_empid, orig_proxid);

	 // slim the layout for joining to gong key.
	 ds_trim_phone := project(ds_slim_relative, transform({unsigned6 ultid; unsigned6 orgid;
	                                 unsigned6 seleid; unsigned6 proxid; unsigned6 powid; unsigned6 empid;
																	 unsigned6 dotid;
	                                 string10 company_phone;},
																	 self.company_phone := left.phoneInfo.phone10;
																	 self.ultid := left.orig_ultid;
																	 self.orgid := left.orig_orgid;
																	 self.seleid := left.orig_seleid;
																	 self.proxid := left.orig_proxid;
																	 self.powid := left.orig_powid;
																	 self.empid := left.orig_empid;
																	 self.dotid := left.orig_dotid;
																	 )); // sets  linkids;

   ds_phone_info_raw := join(ds_trim_phone, dx_Gong.key_history_phone(),
    keyed(left.company_phone[4..10] = right.p7) and
    keyed(left.company_phone[1..3]  = right.p3),
    limit(TopBusiness_Services.Constants.defaultJoinLimit,skip));

   ds_phone_info := Suppress.MAC_SuppressSource(ds_phone_info_raw, mod_access);

	unique_phones_wgongdata_1 := dedup(ds_phone_info, all);

	unique_phones_wgongdata := rollup(
		sort(unique_phones_wgongdata_1,
			 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			 company_phone,if (current_flag, 0, 1),
			if(current_flag,listed_name,'')),
		transform(recordof(left),
			self.listing_type_gov := max(left.listing_type_gov,right.listing_type_gov),
			self.listing_type_bus := max(left.listing_type_bus,right.listing_type_bus),
			self.listing_type_res := max(left.listing_type_res,right.listing_type_res),
			self.listed_name := left.listed_name,
			self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen),
			self.dt_last_seen := max(left.dt_last_seen,right.dt_last_seen),
			self := left),
		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
		company_phone,if (current_flag, 0, 1),
		if(current_flag,listed_name,''));

		unique_phones_against_names :=
		         denormalize(unique_phones_wgongdata,ds_relative_rec,
																						 BIPV2.IDmacros.mac_JoinTop3Linkids(),
          group,
		transform({recordof(left);},
			self := left),
		LIMIT(0),
		KEEP(1000));

		unique_phones_gong_rolled := rollup(
		group(sort(unique_phones_against_names,
													#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
		              company_phone, if (current_flag, 0, 1)),
												#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
									      company_phone),
		group,
		transform({
			ds_trim_phone;
			string1 phone_type;
			string1 active_EDA;
			string1 disconnected;
			string8 from_date;
			string8 to_date;
			string120 listed_name;},
			self.disconnected := if(not exists(rows(left)(current_flag)),'Y','N'),

			self.active_EDA := if(exists(rows(left)(current_flag)),'Y','N'),
			self.from_date := min(rows(left)(current_flag),dt_first_seen),
			self.to_date := max(rows(left)(current_flag),dt_last_seen),
			self.phone_type := map(
				exists(rows(left)(current_flag and listing_type_gov != '')) => max(rows(left)(current_flag and listing_type_gov != ''),listing_type_gov),
				exists(rows(left)(current_flag and listing_type_bus != '')) => max(rows(left)(current_flag and listing_type_bus != ''),listing_type_bus),
				exists(rows(left)(current_flag and listing_type_res != '')) => max(rows(left)(current_flag and listing_type_res != ''),listing_type_res),
				''),
			self.listed_name := max(rows(left)(current_flag),listed_name),
			self := left,
			self := []));

	 ds_slim_relativePhoneInfo := join(ds_slim_relative , unique_phones_gong_rolled,
			 left.orig_ultid  = right.ultid AND
			 left.orig_orgid  = right.orgid AND
			 left.orig_seleid = right.seleid AND
			 left.phoneInfo.phone10 = right.company_phone,
								transform(recordof(ds_slim_relative),
								self.phoneInfo.phone10 := left.phoneInfo.phone10;
			 self.PhoneInfo.ListingName := right.listed_name,
			 self.PhoneType := right.phone_type,
			 self.ActiveEDA := map (right.active_eda = 'Y' => true,
			                             right.active_eda = 'N' => false,
																	 false);
			 self.Disconnected := map( right.disconnected = 'Y' => true,
			                                right.disconnected = 'N' => false,
																			false);
         self := left),
		 left outer);

    TopBusiness_Services.Macro_AppendWirelessIndicator(ds_slim_relativePhoneInfo, ds_slim_relativePhoneInfoWireless);

	// Rollup the full data by linkids
	rolledup_full_data := rollup(group(sort(ds_slim_relativePhoneInfoWireless,
	                                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
	                                              )
                                        ,#expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																				),group,
		transform({TopBusiness_Services.ParentSection_layouts.rec_tmpFinal - [acctno]},
				 self.ultid  := left.ultid;
				 self.orgid  := left.orgid;
				 self.seleid := left.seleid;
				 self.proxid := left.proxid;
				 self.powid  := left.powid;
			   self.empid  := left.empid;
			   self.dotid  := left.dotid;
				 self.orig_ultid  := left.orig_ultid;
				 self.orig_orgid  := left.orig_orgid;
				 self.orig_seleid := left.orig_seleid;
				 self.orig_proxid := left.orig_proxid;
				 self.orig_powid  := 0;
				 self.orig_empid  := 0;
				 self.orig_dotid  := 0;
				 self.Parents := choosen(dedup(project(sort(rows(left),
													stringlib.StringCleanSpaces(CompanyName),record),
				              transform(TopBusiness_Services.ParentSection_layouts.rec_relative,
											       self := left,
											       self := [])),all),
			                     iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PARENT_RECORDS);
			self.SourceDocs := choosen(left.sourceDocs,
			       in_sourceDocMaxCount);
				self := [];
	    ));
	// Join back to the acctno
	// only join by by proxid because the other id's are possibly different now because
	// of the magic that is happening behind the scenes in the kfetch call to best key
	// to fetch values for the parent information ,which is stored in rolledup_full_data now
	//
	final_data := join(ds_in_data,rolledup_full_data,

				left.ultid = right.orig_ultid AND
		    left.orgid = right.orig_orgid AND
				left.seleid = right.orig_seleid,
		transform(TopBusiness_Services.ParentSection_layouts.rec_final,
				self.acctno := left.acctno;
			  self := right;
				self := [];
				), left outer);

  // output(FETCH_LEVEL, named('FETCH_LEVEL'));
	// output(ds_in_unique_ids_ForHeader, named('ds_in_unique_ids_ForHeader'));
	// output(ds_in_data, named('ds_in_data'));
	 //output(BusHeaderRecs, named('BusHeaderRecs'));
	 // output(ds_busHeaderRecs, named('ds_busHeaderRecs'));

	 //output(dsUltlinkIDInfo, named('dsUltlinkIDInfo'));
	// output(dsUltLinkIdInfoFilter, named('dsUltLinkIdInfoFilter'));
	  //output(ds_relative_rec, named('ds_relative_rec'));
	 //output(ds_slim_relativePhoneInfo, named('ds_slim_relativePhoneInfo'));
	 // output(unique_phones_gong_rolled, named('unique_phones_gong_rolled'));
	 // output(ds_slim_relative, named('ds_slim_relative'));
	 // output(ds_slim_relativePhoneInfo, named('ds_slim_relativePhoneInfo'));
	  //output(rolledup_full_data, named('rolledup_full_data'));
	// output(ds_relative_rec, named('ds_relative_rec'));
	// output(final_data, named('final_data'));

	return final_data;

end; // function
end; // module
