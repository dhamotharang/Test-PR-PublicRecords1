//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Prox_3,CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Phone,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_T_I_N,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Prox_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3;
  SHARED VIRTUAL TYPEOF(E_Prox_Phone_Number(__in,__cfg).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Prox_T_I_N(__in,__cfg).__Result) __E_Prox_T_I_N := E_Prox_T_I_N(__in,__cfg).__Result;
  SHARED __EE6774236 := __ENH_Business_Prox_3;
  SHARED __EE6774238 := __E_Prox_Phone_Number;
  SHARED __EE6774245 := __EE6774238(__NN(__EE6774238.Business_Location_));
  SHARED __ST1287112_Layout := RECORD
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
  __ST1287112_Layout __JT6774256(E_Prox_Phone_Number(__in,__cfg).Layout __l, E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6774295 := NORMALIZE(__EE6774245,__T(LEFT.Best_Phone_Details_),__JT6774256(LEFT,RIGHT));
  SHARED __ST1291693_Layout := RECORD
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
    KEL.typ.ndataset(__ST1287112_Layout) Prox_Phone_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6774304(B_Business_Prox_3(__in,__cfg).__ST799717_Layout __EE6774236, __ST1287112_Layout __EE6774295) := __EEQP(__EE6774236.UID,__EE6774295.Business_Location_);
  __ST1291693_Layout __Join__ST1291693_Layout(B_Business_Prox_3(__in,__cfg).__ST799717_Layout __r, DATASET(__ST1287112_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Prox_Phone_Number_ := __CN(__recs);
  END;
  SHARED __EE6774536 := DENORMALIZE(DISTRIBUTE(__EE6774236,HASH(UID)),DISTRIBUTE(__EE6774295,HASH(Business_Location_)),__JC6774304(LEFT,RIGHT),GROUP,__Join__ST1291693_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE6774547 := __E_Prox_T_I_N;
  SHARED __EE6774554 := __EE6774547(__NN(__EE6774547.Business_Location_));
  SHARED __ST1286789_Layout := RECORD
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
  SHARED __EE6774606 := PROJECT(__EE6774554,TRANSFORM(__ST1286789_Layout,SELF.____grp___U_I_D_ := LEFT.Business_Location_,SELF := LEFT));
  SHARED __EE6774617 := GROUP(KEL.Routines.SortChildren(__EE6774606,'Data_Sources_'),____grp___U_I_D_,ALL);
  SHARED __EE6774621 := UNGROUP(TOPN(__EE6774617(__NN(__EE6774617.Best_T_I_N_Rank_)),1,__T(__EE6774617.Best_T_I_N_Rank_),__T(____grp___U_I_D_),__T(Tax_I_D_),__T(Ult_I_D_),__T(Org_I_D_),__T(Sele_I_D_),__T(Prox_I_D_),__T(Best_T_I_N_)));
  SHARED __ST1293013_Layout := RECORD
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
    KEL.typ.ndataset(__ST1287112_Layout) Prox_Phone_Number_;
    KEL.typ.ndataset(__ST1286789_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6774630(__ST1291693_Layout __EE6774536, __ST1286789_Layout __EE6774621) := __EEQP(__EE6774536.UID,__EE6774621.____grp___U_I_D_);
  __ST1293013_Layout __Join__ST1293013_Layout(__ST1291693_Layout __r, DATASET(__ST1286789_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE6774877 := DENORMALIZE(DISTRIBUTE(__EE6774536,HASH(UID)),DISTRIBUTE(__EE6774621,HASH(____grp___U_I_D_)),__JC6774630(LEFT,RIGHT),GROUP,__Join__ST1293013_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST205306_Layout := RECORD
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
    KEL.typ.ndataset(__ST1286789_Layout) Best_Business_Prox_Tin_;
    E_Prox_Address(__in,__cfg).Best_Addresses_Layout Only_Best_Business_Prox_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST205306_Layout __ND6774888__Project(__ST1293013_Layout __PP6774884) := TRANSFORM
    __EE6775189 := __PP6774884.Best_Company_Names_;
    __BS6775179 := __T(__EE6775189);
    __EE6775193 := __BN(TOPN(__BS6775179(__NN(__T(__EE6775189).Best_Company_Name_Rank_)),1,__T(__T(__EE6775189).Best_Company_Name_Rank_),__T(Best_Company_Name_)),__NL(__EE6775189));
    SELF.Best_Business_Prox_Names_Sorted_ := __EE6775193;
    __EE6774880 := __PP6774884.Prox_Phone_Number_;
    __EE6775221 := PROJECT(TABLE(PROJECT(__T(__EE6774880),E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_Phone_,Best_Phone_Rank_},Best_Phone_,Best_Phone_Rank_,MERGE),E_Prox_Phone_Number(__in,__cfg).Best_Phone_Details_Layout);
    __EE6775225 := TOPN(__EE6775221(__NN(__EE6775221.Best_Phone_Rank_)),1,__T(__EE6775221.Best_Phone_Rank_),__T(Best_Phone_));
    SELF.Best_Business_Prox_Phone_ := __CN(__EE6775225(__NN(Best_Phone_) OR __NN(Best_Phone_Rank_)));
    __EE6774883 := __PP6774884.Exp1_;
    SELF.Best_Business_Prox_Tin_ := __EE6774883;
    __EE6775229 := __PP6774884.Best_Business_Prox_Address_;
    SELF.Only_Best_Business_Prox_Address_ := (__T(__EE6775229))[1];
    SELF := __PP6774884;
  END;
  SHARED __EE6775447 := PROJECT(__EE6774877,__ND6774888__Project(LEFT));
  EXPORT __ST1286517_Layout := RECORD
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
  SHARED __ST1286517_Layout __ND6773676__Project(__ST205306_Layout __PP6773672) := TRANSFORM
    __EE6775450 := __PP6773672.Best_Business_Prox_Tin_;
    SELF.Best_Business_Prox_Tin_ := __PROJECT(__EE6775450,E_Prox_T_I_N(__in,__cfg).Layout);
    SELF := __PP6773672;
  END;
  EXPORT __ENH_Business_Prox_2 := PROJECT(__EE6775447,__ND6773676__Project(LEFT));
END;
