//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Inquiry_5,CFG_Compile,E_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT B_Inquiry_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_5(__in,__cfg).__ENH_Inquiry_5) __ENH_Inquiry_5 := B_Inquiry_5(__in,__cfg).__ENH_Inquiry_5;
  SHARED __EE307430 := __ENH_Inquiry_5;
  EXPORT __ST150401_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Search_Info_Layout) Search_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Permissions_Layout) Permissions_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Bus_Intel_Layout) Bus_Intel_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Person_Info_Layout) Person_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Business_Info_Layout) Business_Info_;
    KEL.typ.nint Fraudpoint_Score_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Agein_Days_;
    KEL.typ.str Inquiry_Function_Description_ := '';
    KEL.typ.str Inquiry_Industry_ := '';
    KEL.typ.str Inquiry_Method_ := '';
    KEL.typ.nint Inquiry_Product_Code_;
    KEL.typ.str Inquiry_Vertical_ := '';
    KEL.typ.bool Is_Batch_Monitoring_Method_ := FALSE;
    KEL.typ.bool Is_Collection_ := FALSE;
    KEL.typ.bool Is_Length_Sub_Market_ := FALSE;
    KEL.typ.nbool Is_Non_Fcra_Ok_;
    KEL.typ.nbool Is_Product_Code_Ok_;
    KEL.typ.nbool Is_Valid_Velocity_Inquiry_Non_F_C_R_A_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST150401_Layout __ND307721__Project(B_Inquiry_5(__in,__cfg).__ST151194_Layout __PP307431) := TRANSFORM
    __CC40410 := ['CHARGEBACK DEFENDER','CHARGEBACK DEFENDER SCORE ATTRIBUTES','RISKWISE CHARGEBACK DEFENDER (SCORE ONLY CD02)','RISKWISE CHARGEBACK DEFENDER W/ RC JOINT APP (FDSL)','RISKWISE CHARGEBACK DEFENDER W/ RC SINGLE APP (FDS7)','RISKWISE CUSTOM CANADIAN CHARGEBACK DEFENDER','RISKWISE CUSTOM CHARGEBACK DEFENDER (CB61)','RISKWISE CUSTOM CHARGEBACK DEFENDER (ND03)','RISKWISE CUSTOM CHARGEBACK DEFENDER (ND05)','RISKWISE CUSTOM CHARGEBACK DEFENDER (ND11)','RISKWISE CUSTOM CHARGEBACK DEFENDER W/ IP DOMAIN (ND10)'];
    SELF.Is_Valid_Velocity_Inquiry_Non_F_C_R_A_ := __AND(__AND(__AND(__AND(__AND(__OP2(__PP307431.Agein_Days_,<=,__CN(365)),__CN(NOT (__PP307431.Is_Collection_))),__CN(NOT (__PP307431.Is_Batch_Monitoring_Method_))),__PP307431.Is_Product_Code_Ok_),__CN(NOT (__PP307431.Inquiry_Function_Description_ IN __CC40410))),__PP307431.Is_Non_Fcra_Ok_);
    SELF := __PP307431;
  END;
  EXPORT __ENH_Inquiry_4 := PROJECT(__EE307430,__ND307721__Project(LEFT));
END;
