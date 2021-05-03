/*
    The following macro calcuates historical Cortera Tradelines growth metrics, by seleid,
    proxid, and Cortera link_id. You can specify the timePeriod of the report (weekly, 
    monthly, yearly) by invoking the macro from a builder window, e.g.:

    Cortera_B2B_Live_Stats.CorteraTradelineGrowth(weekly);
    Cortera_B2B_Live_Stats.CorteraTradelineGrowth(monthly);
    Cortera_B2B_Live_Stats.CorteraTradelineGrowth(yearly);

    The macro will write the report to disk on Thor and despray to a landing zone.

*/
IMPORT DI_Metrics, STD;

EXPORT CorteraTradeLineGrowth(destinationIP, destinationpath, emailContact = 'DataInsightAutomation@lexisnexisrisk.com', timePeriod, today) := FUNCTIONMACRO

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
    UNSIGNED6 proxid;       // ProxID identifies a particular business location.
    UNSIGNED4 link_id;      // Cortera definition: "Cortera unique identifier for a location"
    STRING32  account_key;  // Cortera definition: "Unique key for a tradeline"
    STRING8   ar_date;      // Cortera definition: "Date of the trade record. Format is YYYYMMDD"
    INTEGER8  current_ar;   // Cortera definition: "Current accounts receivables due"
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
        SELF.proxid       := LEFT.proxid,
        SELF.link_id      := LEFT.link_id,
        SELF.account_key  := LEFT.account_key,
        SELF.ar_date      := LEFT.ar_date,
        SELF.current_ar   := (INTEGER)TRIM(LEFT.current_ar,LEFT,RIGHT),
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
  tradeline_data_small := CHOOSEN(DISTRIBUTE(tradeline_data_slim, HASH32(RANDOM())),1000000);
  tbl_timePeriods      := SORT( TABLE( tradeline_data_small, {Date := timePeriod}, timePeriod ), Date );

  // 1.a. Get all Tradelines for each timePeriod by SeleID.
  tradeline_data_vendor_rptd_range_by_seleid :=
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
  
  tradeline_data_vendor_rptd_range_by_seleid_extended :=
    PROJECT(
      tradeline_data_vendor_rptd_range_by_seleid,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_seleid),
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

  tradeline_data_vendor_rptd_range_by_seleid_corrected :=
    PROJECT(
      tradeline_data_vendor_rptd_range_by_seleid_extended,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_seleid),
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

  tradeline_data_with_missing_dates_by_seleid :=
    NORMALIZE(
      tradeline_data_vendor_rptd_range_by_seleid_corrected,
      COUNT(tbl_timePeriods),
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_seleid),
        SELF.Date := tbl_timePeriods[COUNTER].Date,
        SELF := LEFT
      )
    );
  
  all_tradelines_by_seleid := 
    tradeline_data_with_missing_dates_by_seleid(Date BETWEEN dt_vndr_first_rptd AND dt_vndr_last_rptd);
  
  // 1.b. Get new Tradelines for each timePeriod by SeleID.
  new_tradelines_by_seleid := 
    DEDUP( 
      SORT( tradeline_data_slim, seleid, account_key, timePeriod, -ar_date, RECORD ), 
      seleid, account_key 
    );

  // 2.a. Get all Tradelines for each timePeriod by ProxID.
  tradeline_data_vendor_rptd_range_by_proxid :=
    TABLE(
      tradeline_data_slim,
      {
        ultid,
        orgid,
        seleid,
        proxid,
        account_key,
        dt_vndr_first_rptd := MIN(GROUP,timePeriod),
        dt_vndr_last_rptd  := MAX(GROUP,timePeriod),
        UNSIGNED4 Date := 0
      },
      ultid, orgid, seleid, proxid, account_key
    );

  tradeline_data_vendor_rptd_range_by_proxid_extended :=
    PROJECT(
      tradeline_data_vendor_rptd_range_by_proxid,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_proxid),
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

  tradeline_data_vendor_rptd_range_by_proxid_corrected :=
    PROJECT(
      tradeline_data_vendor_rptd_range_by_proxid_extended,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_proxid),
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

  tradeline_data_with_missing_dates_by_proxid :=
    NORMALIZE(
      tradeline_data_vendor_rptd_range_by_proxid_corrected,
      COUNT(tbl_timePeriods),
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_proxid),
        SELF.Date := tbl_timePeriods[COUNTER].Date,
        SELF := LEFT
      )
    );
  
  all_tradelines_by_proxid := 
    tradeline_data_with_missing_dates_by_proxid(Date BETWEEN dt_vndr_first_rptd AND dt_vndr_last_rptd);
  
  // 2.b. Get new Tradelines for each timePeriod by ProxID.
  new_tradelines_by_proxid := 
    DEDUP( 
      SORT( tradeline_data_slim, proxid, account_key, timePeriod, -ar_date, RECORD ), 
      proxid, account_key 
    );

  // 3.a. Get all Tradelines for each timePeriod by Cortera Link_ID.
  tradeline_data_vendor_rptd_range_by_link_id :=
    TABLE(
      tradeline_data_slim,
      {
        link_id,
        account_key,
        dt_vndr_first_rptd := MIN(GROUP,timePeriod),
        dt_vndr_last_rptd  := MAX(GROUP,timePeriod),
        UNSIGNED4 Date := 0
      },
      link_id, account_key
    );

  tradeline_data_vendor_rptd_range_by_link_id_extended :=
    PROJECT(
      tradeline_data_vendor_rptd_range_by_link_id,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_link_id),
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

  tradeline_data_vendor_rptd_range_by_link_id_corrected :=
    PROJECT(
      tradeline_data_vendor_rptd_range_by_link_id_extended,
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_link_id),
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

  tradeline_data_with_missing_dates_by_link_id :=
    NORMALIZE(
      tradeline_data_vendor_rptd_range_by_link_id_corrected,
      COUNT(tbl_timePeriods),
      TRANSFORM( RECORDOF(tradeline_data_vendor_rptd_range_by_link_id),
        SELF.Date := tbl_timePeriods[COUNTER].Date,
        SELF := LEFT
      )
    );
  
  all_tradelines_by_linkid := 
    tradeline_data_with_missing_dates_by_link_id(Date BETWEEN dt_vndr_first_rptd AND dt_vndr_last_rptd);
  
  // 3.b. Get new Tradelines for each timePeriod by Cortera Link_ID.
  new_tradelines_by_linkid := 
    DEDUP( 
      SORT( tradeline_data_slim, link_id, account_key, timePeriod, -ar_date, RECORD ), 
      link_id, account_key 
    );

  layout_tradelines_info := RECORD
    INTEGER Date;                
    INTEGER CountAllTLsBySeleid;  // Count of all tradelines by seleid for the current time period
    INTEGER CountNewTLsBySeleid;  // Count of new tradelines by seleid for the current time period
    INTEGER TtlValNewTLsBySeleid; // Total tradeline $ value by seleid for the current time period
    INTEGER CountAllTLsByProxid;  // Count of all tradelines by proxid for the current time period
    INTEGER CountNewTLsByProxid;  // Count of new tradelines by proxid for the current time period
    INTEGER TtlValNewTLsByProxid; // Total tradeline $ value by proxid for the current time period
    INTEGER CountAllTLsByLinkid;  // Count of all tradelines by Cortera link_id for the current time period
    INTEGER CountNewTLsByLinkid;  // Count of new tradelines by Cortera link_id for the current time period
    INTEGER TtlValNewTLsByLinkid; // Total tradeline $ value by Cortera link_id for the current time period
  END;

  // 4. Count both all and new tradelines per time period by seleid, and value of new tradelines.
  tbl_count_all_tradelines_by_seleid := 
    TABLE( all_tradelines_by_seleid, { Date, CountAllTLsBySeleid := COUNT(GROUP) }, Date );

  tbl_count_new_tradelines_by_seleid := 
    TABLE( new_tradelines_by_seleid, { Date := timePeriod, CountNewTLsBySeleid := COUNT(GROUP), TtlValNewTLsBySeleID := SUM(GROUP, current_ar), }, timePeriod );

  // 5. Count both all and new tradelines per time period by proxid, and value of new tradelines.
  tbl_count_all_tradelines_by_proxid := 
    TABLE( all_tradelines_by_proxid, { Date, CountAllTLsByProxid := COUNT(GROUP) }, Date );

  tbl_count_new_tradelines_by_proxid := 
    TABLE( new_tradelines_by_proxid, { Date := timePeriod, CountNewTLsByProxid := COUNT(GROUP), TtlValNewTLsByProxid := SUM(GROUP, current_ar), }, timePeriod );

  // 6. Count both all and new tradelines per time period by Cortera link_id, and value of new tradelines.
  tbl_count_all_tradelines_by_linkid := 
    TABLE( all_tradelines_by_linkid, { Date, CountAllTLsByLinkid := COUNT(GROUP) }, Date );

  tbl_count_new_tradelines_by_linkid := 
    TABLE( new_tradelines_by_linkid, { Date := timePeriod, CountNewTLsByLinkid := COUNT(GROUP), TtlValNewTLsByLinkid := SUM(GROUP, current_ar), }, timePeriod );

  // 7. Use a series of joins to pull all of the information together into a single dataset.
  join_result_1 :=
    JOIN(
      tbl_count_all_tradelines_by_seleid, tbl_count_new_tradelines_by_seleid,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.Date                 := LEFT.Date,
        SELF.CountAllTLsBySeleid  := LEFT.CountAllTLsBySeleid,
        SELF.CountNewTLsBySeleid  := RIGHT.CountNewTLsBySeleid,
        SELF.TtlValNewTLsBySeleid := RIGHT.TtlValNewTLsBySeleid,
        SELF := []
      ),
      LEFT OUTER,
      KEEP(1)
    );
 
   join_result_2 :=
    JOIN(
      join_result_1, tbl_count_all_tradelines_by_proxid,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.CountAllTLsByProxid := RIGHT.CountAllTLsByProxid,
        SELF := LEFT;
        SELF := []
      ),
      LEFT OUTER,
      KEEP(1)
    );
    
   join_result_3 :=
    JOIN(
      join_result_2, tbl_count_new_tradelines_by_proxid,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.CountNewTLsByProxid  := RIGHT.CountNewTLsByProxid,
        SELF.TtlValNewTLsByProxid := RIGHT.TtlValNewTLsByProxid,
        SELF := LEFT;
        SELF := []
      ),
      LEFT OUTER,
      KEEP(1)
    );

   join_result_4 :=
    JOIN(
      join_result_3, tbl_count_all_tradelines_by_linkid,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.CountAllTLsByLinkid  := RIGHT.CountAllTLsByLinkid,
        SELF := LEFT;
        SELF := []
      ),
      LEFT OUTER,
      KEEP(1)
    );

   join_result_5 :=
    JOIN(
      join_result_4, tbl_count_new_tradelines_by_linkid,
      LEFT.Date = RIGHT.Date,
      TRANSFORM( layout_tradelines_info,
        SELF.CountNewTLsByLinkid  := RIGHT.CountNewTLsByLinkid,
        SELF.TtlValNewTLsByLinkid := RIGHT.TtlValNewTLsByLinkid,
        SELF := LEFT;
        SELF := []
      ),
      LEFT OUTER,
      KEEP(1)
    );
    
  _timePeriod := 
    TRIM(
      CASE( 
        LENGTH((STRING)join_result_1[1].Date),
        8 => 'weekly',
        6 => 'monthly',
        4 => 'yearly',
        'unk'
      )
    );

  fileName_stem := '~thor_data400::data_insight::data_metrics::';
  fileName      := 'CorteraTradelineGrowth_' + _timePeriod + '_' + filedate + '.csv';
  fileName_full := fileName_stem + fileName;

  output_to_thor := 
    OUTPUT( join_result_5, , fileName_full, CSV(HEADING(SINGLE), SEPARATOR(','), TERMINATOR('\r\n'), QUOTE('\"')), OVERWRITE, EXPIRE(30) );

  // Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
  despray_to_LZ := // charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
    STD.File.DeSpray( fileName_full, destinationIP, destinationpath + fileName, , , , TRUE );

  // If everything in the Sequential statement runs it will send the Success email, else the Failure email.
  email_alert := 
    SEQUENTIAL(
      output_to_thor,
      despray_to_LZ
    ) :
    SUCCESS(FileServices.SendEmail(emailContact , 'Cortera Group: CorteraTradelineGrowth (' + _timePeriod + ') Build Succeeded', WORKUNIT + ': Build complete.' + filedate)),
    FAILURE(FileServices.SendEmail(emailContact , 'Cortera Group: CorteraTradelineGrowth (' + _timePeriod + ') Failed', WORKUNIT + filedate + '\n' + FAILMESSAGE));

  RETURN email_alert;

ENDMACRO;

