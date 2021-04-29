﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL15.Null;
EXPORT L_Compile := MODULE
  SHARED Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic_Res0_Internal_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.str B___Lex_I_D_Legal_Seen_Flag_ := '';
    KEL.typ.nint B_E___B2_B_Cnt_Ev_;
    KEL.typ.int B_E___B2_B_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt2_Y_ := 0;
    KEL.typ.float B_E___B2_B_Carr_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Flt_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Mat_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Ops_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Oth_Pct2_Y_ := 0.0;
    KEL.typ.nstr B_E___B2_B_Old_Dt_Ev_;
    KEL.typ.nint B_E___B2_B_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___B2_B_Old_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_New_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Old_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_New_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Actv_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Pct_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_;
    KEL.typ.int B_E___B2_B_Actv_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Bal_Max_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max_Msnc2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Seg_Type2_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Worst_Perf_Indx_;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.str B_E___B2_B_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Carr_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Flt_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Mat_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Ops_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Oth_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.nstr B_E___B2_B_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Worst_Perf_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_ := 0;
    KEL.typ.str B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.nint B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Carr_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Flt_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Mat_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Ops_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Oth_Bal_Vol24_Mc_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic_Res0_Layout := RECORDOF(__UNWRAP(DATASET([],Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic_Res0_Internal_Layout)));
END;
