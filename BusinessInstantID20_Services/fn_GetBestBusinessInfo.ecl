IMPORT Address, BIPV2, BIPV2_Best, BIPV2_Best_SBFE, Business_Risk_BIP, Codes, STD;

	// The following function determines the Best information for a particular Business. 
	EXPORT fn_GetBestBusinessInfo( DATASET(BIPV2.IDlayouts.l_xlink_ids2) ds_BIPIDs,
	                               BusinessInstantID20_Services.iOptions Options,
														     BIPV2.mod_sources.iParams linkingOptions ) := 
		FUNCTION
			UCase := STD.Str.ToUpperCase;
			
			// 1.  Get LN Best Info
			ds_BestInformationRaw := BIPV2_Best.Key_LinkIds.kFetch2(inputs := ds_BIPIDs, 
			                                                     Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
			                                                     ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
			                                                     in_mod := linkingOptions,
																													 IncludeStatus := TRUE,
			                                                     JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
			                                                     JoinType := Options.KeepLargeBusinesses);

			// NOTE: this filter (proxid = 0) is only correct if we're doing a SELEID based level fetch
			// --which is the default FETCH LEVEL set at upper most roxie service level. The dataset
			// ds_BestInformationRaw actually contains Best records for every SeleID/ProxID variation.
			ds_BestInformationRawFilt := ds_BestInformationRaw(proxid = 0);	
			
			BusinessInstantID20_Services.layouts.BestInfoLayout xfm_SelectBestInformation( RECORDOF(ds_BestInformationRaw) le ) := TRANSFORM
				bestCompanyName     := le.Company_Name[1];
				bestCompanyAddress  := le.Company_Address[1];
				bestSICCode         := le.sic_code[1].company_sic_code1[1..4];
				bestNAICSCode       := le.naics_code[1].company_naics_code1[1..6];

				SELF.Seq                  := le.uniqueid;
				SELF.isactive             := le.isactive;
				SELF.isdefunct            := le.isdefunct;
				SELF.dt_first_seen        := bestCompanyName.dt_first_seen;
				SELF.dt_last_seen         := bestCompanyName.dt_last_seen;
				SELF.best_bus_name        := bestCompanyName.Company_Name;
				SELF.best_bus_prim_range  := bestCompanyAddress.Company_Prim_Range;
				SELF.best_bus_predir      := bestCompanyAddress.Company_Predir;
				SELF.best_bus_prim_name   := bestCompanyAddress.Company_Prim_Name;
				SELF.best_bus_addr_suffix := bestCompanyAddress.Company_Addr_Suffix;
				SELF.best_bus_postdir     := bestCompanyAddress.Company_Postdir;
				SELF.best_bus_unit_desig  := bestCompanyAddress.Company_Unit_Desig;
				SELF.best_bus_sec_range   := bestCompanyAddress.Company_Sec_Range;			
				SELF.best_bus_addr        := Address.Addr1FromComponents(bestCompanyAddress.Company_Prim_Range, bestCompanyAddress.Company_Predir, bestCompanyAddress.Company_Prim_Name, bestCompanyAddress.Company_Addr_Suffix, bestCompanyAddress.Company_Postdir, bestCompanyAddress.Company_Unit_Desig, bestCompanyAddress.Company_Sec_Range);
				SELF.best_bus_city        := IF( bestCompanyAddress.company_p_city_name != '', bestCompanyAddress.company_p_city_name, bestCompanyAddress.address_v_city_name );
				SELF.best_bus_state       := bestCompanyAddress.company_st;
				SELF.best_bus_zip         := bestCompanyAddress.company_zip5;
				SELF.best_bus_zip4        := bestCompanyAddress.company_zip4;
				SELF.best_bus_county      := bestCompanyAddress.county_name;
				SELF.best_bus_phone       := le.Company_Phone[1].Company_Phone;
				SELF.best_bus_fein        := le.Company_FEIN[1].Company_FEIN;
				SELF.best_sic_code        := bestSICCode;
				SELF.best_sic_desc        := UCase( Codes.Key_SIC4(KEYED(SIC4_Code = bestSICCode))[1].sic4_description );
				SELF.best_naics_code      := bestNAICSCode;
				SELF.best_naics_desc      := UCase( Codes.Key_NAICS(KEYED(naics_code = bestNAICSCode))[1].naics_description );
				SELF := [];
			END;
			
			ds_bestBusinessInfo := PROJECT( ds_BestInformationRawFilt, xfm_SelectBestInformation(LEFT) );
			
			// 2.  Get SBFE Best info
			ds_BestSBFERaw := BIPV2_Best_SBFE.Key_LinkIds().kFetch2(inputs := ds_BIPIDs, 
			                                                    Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel), 
																													ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
																													DataPermissionMask := Options.DataPermissionMask,
																													JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
																													JoinType := Options.KeepLargeBusinesses);

			ds_BestSBFERawFilt := ds_BestSBFERaw(proxid = 0);	
			
			BusinessInstantID20_Services.layouts.BestInfoLayout xfm_SelectSBFEBestInformation( RECORDOF(ds_BestSBFERaw) le ) := TRANSFORM
				bestCompanyName     := le.Company_Name[1];
				bestCompanyAddress  := le.Company_Address[1];
				bestSICCode         := le.sic_code[1].company_sic_code1[1..4];
				bestNAICSCode       := le.naics_code[1].company_naics_code1[1..6];
				
				SELF.Seq                  := le.uniqueid;
				SELF.isactive             := le.isactive;
				SELF.isdefunct            := le.isdefunct;
				SELF.dt_first_seen        := bestCompanyName.dt_first_seen;
				SELF.dt_last_seen         := bestCompanyName.dt_last_seen;
				SELF.best_bus_name        := bestCompanyName.Company_Name;
				SELF.best_bus_prim_range  := bestCompanyAddress.Company_Prim_Range;
				SELF.best_bus_predir      := bestCompanyAddress.Company_Predir;
				SELF.best_bus_prim_name   := bestCompanyAddress.Company_Prim_Name;
				SELF.best_bus_addr_suffix := bestCompanyAddress.Company_Addr_Suffix;
				SELF.best_bus_postdir     := bestCompanyAddress.Company_Postdir;
				SELF.best_bus_unit_desig  := bestCompanyAddress.Company_Unit_Desig;
				SELF.best_bus_sec_range   := bestCompanyAddress.Company_Sec_Range;			
				SELF.best_bus_addr        := Address.Addr1FromComponents(bestCompanyAddress.Company_Prim_Range, bestCompanyAddress.Company_Predir, bestCompanyAddress.Company_Prim_Name, bestCompanyAddress.Company_Addr_Suffix, bestCompanyAddress.Company_Postdir, bestCompanyAddress.Company_Unit_Desig, bestCompanyAddress.Company_Sec_Range);
				SELF.best_bus_city        := IF( bestCompanyAddress.company_p_city_name != '', bestCompanyAddress.company_p_city_name, bestCompanyAddress.address_v_city_name );
				SELF.best_bus_state       := bestCompanyAddress.company_st;
				SELF.best_bus_zip         := bestCompanyAddress.company_zip5;
				SELF.best_bus_zip4        := bestCompanyAddress.company_zip4;
				SELF.best_bus_county      := bestCompanyAddress.county_name;
				SELF.best_bus_phone       := le.Company_Phone[1].Company_Phone;
				SELF.best_bus_fein        := le.Company_FEIN[1].Company_FEIN;
				SELF.best_sic_code        := bestSICCode;
				SELF.best_sic_desc        := UCase( Codes.Key_SIC4(KEYED(SIC4_Code = bestSICCode))[1].sic4_description );
				SELF.best_naics_code      := bestNAICSCode;
				SELF.best_naics_desc      := UCase( Codes.Key_NAICS(KEYED(naics_code = bestNAICSCode))[1].naics_description );
				SELF := [];
			END;
			
			ds_bestSBFEInfo := PROJECT( ds_BestSBFERawFilt, xfm_SelectSBFEBestInformation(LEFT) );			

			ds_SBFE_records_needed :=
				JOIN(
					ds_bestBusinessInfo, ds_bestSBFEInfo(Options.useSBFE),
					LEFT.seq = RIGHT.seq,
					TRANSFORM(RIGHT),
					RIGHT ONLY
				);
			
			ds_best_records := SORT( (ds_bestBusinessInfo + ds_SBFE_records_needed), seq );
			
			// DEBUGs:
			// OUTPUT( ds_BestInformationRaw, NAMED('BestInformationRaw') );
			// OUTPUT( ds_BestInformationRawFilt, NAMED('BestInformationRawFilt') );
			// OUTPUT( ds_BestSBFERawFilt, NAMED('bestrecs_sbfe') );
			// OUTPUT( ds_bestSBFEInfo, NAMED('bestSBFEInfo') );
			// OUTPUT( ds_SBFE_records_needed, NAMED('ds_SBFE_records_needed') );
			
			RETURN ds_best_records;
		END;