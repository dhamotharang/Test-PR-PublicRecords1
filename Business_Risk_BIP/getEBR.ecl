IMPORT BIPV2, Business_Risk_BIP, EBR, Experian_CRDB, MDR, doxie, STD;

EXPORT getEBR(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

  // NOTE: this function gets records from Experian Business Records (EBR) and Credit Risk Data Base (CRDB).
	mod_access := PROJECT(Options, doxie.IDataAccess);

	link_search_level := Options.LinkSearchLevel;

	tempLayout := RECORD
		UNSIGNED4 Seq;
		INTEGER FirmAgeEstablished;
		UNSIGNED4 RecordCount;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) EmployeeSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSalesSources) SalesSources;
	END;

	// ---------------- EBR - Experian Business Records ------------------
	EBR5600Raw := EBR.Key_5600_Demographic_Data_linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																							mod_access,
																							Business_Risk_BIP.Common.SetLinkSearchLevel(link_search_level),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(EBR5600Raw, Shell, EBR5600Seq);

	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(EBR5600Seq);

	// Filter out records after our history date
	EBR5600 := Business_Risk_BIP.Common.FilterRecords(EBR5600Seq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_EBR, AllowedSourcesSet);

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	EBR5600Stats_pre_pre := TABLE(EBR5600,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 Source := MDR.SourceTools.src_EBR,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Constants.MissingDate, //no vendor date fields in EBR5600 key
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 INTEGER FirmAgeEstablished := MAX(GROUP, (INTEGER)yrs_in_bus_actual),
       // For v30 and up, need to differentiate between 0 and '' for FirmReportedSales. Set missing records to -1.
       INTEGER FirmEmployeeCount := -1,
			 INTEGER FirmReportedSales := MAX(GROUP, IF(EBR.fFix_amount_codes(Sales_Actual) = '' AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, -1,
                                          (INTEGER)EBR.fFix_amount_codes(Sales_Actual)*100)) // Because the data team botched the conversion process Sales_Actual contains characters, and rather than fix the data they created a function to translate the characters to the correct numbers
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID)
			 );

  // If running Business Shell version 31 or higher, we'll need a dataset consisting of records that exist in the past 24 months
  // to calculate FirmEmployeeCount and SalesSources.
  EBR5600_past24Months := EBR5600( (INTEGER)date_last_seen >= STD.Date.AdjustDate( HistoryDate, year_delta := -2 ) );

  // Sum of all most recent, populated employee count values among all unique data source company identifiers.
  tbl_FirmEmployeeCount_EBR5600 := TABLE(
    DEDUP(SORT(EBR5600_past24Months(empl_size_actual != ''), Seq, file_number, -date_last_seen, -(INTEGER)empl_size_actual), Seq, file_number),
    {seq, FirmEmployeeCount := SUM( GROUP, (INTEGER)empl_size_actual )},
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID) );

  EBR5600Stats_pre :=
    JOIN(
      EBR5600Stats_pre_pre, tbl_FirmEmployeeCount_EBR5600,
      LEFT.seq = RIGHT.seq,
      TRANSFORM( RECORDOF(EBR5600Stats_pre_pre),
        SELF.FirmEmployeeCount :=
						IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,
								IF( COUNT(tbl_FirmEmployeeCount_EBR5600(seq = LEFT.seq)) > 0, RIGHT.FirmEmployeeCount, -1 ),
								LEFT.FirmEmployeeCount ),
        SELF := LEFT,
        SELF := []
      ),
			LEFT OUTER, FEW
    );

  // Sum of all most recent, populated reported sales values among all unique data source company identifiers.
  tbl_SalesSources_EBR5600 := TABLE(
    DEDUP(SORT(EBR5600_past24Months(EBR.fFix_amount_codes(Sales_Actual) != ''), Seq, file_number, -date_last_seen, -(INTEGER)EBR.fFix_amount_codes(Sales_Actual)), Seq, file_number),
    {seq, FirmReportedSales := SUM( GROUP, ((INTEGER)EBR.fFix_amount_codes(Sales_Actual))*1000 )},
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID) );

  EBR5600Stats :=
    JOIN(
      EBR5600Stats_pre, tbl_SalesSources_EBR5600,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( RECORDOF(EBR5600Stats_pre_pre),
        SELF.FirmReportedSales :=
						IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,
								IF( COUNT(tbl_SalesSources_EBR5600(seq = LEFT.seq)) > 0, RIGHT.FirmReportedSales, -1 ),
								LEFT.FirmReportedSales ),
        SELF := LEFT,
        SELF := []
      ),
      LEFT OUTER, FEW
    );

	EBR5600StatsTemp :=
      PROJECT(
        EBR5600Stats,
        TRANSFORM( tempLayout,
          SELF.Seq := LEFT.Seq;
          SELF.FirmAgeEstablished := LEFT.FirmAgeEstablished;
          SELF.RecordCount := LEFT.RecordCount;
          SELF.Sources := DATASET(
            [
              {
                LEFT.Source,
                IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
                IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
                LEFT.DateLastSeen,
                LEFT.DateVendorLastSeen,
                LEFT.RecordCount
              }
            ], Business_Risk_BIP.Layouts.LayoutSources);
          SELF.EmployeeSources := DATASET(
              [
                {
                  LEFT.Source,
                  IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
                  IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
                  LEFT.DateLastSeen,
                  LEFT.DateVendorLastSeen,
                  LEFT.FirmEmployeeCount
                }
              ], Business_Risk_BIP.Layouts.LayoutSources);
          SELF.SalesSources := DATASET(
              [
                {
                  LEFT.Source,
                  IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
                  IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
                  LEFT.DateLastSeen,
                  LEFT.DateVendorLastSeen,
                  LEFT.FirmReportedSales
                }
              ], Business_Risk_BIP.Layouts.LayoutSalesSources);
          SELF := []));

	EBR5600StatsRolled :=
      ROLLUP(
        EBR5600StatsTemp,
        LEFT.Seq = RIGHT.Seq,
        TRANSFORM( tempLayout,
          SELF.Seq := LEFT.Seq;
          SELF.FirmAgeEstablished := MAX(LEFT.FirmAgeEstablished, RIGHT.FirmAgeEstablished);
          SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
          SELF.Sources := LEFT.Sources + RIGHT.Sources;
          SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
					SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
          SELF := LEFT;
          SELF := []));

	withEBR5600Stats :=
      JOIN(
        Shell, EBR5600StatsRolled,
        LEFT.Seq = RIGHT.Seq,
        TRANSFORM( Business_Risk_BIP.Layouts.Shell,
          SELF.Firmographic.FirmAgeEstablished := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmAgeEstablished, -1), -1, 110);
          SELF.Sources := RIGHT.Sources;
          SELF.EmployeeSources := RIGHT.EmployeeSources;
					SELF.SalesSources := RIGHT.SalesSources;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// Get all unique SIC Codes along with dates, for the primary and all 3 secondary SIC's
	getEBR5600SIC(InputDataset, OutputTable, OutputTemp, OutputRolled, WithInput, WithOutput, SICField, PrimarySIC) := MACRO
		OutputTable := TABLE(InputDataset,
    {Seq,
    LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
    Source := MDR.SourceTools.src_EBR,
    STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
    STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
    UNSIGNED4 RecordCount := COUNT(GROUP),
    STRING10 SICCode := IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,(STD.Str.Filter((STRING)SICField, '0123456789'))[1..8],(STD.Str.Filter((STRING)SICField, '0123456789'))[1..4]),
    BOOLEAN IsPrimary := PrimarySIC // SIC1 is the primary SIC in DNB DMI data, all others are not primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID), ((STRING)SICField)[1..4]
			 );

		OutputTemp := PROJECT(OutputTable, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
		OutputRolled := ROLLUP(OutputTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));

		WithOutput := JOIN(WithInput, OutputRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	ENDMACRO;
	// Go through and TABLE/ROLLUP/JOIN all SIC fields in the DNB DMI data
	getEBR5600SIC(EBR5600, EBR5600SIC1, EBR5600SIC1Temp, EBR5600SIC1Rolled, withEBR5600Stats, withEBR5600SIC1, SIC_1_Code, TRUE);
	getEBR5600SIC(EBR5600, EBR5600SIC2, EBR5600SIC2Temp, EBR5600SIC2Rolled, withEBR5600SIC1, withEBR5600SIC2, SIC_2_Code, FALSE);
	getEBR5600SIC(EBR5600, EBR5600SIC3, EBR5600SIC3Temp, EBR5600SIC3Rolled, withEBR5600SIC2, withEBR5600SIC3, SIC_3_Code, FALSE);
	getEBR5600SIC(EBR5600, EBR5600SIC4, EBR5600SIC4Temp, EBR5600SIC4Rolled, withEBR5600SIC3, withEBR5600, SIC_4_Code, FALSE);

	// ---------------- CRDB - Experian Credit Risk Data Base ------------------
	EBRCRDBRaw := Experian_CRDB.Key_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																							mod_access,
																							Business_Risk_BIP.Common.SetLinkSearchLevel(link_search_level),
																							0,/*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses
																							);

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq(EBRCRDBRaw, Shell, EBRCRDBSeq, link_search_level);

	// Figure out if the kFetch was successful
	// kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(EBRCRDBSeq);

	// Filter out records after our history date
	EBRCRDB := Business_Risk_BIP.Common.FilterRecords(EBRCRDBSeq, dt_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_Experian_CRDB, AllowedSourcesSet);

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	EBRCRDBStats_pre_pre := TABLE(EBRCRDB,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 Source := MDR.SourceTools.src_Experian_CRDB,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
       // For v30 and up, need to differentiate between 0 and '' for FirmReportedSales. Set missing records to -1.
       INTEGER FirmEmployeeCount := -1,
			 INTEGER FirmReportedSales := -1
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID)
			 );

  // If running Business Shell version 31 or higher, we'll need a dataset consisting of records that exist in the past 24 months
  // to calculate FirmEmployeeCount and SalesSources.
  EBRCRDB_past24Months := EBRCRDB( (INTEGER)dt_last_seen >= STD.Date.AdjustDate( HistoryDate, year_delta := -2 ) );

  // Sum of all most recent, populated employee count values among all unique data source company identifiers.
  tbl_FirmEmployeeCount_EBRCRDB := TABLE(
    DEDUP(SORT(EBRCRDB_past24Months(estimated_number_of_employees != ''), Seq, experian_bus_id , -dt_last_seen, -(INTEGER)estimated_number_of_employees), Seq, experian_bus_id ),
    {seq, FirmEmployeeCount := SUM( GROUP, (INTEGER)estimated_number_of_employees )},
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID) );

  EBRCRDBStats_pre :=
    JOIN(
      EBRCRDBStats_pre_pre, tbl_FirmEmployeeCount_EBRCRDB,
      LEFT.seq = RIGHT.seq,
      TRANSFORM( RECORDOF(EBRCRDBStats_pre_pre),
        SELF.FirmEmployeeCount :=
						IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,
								IF( COUNT(tbl_FirmEmployeeCount_EBRCRDB(seq = LEFT.seq)) > 0, RIGHT.FirmEmployeeCount, -1 ),
								LEFT.FirmEmployeeCount ),
        SELF := LEFT,
        SELF := []
      ),
			LEFT OUTER, FEW
    );

  // Sum of all most recent, populated reported sales values among all unique data source company identifiers.
  tbl_SalesSources_EBRCRDB := TABLE(
    DEDUP(SORT(EBRCRDB_past24Months(estimated_annual_sales_amount != ''), Seq, experian_bus_id , -dt_last_seen, -(INTEGER)estimated_annual_sales_amount), Seq, experian_bus_id ),
    {seq, FirmReportedSales := SUM( GROUP, (INTEGER)estimated_annual_sales_amount )},
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID) );

  EBRCRDBStats :=
    JOIN(
      EBRCRDBStats_pre, tbl_SalesSources_EBRCRDB,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( RECORDOF(EBRCRDBStats_pre_pre),
        SELF.FirmReportedSales :=
						IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,
								IF( COUNT(tbl_SalesSources_EBRCRDB(seq = LEFT.seq)) > 0, RIGHT.FirmReportedSales, -1 ),
								LEFT.FirmReportedSales ),
        SELF := LEFT,
        SELF := []
      ),
      LEFT OUTER, FEW
    );

	EBRCRDBStatsTemp :=
      PROJECT(
        EBRCRDBStats,
        TRANSFORM( tempLayout,
          SELF.Seq := LEFT.Seq;
          SELF.RecordCount := LEFT.RecordCount;
          SELF.Sources := DATASET(
            [
              {
                LEFT.Source,
                IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
                0,
                LEFT.DateLastSeen,
                0,
                LEFT.RecordCount
              }
            ], Business_Risk_BIP.Layouts.LayoutSources);
          SELF.EmployeeSources := DATASET(
              [
                {
                  LEFT.Source,
                  IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
                  0,
                  LEFT.DateLastSeen,
                  0,
                  LEFT.FirmEmployeeCount
                }
              ], Business_Risk_BIP.Layouts.LayoutSources);
          SELF.SalesSources := DATASET(
              [
                {
                  LEFT.Source,
                  IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
                  0,
                  LEFT.DateLastSeen,
                  0,
                  LEFT.FirmReportedSales
                }
              ], Business_Risk_BIP.Layouts.LayoutSalesSources);
          SELF := []));

	EBRCRDBStatsRolled :=
      ROLLUP(
        EBRCRDBStatsTemp,
        LEFT.Seq = RIGHT.Seq,
        TRANSFORM( tempLayout,
          SELF.Seq := LEFT.Seq;
          SELF.FirmAgeEstablished := MAX(LEFT.FirmAgeEstablished, RIGHT.FirmAgeEstablished);
          SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
          SELF.Sources := LEFT.Sources + RIGHT.Sources;
          SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
					SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
          SELF := LEFT;
          SELF := []));

	withEBRCRDBStats :=
      JOIN(
        withEBR5600, EBRCRDBStatsRolled,
        LEFT.Seq = RIGHT.Seq,
        TRANSFORM( Business_Risk_BIP.Layouts.Shell,
          SELF.Firmographic.FirmAgeEstablished := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmAgeEstablished, -1), -1, 110);
          SELF.Sources := LEFT.Sources + RIGHT.Sources;
          SELF.EmployeeSources := LEFT.EmployeeSources + RIGHT.EmployeeSources;
					SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(1), ATMOST(100), FEW);

  // Get all unique NAIC Codes along with dates. For this data source, we only need the primary code.
  EBRCRDB_NAIC := TABLE(EBRCRDB,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
      STRING2 Source := MDR.SourceTools.src_Experian_CRDB,
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 NAICCode := (STD.Str.Filter((STRING)primary_naics_code, '0123456789'))[1..6],
      BOOLEAN IsPrimary := TRUE
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID), ((STRING)primary_naics_code)[1..6]
  );

  EBRCRDB_NAICTemp :=
    PROJECT(
      EBRCRDB_NAIC,
      TRANSFORM(tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  EBRCRDB_NAICRolled :=
    ROLLUP(
      EBRCRDB_NAICTemp,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      )
    );

  withEBRCRDB_NAIC :=
    JOIN(withEBRCRDBStats, EBRCRDB_NAICRolled,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );

  // Get all unique SIC Codes along with dates. For this data source, we only need the primary code.
  EBRCRDB_SIC := TABLE(EBRCRDB,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
      STRING2 Source := MDR.SourceTools.src_Experian_CRDB,
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 SICCode := IF( Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31,(STD.Str.Filter((STRING)primary_sic_code, '0123456789'))[1..8],(STD.Str.Filter((STRING)primary_sic_code, '0123456789'))[1..4]),
      BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID), ((STRING)primary_sic_code)[1..4]
  );

  EBRCRDB_SICTemp :=
    PROJECT(
      EBRCRDB_SIC,
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  EBRCRDB_SICRolled :=
    ROLLUP(
      EBRCRDB_SICTemp,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      )
    );

  withEBRCRDB :=
    JOIN(withEBRCRDB_NAIC, EBRCRDB_SICRolled,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );

// --------------------------------------------

	withErrorCodes := JOIN(withEBRCRDB, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeEBR5600 := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(EBR5600Raw, 100), NAMED('Sample_EBR5600Raw'));
	// OUTPUT(CHOOSEN(EBR5600, 100), NAMED('Sample_EBR5600'));
	// OUTPUT(CHOOSEN(EBR5600Stats, 100), NAMED('Sample_EBR5600Stats'));
	// OUTPUT(CHOOSEN(EBR5600StatsTemp, 100), NAMED('Sample_EBR5600StatsTemp'));
	// OUTPUT(CHOOSEN(withEBR5600, 100), NAMED('Sample_withEBR5600'));

	RETURN withErrorCodes;
END;
