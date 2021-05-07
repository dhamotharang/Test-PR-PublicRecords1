IMPORT Phone_Shell, Models, STD;

EXPORT Luci_IPhoneShellAttributes := INTERFACE

  // Input Phone_Shell attributes
  EXPORT shell_attributes := ROW([], Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout.Phone_Shell);
  
  SHARED INTEGER4 NULL := -999999999;
  // Can be overridden for testing of certain date calculations but otherwise
  // should always be Today. Phone_Shell does not run in archive mode.
  // EXPORT because technically is a model variable and should be returned.
  EXPORT STRING8  sysdate  := (STRING8)STD.Date.Today();
  EXPORT INTEGER4 sysdate8 := Models.Common.sas_date(sysdate);
  
  SHARED BOOLEAN  contains_i(STRING haystack, STRING needle) := STD.Str.Find(haystack, needle, 1) > 0;
  // Pulling out this bit of code into a function because it's used a lot
  // Can't use Std.Date.MonthsBetween because they want to use the 30.5 rounding  
  SHARED INTEGER4 monthdiff(INTEGER4 sasdate1, INTEGER4 sasdate2) := 
    IF(MIN(sasdate1, sasdate2) = NULL, NULL,
       IF((sasdate1 - sasdate2) / 30.5 >= 0, TRUNCATE((sasdate1 - sasdate2) / 30.5),
                                             ROUNDUP((sasdate1 - sasdate2) / 30.5)));
  // This is also used quite a bit, mostly in "tof" variables to get the difference
  // between two month counters while also handling NULLs the same way SAS expects
  SHARED INTEGER4 tofcalc(INTEGER4 fdate_mth, INTEGER4 ldate_mth) := 
    IF(MIN(fdate_mth, ldate_mth) = NULL, NULL, fdate_mth - ldate_mth);
  // Pulling out another reused bit, only used maybe 3 times but it's bulky
  // Will also save a couple variables
  SHARED INTEGER4 carriergroups(STRING60 carrier_name) := 
    MAP(TRIM(carrier_name, LEFT, RIGHT) = ''                                          => NULL,
        contains_i(carrier_name, 'VERIZON WIRELESS')                                  => 1,
        contains_i(carrier_name, 'VERIZON')                                           => 2,
        contains_i(carrier_name, 'SPRINT')                                            => 3,
        contains_i(carrier_name, 'T-MOBILE')                                          => 4,
        contains_i(carrier_name, 'SOUTHWESTERN BELL')                                 => 5,
        contains_i(carrier_name, 'PACIFIC BELL')                                      => 6,
        contains_i(carrier_name, 'NEW CINGULAR')                                      => 7,
        contains_i(carrier_name, 'METRO PCS') OR contains_i(carrier_name, 'METROPCS') => 8,
        contains_i(carrier_name, 'BELLSOUTH')                                         => 9,
        contains_i(carrier_name, 'CRICKET COMM')                                      => 10,
        contains_i(carrier_name, 'AERIAL COMMUNICATION')                              => 11,
        contains_i(carrier_name, 'AMERITECH')                                         => 12,
        contains_i(carrier_name, 'CENTURYLINK')                                       => 13,
        contains_i(carrier_name, 'COMCAST')                                           => 14,
        contains_i(carrier_name, 'TIME WARNER')                                       => 15,
        contains_i(carrier_name, 'QWEST CORPORATION')                                 => 16,
        contains_i(carrier_name, 'OMNIPOINT')                                         => 17,
        contains_i(carrier_name, 'FRONTIER')                                          => 18,
        contains_i(carrier_name, 'UNITED STATES CEL')                                 => 19,
                                                                                         20);
  
  // Phone Shell Attributes needed to calculate the model variables
  // or internal calculations that the models need but don't want returned as a model variable
  // datatypes match either (a) the Phone_Shell attribute (from layout) or (b) the result of the calculation upon it
  SHARED STRING200  source_list                 := TRIM(shell_attributes.Sources.Source_List, LEFT, RIGHT); // comma-delimited list of phone origin codes
  SHARED STRING200  source_list_first_seen      := TRIM(shell_attributes.Sources.Source_List_First_Seen, LEFT, RIGHT); // comma-delimited list of YYYYMMDD dates
  SHARED STRING200  source_list_last_seen       := TRIM(shell_attributes.Sources.Source_List_Last_Seen, LEFT, RIGHT);  // comma-delimited list of YYYYMMDD dates
  SHARED STRING1    phone_switch_type           := shell_attributes.Raw_Phone_Characteristics.Phone_Switch_Type;// single-letter code indicating type of phone
  SHARED STRING30   phone_match_code            := shell_attributes.Raw_Phone_Characteristics.Phone_Match_Code; // currently a non-delimited list of letters indicating how the phone matched to PII from ANY source combined. eg. LNS or ACLN
  SHARED STRING35   phone_subject_title         := TRIM(shell_attributes.Raw_Phone_Characteristics.Phone_Subject_Title, LEFT, RIGHT);
  SHARED QSTRING150 pp_src_list                 := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Src_List; // comma-delimited list of phonesplus source codes
  SHARED QSTRING200 pp_datefirstseen            := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen; // comma-delimited list of YYYYMMDD dates corresponding to sources in the pp_src_list
  SHARED QSTRING200 pp_datelastseen             := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;  // comma-delimited list of YYYYMMDD dates corresponding to sources in the pp_src_list
  SHARED QSTRING200 pp_datevendorfirstseen      := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen; // comma-delimited list of YYYYMMDD dates corresponding to sources in the pp_src_list
  SHARED QSTRING200 pp_datevendorlastseen       := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen;  // comma-delimited list of YYYYMMDD dates corresponding to sources in the pp_src_list
  SHARED STRING64   pp_rules                    := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Rules; // bitmap string of phonesplus rules
  SHARED STRING1    pp_type                     := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Type;
  SHARED STRING8    phone_fb_rp_last_rpc_date   := shell_attributes.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date;
  SHARED INTEGER4   phone_fb_rp_last_rpc_date2  := Models.Common.sas_date(phone_fb_rp_last_rpc_date);
  SHARED UNSIGNED1  phone_fb_rp_result          := shell_attributes.Phone_Feedback.Phone_Feedback_RP_Result;
  SHARED STRING200  inq_adl_ph_industry_list_12 := shell_attributes.Inquiries.Inq_ADL_Phone_Industry_List_12;
  SHARED STRING8    ins_ver_fseen               := shell_attributes.Internal_Corroboration.Internal_Verification_First_Seen;
  SHARED INTEGER4   ins_ver_fseen2              := Models.Common.sas_date(ins_ver_fseen);
  SHARED STRING8    ins_ver_lseen               := shell_attributes.Internal_Corroboration.Internal_Verification_Last_Seen;
  SHARED INTEGER4   ins_ver_lseen2              := Models.Common.sas_date(ins_ver_lseen);
  SHARED INTEGER4   ins_ver_lseen_mth           := monthdiff(sysdate8, ins_ver_lseen2);
  SHARED STRING8    eda_dt_fseen                := shell_attributes.EDA_Characteristics.EDA_Dt_First_Seen;
  SHARED INTEGER4   eda_dt_fseen2               := Models.Common.sas_date(eda_dt_fseen);
  SHARED STRING8    eda_dt_lseen                := shell_attributes.EDA_Characteristics.EDA_Dt_Last_Seen;
  SHARED INTEGER4   eda_dt_lseen2               := Models.Common.sas_date(eda_dt_lseen);
  SHARED STRING8    eda_deletion_date           := shell_attributes.EDA_Characteristics.EDA_Deletion_Date;
  SHARED INTEGER4   eda_deletion_date2          := Models.Common.sas_date(eda_deletion_date);
  SHARED STRING8    meta_lseen_deact            := shell_attributes.Metadata.Meta_Most_Recent_Deact_Dt;
  SHARED STRING8    meta_lseen_react            := shell_attributes.Metadata.Meta_Most_Recent_React_Dt;
  SHARED STRING8    meta_lseen_port             := shell_attributes.Metadata.Meta_Most_Recent_Port_Dt;
  SHARED STRING8    meta_lseen_swap             := shell_attributes.Metadata.Meta_Most_Recent_Swap_Dt;
  SHARED INTEGER4   meta_lseen_port2            := Models.Common.sas_date(meta_lseen_port);
  SHARED INTEGER4   md_port_dt_lseen_mth        := monthdiff(sysdate8, meta_lseen_port2);
  SHARED INTEGER4   meta_lseen_react2           := Models.Common.sas_date(meta_lseen_react);
  SHARED INTEGER4   md_react_dt_lseen_mth       := monthdiff(sysdate8, meta_lseen_react2);
  SHARED STRING8    meta_lseen_otp              := shell_attributes.Metadata.Meta_Most_Recent_OTP_Dt;
  SHARED INTEGER4   meta_lseen_otp2             := Models.Common.sas_date(meta_lseen_otp);
  SHARED INTEGER4   md_otp_dt_lseen_mth         := monthdiff(sysdate8, meta_lseen_otp2);
  SHARED STRING8    bur_last_update             := shell_attributes.Bureau.Bureau_Last_Update;
  SHARED INTEGER4   bur_last_update2            := Models.Common.sas_date(bur_last_update);
  
  
  // ALL MODEL VARIABLES BELOW (except for the sysdates at the top) 
  
  // Intermediate Modeling Variables
  EXPORT INTEGER4  p_src_list_cnt               := Models.Common.countw(source_list, ' !$%&()*+,-./;<^|');
  EXPORT INTEGER4  p_src_list_edaca_pos         := Models.Common.findw_cpp(source_list, 'EDACA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edaca             := p_src_list_edaca_pos > 0;
  EXPORT INTEGER4  p_src_list_edadid_pos        := Models.Common.findw_cpp(source_list, 'EDADID' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edadid            := p_src_list_edadid_pos > 0;
  EXPORT STRING8   p_src_list_fdate_edadid      := IF(p_src_list_edadid_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_edadid_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_edadid2     := Models.Common.sas_date(p_src_list_fdate_edadid);
  EXPORT INTEGER4  p_src_list_fdate_edadid_mth  := monthdiff(sysdate8, p_src_list_fdate_edadid2);
  EXPORT INTEGER4  p_src_list_edafa_pos         := Models.Common.findw_cpp(source_list, 'EDAFA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edafa             := p_src_list_edafa_pos > 0;
  EXPORT INTEGER4  p_src_list_edafla_pos        := Models.Common.findw_cpp(source_list, 'EDAFLA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edafla            := p_src_list_edafla_pos > 0;
  EXPORT INTEGER4  p_src_list_edahistory_pos    := Models.Common.findw_cpp(source_list, 'EDAHistory' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edahistory        := p_src_list_edahistory_pos > 0;
  EXPORT INTEGER4  p_src_list_edala_pos         := Models.Common.findw_cpp(source_list, 'EDALA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edala             := p_src_list_edala_pos > 0;
  EXPORT INTEGER4  p_src_list_edalfa_pos        := Models.Common.findw_cpp(source_list, 'EDALFA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_edalfa            := p_src_list_edalfa_pos > 0;
  EXPORT INTEGER4  p_src_list_eqp_pos           := Models.Common.findw_cpp(source_list, 'EQP' , '  ,', 'ie');
  EXPORT STRING8   p_src_list_fdate_eqp         := IF(p_src_list_eqp_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_eqp_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_eqp2        := Models.Common.sas_date(p_src_list_fdate_eqp);
  EXPORT INTEGER4  p_src_list_fdate_eqp_mth     := monthdiff(sysdate8, p_src_list_fdate_eqp2);
  EXPORT STRING8   p_src_list_ldate_eqp         := IF(p_src_list_eqp_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_eqp_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_eqp2        := Models.Common.sas_date(p_src_list_ldate_eqp);
  EXPORT INTEGER4  p_src_list_ldate_eqp_mth     := monthdiff(sysdate8, p_src_list_ldate_eqp2);
  EXPORT INTEGER4  p_src_list_inf_pos           := Models.Common.findw_cpp(source_list, 'INF' , '  ,', 'ie');
  EXPORT STRING8   p_src_list_fdate_inf         := IF(p_src_list_inf_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_inf_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_inf2        := Models.Common.sas_date(p_src_list_fdate_inf);
  EXPORT INTEGER4  p_src_list_fdate_inf_mth     := monthdiff(sysdate8, p_src_list_fdate_inf2);
  EXPORT STRING8   p_src_list_ldate_inf         := IF(p_src_list_inf_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_inf_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_inf2        := Models.Common.sas_date(p_src_list_ldate_inf);
  EXPORT INTEGER4  p_src_list_ldate_inf_mth     := monthdiff(sysdate8, p_src_list_ldate_inf2);
  EXPORT INTEGER4  p_src_list_ne_pos            := Models.Common.findw_cpp(source_list, 'NE' , '  ,', 'ie');
  EXPORT STRING8   p_src_list_fdate_ne          := IF(p_src_list_ne_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_ne_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_ne2         := Models.Common.sas_date(p_src_list_fdate_ne);
  EXPORT INTEGER4  p_src_list_fdate_ne_mth      := monthdiff(sysdate8, p_src_list_fdate_ne2);
  EXPORT INTEGER4  p_src_list_paw_pos           := Models.Common.findw_cpp(source_list, 'PAW' , '  ,', 'ie');
  EXPORT STRING8   p_src_list_fdate_paw         := IF(p_src_list_paw_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_paw_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_paw2        := Models.Common.sas_date(p_src_list_fdate_paw);
  EXPORT INTEGER4  p_src_list_fdate_paw_mth     := monthdiff(sysdate8, p_src_list_fdate_paw2);
  EXPORT STRING8   p_src_list_ldate_paw         := IF(p_src_list_paw_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_paw_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_paw2        := Models.Common.sas_date(p_src_list_ldate_paw);
  EXPORT INTEGER4  p_src_list_ldate_paw_mth     := monthdiff(sysdate8, p_src_list_ldate_paw2);
  EXPORT INTEGER4  p_src_list_ppca_pos          := Models.Common.findw_cpp(source_list, 'PPCA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_ppca              := p_src_list_ppca_pos > 0;
  EXPORT STRING8   p_src_list_fdate_ppca        := IF(p_src_list_ppca_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_ppca_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_ppca2       := Models.Common.sas_date(p_src_list_fdate_ppca);
  EXPORT INTEGER4  p_src_list_fdate_ppca_mth    := monthdiff(sysdate8, p_src_list_fdate_ppca2);
  EXPORT STRING8   p_src_list_ldate_ppca        := IF(p_src_list_ppca_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_ppca_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_ppca2       := Models.Common.sas_date(p_src_list_ldate_ppca);
  EXPORT INTEGER4  p_src_list_ldate_ppca_mth    := monthdiff(sysdate8, p_src_list_ldate_ppca2);
  EXPORT INTEGER4  p_src_list_ppdid_pos         := Models.Common.findw_cpp(source_list, 'PPDID' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_ppdid             := p_src_list_ppdid_pos > 0;
  EXPORT STRING8   p_src_list_fdate_ppdid       := IF(p_src_list_ppdid_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_ppdid_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_ppdid2      := Models.Common.sas_date(p_src_list_fdate_ppdid);
  EXPORT INTEGER4  p_src_list_fdate_ppdid_mth   := monthdiff(sysdate8, p_src_list_fdate_ppdid2);
  EXPORT STRING8   p_src_list_ldate_ppdid       := IF(p_src_list_ppdid_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_ppdid_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_ppdid2      := Models.Common.sas_date(p_src_list_ldate_ppdid);
  EXPORT INTEGER4  p_src_list_ldate_ppdid_mth   := monthdiff(sysdate8, p_src_list_ldate_ppdid2);
  EXPORT INTEGER4  p_src_list_ppfa_pos          := Models.Common.findw_cpp(source_list, 'PPFA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_ppfa              := p_src_list_ppfa_pos > 0;
  EXPORT INTEGER4  p_src_list_ppfla_pos         := Models.Common.findw_cpp(source_list, 'PPFLA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_ppfla             := p_src_list_ppfla_pos > 0;
  EXPORT STRING8   p_src_list_fdate_ppfla       := IF(p_src_list_ppfla_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_ppfla_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_ppfla2      := Models.Common.sas_date(p_src_list_fdate_ppfla);
  EXPORT INTEGER4  p_src_list_fdate_ppfla_mth   := monthdiff(sysdate8, p_src_list_fdate_ppfla2);
  EXPORT STRING8   p_src_list_ldate_ppfla       := IF(p_src_list_ppfla_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_ppfla_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_ppfla2      := Models.Common.sas_date(p_src_list_ldate_ppfla);
  EXPORT INTEGER4  p_src_list_ldate_ppfla_mth   := monthdiff(sysdate8, p_src_list_ldate_ppfla2);
  EXPORT INTEGER4  p_src_list_ppla_pos          := Models.Common.findw_cpp(source_list, 'PPLA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_ppla              := p_src_list_ppla_pos > 0;
  EXPORT STRING8   p_src_list_fdate_ppla        := IF(p_src_list_ppla_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_ppla_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_ppla2       := Models.Common.sas_date(p_src_list_fdate_ppla);
  EXPORT INTEGER4  p_src_list_fdate_ppla_mth    := monthdiff(sysdate8, p_src_list_fdate_ppla2);
  EXPORT STRING8   p_src_list_ldate_ppla        := IF(p_src_list_ppla_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_ppla_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_ppla2       := Models.Common.sas_date(p_src_list_ldate_ppla);
  EXPORT INTEGER4  p_src_list_ldate_ppla_mth    := monthdiff(sysdate8, p_src_list_ldate_ppla2);
  EXPORT INTEGER4  p_src_list_pplfa_pos         := Models.Common.findw_cpp(source_list, 'PPLFA' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_pplfa             := p_src_list_pplfa_pos > 0;
  EXPORT INTEGER4  p_src_list_ppth_pos          := Models.Common.findw_cpp(source_list, 'PPTH' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_ppth              := p_src_list_ppth_pos > 0;
  EXPORT INTEGER4  p_src_list_sx_pos            := Models.Common.findw_cpp(source_list, 'SX' , '  ,', 'ie');
  EXPORT STRING8   p_src_list_fdate_sx          := IF(p_src_list_sx_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_sx_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_sx2         := Models.Common.sas_date(p_src_list_fdate_sx);
  EXPORT INTEGER4  p_src_list_fdate_sx_mth      := monthdiff(sysdate8, p_src_list_fdate_sx2);
  EXPORT INTEGER4  p_src_list_utildid_pos       := Models.Common.findw_cpp(source_list, 'UtilDID' , '  ,', 'ie');
  EXPORT BOOLEAN   p_src_list_utildid           := p_src_list_utildid_pos > 0;
  EXPORT STRING8   p_src_list_fdate_utildid     := IF(p_src_list_utildid_pos > 0, Models.Common.getw(source_list_first_seen, p_src_list_utildid_pos), '0');
  EXPORT INTEGER4  p_src_list_fdate_utildid2    := Models.Common.sas_date(p_src_list_fdate_utildid);
  EXPORT INTEGER4  p_src_list_fdate_utildid_mth := monthdiff(sysdate8, p_src_list_fdate_utildid2);
  EXPORT STRING8   p_src_list_ldate_utildid     := IF(p_src_list_utildid_pos > 0, Models.Common.getw(source_list_last_seen, p_src_list_utildid_pos), '0');
  EXPORT INTEGER4  p_src_list_ldate_utildid2    := Models.Common.sas_date(p_src_list_ldate_utildid);
  EXPORT INTEGER4  p_src_list_ldate_utildid_mth := monthdiff(sysdate8, p_src_list_ldate_utildid2);
  EXPORT INTEGER4  p_src_list_tof_eqp_mth       := tofcalc(p_src_list_fdate_eqp_mth, p_src_list_ldate_eqp_mth);
  EXPORT INTEGER4  p_src_list_tof_inf_mth       := tofcalc(p_src_list_fdate_inf_mth, p_src_list_ldate_inf_mth);
  EXPORT INTEGER4  p_src_list_tof_paw_mth       := tofcalc(p_src_list_fdate_paw_mth, p_src_list_ldate_paw_mth);
  EXPORT INTEGER4  p_src_list_tof_ppca_mth      := tofcalc(p_src_list_fdate_ppca_mth,p_src_list_ldate_ppca_mth);
  EXPORT INTEGER4  p_src_list_tof_ppdid_mth     := tofcalc(p_src_list_fdate_ppdid_mth, p_src_list_ldate_ppdid_mth);
  EXPORT INTEGER4  p_src_list_tof_ppfla_mth     := tofcalc(p_src_list_fdate_ppfla_mth, p_src_list_ldate_ppfla_mth);
  EXPORT INTEGER4  p_src_list_tof_ppla_mth      := tofcalc(p_src_list_fdate_ppla_mth, p_src_list_ldate_ppla_mth);
  EXPORT INTEGER4  p_src_list_tof_utildid_mth   := tofcalc(p_src_list_fdate_utildid_mth, p_src_list_ldate_utildid_mth);
  EXPORT UNSIGNED1 p_source_eda_any             := (UNSIGNED1)(p_src_list_edaca OR p_src_list_edadid OR p_src_list_edafa OR p_src_list_edafla OR 
                                                               p_src_list_edahistory OR p_src_list_edala OR p_src_list_edalfa);
  EXPORT UNSIGNED1 p_source_pp_any              := (UNSIGNED1)(p_src_list_ppca OR p_src_list_ppdid OR p_src_list_ppfa OR p_src_list_ppfla OR 
                                                               p_src_list_ppla OR p_src_list_pplfa OR p_src_list_ppth);
  EXPORT UNSIGNED1 p_phone_subject_level        := shell_attributes.Raw_Phone_Characteristics.Phone_Subject_Level;
  EXPORT INTEGER4  p_phone_switch_type          := CASE(phone_switch_type, '8' => 1, 'C' => 2, 'G' => 3, 'I' => 4, 'P' => 5,
                                                                           'T' => 6, 'U' => 7, 'V' => 8, 'W' => 9, NULL);
  EXPORT BOOLEAN   p_phone_disconnected         := shell_attributes.Raw_Phone_Characteristics.Phone_Disconnected;
  EXPORT UNSIGNED1 p_phone_zip_match            := shell_attributes.Raw_Phone_Characteristics.Phone_Zip_Match;
  EXPORT UNSIGNED1 p_phone_timezone_match       := shell_attributes.Raw_Phone_Characteristics.Phone_Timezone_Match;
  EXPORT UNSIGNED1 p_phone_match_code_addr      := IF(contains_i(phone_match_code, 'A'), 1, 0);
  EXPORT UNSIGNED1 p_phone_match_code_city      := IF(contains_i(phone_match_code, 'C'), 1, 0);
  EXPORT UNSIGNED1 p_phone_match_code_lex       := IF(contains_i(phone_match_code, 'L'), 1, 0);
  EXPORT UNSIGNED1 p_phone_match_code_name      := IF(contains_i(phone_match_code, 'N'), 1, 0);
  EXPORT UNSIGNED1 p_phone_match_code_ssn       := IF(contains_i(phone_match_code, 'S'), 1, 0);
  EXPORT UNSIGNED1 p_phone_match_code_st        := IF(contains_i(phone_match_code, 'T'), 1, 0);
  EXPORT UNSIGNED1 p_phone_match_code_zip       := IF(contains_i(phone_match_code, 'Z'), 1, 0);
  EXPORT UNSIGNED1 p_phone_subject_title_group  := MAP(contains_i(phone_subject_title, 'Associate')                                 => 1,
                                                       phone_subject_title IN ['Grandchild', 'Granddaughter', 'Grandson',
                                                                               'Grandfather', 'Grandmother', 'Grandparent', 
                                                                               'Relative', 'Neighbor']                              => 2,
                                                       phone_subject_title IN ['Brother', 'Child', 'Daughter', 'Father', 'Husband', 
                                                                               'Mother', 'Parent', 'Sibling', 'Sister', 'Son', 
                                                                               'Spouse', 'Wife', 'Subject at Household']            => 3,
                                                       phone_subject_title = 'Subject'                                              => 4,
                                                                                                                                       0);
  EXPORT INTEGER4  p_phone_subject_title_group2 := MAP(contains_i(phone_subject_title, 'Associate By Address')              => 1,
                                                       contains_i(phone_subject_title, 'Associate')                         => 2,
                                                       phone_subject_title IN ['Grandfather', 'Grandmother', 'Grandparent'] => 3,
                                                       phone_subject_title IN ['Grandchild', 'Granddaughter', 'Grandson']   => 4,
                                                       phone_subject_title IN ['Brother', 'Sibling', 'Sister']              => 5,
                                                       phone_subject_title IN ['Child', 'Daughter', 'Son']                  => 6,
                                                       phone_subject_title IN ['Father', 'Mother', 'Parent']                => 7,
                                                       phone_subject_title IN ['Husband', 'Spouse', 'Wife']                 => 8,
                                                                                                                               NULL);
  EXPORT UNSIGNED1 p_phone_switch_type_cell     := IF(phone_switch_type = 'C', 1, 0);
  EXPORT INTEGER4  mpp_src_cnt                  := Models.Common.countw(pp_src_list, ' !$%&()*+,-./;<^|');
  EXPORT INTEGER4  mpp_src_ao_pos               := Models.Common.findw_cpp(pp_src_list, 'AO' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ao                   := mpp_src_ao_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ao             := IF(mpp_src_ao_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ao_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ao2            := Models.Common.sas_date(mpp_src_fdate_ao);
  EXPORT INTEGER4  mpp_src_fdate_ao_mth         := monthdiff(sysdate8, mpp_src_fdate_ao2);
  EXPORT STRING8   mpp_src_ldate_ao             := IF(mpp_src_ao_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ao_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ao2            := Models.Common.sas_date(mpp_src_ldate_ao);
  EXPORT INTEGER4  mpp_src_ldate_ao_mth         := monthdiff(sysdate8, mpp_src_ldate_ao2);
  EXPORT INTEGER4  mpp_src_bw_pos               := Models.Common.findw_cpp(pp_src_list, 'BW' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_bw                   := mpp_src_bw_pos > 0;
  EXPORT STRING8   mpp_src_fdate_bw             := IF(mpp_src_bw_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_bw_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_bw2            := Models.Common.sas_date(mpp_src_fdate_bw);
  EXPORT INTEGER4  mpp_src_fdate_bw_mth         := monthdiff(sysdate8, mpp_src_fdate_bw2);
  EXPORT STRING8   mpp_src_ldate_bw             := IF(mpp_src_bw_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_bw_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_bw2            := Models.Common.sas_date(mpp_src_ldate_bw);
  EXPORT INTEGER4  mpp_src_ldate_bw_mth         := monthdiff(sysdate8, mpp_src_ldate_bw2);
  EXPORT INTEGER4  mpp_src_cy_pos               := Models.Common.findw_cpp(pp_src_list, 'CY' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_cy                   := mpp_src_cy_pos > 0;
  EXPORT STRING8   mpp_src_fdate_cy             := IF(mpp_src_cy_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_cy_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_cy2            := Models.Common.sas_date(mpp_src_fdate_cy);
  EXPORT INTEGER4  mpp_src_fdate_cy_mth         := monthdiff(sysdate8, mpp_src_fdate_cy2);
  EXPORT STRING8   mpp_src_ldate_cy             := IF(mpp_src_cy_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_cy_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_cy2            := Models.Common.sas_date(mpp_src_ldate_cy);
  EXPORT INTEGER4  mpp_src_ldate_cy_mth         := monthdiff(sysdate8, mpp_src_ldate_cy2);
  EXPORT INTEGER4  mpp_src_dw_pos               := Models.Common.findw_cpp(pp_src_list, 'DW' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_dw                   := mpp_src_dw_pos > 0;
  EXPORT STRING8   mpp_src_fdate_dw             := IF(mpp_src_dw_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_dw_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_dw2            := Models.Common.sas_date(mpp_src_fdate_dw);
  EXPORT INTEGER4  mpp_src_fdate_dw_mth         := monthdiff(sysdate8, mpp_src_fdate_dw2);
  EXPORT STRING8   mpp_src_ldate_dw             := IF(mpp_src_dw_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_dw_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_dw2            := Models.Common.sas_date(mpp_src_ldate_dw);
  EXPORT INTEGER4  mpp_src_ldate_dw_mth         := monthdiff(sysdate8, mpp_src_ldate_dw2);
  EXPORT INTEGER4  mpp_src_e1_pos               := Models.Common.findw_cpp(pp_src_list, 'E1' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_e1                   := mpp_src_e1_pos > 0;
  EXPORT STRING8   mpp_src_fdate_e1             := IF(mpp_src_e1_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_e1_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_e12            := Models.Common.sas_date(mpp_src_fdate_e1);
  EXPORT INTEGER4  mpp_src_fdate_e1_mth         := monthdiff(sysdate8, mpp_src_fdate_e12);
  EXPORT STRING8   mpp_src_ldate_e1             := IF(mpp_src_e1_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_e1_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_e12            := Models.Common.sas_date(mpp_src_ldate_e1);
  EXPORT INTEGER4  mpp_src_ldate_e1_mth         := monthdiff(sysdate8, mpp_src_ldate_e12);
  EXPORT INTEGER4  mpp_src_e2_pos               := Models.Common.findw_cpp(pp_src_list, 'E2' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_e2                   := mpp_src_e2_pos > 0;
  EXPORT STRING8   mpp_src_fdate_e2             := IF(mpp_src_e2_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_e2_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_e22            := Models.Common.sas_date(mpp_src_fdate_e2);
  EXPORT INTEGER4  mpp_src_fdate_e2_mth         := monthdiff(sysdate8, mpp_src_fdate_e22);
  EXPORT STRING8   mpp_src_ldate_e2             := IF(mpp_src_e2_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_e2_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_e22            := Models.Common.sas_date(mpp_src_ldate_e2);
  EXPORT INTEGER4  mpp_src_ldate_e2_mth         := monthdiff(sysdate8, mpp_src_ldate_e22);
  EXPORT INTEGER4  mpp_src_e4_pos               := Models.Common.findw_cpp(pp_src_list, 'E4' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_e4                   := mpp_src_e4_pos > 0;
  EXPORT STRING8   mpp_src_fdate_e4             := IF(mpp_src_e4_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_e4_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_e42            := Models.Common.sas_date(mpp_src_fdate_e4);
  EXPORT INTEGER4  mpp_src_fdate_e4_mth         := monthdiff(sysdate8, mpp_src_fdate_e42);
  EXPORT STRING8   mpp_src_ldate_e4             := IF(mpp_src_e4_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_e4_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_e42            := Models.Common.sas_date(mpp_src_ldate_e4);
  EXPORT INTEGER4  mpp_src_ldate_e4_mth         := monthdiff(sysdate8, mpp_src_ldate_e42);
  EXPORT INTEGER4  mpp_src_eb_pos               := Models.Common.findw_cpp(pp_src_list, 'EB' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_eb                   := mpp_src_eb_pos > 0;
  EXPORT STRING8   mpp_src_fdate_eb             := IF(mpp_src_eb_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_eb_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_eb2            := Models.Common.sas_date(mpp_src_fdate_eb);
  EXPORT INTEGER4  mpp_src_fdate_eb_mth         := monthdiff(sysdate8, mpp_src_fdate_eb2);
  EXPORT STRING8   mpp_src_ldate_eb             := IF(mpp_src_eb_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_eb_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_eb2            := Models.Common.sas_date(mpp_src_ldate_eb);
  EXPORT INTEGER4  mpp_src_ldate_eb_mth         := monthdiff(sysdate8, mpp_src_ldate_eb2);
  EXPORT INTEGER4  mpp_src_em_pos               := Models.Common.findw_cpp(pp_src_list, 'EM' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_em                   := mpp_src_em_pos > 0;
  EXPORT STRING8   mpp_src_fdate_em             := IF(mpp_src_em_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_em_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_em2            := Models.Common.sas_date(mpp_src_fdate_em);
  EXPORT INTEGER4  mpp_src_fdate_em_mth         := monthdiff(sysdate8, mpp_src_fdate_em2);
  EXPORT STRING8   mpp_src_ldate_em             := IF(mpp_src_em_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_em_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_em2            := Models.Common.sas_date(mpp_src_ldate_em);
  EXPORT INTEGER4  mpp_src_ldate_em_mth         := monthdiff(sysdate8, mpp_src_ldate_em2);
  EXPORT INTEGER4  mpp_src_en_pos               := Models.Common.findw_cpp(pp_src_list, 'EN' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_en                   := mpp_src_en_pos > 0;
  EXPORT STRING8   mpp_src_fdate_en             := IF(mpp_src_en_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_en_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_en2            := Models.Common.sas_date(mpp_src_fdate_en);
  EXPORT INTEGER4  mpp_src_fdate_en_mth         := monthdiff(sysdate8, mpp_src_fdate_en2);
  EXPORT STRING8   mpp_src_ldate_en             := IF(mpp_src_en_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_en_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_en2            := Models.Common.sas_date(mpp_src_ldate_en);
  EXPORT INTEGER4  mpp_src_ldate_en_mth         := monthdiff(sysdate8, mpp_src_ldate_en2);
  EXPORT INTEGER4  mpp_src_eq_pos               := Models.Common.findw_cpp(pp_src_list, 'EQ' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_eq                   := mpp_src_eq_pos > 0;
  EXPORT STRING8   mpp_src_fdate_eq             := IF(mpp_src_eq_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_eq_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_eq2            := Models.Common.sas_date(mpp_src_fdate_eq);
  EXPORT INTEGER4  mpp_src_fdate_eq_mth         := monthdiff(sysdate8, mpp_src_fdate_eq2);
  EXPORT STRING8   mpp_src_ldate_eq             := IF(mpp_src_eq_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_eq_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_eq2            := Models.Common.sas_date(mpp_src_ldate_eq);
  EXPORT INTEGER4  mpp_src_ldate_eq_mth         := monthdiff(sysdate8, mpp_src_ldate_eq2);
  EXPORT INTEGER4  mpp_src_fa_pos               := Models.Common.findw_cpp(pp_src_list, 'FA' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_fa                   := mpp_src_fa_pos > 0;
  EXPORT STRING8   mpp_src_fdate_fa             := IF(mpp_src_fa_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_fa_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_fa2            := Models.Common.sas_date(mpp_src_fdate_fa);
  EXPORT INTEGER4  mpp_src_fdate_fa_mth         := monthdiff(sysdate8, mpp_src_fdate_fa2);
  EXPORT STRING8   mpp_src_ldate_fa             := IF(mpp_src_fa_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_fa_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_fa2            := Models.Common.sas_date(mpp_src_ldate_fa);
  EXPORT INTEGER4  mpp_src_ldate_fa_mth         := monthdiff(sysdate8, mpp_src_ldate_fa2);
  EXPORT INTEGER4  mpp_src_fe_pos               := Models.Common.findw_cpp(pp_src_list, 'FE' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_fe                   := mpp_src_fe_pos > 0;
  EXPORT STRING8   mpp_src_fdate_fe             := IF(mpp_src_fe_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_fe_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_fe2            := Models.Common.sas_date(mpp_src_fdate_fe);
  EXPORT INTEGER4  mpp_src_fdate_fe_mth         := monthdiff(sysdate8, mpp_src_fdate_fe2);
  EXPORT STRING8   mpp_src_ldate_fe             := IF(mpp_src_fe_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_fe_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_fe2            := Models.Common.sas_date(mpp_src_ldate_fe);
  EXPORT INTEGER4  mpp_src_ldate_fe_mth         := monthdiff(sysdate8, mpp_src_ldate_fe2);
  EXPORT INTEGER4  mpp_src_ff_pos               := Models.Common.findw_cpp(pp_src_list, 'FF' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ff                   := mpp_src_ff_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ff             := IF(mpp_src_ff_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ff_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ff2            := Models.Common.sas_date(mpp_src_fdate_ff);
  EXPORT INTEGER4  mpp_src_fdate_ff_mth         := monthdiff(sysdate8, mpp_src_fdate_ff2);
  EXPORT STRING8   mpp_src_ldate_ff             := IF(mpp_src_ff_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ff_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ff2            := Models.Common.sas_date(mpp_src_ldate_ff);
  EXPORT INTEGER4  mpp_src_ldate_ff_mth         := monthdiff(sysdate8, mpp_src_ldate_ff2);
  EXPORT INTEGER4  mpp_src_go_pos               := Models.Common.findw_cpp(pp_src_list, 'GO' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_go                   := mpp_src_go_pos > 0;
  EXPORT STRING8   mpp_src_fdate_go             := IF(mpp_src_go_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_go_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_go2            := Models.Common.sas_date(mpp_src_fdate_go);
  EXPORT INTEGER4  mpp_src_fdate_go_mth         := monthdiff(sysdate8, mpp_src_fdate_go2);
  EXPORT STRING8   mpp_src_ldate_go             := IF(mpp_src_go_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_go_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_go2            := Models.Common.sas_date(mpp_src_ldate_go);
  EXPORT INTEGER4  mpp_src_ldate_go_mth         := monthdiff(sysdate8, mpp_src_ldate_go2);
  EXPORT INTEGER4  mpp_src_ib_pos               := Models.Common.findw_cpp(pp_src_list, 'IB' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ib                   := mpp_src_ib_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ib             := IF(mpp_src_ib_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ib_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ib2            := Models.Common.sas_date(mpp_src_fdate_ib);
  EXPORT INTEGER4  mpp_src_fdate_ib_mth         := monthdiff(sysdate8, mpp_src_fdate_ib2);
  EXPORT STRING8   mpp_src_ldate_ib             := IF(mpp_src_ib_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ib_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ib2            := Models.Common.sas_date(mpp_src_ldate_ib);
  EXPORT INTEGER4  mpp_src_ldate_ib_mth         := monthdiff(sysdate8, mpp_src_ldate_ib2);
  EXPORT INTEGER4  mpp_src_io_pos               := Models.Common.findw_cpp(pp_src_list, 'IO' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_io                   := mpp_src_io_pos > 0;
  EXPORT STRING8   mpp_src_fdate_io             := IF(mpp_src_io_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_io_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_io2            := Models.Common.sas_date(mpp_src_fdate_io);
  EXPORT INTEGER4  mpp_src_fdate_io_mth         := monthdiff(sysdate8, mpp_src_fdate_io2);
  EXPORT STRING8   mpp_src_ldate_io             := IF(mpp_src_io_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_io_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_io2            := Models.Common.sas_date(mpp_src_ldate_io);
  EXPORT INTEGER4  mpp_src_ldate_io_mth         := monthdiff(sysdate8, mpp_src_ldate_io2);
  EXPORT INTEGER4  mpp_src_iq_pos               := Models.Common.findw_cpp(pp_src_list, 'IQ' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_iq                   := mpp_src_iq_pos > 0;
  EXPORT STRING8   mpp_src_fdate_iq             := IF(mpp_src_iq_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_iq_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_iq2            := Models.Common.sas_date(mpp_src_fdate_iq);
  EXPORT INTEGER4  mpp_src_fdate_iq_mth         := monthdiff(sysdate8, mpp_src_fdate_iq2);
  EXPORT STRING8   mpp_src_ldate_iq             := IF(mpp_src_iq_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_iq_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_iq2            := Models.Common.sas_date(mpp_src_ldate_iq);
  EXPORT INTEGER4  mpp_src_ldate_iq_mth         := monthdiff(sysdate8, mpp_src_ldate_iq2);
  EXPORT INTEGER4  mpp_src_ir_pos               := Models.Common.findw_cpp(pp_src_list, 'IR' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ir                   := mpp_src_ir_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ir             := IF(mpp_src_ir_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ir_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ir2            := Models.Common.sas_date(mpp_src_fdate_ir);
  EXPORT INTEGER4  mpp_src_fdate_ir_mth         := monthdiff(sysdate8, mpp_src_fdate_ir2);
  EXPORT STRING8   mpp_src_ldate_ir             := IF(mpp_src_ir_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ir_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ir2            := Models.Common.sas_date(mpp_src_ldate_ir);
  EXPORT INTEGER4  mpp_src_ldate_ir_mth         := monthdiff(sysdate8, mpp_src_ldate_ir2);
  EXPORT INTEGER4  mpp_src_kw_pos               := Models.Common.findw_cpp(pp_src_list, 'KW' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_kw                   := mpp_src_kw_pos > 0;
  EXPORT STRING8   mpp_src_fdate_kw             := IF(mpp_src_kw_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_kw_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_kw2            := Models.Common.sas_date(mpp_src_fdate_kw);
  EXPORT INTEGER4  mpp_src_fdate_kw_mth         := monthdiff(sysdate8, mpp_src_fdate_kw2);
  EXPORT STRING8   mpp_src_ldate_kw             := IF(mpp_src_kw_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_kw_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_kw2            := Models.Common.sas_date(mpp_src_ldate_kw);
  EXPORT INTEGER4  mpp_src_ldate_kw_mth         := monthdiff(sysdate8, mpp_src_ldate_kw2);
  EXPORT INTEGER4  mpp_src_l9_pos               := Models.Common.findw_cpp(pp_src_list, 'L9' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_l9                   := mpp_src_l9_pos > 0;
  EXPORT STRING8   mpp_src_fdate_l9             := IF(mpp_src_l9_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_l9_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_l92            := Models.Common.sas_date(mpp_src_fdate_l9);
  EXPORT INTEGER4  mpp_src_fdate_l9_mth         := monthdiff(sysdate8, mpp_src_fdate_l92);
  EXPORT STRING8   mpp_src_ldate_l9             := IF(mpp_src_l9_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_l9_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_l92            := Models.Common.sas_date(mpp_src_ldate_l9);
  EXPORT INTEGER4  mpp_src_ldate_l9_mth         := monthdiff(sysdate8, mpp_src_ldate_l92);
  EXPORT INTEGER4  mpp_src_la_pos               := Models.Common.findw_cpp(pp_src_list, 'LA' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_la                   := mpp_src_la_pos > 0;
  EXPORT STRING8   mpp_src_fdate_la             := IF(mpp_src_la_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_la_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_la2            := Models.Common.sas_date(mpp_src_fdate_la);
  EXPORT INTEGER4  mpp_src_fdate_la_mth         := monthdiff(sysdate8, mpp_src_fdate_la2);
  EXPORT STRING8   mpp_src_ldate_la             := IF(mpp_src_la_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_la_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_la2            := Models.Common.sas_date(mpp_src_ldate_la);
  EXPORT INTEGER4  mpp_src_ldate_la_mth         := monthdiff(sysdate8, mpp_src_ldate_la2);
  EXPORT INTEGER4  mpp_src_lp_pos               := Models.Common.findw_cpp(pp_src_list, 'LP' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_lp                   := mpp_src_lp_pos > 0;
  EXPORT STRING8   mpp_src_fdate_lp             := IF(mpp_src_lp_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_lp_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_lp2            := Models.Common.sas_date(mpp_src_fdate_lp);
  EXPORT INTEGER4  mpp_src_fdate_lp_mth         := monthdiff(sysdate8, mpp_src_fdate_lp2);
  EXPORT STRING8   mpp_src_ldate_lp             := IF(mpp_src_lp_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_lp_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_lp2            := Models.Common.sas_date(mpp_src_ldate_lp);
  EXPORT INTEGER4  mpp_src_ldate_lp_mth         := monthdiff(sysdate8, mpp_src_ldate_lp2);
  EXPORT INTEGER4  mpp_src_md_pos               := Models.Common.findw_cpp(pp_src_list, 'MD' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_md                   := mpp_src_md_pos > 0;
  EXPORT STRING8   mpp_src_fdate_md             := IF(mpp_src_md_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_md_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_md2            := Models.Common.sas_date(mpp_src_fdate_md);
  EXPORT INTEGER4  mpp_src_fdate_md_mth         := monthdiff(sysdate8, mpp_src_fdate_md2);
  EXPORT STRING8   mpp_src_ldate_md             := IF(mpp_src_md_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_md_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_md2            := Models.Common.sas_date(mpp_src_ldate_md);
  EXPORT INTEGER4  mpp_src_ldate_md_mth         := monthdiff(sysdate8, mpp_src_ldate_md2);
  EXPORT INTEGER4  mpp_src_n2_pos               := Models.Common.findw_cpp(pp_src_list, 'N2' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_n2                   := mpp_src_n2_pos > 0;
  EXPORT STRING8   mpp_src_fdate_n2             := IF(mpp_src_n2_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_n2_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_n22            := Models.Common.sas_date(mpp_src_fdate_n2);
  EXPORT INTEGER4  mpp_src_fdate_n2_mth         := monthdiff(sysdate8, mpp_src_fdate_n22);
  EXPORT STRING8   mpp_src_ldate_n2             := IF(mpp_src_n2_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_n2_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_n22            := Models.Common.sas_date(mpp_src_ldate_n2);
  EXPORT INTEGER4  mpp_src_ldate_n2_mth         := monthdiff(sysdate8, mpp_src_ldate_n22);
  EXPORT INTEGER4  mpp_src_nw_pos               := Models.Common.findw_cpp(pp_src_list, 'NW' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_nw                   := mpp_src_nw_pos > 0;
  EXPORT STRING8   mpp_src_fdate_nw             := IF(mpp_src_nw_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_nw_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_nw2            := Models.Common.sas_date(mpp_src_fdate_nw);
  EXPORT INTEGER4  mpp_src_fdate_nw_mth         := monthdiff(sysdate8, mpp_src_fdate_nw2);
  EXPORT STRING8   mpp_src_ldate_nw             := IF(mpp_src_nw_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_nw_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_nw2            := Models.Common.sas_date(mpp_src_ldate_nw);
  EXPORT INTEGER4  mpp_src_ldate_nw_mth         := monthdiff(sysdate8, mpp_src_ldate_nw2);
  EXPORT INTEGER4  mpp_src_pl_pos               := Models.Common.findw_cpp(pp_src_list, 'PL' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_pl                   := mpp_src_pl_pos > 0;
  EXPORT STRING8   mpp_src_fdate_pl             := IF(mpp_src_pl_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_pl_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_pl2            := Models.Common.sas_date(mpp_src_fdate_pl);
  EXPORT INTEGER4  mpp_src_fdate_pl_mth         := monthdiff(sysdate8, mpp_src_fdate_pl2);
  EXPORT STRING8   mpp_src_ldate_pl             := IF(mpp_src_pl_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_pl_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_pl2            := Models.Common.sas_date(mpp_src_ldate_pl);
  EXPORT INTEGER4  mpp_src_ldate_pl_mth         := monthdiff(sysdate8, mpp_src_ldate_pl2);
  EXPORT INTEGER4  mpp_src_pn_pos               := Models.Common.findw_cpp(pp_src_list, 'PN' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_pn                   := mpp_src_pn_pos > 0;
  EXPORT STRING8   mpp_src_fdate_pn             := IF(mpp_src_pn_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_pn_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_pn2            := Models.Common.sas_date(mpp_src_fdate_pn);
  EXPORT INTEGER4  mpp_src_fdate_pn_mth         := monthdiff(sysdate8, mpp_src_fdate_pn2);
  EXPORT STRING8   mpp_src_ldate_pn             := IF(mpp_src_pn_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_pn_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_pn2            := Models.Common.sas_date(mpp_src_ldate_pn);
  EXPORT INTEGER4  mpp_src_ldate_pn_mth         := monthdiff(sysdate8, mpp_src_ldate_pn2);
  EXPORT INTEGER4  mpp_src_pq_pos               := Models.Common.findw_cpp(pp_src_list, 'PQ' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_pq                   := mpp_src_pq_pos > 0;
  EXPORT STRING8   mpp_src_fdate_pq             := IF(mpp_src_pq_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_pq_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_pq2            := Models.Common.sas_date(mpp_src_fdate_pq);
  EXPORT INTEGER4  mpp_src_fdate_pq_mth         := monthdiff(sysdate8, mpp_src_fdate_pq2);
  EXPORT STRING8   mpp_src_ldate_pq             := IF(mpp_src_pq_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_pq_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_pq2            := Models.Common.sas_date(mpp_src_ldate_pq);
  EXPORT INTEGER4  mpp_src_ldate_pq_mth         := monthdiff(sysdate8, mpp_src_ldate_pq2);
  EXPORT INTEGER4  mpp_src_sl_pos               := Models.Common.findw_cpp(pp_src_list, 'SL' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_sl                   := mpp_src_sl_pos > 0;
  EXPORT STRING8   mpp_src_fdate_sl             := IF(mpp_src_sl_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_sl_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_sl2            := Models.Common.sas_date(mpp_src_fdate_sl);
  EXPORT INTEGER4  mpp_src_fdate_sl_mth         := monthdiff(sysdate8, mpp_src_fdate_sl2);
  EXPORT STRING8   mpp_src_ldate_sl             := IF(mpp_src_sl_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_sl_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_sl2            := Models.Common.sas_date(mpp_src_ldate_sl);
  EXPORT INTEGER4  mpp_src_ldate_sl_mth         := monthdiff(sysdate8, mpp_src_ldate_sl2);
  EXPORT INTEGER4  mpp_src_sv_pos               := Models.Common.findw_cpp(pp_src_list, 'SV' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_sv                   := mpp_src_sv_pos > 0;
  EXPORT STRING8   mpp_src_fdate_sv             := IF(mpp_src_sv_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_sv_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_sv2            := Models.Common.sas_date(mpp_src_fdate_sv);
  EXPORT INTEGER4  mpp_src_fdate_sv_mth         := monthdiff(sysdate8, mpp_src_fdate_sv2);
  EXPORT STRING8   mpp_src_ldate_sv             := IF(mpp_src_sv_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_sv_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_sv2            := Models.Common.sas_date(mpp_src_ldate_sv);
  EXPORT INTEGER4  mpp_src_ldate_sv_mth         := monthdiff(sysdate8, mpp_src_ldate_sv2);
  EXPORT INTEGER4  mpp_src_t_pos                := Models.Common.findw_cpp(pp_src_list, 'T$' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_t                    := mpp_src_t_pos > 0;
  EXPORT STRING8   mpp_src_fdate_t              := IF(mpp_src_t_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_t_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_t2             := Models.Common.sas_date(mpp_src_fdate_t);
  EXPORT INTEGER4  mpp_src_fdate_t_mth          := monthdiff(sysdate8, mpp_src_fdate_t2);
  EXPORT STRING8   mpp_src_ldate_t              := IF(mpp_src_t_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_t_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_t2             := Models.Common.sas_date(mpp_src_ldate_t);
  EXPORT INTEGER4  mpp_src_ldate_t_mth          := monthdiff(sysdate8, mpp_src_ldate_t2);
  EXPORT INTEGER4  mpp_src_tm_pos               := Models.Common.findw_cpp(pp_src_list, 'TM' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_tm                   := mpp_src_tm_pos > 0;
  EXPORT STRING8   mpp_src_fdate_tm             := IF(mpp_src_tm_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_tm_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_tm2            := Models.Common.sas_date(mpp_src_fdate_tm);
  EXPORT INTEGER4  mpp_src_fdate_tm_mth         := monthdiff(sysdate8, mpp_src_fdate_tm2);
  EXPORT STRING8   mpp_src_ldate_tm             := IF(mpp_src_tm_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_tm_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_tm2            := Models.Common.sas_date(mpp_src_ldate_tm);
  EXPORT INTEGER4  mpp_src_ldate_tm_mth         := monthdiff(sysdate8, mpp_src_ldate_tm2);
  EXPORT INTEGER4  mpp_src_tn_pos               := Models.Common.findw_cpp(pp_src_list, 'TN' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_tn                   := mpp_src_tn_pos > 0;
  EXPORT STRING8   mpp_src_fdate_tn             := IF(mpp_src_tn_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_tn_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_tn2            := Models.Common.sas_date(mpp_src_fdate_tn);
  EXPORT INTEGER4  mpp_src_fdate_tn_mth         := monthdiff(sysdate8, mpp_src_fdate_tn2);
  EXPORT STRING8   mpp_src_ldate_tn             := IF(mpp_src_tn_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_tn_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_tn2            := Models.Common.sas_date(mpp_src_ldate_tn);
  EXPORT INTEGER4  mpp_src_ldate_tn_mth         := monthdiff(sysdate8, mpp_src_ldate_tn2);
  EXPORT INTEGER4  mpp_src_ts_pos               := Models.Common.findw_cpp(pp_src_list, 'TS' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ts                   := mpp_src_ts_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ts             := IF(mpp_src_ts_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ts_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ts2            := Models.Common.sas_date(mpp_src_fdate_ts);
  EXPORT INTEGER4  mpp_src_fdate_ts_mth         := monthdiff(sysdate8, mpp_src_fdate_ts2);
  EXPORT STRING8   mpp_src_ldate_ts             := IF(mpp_src_ts_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ts_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ts2            := Models.Common.sas_date(mpp_src_ldate_ts);
  EXPORT INTEGER4  mpp_src_ldate_ts_mth         := monthdiff(sysdate8, mpp_src_ldate_ts2);
  EXPORT INTEGER4  mpp_src_ut_pos               := Models.Common.findw_cpp(pp_src_list, 'UT' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ut                   := mpp_src_ut_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ut             := IF(mpp_src_ut_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ut_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ut2            := Models.Common.sas_date(mpp_src_fdate_ut);
  EXPORT INTEGER4  mpp_src_fdate_ut_mth         := monthdiff(sysdate8, mpp_src_fdate_ut2);
  EXPORT STRING8   mpp_src_ldate_ut             := IF(mpp_src_ut_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ut_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ut2            := Models.Common.sas_date(mpp_src_ldate_ut);
  EXPORT INTEGER4  mpp_src_ldate_ut_mth         := monthdiff(sysdate8, mpp_src_ldate_ut2);
  EXPORT INTEGER4  mpp_src_uw_pos               := Models.Common.findw_cpp(pp_src_list, 'UW' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_uw                   := mpp_src_uw_pos > 0;
  EXPORT STRING8   mpp_src_fdate_uw             := IF(mpp_src_uw_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_uw_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_uw2            := Models.Common.sas_date(mpp_src_fdate_uw);
  EXPORT INTEGER4  mpp_src_fdate_uw_mth         := monthdiff(sysdate8, mpp_src_fdate_uw2);
  EXPORT STRING8   mpp_src_ldate_uw             := IF(mpp_src_uw_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_uw_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_uw2            := Models.Common.sas_date(mpp_src_ldate_uw);
  EXPORT INTEGER4  mpp_src_ldate_uw_mth         := monthdiff(sysdate8, mpp_src_ldate_uw2);
  EXPORT INTEGER4  mpp_src_vo_pos               := Models.Common.findw_cpp(pp_src_list, 'VO' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_vo                   := mpp_src_vo_pos > 0;
  EXPORT STRING8   mpp_src_fdate_vo             := IF(mpp_src_vo_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_vo_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_vo2            := Models.Common.sas_date(mpp_src_fdate_vo);
  EXPORT INTEGER4  mpp_src_fdate_vo_mth         := monthdiff(sysdate8, mpp_src_fdate_vo2);
  EXPORT STRING8   mpp_src_ldate_vo             := IF(mpp_src_vo_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_vo_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_vo2            := Models.Common.sas_date(mpp_src_ldate_vo);
  EXPORT INTEGER4  mpp_src_ldate_vo_mth         := monthdiff(sysdate8, mpp_src_ldate_vo2);
  EXPORT INTEGER4  mpp_src_vw_pos               := Models.Common.findw_cpp(pp_src_list, 'VW' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_vw                   := mpp_src_vw_pos > 0;
  EXPORT STRING8   mpp_src_fdate_vw             := IF(mpp_src_vw_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_vw_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_vw2            := Models.Common.sas_date(mpp_src_fdate_vw);
  EXPORT INTEGER4  mpp_src_fdate_vw_mth         := monthdiff(sysdate8, mpp_src_fdate_vw2);
  EXPORT STRING8   mpp_src_ldate_vw             := IF(mpp_src_vw_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_vw_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_vw2            := Models.Common.sas_date(mpp_src_ldate_vw);
  EXPORT INTEGER4  mpp_src_ldate_vw_mth         := monthdiff(sysdate8, mpp_src_ldate_vw2);
  EXPORT INTEGER4  mpp_src_wo_pos               := Models.Common.findw_cpp(pp_src_list, 'WO' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_wo                   := mpp_src_wo_pos > 0;
  EXPORT STRING8   mpp_src_fdate_wo             := IF(mpp_src_wo_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_wo_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_wo2            := Models.Common.sas_date(mpp_src_fdate_wo);
  EXPORT INTEGER4  mpp_src_fdate_wo_mth         := monthdiff(sysdate8, mpp_src_fdate_wo2);
  EXPORT STRING8   mpp_src_ldate_wo             := IF(mpp_src_wo_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_wo_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_wo2            := Models.Common.sas_date(mpp_src_ldate_wo);
  EXPORT INTEGER4  mpp_src_ldate_wo_mth         := monthdiff(sysdate8, mpp_src_ldate_wo2);
  EXPORT INTEGER4  mpp_src_wp_pos               := Models.Common.findw_cpp(pp_src_list, 'WP' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_wp                   := mpp_src_wp_pos > 0;
  EXPORT STRING8   mpp_src_fdate_wp             := IF(mpp_src_wp_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_wp_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_wp2            := Models.Common.sas_date(mpp_src_fdate_wp);
  EXPORT INTEGER4  mpp_src_fdate_wp_mth         := monthdiff(sysdate8, mpp_src_fdate_wp2);
  EXPORT STRING8   mpp_src_ldate_wp             := IF(mpp_src_wp_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_wp_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_wp2            := Models.Common.sas_date(mpp_src_ldate_wp);
  EXPORT INTEGER4  mpp_src_ldate_wp_mth         := monthdiff(sysdate8, mpp_src_ldate_wp2);
  EXPORT INTEGER4  mpp_src_wr_pos               := Models.Common.findw_cpp(pp_src_list, 'WR' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_wr                   := mpp_src_wr_pos > 0;
  EXPORT STRING8   mpp_src_fdate_wr             := IF(mpp_src_wr_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_wr_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_wr2            := Models.Common.sas_date(mpp_src_fdate_wr);
  EXPORT INTEGER4  mpp_src_fdate_wr_mth         := monthdiff(sysdate8, mpp_src_fdate_wr2);
  EXPORT STRING8   mpp_src_ldate_wr             := IF(mpp_src_wr_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_wr_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_wr2            := Models.Common.sas_date(mpp_src_ldate_wr);
  EXPORT INTEGER4  mpp_src_ldate_wr_mth         := monthdiff(sysdate8, mpp_src_ldate_wr2);
  EXPORT INTEGER4  mpp_src_ye_pos               := Models.Common.findw_cpp(pp_src_list, 'YE' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_ye                   := mpp_src_ye_pos > 0;
  EXPORT STRING8   mpp_src_fdate_ye             := IF(mpp_src_ye_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_ye_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_ye2            := Models.Common.sas_date(mpp_src_fdate_ye);
  EXPORT INTEGER4  mpp_src_fdate_ye_mth         := monthdiff(sysdate8, mpp_src_fdate_ye2);
  EXPORT STRING8   mpp_src_ldate_ye             := IF(mpp_src_ye_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_ye_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_ye2            := Models.Common.sas_date(mpp_src_ldate_ye);
  EXPORT INTEGER4  mpp_src_ldate_ye_mth         := monthdiff(sysdate8, mpp_src_ldate_ye2);
  EXPORT INTEGER4  mpp_src_zk_pos               := Models.Common.findw_cpp(pp_src_list, 'ZK' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_zk                   := mpp_src_zk_pos > 0;
  EXPORT STRING8   mpp_src_fdate_zk             := IF(mpp_src_zk_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_zk_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_zk2            := Models.Common.sas_date(mpp_src_fdate_zk);
  EXPORT INTEGER4  mpp_src_fdate_zk_mth         := monthdiff(sysdate8, mpp_src_fdate_zk2);
  EXPORT STRING8   mpp_src_ldate_zk             := IF(mpp_src_zk_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_zk_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_zk2            := Models.Common.sas_date(mpp_src_ldate_zk);
  EXPORT INTEGER4  mpp_src_ldate_zk_mth         := monthdiff(sysdate8, mpp_src_ldate_zk2);
  EXPORT INTEGER4  mpp_src_zt_pos               := Models.Common.findw_cpp(pp_src_list, 'ZT' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_zt                   := mpp_src_zt_pos > 0;
  EXPORT STRING8   mpp_src_fdate_zt             := IF(mpp_src_zt_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_zt_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_zt2            := Models.Common.sas_date(mpp_src_fdate_zt);
  EXPORT INTEGER4  mpp_src_fdate_zt_mth         := monthdiff(sysdate8, mpp_src_fdate_zt2);
  EXPORT STRING8   mpp_src_ldate_zt             := IF(mpp_src_zt_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_zt_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_zt2            := Models.Common.sas_date(mpp_src_ldate_zt);
  EXPORT INTEGER4  mpp_src_ldate_zt_mth         := monthdiff(sysdate8, mpp_src_ldate_zt2);
  EXPORT INTEGER4  mpp_src_01_pos               := Models.Common.findw_cpp(pp_src_list, '01' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_01                   := mpp_src_01_pos > 0;
  EXPORT STRING8   mpp_src_fdate_01             := IF(mpp_src_01_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_01_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_012            := Models.Common.sas_date(mpp_src_fdate_01);
  EXPORT INTEGER4  mpp_src_fdate_01_mth         := monthdiff(sysdate8, mpp_src_fdate_012);
  EXPORT STRING8   mpp_src_ldate_01             := IF(mpp_src_01_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_01_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_012            := Models.Common.sas_date(mpp_src_ldate_01);
  EXPORT INTEGER4  mpp_src_ldate_01_mth         := monthdiff(sysdate8, mpp_src_ldate_012);
  EXPORT INTEGER4  mpp_src_02_pos               := Models.Common.findw_cpp(pp_src_list, '02' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_02                   := mpp_src_02_pos > 0;
  EXPORT STRING8   mpp_src_fdate_02             := IF(mpp_src_02_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_02_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_022            := Models.Common.sas_date(mpp_src_fdate_02);
  EXPORT INTEGER4  mpp_src_fdate_02_mth         := monthdiff(sysdate8, mpp_src_fdate_022);
  EXPORT STRING8   mpp_src_ldate_02             := IF(mpp_src_02_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_02_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_022            := Models.Common.sas_date(mpp_src_ldate_02);
  EXPORT INTEGER4  mpp_src_ldate_02_mth         := monthdiff(sysdate8, mpp_src_ldate_022);
  EXPORT INTEGER4  mpp_src_05_pos               := Models.Common.findw_cpp(pp_src_list, '05' , '  ,', 'ie');
  EXPORT BOOLEAN   mpp_src_05                   := mpp_src_05_pos > 0;
  EXPORT STRING8   mpp_src_fdate_05             := IF(mpp_src_05_pos > 0, Models.Common.getw(pp_datefirstseen, mpp_src_05_pos), '0');
  EXPORT INTEGER4  mpp_src_fdate_052            := Models.Common.sas_date(mpp_src_fdate_05);
  EXPORT INTEGER4  mpp_src_fdate_05_mth         := monthdiff(sysdate8, mpp_src_fdate_052);
  EXPORT STRING8   mpp_src_ldate_05             := IF(mpp_src_05_pos > 0, Models.Common.getw(pp_datelastseen, mpp_src_05_pos), '0');
  EXPORT INTEGER4  mpp_src_ldate_052            := Models.Common.sas_date(mpp_src_ldate_05);
  EXPORT INTEGER4  mpp_src_ldate_05_mth         := monthdiff(sysdate8, mpp_src_ldate_052);
  EXPORT INTEGER4  mpp_src_vend_iq_pos          := Models.Common.findw_cpp(pp_src_list, 'IQ' , '  ,', 'ie');
  EXPORT STRING8   mpp_src_vend_fdate_iq        := IF(mpp_src_vend_iq_pos > 0, Models.Common.getw(pp_datevendorfirstseen, mpp_src_vend_iq_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_fdate_iq2       := Models.Common.sas_date(mpp_src_vend_fdate_iq);
  EXPORT INTEGER4  mpp_src_vend_fdate_iq_mth    := monthdiff(sysdate8, mpp_src_vend_fdate_iq2);
  EXPORT STRING8   mpp_src_vend_ldate_iq        := IF(mpp_src_vend_iq_pos > 0, Models.Common.getw(pp_datevendorlastseen, mpp_src_vend_iq_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_ldate_iq2       := Models.Common.sas_date(mpp_src_vend_ldate_iq);
  EXPORT INTEGER4  mpp_src_vend_ldate_iq_mth    := monthdiff(sysdate8, mpp_src_vend_ldate_iq2);
  EXPORT INTEGER4  mpp_src_vend_ir_pos          := Models.Common.findw_cpp(pp_src_list, 'IR' , '  ,', 'ie');
  EXPORT STRING8   mpp_src_vend_fdate_ir        := IF(mpp_src_vend_ir_pos > 0, Models.Common.getw(pp_datevendorfirstseen, mpp_src_vend_ir_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_fdate_ir2       := Models.Common.sas_date(mpp_src_vend_fdate_ir);
  EXPORT INTEGER4  mpp_src_vend_fdate_ir_mth    := monthdiff(sysdate8, mpp_src_vend_fdate_ir2);
  EXPORT STRING8   mpp_src_vend_ldate_ir        := IF(mpp_src_vend_ir_pos > 0, Models.Common.getw(pp_datevendorlastseen, mpp_src_vend_ir_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_ldate_ir2       := Models.Common.sas_date(mpp_src_vend_ldate_ir);
  EXPORT INTEGER4  mpp_src_vend_ldate_ir_mth    := monthdiff(sysdate8, mpp_src_vend_ldate_ir2);
  EXPORT INTEGER4  mpp_src_vend_n2_pos          := Models.Common.findw_cpp(pp_src_list, 'N2' , '  ,', 'ie');
  EXPORT STRING8   mpp_src_vend_fdate_n2        := IF(mpp_src_vend_n2_pos > 0, Models.Common.getw(pp_datevendorfirstseen, mpp_src_vend_n2_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_fdate_n22       := Models.Common.sas_date(mpp_src_vend_fdate_n2);
  EXPORT INTEGER4  mpp_src_vend_fdate_n2_mth    := monthdiff(sysdate8, mpp_src_vend_fdate_n22);
  EXPORT INTEGER4  mpp_src_vend_ut_pos          := Models.Common.findw_cpp(pp_src_list, 'UT' , '  ,', 'ie');
  EXPORT STRING8   mpp_src_vend_fdate_ut        := IF(mpp_src_vend_ut_pos > 0, Models.Common.getw(pp_datevendorfirstseen, mpp_src_vend_ut_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_fdate_ut2       := Models.Common.sas_date(mpp_src_vend_fdate_ut);
  EXPORT INTEGER4  mpp_src_vend_fdate_ut_mth    := monthdiff(sysdate8, mpp_src_vend_fdate_ut2);
  EXPORT STRING8   mpp_src_vend_ldate_ut        := IF(mpp_src_vend_ut_pos > 0, Models.Common.getw(pp_datevendorlastseen, mpp_src_vend_ut_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_ldate_ut2       := Models.Common.sas_date(mpp_src_vend_ldate_ut);
  EXPORT INTEGER4  mpp_src_vend_ldate_ut_mth    := monthdiff(sysdate8, mpp_src_vend_ldate_ut2);
  EXPORT INTEGER4  mpp_src_vend_uw_pos          := Models.Common.findw_cpp(pp_src_list, 'UW' , '  ,', 'ie');
  EXPORT STRING8   mpp_src_vend_fdate_uw        := IF(mpp_src_vend_uw_pos > 0, Models.Common.getw(pp_datevendorfirstseen, mpp_src_vend_uw_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_fdate_uw2       := Models.Common.sas_date(mpp_src_vend_fdate_uw);
  EXPORT INTEGER4  mpp_src_vend_fdate_uw_mth    := monthdiff(sysdate8, mpp_src_vend_fdate_uw2);
  EXPORT STRING8   mpp_src_vend_ldate_uw        := IF(mpp_src_vend_uw_pos > 0, Models.Common.getw(pp_datevendorlastseen, mpp_src_vend_uw_pos), '0');
  EXPORT INTEGER4  mpp_src_vend_ldate_uw2       := Models.Common.sas_date(mpp_src_vend_ldate_uw);
  EXPORT INTEGER4  mpp_src_vend_ldate_uw_mth    := monthdiff(sysdate8, mpp_src_vend_ldate_uw2);
  EXPORT UNSIGNED1 mpp_rule_disconnected_eda    := IF(pp_rules[3..3] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_high_conf_infutor   := IF(pp_rules[7..7] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_low_conf_infutor    := IF(pp_rules[8..8] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_cellphone_latest    := IF(pp_rules[9..9] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_source_latest       := IF(pp_rules[14..14] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_med_vend_conf_cell  := IF(pp_rules[15..15] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_gong_disc           := IF(pp_rules[21..21] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_fb_disc             := IF(pp_rules[22..22] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_inq_lex_diff        := IF(pp_rules[24..24] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_inq_lex_match       := IF(pp_rules[25..25] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_ins_ver_above       := IF(pp_rules[26..26] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_ins_ver_below       := IF(pp_rules[27..27] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_f1_ver_above        := IF(pp_rules[28..28] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_rule_f1_ver_below        := IF(pp_rules[29..29] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a1      := IF(pp_rules[37..37] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a2      := IF(pp_rules[38..38] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a3      := IF(pp_rules[39..39] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a4      := IF(pp_rules[40..40] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a5      := IF(pp_rules[41..41] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a6      := IF(pp_rules[42..42] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_a7      := IF(pp_rules[43..43] = '1', 1, 0);
  EXPORT UNSIGNED1 _mpp_rule_neu_status_u       := IF(pp_rules[51..51] = '1', 1, 0);
  EXPORT UNSIGNED1 mpp_type_mobile              := IF(pp_type = 'M', 1, 0);
  EXPORT INTEGER4  mpp_src_ldate_overall_mth    := IF(mpp_src_cnt = 0, NULL, 
                                                      IF(MAX(mpp_src_ldate_ao_mth, mpp_src_ldate_bw_mth, mpp_src_ldate_cy_mth, mpp_src_ldate_dw_mth, 
                                                             mpp_src_ldate_e1_mth, mpp_src_ldate_e2_mth, mpp_src_ldate_e4_mth, mpp_src_ldate_eb_mth, 
                                                             mpp_src_ldate_em_mth, mpp_src_ldate_en_mth, mpp_src_ldate_eq_mth, mpp_src_ldate_fa_mth, 
                                                             mpp_src_ldate_fe_mth, mpp_src_ldate_ff_mth, mpp_src_ldate_go_mth, mpp_src_ldate_ib_mth, 
                                                             mpp_src_ldate_io_mth, mpp_src_ldate_iq_mth, mpp_src_ldate_ir_mth, mpp_src_ldate_kw_mth, 
                                                             mpp_src_ldate_l9_mth, mpp_src_ldate_la_mth, mpp_src_ldate_lp_mth, mpp_src_ldate_md_mth, 
                                                             mpp_src_ldate_n2_mth, mpp_src_ldate_nw_mth, mpp_src_ldate_pl_mth, mpp_src_ldate_pn_mth, 
                                                             mpp_src_ldate_pq_mth, mpp_src_ldate_sl_mth, mpp_src_ldate_sv_mth, mpp_src_ldate_t_mth, 
                                                             mpp_src_ldate_tm_mth, mpp_src_ldate_tn_mth, mpp_src_ldate_ts_mth, mpp_src_ldate_ut_mth, 
                                                             mpp_src_ldate_uw_mth, mpp_src_ldate_vo_mth, mpp_src_ldate_vw_mth, mpp_src_ldate_wo_mth, 
                                                             mpp_src_ldate_wp_mth, mpp_src_ldate_wr_mth, mpp_src_ldate_ye_mth, mpp_src_ldate_zk_mth, 
                                                             mpp_src_ldate_zt_mth, mpp_src_ldate_01_mth, mpp_src_ldate_02_mth, mpp_src_ldate_05_mth
                                                            ) = NULL, NULL, 
                                                         MIN(IF(mpp_src_ldate_ao_mth = NULL, -NULL, mpp_src_ldate_ao_mth), IF(mpp_src_ldate_bw_mth = NULL, -NULL, mpp_src_ldate_bw_mth), 
                                                             IF(mpp_src_ldate_cy_mth = NULL, -NULL, mpp_src_ldate_cy_mth), IF(mpp_src_ldate_dw_mth = NULL, -NULL, mpp_src_ldate_dw_mth), 
                                                             IF(mpp_src_ldate_e1_mth = NULL, -NULL, mpp_src_ldate_e1_mth), IF(mpp_src_ldate_e2_mth = NULL, -NULL, mpp_src_ldate_e2_mth), 
                                                             IF(mpp_src_ldate_e4_mth = NULL, -NULL, mpp_src_ldate_e4_mth), IF(mpp_src_ldate_eb_mth = NULL, -NULL, mpp_src_ldate_eb_mth), 
                                                             IF(mpp_src_ldate_em_mth = NULL, -NULL, mpp_src_ldate_em_mth), IF(mpp_src_ldate_en_mth = NULL, -NULL, mpp_src_ldate_en_mth), 
                                                             IF(mpp_src_ldate_eq_mth = NULL, -NULL, mpp_src_ldate_eq_mth), IF(mpp_src_ldate_fa_mth = NULL, -NULL, mpp_src_ldate_fa_mth), 
                                                             IF(mpp_src_ldate_fe_mth = NULL, -NULL, mpp_src_ldate_fe_mth), IF(mpp_src_ldate_ff_mth = NULL, -NULL, mpp_src_ldate_ff_mth), 
                                                             IF(mpp_src_ldate_go_mth = NULL, -NULL, mpp_src_ldate_go_mth), IF(mpp_src_ldate_ib_mth = NULL, -NULL, mpp_src_ldate_ib_mth), 
                                                             IF(mpp_src_ldate_io_mth = NULL, -NULL, mpp_src_ldate_io_mth), IF(mpp_src_ldate_iq_mth = NULL, -NULL, mpp_src_ldate_iq_mth), 
                                                             IF(mpp_src_ldate_ir_mth = NULL, -NULL, mpp_src_ldate_ir_mth), IF(mpp_src_ldate_kw_mth = NULL, -NULL, mpp_src_ldate_kw_mth), 
                                                             IF(mpp_src_ldate_l9_mth = NULL, -NULL, mpp_src_ldate_l9_mth), IF(mpp_src_ldate_la_mth = NULL, -NULL, mpp_src_ldate_la_mth), 
                                                             IF(mpp_src_ldate_lp_mth = NULL, -NULL, mpp_src_ldate_lp_mth), IF(mpp_src_ldate_md_mth = NULL, -NULL, mpp_src_ldate_md_mth), 
                                                             IF(mpp_src_ldate_n2_mth = NULL, -NULL, mpp_src_ldate_n2_mth), IF(mpp_src_ldate_nw_mth = NULL, -NULL, mpp_src_ldate_nw_mth), 
                                                             IF(mpp_src_ldate_pl_mth = NULL, -NULL, mpp_src_ldate_pl_mth), IF(mpp_src_ldate_pn_mth = NULL, -NULL, mpp_src_ldate_pn_mth), 
                                                             IF(mpp_src_ldate_pq_mth = NULL, -NULL, mpp_src_ldate_pq_mth), IF(mpp_src_ldate_sl_mth = NULL, -NULL, mpp_src_ldate_sl_mth), 
                                                             IF(mpp_src_ldate_sv_mth = NULL, -NULL, mpp_src_ldate_sv_mth), IF(mpp_src_ldate_t_mth = NULL, -NULL, mpp_src_ldate_t_mth), 
                                                             IF(mpp_src_ldate_tm_mth = NULL, -NULL, mpp_src_ldate_tm_mth), IF(mpp_src_ldate_tn_mth = NULL, -NULL, mpp_src_ldate_tn_mth), 
                                                             IF(mpp_src_ldate_ts_mth = NULL, -NULL, mpp_src_ldate_ts_mth), IF(mpp_src_ldate_ut_mth = NULL, -NULL, mpp_src_ldate_ut_mth), 
                                                             IF(mpp_src_ldate_uw_mth = NULL, -NULL, mpp_src_ldate_uw_mth), IF(mpp_src_ldate_vo_mth = NULL, -NULL, mpp_src_ldate_vo_mth), 
                                                             IF(mpp_src_ldate_vw_mth = NULL, -NULL, mpp_src_ldate_vw_mth), IF(mpp_src_ldate_wo_mth = NULL, -NULL, mpp_src_ldate_wo_mth), 
                                                             IF(mpp_src_ldate_wp_mth = NULL, -NULL, mpp_src_ldate_wp_mth), IF(mpp_src_ldate_wr_mth = NULL, -NULL, mpp_src_ldate_wr_mth), 
                                                             IF(mpp_src_ldate_ye_mth = NULL, -NULL, mpp_src_ldate_ye_mth), IF(mpp_src_ldate_zk_mth = NULL, -NULL, mpp_src_ldate_zk_mth), 
                                                             IF(mpp_src_ldate_zt_mth = NULL, -NULL, mpp_src_ldate_zt_mth), IF(mpp_src_ldate_01_mth = NULL, -NULL, mpp_src_ldate_01_mth), 
                                                             IF(mpp_src_ldate_02_mth = NULL, -NULL, mpp_src_ldate_02_mth), IF(mpp_src_ldate_05_mth = NULL, -NULL, mpp_src_ldate_05_mth)
                                                            )));
  EXPORT INTEGER4  mpp_src_fdate_overall_mth    := IF(mpp_src_cnt = 0, NULL, 
                                                      MAX(mpp_src_fdate_ao_mth, mpp_src_fdate_bw_mth, mpp_src_fdate_cy_mth, mpp_src_fdate_dw_mth, 
                                                          mpp_src_fdate_e1_mth, mpp_src_fdate_e2_mth, mpp_src_fdate_e4_mth, mpp_src_fdate_eb_mth, 
                                                          mpp_src_fdate_em_mth, mpp_src_fdate_en_mth, mpp_src_fdate_eq_mth, mpp_src_fdate_fa_mth, 
                                                          mpp_src_fdate_fe_mth, mpp_src_fdate_ff_mth, mpp_src_fdate_go_mth, mpp_src_fdate_ib_mth, 
                                                          mpp_src_fdate_io_mth, mpp_src_fdate_iq_mth, mpp_src_fdate_ir_mth, mpp_src_fdate_kw_mth, 
                                                          mpp_src_fdate_l9_mth, mpp_src_fdate_la_mth, mpp_src_fdate_lp_mth, mpp_src_fdate_md_mth, 
                                                          mpp_src_fdate_n2_mth, mpp_src_fdate_nw_mth, mpp_src_fdate_pl_mth, mpp_src_fdate_pn_mth, 
                                                          mpp_src_fdate_pq_mth, mpp_src_fdate_sl_mth, mpp_src_fdate_sv_mth, mpp_src_fdate_t_mth, 
                                                          mpp_src_fdate_tm_mth, mpp_src_fdate_tn_mth, mpp_src_fdate_ts_mth, mpp_src_fdate_ut_mth, 
                                                          mpp_src_fdate_uw_mth, mpp_src_fdate_vo_mth, mpp_src_fdate_vw_mth, mpp_src_fdate_wo_mth, 
                                                          mpp_src_fdate_wp_mth, mpp_src_fdate_wr_mth, mpp_src_fdate_ye_mth, mpp_src_fdate_zk_mth, 
                                                          mpp_src_fdate_zt_mth, mpp_src_fdate_01_mth, mpp_src_fdate_02_mth, mpp_src_fdate_05_mth
                                                         ));
  // does a bad source exist in the source list
  EXPORT INTEGER4  mpp_src_bad                  := MAP(mpp_src_cnt = 0 => NULL,
                                                       (mpp_src_05 OR mpp_src_bw OR mpp_src_cy OR mpp_src_dw OR mpp_src_e4 OR mpp_src_eb OR 
                                                        mpp_src_en OR mpp_src_eq OR mpp_src_fa OR mpp_src_fe OR mpp_src_ff OR mpp_src_go OR 
                                                        mpp_src_ib OR mpp_src_io OR mpp_src_kw OR mpp_src_la OR mpp_src_lp OR mpp_src_md OR 
                                                        mpp_src_nw OR mpp_src_pn OR mpp_src_pq OR mpp_src_sl OR mpp_src_sv OR mpp_src_t  OR 
                                                        mpp_src_tm OR mpp_src_tn OR mpp_src_ts OR mpp_src_vo OR mpp_src_vw OR mpp_src_wp OR 
                                                        mpp_src_wr OR mpp_src_ye OR mpp_src_zk OR mpp_src_zt)
                                                                       => 1,
                                                                          0);
  // how many bad sources
  EXPORT INTEGER4  mpp_src_bad_cnt              := IF(mpp_src_cnt = 0, NULL,
                                                      IF(mpp_src_bad <= 0, NULL,
                                                         SUM((INTEGER)mpp_src_05, (INTEGER)mpp_src_bw, (INTEGER)mpp_src_cy, (INTEGER)mpp_src_dw,
                                                             (INTEGER)mpp_src_e4, (INTEGER)mpp_src_eb, (INTEGER)mpp_src_en, (INTEGER)mpp_src_eq,
                                                             (INTEGER)mpp_src_fa, (INTEGER)mpp_src_fe, (INTEGER)mpp_src_ff, (INTEGER)mpp_src_go, 
                                                             (INTEGER)mpp_src_ib, (INTEGER)mpp_src_io, (INTEGER)mpp_src_kw, (INTEGER)mpp_src_la,
                                                             (INTEGER)mpp_src_lp, (INTEGER)mpp_src_md, (INTEGER)mpp_src_nw, (INTEGER)mpp_src_pn,
                                                             (INTEGER)mpp_src_pq, (INTEGER)mpp_src_sl, (INTEGER)mpp_src_sv, (INTEGER)mpp_src_t, 
                                                             (INTEGER)mpp_src_tm, (INTEGER)mpp_src_tn, (INTEGER)mpp_src_ts, (INTEGER)mpp_src_vo,
                                                             (INTEGER)mpp_src_vw, (INTEGER)mpp_src_wp, (INTEGER)mpp_src_wr, (INTEGER)mpp_src_ye,
                                                             (INTEGER)mpp_src_zk, (INTEGER)mpp_src_zt
                                                            )));
  // does a good source exist in the source list
  EXPORT INTEGER4  mpp_src_good                 := MAP(mpp_src_cnt = 0 => NULL,
                                                       (mpp_src_01 OR mpp_src_02 OR mpp_src_ao OR mpp_src_e1 OR mpp_src_e2 OR mpp_src_em OR 
                                                        mpp_src_iq OR mpp_src_ir OR mpp_src_l9 OR mpp_src_n2 OR mpp_src_pl OR mpp_src_ut OR 
                                                        mpp_src_uw OR mpp_src_wo)
                                                                       => 1,
                                                                          0);
  // how many good sources
  EXPORT INTEGER4  mpp_src_good_cnt             := IF(mpp_src_cnt = 0, NULL, 
                                                      IF(mpp_src_good <= 0, NULL, 
                                                         SUM((INTEGER)mpp_src_01, (INTEGER)mpp_src_02, (INTEGER)mpp_src_ao, (INTEGER)mpp_src_e1, 
                                                             (INTEGER)mpp_src_e2, (INTEGER)mpp_src_em, (INTEGER)mpp_src_iq, (INTEGER)mpp_src_ir, 
                                                             (INTEGER)mpp_src_l9, (INTEGER)mpp_src_n2, (INTEGER)mpp_src_pl, (INTEGER)mpp_src_ut, 
                                                             (INTEGER)mpp_src_uw, (INTEGER)mpp_src_wo
                                                            )));
  // latest bad source last seen date
  EXPORT INTEGER4  mpp_src_ldate_bad_mth        := MAP(mpp_src_bad <= 0               => NULL,
                                                       mpp_src_cnt = mpp_src_good_cnt => NULL,
                                                                                         IF(MAX(mpp_src_ldate_05_mth, mpp_src_ldate_bw_mth, mpp_src_ldate_cy_mth, mpp_src_ldate_dw_mth, 
                                                                                                mpp_src_ldate_e4_mth, mpp_src_ldate_eb_mth, mpp_src_ldate_en_mth, mpp_src_ldate_eq_mth, 
                                                                                                mpp_src_ldate_fa_mth, mpp_src_ldate_fe_mth, mpp_src_ldate_ff_mth, mpp_src_ldate_go_mth, 
                                                                                                mpp_src_ldate_ib_mth, mpp_src_ldate_io_mth, mpp_src_ldate_kw_mth, mpp_src_ldate_la_mth, 
                                                                                                mpp_src_ldate_lp_mth, mpp_src_ldate_md_mth, mpp_src_ldate_nw_mth, mpp_src_ldate_pn_mth, 
                                                                                                mpp_src_ldate_pq_mth, mpp_src_ldate_sl_mth, mpp_src_ldate_sv_mth, mpp_src_ldate_t_mth, 
                                                                                                mpp_src_ldate_tm_mth, mpp_src_ldate_tn_mth, mpp_src_ldate_ts_mth, mpp_src_ldate_vo_mth, 
                                                                                                mpp_src_ldate_vw_mth, mpp_src_ldate_wp_mth, mpp_src_ldate_wr_mth, mpp_src_ldate_ye_mth, 
                                                                                                mpp_src_ldate_zk_mth, mpp_src_ldate_zt_mth) = NULL, NULL, 
                                                                                            MIN(IF(mpp_src_ldate_05_mth = NULL, -NULL, mpp_src_ldate_05_mth), IF(mpp_src_ldate_bw_mth = NULL, -NULL, mpp_src_ldate_bw_mth), 
                                                                                                IF(mpp_src_ldate_cy_mth = NULL, -NULL, mpp_src_ldate_cy_mth), IF(mpp_src_ldate_dw_mth = NULL, -NULL, mpp_src_ldate_dw_mth), 
                                                                                                IF(mpp_src_ldate_e4_mth = NULL, -NULL, mpp_src_ldate_e4_mth), IF(mpp_src_ldate_eb_mth = NULL, -NULL, mpp_src_ldate_eb_mth), 
                                                                                                IF(mpp_src_ldate_en_mth = NULL, -NULL, mpp_src_ldate_en_mth), IF(mpp_src_ldate_eq_mth = NULL, -NULL, mpp_src_ldate_eq_mth), 
                                                                                                IF(mpp_src_ldate_fa_mth = NULL, -NULL, mpp_src_ldate_fa_mth), IF(mpp_src_ldate_fe_mth = NULL, -NULL, mpp_src_ldate_fe_mth), 
                                                                                                IF(mpp_src_ldate_ff_mth = NULL, -NULL, mpp_src_ldate_ff_mth), IF(mpp_src_ldate_go_mth = NULL, -NULL, mpp_src_ldate_go_mth), 
                                                                                                IF(mpp_src_ldate_ib_mth = NULL, -NULL, mpp_src_ldate_ib_mth), IF(mpp_src_ldate_io_mth = NULL, -NULL, mpp_src_ldate_io_mth), 
                                                                                                IF(mpp_src_ldate_kw_mth = NULL, -NULL, mpp_src_ldate_kw_mth), IF(mpp_src_ldate_la_mth = NULL, -NULL, mpp_src_ldate_la_mth), 
                                                                                                IF(mpp_src_ldate_lp_mth = NULL, -NULL, mpp_src_ldate_lp_mth), IF(mpp_src_ldate_md_mth = NULL, -NULL, mpp_src_ldate_md_mth), 
                                                                                                IF(mpp_src_ldate_nw_mth = NULL, -NULL, mpp_src_ldate_nw_mth), IF(mpp_src_ldate_pn_mth = NULL, -NULL, mpp_src_ldate_pn_mth), 
                                                                                                IF(mpp_src_ldate_pq_mth = NULL, -NULL, mpp_src_ldate_pq_mth), IF(mpp_src_ldate_sl_mth = NULL, -NULL, mpp_src_ldate_sl_mth), 
                                                                                                IF(mpp_src_ldate_sv_mth = NULL, -NULL, mpp_src_ldate_sv_mth), IF(mpp_src_ldate_t_mth = NULL, -NULL, mpp_src_ldate_t_mth), 
                                                                                                IF(mpp_src_ldate_tm_mth = NULL, -NULL, mpp_src_ldate_tm_mth), IF(mpp_src_ldate_tn_mth = NULL, -NULL, mpp_src_ldate_tn_mth), 
                                                                                                IF(mpp_src_ldate_ts_mth = NULL, -NULL, mpp_src_ldate_ts_mth), IF(mpp_src_ldate_vo_mth = NULL, -NULL, mpp_src_ldate_vo_mth), 
                                                                                                IF(mpp_src_ldate_vw_mth = NULL, -NULL, mpp_src_ldate_vw_mth), IF(mpp_src_ldate_wp_mth = NULL, -NULL, mpp_src_ldate_wp_mth), 
                                                                                                IF(mpp_src_ldate_wr_mth = NULL, -NULL, mpp_src_ldate_wr_mth), IF(mpp_src_ldate_ye_mth = NULL, -NULL, mpp_src_ldate_ye_mth), 
                                                                                                IF(mpp_src_ldate_zk_mth = NULL, -NULL, mpp_src_ldate_zk_mth), IF(mpp_src_ldate_zt_mth = NULL, -NULL, mpp_src_ldate_zt_mth)
                                                                                               )));
  // latest good source last seen date
  EXPORT INTEGER4  mpp_src_ldate_good_mth       := MAP(mpp_src_good <= 0             => NULL,
                                                       mpp_src_cnt = mpp_src_bad_cnt => NULL,
                                                                                        IF(MAX(mpp_src_ldate_01_mth, mpp_src_ldate_02_mth, mpp_src_ldate_ao_mth, mpp_src_ldate_e1_mth, 
                                                                                               mpp_src_ldate_e2_mth, mpp_src_ldate_em_mth, mpp_src_ldate_iq_mth, mpp_src_ldate_ir_mth, 
                                                                                               mpp_src_ldate_l9_mth, mpp_src_ldate_n2_mth, mpp_src_ldate_pl_mth, mpp_src_ldate_ut_mth, 
                                                                                               mpp_src_ldate_uw_mth, mpp_src_ldate_wo_mth) = NULL, NULL, 
                                                                                           MIN(IF(mpp_src_ldate_01_mth = NULL, -NULL, mpp_src_ldate_01_mth), IF(mpp_src_ldate_02_mth = NULL, -NULL, mpp_src_ldate_02_mth), 
                                                                                               IF(mpp_src_ldate_ao_mth = NULL, -NULL, mpp_src_ldate_ao_mth), IF(mpp_src_ldate_e1_mth = NULL, -NULL, mpp_src_ldate_e1_mth), 
                                                                                               IF(mpp_src_ldate_e2_mth = NULL, -NULL, mpp_src_ldate_e2_mth), IF(mpp_src_ldate_em_mth = NULL, -NULL, mpp_src_ldate_em_mth), 
                                                                                               IF(mpp_src_ldate_iq_mth = NULL, -NULL, mpp_src_ldate_iq_mth), IF(mpp_src_ldate_ir_mth = NULL, -NULL, mpp_src_ldate_ir_mth), 
                                                                                               IF(mpp_src_ldate_l9_mth = NULL, -NULL, mpp_src_ldate_l9_mth), IF(mpp_src_ldate_n2_mth = NULL, -NULL, mpp_src_ldate_n2_mth), 
                                                                                               IF(mpp_src_ldate_pl_mth = NULL, -NULL, mpp_src_ldate_pl_mth), IF(mpp_src_ldate_ut_mth = NULL, -NULL, mpp_src_ldate_ut_mth), 
                                                                                               IF(mpp_src_ldate_uw_mth = NULL, -NULL, mpp_src_ldate_uw_mth), IF(mpp_src_ldate_wo_mth = NULL, -NULL, mpp_src_ldate_wo_mth)
                                                                                              )));
  // earliest good source first seen date
  EXPORT INTEGER4  mpp_src_fdate_good_mth       := MAP(mpp_src_cnt = 0               => NULL,
                                                       mpp_src_cnt = mpp_src_bad_cnt => NULL,
                                                                                        MAX(mpp_src_fdate_01_mth, mpp_src_fdate_02_mth, mpp_src_fdate_ao_mth, mpp_src_fdate_e1_mth, 
                                                                                            mpp_src_fdate_e2_mth, mpp_src_fdate_em_mth, mpp_src_fdate_iq_mth, mpp_src_fdate_ir_mth, 
                                                                                            mpp_src_fdate_l9_mth, mpp_src_fdate_n2_mth, mpp_src_fdate_pl_mth, mpp_src_fdate_ut_mth, 
                                                                                            mpp_src_fdate_uw_mth, mpp_src_fdate_wo_mth
                                                                                           ));
  EXPORT INTEGER4  mpp_src_tof_good_mth         := tofcalc(mpp_src_fdate_good_mth, mpp_src_ldate_good_mth);
  EXPORT UNSIGNED1 _pp_app_fb_ph_disc           := IF(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone = 4, 1, 0);
  EXPORT UNSIGNED1 _pp_app_fb_ph7_did_disc      := IF(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID = 4, 1, 0);
  EXPORT UNSIGNED1 _pp_app_fb_ph7_nm_addr_disc  := IF(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr = 4, 1, 0);
  EXPORT UNSIGNED1 _phone_fb_result_disc        := IF(shell_attributes.Phone_Feedback.Phone_Feedback_Result = 4, 1, 0);
  EXPORT UNSIGNED1 _phone_fb_rp_result_disc     := IF(phone_fb_rp_result = 4, 1, 0);
  EXPORT UNSIGNED1 _pp_rule_disc_flag           := IF(SUM(mpp_rule_disconnected_eda, mpp_rule_gong_disc, mpp_rule_fb_disc) > 0, 1, 0);
  EXPORT UNSIGNED1 _pp_app_fb_disc_flag         := IF(SUM(_pp_app_fb_ph_disc, _pp_app_fb_ph7_did_disc, _pp_app_fb_ph7_nm_addr_disc) > 0, 1, 0);
  EXPORT UNSIGNED1 _phone_fb_disc_flag          := IF(SUM(_phone_fb_result_disc, _phone_fb_rp_result_disc) > 0, 1, 0);
  EXPORT UNSIGNED1 p_disconnect_flag            := MAP(SUM((INTEGER)p_phone_disconnected, _pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) = 4 => 4,
                                                       p_phone_disconnected AND SUM(_pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) >= 1      => 3,
                                                       p_phone_disconnected                                                                                  => 2,
                                                       SUM(_pp_rule_disc_flag, _pp_app_fb_disc_flag, _phone_fb_disc_flag) >= 1                               => 1,
                                                                                                                                                                0);
  EXPORT INTEGER4  mpp_rule_neu_active_mth      := MAP(SUM(_mpp_rule_neu_status_a1, _mpp_rule_neu_status_a2, _mpp_rule_neu_status_a3, 
                                                           _mpp_rule_neu_status_a4, _mpp_rule_neu_status_a5, _mpp_rule_neu_status_a6, 
                                                           _mpp_rule_neu_status_a7, _mpp_rule_neu_status_u) = 0                       => NULL,
                                                           _mpp_rule_neu_status_a7 = 1                                                => 12,
                                                           _mpp_rule_neu_status_a6 = 1                                                => 10,
                                                           _mpp_rule_neu_status_a5 = 1                                                => 7,
                                                           _mpp_rule_neu_status_a4 = 1                                                => 4,
                                                           _mpp_rule_neu_status_a3 = 1                                                => 3,
                                                           _mpp_rule_neu_status_a2 = 1                                                => 2,
                                                           _mpp_rule_neu_status_a1 = 1                                                => 1,
                                                                                                                                         0);
  EXPORT UNSIGNED1 mpp_rule_infutor             := mpp_rule_high_conf_infutor + mpp_rule_low_conf_infutor;
  EXPORT UNSIGNED1 mpp_rule_inq_1yr             := mpp_rule_inq_lex_diff + mpp_rule_inq_lex_match;
  EXPORT UNSIGNED1 mpp_rule_ins_ver             := mpp_rule_ins_ver_below + mpp_rule_ins_ver_above;
  EXPORT UNSIGNED1 mpp_rule_f1_ver              := mpp_rule_f1_ver_below + mpp_rule_f1_ver_above;
  EXPORT UNSIGNED1 mpp_did_count                := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_DID_Count;
  EXPORT INTEGER4  mpp_carrier_groups           := carriergroups(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Carrier);
  EXPORT INTEGER4  mpp_carrier_groups_disc      := MAP(mpp_carrier_groups = NULL                          => NULL,
                                                       mpp_carrier_groups IN [2, 5, 6, 9, 12, 13, 16, 18] => 1,
                                                                                                             0);
  EXPORT INTEGER4  mpp_rp_type                  := CASE(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_RP_Type, 
                                                        'B' => 1, 'M' => 2, 'R' => 3, 'U' => 4, NULL);
  EXPORT INTEGER4  mpp_rp_carrier_groups        := carriergroups(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier);
  EXPORT INTEGER4  mpp_rp_carrier_groups_disc   := MAP(mpp_rp_carrier_groups = NULL                          => NULL,
                                                       mpp_rp_carrier_groups IN [2, 5, 6, 9, 12, 13, 16, 18] => 1,
                                                                                                                0);
  EXPORT INTEGER4  mpp_origlisting_type         := CASE(TRIM(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_OrigListingType, LEFT, RIGHT), 
                                                        'B'  => 1, 'BG' => 2, 'G'  => 3, 'R'  => 4, 'RB' => 5, NULL);
  EXPORT INTEGER4  mpp_listing_type             := CASE(TRIM(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_ListingType, LEFT, RIGHT), 
                                                        'B'  => 1, 'BG' => 2, 'G'  => 3, 'R'  => 4, 'RB' => 5, NULL);
  EXPORT INTEGER4  mpp_origphonetype            := CASE(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType, 
                                                        'L' => 1, 'O' => 2, 'P' => 3, 'T' => 4, 'V' => 5, 'W' => 6, NULL);
  EXPORT INTEGER4  mpp_origphoneusage           := CASE(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage, 
                                                        'A' => 1, 'C' => 2, 'D' => 3,  'F' => 4,  'G' => 5,  'H' => 6,  'M' => 7,  
                                                        'O' => 8, 'P' => 9, 'R' => 10, 'S' => 11, 'T' => 12, 'W' => 13, NULL);
  EXPORT UNSIGNED1 mpp_app_company_type         := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
  EXPORT UNSIGNED1 mpp_max_score_infutor        := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score;
  EXPORT UNSIGNED1 mpp_min_score_infutor        := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score;
  EXPORT UNSIGNED1 mpp_orig_score_infutor       := shell_attributes.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score;
  EXPORT UNSIGNED1 mpp_eda_match_did            := IF(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_EDA_Match[3..3] = '1', 1, 0);
  EXPORT INTEGER4  pp_eda_hist_ph_dt2           := Models.Common.sas_date(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt);
  EXPORT INTEGER4  mpp_eda_hist_ph_dt_mth       := monthdiff(sysdate8, pp_eda_hist_ph_dt2);
  EXPORT INTEGER4  pp_eda_hist_did_dt2          := Models.Common.sas_date(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt);
  EXPORT INTEGER4  mpp_eda_hist_did_dt_mth      := monthdiff(sysdate8, pp_eda_hist_did_dt2);
  EXPORT INTEGER4  pp_eda_hist_nm_addr_dt2      := Models.Common.sas_date(shell_attributes.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt);
  EXPORT INTEGER4  mpp_eda_hist_nm_addr_dt_mth  := monthdiff(sysdate8, pp_eda_hist_nm_addr_dt2);
  EXPORT UNSIGNED1 mpp_app_company_type_cell    := IF(mpp_app_company_type in [5, 8], 1, 0);
  EXPORT INTEGER4  phone_fb_rp_date2            := Models.Common.sas_date(shell_attributes.Phone_Feedback.Phone_Feedback_RP_Date);
  EXPORT INTEGER4  pf_rp_date_mth               := monthdiff(sysdate8, phone_fb_rp_date2);
  EXPORT INTEGER4  pf_rp_last_rpc_date_mth      := monthdiff(sysdate8, phone_fb_rp_last_rpc_date2);
  EXPORT INTEGER4  pf_rp_result                 := IF(phone_fb_rp_result = 9, NULL, phone_fb_rp_result);
  EXPORT INTEGER4  minq_indus_12_auto_pos       := Models.Common.findw_cpp(inq_adl_ph_industry_list_12, 'AUTO' , '  ,', 'ie');
  EXPORT BOOLEAN   minq_indus_12_auto           := minq_indus_12_auto_pos > 0;
  EXPORT INTEGER4  minq_indus_12_day_pos        := Models.Common.findw_cpp(inq_adl_ph_industry_list_12, 'DAY' , '  ,', 'ie');
  EXPORT BOOLEAN   minq_indus_12_day            := minq_indus_12_day_pos > 0;
  EXPORT INTEGER4  minq_indus_12_pay_pos        := Models.Common.findw_cpp(inq_adl_ph_industry_list_12, 'PAY' , '  ,', 'ie');
  EXPORT BOOLEAN   minq_indus_12_pay            := minq_indus_12_pay_pos > 0;
  EXPORT UNSIGNED4 minq_cnt                     := (UNSIGNED4)shell_attributes.Inquiries.Inq_Num; // currently can never be NULL, or negative
  EXPORT UNSIGNED4 minq_cnt_06                  := (UNSIGNED4)shell_attributes.Inquiries.Inq_Num_06;
  EXPORT UNSIGNED4 minq_addr_cnt                := (UNSIGNED4)shell_attributes.Inquiries.Inq_Num_Addresses;
  EXPORT UNSIGNED4 minq_addr_cnt_06             := (UNSIGNED4)shell_attributes.Inquiries.Inq_Num_Addresses_06;
  EXPORT UNSIGNED4 minq_did_cnt                 := (UNSIGNED4)shell_attributes.Inquiries.Inq_Num_ADLs;
  EXPORT UNSIGNED4 minq_didph_cnt               := (UNSIGNED4)shell_attributes.Inquiries.Inq_Num_MatchADL;
  EXPORT INTEGER4  minq_fseen_mth               := IF(shell_attributes.Inquiries.Inq_FirstSeen = '', NULL, (INTEGER4)shell_attributes.Inquiries.Inq_FirstSeen); // a count of months
  EXPORT INTEGER4  minq_lseen_mth               := IF(shell_attributes.Inquiries.Inq_LastSeen = '', NULL, (INTEGER4)shell_attributes.Inquiries.Inq_LastSeen); // a count of months
  EXPORT INTEGER4  minq_didph_fseen_mth         := IF(shell_attributes.Inquiries.Inq_ADL_FirstSeen IN ['','0'], NULL, (INTEGER4)shell_attributes.Inquiries.Inq_ADL_FirstSeen); // count of months
  EXPORT INTEGER4  minq_didph_lseen_mth         := IF(shell_attributes.Inquiries.Inq_ADL_LastSeen IN ['','0'], NULL, (INTEGER4)shell_attributes.Inquiries.Inq_ADL_LastSeen); // count of months
  EXPORT INTEGER4  minq_se_did_cnt              := IF(minq_didph_cnt <= 0 AND minq_did_cnt >= 1, minq_did_cnt, NULL);
  EXPORT INTEGER4  minq_se_lseen_mth            := IF(minq_didph_cnt <= 0 AND minq_did_cnt >= 1, minq_lseen_mth, NULL);
  EXPORT BOOLEAN   ins_ver                      := shell_attributes.Internal_Corroboration.Internal_Verification;
  EXPORT INTEGER4  ins_ver_fseen_mth            := monthdiff(sysdate8, ins_ver_fseen2);
  EXPORT INTEGER4  ins_ver_tof_mth              := tofcalc(ins_ver_fseen_mth, ins_ver_lseen_mth);
  EXPORT UNSIGNED1 meda_did_flag                := IF(shell_attributes.EDA_Characteristics.EDA_DID > 0, 1, 0);
  EXPORT UNSIGNED1 meda_hhid_flag               := IF(shell_attributes.EDA_Characteristics.EDA_HHID > 0, 1, 0);
  EXPORT UNSIGNED1 meda_bdid_flag               := IF(shell_attributes.EDA_Characteristics.EDA_BDID > 0, 1, 0);
  EXPORT INTEGER4  meda_dt_fseen_mth            := monthdiff(sysdate8, eda_dt_fseen2);
  EXPORT INTEGER4  meda_dt_lseen_mth            := monthdiff(sysdate8, eda_dt_lseen2);
  EXPORT INTEGER4  meda_tof_mth                 := tofcalc(meda_dt_fseen_mth, meda_dt_lseen_mth);
  EXPORT BOOLEAN   meda_current_eda_flag        := shell_attributes.EDA_Characteristics.EDA_Current_Record_Flag;
  EXPORT INTEGER4  meda_dt_deletion_mth         := monthdiff(sysdate8, eda_deletion_date2);
  EXPORT UNSIGNED1 meda_pfrd_addr_listtype_zip  := CASE(shell_attributes.EDA_Characteristics.EDA_Pfrd_Address_Ind, 
                                                        '1A' => 5, '1B' => 4, '1C' => 3, '1D' => 2, '1E' => 1, 0);
  EXPORT UNSIGNED4 meda_days_in_service         := shell_attributes.EDA_Characteristics.EDA_Days_In_Service;
  EXPORT UNSIGNED2 meda_num_ph_owners_hist      := shell_attributes.EDA_Characteristics.EDA_Num_Phone_Owners_Hist;
  EXPORT UNSIGNED2 meda_num_ph_owners_cur       := shell_attributes.EDA_Characteristics.EDA_Num_Phone_Owners_Cur;
  EXPORT UNSIGNED2 meda_num_phs_ind             := shell_attributes.EDA_Characteristics.EDA_Num_Phones_Indiv;
  EXPORT UNSIGNED4 meda_avg_days_connected_ind  := shell_attributes.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv;
  EXPORT UNSIGNED4 meda_min_days_connected_ind  := shell_attributes.EDA_Characteristics.EDA_Min_Days_Connected_Indiv;
  EXPORT UNSIGNED4 meda_days_ind_first_seen     := shell_attributes.EDA_Characteristics.EDA_Days_Indiv_First_Seen;
  EXPORT UNSIGNED4 meda_days_ph_first_seen      := shell_attributes.EDA_Characteristics.EDA_Days_Phone_First_Seen;
  EXPORT UNSIGNED3 meda_months_addr_last_seen   := shell_attributes.EDA_Characteristics.EDA_Months_Addr_Last_Seen;
  EXPORT UNSIGNED4 meda_num_phs_discon_addr     := shell_attributes.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
  EXPORT UNSIGNED4 meda_num_phs_connected_hhid  := shell_attributes.EDA_Characteristics.EDA_Num_Phones_Connected_HHID;
  EXPORT UNSIGNED4 meda_num_phs_discon_hhid     := shell_attributes.EDA_Characteristics.EDA_Num_Phones_Discon_HHID;
  EXPORT BOOLEAN   meda_is_current_in_hist      := shell_attributes.EDA_Characteristics.EDA_Is_Current_In_Hist;
  EXPORT UNSIGNED2 meda_num_interrupts_cur      := shell_attributes.EDA_Characteristics.EDA_Num_Interrupts_Cur;
  EXPORT UNSIGNED4 meda_avg_days_interrupt      := shell_attributes.EDA_Characteristics.EDA_Avg_Days_Interrupt;
  EXPORT UNSIGNED4 meda_min_days_interrupt      := shell_attributes.EDA_Characteristics.EDA_Min_Days_Interrupt;
  EXPORT UNSIGNED4 meda_max_days_interrupt      := shell_attributes.EDA_Characteristics.EDA_Max_Days_Interrupt;
  EXPORT BOOLEAN   meda_has_cur_discon_15_days  := shell_attributes.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;
  EXPORT BOOLEAN   meda_has_cur_discon_30_days  := shell_attributes.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;
  EXPORT BOOLEAN   meda_has_cur_discon_60_days  := shell_attributes.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;
  EXPORT BOOLEAN   meda_has_cur_discon_90_days  := shell_attributes.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
  EXPORT BOOLEAN   meda_has_cur_discon_180_days := shell_attributes.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
  EXPORT BOOLEAN   md_deact_flag                := (INTEGER)meta_lseen_deact > 0;
  EXPORT BOOLEAN   md_react_flag                := (INTEGER)meta_lseen_react > 0;
  EXPORT BOOLEAN   md_port_flag                 := (INTEGER)meta_lseen_port > 0;
  EXPORT BOOLEAN   md_swap_flag                 := (INTEGER)meta_lseen_swap > 0;
  EXPORT INTEGER4  _meta_lseen_swap             := IF(meta_lseen_swap IN ['','0'], NULL, (UNSIGNED4)meta_lseen_swap);
  EXPORT INTEGER4  _meta_lseen_deact            := IF(meta_lseen_deact IN ['','0'], NULL, (UNSIGNED4)meta_lseen_deact);
  EXPORT INTEGER4  _meta_lseen_port             := IF(meta_lseen_port IN ['','0'], NULL, (UNSIGNED4)meta_lseen_port);
  EXPORT INTEGER4  _meta_lseen_react            := IF(meta_lseen_react IN ['','0'], NULL, (UNSIGNED4)meta_lseen_react);
  EXPORT INTEGER4  _max_react                   := MAX(_meta_lseen_port, _meta_lseen_react);
  EXPORT INTEGER4  _max_deact                   := MAX(_meta_lseen_swap, _meta_lseen_deact);
  EXPORT INTEGER4  _max_react2                  := Models.Common.sas_date((STRING)_max_react);
  EXPORT INTEGER4  _max_deact2                  := Models.Common.sas_date((STRING)_max_deact);
  EXPORT UNSIGNED1 md_disc_no_port              := MAP(_max_deact != NULL AND _max_react = NULL => 1,
                                                       _max_deact = NULL AND _max_react != NULL => 0,
                                                                                                   (UNSIGNED1)(_max_deact2 - _max_react2 > 30)
                                                      );
  EXPORT UNSIGNED1 md_active                    := IF(_max_react != NULL AND md_disc_no_port = 0, 1, 0);
  EXPORT STRING1   md_line_type                 := shell_attributes.Metadata.Meta_Line;
  EXPORT STRING1   md_serv_type                 := shell_attributes.Metadata.Meta_Serv;
  EXPORT UNSIGNED1 md_phone_type                := MAP(md_serv_type = '0' AND md_line_type = '0' => 0,
                                                       md_serv_type = '0' AND md_line_type = '2' => 1,
                                                       md_serv_type = '1' AND md_line_type = '1' => 2,
                                                       md_serv_type = '2' AND md_line_type = '2' => 3,
                                                       md_serv_type = '3' AND md_line_type = '3' => 4,
                                                                                                    5);
  EXPORT INTEGER4  md_carrier_groups            := carriergroups(shell_attributes.Metadata.Meta_Carrier_Name);
  EXPORT INTEGER4  md_carrier_groups_disc       := MAP(md_carrier_groups = NULL                          => NULL,
                                                       md_carrier_groups IN [2, 5, 6, 9, 12, 13, 16, 18] => 1,
                                                                                                            0);
  EXPORT UNSIGNED4 md_otp_count_90_day          := shell_attributes.Metadata.Meta_Count_OTP_90;
  EXPORT UNSIGNED4 md_otp_count_180_day         := shell_attributes.Metadata.Meta_Count_OTP_180;
  EXPORT UNSIGNED4 md_otp_count_365_day         := shell_attributes.Metadata.Meta_Count_OTP_365;
  EXPORT UNSIGNED4 md_otp_count_730_day         := shell_attributes.Metadata.Meta_Count_OTP_730;
  EXPORT UNSIGNED1 md_good_recent_act           := MAP(md_active = 1                                                => 1,
                                                       md_port_dt_lseen_mth != NULL AND md_port_dt_lseen_mth < 61   => 1,
                                                       md_react_dt_lseen_mth != NULL AND md_react_dt_lseen_mth < 61 => 1,
                                                       md_otp_dt_lseen_mth != NULL AND md_otp_dt_lseen_mth < 61     => 1,
                                                                                                                       0);
  EXPORT INTEGER4  bur_last_update_mth          := monthdiff(sysdate8, bur_last_update2);
  EXPORT REAL      disc_score_v01_w             := MAP(md_active = NULL => 0,
                                                       md_active <= 0.5 => 0.566527127829903,
                                                                           -0.564922135127209);
  EXPORT REAL      disc_score_v02_w             := MAP(md_phone_type = NULL => 0,
                                                       md_phone_type <= 0.5 => 0.353796806390152,
                                                                               -0.354286736962154);
  EXPORT REAL      disc_score_v03_w             := MAP(md_carrier_groups_disc = NULL => 0,
                                                       md_carrier_groups_disc <= 0.5 => -0.218186112616668,
                                                                                        0.548805068655057);
  EXPORT REAL      disc_score_v04_w             := MAP(mpp_orig_score_infutor = NULL => 0,
                                                       mpp_orig_score_infutor <= 2.5 => -0.342174632212579,
                                                       mpp_orig_score_infutor <= 3.5 => -0.0239354351103991,
                                                                                        0.320589751701716);
  EXPORT REAL      disc_score_v05_w             := MAP(meda_dt_lseen_mth = NULL  => 0,
                                                       meda_dt_lseen_mth <= 0.5  => -0.530932381346374,
                                                       meda_dt_lseen_mth <= 45.5 => 0.0477140138574585,
                                                       meda_dt_lseen_mth <= 67.5 => 0.25352812612682,
                                                       meda_dt_lseen_mth <= 71.5 => 0.322786679819108,
                                                                                    0.334974063485844);
  EXPORT REAL      disc_score_v06_w             := MAP(p_disconnect_flag = NULL => 0,
                                                       p_disconnect_flag <= 0.5 => -0.293731807896506,
                                                                                   0.293457736673754);
  EXPORT REAL      disc_score_v07_w             := MAP(md_otp_dt_lseen_mth = NULL  => 0,
                                                       md_otp_dt_lseen_mth <= 3.5  => -1.2764539167082,
                                                       md_otp_dt_lseen_mth <= 7.5  => -0.94849175097746,
                                                       md_otp_dt_lseen_mth <= 9.5  => -0.832719944432251,
                                                       md_otp_dt_lseen_mth <= 13.5 => -0.813796850253377,
                                                       md_otp_dt_lseen_mth <= 25.5 => -0.68139541674152,
                                                       md_otp_dt_lseen_mth <= 31.5 => -0.626706645611945,
                                                       md_otp_dt_lseen_mth <= 42.5 => -0.335298721666025,
                                                       md_otp_dt_lseen_mth <= 52.5 => -0.316244398598314,
                                                                                      0.18582752483664);
  EXPORT REAL      disc_score_v08_w             := MAP(p_phone_switch_type = NULL => 0,
                                                       p_phone_switch_type <= 1.5 => -1.52882246967671,
                                                       p_phone_switch_type <= 2.5 => -0.217544406085623,
                                                                                     0.223412149385675);
  EXPORT REAL      disc_score_v09_w             := MAP(minq_se_lseen_mth = NULL   => 0,
                                                       minq_se_lseen_mth <= 22.5  => -0.4431567643854,
                                                       minq_se_lseen_mth <= 54.5  => -0.35881038284337,
                                                       minq_se_lseen_mth <= 83.5  => -0.235599110633034,
                                                       minq_se_lseen_mth <= 106.5 => -0.222025694133323,
                                                       minq_se_lseen_mth <= 142.5 => -0.111334877463602,
                                                                                     -0.0496286252757765);
  EXPORT REAL      disc_score_v10_w             := MAP(md_port_dt_lseen_mth = NULL   => 0,
                                                       md_port_dt_lseen_mth <= 12.5  => -0.583015278261815,
                                                       md_port_dt_lseen_mth <= 19.5  => -0.47153071488569,
                                                       md_port_dt_lseen_mth <= 20.5  => -0.411937560355835,
                                                       md_port_dt_lseen_mth <= 25.5  => -0.201718909320506,
                                                       md_port_dt_lseen_mth <= 39.5  => -0.163448287398013,
                                                       md_port_dt_lseen_mth <= 146.5 => 0.026118421061524,
                                                       md_port_dt_lseen_mth <= 219.5 => 0.560360508308764,
                                                                                        1.07260075610012);
  EXPORT REAL      disc_score_v11_w             := MAP(minq_lseen_mth = NULL   => 0,
                                                       minq_lseen_mth <= 17.5  => -0.401702992219247,
                                                       minq_lseen_mth <= 22.5  => -0.246089729393094,
                                                       minq_lseen_mth <= 41.5  => -0.21812099249212,
                                                       minq_lseen_mth <= 54.5  => -0.0759086272777509,
                                                       minq_lseen_mth <= 82.5  => -0.024789256720574,
                                                       minq_lseen_mth <= 107.5 => 0.0946616730437819,
                                                       minq_lseen_mth <= 142.5 => 0.140099458294426,
                                                                                  0.254173003831214);
  EXPORT REAL      disc_score_v12_w             := MAP(minq_cnt_06 = NULL => 0, // as the phone shell is currently, minq_cnt_06 will NEVER be NULL (always 0+)
                                                       minq_cnt_06 <= 0.5 => 0.160489809200107,
                                                                             -0.160322644668375);
  EXPORT REAL      disc_score_v13_w             := MAP(bur_last_update_mth = NULL  => 0,
                                                       bur_last_update_mth <= 2.5  => -1.03476197882183,
                                                       bur_last_update_mth <= 3.5  => -0.680781813454687,
                                                       bur_last_update_mth <= 4.5  => -0.660219117822413,
                                                       bur_last_update_mth <= 12.5 => -0.253311179040146,
                                                       bur_last_update_mth <= 17.5 => -0.236137992958586,
                                                       bur_last_update_mth <= 24.5 => -0.0857811470959273,
                                                       bur_last_update_mth <= 50.5 => -0.0170049463412991,
                                                                                      0.138972140578253);
  EXPORT REAL      disc_score                   := ROUND(-0.712753618904358 +
                                                         disc_score_v01_w +
                                                         disc_score_v02_w +
                                                         disc_score_v03_w +
                                                         disc_score_v04_w +
                                                         disc_score_v05_w +
                                                         disc_score_v06_w +
                                                         disc_score_v07_w +
                                                         disc_score_v08_w +
                                                         disc_score_v09_w +
                                                         disc_score_v10_w +
                                                         disc_score_v11_w +
                                                         disc_score_v12_w +
                                                         disc_score_v13_w,6);
                                                         
  // future possibilities 
  //EXPORT model_ivs := ROW({disc_score, ...}, Phone_Shell.Luci_ModelAttributes_Layouts.All_Attributes);

END;