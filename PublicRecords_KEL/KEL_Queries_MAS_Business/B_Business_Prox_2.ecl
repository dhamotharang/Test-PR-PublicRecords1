﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Business_Prox_3,CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Phone,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_T_I_N,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Business_Prox_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3;
  SHARED VIRTUAL TYPEOF(E_Prox_Phone_Number(__in,__cfg).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Prox_T_I_N(__in,__cfg).__Result) __E_Prox_T_I_N := E_Prox_T_I_N(__in,__cfg).__Result;
  SHARED __EE2524888 := __ENH_Business_Prox_3;
  SHARED __EE2524890 := __E_Prox_Phone_Number;
  SHARED __EE2524897 := __EE2524890(__NN(__EE2524890.Business_Location_));
  SHARED __ST810158_Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Business_Location_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Best_Phone_;
    KEL.typ.nint Best_Phone_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST810158_Layout __JT2524908(E_Prox_Phone_Number(__in,__cfg).Layout __l, E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2524947 := NORMALIZE(__EE2524897,__T(LEFT.Best_Phone_Details_),__JT2524908(LEFT,RIGHT));
  SHARED __ST814739_Layout := RECORD
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
    KEL.typ.ndataset(E_Prox_Address(__in,__cfg).Best_Addresses_Layout) Best_Business_Prox_Address_;
    KEL.typ.ndataset(__ST810158_Layout) Prox_Phone_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2524956(B_Business_Prox_3(__in,__cfg).__ST561551_Layout __EE2524888, __ST810158_Layout __EE2524947) := __EEQP(__EE2524888.UID,__EE2524947.Business_Location_);
  __ST814739_Layout __Join__ST814739_Layout(B_Business_Prox_3(__in,__cfg).__ST561551_Layout __r, DATASET(__ST810158_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Prox_Phone_Number_ := __CN(__recs);
  END;
  SHARED __EE2525188 := DENORMALIZE(DISTRIBUTE(__EE2524888,HASH(UID)),DISTRIBUTE(__EE2524947,HASH(Business_Location_)),__JC2524956(LEFT,RIGHT),GROUP,__Join__ST814739_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE2525199 := __E_Prox_T_I_N;
  SHARED __EE2525206 := __EE2525199(__NN(__EE2525199.Business_Location_));
  SHARED __ST809835_Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) ____grp___U_I_D_;
    KEL.typ.ntyp(E_Business_Prox().Typ) Business_Location_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(E_Prox_T_I_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE2525258 := PROJECT(__EE2525206,TRANSFORM(__ST809835_Layout,SELF.____grp___U_I_D_ := LEFT.Business_Location_,SELF := LEFT));
  SHARED __EE2525269 := GROUP(KEL.Routines.SortChildren(__EE2525258,'Data_Sources_'),____grp___U_I_D_,ALL);
  SHARED __EE2525273 := UNGROUP(TOPN(__EE2525269(__NN(__EE2525269.Best_T_I_N_Rank_)),1,__T(__EE2525269.Best_T_I_N_Rank_),__T(____grp___U_I_D_),__T(Tax_I_D_),__T(Ult_I_D_),__T(Org_I_D_),__T(Sele_I_D_),__T(Prox_I_D_),__T(Best_T_I_N_)));
  SHARED __ST816059_Layout := RECORD
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
    KEL.typ.ndataset(E_Prox_Address(__in,__cfg).Best_Addresses_Layout) Best_Business_Prox_Address_;
    KEL.typ.ndataset(__ST810158_Layout) Prox_Phone_Number_;
    KEL.typ.ndataset(__ST809835_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2525282(__ST814739_Layout __EE2525188, __ST809835_Layout __EE2525273) := __EEQP(__EE2525188.UID,__EE2525273.____grp___U_I_D_);
  __ST816059_Layout __Join__ST816059_Layout(__ST814739_Layout __r, DATASET(__ST809835_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE2525529 := DENORMALIZE(DISTRIBUTE(__EE2525188,HASH(UID)),DISTRIBUTE(__EE2525273,HASH(____grp___U_I_D_)),__JC2525282(LEFT,RIGHT),GROUP,__Join__ST816059_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST175511_Layout := RECORD
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
    KEL.typ.ndataset(E_Prox_Address(__in,__cfg).Best_Addresses_Layout) Best_Business_Prox_Address_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Best_Company_Names_Layout) Best_Business_Prox_Names_Sorted_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Business_Prox_Phone_;
    KEL.typ.ndataset(__ST809835_Layout) Best_Business_Prox_Tin_;
    E_Prox_Address(__in,__cfg).Best_Addresses_Layout Only_Best_Business_Prox_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST175511_Layout __ND2525540__Project(__ST816059_Layout __PP2525536) := TRANSFORM
    __EE2525841 := __PP2525536.Best_Company_Names_;
    __BS2525831 := __T(__EE2525841);
    __EE2525845 := __BN(TOPN(__BS2525831(__NN(__T(__EE2525841).Best_Company_Name_Rank_)),1,__T(__T(__EE2525841).Best_Company_Name_Rank_),__T(Best_Company_Name_)),__NL(__EE2525841));
    SELF.Best_Business_Prox_Names_Sorted_ := __EE2525845;
    __EE2525532 := __PP2525536.Prox_Phone_Number_;
    __EE2525873 := PROJECT(TABLE(PROJECT(__T(__EE2525532),E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_Phone_,Best_Phone_Rank_},Best_Phone_,Best_Phone_Rank_,MERGE),E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout);
    __EE2525877 := TOPN(__EE2525873(__NN(__EE2525873.Best_Phone_Rank_)),1,__T(__EE2525873.Best_Phone_Rank_),__T(Best_Phone_));
    SELF.Best_Business_Prox_Phone_ := __CN(__EE2525877(__NN(Best_Phone_) OR __NN(Best_Phone_Rank_)));
    __EE2525535 := __PP2525536.Exp1_;
    SELF.Best_Business_Prox_Tin_ := __EE2525535;
    __EE2525881 := __PP2525536.Best_Business_Prox_Address_;
    SELF.Only_Best_Business_Prox_Address_ := (__T(__EE2525881))[1];
    SELF := __PP2525536;
  END;
  SHARED __EE2526099 := PROJECT(__EE2525529,__ND2525540__Project(LEFT));
  EXPORT __ST809563_Layout := RECORD
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
    KEL.typ.ndataset(E_Prox_Address(__in,__cfg).Best_Addresses_Layout) Best_Business_Prox_Address_;
    KEL.typ.ndataset(E_Business_Prox(__in,__cfg).Best_Company_Names_Layout) Best_Business_Prox_Names_Sorted_;
    KEL.typ.ndataset(E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Business_Prox_Phone_;
    KEL.typ.ndataset(E_Prox_T_I_N(__in,__cfg).Layout) Best_Business_Prox_Tin_;
    E_Prox_Address(__in,__cfg).Best_Addresses_Layout Only_Best_Business_Prox_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST809563_Layout __ND2524328__Project(__ST175511_Layout __PP2524324) := TRANSFORM
    __EE2526102 := __PP2524324.Best_Business_Prox_Tin_;
    SELF.Best_Business_Prox_Tin_ := __PROJECT(__EE2526102,E_Prox_T_I_N(__in,__cfg).Layout);
    SELF := __PP2524324;
  END;
  EXPORT __ENH_Business_Prox_2 := PROJECT(__EE2526099,__ND2524328__Project(LEFT));
END;
