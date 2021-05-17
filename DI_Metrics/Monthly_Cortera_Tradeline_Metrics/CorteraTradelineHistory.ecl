/*
    The following macro calcuates historical Cortera Tradelines metrics. You can specify
    the timePeriod of the report (weekly, monthly, yearly) by invoking the macro from a 
    builder window, e.g.:

    Cortera_B2B_Live_Stats.CorteraTradelineHistory(weekly);
    Cortera_B2B_Live_Stats.CorteraTradelineHistory(monthly);
    Cortera_B2B_Live_Stats.CorteraTradelineHistory(yearly);

    The macro will write the report to disk on Thor and despray to a landing zone.

*/
// See below end of this macro for requirements.
IMPORT DI_Metrics, STD;

EXPORT CorteraTradeLineHistory(destinationIP, destinationpath, emailContact = 'DataInsightAutomation@lexisnexisrisk.com', timePeriod, today) := FUNCTIONMACRO

  filedate := (STRING8)today;

  // tradeline_data_in   := PULL(Cortera_Tradeline.Key_LinkIds.Key);
  tradeline_data_in   := DI_Metrics.Monthly_Cortera_Tradeline_Metrics.Cortera_Tradeline_Key_LinkIds_alias;
  tradeline_data_filt := tradeline_data_in(status = '' and ar_date != '' and seleid != 0);

  // For unit-testing, etc.:
  // seleids_to_look_at := [46,51];
  // tradeline_data_filt := tradeline_data_in(seleid IN seleids_to_look_at); 
  
  layout_tradeline_data_slim := RECORD
    UNSIGNED6 ultid;        //  ---- UltID, OrgID, and SeleID together identify 
    UNSIGNED6 orgid;        //  ---- a particular business at the Legal Entity
    UNSIGNED6 seleid;       //  ---- level.
    STRING32  account_key;  // Cortera definition: "Unique key for a tradeline"
    STRING8   ar_date;      // Cortera definition: "Date of the trade record. Format is YYYYMMDD"
    INTEGER8  current_ar;   // Cortera definition: "Current accounts receivables due"
    INTEGER8  aging_91plus; // Cortera definition: "Amount of accounts receivables that is more than 91 days past due"
    UNSIGNED4 weekly;       // YYYYMMDD format date that Cortera first reported the Tradeline record; for grouping
    UNSIGNED3 monthly;      // YYYYMM format of dt_vendor_first_reported; for grouping
    UNSIGNED2 yearly;       // YYYY format of dt_vendor_first_reported; for grouping
  END;

  tradeline_data_slim := 
    PROJECT(
      tradeline_data_filt,
      TRANSFORM( layout_tradeline_data_slim,
        SELF.ultid        := LEFT.ultid,
        SELF.orgid        := LEFT.orgid,
        SELF.seleid       := LEFT.seleid,
        SELF.account_key  := LEFT.account_key,
        SELF.ar_date      := LEFT.ar_date,
        SELF.current_ar   := (INTEGER)TRIM(LEFT.current_ar,LEFT,RIGHT),
        SELF.aging_91plus := (INTEGER)TRIM(LEFT.aging_91plus,LEFT,RIGHT),
        SELF.weekly       := (UNSIGNED4)LEFT.ar_date,
        SELF.monthly      := (UNSIGNED4)LEFT.ar_date DIV 100,
        SELF.yearly       := (UNSIGNED4)LEFT.ar_date DIV 10000
      )
    );

  // Since Cortera Tradeline records often do not appear faithfully every timePeriod they 
  // exist, we need to fill in the blanks so to speak with additional records where we are 
  // certain they do exist--based on the earliest and latest dates seen by the vendor. Only 
  // then can we get an accurate count of Tradelines for each timePeriod.

  // Generate a table of timePeriods based on a small sample of the Tradelines file.
  tradeline_data_small := CHOOSEN(DISTRIBUTE(tradeline_data_slim, HASH32(RANDOM())),1000000); // ***** THIS MIGHT BE A PROBLEM; DEDUP THE ENTIRE RECORD INSTEAD. *****
  tbl_timePeriods      := SORT( TABLE( tradeline_data_small, {Date := timePeriod}, timePeriod ), Date );

  tradeline_data_vendor_rptd_range :=
    TABLE(
      tradeline_data_slim,
      {
        ultid,
        orgid,
        seleid,
        account_key,
        dt_vndr_first_rptd := MIN(GROUP,timePeriod),
        dt_vndr_last_rptd  := MAX(GROUP,timePeriod),
        UNSIGNED4 Date := 0
      },
      ultid, orgid, seleid, account_key
    );

  // Add two years (per J. Bozik, Z. Fredenberg) to dt_vndr_last_rptd to account for those Tradelines 
  // we haven't heard from in up to two years but may yet be still active.
  YYYYMMDD := 8;
  YYYYMM   := 6;
  YYYY     := 4;
  
  tradeline_data_vendor_rptd_range_extended :=
    PROJECT(
      tradeline_data_vendor_rptd_range,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range),
        SELF.dt_vndr_last_rptd :=
          CASE( LENGTH((STRING)LEFT.dt_vndr_last_rptd),
            YYYYMMDD => LEFT.dt_vndr_last_rptd + 20000,
            YYYYMM   => LEFT.dt_vndr_last_rptd + 200,
            YYYY     => LEFT.dt_vndr_last_rptd + 2,
            LEFT.dt_vndr_last_rptd
          ),
        SELF := LEFT
      )
    );

  tradeline_data_vendor_rptd_range_corrected :=
    PROJECT(
      tradeline_data_vendor_rptd_range_extended,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range),
        SELF.dt_vndr_last_rptd :=
          CASE( LENGTH((STRING)LEFT.dt_vndr_last_rptd),
            YYYYMMDD => IF( LEFT.dt_vndr_last_rptd < (STD.Date.Today())          , LEFT.dt_vndr_last_rptd, STD.Date.Today() ),
            YYYYMM   => IF( LEFT.dt_vndr_last_rptd < (STD.Date.Today() DIV 100)  , LEFT.dt_vndr_last_rptd, STD.Date.Today() DIV 100 ),
            YYYY     => IF( LEFT.dt_vndr_last_rptd < (STD.Date.Today() DIV 10000), LEFT.dt_vndr_last_rptd, STD.Date.Today() DIV 10000 ),
            LEFT.dt_vndr_last_rptd
          ),
        SELF := LEFT
      )
    );

  tradeline_data_with_missing_dates :=
    NORMALIZE(
      tradeline_data_vendor_rptd_range_corrected,
      COUNT(tbl_timePeriods),
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range),
        SELF.Date := tbl_timePeriods[COUNTER].Date,
        SELF := LEFT
      )
    );

  tradeline_data_with_valid_dates := 
    tradeline_data_with_missing_dates(Date BETWEEN dt_vndr_first_rptd AND dt_vndr_last_rptd);

  // 0.a.  To get all unique Tradelines for each timePeriod (for calculating other metrics
  // besides the number of unique TLs per timePeriod), sort on timePeriod DESCENDING so
  // that we see the latest, accumulated account_keys at the top of the stack. Also, sort 
  // to find the most recent Accounts Receivable date. Then dedup.
  all_tradelines_by_seleid_srtd := SORT( tradeline_data_slim, seleid, account_key, -timePeriod, -ar_date, RECORD );
  all_tradelines_by_seleid_ddpd := DEDUP( all_tradelines_by_seleid_srtd, seleid, account_key, timePeriod );
  all_tradelines_by_seleid      := all_tradelines_by_seleid_ddpd : INDEPENDENT;

  // 0.b.  To get NEW, unique Tradelines for each timePeriod, sort on timePeriod ASCENDING 
  // so that we see the first instances of account_keys at the top of the stack. Also, sort 
  // to find the most recent Accounts Receivable date. Then dedup.
  new_tradelines_by_seleid_srtd := SORT( tradeline_data_slim, seleid, account_key, timePeriod, -ar_date, RECORD );
  new_tradelines_by_seleid_ddpd := DEDUP( new_tradelines_by_seleid_srtd, seleid, account_key );
  new_tradelines_by_seleid      := new_tradelines_by_seleid_ddpd : INDEPENDENT;

  layout_tradelines_info := RECORD
    INTEGER Date;              // Date of ending time period for which metrics are calculated
    INTEGER CountAllTLs;       // Count of all tradelines for the current time period
    INTEGER CountNewTLs;       // Count of new tradelines for the current time period
    INTEGER CountInactiveTLs;  // Count of inactive tradelines for the current time period
    INTEGER TtlValAllTLs;      // Total tradeline $ value across all SELEIDs over time (per time period)
    INTEGER TtlValNewTLs;      // Total tradeline $ value across new SELEIDs over time (per time period)
    INTEGER TtlValTLsGT91Days; // (Extra) Total tradeline $ value aging_91plus across unique SELEIDs over time (per time period)
    DECIMAL5_4 PctTLsGT91Days; // % of aging_91plus that are > 0 AND non-blank, over time (per time period)
    DECIMAL10_2 AvgCountTLs;   // Avg count of tradelines per unique SELEID (per time period)
    INTEGER MdnCountTLs;       // Median count of tradelines per unique SELEID (per time period)
    INTEGER AvgValueTLs;       // Avg tradeline $ value per unique SELEID (per time period)
    INTEGER MdnValTLs;         // Median tradeline $ value per unique SELEID (per time period)
  END;

  // 0. Count unique Tradelines over time:
  //    CountAllTLs --Count of tradelines for the current time period
  tbl_count_all_TLs_per_time_period := 
    TABLE(
      tradeline_data_with_valid_dates,
      {
        Date,
        CountAllTLs := COUNT(GROUP)
      },
      Date
    );

  // 1. Count and sum up some more metrics for new and unique Tradelines over time:
  //    TtlValTLsAllSeleIDs      --Total tradeline $ value across all unique SELEIDs over time
  //    TtlValTLsGT91Days        --Total tradeline $ value aging_91plus across unique SELEIDs over time
  //    PctTLsGT91Days           --Percentage of aging_91plus that are > 0 AND non-blank, over time
  tbl_metrics_for_TLs_per_time_period := 
    TABLE(
      all_tradelines_by_seleid,
      {
        Date              := timePeriod,
        TtlValAllTLs      := SUM(GROUP, current_ar), 
        TtlValTLsGT91Days := SUM(GROUP, aging_91plus),
        PctTLsGT91Days    := SUM(GROUP, aging_91plus) / SUM(GROUP, current_ar)
      },
      timePeriod
    );

  ds_tradelines_stats_0 := 
    JOIN(
      tbl_count_all_TLs_per_time_period, tbl_metrics_for_TLs_per_time_period,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.Date := LEFT.Date,
        SELF.CountAllTLs := LEFT.CountAllTLs,
        SELF.TtlValAllTLs := RIGHT.TtlValAllTLs,
        SELF.TtlValTLsGT91Days := RIGHT.TtlValTLsGT91Days,
        SELF.PctTLsGT91Days := RIGHT.PctTLsGT91Days,
        SELF := []
      ),
      KEEP(1),
      LEFT OUTER
    );

  // 2. Count the new (unique) tradelines per time period:
  //    CountNewTLs;          --Count of new tradelines for the current time period
  //    TtlValNewTLsBySeleIDs --Total tradeline $ value across all unique SELEIDs over time
  tbl_count_new_TLs_per_time_period := 
    TABLE(
      new_tradelines_by_seleid,
      {
        Date         := timePeriod,
        CountNewTLs  := COUNT(GROUP),
        TtlValNewTLs := SUM(GROUP, current_ar), 
      },
      timePeriod
    );

  ds_tradelines_stats_1 := 
    JOIN(
      ds_tradelines_stats_0, tbl_count_new_TLs_per_time_period,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.CountNewTLs := RIGHT.CountNewTLs,
        SELF.TtlValNewTLs := RIGHT.TtlValNewTLs,
        SELF := LEFT,
        SELF := []
      ),
      KEEP(1),
      LEFT OUTER
    );

  // 3. Get average number and average value of Tradelines among all seleids to calculate:
  //    AvgCountTLsPerSeleID--Avg count of tradelines per unique SELEID
  //    AvgValueTLsPerSeleID--Avg tradeline $ value per unique SELEID
  tbl_TL_counts_and_values_per_seleid := 
    TABLE(
      all_tradelines_by_seleid, 
      {
        timePeriod, 
        seleid, 
        count_TLs := COUNT(GROUP),
        value_TLs := SUM(GROUP, current_ar)
      }, 
      timePeriod, seleid 
    );

  tbl_TL_counts_and_values_per_time_period :=
    TABLE(
      tbl_TL_counts_and_values_per_seleid,
      {
        Date        := timePeriod,
        AvgCountTLs := SUM(GROUP, count_TLs) / COUNT(GROUP),
        AvgValueTLs := SUM(GROUP, value_TLs) / COUNT(GROUP)
      },
      timePeriod
    );

  ds_tradelines_stats_2 := 
    JOIN(
      ds_tradelines_stats_1, tbl_TL_counts_and_values_per_time_period,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.AvgCountTLs := (DECIMAL10_2)RIGHT.AvgCountTLs,
        SELF.AvgValueTLs := (INTEGER)RIGHT.AvgValueTLs,
        SELF := LEFT,
        SELF := []
      ),
      KEEP(1),
      LEFT OUTER
    );

  // 4. Get median number and median value of Tradelines among all seleids to calculate:
  //    MdnCountTLsPerSeleID;    // Median count of tradelines per unique SELEID
  //    MdnValTLsPerSeleID;      // Median tradeline $ value per unique SELEID
  ds_tradelines_stats_3_pre :=
    DENORMALIZE(
      ds_tradelines_stats_2, tbl_TL_counts_and_values_per_seleid,
      LEFT.Date = RIGHT.timePeriod,
      GROUP,
      TRANSFORM( layout_tradelines_info,
        SELF.MdnCountTLs := SORT( ROWS(RIGHT), timePeriod, count_TLs )[ROUND(COUNT(ROWS(RIGHT))/2)].count_TLs,
        SELF.MdnValTLs   := SORT( ROWS(RIGHT), timePeriod, value_TLs )[ROUND(COUNT(ROWS(RIGHT))/2)].value_TLs,
        SELF := LEFT
      ),
      LEFT OUTER,
      SKEW(1.0)
    );

  ds_tradelines_stats_3 := PROJECT( ds_tradelines_stats_3_pre, { layout_tradelines_info AND NOT [CountInactiveTLs] } );
  
  // 5. Calculate the number of Tradelines that have become Inactive during the last timeperiod
  layout_tradelines_info_slim := RECORD
    INTEGER Date;              // Date of ending time period for which metrics are calculated
    INTEGER CountInactiveTLs;  // Count of all tradelines that haven't been seen in the last 2 years
  END;

  ds_tradelines_stats_4_pre := 
    ITERATE(
      ds_tradelines_stats_3_pre,
      TRANSFORM( layout_tradelines_info,
        SELF.CountInactiveTLs := LEFT.CountAllTLs + RIGHT.CountNewTLs - RIGHT.CountAllTLs,
        SELF := RIGHT
      )
    );

  ds_tradelines_stats_4 := PROJECT( ds_tradelines_stats_4_pre, layout_tradelines_info_slim );
  
  _timePeriod := 
    TRIM(
      CASE( 
        LENGTH((STRING)ds_tradelines_stats_3[1].Date),
        8 => 'weekly',
        6 => 'monthly',
        4 => 'yearly',
        'unk'
      )
    );
  
  fileName_stem := '~thor_data400::data_insight::data_metrics::';
  
  fileName_history_active_TLs := 'CorteraTradelineHistory_' + _timePeriod + '_' + filedate + '.csv';
  fileName_history_active_TLs_full := fileName_stem + fileName_history_active_TLs;

  fileName_history_inactive_TLs := 'CorteraTradelineHistoryInactive_' + _timePeriod + '_' + filedate + '.csv';
  fileName_history_inactive_TLs_full := fileName_stem + fileName_history_inactive_TLs;

  output_to_thor_active_TLs := 
    OUTPUT( ds_tradelines_stats_3, , fileName_history_active_TLs_full, CSV(HEADING(SINGLE), SEPARATOR(','), TERMINATOR('\r\n'), QUOTE('\"')), OVERWRITE, EXPIRE(30) );

  output_to_thor_inactive_TLs := 
    OUTPUT( ds_tradelines_stats_4, , fileName_history_inactive_TLs_full, CSV(HEADING(SINGLE), SEPARATOR(','), TERMINATOR('\r\n'), QUOTE('\"')), OVERWRITE, EXPIRE(30) );

  // Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
  despray_to_LZ_active_TLs := // charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
    STD.File.DeSpray( fileName_history_active_TLs_full, destinationIP, destinationpath + fileName_history_active_TLs, , , , TRUE );

  despray_to_LZ_inactive_TLs := // charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
    STD.File.DeSpray( fileName_history_inactive_TLs_full, destinationIP, destinationpath + fileName_history_inactive_TLs, , , , TRUE );

  // If everything in the Sequential statement runs it will send the Success email, else the Failure email.
  email_alert := 
    SEQUENTIAL(
      output_to_thor_active_TLs,
      output_to_thor_inactive_TLs,
      despray_to_LZ_active_TLs,
      despray_to_LZ_inactive_TLs
    ) :
    SUCCESS(FileServices.SendEmail(emailContact, 'Cortera Group: CorteraTradelineHistory (' + _timePeriod + ') Build Succeeded', WORKUNIT + ': Build complete.' + filedate)),
    FAILURE(FileServices.SendEmail(emailContact, 'Cortera Group: CorteraTradelineHistory (' + _timePeriod + ') Failed', WORKUNIT + filedate + '\n' + FAILMESSAGE));

  RETURN email_alert;

ENDMACRO;

