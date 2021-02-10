//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Tradeline(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate _load__date_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nkdate _cycle__end__date_;
    KEL.typ.nstr _segment__identifier_;
    KEL.typ.nstr _file__segment__num_;
    KEL.typ.nstr _parent__sequence__number_;
    KEL.typ.nstr _account__holder__business__name_;
    KEL.typ.nstr _dba_;
    KEL.typ.nstr _company__website_;
    KEL.typ.nint _legal__business__structure_;
    KEL.typ.nkdate _business__established__date_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nstr _account__status__1_;
    KEL.typ.nstr _account__status__2_;
    KEL.typ.nkdate _date__account__opened_;
    KEL.typ.nkdate _date__account__closed_;
    KEL.typ.nstr _account__closure__basis_;
    KEL.typ.nkdate _account__expiration__date_;
    KEL.typ.nkdate _last__activity__date_;
    KEL.typ.nstr _last__activity__type_;
    KEL.typ.nstr _recent__activity__indicator_;
    KEL.typ.nint _original__credit__limit_;
    KEL.typ.nint _highest__credit__used_;
    KEL.typ.nint _current__credit__limit_;
    KEL.typ.nunk _reporting__indicator__length_;
    KEL.typ.nstr _payment__interval_;
    KEL.typ.nstr _payment__status__category_;
    KEL.typ.nint D_B_T___V5_;
    KEL.typ.nint _raw__dbt__v5_;
    KEL.typ.nstr _overall__file__format__version_;
    KEL.typ.nunk _term__of__account__in__months_;
    KEL.typ.nkdate _first__payment__due__date_;
    KEL.typ.nkdate _final__pyament__due__date_;
    KEL.typ.nunk _original__rate_;
    KEL.typ.nunk _floating__rate_;
    KEL.typ.nunk _grace__period_;
    KEL.typ.nunk _payment__category_;
    KEL.typ.nunk _payment__history__profile__12__months_;
    KEL.typ.nunk _payment__history__profile__13__24__months_;
    KEL.typ.nunk _payment__history__profile__25__36__months_;
    KEL.typ.nunk _payment__history__profile__37__48__months_;
    KEL.typ.nunk _payment__history__length_;
    KEL.typ.nunk _year__to__date__purchases__count_;
    KEL.typ.nunk _lifetime__to__date__purchases__count_;
    KEL.typ.nunk _year__to__date__purchases__sum__amount_;
    KEL.typ.nunk _lifetime__to__date__purchases__sum__amount_;
    KEL.typ.nint _payment__amount__scheduled_;
    KEL.typ.nint _recent__payment__amount_;
    KEL.typ.nkdate _recent__payment__date_;
    KEL.typ.nint _remaining__balance_;
    KEL.typ.nunk _carried__over__amount_;
    KEL.typ.nunk _new__applied__charges_;
    KEL.typ.nint _balloon__payment__due_;
    KEL.typ.nkdate _balloon__payment__due__date_;
    KEL.typ.nkdate _delinquency__date_;
    KEL.typ.nunk _days__delinquent_;
    KEL.typ.nint _past__due__amount_;
    KEL.typ.nunk _maximum__number__of__past__due__aging__amounts__buckets__provided_;
    KEL.typ.nunk _past__due__aging__bucket__type_;
    KEL.typ.nint _past__due__aging__amount__bucket__1_;
    KEL.typ.nint _past__due__aging__amount__bucket__2_;
    KEL.typ.nint _past__due__aging__amount__bucket__3_;
    KEL.typ.nint _past__due__aging__amount__bucket__4_;
    KEL.typ.nint _past__due__aging__amount__bucket__5_;
    KEL.typ.nint _past__due__aging__amount__bucket__6_;
    KEL.typ.nint _past__due__aging__amount__bucket__7_;
    KEL.typ.nunk _maximum__number__of__payment__tracking__cycle__periods__provided_;
    KEL.typ.nunk _payment__tracking__cycle__type_;
    KEL.typ.nunk _payment__tracking__cycle__0__current_;
    KEL.typ.nunk _payment__tracking__cycle__1__1__30__days_;
    KEL.typ.nunk _payment__tracking__cycle__2__31__60__days_;
    KEL.typ.nunk _payment__tracking__cycle__3__61__90__days_;
    KEL.typ.nunk _payment__tracking__cycle__4__91__120__days_;
    KEL.typ.nunk _payment__tracking__cycle__5__121__150days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__6__151__180__days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__7__181__or__greater__days_;
    KEL.typ.nkdate _date__account__was__charged__off_;
    KEL.typ.nint _amount__charged__off__by__creditor_;
    KEL.typ.nstr _charge__off__type__indicator_;
    KEL.typ.nint _total__charge__off__recoveries__to__date_;
    KEL.typ.nstr _government__guarantee__flag_;
    KEL.typ.nint _government__guarantee__category_;
    KEL.typ.nint _portion__of__account__guaranteed__by__government_;
    KEL.typ.nstr _guarantors__indicator_;
    KEL.typ.nint _number__of__guarantors_;
    KEL.typ.nstr _owners__indicator_;
    KEL.typ.nint _number__of__principals_;
    KEL.typ.nunk _account__update__deletion__indicator_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'seq_num(DEFAULT:UID),load_dateyyyymmdd(DEFAULT:_load__date_:DATE),sbfe_contributor_number(DEFAULT:_sbfe__contributor__number_:\'\'),contract_account_number(DEFAULT:_contract__account__number_:\'\'),cycle_end_date(DEFAULT:_cycle__end__date_:DATE),segment_identifier(DEFAULT:_segment__identifier_:\'\'),file_segment_num(DEFAULT:_file__segment__num_:\'\'),parent_sequence_number(DEFAULT:_parent__sequence__number_:\'\'),account_holder_business_name(DEFAULT:_account__holder__business__name_:\'\'),dba(DEFAULT:_dba_:\'\'),company_website(DEFAULT:_company__website_:\'\'),legal_business_structure(DEFAULT:_legal__business__structure_:\'\'),business_established_date(DEFAULT:_business__established__date_:DATE),account_type_reported(DEFAULT:_account__type__reported_:0),account_status_1(DEFAULT:_account__status__1_:\'\'),account_status_2(DEFAULT:_account__status__2_:\'\'),date_account_opened(DEFAULT:_date__account__opened_:DATE),date_account_closed(DEFAULT:_date__account__closed_:DATE),account_closure_basis(DEFAULT:_account__closure__basis_:\'\'),account_expiration_date(DEFAULT:_account__expiration__date_:DATE),last_activity_date(DEFAULT:_last__activity__date_:DATE),last_activity_type(DEFAULT:_last__activity__type_:\'\'),recent_activity_indicator(DEFAULT:_recent__activity__indicator_:\'\'),original_credit_limit(DEFAULT:_original__credit__limit_:0),highest_credit_used(DEFAULT:_highest__credit__used_:\'\'),current_credit_limit(DEFAULT:_current__credit__limit_:0),reporting_indicator_length(DEFAULT:_reporting__indicator__length_:\'\'),payment_interval(DEFAULT:_payment__interval_:\'\'),payment_status_category(DEFAULT:_payment__status__category_:\'\'),dbt_v5(DEFAULT:D_B_T___V5_:\'\'),raw_dbt_v5(DEFAULT:_raw__dbt__v5_:\'\'),overall_file_format_version(DEFAULT:_overall__file__format__version_:\'\'),term_of_account_in_months(DEFAULT:_term__of__account__in__months_:\'\'),first_payment_due_date(DEFAULT:_first__payment__due__date_:DATE),final_pyament_due_date(DEFAULT:_final__pyament__due__date_:DATE),original_rate(DEFAULT:_original__rate_:\'\'),floating_rate(DEFAULT:_floating__rate_:\'\'),grace_period(DEFAULT:_grace__period_:\'\'),payment_category(DEFAULT:_payment__category_:\'\'),payment_history_profile_12_months(DEFAULT:_payment__history__profile__12__months_:\'\'),payment_history_profile_13_24_months(DEFAULT:_payment__history__profile__13__24__months_:\'\'),payment_history_profile_25_36_months(DEFAULT:_payment__history__profile__25__36__months_:\'\'),payment_history_profile_37_48_months(DEFAULT:_payment__history__profile__37__48__months_:\'\'),payment_history_length(DEFAULT:_payment__history__length_:\'\'),year_to_date_purchases_count(DEFAULT:_year__to__date__purchases__count_:\'\'),lifetime_to_date_purchases_count(DEFAULT:_lifetime__to__date__purchases__count_:\'\'),year_to_date_purchases_sum_amount(DEFAULT:_year__to__date__purchases__sum__amount_:\'\'),lifetime_to_date_purchases_sum_amount(DEFAULT:_lifetime__to__date__purchases__sum__amount_:\'\'),payment_amount_scheduled(DEFAULT:_payment__amount__scheduled_:\'\'),recent_payment_amount(DEFAULT:_recent__payment__amount_:\'\'),recent_payment_date(DEFAULT:_recent__payment__date_:DATE),remaining_balance(DEFAULT:_remaining__balance_:\'\'),carried_over_amount(DEFAULT:_carried__over__amount_:\'\'),new_applied_charges(DEFAULT:_new__applied__charges_:\'\'),balloon_payment_due(DEFAULT:_balloon__payment__due_:0),balloon_payment_due_date(DEFAULT:_balloon__payment__due__date_:DATE),delinquency_date(DEFAULT:_delinquency__date_:DATE),days_delinquent(DEFAULT:_days__delinquent_:\'\'),past_due_amount(DEFAULT:_past__due__amount_:\'\'),maximum_number_of_past_due_aging_amounts_buckets_provided(DEFAULT:_maximum__number__of__past__due__aging__amounts__buckets__provided_:\'\'),past_due_aging_bucket_type(DEFAULT:_past__due__aging__bucket__type_:\'\'),past_due_aging_amount_bucket_1(DEFAULT:_past__due__aging__amount__bucket__1_:\'\'),past_due_aging_amount_bucket_2(DEFAULT:_past__due__aging__amount__bucket__2_:\'\'),past_due_aging_amount_bucket_3(DEFAULT:_past__due__aging__amount__bucket__3_:\'\'),past_due_aging_amount_bucket_4(DEFAULT:_past__due__aging__amount__bucket__4_:\'\'),past_due_aging_amount_bucket_5(DEFAULT:_past__due__aging__amount__bucket__5_:\'\'),past_due_aging_amount_bucket_6(DEFAULT:_past__due__aging__amount__bucket__6_:\'\'),past_due_aging_amount_bucket_7(DEFAULT:_past__due__aging__amount__bucket__7_:\'\'),maximum_number_of_payment_tracking_cycle_periods_provided(DEFAULT:_maximum__number__of__payment__tracking__cycle__periods__provided_:\'\'),payment_tracking_cycle_type(DEFAULT:_payment__tracking__cycle__type_:\'\'),payment_tracking_cycle_0_current(DEFAULT:_payment__tracking__cycle__0__current_:\'\'),payment_tracking_cycle_1_1_30_days(DEFAULT:_payment__tracking__cycle__1__1__30__days_:\'\'),payment_tracking_cycle_2_31_60_days(DEFAULT:_payment__tracking__cycle__2__31__60__days_:\'\'),payment_tracking_cycle_3_61_90_days(DEFAULT:_payment__tracking__cycle__3__61__90__days_:\'\'),payment_tracking_cycle_4_91_120_days(DEFAULT:_payment__tracking__cycle__4__91__120__days_:\'\'),payment_tracking_cycle_5_121_150days(DEFAULT:_payment__tracking__cycle__5__121__150days_:\'\'),payment_tracking_number_of_times_cycle_6_151_180_days(DEFAULT:_payment__tracking__number__of__times__cycle__6__151__180__days_:\'\'),payment_tracking_number_of_times_cycle_7_181_or_greater_days(DEFAULT:_payment__tracking__number__of__times__cycle__7__181__or__greater__days_:\'\'),date_account_was_charged_off(DEFAULT:_date__account__was__charged__off_:DATE),amount_charged_off_by_creditor(DEFAULT:_amount__charged__off__by__creditor_:\'\'),charge_off_type_indicator(DEFAULT:_charge__off__type__indicator_:\'\'),total_charge_off_recoveries_to_date(DEFAULT:_total__charge__off__recoveries__to__date_:0),government_guarantee_flag(DEFAULT:_government__guarantee__flag_:\'\'),government_guarantee_category(DEFAULT:_government__guarantee__category_:0),portion_of_account_guaranteed_by_government(DEFAULT:_portion__of__account__guaranteed__by__government_:\'\'),guarantors_indicator(DEFAULT:_guarantors__indicator_:\'\'),number_of_guarantors(DEFAULT:_number__of__guarantors_:\'\'),owners_indicator(DEFAULT:_owners__indicator_:\'\'),number_of_principals(DEFAULT:_number__of__principals_:\'\'),account_update_deletion_indicator(DEFAULT:_account__update__deletion__indicator_:\'\')';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Tradelines,TRANSFORM(RECORDOF(__in.Tradelines),SELF:=RIGHT));
  EXPORT Business_Credit_KEL_File_SBFE_temp_Tradelines_Invalid := __d0_Norm((KEL.typ.uid)seq_num = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)seq_num <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate _load__date_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nkdate _cycle__end__date_;
    KEL.typ.nstr _segment__identifier_;
    KEL.typ.nstr _file__segment__num_;
    KEL.typ.nstr _parent__sequence__number_;
    KEL.typ.nstr _account__holder__business__name_;
    KEL.typ.nstr _dba_;
    KEL.typ.nstr _company__website_;
    KEL.typ.nint _legal__business__structure_;
    KEL.typ.nkdate _business__established__date_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nstr _account__status__1_;
    KEL.typ.nstr _account__status__2_;
    KEL.typ.nkdate _date__account__opened_;
    KEL.typ.nkdate _date__account__closed_;
    KEL.typ.nstr _account__closure__basis_;
    KEL.typ.nkdate _account__expiration__date_;
    KEL.typ.nkdate _last__activity__date_;
    KEL.typ.nstr _last__activity__type_;
    KEL.typ.nstr _recent__activity__indicator_;
    KEL.typ.nint _original__credit__limit_;
    KEL.typ.nint _highest__credit__used_;
    KEL.typ.nint _current__credit__limit_;
    KEL.typ.nunk _reporting__indicator__length_;
    KEL.typ.nstr _payment__interval_;
    KEL.typ.nstr _payment__status__category_;
    KEL.typ.nint D_B_T___V5_;
    KEL.typ.nint _raw__dbt__v5_;
    KEL.typ.nstr _overall__file__format__version_;
    KEL.typ.nunk _term__of__account__in__months_;
    KEL.typ.nkdate _first__payment__due__date_;
    KEL.typ.nkdate _final__pyament__due__date_;
    KEL.typ.nunk _original__rate_;
    KEL.typ.nunk _floating__rate_;
    KEL.typ.nunk _grace__period_;
    KEL.typ.nunk _payment__category_;
    KEL.typ.nunk _payment__history__profile__12__months_;
    KEL.typ.nunk _payment__history__profile__13__24__months_;
    KEL.typ.nunk _payment__history__profile__25__36__months_;
    KEL.typ.nunk _payment__history__profile__37__48__months_;
    KEL.typ.nunk _payment__history__length_;
    KEL.typ.nunk _year__to__date__purchases__count_;
    KEL.typ.nunk _lifetime__to__date__purchases__count_;
    KEL.typ.nunk _year__to__date__purchases__sum__amount_;
    KEL.typ.nunk _lifetime__to__date__purchases__sum__amount_;
    KEL.typ.nint _payment__amount__scheduled_;
    KEL.typ.nint _recent__payment__amount_;
    KEL.typ.nkdate _recent__payment__date_;
    KEL.typ.nint _remaining__balance_;
    KEL.typ.nunk _carried__over__amount_;
    KEL.typ.nunk _new__applied__charges_;
    KEL.typ.nint _balloon__payment__due_;
    KEL.typ.nkdate _balloon__payment__due__date_;
    KEL.typ.nkdate _delinquency__date_;
    KEL.typ.nunk _days__delinquent_;
    KEL.typ.nint _past__due__amount_;
    KEL.typ.nunk _maximum__number__of__past__due__aging__amounts__buckets__provided_;
    KEL.typ.nunk _past__due__aging__bucket__type_;
    KEL.typ.nint _past__due__aging__amount__bucket__1_;
    KEL.typ.nint _past__due__aging__amount__bucket__2_;
    KEL.typ.nint _past__due__aging__amount__bucket__3_;
    KEL.typ.nint _past__due__aging__amount__bucket__4_;
    KEL.typ.nint _past__due__aging__amount__bucket__5_;
    KEL.typ.nint _past__due__aging__amount__bucket__6_;
    KEL.typ.nint _past__due__aging__amount__bucket__7_;
    KEL.typ.nunk _maximum__number__of__payment__tracking__cycle__periods__provided_;
    KEL.typ.nunk _payment__tracking__cycle__type_;
    KEL.typ.nunk _payment__tracking__cycle__0__current_;
    KEL.typ.nunk _payment__tracking__cycle__1__1__30__days_;
    KEL.typ.nunk _payment__tracking__cycle__2__31__60__days_;
    KEL.typ.nunk _payment__tracking__cycle__3__61__90__days_;
    KEL.typ.nunk _payment__tracking__cycle__4__91__120__days_;
    KEL.typ.nunk _payment__tracking__cycle__5__121__150days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__6__151__180__days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__7__181__or__greater__days_;
    KEL.typ.nkdate _date__account__was__charged__off_;
    KEL.typ.nint _amount__charged__off__by__creditor_;
    KEL.typ.nstr _charge__off__type__indicator_;
    KEL.typ.nint _total__charge__off__recoveries__to__date_;
    KEL.typ.nstr _government__guarantee__flag_;
    KEL.typ.nint _government__guarantee__category_;
    KEL.typ.nint _portion__of__account__guaranteed__by__government_;
    KEL.typ.nstr _guarantors__indicator_;
    KEL.typ.nint _number__of__guarantors_;
    KEL.typ.nstr _owners__indicator_;
    KEL.typ.nint _number__of__principals_;
    KEL.typ.nunk _account__update__deletion__indicator_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Tradeline_Group := __PostFilter;
  Layout Tradeline__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._load__date_ := KEL.Intake.SingleValue(__recs,_load__date_);
    SELF._sbfe__contributor__number_ := KEL.Intake.SingleValue(__recs,_sbfe__contributor__number_);
    SELF._contract__account__number_ := KEL.Intake.SingleValue(__recs,_contract__account__number_);
    SELF._cycle__end__date_ := KEL.Intake.SingleValue(__recs,_cycle__end__date_);
    SELF._segment__identifier_ := KEL.Intake.SingleValue(__recs,_segment__identifier_);
    SELF._file__segment__num_ := KEL.Intake.SingleValue(__recs,_file__segment__num_);
    SELF._parent__sequence__number_ := KEL.Intake.SingleValue(__recs,_parent__sequence__number_);
    SELF._account__holder__business__name_ := KEL.Intake.SingleValue(__recs,_account__holder__business__name_);
    SELF._dba_ := KEL.Intake.SingleValue(__recs,_dba_);
    SELF._company__website_ := KEL.Intake.SingleValue(__recs,_company__website_);
    SELF._legal__business__structure_ := KEL.Intake.SingleValue(__recs,_legal__business__structure_);
    SELF._business__established__date_ := KEL.Intake.SingleValue(__recs,_business__established__date_);
    SELF._account__type__reported_ := KEL.Intake.SingleValue(__recs,_account__type__reported_);
    SELF._account__status__1_ := KEL.Intake.SingleValue(__recs,_account__status__1_);
    SELF._account__status__2_ := KEL.Intake.SingleValue(__recs,_account__status__2_);
    SELF._date__account__opened_ := KEL.Intake.SingleValue(__recs,_date__account__opened_);
    SELF._date__account__closed_ := KEL.Intake.SingleValue(__recs,_date__account__closed_);
    SELF._account__closure__basis_ := KEL.Intake.SingleValue(__recs,_account__closure__basis_);
    SELF._account__expiration__date_ := KEL.Intake.SingleValue(__recs,_account__expiration__date_);
    SELF._last__activity__date_ := KEL.Intake.SingleValue(__recs,_last__activity__date_);
    SELF._last__activity__type_ := KEL.Intake.SingleValue(__recs,_last__activity__type_);
    SELF._recent__activity__indicator_ := KEL.Intake.SingleValue(__recs,_recent__activity__indicator_);
    SELF._original__credit__limit_ := KEL.Intake.SingleValue(__recs,_original__credit__limit_);
    SELF._highest__credit__used_ := KEL.Intake.SingleValue(__recs,_highest__credit__used_);
    SELF._current__credit__limit_ := KEL.Intake.SingleValue(__recs,_current__credit__limit_);
    SELF._reporting__indicator__length_ := KEL.Intake.SingleValue(__recs,_reporting__indicator__length_);
    SELF._payment__interval_ := KEL.Intake.SingleValue(__recs,_payment__interval_);
    SELF._payment__status__category_ := KEL.Intake.SingleValue(__recs,_payment__status__category_);
    SELF.D_B_T___V5_ := KEL.Intake.SingleValue(__recs,D_B_T___V5_);
    SELF._raw__dbt__v5_ := KEL.Intake.SingleValue(__recs,_raw__dbt__v5_);
    SELF._overall__file__format__version_ := KEL.Intake.SingleValue(__recs,_overall__file__format__version_);
    SELF._term__of__account__in__months_ := KEL.Intake.SingleValue(__recs,_term__of__account__in__months_);
    SELF._first__payment__due__date_ := KEL.Intake.SingleValue(__recs,_first__payment__due__date_);
    SELF._final__pyament__due__date_ := KEL.Intake.SingleValue(__recs,_final__pyament__due__date_);
    SELF._original__rate_ := KEL.Intake.SingleValue(__recs,_original__rate_);
    SELF._floating__rate_ := KEL.Intake.SingleValue(__recs,_floating__rate_);
    SELF._grace__period_ := KEL.Intake.SingleValue(__recs,_grace__period_);
    SELF._payment__category_ := KEL.Intake.SingleValue(__recs,_payment__category_);
    SELF._payment__history__profile__12__months_ := KEL.Intake.SingleValue(__recs,_payment__history__profile__12__months_);
    SELF._payment__history__profile__13__24__months_ := KEL.Intake.SingleValue(__recs,_payment__history__profile__13__24__months_);
    SELF._payment__history__profile__25__36__months_ := KEL.Intake.SingleValue(__recs,_payment__history__profile__25__36__months_);
    SELF._payment__history__profile__37__48__months_ := KEL.Intake.SingleValue(__recs,_payment__history__profile__37__48__months_);
    SELF._payment__history__length_ := KEL.Intake.SingleValue(__recs,_payment__history__length_);
    SELF._year__to__date__purchases__count_ := KEL.Intake.SingleValue(__recs,_year__to__date__purchases__count_);
    SELF._lifetime__to__date__purchases__count_ := KEL.Intake.SingleValue(__recs,_lifetime__to__date__purchases__count_);
    SELF._year__to__date__purchases__sum__amount_ := KEL.Intake.SingleValue(__recs,_year__to__date__purchases__sum__amount_);
    SELF._lifetime__to__date__purchases__sum__amount_ := KEL.Intake.SingleValue(__recs,_lifetime__to__date__purchases__sum__amount_);
    SELF._payment__amount__scheduled_ := KEL.Intake.SingleValue(__recs,_payment__amount__scheduled_);
    SELF._recent__payment__amount_ := KEL.Intake.SingleValue(__recs,_recent__payment__amount_);
    SELF._recent__payment__date_ := KEL.Intake.SingleValue(__recs,_recent__payment__date_);
    SELF._remaining__balance_ := KEL.Intake.SingleValue(__recs,_remaining__balance_);
    SELF._carried__over__amount_ := KEL.Intake.SingleValue(__recs,_carried__over__amount_);
    SELF._new__applied__charges_ := KEL.Intake.SingleValue(__recs,_new__applied__charges_);
    SELF._balloon__payment__due_ := KEL.Intake.SingleValue(__recs,_balloon__payment__due_);
    SELF._balloon__payment__due__date_ := KEL.Intake.SingleValue(__recs,_balloon__payment__due__date_);
    SELF._delinquency__date_ := KEL.Intake.SingleValue(__recs,_delinquency__date_);
    SELF._days__delinquent_ := KEL.Intake.SingleValue(__recs,_days__delinquent_);
    SELF._past__due__amount_ := KEL.Intake.SingleValue(__recs,_past__due__amount_);
    SELF._maximum__number__of__past__due__aging__amounts__buckets__provided_ := KEL.Intake.SingleValue(__recs,_maximum__number__of__past__due__aging__amounts__buckets__provided_);
    SELF._past__due__aging__bucket__type_ := KEL.Intake.SingleValue(__recs,_past__due__aging__bucket__type_);
    SELF._past__due__aging__amount__bucket__1_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__1_);
    SELF._past__due__aging__amount__bucket__2_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__2_);
    SELF._past__due__aging__amount__bucket__3_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__3_);
    SELF._past__due__aging__amount__bucket__4_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__4_);
    SELF._past__due__aging__amount__bucket__5_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__5_);
    SELF._past__due__aging__amount__bucket__6_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__6_);
    SELF._past__due__aging__amount__bucket__7_ := KEL.Intake.SingleValue(__recs,_past__due__aging__amount__bucket__7_);
    SELF._maximum__number__of__payment__tracking__cycle__periods__provided_ := KEL.Intake.SingleValue(__recs,_maximum__number__of__payment__tracking__cycle__periods__provided_);
    SELF._payment__tracking__cycle__type_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__type_);
    SELF._payment__tracking__cycle__0__current_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__0__current_);
    SELF._payment__tracking__cycle__1__1__30__days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__1__1__30__days_);
    SELF._payment__tracking__cycle__2__31__60__days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__2__31__60__days_);
    SELF._payment__tracking__cycle__3__61__90__days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__3__61__90__days_);
    SELF._payment__tracking__cycle__4__91__120__days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__4__91__120__days_);
    SELF._payment__tracking__cycle__5__121__150days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__cycle__5__121__150days_);
    SELF._payment__tracking__number__of__times__cycle__6__151__180__days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__number__of__times__cycle__6__151__180__days_);
    SELF._payment__tracking__number__of__times__cycle__7__181__or__greater__days_ := KEL.Intake.SingleValue(__recs,_payment__tracking__number__of__times__cycle__7__181__or__greater__days_);
    SELF._date__account__was__charged__off_ := KEL.Intake.SingleValue(__recs,_date__account__was__charged__off_);
    SELF._amount__charged__off__by__creditor_ := KEL.Intake.SingleValue(__recs,_amount__charged__off__by__creditor_);
    SELF._charge__off__type__indicator_ := KEL.Intake.SingleValue(__recs,_charge__off__type__indicator_);
    SELF._total__charge__off__recoveries__to__date_ := KEL.Intake.SingleValue(__recs,_total__charge__off__recoveries__to__date_);
    SELF._government__guarantee__flag_ := KEL.Intake.SingleValue(__recs,_government__guarantee__flag_);
    SELF._government__guarantee__category_ := KEL.Intake.SingleValue(__recs,_government__guarantee__category_);
    SELF._portion__of__account__guaranteed__by__government_ := KEL.Intake.SingleValue(__recs,_portion__of__account__guaranteed__by__government_);
    SELF._guarantors__indicator_ := KEL.Intake.SingleValue(__recs,_guarantors__indicator_);
    SELF._number__of__guarantors_ := KEL.Intake.SingleValue(__recs,_number__of__guarantors_);
    SELF._owners__indicator_ := KEL.Intake.SingleValue(__recs,_owners__indicator_);
    SELF._number__of__principals_ := KEL.Intake.SingleValue(__recs,_number__of__principals_);
    SELF._account__update__deletion__indicator_ := KEL.Intake.SingleValue(__recs,_account__update__deletion__indicator_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Tradeline__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Tradeline_Group,COUNT(ROWS(LEFT))=1),GROUP,Tradeline__Single_Rollup(LEFT)) + ROLLUP(HAVING(Tradeline_Group,COUNT(ROWS(LEFT))>1),GROUP,Tradeline__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT _load__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_load__date_);
  EXPORT _sbfe__contributor__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_sbfe__contributor__number_);
  EXPORT _contract__account__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_contract__account__number_);
  EXPORT _cycle__end__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_cycle__end__date_);
  EXPORT _segment__identifier__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_segment__identifier_);
  EXPORT _file__segment__num__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_file__segment__num_);
  EXPORT _parent__sequence__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_parent__sequence__number_);
  EXPORT _account__holder__business__name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__holder__business__name_);
  EXPORT _dba__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dba_);
  EXPORT _company__website__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_company__website_);
  EXPORT _legal__business__structure__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_legal__business__structure_);
  EXPORT _business__established__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_business__established__date_);
  EXPORT _account__type__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__type__reported_);
  EXPORT _account__status__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__status__1_);
  EXPORT _account__status__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__status__2_);
  EXPORT _date__account__opened__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_date__account__opened_);
  EXPORT _date__account__closed__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_date__account__closed_);
  EXPORT _account__closure__basis__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__closure__basis_);
  EXPORT _account__expiration__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__expiration__date_);
  EXPORT _last__activity__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_last__activity__date_);
  EXPORT _last__activity__type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_last__activity__type_);
  EXPORT _recent__activity__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_recent__activity__indicator_);
  EXPORT _original__credit__limit__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_original__credit__limit_);
  EXPORT _highest__credit__used__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_highest__credit__used_);
  EXPORT _current__credit__limit__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_current__credit__limit_);
  EXPORT _reporting__indicator__length__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_reporting__indicator__length_);
  EXPORT _payment__interval__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__interval_);
  EXPORT _payment__status__category__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__status__category_);
  EXPORT D_B_T___V5__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,D_B_T___V5_);
  EXPORT _raw__dbt__v5__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_raw__dbt__v5_);
  EXPORT _overall__file__format__version__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_overall__file__format__version_);
  EXPORT _term__of__account__in__months__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_term__of__account__in__months_);
  EXPORT _first__payment__due__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_first__payment__due__date_);
  EXPORT _final__pyament__due__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_final__pyament__due__date_);
  EXPORT _original__rate__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_original__rate_);
  EXPORT _floating__rate__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_floating__rate_);
  EXPORT _grace__period__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_grace__period_);
  EXPORT _payment__category__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__category_);
  EXPORT _payment__history__profile__12__months__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__history__profile__12__months_);
  EXPORT _payment__history__profile__13__24__months__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__history__profile__13__24__months_);
  EXPORT _payment__history__profile__25__36__months__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__history__profile__25__36__months_);
  EXPORT _payment__history__profile__37__48__months__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__history__profile__37__48__months_);
  EXPORT _payment__history__length__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__history__length_);
  EXPORT _year__to__date__purchases__count__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_year__to__date__purchases__count_);
  EXPORT _lifetime__to__date__purchases__count__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_lifetime__to__date__purchases__count_);
  EXPORT _year__to__date__purchases__sum__amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_year__to__date__purchases__sum__amount_);
  EXPORT _lifetime__to__date__purchases__sum__amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_lifetime__to__date__purchases__sum__amount_);
  EXPORT _payment__amount__scheduled__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__amount__scheduled_);
  EXPORT _recent__payment__amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_recent__payment__amount_);
  EXPORT _recent__payment__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_recent__payment__date_);
  EXPORT _remaining__balance__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_remaining__balance_);
  EXPORT _carried__over__amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_carried__over__amount_);
  EXPORT _new__applied__charges__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_new__applied__charges_);
  EXPORT _balloon__payment__due__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_balloon__payment__due_);
  EXPORT _balloon__payment__due__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_balloon__payment__due__date_);
  EXPORT _delinquency__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_delinquency__date_);
  EXPORT _days__delinquent__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_days__delinquent_);
  EXPORT _past__due__amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__amount_);
  EXPORT _maximum__number__of__past__due__aging__amounts__buckets__provided__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_maximum__number__of__past__due__aging__amounts__buckets__provided_);
  EXPORT _past__due__aging__bucket__type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__bucket__type_);
  EXPORT _past__due__aging__amount__bucket__1__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__1_);
  EXPORT _past__due__aging__amount__bucket__2__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__2_);
  EXPORT _past__due__aging__amount__bucket__3__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__3_);
  EXPORT _past__due__aging__amount__bucket__4__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__4_);
  EXPORT _past__due__aging__amount__bucket__5__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__5_);
  EXPORT _past__due__aging__amount__bucket__6__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__6_);
  EXPORT _past__due__aging__amount__bucket__7__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_past__due__aging__amount__bucket__7_);
  EXPORT _maximum__number__of__payment__tracking__cycle__periods__provided__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_maximum__number__of__payment__tracking__cycle__periods__provided_);
  EXPORT _payment__tracking__cycle__type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__type_);
  EXPORT _payment__tracking__cycle__0__current__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__0__current_);
  EXPORT _payment__tracking__cycle__1__1__30__days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__1__1__30__days_);
  EXPORT _payment__tracking__cycle__2__31__60__days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__2__31__60__days_);
  EXPORT _payment__tracking__cycle__3__61__90__days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__3__61__90__days_);
  EXPORT _payment__tracking__cycle__4__91__120__days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__4__91__120__days_);
  EXPORT _payment__tracking__cycle__5__121__150days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__cycle__5__121__150days_);
  EXPORT _payment__tracking__number__of__times__cycle__6__151__180__days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__number__of__times__cycle__6__151__180__days_);
  EXPORT _payment__tracking__number__of__times__cycle__7__181__or__greater__days__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_payment__tracking__number__of__times__cycle__7__181__or__greater__days_);
  EXPORT _date__account__was__charged__off__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_date__account__was__charged__off_);
  EXPORT _amount__charged__off__by__creditor__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_amount__charged__off__by__creditor_);
  EXPORT _charge__off__type__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_charge__off__type__indicator_);
  EXPORT _total__charge__off__recoveries__to__date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_total__charge__off__recoveries__to__date_);
  EXPORT _government__guarantee__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_government__guarantee__flag_);
  EXPORT _government__guarantee__category__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_government__guarantee__category_);
  EXPORT _portion__of__account__guaranteed__by__government__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_portion__of__account__guaranteed__by__government_);
  EXPORT _guarantors__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_guarantors__indicator_);
  EXPORT _number__of__guarantors__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_number__of__guarantors_);
  EXPORT _owners__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_owners__indicator_);
  EXPORT _number__of__principals__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_number__of__principals_);
  EXPORT _account__update__deletion__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__update__deletion__indicator_);
  EXPORT SanityCheck := DATASET([{COUNT(Business_Credit_KEL_File_SBFE_temp_Tradelines_Invalid),COUNT(_load__date__SingleValue_Invalid),COUNT(_sbfe__contributor__number__SingleValue_Invalid),COUNT(_contract__account__number__SingleValue_Invalid),COUNT(_cycle__end__date__SingleValue_Invalid),COUNT(_segment__identifier__SingleValue_Invalid),COUNT(_file__segment__num__SingleValue_Invalid),COUNT(_parent__sequence__number__SingleValue_Invalid),COUNT(_account__holder__business__name__SingleValue_Invalid),COUNT(_dba__SingleValue_Invalid),COUNT(_company__website__SingleValue_Invalid),COUNT(_legal__business__structure__SingleValue_Invalid),COUNT(_business__established__date__SingleValue_Invalid),COUNT(_account__type__reported__SingleValue_Invalid),COUNT(_account__status__1__SingleValue_Invalid),COUNT(_account__status__2__SingleValue_Invalid),COUNT(_date__account__opened__SingleValue_Invalid),COUNT(_date__account__closed__SingleValue_Invalid),COUNT(_account__closure__basis__SingleValue_Invalid),COUNT(_account__expiration__date__SingleValue_Invalid),COUNT(_last__activity__date__SingleValue_Invalid),COUNT(_last__activity__type__SingleValue_Invalid),COUNT(_recent__activity__indicator__SingleValue_Invalid),COUNT(_original__credit__limit__SingleValue_Invalid),COUNT(_highest__credit__used__SingleValue_Invalid),COUNT(_current__credit__limit__SingleValue_Invalid),COUNT(_reporting__indicator__length__SingleValue_Invalid),COUNT(_payment__interval__SingleValue_Invalid),COUNT(_payment__status__category__SingleValue_Invalid),COUNT(D_B_T___V5__SingleValue_Invalid),COUNT(_raw__dbt__v5__SingleValue_Invalid),COUNT(_overall__file__format__version__SingleValue_Invalid),COUNT(_term__of__account__in__months__SingleValue_Invalid),COUNT(_first__payment__due__date__SingleValue_Invalid),COUNT(_final__pyament__due__date__SingleValue_Invalid),COUNT(_original__rate__SingleValue_Invalid),COUNT(_floating__rate__SingleValue_Invalid),COUNT(_grace__period__SingleValue_Invalid),COUNT(_payment__category__SingleValue_Invalid),COUNT(_payment__history__profile__12__months__SingleValue_Invalid),COUNT(_payment__history__profile__13__24__months__SingleValue_Invalid),COUNT(_payment__history__profile__25__36__months__SingleValue_Invalid),COUNT(_payment__history__profile__37__48__months__SingleValue_Invalid),COUNT(_payment__history__length__SingleValue_Invalid),COUNT(_year__to__date__purchases__count__SingleValue_Invalid),COUNT(_lifetime__to__date__purchases__count__SingleValue_Invalid),COUNT(_year__to__date__purchases__sum__amount__SingleValue_Invalid),COUNT(_lifetime__to__date__purchases__sum__amount__SingleValue_Invalid),COUNT(_payment__amount__scheduled__SingleValue_Invalid),COUNT(_recent__payment__amount__SingleValue_Invalid),COUNT(_recent__payment__date__SingleValue_Invalid),COUNT(_remaining__balance__SingleValue_Invalid),COUNT(_carried__over__amount__SingleValue_Invalid),COUNT(_new__applied__charges__SingleValue_Invalid),COUNT(_balloon__payment__due__SingleValue_Invalid),COUNT(_balloon__payment__due__date__SingleValue_Invalid),COUNT(_delinquency__date__SingleValue_Invalid),COUNT(_days__delinquent__SingleValue_Invalid),COUNT(_past__due__amount__SingleValue_Invalid),COUNT(_maximum__number__of__past__due__aging__amounts__buckets__provided__SingleValue_Invalid),COUNT(_past__due__aging__bucket__type__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__1__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__2__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__3__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__4__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__5__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__6__SingleValue_Invalid),COUNT(_past__due__aging__amount__bucket__7__SingleValue_Invalid),COUNT(_maximum__number__of__payment__tracking__cycle__periods__provided__SingleValue_Invalid),COUNT(_payment__tracking__cycle__type__SingleValue_Invalid),COUNT(_payment__tracking__cycle__0__current__SingleValue_Invalid),COUNT(_payment__tracking__cycle__1__1__30__days__SingleValue_Invalid),COUNT(_payment__tracking__cycle__2__31__60__days__SingleValue_Invalid),COUNT(_payment__tracking__cycle__3__61__90__days__SingleValue_Invalid),COUNT(_payment__tracking__cycle__4__91__120__days__SingleValue_Invalid),COUNT(_payment__tracking__cycle__5__121__150days__SingleValue_Invalid),COUNT(_payment__tracking__number__of__times__cycle__6__151__180__days__SingleValue_Invalid),COUNT(_payment__tracking__number__of__times__cycle__7__181__or__greater__days__SingleValue_Invalid),COUNT(_date__account__was__charged__off__SingleValue_Invalid),COUNT(_amount__charged__off__by__creditor__SingleValue_Invalid),COUNT(_charge__off__type__indicator__SingleValue_Invalid),COUNT(_total__charge__off__recoveries__to__date__SingleValue_Invalid),COUNT(_government__guarantee__flag__SingleValue_Invalid),COUNT(_government__guarantee__category__SingleValue_Invalid),COUNT(_portion__of__account__guaranteed__by__government__SingleValue_Invalid),COUNT(_guarantors__indicator__SingleValue_Invalid),COUNT(_number__of__guarantors__SingleValue_Invalid),COUNT(_owners__indicator__SingleValue_Invalid),COUNT(_number__of__principals__SingleValue_Invalid),COUNT(_account__update__deletion__indicator__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Business_Credit_KEL_File_SBFE_temp_Tradelines_Invalid,KEL.typ.int _load__date__SingleValue_Invalid,KEL.typ.int _sbfe__contributor__number__SingleValue_Invalid,KEL.typ.int _contract__account__number__SingleValue_Invalid,KEL.typ.int _cycle__end__date__SingleValue_Invalid,KEL.typ.int _segment__identifier__SingleValue_Invalid,KEL.typ.int _file__segment__num__SingleValue_Invalid,KEL.typ.int _parent__sequence__number__SingleValue_Invalid,KEL.typ.int _account__holder__business__name__SingleValue_Invalid,KEL.typ.int _dba__SingleValue_Invalid,KEL.typ.int _company__website__SingleValue_Invalid,KEL.typ.int _legal__business__structure__SingleValue_Invalid,KEL.typ.int _business__established__date__SingleValue_Invalid,KEL.typ.int _account__type__reported__SingleValue_Invalid,KEL.typ.int _account__status__1__SingleValue_Invalid,KEL.typ.int _account__status__2__SingleValue_Invalid,KEL.typ.int _date__account__opened__SingleValue_Invalid,KEL.typ.int _date__account__closed__SingleValue_Invalid,KEL.typ.int _account__closure__basis__SingleValue_Invalid,KEL.typ.int _account__expiration__date__SingleValue_Invalid,KEL.typ.int _last__activity__date__SingleValue_Invalid,KEL.typ.int _last__activity__type__SingleValue_Invalid,KEL.typ.int _recent__activity__indicator__SingleValue_Invalid,KEL.typ.int _original__credit__limit__SingleValue_Invalid,KEL.typ.int _highest__credit__used__SingleValue_Invalid,KEL.typ.int _current__credit__limit__SingleValue_Invalid,KEL.typ.int _reporting__indicator__length__SingleValue_Invalid,KEL.typ.int _payment__interval__SingleValue_Invalid,KEL.typ.int _payment__status__category__SingleValue_Invalid,KEL.typ.int D_B_T___V5__SingleValue_Invalid,KEL.typ.int _raw__dbt__v5__SingleValue_Invalid,KEL.typ.int _overall__file__format__version__SingleValue_Invalid,KEL.typ.int _term__of__account__in__months__SingleValue_Invalid,KEL.typ.int _first__payment__due__date__SingleValue_Invalid,KEL.typ.int _final__pyament__due__date__SingleValue_Invalid,KEL.typ.int _original__rate__SingleValue_Invalid,KEL.typ.int _floating__rate__SingleValue_Invalid,KEL.typ.int _grace__period__SingleValue_Invalid,KEL.typ.int _payment__category__SingleValue_Invalid,KEL.typ.int _payment__history__profile__12__months__SingleValue_Invalid,KEL.typ.int _payment__history__profile__13__24__months__SingleValue_Invalid,KEL.typ.int _payment__history__profile__25__36__months__SingleValue_Invalid,KEL.typ.int _payment__history__profile__37__48__months__SingleValue_Invalid,KEL.typ.int _payment__history__length__SingleValue_Invalid,KEL.typ.int _year__to__date__purchases__count__SingleValue_Invalid,KEL.typ.int _lifetime__to__date__purchases__count__SingleValue_Invalid,KEL.typ.int _year__to__date__purchases__sum__amount__SingleValue_Invalid,KEL.typ.int _lifetime__to__date__purchases__sum__amount__SingleValue_Invalid,KEL.typ.int _payment__amount__scheduled__SingleValue_Invalid,KEL.typ.int _recent__payment__amount__SingleValue_Invalid,KEL.typ.int _recent__payment__date__SingleValue_Invalid,KEL.typ.int _remaining__balance__SingleValue_Invalid,KEL.typ.int _carried__over__amount__SingleValue_Invalid,KEL.typ.int _new__applied__charges__SingleValue_Invalid,KEL.typ.int _balloon__payment__due__SingleValue_Invalid,KEL.typ.int _balloon__payment__due__date__SingleValue_Invalid,KEL.typ.int _delinquency__date__SingleValue_Invalid,KEL.typ.int _days__delinquent__SingleValue_Invalid,KEL.typ.int _past__due__amount__SingleValue_Invalid,KEL.typ.int _maximum__number__of__past__due__aging__amounts__buckets__provided__SingleValue_Invalid,KEL.typ.int _past__due__aging__bucket__type__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__1__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__2__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__3__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__4__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__5__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__6__SingleValue_Invalid,KEL.typ.int _past__due__aging__amount__bucket__7__SingleValue_Invalid,KEL.typ.int _maximum__number__of__payment__tracking__cycle__periods__provided__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__type__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__0__current__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__1__1__30__days__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__2__31__60__days__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__3__61__90__days__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__4__91__120__days__SingleValue_Invalid,KEL.typ.int _payment__tracking__cycle__5__121__150days__SingleValue_Invalid,KEL.typ.int _payment__tracking__number__of__times__cycle__6__151__180__days__SingleValue_Invalid,KEL.typ.int _payment__tracking__number__of__times__cycle__7__181__or__greater__days__SingleValue_Invalid,KEL.typ.int _date__account__was__charged__off__SingleValue_Invalid,KEL.typ.int _amount__charged__off__by__creditor__SingleValue_Invalid,KEL.typ.int _charge__off__type__indicator__SingleValue_Invalid,KEL.typ.int _total__charge__off__recoveries__to__date__SingleValue_Invalid,KEL.typ.int _government__guarantee__flag__SingleValue_Invalid,KEL.typ.int _government__guarantee__category__SingleValue_Invalid,KEL.typ.int _portion__of__account__guaranteed__by__government__SingleValue_Invalid,KEL.typ.int _guarantors__indicator__SingleValue_Invalid,KEL.typ.int _number__of__guarantors__SingleValue_Invalid,KEL.typ.int _owners__indicator__SingleValue_Invalid,KEL.typ.int _number__of__principals__SingleValue_Invalid,KEL.typ.int _account__update__deletion__indicator__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','UID',COUNT(Business_Credit_KEL_File_SBFE_temp_Tradelines_Invalid),COUNT(__d0)},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','load_dateyyyymmdd',COUNT(__d0(__NL(_load__date_))),COUNT(__d0(__NN(_load__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','sbfe_contributor_number',COUNT(__d0(__NL(_sbfe__contributor__number_))),COUNT(__d0(__NN(_sbfe__contributor__number_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','contract_account_number',COUNT(__d0(__NL(_contract__account__number_))),COUNT(__d0(__NN(_contract__account__number_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','cycle_end_date',COUNT(__d0(__NL(_cycle__end__date_))),COUNT(__d0(__NN(_cycle__end__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','segment_identifier',COUNT(__d0(__NL(_segment__identifier_))),COUNT(__d0(__NN(_segment__identifier_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','file_segment_num',COUNT(__d0(__NL(_file__segment__num_))),COUNT(__d0(__NN(_file__segment__num_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','parent_sequence_number',COUNT(__d0(__NL(_parent__sequence__number_))),COUNT(__d0(__NN(_parent__sequence__number_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_holder_business_name',COUNT(__d0(__NL(_account__holder__business__name_))),COUNT(__d0(__NN(_account__holder__business__name_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','dba',COUNT(__d0(__NL(_dba_))),COUNT(__d0(__NN(_dba_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','company_website',COUNT(__d0(__NL(_company__website_))),COUNT(__d0(__NN(_company__website_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','legal_business_structure',COUNT(__d0(__NL(_legal__business__structure_))),COUNT(__d0(__NN(_legal__business__structure_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','business_established_date',COUNT(__d0(__NL(_business__established__date_))),COUNT(__d0(__NN(_business__established__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_type_reported',COUNT(__d0(__NL(_account__type__reported_))),COUNT(__d0(__NN(_account__type__reported_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_status_1',COUNT(__d0(__NL(_account__status__1_))),COUNT(__d0(__NN(_account__status__1_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_status_2',COUNT(__d0(__NL(_account__status__2_))),COUNT(__d0(__NN(_account__status__2_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','date_account_opened',COUNT(__d0(__NL(_date__account__opened_))),COUNT(__d0(__NN(_date__account__opened_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','date_account_closed',COUNT(__d0(__NL(_date__account__closed_))),COUNT(__d0(__NN(_date__account__closed_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_closure_basis',COUNT(__d0(__NL(_account__closure__basis_))),COUNT(__d0(__NN(_account__closure__basis_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_expiration_date',COUNT(__d0(__NL(_account__expiration__date_))),COUNT(__d0(__NN(_account__expiration__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','last_activity_date',COUNT(__d0(__NL(_last__activity__date_))),COUNT(__d0(__NN(_last__activity__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','last_activity_type',COUNT(__d0(__NL(_last__activity__type_))),COUNT(__d0(__NN(_last__activity__type_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','recent_activity_indicator',COUNT(__d0(__NL(_recent__activity__indicator_))),COUNT(__d0(__NN(_recent__activity__indicator_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','original_credit_limit',COUNT(__d0(__NL(_original__credit__limit_))),COUNT(__d0(__NN(_original__credit__limit_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','highest_credit_used',COUNT(__d0(__NL(_highest__credit__used_))),COUNT(__d0(__NN(_highest__credit__used_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','current_credit_limit',COUNT(__d0(__NL(_current__credit__limit_))),COUNT(__d0(__NN(_current__credit__limit_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','reporting_indicator_length',COUNT(__d0(__NL(_reporting__indicator__length_))),COUNT(__d0(__NN(_reporting__indicator__length_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_interval',COUNT(__d0(__NL(_payment__interval_))),COUNT(__d0(__NN(_payment__interval_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_status_category',COUNT(__d0(__NL(_payment__status__category_))),COUNT(__d0(__NN(_payment__status__category_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','DBT_V5',COUNT(__d0(__NL(D_B_T___V5_))),COUNT(__d0(__NN(D_B_T___V5_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','raw_dbt_v5',COUNT(__d0(__NL(_raw__dbt__v5_))),COUNT(__d0(__NN(_raw__dbt__v5_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','overall_file_format_version',COUNT(__d0(__NL(_overall__file__format__version_))),COUNT(__d0(__NN(_overall__file__format__version_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','term_of_account_in_months',COUNT(__d0(__NL(_term__of__account__in__months_))),COUNT(__d0(__NN(_term__of__account__in__months_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','first_payment_due_date',COUNT(__d0(__NL(_first__payment__due__date_))),COUNT(__d0(__NN(_first__payment__due__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','final_pyament_due_date',COUNT(__d0(__NL(_final__pyament__due__date_))),COUNT(__d0(__NN(_final__pyament__due__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','original_rate',COUNT(__d0(__NL(_original__rate_))),COUNT(__d0(__NN(_original__rate_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','floating_rate',COUNT(__d0(__NL(_floating__rate_))),COUNT(__d0(__NN(_floating__rate_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','grace_period',COUNT(__d0(__NL(_grace__period_))),COUNT(__d0(__NN(_grace__period_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_category',COUNT(__d0(__NL(_payment__category_))),COUNT(__d0(__NN(_payment__category_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_history_profile_12_months',COUNT(__d0(__NL(_payment__history__profile__12__months_))),COUNT(__d0(__NN(_payment__history__profile__12__months_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_history_profile_13_24_months',COUNT(__d0(__NL(_payment__history__profile__13__24__months_))),COUNT(__d0(__NN(_payment__history__profile__13__24__months_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_history_profile_25_36_months',COUNT(__d0(__NL(_payment__history__profile__25__36__months_))),COUNT(__d0(__NN(_payment__history__profile__25__36__months_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_history_profile_37_48_months',COUNT(__d0(__NL(_payment__history__profile__37__48__months_))),COUNT(__d0(__NN(_payment__history__profile__37__48__months_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_history_length',COUNT(__d0(__NL(_payment__history__length_))),COUNT(__d0(__NN(_payment__history__length_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','year_to_date_purchases_count',COUNT(__d0(__NL(_year__to__date__purchases__count_))),COUNT(__d0(__NN(_year__to__date__purchases__count_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','lifetime_to_date_purchases_count',COUNT(__d0(__NL(_lifetime__to__date__purchases__count_))),COUNT(__d0(__NN(_lifetime__to__date__purchases__count_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','year_to_date_purchases_sum_amount',COUNT(__d0(__NL(_year__to__date__purchases__sum__amount_))),COUNT(__d0(__NN(_year__to__date__purchases__sum__amount_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','lifetime_to_date_purchases_sum_amount',COUNT(__d0(__NL(_lifetime__to__date__purchases__sum__amount_))),COUNT(__d0(__NN(_lifetime__to__date__purchases__sum__amount_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_amount_scheduled',COUNT(__d0(__NL(_payment__amount__scheduled_))),COUNT(__d0(__NN(_payment__amount__scheduled_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','recent_payment_amount',COUNT(__d0(__NL(_recent__payment__amount_))),COUNT(__d0(__NN(_recent__payment__amount_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','recent_payment_date',COUNT(__d0(__NL(_recent__payment__date_))),COUNT(__d0(__NN(_recent__payment__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','remaining_balance',COUNT(__d0(__NL(_remaining__balance_))),COUNT(__d0(__NN(_remaining__balance_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','carried_over_amount',COUNT(__d0(__NL(_carried__over__amount_))),COUNT(__d0(__NN(_carried__over__amount_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','new_applied_charges',COUNT(__d0(__NL(_new__applied__charges_))),COUNT(__d0(__NN(_new__applied__charges_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','balloon_payment_due',COUNT(__d0(__NL(_balloon__payment__due_))),COUNT(__d0(__NN(_balloon__payment__due_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','balloon_payment_due_date',COUNT(__d0(__NL(_balloon__payment__due__date_))),COUNT(__d0(__NN(_balloon__payment__due__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','delinquency_date',COUNT(__d0(__NL(_delinquency__date_))),COUNT(__d0(__NN(_delinquency__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','days_delinquent',COUNT(__d0(__NL(_days__delinquent_))),COUNT(__d0(__NN(_days__delinquent_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_amount',COUNT(__d0(__NL(_past__due__amount_))),COUNT(__d0(__NN(_past__due__amount_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','maximum_number_of_past_due_aging_amounts_buckets_provided',COUNT(__d0(__NL(_maximum__number__of__past__due__aging__amounts__buckets__provided_))),COUNT(__d0(__NN(_maximum__number__of__past__due__aging__amounts__buckets__provided_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_bucket_type',COUNT(__d0(__NL(_past__due__aging__bucket__type_))),COUNT(__d0(__NN(_past__due__aging__bucket__type_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_1',COUNT(__d0(__NL(_past__due__aging__amount__bucket__1_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__1_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_2',COUNT(__d0(__NL(_past__due__aging__amount__bucket__2_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__2_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_3',COUNT(__d0(__NL(_past__due__aging__amount__bucket__3_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__3_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_4',COUNT(__d0(__NL(_past__due__aging__amount__bucket__4_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__4_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_5',COUNT(__d0(__NL(_past__due__aging__amount__bucket__5_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__5_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_6',COUNT(__d0(__NL(_past__due__aging__amount__bucket__6_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__6_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','past_due_aging_amount_bucket_7',COUNT(__d0(__NL(_past__due__aging__amount__bucket__7_))),COUNT(__d0(__NN(_past__due__aging__amount__bucket__7_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','maximum_number_of_payment_tracking_cycle_periods_provided',COUNT(__d0(__NL(_maximum__number__of__payment__tracking__cycle__periods__provided_))),COUNT(__d0(__NN(_maximum__number__of__payment__tracking__cycle__periods__provided_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_type',COUNT(__d0(__NL(_payment__tracking__cycle__type_))),COUNT(__d0(__NN(_payment__tracking__cycle__type_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_0_current',COUNT(__d0(__NL(_payment__tracking__cycle__0__current_))),COUNT(__d0(__NN(_payment__tracking__cycle__0__current_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_1_1_30_days',COUNT(__d0(__NL(_payment__tracking__cycle__1__1__30__days_))),COUNT(__d0(__NN(_payment__tracking__cycle__1__1__30__days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_2_31_60_days',COUNT(__d0(__NL(_payment__tracking__cycle__2__31__60__days_))),COUNT(__d0(__NN(_payment__tracking__cycle__2__31__60__days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_3_61_90_days',COUNT(__d0(__NL(_payment__tracking__cycle__3__61__90__days_))),COUNT(__d0(__NN(_payment__tracking__cycle__3__61__90__days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_4_91_120_days',COUNT(__d0(__NL(_payment__tracking__cycle__4__91__120__days_))),COUNT(__d0(__NN(_payment__tracking__cycle__4__91__120__days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_cycle_5_121_150days',COUNT(__d0(__NL(_payment__tracking__cycle__5__121__150days_))),COUNT(__d0(__NN(_payment__tracking__cycle__5__121__150days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_number_of_times_cycle_6_151_180_days',COUNT(__d0(__NL(_payment__tracking__number__of__times__cycle__6__151__180__days_))),COUNT(__d0(__NN(_payment__tracking__number__of__times__cycle__6__151__180__days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','payment_tracking_number_of_times_cycle_7_181_or_greater_days',COUNT(__d0(__NL(_payment__tracking__number__of__times__cycle__7__181__or__greater__days_))),COUNT(__d0(__NN(_payment__tracking__number__of__times__cycle__7__181__or__greater__days_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','date_account_was_charged_off',COUNT(__d0(__NL(_date__account__was__charged__off_))),COUNT(__d0(__NN(_date__account__was__charged__off_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','amount_charged_off_by_creditor',COUNT(__d0(__NL(_amount__charged__off__by__creditor_))),COUNT(__d0(__NN(_amount__charged__off__by__creditor_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','charge_off_type_indicator',COUNT(__d0(__NL(_charge__off__type__indicator_))),COUNT(__d0(__NN(_charge__off__type__indicator_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','total_charge_off_recoveries_to_date',COUNT(__d0(__NL(_total__charge__off__recoveries__to__date_))),COUNT(__d0(__NN(_total__charge__off__recoveries__to__date_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','government_guarantee_flag',COUNT(__d0(__NL(_government__guarantee__flag_))),COUNT(__d0(__NN(_government__guarantee__flag_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','government_guarantee_category',COUNT(__d0(__NL(_government__guarantee__category_))),COUNT(__d0(__NN(_government__guarantee__category_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','portion_of_account_guaranteed_by_government',COUNT(__d0(__NL(_portion__of__account__guaranteed__by__government_))),COUNT(__d0(__NN(_portion__of__account__guaranteed__by__government_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','guarantors_indicator',COUNT(__d0(__NL(_guarantors__indicator_))),COUNT(__d0(__NN(_guarantors__indicator_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','number_of_guarantors',COUNT(__d0(__NL(_number__of__guarantors_))),COUNT(__d0(__NN(_number__of__guarantors_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','owners_indicator',COUNT(__d0(__NL(_owners__indicator_))),COUNT(__d0(__NN(_owners__indicator_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','number_of_principals',COUNT(__d0(__NL(_number__of__principals_))),COUNT(__d0(__NN(_number__of__principals_)))},
    {'Tradeline','Business_Credit_KEL.File_SBFE_temp','account_update_deletion_indicator',COUNT(__d0(__NL(_account__update__deletion__indicator_))),COUNT(__d0(__NN(_account__update__deletion__indicator_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
