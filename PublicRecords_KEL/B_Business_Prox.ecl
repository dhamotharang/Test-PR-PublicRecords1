﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_Prox_1,CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Geo_Link,E_Phone,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_T_I_N,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_Prox(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Prox_1().__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1(__in,__cfg).__ENH_Business_Prox_1;
  SHARED __EE2834610 := __ENH_Business_Prox_1;
  EXPORT __ST87169_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Prox_Sele_;
    KEL.typ.nint Parent_Prox_I_D_;
    KEL.typ.nint Sele_Prox_I_D_;
    KEL.typ.nint Org_Prox_I_D_;
    KEL.typ.nint Ult_Prox_I_D_;
    KEL.typ.nint Levels_From_Top_;
    KEL.typ.nint Nodes_Below_;
    KEL.typ.nstr Prox_Segment_;
    KEL.typ.nstr Store_Number_;
    KEL.typ.nstr Active_Duns_Number_;
    KEL.typ.nstr Hist_Duns_Number_;
    KEL.typ.nstr D_U_N_S_Number_;
    KEL.typ.nint Equifax_I_D_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Cortera_Layout) Cortera_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Deleted_I_D_Numbers_Layout) Deleted_I_D_Numbers_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).O_S_H_A_Inspection_Layout) O_S_H_A_Inspection_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).O_S_H_A_Violations_Layout) O_S_H_A_Violations_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).O_S_H_A_Business_Information_Layout) O_S_H_A_Business_Information_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Associated_Address_Type_Layout) Associated_Address_Type_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Location_Status_Layout) Location_Status_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Business_Owned_Characteristics_Layout) Business_Owned_Characteristics_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Contacts_Layout) Contacts_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr B_P___Best_Addr_City_;
    KEL.typ.nstr B_P___Best_Addr_City_Post_;
    KEL.typ.nint B_P___Best_Addr_Loc_I_D_;
    KEL.typ.nstr B_P___Best_Addr_St_;
    KEL.typ.nstr B_P___Best_Addr_State_;
    KEL.typ.nstr B_P___Best_Addr_Zip_;
    KEL.typ.nstr B_P___Best_Name_;
    KEL.typ.nstr B_P___Best_Phone_;
    KEL.typ.nstr B_P___Best_T_I_N_;
    KEL.typ.str B___Lex_I_D_Loc_Seen_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST87169_Layout __ND2837765__Project(B_Business_Prox_1(__in,__cfg).__ST110767_Layout __PP2833701) := TRANSFORM
    __CC9813 := '-99999';
    __CC9818 := '-99998';
    SELF.B_P___Best_Addr_City_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9813))))=>__ECAST(KEL.typ.nstr,__CN(__CC9813)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Address_.Best_Vanity_City_),__OP2(__PP2833701.Only_Best_Business_Prox_Address_.Best_Vanity_City_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9818)),__ECAST(KEL.typ.nstr,__PP2833701.Only_Best_Business_Prox_Address_.Best_Vanity_City_));
    SELF.B_P___Best_Addr_City_Post_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9813))))=>__ECAST(KEL.typ.nstr,__CN(__CC9813)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Address_.Best_Postal_City_),__OP2(__PP2833701.Only_Best_Business_Prox_Address_.Best_Postal_City_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9818)),__ECAST(KEL.typ.nstr,__PP2833701.Only_Best_Business_Prox_Address_.Best_Postal_City_));
    __CC9816 := -99999;
    __CC9821 := -99998;
    SELF.B_P___Best_Addr_Loc_I_D_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9813))))=>__ECAST(KEL.typ.nint,__CN(__CC9816)),__T(__OP2(__PP2833701.Business_Prox_Location_I_D_,=,__CN(0)))=>__ECAST(KEL.typ.nint,__CN(__CC9821)),__ECAST(KEL.typ.nint,__PP2833701.Business_Prox_Location_I_D_));
    SELF.B_P___Best_Addr_St_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9813))))=>__ECAST(KEL.typ.nstr,__CN(__CC9813)),__T(__OR(__NT(__PP2833701.Best_Prox_Address_),__OP2(__PP2833701.Best_Prox_Address_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9818)),__ECAST(KEL.typ.nstr,__PP2833701.Best_Prox_Address_));
    SELF.B_P___Best_Addr_State_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9813))))=>__ECAST(KEL.typ.nstr,__CN(__CC9813)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Address_.Best_State_),__OP2(__PP2833701.Only_Best_Business_Prox_Address_.Best_State_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9818)),__ECAST(KEL.typ.nstr,__PP2833701.Only_Best_Business_Prox_Address_.Best_State_));
    SELF.B_P___Best_Addr_Zip_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9813))))=>__ECAST(KEL.typ.nstr,__CN(__CC9813)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Address_.Best_Zip5_),__OP2(__CAST(KEL.typ.str,__PP2833701.Only_Best_Business_Prox_Address_.Best_Zip5_),=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9818)),__ECAST(KEL.typ.nstr,__FN3(INTFORMAT,__PP2833701.Only_Best_Business_Prox_Address_.Best_Zip5_,__CN(5),__CN(1))));
    __CC9809 := '-99999';
    __CC9811 := '-99998';
    SELF.B_P___Best_Name_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9809))))=>__ECAST(KEL.typ.nstr,__CN(__CC9809)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Name_.Best_Company_Name_),__OP2(__PP2833701.Only_Best_Business_Prox_Name_.Best_Company_Name_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9811)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN__fn_Remove_Special_Chars(__ECAST(KEL.typ.nstr,__PP2833701.Only_Best_Business_Prox_Name_.Best_Company_Name_),__ECAST(KEL.typ.nstr,__CN('')))));
    __CC9827 := '-99999';
    __CC9829 := '-99998';
    SELF.B_P___Best_Phone_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9827))))=>__ECAST(KEL.typ.nstr,__CN(__CC9827)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Phone_.Best_Phone_),__OP2(__PP2833701.Only_Best_Business_Prox_Phone_.Best_Phone_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9829)),__ECAST(KEL.typ.nstr,__PP2833701.Only_Best_Business_Prox_Phone_.Best_Phone_));
    __CC9823 := '-99999';
    __CC9825 := '-99998';
    SELF.B_P___Best_T_I_N_ := MAP(__T(__OR(__CN(__PP2833701.B___Lex_I_D_Loc_Seen_Flag_ = '0'),__OP2(__CAST(KEL.typ.str,__PP2833701.Prox_I_D_),=,__CN(__CC9823))))=>__ECAST(KEL.typ.nstr,__CN(__CC9823)),__T(__OR(__NT(__PP2833701.Only_Best_Business_Prox_Tin_.Best_T_I_N_),__OP2(__CAST(KEL.typ.str,__PP2833701.Only_Best_Business_Prox_Tin_.Best_T_I_N_),=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CN(__CC9825)),__ECAST(KEL.typ.nstr,__FN3(INTFORMAT,__PP2833701.Only_Best_Business_Prox_Tin_.Best_T_I_N_,__CN(9),__CN(1))));
    SELF := __PP2833701;
  END;
  EXPORT __ENH_Business_Prox := PROJECT(__EE2834610,__ND2837765__Project(LEFT));
END;
