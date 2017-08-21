import ut, header, Strata, Orbit3SOA;

export modOrbitAdaptersForPersonHdrBld := module

	// record layout from Header.Header_Joined
	export recNoBasicMatch := record
		string2 src; // oNMNHR.src
		string30 src_desc;
		integer count_;
	end;

	// Orbit submit adapter for no basic match data set
	export fnGetNoBasicMatchAction(dataset(recNoBasicMatch) rsNoBasicMatch, string8 strBuildDate, boolean boolDebug = false) := function

		// stability of data by source as determination for the rule name to use for alerts
		setConsistencyNoBasicMatchLt100 := [
			'!W',
			'@W',
			'^W',
			'1W',
			'3W',
			'3X',
			'4W',
			'6W',
			'7W',
			'9W',
			'AE',
			'AK',
			'AM',
			'AR',
			'AV',
			'BA',
			'CD',
			'CY',
			'D$',
			'D@',
			'D2',
			'D9',
			'DA',
			'DD',
			'DE',
			'DW',
			'E7',
			'ED',
			'EL',
			'EQ',
			'EV',
			'FD',
			'FF',
			'FR',
			'GD',
			'HE',
			'L2',
			'MV',
			'MW',
			'NT',
			'NV',
			'NW',
			'OB',
			'OD',
			'QE',
			'SL',
			'TD',
			'TR',
			'TW',
			'UT',
			'UW',
			'WV',
			'XV',
			'YD',
			'YV',
			'ZT' ];
		setConsistencyNoBasicMatchLt400 := [
			'!E',
			'#E',
			'&E',
			'.E',
			'@E',
			'+E',
			'2X',
			'5W',
			'7X',
			'AY',
			'DS',
			'FE',
			'FV',
			'GE',
			'IE',
			'JE',
			'KD',
			'KV',
			'LE',
			'NE',
			'PV',
			'PW',
			'QV',
			'RE',
			'RV',
			'SD',
			'SE',
			'SV',
			'TE',
			'TV',
			'VE',
			'WP',
			'XE',
			'YE',
			'YW' ];
		setConsistencyNoBasicMatchLt2000 := [
			'#W',
			'%W',
			'?E',
			'9X',
			'AD',
			'BD',
			'BE',
			'BX',
			'CG',
			'CW',
			'D%',
			'EE',
			'EW',
			'HW',
			'IV',
			'JW',
			'KE',
			'KW',
			'LV',
			'ND',
			'OE',
			'OV',
			'PE',
			'QW',
			'SW',
			'UE',
			'VD',
			'WE',
			'WW',
			'ZE',
			'ZW' ];
		setConsistencyNoBasicMatchE := [
			'$E',
			'[W',
			'1X',
			'2W',
			'4X',
			'5X',
			'6X',
			'8X',
			'BW',
			'CE',
			'D!',
			'D0',
			'D3',
			'D7',
			'E1',
			'E2',
			'E3',
			'E4',
			'EB',
			'EM',
			'EN',
			'FA',
			'FP',
			'FW',
			'GW',
			'ID',
			'IW',
			'LA',
			'LP',
			'LW',
			'MD',
			'ME',
			'OW',
			'PD',
			'PL',
			'RW',
			'VO',
			'VW',
			'WD',
			'XW',
			'XX',
			'ZK',
			'ZX' ];
		fnNoBasicMatchConsistency(string2 src) := 
				if (src in setConsistencyNoBasicMatchLt100, 'lt100',
				if (src in setConsistencyNoBasicMatchLt400, 'lt400',
				if (src in setConsistencyNoBasicMatchLt2000, 'lt2000',
				if (src in setConsistencyNoBasicMatchE, 'erratic',
				'lt2000'))));

		// project a transform to assemble data in a record layout expected by profile, including rule name
		recNoBasicMatchPlusCat := record
			string2 source;
			string30 source_desc;
			integer count_;
			string7 rule_name;
		end;
		recNoBasicMatchPlusCat addNoBasicMatchConsistencyCategory(recNoBasicMatch L) := transform
				self.rule_name := fnNoBasicMatchConsistency(L.src);
				self.source := L.src;
				self.source_desc := L.src_desc;
				self := L;
		end;
		rsNoBasicMatchPlusCat := project(rsNoBasicMatch, addNoBasicMatchConsistencyCategory(left));

		// use the Orbit submission function to make the appropriate SOAP call
		string profileTemplateNoBasicMatch := 'StrataNoPopulation';
		string profileNameNoBasicMatch := 'PersonHeader_NoBasicMatchV01_Population_View';
		string fileTypeNoBasicMatch := '_' + profileNameNoBasicMatch;
		return if(boolDebug,
			parallel(
				output(rsNoBasicMatch, named('rsNoBasicMatch' + strBuildDate)),
				output(rsNoBasicMatchPlusCat, named('rsNoBasicMatchPlusCat' + strBuildDate))),
			Orbit3SOA.SubmitStat(rsNoBasicMatchPlusCat, profileNameNoBasicMatch, profileTemplateNoBasicMatch, strBuildDate, fileTypeNoBasicMatch));

	end;



	// record layout from Header.fn_new_dids_by_src.r1
	export recNewDids := record
		string2 src;
		integer count_;
	end;

	// Orbit submit adapter for new did data set
	export fnGetNewDidsAction(dataset(recNewDids) rsNewDids, string8 strBuildDate, boolean boolDebug = false) := function

		// stability of data by source as determination for the rule name to use for alerts
		// the rules names were constructed in Excel as follows
			// AT4=ROUND(3*QUARTILE(B4:AO4,3),0)
			// AV4=ROUND(QUARTILE(B4:AO4,1)/3,0)
			// AW4=IF(IF(AT4=0,AS4/2,AT4)>=AZ4,1,-1)*POWER(10,CEILING(LOG10(ABS(100*(IF(AT4=0,AS4/2,AT4)-AZ4)/AZ4)),1))
			// AX4=IFERROR(-POWER(10,FLOOR(LOG10(ABS(100*(AV4-AZ4)/AZ4)),1)),0)
			// ruleName=CONCATENATE(IF(AX4=0,"z",CONCATENATE("e",LOG10(-AX4))),IF(AW4<0,"toEn","toE"),LOG10(ABS(AW4)))
		// this function was generated using the following Cygwin command:
			// gen.consistency.sets.sh raw.categories.new.dids.by.src.201501.txt NewDids e1toE3
		setConsistencyNewDidsE1toE2 := [
			'AE',
			'CE',
			'EV',
			'FW',
			'LV',
			'MV',
			'WV',
			'YD' ];
		setConsistencyNewDidsE1toE3 := [
			'!E',
			'#E',
			'&E',
			'.E',
			'?E',
			'@E',
			'+E',
			'AD',
			'AM',
			'AR',
			'BA',
			'BD',
			'BW',
			'CD',
			'CY',
			'D%',
			'DA',
			'DD',
			'DE',
			'DS',
			'DU',
			'EE',
			'EN',
			'EQ',
			'FA',
			'FD',
			'FP',
			'FR',
			'FV',
			'GD',
			'GE',
			'HE',
			'IE',
			'KE',
			'L2',
			'LA',
			'LE',
			'LP',
			'ME',
			'ND',
			'NE',
			'NT',
			'OD',
			'OV',
			'PE',
			'PL',
			'RE',
			'SD',
			'SL',
			'TD',
			'TE',
			'UT',
			'UW',
			'VE',
			'VO',
			'WD',
			'WE',
			'WP',
			'XE',
			'YE',
			'YV',
			'ZE',
			'ZT' ];
		setConsistencyNewDidsE1toEn1 := [
			'NV' ];
		setConsistencyNewDidsE1toEn2 := [
			'1X',
			'ID',
			'IV',
			'JE',
			'KV',
			'QE',
			'QV',
			'RV',
			'SE',
			'SV',
			'TV' ];
		setConsistencyNewDidsE2toE1 := [
			'3X',
			'CW' ];
		setConsistencyNewDidsE2toE2 := [
			'1W',
			'3W',
			'5W',
			'DW',
			'EM',
			'EW',
			'FF',
			'JW',
			'KW',
			'PW',
			'SW',
			'TR',
			'XW' ];
		setConsistencyNewDidsE2toE3 := [
			'#W',
			'[W',
			'^W',
			'6W',
			'8F',
			'AV',
			'CG',
			'D%',
			'D2',
			'E1',
			'E2',
			'FE',
			'GW',
			'HW',
			'IW',
			'LW',
			'OW',
			'RW',
			'TW',
			'VW',
			'WW',
			'ZW' ];
		setConsistencyNewDidsE2toE4 := [
			'2X',
			'6X',
			'BX',
			'D!',
			'D3',
			'E7',
			'ED',
			'FB',
			'LI',
			'MW',
			'OB',
			'XV',
			'ZX' ];
		setConsistencyNewDidsE2toEn1 := [
			'@W' ];
		setConsistencyNewDidsE2toEn2 := [
			'!W',
			'$E',
			'%W',
			'2W',
			'4W',
			'4X',
			'5X',
			'7W',
			'7X',
			'8X',
			'9W',
			'9X',
			'AK',
			'AY',
			'BE',
			'D@',
			'D0',
			'D7',
			'D9',
			'E3',
			'E4',
			'EB',
			'EL',
			'KD',
			'MD',
			'NW',
			'OE',
			'PD',
			'PV',
			'QW',
			'UE',
			'VD',
			'XX',
			'YW',
			'ZK' ];
		fnNewDidsConsistency(string2 src) := 
				if (src in setConsistencyNewDidsE1toE2, 'e1toE2',
				if (src in setConsistencyNewDidsE1toE3, 'e1toE3',
				if (src in setConsistencyNewDidsE1toEn1, 'e1toEn1',
				if (src in setConsistencyNewDidsE1toEn2, 'e1toEn2',
				if (src in setConsistencyNewDidsE2toE1, 'e2toE1',
				if (src in setConsistencyNewDidsE2toE2, 'e2toE2',
				if (src in setConsistencyNewDidsE2toE3, 'e2toE3',
				if (src in setConsistencyNewDidsE2toE4, 'e2toE4',
				if (src in setConsistencyNewDidsE2toEn1, 'e2toEn1',
				if (src in setConsistencyNewDidsE2toEn2, 'e2toEn2',
				'e1toE3'))))))))));

		// project a transform to assemble data in a record layout expected by profile, including rule name
		recNewDidsPlusCat := record
			string2 source;
			string20 source_desc;
			integer count_;
			string7 rule_name;
		end;
		recNewDidsPlusCat addNewDidsConsistencyCategory(recNewDids L) := transform
				self.rule_name := fnNewDidsConsistency(L.src);
				self.source := L.src;
				self.source_desc := header.translateSource(L.src);
				self := L;
		end;
		rsNewDidsPlusCat := project(rsNewDids, addNewDidsConsistencyCategory(left));

		// use the Orbit submission function to make the appropriate SOAP call
		string profileTemplateNewDids := 'StrataNoPopulation';
		string profileNameNewDids := 'PersonHeader_NewDidsV01_Population_View';
		string fileTypeNewDids := '_' + profileNameNewDids;
		return if(boolDebug,
			parallel(
				output(rsNewDids, named('rsNewDids' + strBuildDate)),
				output(rsNewDidsPlusCat, named('rsNewDidsPlusCat' + strBuildDate))),
			Orbit3SOA.SubmitStat(rsNewDidsPlusCat, profileNameNewDids, profileTemplateNewDids, strBuildDate, fileTypeNewDids));

	end;



	// record layout from header.Proc_BuildStats.statrec
	export recTotalClean := record
		string2 src;
		string20 src_desc;
		integer counted;
		real p_integrated;
	end;

	// Orbit submit adapter for total clean records data set
	export fnGetTotalCleanRecordsAction(dataset(recTotalClean) rsTotalClean, string8 strBuildDate, boolean boolDebug = false) := function

		// stability of data by source as determination for the rule name to use for alerts
		setConsistencyTotalCleanLtp6 := [
			'^W',
			'3W',
			'8F',
			'AE',
			'AV',
			'BA',
			'CY',
			'D3',
			'DU',
			'E4',
			'E7',
			'EB',
			'ED',
			'EL',
			'FB',
			'FR',
			'IV',
			'JE',
			'LI',
			'LV',
			'MA',
			'MI',
			'MV',
			'MW',
			'NV',
			'NW',
			'OB',
			'OE',
			'PV',
			'QV',
			'RV',
			'SE',
			'SW',
			'TV',
			'TW',
			'UE',
			'XV',
			'YD',
			'YV' ];
		setConsistencyTotalCleanLt1 := [
			'+E',
			'1W',
			'4X',
			'6W',
			'7W',
			'9W',
			'AD',
			'AK',
			'AR',
			'BE',
			'CD',
			'D@',
			'DW',
			'EE',
			'EM',
			'EQ',
			'EV',
			'FD',
			'FE',
			'FV',
			'HE',
			'IE',
			'KD',
			'KE',
			'L2',
			'LE',
			'NE',
			'OD',
			'OV',
			'PE',
			'PW',
			'RE',
			'SV',
			'TD',
			'VD',
			'WD',
			'WE',
			'XE',
			'XW',
			'YW',
			'ZE',
			'ZX' ];
		setConsistencyTotalCleanLt2p6 := [
			'$E',
			'[W',
			'2W',
			'2X',
			'5W',
			'8X',
			'9X',
			'AM',
			'BD',
			'BW',
			'BX',
			'CG',
			'CW',
			'D!',
			'D9',
			'DA',
			'E1',
			'E2',
			'EW',
			'FF',
			'FW',
			'GD',
			'GE',
			'GW',
			'HW',
			'ID',
			'IW',
			'JW',
			'KV',
			'KW',
			'ND',
			'NT',
			'OW',
			'QE',
			'RW',
			'SD',
			'SL',
			'TE',
			'VE',
			'VW',
			'WP',
			'WV',
			'WW',
			'YE',
			'ZW' ];
		setConsistencyTotalCleanE := [
			'!E',
			'!W',
			'#E',
			'#W',
			'%W',
			'&E',
			'.E',
			'?E',
			'@E',
			'@W',
			'1X',
			'3X',
			'4W',
			'5X',
			'6X',
			'7X',
			'AY',
			'CE',
			'D%',
			'D0',
			'D2',
			'D7',
			'DD',
			'DE',
			'DS',
			'E3',
			'EN',
			'FA',
			'FP',
			'LA',
			'LP',
			'LW',
			'MD',
			'ME',
			'PD',
			'PL',
			'QW',
			'TR',
			'UT',
			'UW',
			'VO',
			'XX',
			'ZK',
			'ZT' ];
		fnTotalCleanConsistency(string2 src) := 
				if (src in setConsistencyTotalCleanLtp6, 'lt0p6',
				if (src in setConsistencyTotalCleanLt1, 'lt1p0',
				if (src in setConsistencyTotalCleanLt2p6, 'lt2p6',
				if (src in setConsistencyTotalCleanE, 'erratic',
				'lt1'))));

		// project a transform to assemble data in a record layout expected by profile, including rule name
		recTotalCleanPlusCat := record
			string2 source;
			string30 source_desc;
			integer count_;
			string7 rule_name;
		end;
		recTotalCleanPlusCat addTotalCleanConsistencyCategory(recTotalClean L) := transform
				self.rule_name := fnTotalCleanConsistency(L.src);
				self.source := L.src;
				self.source_desc := L.src_desc;
				self.count_ := L.counted;
		end;
		rsTotalCleanPlusCat := project(rsTotalClean, addTotalCleanConsistencyCategory(left));

		// use the Orbit submission function to make the appropriate SOAP call
		string profileTemplateTotalClean := 'StrataNoPopulation';
		string profileNameTotalClean := 'PersonHeader_TotalCleanV01_Population_View';
		string fileTypeTotalClean := '_' + profileNameTotalClean;
		return if(boolDebug,
			parallel(
				output(rsTotalClean, named('rsTotalClean' + strBuildDate)),
				output(rsTotalCleanPlusCat, named('rsTotalCleanPlusCat' + strBuildDate))),
			Orbit3SOA.SubmitStat(rsTotalCleanPlusCat, profileNameTotalClean, profileTemplateTotalClean, strBuildDate, fileTypeTotalClean));

	end;



	// Orbit submit adapter for total clean records data set
	export fnGetCrossSourceAction(dataset(ut.layout_stats_extend) rsCrossSource, string8 strBuildDate, boolean boolDebug = false) := function

		// stability of data by source as determination for the rule name to use for alerts
		setConsistencyCrossSourceLtp02 := [
			'Build Stats: MaxRID',
			'Build Stats: Total Header Recs',
			'DID Stats: Good Rate',
			'DID Stats: RID less than DID',
			'Field Count: jflag1 = B pct',
			'Field Count: jflag1 = C',
			'Field Count: jflag1 = C pct',
			'Field Count: jflag1 = pct',
			'Field Count: jflag1 = T',
			'Field Count: jflag2 =',
			'Field Count: jflag2 = pct',
			'Field Count: jflag3 = ',
			'Field Count: jflag3 = C ',
			'Field Count: jflag3 = C pct ',
			'Field Count: jflag3 = pct ',
			'Field Count: pflag2 =',
			'Field Count: pflag2 = ?',
			'Field Count: pflag2 = E',
			'Field Count: pflag2 = N',
			'Field Count: pflag2 = N pct',
			'Field Count: pflag2 = pct',
			'Field Count: pflag2 = R',
			'Field Count: pflag2 = R pct',
			'Field Count: pflag3 =',
			'Field Count: pflag3 = G',
			'Field Count: pflag3 = G pct',
			'Field Count: pflag3 = pct',
			'Field Count: pflag3 = U',
			'Field Count: pflag3 = W',
			'Field Count: tnt = N',
			'Field Count: tnt = N pct',
			'Field Count: tnt = P pct',
			'Field Count: tnt = Y pct',
			'Field Count: valid_ssn = G',
			'Field Count: valid_ssn = G pct',
			'Field Count: valid_ssn = pct',
			'Field Count: DEAD',
			'Total RIDs' ];
		setConsistencyCrossSourceErratic := [
			'Build Stats: Header Inc Rate',
			'Build Stats: New Header Recs',
			'DID Stats: Appear Rate',
			'DID Stats: Appearing DIDs',
			'DID Stats: Disappear Rate',
			'DID Stats: Disappearing DIDs',
			'DID Stats: matching RID in other DID',
			'Field Count: jflag1 = B',
			'Field Count: jflag2 = A',
			'Field Count: jflag2 = A pct',
			'Field Count: jflag2 = C',
			'Field Count: jflag2 = C pct',
			'Field Count: jflag2 = D',
			'Field Count: jflag2 = D pct',
			'Field Count: pflag1 = A',
			'Field Count: pflag1 = A pct',
			'Field Count: valid_ssn = B pct',
			'Field Count: valid_ssn = O',
			'Field Count: valid_ssn = O pct',
			'Field Count: valid_ssn = R pct',
			'Field Count: valid_ssn = U',
			'Field Count: valid_ssn = U pct',
			'Field Count: valid_ssn = Z',
			'Field Count: valid_ssn = Z pct',
			'Field Count: AMBIG',
			'Field Count: INACTIVE',
			'Field Count: SUSPECT' ];
		setConsistencyCrossSourceLtp05 := [
			'DID Stats: unique_new_DIDs_nojflag2_living_multrecs',
			'Field Count: jflag1 =',
			'Field Count: jflag1 = L',
			'Field Count: jflag1 = L pct',
			'Field Count: jflag1 = T pct',
			'Field Count: jflag1 = U',
			'Field Count: pflag2 = ? pct',
			'Field Count: pflag3 = X',
			'Field Count: tnt = D',
			'Field Count: tnt = D pct',
			'Field Count: tnt = P',
			'Field Count: tnt = Y',
			'Field Count: valid_ssn =',
			'Field Count: valid_ssn = F',
			'Field Count: valid_ssn = F pct',
			'Field Count: CORE',
			'Field Count: H_MERGE' ];
		setConsistencyCrossSourceLtp2 := [
			'DID Stats: Good matches',
			'DID Stats: new_DID_equals_RID',
			'DID Stats: No Change',
			'DID Stats: old_DID_equals_RID',
			'DID Stats: unique_new_DIDs',
			'DID Stats: unique_new_DIDs_nojflag2',
			'DID Stats: unique_new_DIDs_nojflag2_living',
			'DID Stats: unique_old_DIDs',
			'Field Count: jflag1 = I',
			'Field Count: jflag1 = U pct',
			'Field Count: jflag2 = B',
			'Field Count: jflag2 = B pct',
			'Field Count: pflag1 =',
			'Field Count: pflag1 = +',
			'Field Count: pflag1 = + pct',
			'Field Count: pflag1 = pct',
			'Field Count: pflag2 = A',
			'Field Count: pflag2 = A pct',
			'Field Count: valid_ssn = B',
			'Field Count: valid_ssn = R',
			'Field Count: C_MERGE',
			'Field Count: CORENOVSSN',
			'Field Count: NO_SSN',
			'Field Count: NOISE',
			'non-Singletons',
			'Average RIDs in non-Singleton Cluster' ];
		fnCrossSourceConsistency(string150 name) := 
				if (name in setConsistencyCrossSourceLtp02, 'ltp02',
				if (name in setConsistencyCrossSourceErratic, 'erratic',
				if (name in setConsistencyCrossSourceLtp02, 'ltp02',
				if (name in setConsistencyCrossSourceLtp05, 'ltp05',
				if (name in setConsistencyCrossSourceLtp2, 'ltp2',
				'ltp05')))));

		// project a transform to assemble data in a record layout expected by profile, including rule name
		recCrossSourcePlusCat := record
			string150 name;
			real8 value_;
			string7 rule_name;
		end;
		recCrossSourcePlusCat addCrossSourceConsistencyCategory(recordof(rsCrossSource) L) := transform
				self.rule_name := fnCrossSourceConsistency(L.name);
				self.value_ := L.value;
				self := L;
		end;
		rsCrossSourcePlusCat := project(rsCrossSource, addCrossSourceConsistencyCategory(left));

		// use the Orbit submission function to make the appropriate SOAP call
		string profileTemplateCrossSource := 'StrataNoPopulation';
		string profileNameCrossSource := 'PersonHeader_CrossSourceV01_Population_View';
		string fileTypeCrossSource := '_' + profileNameCrossSource;
		return if(boolDebug,
			output(rsCrossSourcePlusCat, named('rsCrossSourcePlusCat' + strBuildDate)),
			Orbit3SOA.SubmitStat(rsCrossSourcePlusCat, profileNameCrossSource, profileTemplateCrossSource, strBuildDate, fileTypeCrossSource));

	end;

end;