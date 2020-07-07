//HPCC Systems KEL Compiler Version 1.2.0beta2
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Phone,FN_Compile FROM $;
IMPORT * FROM KEL12.Null;
EXPORT B_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Phone(__in,__cfg).__Result) __E_Phone := E_Phone(__in,__cfg).__Result;
  SHARED __EE1987589 := __E_Phone;
  EXPORT __ST80342_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Active_Layout) Active_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Confidence_Scores_Layout) Confidence_Scores_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Types_Layout) Phone_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Record_Types_Layout) Record_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST80342_Layout __ND1988088__Project(E_Phone(__in,__cfg).Layout __PP1987315) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('targus_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP1987315;
  END;
  EXPORT __ENH_Phone := PROJECT(__EE1987589,__ND1988088__Project(LEFT));
END;
