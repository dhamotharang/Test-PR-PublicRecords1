EXPORT Delta(DATASET(Layout_DOT_Base)old_s, DATASET(Layout_DOT_Base) new_s) := MODULE//Routines to compute the differences between two instances of a file
  Diff_Layout := RECORD(layout_DOT_Base)
    BOOLEAN  Added;
    BOOLEAN Deleted;
    BOOLEAN Changed;
  END;
 
  Diff_Layout Take_Record(old_s le, new_s ri) := TRANSFORM
    SELF.Added := le.rcid = (TYPEOF(le.rcid))'';
    SELF.Deleted := ri.rcid = (TYPEOF(ri.rcid))'';
    SELF.Changed := MAP ( le.rcid = (TYPEOF(le.rcid))'' OR ri.rcid = (TYPEOF(ri.rcid))'' => FALSE,
       le.cnp_number<>ri.cnp_number OR  le.prim_range<>ri.prim_range OR  le.prim_name<>ri.prim_name OR  le.st<>ri.st OR  le.active_enterprise_number<>ri.active_enterprise_number OR  le.MN_foreign_corp_key<>ri.MN_foreign_corp_key OR  le.NJ_foreign_corp_key<>ri.NJ_foreign_corp_key OR  le.active_duns_number<>ri.active_duns_number OR  le.hist_enterprise_number<>ri.hist_enterprise_number OR  le.hist_duns_number<>ri.hist_duns_number OR  le.ebr_file_number<>ri.ebr_file_number OR  le.AR_foreign_corp_key<>ri.AR_foreign_corp_key OR  le.CA_foreign_corp_key<>ri.CA_foreign_corp_key OR  le.CO_foreign_corp_key<>ri.CO_foreign_corp_key OR  le.DC_foreign_corp_key<>ri.DC_foreign_corp_key OR  le.KS_foreign_corp_key<>ri.KS_foreign_corp_key OR  le.KY_foreign_corp_key<>ri.KY_foreign_corp_key OR  le.MA_foreign_corp_key<>ri.MA_foreign_corp_key OR  le.MD_foreign_corp_key<>ri.MD_foreign_corp_key OR  le.ME_foreign_corp_key<>ri.ME_foreign_corp_key OR  le.MI_foreign_corp_key<>ri.MI_foreign_corp_key OR  le.MO_foreign_corp_key<>ri.MO_foreign_corp_key OR  le.NC_foreign_corp_key<>ri.NC_foreign_corp_key OR  le.ND_foreign_corp_key<>ri.ND_foreign_corp_key OR  le.NM_foreign_corp_key<>ri.NM_foreign_corp_key OR  le.OK_foreign_corp_key<>ri.OK_foreign_corp_key OR  le.PA_foreign_corp_key<>ri.PA_foreign_corp_key OR  le.SC_foreign_corp_key<>ri.SC_foreign_corp_key OR  le.SD_foreign_corp_key<>ri.SD_foreign_corp_key OR  le.TN_foreign_corp_key<>ri.TN_foreign_corp_key OR  le.VT_foreign_corp_key<>ri.VT_foreign_corp_key OR  le.company_phone<>ri.company_phone OR  le.domestic_corp_key<>ri.domestic_corp_key OR  le.AL_foreign_corp_key<>ri.AL_foreign_corp_key OR  le.FL_foreign_corp_key<>ri.FL_foreign_corp_key OR  le.GA_foreign_corp_key<>ri.GA_foreign_corp_key OR  le.IL_foreign_corp_key<>ri.IL_foreign_corp_key OR  le.IN_foreign_corp_key<>ri.IN_foreign_corp_key OR  le.MS_foreign_corp_key<>ri.MS_foreign_corp_key OR  le.NH_foreign_corp_key<>ri.NH_foreign_corp_key OR  le.NV_foreign_corp_key<>ri.NV_foreign_corp_key OR  le.NY_foreign_corp_key<>ri.NY_foreign_corp_key OR  le.OR_foreign_corp_key<>ri.OR_foreign_corp_key OR  le.RI_foreign_corp_key<>ri.RI_foreign_corp_key OR  le.UT_foreign_corp_key<>ri.UT_foreign_corp_key OR  le.company_fein<>ri.company_fein OR  le.cnp_name<>ri.cnp_name OR  le.AK_foreign_corp_key<>ri.AK_foreign_corp_key OR  le.CT_foreign_corp_key<>ri.CT_foreign_corp_key OR  le.HI_foreign_corp_key<>ri.HI_foreign_corp_key OR  le.IA_foreign_corp_key<>ri.IA_foreign_corp_key OR  le.LA_foreign_corp_key<>ri.LA_foreign_corp_key OR  le.MT_foreign_corp_key<>ri.MT_foreign_corp_key OR  le.NE_foreign_corp_key<>ri.NE_foreign_corp_key OR  le.VA_foreign_corp_key<>ri.VA_foreign_corp_key OR  le.AZ_foreign_corp_key<>ri.AZ_foreign_corp_key OR  le.TX_foreign_corp_key<>ri.TX_foreign_corp_key OR  le.zip<>ri.zip OR  le.sec_range<>ri.sec_range OR  le.v_city_name<>ri.v_city_name OR  le.cnp_btype<>ri.cnp_btype OR  le.iscorp<>ri.iscorp OR  le.cnp_lowv<>ri.cnp_lowv OR  le.cnp_translated<>ri.cnp_translated OR  le.cnp_classid<>ri.cnp_classid OR  le.company_foreign_domestic<>ri.company_foreign_domestic OR  le.company_bdid<>ri.company_bdid OR  le.cnp_hasnumber<>ri.cnp_hasnumber OR  le.company_name<>ri.company_name OR  le.dt_first_seen<>ri.dt_first_seen OR  le.dt_last_seen<>ri.dt_last_seen OR  le.DE_foreign_corp_key<>ri.DE_foreign_corp_key OR  le.ID_foreign_corp_key<>ri.ID_foreign_corp_key OR  le.OH_foreign_corp_key<>ri.OH_foreign_corp_key OR  le.PR_foreign_corp_key<>ri.PR_foreign_corp_key OR  le.VI_foreign_corp_key<>ri.VI_foreign_corp_key OR  le.WA_foreign_corp_key<>ri.WA_foreign_corp_key OR  le.WI_foreign_corp_key<>ri.WI_foreign_corp_key OR  le.WV_foreign_corp_key<>ri.WV_foreign_corp_key OR  le.WY_foreign_corp_key<>ri.WY_foreign_corp_key => TRUE,
      SKIP );
    SELF := if ( ri.rcid=(TYPEOF(ri.rcid))'', le, ri );
  END;
  re := JOIN(old_s,new_s,left.rcid=right.rcid,Take_Record(LEFT,RIGHT),HASH,FULL OUTER);
EXPORT Differences := re;
  d := Differences;
EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(d(deleted)).Summary('Deletions') + hygiene(d(added)).Summary('Additions') + hygiene(d(changed)).Summary('Updates');
END;
