//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Business_Prox_2,CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Phone,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_T_I_N,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Business_Prox_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2;
  SHARED __EE2905434 := __ENH_Business_Prox_2;
  EXPORT __ST169049_Layout := RECORD
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
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Company_Names_Layout) Company_Names_;
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
    KEL.typ.str B___Lex_I_D_Loc_Seen_Flag_ := '';
    KEL.typ.nstr Best_Prox_Address_;
    KEL.typ.nint Business_Prox_Location_I_D_;
    E_Prox_Address(__in,__cfg).Best_Addresses_Layout Only_Best_Business_Prox_Address_;
    E_Business_Prox(__in,__cfg).Best_Company_Names_Layout Only_Best_Business_Prox_Name_;
    E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout Only_Best_Business_Prox_Phone_;
    E_Prox_T_I_N(__in,__cfg).Layout Only_Best_Business_Prox_Tin_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST169049_Layout __ND2906345__Project(B_Business_Prox_2(__in,__cfg).__ST811520_Layout __PP2905435) := TRANSFORM
    __BS2905707 := __T(__PP2905435.Data_Sources_);
    SELF.B___Lex_I_D_Loc_Seen_Flag_ := IF(EXISTS(__BS2905707(__T(__T(__PP2905435.Data_Sources_).Header_Hit_Flag_))),'1','0');
    SELF.Best_Prox_Address_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Range_))),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Range_),+,__CN(' '))),__ECAST(KEL.typ.nstr,__CN(''))),+,IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Predirectional_))),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Predirectional_),+,__CN(' '))),__ECAST(KEL.typ.nstr,__CN('')))),+,IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Name_))),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Name_),+,__CN(' '))),__ECAST(KEL.typ.nstr,__CN('')))),+,IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Suffix_))),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Suffix_),+,__CN(' '))),__ECAST(KEL.typ.nstr,__CN('')))),+,IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Postdirectional_))),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Postdirectional_),+,__CN(' '))),__ECAST(KEL.typ.nstr,__CN('')))),+,IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Unit_Designation_))),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Unit_Designation_),+,__CN(' '))),__ECAST(KEL.typ.nstr,__CN('')))),+,IF(__T(__NOT(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Secondary_Range_))),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP2905435.Only_Best_Business_Prox_Address_.Best_Secondary_Range_)),__ECAST(KEL.typ.nstr,__CN(''))));
    SELF.Business_Prox_Location_I_D_ := FN_Compile(__cfg).FN_Append_Location_I_D(__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Range_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Range_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Predirectional_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Predirectional_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Name_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Primary_Name_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Suffix_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Suffix_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Postdirectional_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Postdirectional_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Secondary_Range_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Secondary_Range_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Vanity_City_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_Vanity_City_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_State_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2905435.Only_Best_Business_Prox_Address_.Best_State_))),__ECAST(KEL.typ.nstr,IF(__T(__NT(__PP2905435.Only_Best_Business_Prox_Address_.Best_Zip5_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__PP2905435.Only_Best_Business_Prox_Address_.Best_Zip5_)))));
    __EE2905874 := __PP2905435.Best_Business_Prox_Names_Sorted_;
    SELF.Only_Best_Business_Prox_Name_ := (__T(__EE2905874))[1];
    __EE2905877 := __PP2905435.Best_Business_Prox_Phone_;
    SELF.Only_Best_Business_Prox_Phone_ := (__T(__EE2905877))[1];
    __EE2905880 := __PP2905435.Best_Business_Prox_Tin_;
    SELF.Only_Best_Business_Prox_Tin_ := (__T(__EE2905880))[1];
    SELF := __PP2905435;
  END;
  EXPORT __ENH_Business_Prox_1 := PROJECT(__EE2905434,__ND2906345__Project(LEFT));
END;
