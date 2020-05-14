IMPORT Doxie, topBusiness_services, iesp, AutoStandardI, ut;
IMPORT $;

EXPORT SourceCount(
		dataset( TopBusiness_Services.Layouts.rec_input_ids) ds_tmpinput_data,
		TopBusiness_Services.SourceCount_Layouts.OptionsLayout in_options,
		AutoStandardI.DataRestrictionI.params in_mod
		) := FUNCTION

    mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
      EXPORT application_type := in_options.app_type;
      EXPORT ssn_mask := in_options.ssn_mask;
      EXPORT DataRestrictionMask := in_mod.DataRestrictionMask;
      EXPORT DataPermissionMask := '' : STORED('DataPermissionMask');
      EXPORT dppa := in_mod.DPPAPurpose;
      EXPORT glb := in_mod.GLBPurpose;
      EXPORT show_minors := in_mod.IncludeMinors;
    END;

		sourcelinkids := PROJECT(ds_tmpinput_data,TRANSFORM(Layouts.rec_input_ids_wSrc,
																												SELF := LEFT,
																												SELF := []));
		sourceOptions := PROJECT(in_options,TRANSFORM(SourceService_Layouts.OptionsLayout, SELF := LEFT));

		bus_recs := $.BusHeadSource_Records(sourcelinkids, sourceOptions, mod_access, false).SourceDetailInfo;
		bank_recs := $.BankruptcySource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeBankruptcies);
		corp_recs := $.CorporationSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeIncorporation);
		ucc_recs := $.UCCSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeUCCFilings);
		lien_recs := $.LienSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeLiensJudgments);
		prop_recs := $.PropertySource_Records(sourcelinkids,sourceOptions,,false).SourceDetailInfo(in_options.IncludeProperties);
		nod_recs := $.ForeclosureNodSource_Records(sourcelinkids,sourceOptions,false,true).SourceDetailInfo(in_options.IncludeProperties);
		fore_recs := $.ForeclosureNodSource_Records(sourcelinkids,sourceOptions,false,false).SourceDetailInfo(in_options.IncludeProperties);
		proflic_recs := $.ProfLicenseSource_Records(sourcelinkids, sourceOptions, mod_access, false).SourceDetailInfo(in_options.IncludeProfessionalLicenses);
		mvr_recs := $.MotorVehicleSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeMotorVehicles);
		watercraft_recs := $.WatercraftSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeWatercrafts);
		aircraft_recs := $.AircraftSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeAircrafts);
		ebr_recs := $.EBRSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeExperianBusinessReports);
		irs5500_recs := $.IRS5500Source_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeIRS5500);
		dnb_recs := $.DNBDmiSource_Records(sourcelinkids,sourceOptions, mod_access, false).SourceDetailInfo(in_options.IncludeDunBradStreet);
		msworks_recs := $.MSWorkSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeWorkersComp);
		orworks_recs := $.ORWorkSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeWorkersComp);
		bbb_recs := $.BBBSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeBetterBusinessBureau);
		bbbnm_recs := $.BBBNonMemSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeBetterBusinessBureau);
		catax_recs := $.CASalesTaxSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeSalesTax);
		iatax_recs := $.IASalesTaxSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeSalesTax);
		irs990_recs := $.IRS990Source_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeIRS990);
		fdic_recs := $.FDICSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeFDIC);
		sanc_recs := $.SanctionSource_Records(sourcelinkids,sourceOptions,false).SourceDetailInfo(in_options.IncludeSanctions);

		DATASET(SourceCount_Layouts.SummaryLayout) roll_Summary(DATASET(SourceCount_Layouts.SourceDetailsLayout) ds_in) := function

			EXPORT cat_code := MODULE
				EXPORT name		:= 'NAME';
				EXPORT ssn		:= 'SSN';
				EXPORT dob		:= 'DOB';
				EXPORT fein		:= 'FEIN';
				EXPORT addr		:= 'ADDR';
				EXPORT phone	:= 'PHONE';
			END;
			EXPORT max_cat := 6;

			// produce separate records for each data type
			l_tmp := RECORD(SourceCount_Layouts.SourceDetailLayout)
				string50	src_desc;
				string5		cat_type;
			end;
			l_tmp toTmp(SourceCount_Layouts.SourceDetailsLayout L, integer C) := TRANSFORM
				SELF.cat_type := choose(C,
					if (L.hasName,	cat_code.name,	skip),
					if (L.hasSSN,		cat_code.ssn,		skip),
					if (L.hasDOB,		cat_code.dob,		skip),
					if (L.hasFEIN,	cat_code.fein,	skip),
					if (L.hasAddr,	cat_code.addr,	skip),
					if (L.hasPhone,	cat_code.phone,	skip),
					skip
				);
				SELF.occurrences := 1;
				SELF := L;
			END;
			tmp := normalize(ds_in, max_cat, toTmp(left, counter));

			// rollup by src/cat, counting occurrences as we go
			l_tmp toCnt(l_tmp L, l_tmp R) := TRANSFORM
				SELF.occurrences		:= L.occurrences + R.occurrences;
				SELF.dt_first_seen	:= ut.min2(L.dt_first_seen, R.dt_first_seen);
				SELF.dt_last_seen		:= Max(L.dt_last_seen, R.dt_last_seen);
				SELF := L;
			END;
			cnt := rollup(sort(tmp, cat_type, src), toCnt(LEFT,RIGHT), cat_type, src);

			// merge occurrences by cat/src_desc
			l_tmp toMerged(l_tmp L, l_tmp R) := TRANSFORM
				SELF.occurrences		:= L.occurrences + R.occurrences;
				SELF.dt_first_seen	:= ut.min2(L.dt_first_seen, R.dt_first_seen);
				SELF.dt_last_seen		:= Max(L.dt_last_seen, R.dt_last_seen);
				SELF := L;
			END;
			cnt_s		:= sort(cnt, cat_type, src_desc, -occurrences, src, RECORD);
			merged	:= rollup(cnt_s, toMerged(LEFT,RIGHT), cat_type, src_desc);

			// rollup by category(cat) to show occurrences in a child dataset
			SourceCount_Layouts.SummaryLayout toOut(l_tmp L, dataset(l_tmp) R) := TRANSFORM
				SELF.cat_type			:= L.cat_type;
				SELF.num_sources	:= count(R);
				all_sources				:= project(choosen(R, iesp.Constants.TOPBUSINESS.MAX_COUNT_SOURCE_SOURCES),
																								TRANSFORM(SourceCount_Layouts.SourceDetailLayout,
																													SELF.src:=LEFT.src_desc,SELF:=LEFT)); // the choosen is just insurance
				SELF.sources			:= sort(all_sources, -dt_last_seen, dt_first_seen, src, RECORD);
			END;
			grp := group(sort(merged, cat_type, src, RECORD), cat_type);
			results := rollup(grp, group, toOut(LEFT, rows(LEFT)));

			// output(ds_in,		named('ds_in'));		// DEBUG
			// output(tmp,			named('tmp'));			// DEBUG
			// output(cnt,			named('cnt'));			// DEBUG
			// output(merged, 	named('merged'));		// DEBUG

			RETURN results;

		END; // roll_Summary()

		summaryResults := roll_Summary(bank_recs+corp_recs+ucc_recs+lien_recs+prop_recs+
																	nod_recs+fore_recs+proflic_recs+mvr_recs+watercraft_recs+
																	aircraft_recs+ebr_recs
																	+irs5500_recs+irs990_recs+fdic_recs+
																	msworks_recs+orworks_recs+bbb_recs+bbbnm_recs+catax_recs+
																	iatax_recs+dnb_recs+bus_recs+sanc_recs);

		iesp.TopBusinessSourceCount.t_TopBusinessSourceRecord xfm_sources(SourceCount_Layouts.SourceDetailLayout L) := TRANSFORM
				SELF.SourceName := L.src;
				SELF.OccurancesCount := L.occurrences;
				SELF.DateFirstSeen := iesp.ECL2ESP.toDate(L.dt_first_seen);
				SELF.DateLastSeen := iesp.ECL2ESP.toDate(L.dt_last_seen);
				SELF := [];
		END;

		iesp.TopBusinessSourceCount.t_TopBusinessCategoryRecord xfm_summary(SourceCount_Layouts.SummaryLayout L) := TRANSFORM
				SELF.CategoryName := L.cat_type;
				SELF.SourcesCount := L.num_sources;
				SELF.Sources := PROJECT(L.sources,xfm_sources(LEFT));
				SELF := [];
		END;

		iesp.TopBusinessSourceCount.t_TopBusinessSourceCountResponse format_iesp() := TRANSFORM
			SELF._Header := iesp.ECL2ESP.GetHeaderRow();
			SELF.BusinessIds.UltID  := sourcelinkids[1].UltId;
      SELF.BusinessIds.OrgID  := sourcelinkids[1].OrgID;
			SELF.BusinessIds.SELEID := sourcelinkids[1].SELEID;
			SELF.BusinessIds.ProxID := sourcelinkids[1].ProxID;
			SELF.BusinessIds.PowID  := sourcelinkids[1].PowID;
			SELF.BusinessIds.EmpID  := sourcelinkids[1].EmpID;
			SELF.BusinessIds.DotID  := sourcelinkids[1].DotID;
			SELF.Records := PROJECT(summaryResults,xfm_summary(LEFT));
    END;

		iesp_results := dataset([format_iesp()]);
		// output(ds_tmpinput_data,named('ds_tmpinput_data'));
		// output(sourcelinkids,named('sourcelinkids'));
		// output(bank_recs,named('bank_recs'));
		// output(corp_recs,named('corp_recs'));
		// output(ucc_recs,named('ucc_recs'));
		// output(lien_recs,named('lien_recs'));
		// output(prop_recs,named('prop_recs'));
		// output(nod_recs,named('nod_recs'));
		// output(fore_recs,named('fore_recs'));
		// output(proflic_recs,named('proflic_recs'));
		// output(mvr_recs,named('mvr_recs'));
		// output(watercraft_recs,named('watercraft_recs'));
		// output(aircraft_recs,named('aircraft_recs'));
		// output(ebr_recs,named('ebr_recs'));
		// output(irs5500_recs,named('irs5500_recs'));
		// output(irs990_recs,named('irs990_recs'));
		// output(fdic_recs,named('fdic_recs'));
		// output(msworks_recs,named('msworks_recs'));
		// output(orworks_recs,named('orworks_recs'));
		// output(bbb_recs,named('bbb_recs'));
		// output(bbbnm_recs,named('bbbnm_recs'));
		// output(catax_recs,named('catax_recs'));
		// output(iatax_recs,named('iatax_recs'));
		// output(dnb_recs,named('dnb_recs'));
		// output(bus_recs,named('bus_recs'));
		// output(sanc_recs,named('sanc_recs'));
		// output(summaryResults,named('summaryResults'));
		// output(iesp_results,named('iesp_results'));
		return(iesp_results);
end;