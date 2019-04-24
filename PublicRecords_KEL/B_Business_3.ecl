//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Business_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED VIRTUAL TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business(__in,__cfg).__Result;
  SHARED __EE52819 := __E_Business;
  SHARED __EE52886 := __E_Tradeline_Business;
  SHARED __EE53616 := __EE52886(__NN(__EE52886.Company_) AND __NN(__EE52886.Account_));
  SHARED __EE52888 := __ENH_Tradeline_4;
  SHARED __CC10533 := 730;
  SHARED __EE53763 := __EE52888(__T(__OP2(__EE52888.Newest_Record_Age_In_Days_,<=,__CN(__CC10533))));
  __JC53769(E_Tradeline_Business(__in,__cfg).Layout __EE53616, B_Tradeline_4(__in,__cfg).__ST39095_Layout __EE53763) := __EEQP(__EE53616.Account_,__EE53763.UID);
  SHARED __EE53776 := JOIN(__EE53616,__EE53763,__JC53769(LEFT,RIGHT),TRANSFORM(E_Tradeline_Business(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST52951_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Tradeline().Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST52951_Layout __ND53781__Project(E_Tradeline_Business(__in,__cfg).Layout __PP53777) := TRANSFORM
    SELF.UID := __PP53777.Company_;
    SELF.U_I_D__1_ := __PP53777.Account_;
    SELF := __PP53777;
  END;
  SHARED __EE53806 := PROJECT(__EE53776,__ND53781__Project(LEFT));
  SHARED __ST52980_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE53819 := PROJECT(__CLEANANDDO(__EE53806,TABLE(__EE53806,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST52980_Layout);
  SHARED __ST53236_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC53825(E_Business(__in,__cfg).Layout __EE52819, __ST52980_Layout __EE53819) := __EEQP(__EE52819.UID,__EE53819.UID);
  __ST53236_Layout __JT53825(E_Business(__in,__cfg).Layout __l, __ST52980_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE53844 := JOIN(__EE52819,__EE53819,__JC53825(LEFT,RIGHT),__JT53825(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST36861_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.int B2b_T_L_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Business_3 := PROJECT(__EE53844,TRANSFORM(__ST36861_Layout,SELF.B2b_T_L_Cnt2_Y_No_Cap_ := LEFT.C_O_U_N_T___Exp1_,SELF := LEFT));
END;
