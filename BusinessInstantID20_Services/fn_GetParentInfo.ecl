IMPORT Address, BIPV2, BIPV2_Best, Business_Risk, Business_Risk_BIP, BusinessCredit_Services, Census_data, 
       Corp2, DCAV2, DID_Add, EBR, Gateway, MDR, Risk_Indicators, RiskWise, ut, BusinessInstantID20_Services;

		EXPORT fn_getParentInfo( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput,
	                           DATASET(BusinessInstantID20_Services.layouts.BusinessHeaderSlim) ds_BusinessHeader,
														 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
														 BIPV2.mod_sources.iParams linkingOptions) :=
			FUNCTION
				ds_BusinessHeaderFilt := ds_BusinessHeader(uniqueid != 0 AND ParentAboveSELE = TRUE);

				ds_BusinessHeaderDeduped := 
					DEDUP( 
						SORT(
							UNGROUP(ds_BusinessHeaderFilt), 
							uniqueid, ultid, orgid, seleid, parent_proxid
						),
						uniqueid, ultid, orgid, seleid, parent_proxid
					);

				// Get Parent and Ultimate Parent (Best) info.
				ds_ForParentLookup := 
					PROJECT( 
						ds_BusinessHeaderDeduped, 
						TRANSFORM( BIPV2.IDlayouts.l_xlink_ids2, 
							SELF.seleid := LEFT.parent_proxid,      // USING ---> parent proxid
							SELF := LEFT,
							SELF := [] 
						));

				ds_ForUltParentLookup := 
				DEDUP(
					PROJECT( 
						ds_BusinessHeaderDeduped, 
						TRANSFORM( BIPV2.IDlayouts.l_xlink_ids2, 
							SELF.seleid := LEFT.ultimate_proxid, // USING ---> ultimate parent proxid
							SELF := LEFT,
							SELF := [] 
						)
					),
					uniqueid, ultid, orgid, seleid, HASH, ALL );
						
				ds_ParentInfoRaw := BIPV2_Best.Key_LinkIds.kFetch2(inputs := ds_ForParentLookup, 
			                                                     Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
			                                                     ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
			                                                     in_mod := linkingOptions,
																													 IncludeStatus := TRUE,
			                                                     JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
			                                                     JoinType := /* Options.KeepLargeBusinesses */ Business_Risk_BIP.Constants.DefaultJoinType)(proxid = 0);

				ds_UltParentInfoRaw := BIPV2_Best.Key_LinkIds.kFetch2(inputs := ds_ForUltParentLookup, 
			                                                     Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
			                                                     ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
			                                                     in_mod := linkingOptions,
																													 IncludeStatus := TRUE,
			                                                     JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
			                                                     JoinType := /* Options.KeepLargeBusinesses */ Business_Risk_BIP.Constants.DefaultJoinType)(proxid = 0);

				// Do a right-only join to see if there are any ultimate-parent records that will
				// fill in a missing parent record.
				ds_needed_ult_parent_records :=
					JOIN(
						ds_ParentInfoRaw, ds_UltParentInfoRaw,
						LEFT.uniqueid = RIGHT.uniqueid,
						TRANSFORM(RIGHT),
						RIGHT ONLY,
						INNER
					);
				
				ds_ParentInfo := 
					PROJECT(
						SORT( (ds_ParentInfoRaw + ds_needed_ult_parent_records), uniqueid ),
						TRANSFORM( BusinessInstantID20_Services.layouts.ParentLayout,
							SELF.seq           := LEFT.uniqueid,
							SELF.parent_ultid  := LEFT.ultid,
							SELF.parent_orgid  := LEFT.orgid,
							SELF.parent_seleid := LEFT.seleid,
							SELF.parent_proxid := LEFT.proxid,
							SELF.parent_powid  := LEFT.powid,
							SELF.parent_empid  := LEFT.empid,
							SELF.parent_dotid  := LEFT.dotid,
							SELF.parent_best_bus_name := LEFT.company_name[1].company_name,		
						));
				
				// OUTPUT( ds_CleanedInput, NAMED('_CleanedInput') );
				// OUTPUT( ds_BusinessHeaderFilt, NAMED('_BusinessHeaderFilt') );
				// OUTPUT( ds_BusinessHeaderDeduped, NAMED('_BusinessHeaderDeduped') );
				// OUTPUT( ds_ForParentLookup, NAMED('_ForParentLookup') );
				// OUTPUT( ds_ParentInfoRaw, NAMED('_ParentInfoRaw') );
				// OUTPUT( ds_ForUltParentLookup, NAMED('_ForUltParentLookup') );
				// OUTPUT( ds_UltParentInfoRaw, NAMED('_UltParentInfoRaw') );
				// OUTPUT( ds_needed_ult_parent_records, NAMED('_needed_ult_parent_records') );
				
				RETURN ds_ParentInfo;
			END;