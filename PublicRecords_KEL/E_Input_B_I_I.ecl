﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Input_B_I_I(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nint B___Inp_Lex_I_D_Ult_;
    KEL.typ.nint B___Inp_Lex_I_D_Org_;
    KEL.typ.nint B___Inp_Lex_I_D_Legal_;
    KEL.typ.nint B___Inp_Lex_I_D_Site_;
    KEL.typ.nint B___Inp_Lex_I_D_Loc_;
    KEL.typ.nstr B___Inp_Name_;
    KEL.typ.nstr B___Inp_Alt_Name_;
    KEL.typ.nstr B___Inp_Addr_Line1_;
    KEL.typ.nstr B___Inp_Addr_Line2_;
    KEL.typ.nstr B___Inp_Addr_City_;
    KEL.typ.nstr B___Inp_Addr_State_;
    KEL.typ.nstr B___Inp_Addr_Zip_;
    KEL.typ.nstr B___Inp_Phone_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr B___Inp_I_P_Addr_;
    KEL.typ.nstr B___Inp_U_R_L_;
    KEL.typ.nstr B___Inp_Email_;
    KEL.typ.nstr B___Inp_S_I_C_Code_;
    KEL.typ.nstr B___Inp_N_A_I_C_S_Code_;
    KEL.typ.nstr B___Inp_T_I_N_;
    KEL.typ.nstr B___Inp_Arch_Dt_;
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.nint B___Lex_I_D_Site_;
    KEL.typ.nint B___Lex_I_D_Loc_;
    KEL.typ.nint B___Lex_I_D_Legal_Score_;
    KEL.typ.nint B___Lex_I_D_Legal_Wgt_;
    KEL.typ.nstr B___Inp_Cln_Name_;
    KEL.typ.nstr B___Inp_Cln_Alt_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Inp_Cln_Addr_Status_;
    KEL.typ.nstr B___Inp_Cln_Phone_;
    KEL.typ.nstr B___Inp_Cln_Email_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_;
    KEL.typ.nint B___Inp_Cln_Arch_Dt_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'g_procbusuid(DEFAULT:UID|DEFAULT:G___Proc_Bus_U_I_D_:0),Legal_(DEFAULT:Legal_:0),b_inplexidult(DEFAULT:B___Inp_Lex_I_D_Ult_:0),b_inplexidorg(DEFAULT:B___Inp_Lex_I_D_Org_:0),b_inplexidlegal(DEFAULT:B___Inp_Lex_I_D_Legal_:0),b_inplexidsite(DEFAULT:B___Inp_Lex_I_D_Site_:0),b_inplexidloc(DEFAULT:B___Inp_Lex_I_D_Loc_:0),b_inpname(DEFAULT:B___Inp_Name_:\'\'),b_inpaltname(DEFAULT:B___Inp_Alt_Name_:\'\'),b_inpaddrline1(DEFAULT:B___Inp_Addr_Line1_:\'\'),b_inpaddrline2(DEFAULT:B___Inp_Addr_Line2_:\'\'),b_inpaddrcity(DEFAULT:B___Inp_Addr_City_:\'\'),b_inpaddrstate(DEFAULT:B___Inp_Addr_State_:\'\'),b_inpaddrzip(DEFAULT:B___Inp_Addr_Zip_:\'\'),b_inpphone(DEFAULT:B___Inp_Phone_:\'\'),businesstin(DEFAULT:Business_T_I_N_:\'\'),b_inpipaddr(DEFAULT:B___Inp_I_P_Addr_:\'\'),b_inpurl(DEFAULT:B___Inp_U_R_L_:\'\'),b_inpemail(DEFAULT:B___Inp_Email_:\'\'),b_inpsiccode(DEFAULT:B___Inp_S_I_C_Code_:\'\'),b_inpnaicscode(DEFAULT:B___Inp_N_A_I_C_S_Code_:\'\'),b_inptin(DEFAULT:B___Inp_T_I_N_:\'\'),b_inparchdt(DEFAULT:B___Inp_Arch_Dt_:\'\'),b_lexidult(DEFAULT:B___Lex_I_D_Ult_:0),b_lexidorg(DEFAULT:B___Lex_I_D_Org_:0),b_lexidlegal(DEFAULT:B___Lex_I_D_Legal_:0),b_lexidsite(DEFAULT:B___Lex_I_D_Site_:0),b_lexidloc(DEFAULT:B___Lex_I_D_Loc_:0),b_lexidlegalscore(DEFAULT:B___Lex_I_D_Legal_Score_:0),b_lexidlegalwgt(DEFAULT:B___Lex_I_D_Legal_Wgt_:0),b_inpclnname(DEFAULT:B___Inp_Cln_Name_:\'\'),b_inpclnaltname(DEFAULT:B___Inp_Cln_Alt_Name_:\'\'),b_inpclnaddrprimrng(DEFAULT:B___Inp_Cln_Addr_Prim_Rng_:\'\'),b_inpclnaddrpredir(DEFAULT:B___Inp_Cln_Addr_Pre_Dir_:\'\'),b_inpclnaddrprimname(DEFAULT:B___Inp_Cln_Addr_Prim_Name_:\'\'),b_inpclnaddrsffx(DEFAULT:B___Inp_Cln_Addr_Sffx_:\'\'),b_inpclnaddrpostdir(DEFAULT:B___Inp_Cln_Addr_Post_Dir_:\'\'),b_inpclnaddrunitdesig(DEFAULT:B___Inp_Cln_Addr_Unit_Desig_:\'\'),b_inpclnaddrsecrng(DEFAULT:B___Inp_Cln_Addr_Sec_Rng_:\'\'),b_inpclnaddrcity(DEFAULT:B___Inp_Cln_Addr_City_:\'\'),b_inpclnaddrcitypost(DEFAULT:B___Inp_Cln_Addr_City_Post_:\'\'),b_inpclnaddrstate(DEFAULT:B___Inp_Cln_Addr_State_:\'\'),b_inpclnaddrzip5(DEFAULT:B___Inp_Cln_Addr_Zip5_:\'\'),b_inpclnaddrzip4(DEFAULT:B___Inp_Cln_Addr_Zip4_:\'\'),b_inpclnaddrlat(DEFAULT:B___Inp_Cln_Addr_Lat_:\'\'),b_inpclnaddrlng(DEFAULT:B___Inp_Cln_Addr_Lng_:\'\'),b_inpclnaddrstatecode(DEFAULT:B___Inp_Cln_Addr_State_Code_:\'\'),b_inpclnaddrcnty(DEFAULT:B___Inp_Cln_Addr_Cnty_:\'\'),b_inpclnaddrgeo(DEFAULT:B___Inp_Cln_Addr_Geo_:\'\'),b_inpclnaddrtype(DEFAULT:B___Inp_Cln_Addr_Type_:\'\'),b_inpclnaddrstatus(DEFAULT:B___Inp_Cln_Addr_Status_:\'\'),b_inpclnphone(DEFAULT:B___Inp_Cln_Phone_:\'\'),b_inpclnemail(DEFAULT:B___Inp_Cln_Email_:\'\'),b_inpclntin(DEFAULT:B___Inp_Cln_T_I_N_:\'\'),b_inpclnarchdt(DEFAULT:B___Inp_Cln_Arch_Dt_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),archivedate(DEFAULT:Archive_Date_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nint B___Inp_Lex_I_D_Ult_;
    KEL.typ.nint B___Inp_Lex_I_D_Org_;
    KEL.typ.nint B___Inp_Lex_I_D_Legal_;
    KEL.typ.nint B___Inp_Lex_I_D_Site_;
    KEL.typ.nint B___Inp_Lex_I_D_Loc_;
    KEL.typ.nstr B___Inp_Name_;
    KEL.typ.nstr B___Inp_Alt_Name_;
    KEL.typ.nstr B___Inp_Addr_Line1_;
    KEL.typ.nstr B___Inp_Addr_Line2_;
    KEL.typ.nstr B___Inp_Addr_City_;
    KEL.typ.nstr B___Inp_Addr_State_;
    KEL.typ.nstr B___Inp_Addr_Zip_;
    KEL.typ.nstr B___Inp_Phone_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr B___Inp_I_P_Addr_;
    KEL.typ.nstr B___Inp_U_R_L_;
    KEL.typ.nstr B___Inp_Email_;
    KEL.typ.nstr B___Inp_S_I_C_Code_;
    KEL.typ.nstr B___Inp_N_A_I_C_S_Code_;
    KEL.typ.nstr B___Inp_T_I_N_;
    KEL.typ.nstr B___Inp_Arch_Dt_;
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.nint B___Lex_I_D_Site_;
    KEL.typ.nint B___Lex_I_D_Loc_;
    KEL.typ.nint B___Lex_I_D_Legal_Score_;
    KEL.typ.nint B___Lex_I_D_Legal_Wgt_;
    KEL.typ.nstr B___Inp_Cln_Name_;
    KEL.typ.nstr B___Inp_Cln_Alt_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Inp_Cln_Addr_Status_;
    KEL.typ.nstr B___Inp_Cln_Phone_;
    KEL.typ.nstr B___Inp_Cln_Email_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_;
    KEL.typ.nint B___Inp_Cln_Arch_Dt_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Input_B_I_I_Group := __PostFilter;
  Layout Input_B_I_I__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Legal_ := KEL.Intake.SingleValue(__recs,Legal_);
    SELF.G___Proc_Bus_U_I_D_ := KEL.Intake.SingleValue(__recs,G___Proc_Bus_U_I_D_);
    SELF.B___Inp_Lex_I_D_Ult_ := KEL.Intake.SingleValue(__recs,B___Inp_Lex_I_D_Ult_);
    SELF.B___Inp_Lex_I_D_Org_ := KEL.Intake.SingleValue(__recs,B___Inp_Lex_I_D_Org_);
    SELF.B___Inp_Lex_I_D_Legal_ := KEL.Intake.SingleValue(__recs,B___Inp_Lex_I_D_Legal_);
    SELF.B___Inp_Lex_I_D_Site_ := KEL.Intake.SingleValue(__recs,B___Inp_Lex_I_D_Site_);
    SELF.B___Inp_Lex_I_D_Loc_ := KEL.Intake.SingleValue(__recs,B___Inp_Lex_I_D_Loc_);
    SELF.B___Inp_Name_ := KEL.Intake.SingleValue(__recs,B___Inp_Name_);
    SELF.B___Inp_Alt_Name_ := KEL.Intake.SingleValue(__recs,B___Inp_Alt_Name_);
    SELF.B___Inp_Addr_Line1_ := KEL.Intake.SingleValue(__recs,B___Inp_Addr_Line1_);
    SELF.B___Inp_Addr_Line2_ := KEL.Intake.SingleValue(__recs,B___Inp_Addr_Line2_);
    SELF.B___Inp_Addr_City_ := KEL.Intake.SingleValue(__recs,B___Inp_Addr_City_);
    SELF.B___Inp_Addr_State_ := KEL.Intake.SingleValue(__recs,B___Inp_Addr_State_);
    SELF.B___Inp_Addr_Zip_ := KEL.Intake.SingleValue(__recs,B___Inp_Addr_Zip_);
    SELF.B___Inp_Phone_ := KEL.Intake.SingleValue(__recs,B___Inp_Phone_);
    SELF.Business_T_I_N_ := KEL.Intake.SingleValue(__recs,Business_T_I_N_);
    SELF.B___Inp_I_P_Addr_ := KEL.Intake.SingleValue(__recs,B___Inp_I_P_Addr_);
    SELF.B___Inp_U_R_L_ := KEL.Intake.SingleValue(__recs,B___Inp_U_R_L_);
    SELF.B___Inp_Email_ := KEL.Intake.SingleValue(__recs,B___Inp_Email_);
    SELF.B___Inp_S_I_C_Code_ := KEL.Intake.SingleValue(__recs,B___Inp_S_I_C_Code_);
    SELF.B___Inp_N_A_I_C_S_Code_ := KEL.Intake.SingleValue(__recs,B___Inp_N_A_I_C_S_Code_);
    SELF.B___Inp_T_I_N_ := KEL.Intake.SingleValue(__recs,B___Inp_T_I_N_);
    SELF.B___Inp_Arch_Dt_ := KEL.Intake.SingleValue(__recs,B___Inp_Arch_Dt_);
    SELF.B___Lex_I_D_Ult_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Ult_);
    SELF.B___Lex_I_D_Org_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Org_);
    SELF.B___Lex_I_D_Legal_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Legal_);
    SELF.B___Lex_I_D_Site_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Site_);
    SELF.B___Lex_I_D_Loc_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Loc_);
    SELF.B___Lex_I_D_Legal_Score_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Legal_Score_);
    SELF.B___Lex_I_D_Legal_Wgt_ := KEL.Intake.SingleValue(__recs,B___Lex_I_D_Legal_Wgt_);
    SELF.B___Inp_Cln_Name_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Name_);
    SELF.B___Inp_Cln_Alt_Name_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Alt_Name_);
    SELF.B___Inp_Cln_Addr_Prim_Rng_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Prim_Rng_);
    SELF.B___Inp_Cln_Addr_Pre_Dir_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Pre_Dir_);
    SELF.B___Inp_Cln_Addr_Prim_Name_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Prim_Name_);
    SELF.B___Inp_Cln_Addr_Sffx_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Sffx_);
    SELF.B___Inp_Cln_Addr_Post_Dir_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Post_Dir_);
    SELF.B___Inp_Cln_Addr_Unit_Desig_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Unit_Desig_);
    SELF.B___Inp_Cln_Addr_Sec_Rng_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Sec_Rng_);
    SELF.B___Inp_Cln_Addr_City_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_City_);
    SELF.B___Inp_Cln_Addr_City_Post_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_City_Post_);
    SELF.B___Inp_Cln_Addr_State_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_State_);
    SELF.B___Inp_Cln_Addr_Zip5_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Zip5_);
    SELF.B___Inp_Cln_Addr_Zip4_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Zip4_);
    SELF.B___Inp_Cln_Addr_Lat_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Lat_);
    SELF.B___Inp_Cln_Addr_Lng_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Lng_);
    SELF.B___Inp_Cln_Addr_State_Code_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_State_Code_);
    SELF.B___Inp_Cln_Addr_Cnty_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Cnty_);
    SELF.B___Inp_Cln_Addr_Geo_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Geo_);
    SELF.B___Inp_Cln_Addr_Type_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Type_);
    SELF.B___Inp_Cln_Addr_Status_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Addr_Status_);
    SELF.B___Inp_Cln_Phone_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Phone_);
    SELF.B___Inp_Cln_Email_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Email_);
    SELF.B___Inp_Cln_T_I_N_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_T_I_N_);
    SELF.B___Inp_Cln_Arch_Dt_ := KEL.Intake.SingleValue(__recs,B___Inp_Cln_Arch_Dt_);
    SELF.Phone_Verification_Bureau_ := KEL.Intake.SingleValue(__recs,Phone_Verification_Bureau_);
    SELF.Dial_Indicator_ := KEL.Intake.SingleValue(__recs,Dial_Indicator_);
    SELF.Point_I_D_ := KEL.Intake.SingleValue(__recs,Point_I_D_);
    SELF.N_X_X_Type_ := KEL.Intake.SingleValue(__recs,N_X_X_Type_);
    SELF.Z_I_P_Match_ := KEL.Intake.SingleValue(__recs,Z_I_P_Match_);
    SELF.C_O_C_Type_ := KEL.Intake.SingleValue(__recs,C_O_C_Type_);
    SELF.S_S_C_ := KEL.Intake.SingleValue(__recs,S_S_C_);
    SELF.Wireless_Indicator_ := KEL.Intake.SingleValue(__recs,Wireless_Indicator_);
    SELF.Archive_Date_ := KEL.Intake.SingleValue(__recs,Archive_Date_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Input_B_I_I__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Input_B_I_I_Group,COUNT(ROWS(LEFT))=1),GROUP,Input_B_I_I__Single_Rollup(LEFT)) + ROLLUP(HAVING(Input_B_I_I_Group,COUNT(ROWS(LEFT))>1),GROUP,Input_B_I_I__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Legal__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Legal_);
  EXPORT G___Proc_Bus_U_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,G___Proc_Bus_U_I_D_);
  EXPORT B___Inp_Lex_I_D_Ult__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Lex_I_D_Ult_);
  EXPORT B___Inp_Lex_I_D_Org__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Lex_I_D_Org_);
  EXPORT B___Inp_Lex_I_D_Legal__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Lex_I_D_Legal_);
  EXPORT B___Inp_Lex_I_D_Site__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Lex_I_D_Site_);
  EXPORT B___Inp_Lex_I_D_Loc__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Lex_I_D_Loc_);
  EXPORT B___Inp_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Name_);
  EXPORT B___Inp_Alt_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Alt_Name_);
  EXPORT B___Inp_Addr_Line1__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Addr_Line1_);
  EXPORT B___Inp_Addr_Line2__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Addr_Line2_);
  EXPORT B___Inp_Addr_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Addr_City_);
  EXPORT B___Inp_Addr_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Addr_State_);
  EXPORT B___Inp_Addr_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Addr_Zip_);
  EXPORT B___Inp_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Phone_);
  EXPORT Business_T_I_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Business_T_I_N_);
  EXPORT B___Inp_I_P_Addr__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_I_P_Addr_);
  EXPORT B___Inp_U_R_L__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_U_R_L_);
  EXPORT B___Inp_Email__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Email_);
  EXPORT B___Inp_S_I_C_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_S_I_C_Code_);
  EXPORT B___Inp_N_A_I_C_S_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_N_A_I_C_S_Code_);
  EXPORT B___Inp_T_I_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_T_I_N_);
  EXPORT B___Inp_Arch_Dt__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Arch_Dt_);
  EXPORT B___Lex_I_D_Ult__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Ult_);
  EXPORT B___Lex_I_D_Org__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Org_);
  EXPORT B___Lex_I_D_Legal__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Legal_);
  EXPORT B___Lex_I_D_Site__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Site_);
  EXPORT B___Lex_I_D_Loc__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Loc_);
  EXPORT B___Lex_I_D_Legal_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Legal_Score_);
  EXPORT B___Lex_I_D_Legal_Wgt__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Lex_I_D_Legal_Wgt_);
  EXPORT B___Inp_Cln_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Name_);
  EXPORT B___Inp_Cln_Alt_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Alt_Name_);
  EXPORT B___Inp_Cln_Addr_Prim_Rng__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Prim_Rng_);
  EXPORT B___Inp_Cln_Addr_Pre_Dir__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Pre_Dir_);
  EXPORT B___Inp_Cln_Addr_Prim_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Prim_Name_);
  EXPORT B___Inp_Cln_Addr_Sffx__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Sffx_);
  EXPORT B___Inp_Cln_Addr_Post_Dir__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Post_Dir_);
  EXPORT B___Inp_Cln_Addr_Unit_Desig__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Unit_Desig_);
  EXPORT B___Inp_Cln_Addr_Sec_Rng__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Sec_Rng_);
  EXPORT B___Inp_Cln_Addr_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_City_);
  EXPORT B___Inp_Cln_Addr_City_Post__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_City_Post_);
  EXPORT B___Inp_Cln_Addr_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_State_);
  EXPORT B___Inp_Cln_Addr_Zip5__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Zip5_);
  EXPORT B___Inp_Cln_Addr_Zip4__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Zip4_);
  EXPORT B___Inp_Cln_Addr_Lat__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Lat_);
  EXPORT B___Inp_Cln_Addr_Lng__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Lng_);
  EXPORT B___Inp_Cln_Addr_State_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_State_Code_);
  EXPORT B___Inp_Cln_Addr_Cnty__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Cnty_);
  EXPORT B___Inp_Cln_Addr_Geo__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Geo_);
  EXPORT B___Inp_Cln_Addr_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Type_);
  EXPORT B___Inp_Cln_Addr_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Addr_Status_);
  EXPORT B___Inp_Cln_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Phone_);
  EXPORT B___Inp_Cln_Email__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Email_);
  EXPORT B___Inp_Cln_T_I_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_T_I_N_);
  EXPORT B___Inp_Cln_Arch_Dt__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,B___Inp_Cln_Arch_Dt_);
  EXPORT Phone_Verification_Bureau__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Verification_Bureau_);
  EXPORT Dial_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Dial_Indicator_);
  EXPORT Point_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Point_I_D_);
  EXPORT N_X_X_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,N_X_X_Type_);
  EXPORT Z_I_P_Match__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Z_I_P_Match_);
  EXPORT C_O_C_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,C_O_C_Type_);
  EXPORT S_S_C__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,S_S_C_);
  EXPORT Wireless_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Wireless_Indicator_);
  EXPORT Archive_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Archive_Date_);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Legal__SingleValue_Invalid),COUNT(G___Proc_Bus_U_I_D__SingleValue_Invalid),COUNT(B___Inp_Lex_I_D_Ult__SingleValue_Invalid),COUNT(B___Inp_Lex_I_D_Org__SingleValue_Invalid),COUNT(B___Inp_Lex_I_D_Legal__SingleValue_Invalid),COUNT(B___Inp_Lex_I_D_Site__SingleValue_Invalid),COUNT(B___Inp_Lex_I_D_Loc__SingleValue_Invalid),COUNT(B___Inp_Name__SingleValue_Invalid),COUNT(B___Inp_Alt_Name__SingleValue_Invalid),COUNT(B___Inp_Addr_Line1__SingleValue_Invalid),COUNT(B___Inp_Addr_Line2__SingleValue_Invalid),COUNT(B___Inp_Addr_City__SingleValue_Invalid),COUNT(B___Inp_Addr_State__SingleValue_Invalid),COUNT(B___Inp_Addr_Zip__SingleValue_Invalid),COUNT(B___Inp_Phone__SingleValue_Invalid),COUNT(Business_T_I_N__SingleValue_Invalid),COUNT(B___Inp_I_P_Addr__SingleValue_Invalid),COUNT(B___Inp_U_R_L__SingleValue_Invalid),COUNT(B___Inp_Email__SingleValue_Invalid),COUNT(B___Inp_S_I_C_Code__SingleValue_Invalid),COUNT(B___Inp_N_A_I_C_S_Code__SingleValue_Invalid),COUNT(B___Inp_T_I_N__SingleValue_Invalid),COUNT(B___Inp_Arch_Dt__SingleValue_Invalid),COUNT(B___Lex_I_D_Ult__SingleValue_Invalid),COUNT(B___Lex_I_D_Org__SingleValue_Invalid),COUNT(B___Lex_I_D_Legal__SingleValue_Invalid),COUNT(B___Lex_I_D_Site__SingleValue_Invalid),COUNT(B___Lex_I_D_Loc__SingleValue_Invalid),COUNT(B___Lex_I_D_Legal_Score__SingleValue_Invalid),COUNT(B___Lex_I_D_Legal_Wgt__SingleValue_Invalid),COUNT(B___Inp_Cln_Name__SingleValue_Invalid),COUNT(B___Inp_Cln_Alt_Name__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Prim_Rng__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Pre_Dir__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Prim_Name__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Sffx__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Post_Dir__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Unit_Desig__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Sec_Rng__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_City__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_City_Post__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_State__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Zip5__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Zip4__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Lat__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Lng__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_State_Code__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Cnty__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Geo__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Type__SingleValue_Invalid),COUNT(B___Inp_Cln_Addr_Status__SingleValue_Invalid),COUNT(B___Inp_Cln_Phone__SingleValue_Invalid),COUNT(B___Inp_Cln_Email__SingleValue_Invalid),COUNT(B___Inp_Cln_T_I_N__SingleValue_Invalid),COUNT(B___Inp_Cln_Arch_Dt__SingleValue_Invalid),COUNT(Phone_Verification_Bureau__SingleValue_Invalid),COUNT(Dial_Indicator__SingleValue_Invalid),COUNT(Point_I_D__SingleValue_Invalid),COUNT(N_X_X_Type__SingleValue_Invalid),COUNT(Z_I_P_Match__SingleValue_Invalid),COUNT(C_O_C_Type__SingleValue_Invalid),COUNT(S_S_C__SingleValue_Invalid),COUNT(Wireless_Indicator__SingleValue_Invalid),COUNT(Archive_Date__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Legal__SingleValue_Invalid,KEL.typ.int G___Proc_Bus_U_I_D__SingleValue_Invalid,KEL.typ.int B___Inp_Lex_I_D_Ult__SingleValue_Invalid,KEL.typ.int B___Inp_Lex_I_D_Org__SingleValue_Invalid,KEL.typ.int B___Inp_Lex_I_D_Legal__SingleValue_Invalid,KEL.typ.int B___Inp_Lex_I_D_Site__SingleValue_Invalid,KEL.typ.int B___Inp_Lex_I_D_Loc__SingleValue_Invalid,KEL.typ.int B___Inp_Name__SingleValue_Invalid,KEL.typ.int B___Inp_Alt_Name__SingleValue_Invalid,KEL.typ.int B___Inp_Addr_Line1__SingleValue_Invalid,KEL.typ.int B___Inp_Addr_Line2__SingleValue_Invalid,KEL.typ.int B___Inp_Addr_City__SingleValue_Invalid,KEL.typ.int B___Inp_Addr_State__SingleValue_Invalid,KEL.typ.int B___Inp_Addr_Zip__SingleValue_Invalid,KEL.typ.int B___Inp_Phone__SingleValue_Invalid,KEL.typ.int Business_T_I_N__SingleValue_Invalid,KEL.typ.int B___Inp_I_P_Addr__SingleValue_Invalid,KEL.typ.int B___Inp_U_R_L__SingleValue_Invalid,KEL.typ.int B___Inp_Email__SingleValue_Invalid,KEL.typ.int B___Inp_S_I_C_Code__SingleValue_Invalid,KEL.typ.int B___Inp_N_A_I_C_S_Code__SingleValue_Invalid,KEL.typ.int B___Inp_T_I_N__SingleValue_Invalid,KEL.typ.int B___Inp_Arch_Dt__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Ult__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Org__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Legal__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Site__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Loc__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Legal_Score__SingleValue_Invalid,KEL.typ.int B___Lex_I_D_Legal_Wgt__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Name__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Alt_Name__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Prim_Rng__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Pre_Dir__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Prim_Name__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Sffx__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Post_Dir__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Unit_Desig__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Sec_Rng__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_City__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_City_Post__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_State__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Zip5__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Zip4__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Lat__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Lng__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_State_Code__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Cnty__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Geo__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Type__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Addr_Status__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Phone__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Email__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_T_I_N__SingleValue_Invalid,KEL.typ.int B___Inp_Cln_Arch_Dt__SingleValue_Invalid,KEL.typ.int Phone_Verification_Bureau__SingleValue_Invalid,KEL.typ.int Dial_Indicator__SingleValue_Invalid,KEL.typ.int Point_I_D__SingleValue_Invalid,KEL.typ.int N_X_X_Type__SingleValue_Invalid,KEL.typ.int Z_I_P_Match__SingleValue_Invalid,KEL.typ.int C_O_C_Type__SingleValue_Invalid,KEL.typ.int S_S_C__SingleValue_Invalid,KEL.typ.int Wireless_Indicator__SingleValue_Invalid,KEL.typ.int Archive_Date__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
