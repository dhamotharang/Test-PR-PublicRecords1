import $, AutoKeyI, iesp, BIPV2, BusinessCredit_Services, dx_Cortera_Tradeline, Std, ut;

// Note - currently only single inputs (ie records with only 1 uniqueid value) are supported
// most functions support multiple uniqueid values, but some future work is still required to fully
// support inputs with multiple uniqueid values
export LN_Tradeline_Functions(dataset(BIPV2.IDlayouts.l_xlink_ids2) ids) := module

  shared current_date := Std.Date.Today();

  shared active_age_days := 100;
  shared payment_age_months := 9;

  shared translate_key(string k) := function
    data dval := hashmd5(k);
    return Std.Str.ToHexPairs(dval);
  end;

  shared segment_map(integer id) := map(
      id in $.Constants.IndustrySegment.Set_Material => $.Constants.IndustrySegment.Material,
      id in $.Constants.IndustrySegment.Set_Operations => $.Constants.IndustrySegment.Operations,
      id in $.Constants.IndustrySegment.Set_Carrier => $.Constants.IndustrySegment.Carrier,
      id in $.Constants.IndustrySegment.Set_Fleet => $.Constants.IndustrySegment.Fleet,
      $.Constants.IndustrySegment.Other
  );

  shared rawTradelineRecs := dx_Cortera_Tradeline.Key_LinkIds.kFetch2(ids, BIPV2.IDconstants.Fetch_Level_SELEID);

  shared layout_ex := record(recordof(rawTradelineRecs))
    string _segment;
    integer _age_days;
  end;

  shared layout_acct_info := record
    layout_ex.uniqueid;
    layout_ex.segment_id;
    layout_ex.account_key;
    layout_ex._segment;
    string account_id;
  end;

  shared layout_seg_intermediate := record
    layout_ex.uniqueid;
    layout_ex.account_key;
    layout_ex._segment;
    integer provider_cnt;
    real avg_balance;
    real avg_dbt;
    integer max_balance;
  end;

  // add the age in days to the raw tradeline recs
  shared tradelineRecsEx := project(rawTradelineRecs,
    transform(layout_ex,
      self._segment := '',
      self._age_days := Std.Date.DaysBetween((unsigned)left.ar_date, current_date),
      self := left));

  // sort within each account with most recent recs on top
  shared tradelineRecsSorted_tmp := sort(tradelineRecsEx, uniqueid, account_key, _age_days);
  shared acct_recs := dedup(tradelineRecsSorted_tmp, uniqueid, account_key);

  // stores info for each unique account including the segment and the mapped account_id value
  shared acct_info := project(acct_recs,
    transform(layout_acct_info,
      self.account_id := translate_key(left.account_key),
      self._segment := segment_map((integer)left.segment_id),
      self := left
    )
  );

  // add the segment name from acct_info
  shared tradelineRecsSorted := join(tradelineRecsSorted_tmp, acct_info,
    left.uniqueid = right.uniqueid and left.account_key = right.account_key,
    transform(layout_ex,
      self._segment := right._segment,
      self := left
    )
  );

  shared daysLimitedRecs(integer lim) := tradelineRecsSorted(_age_days <= lim);

  // ---------------------------------------------------------------------------
  // shared functions
  // ---------------------------------------------------------------------------
  shared get_pmt_summary(in_recs) := functionmacro

    local layout_pmt_info := record
      integer balance;
      integer current;
      integer amt1to30;
      integer amt31to60;
      integer amt61to90;
      integer amt91plus;
    end;
    local layout_pmt_intermediate := record
      in_recs.uniqueid;
      string _segment;
      integer provider_cnt;
      layout_pmt_info tot;
      layout_pmt_info per;
    end;

    local layout_pmt_intermediate proj_trans(recordof(in_recs) l) := transform
      self.uniqueid := l.uniqueid;
      self._segment := l._segment;
      self.provider_cnt := 1;
      self.tot.balance := (integer)l.total_ar;
      self.tot.current := (integer)l.current_ar;
      self.tot.amt1to30 := (integer)l.aging_1to30;
      self.tot.amt31to60 := (integer)l.aging_31to60;
      self.tot.amt61to90 := (integer)l.aging_61to90;
      self.tot.amt91plus := (integer)l.aging_91plus;
      self := [];
    end;
    local layout_pmt_intermediate roll_trans(layout_pmt_intermediate l, layout_pmt_intermediate r) := transform
      self.uniqueid := r.uniqueid;
      self._segment := r._segment;
      self.provider_cnt := l.provider_cnt + r.provider_cnt;
      self.tot.balance := l.tot.balance + r.tot.balance;
      self.tot.current := l.tot.current + r.tot.current;
      self.tot.amt1to30 := l.tot.amt1to30 + r.tot.amt1to30;
      self.tot.amt31to60 := l.tot.amt31to60 + r.tot.amt31to60;
      self.tot.amt61to90 := l.tot.amt61to90 + r.tot.amt61to90;
      self.tot.amt91plus := l.tot.amt91plus + r.tot.amt91plus;
      self := [];
    end;
    local layout_pmt_intermediate calc_trans(layout_pmt_intermediate l) := transform
      // ensure the percentages sum to 100 and handle negative current values
      tot_val := if(l.tot.current < 0, l.tot.balance - l.tot.current, l.tot.balance);
      per_1to30 := if(tot_val > 0, truncate((l.tot.amt1to30 / tot_val) * 100), 0);
      per_31to60 := if(tot_val > 0, truncate((l.tot.amt31to60 / tot_val) * 100), 0);
      per_61to90 := if(tot_val > 0, truncate((l.tot.amt61to90 / tot_val) * 100), 0);
      per_91plus := if(tot_val > 0, truncate((l.tot.amt91plus / tot_val) * 100), 0);
      per_cur := if(tot_val > 0, 100 - (per_1to30 + per_31to60 + per_61to90 + per_91plus), 0);

      self.per.balance := 100;
      self.per.current := per_cur;
      self.per.amt1to30 := per_1to30;
      self.per.amt31to60 := per_31to60;
      self.per.amt61to90 := per_61to90;
      self.per.amt91plus := per_91plus;
      self := l;
    end;

    // deduping will keep only the most recent rec in each account (they are already age sorted)
    local fmrecs_d := dedup(in_recs, uniqueid, account_key);

    // use the rollup to get the totals
    local fmrecs_p := project(fmrecs_d, proj_trans(left));
    local fmrecs_r := rollup(fmrecs_p, roll_trans(left, right), uniqueid);

    // and finally project the results to calculate the percentages
    local fmrecs_out := project(fmrecs_r, calc_trans(left));

    return fmrecs_out;

  endmacro;


  shared get_seg_provider(dataset(layout_ex) recs_in) := function

    layout_seg_intermediate roll_trans(layout_ex l, dataset(layout_ex) recs) := transform
      r_cnt := count(recs);
      t_balance := sum(recs, (integer)total_ar);
      ptot_1 := sum(recs, (integer)aging_1to30);
      ptot_2 := sum(recs, (integer)aging_31to60);
      ptot_3 := sum(recs, (integer)aging_61to90);
      ptot_4 := sum(recs, (integer)aging_91plus);
      ptot_sum := (ptot_1 * 15) + (ptot_2 * 45) + (ptot_3 * 75) + (ptot_4 * 105);

      self.uniqueid := l.uniqueid;
      self.account_key := l.account_key;
      self._segment := l._segment;
      self.provider_cnt := 1;
      self.avg_balance := if(r_cnt > 0, t_balance / r_cnt, 0);
      self.avg_dbt := if(t_balance > 0, ptot_sum / t_balance, 0);
      self.max_balance := max(recs, (integer)total_ar);
    end;

    // use the grouped rollup to calculate needed sums/averages for all records in each account
    // each account should have up to X months of data (input recs are pre-filtered, caller determines X)
    recs_grp := group(recs_in, uniqueid, account_key);
    recs_rolled := rollup(recs_grp, group, roll_trans(left, rows(left)));

    return recs_rolled;

  end;


  shared get_seg_combined(dataset(layout_seg_intermediate) recs_in) := function

    layout_seg_intermediate roll_trans(layout_seg_intermediate l, dataset(layout_seg_intermediate) recs) := transform
      r_cnt := count(recs);
      t_avg_balance := sum(recs, avg_balance);
      t_avg_dbt := sum(recs, avg_dbt);

      self.uniqueid := l.uniqueid;
      self.account_key := '';
      self._segment := l._segment;
      self.provider_cnt := r_cnt;
      self.avg_balance := if(r_cnt > 0, t_avg_balance / r_cnt, 0);
      self.avg_dbt := if(r_cnt > 0, t_avg_dbt / r_cnt, 0);
      self.max_balance := max(recs, max_balance);
    end;

    // use grouped rollup to average the account values per-segment
    // the input records will contain per-account averages already
    recs_srt := sort(recs_in, uniqueid, _segment);
    recs_grp := group(recs_srt, uniqueid, _segment);
    recs_rolled := rollup(recs_grp, group, roll_trans(left, rows(left)));

    return recs_rolled;

  end;


  shared compose_segment_summary(dataset(layout_ex) recs_in) := function

    // get avg summary info for each provider, then average for the providers in each segment category
    recs_p := get_seg_provider(recs_in);
    recs_c := get_seg_combined(recs_p);

    // get a payment summary for each of the subset of records in each segment category
      recs_grp := group(sort(recs_in, uniqueid, _segment, account_key, _age_days), uniqueid, _segment);
    recs_psum_g := get_pmt_summary(recs_grp);
    recs_psum := ungroup(recs_psum_g);

    iesp.smallbusinessbipcombinedreport.t_SegmentPaymentSummary combine_trans(layout_seg_intermediate l, recordof(recs_psum) r) := transform
      self.IndustrySegment := l._segment;
      self.ProviderCount := l.provider_cnt;
      self.AverageBalance := (string)round(l.avg_balance);
      self.AverageDBT := (string)round(l.avg_dbt);
      self.HighestBalance := (string)l.max_balance;
      self.PastDueAgingAmount31to60Percent := (string)r.per.amt31to60;
      self.PastDueAgingAmount61to90Percent := (string)r.per.amt61to90;
      self.PastDueAgingAmount91PlusPercent := (string)r.per.amt91plus;
    end;

    // add the relevant payment summary info to the combined segment values
    recs_out := join(recs_c, recs_psum,
      left.uniqueid = right.uniqueid and left._segment = right._segment,
      combine_trans(left, right),
      keep(1), limit(0)
    );

    return recs_out;

  end;


  shared compose_account_summary(dataset(layout_ex) recs_in, integer active_age) := function

    // 24-month limit on payment history
    past_dt_24 := Std.Date.AdjustDate(current_date, 0, -24, 0);
    d_age_24 := Std.Date.DaysBetween(past_dt_24, current_date);

    // sort order based on status (current, overdue, inactive)
    status_order(string stat) := map(
      stat = $.Constants.B2BAccountStatus.Current => 1,
      stat = $.Constants.B2BAccountStatus.Overdue => 2,
      3
    );

    iesp.smallbusinessbipcombinedreport.t_AccountPaymentHistory history_trans(layout_ex l) := transform
      self.DateReported := iesp.ECL2ESP.toDatestring8(l.ar_date);
      self.TotalCurrentExposure := l.total_ar;
      self.WithinTermsTotal := l.current_ar;
      self.PastDueAgingAmount01to30Total := l.aging_1to30;
      self.PastDueAgingAmount31to60Total := l.aging_31to60;
      self.PastDueAgingAmount61to90Total := l.aging_61to90;
      self.PastDueAgingAmount91PlusTotal := l.aging_91plus;
    end;

    iesp.smallbusinessbipcombinedreport.t_B2BTradeAcctDetail roll_trans(layout_ex l, dataset(layout_ex) recs) := transform
      is_active := recs[1]._age_days <= active_age;
      amt_out := (integer)recs[1].total_ar - (integer)recs[1].current_ar;
      pmt_recs := choosen(recs(_age_days <= d_age_24), iesp.Constants.BusinessCredit.MaxPaymentHistory);

      self.AccountNo := l.account_key;
      self.Status := map(
        not is_active => $.Constants.B2BAccountStatus.Inactive,
        amt_out > 0 => $.Constants.B2BAccountStatus.Overdue,
        $.Constants.B2BAccountStatus.Current
      );
      self.IndustrySegment := l._segment;
      self.DateReported := iesp.ECL2ESP.toDatestring8(recs[1].ar_date);
      self.AmountOutstanding := (string)amt_out;
      self.PaymentHistory := project(pmt_recs, history_trans(left));
    end;

    // currently we only use the top element in each account (and the below could be done with dedup),
    // this may eventually incorporate data from multiple records, so leaving as grouped rollup
    recs_grp := group(recs_in, uniqueid, account_key);
    recs_rolled := rollup(recs_grp, group, roll_trans(left, rows(left)));

    // the original account_key is seemingly already a hashed value, but to be on the safe side
    // use the 'further hashed' matching account_id value to ensure no acctual account data is relayed
    recs_trans := join(recs_rolled, acct_info,
      left.AccountNo = right.account_key,
      transform(iesp.smallbusinessbipcombinedreport.t_B2BTradeAcctDetail,
        self.AccountNo := right.account_id,
        self := left
      )
    );
    recs_srtd := sort(recs_trans, status_order(Status), IndustrySegment, DateReported.Year,
      DateReported.Month, DateReported.Day);

    return recs_srtd;

  end;


  shared compose_trade_summary(integer active_age) := function

    // use most recent record for each account
    recs_all := tradelineRecsSorted;
    recs_lim := daysLimitedRecs(active_age);
    recs_recent := dedup(recs_lim, uniqueid, account_key);

    num_act := count(recs_recent);
    oldest_date := min(recs_all(ar_date <> ''), (integer)ar_date);
    t_balance := sum(recs_recent, (integer)total_ar);
    t_current := sum(recs_recent, (integer)current_ar);
    t_over := t_balance - t_current;
    avg_over := round(t_over / num_act);

    max_bal := max(recs_recent, (integer)total_ar);
    max_1 := max(recs_recent, (integer)aging_1to30);
    max_2 := max(recs_recent, (integer)aging_31to60);
    max_3 := max(recs_recent, (integer)aging_61to90);
    max_4 := max(recs_recent, (integer)aging_91plus);
    stat := map(
      max_4 > 0 => 'OVERDUE 90PLUS',
      max_3 > 0 => 'OVERDUE 60',
      max_2 > 0 => 'OVERDUE 30',
      max_1 > 0 => 'OVERDUE',
      'WITHIN TERMS'
    );

    // get the median balance
    BusinessCredit_Services.Macros.Mac_Median(recs_recent, med_bal, total_ar);

    iesp.businesscreditreport.t_BusinessCreditTradeSummary summary_trans() := transform
      self.OpenAccountsCount := num_act;
      self.AccountOpenDate := if(oldest_date > 0, iesp.ECL2ESP.toDatestring8((string)oldest_date));
      self.TotalOverdue := if(num_act > 0, (string)t_over, '');
      self.MostSevereStatus := if(num_act > 0, stat, '');
      self.HighestCredit := if(num_act > 0, (string)max_bal, '');
      self.TotalCurrentExposure := if(num_act > 0, (string)t_balance, '');
      self.MedianBalance := if(num_act > 0, (string)round(med_bal), '');
      self.AvgOpenBalance := if(num_act > 0, (string)avg_over, '');
      self := [];
    end;

    return dataset([summary_trans()]);

  end;


  shared compose_payment_summary(integer lim_days = 0, integer lim_mos = 0) := function

    past_dt := Std.Date.AdjustDate(current_date, 0, -lim_mos, -lim_days);
    d_age := Std.Date.DaysBetween(past_dt, current_date);

    // get_pmt_summary results will contain totals and percentages per-account
    recs_lim := daysLimitedRecs(d_age);
    pmt_recs := get_pmt_summary(recs_lim);

    iesp.smallbusinessbipcombinedreport.t_DatedPaymentSummaryEx proj_trans(recordof(pmt_recs) l) := transform
      self.TotalCurrentExposure := (string)l.tot.balance;

      self.WithinTermsTotal := (string)l.tot.current;
      self.WithinTermsPercent := (string)l.per.current;

      self.PastDueAgingAmount01to30Total := (string)l.tot.amt1to30;
      self.PastDueAgingAmount31to60Total := (string)l.tot.amt31to60;
      self.PastDueAgingAmount61to90Total := (string)l.tot.amt61to90;
      self.PastDueAgingAmount91PlusTotal := (string)l.tot.amt91plus;
      self.PastDueAgingAmount01to30Percent := (string)l.per.amt1to30;
      self.PastDueAgingAmount31to60Percent := (string)l.per.amt31to60;
      self.PastDueAgingAmount61to90Percent := (string)l.per.amt61to90;
      self.PastDueAgingAmount91PlusPercent := (string)l.per.amt91plus;

      self.DateReported := iesp.ECL2ESP.toDatestring8((string)past_dt);
      self.ProviderCount := l.provider_cnt;
    end;

    psum_recs := project(pmt_recs, proj_trans(left));
    return psum_recs;

  end;

  // ---------------------------------------------------------------------------
  // exported functions
  // ---------------------------------------------------------------------------
  // will return an empty iesp.smallbusinessbipcombinedreport.t_B2BTradeData row
  export compose_b2b_trade_data_nohit(string code = '', string msg = '') := function

    iesp.smallbusinessbipcombinedreport.t_B2BTradeData trans_err() := transform
      self.StatusCode := code;
      self.StatusDescription := msg;
      self := [];
    end;

    return dataset([trans_err()]);

  end;

  // returns a single row of iesp.smallbusinessbipcombinedreport.t_B2BTradeData
  export compose_b2b_trade_data() := function

    any_records := exists(rawTradelineRecs);

    sum_recs := compose_trade_summary(active_age_days);

    cur_pmt_recs := compose_payment_summary(active_age_days);
    pmt_recs := compose_payment_summary(0, payment_age_months);
    pmt24_recs := compose_payment_summary(0, 24);

    seg_recs := compose_segment_summary(daysLimitedRecs(active_age_days));
    acct_d_recs := compose_account_summary(tradelineRecsSorted, active_age_days);

    // used to get the most recent trade date in any account
    recent_trade_recs := sort(acct_recs, _age_days);

    // note that the uniqueid in the inputs is not supported in this function,
    // therefore the first uniqueid is implicity used for the results
    iesp.smallbusinessbipcombinedreport.t_B2BTradeData trans() := transform
      self.RecentTradeDate := iesp.ECL2ESP.toDatestring8(recent_trade_recs[1].ar_date);
      self.TradeSummary := sum_recs[1];
      self.CurrentPaymentSummary := cur_pmt_recs[1];
      self.PaymentSummary := pmt_recs[1];
      self.Payment24MonthHistory := pmt24_recs[1];
      self.IndustrySegments := choosen(seg_recs, iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CTL_SEGMENTS);
      self.AccountDetails := choosen(acct_d_recs, iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CTL_ACCTS);
      self.StatusCode := '0';     // StatusCode 0 indicates successful data hit
      self := [];
    end;

    b2b_match := dataset([trans()]);
    b2b_nomatch := compose_b2b_trade_data_nohit((string)AutoKeyI.errorcodes._codes.NO_RECORDS,
      'No Tradeline Data Available');

    // if no tradeline data exists in the key for the input, ensure a status of NO_RECORDS is returned
    b2b_out := if(any_records, b2b_match, b2b_nomatch);

    return b2b_out;

  end;

end;
