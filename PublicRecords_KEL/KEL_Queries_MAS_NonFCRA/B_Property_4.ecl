//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address,E_Address_Property,E_Geo_Link,E_Property,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address(__in,__cfg).__Result) __E_Address := E_Address(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Address_Property(__in,__cfg).__Result) __E_Address_Property := E_Address_Property(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Property(__in,__cfg).__Result) __E_Property := E_Property(__in,__cfg).__Result;
  SHARED __EE344451 := __E_Property;
  SHARED __ST344941_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Automated_Valuation_Model_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Address_Property_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE344363 := __E_Address_Property;
  SHARED __EE1708671 := __EE344363(__NN(__EE344363.Location_) AND __NN(__EE344363.Prop_));
  SHARED __EE344377 := __E_Address;
  SHARED __EE344389 := __EE344377.A_D_V_O_Summary_;
  __JC1708980(E_Address(__in,__cfg).A_D_V_O_Summary_Layout __EE344389) := __T(__OP2(__EE344389.Residential_Or_Business_Indicator_,IN,__CN(['B','D'])));
  SHARED __EE1708981 := __EE344377(EXISTS(__CHILDJOINFILTER(__EE344389,__JC1708980)));
  __JC1709103(E_Address_Property(__in,__cfg).Layout __EE1708671, E_Address(__in,__cfg).Layout __EE1708981) := __EEQP(__EE1708671.Location_,__EE1708981.UID);
  SHARED __EE1709127 := JOIN(__EE1708671,__EE1708981,__JC1709103(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC1709133(E_Property(__in,__cfg).Layout __EE344451, E_Address_Property(__in,__cfg).Layout __EE1709127) := __EEQP(__EE344451.UID,__EE1709127.Prop_);
  __JF1709133(E_Address_Property(__in,__cfg).Layout __EE1709127) := __NN(__EE1709127.Prop_);
  SHARED __EE1709169 := JOIN(__EE344451,__EE1709127,__JC1709133(LEFT,RIGHT),TRANSFORM(__ST344941_Layout,SELF:=LEFT,SELF.Address_Property_:=__JF1709133(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST175315_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Automated_Valuation_Model_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Is_Business_Address_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Property_4 := PROJECT(__EE1709169,TRANSFORM(__ST175315_Layout,SELF.Is_Business_Address_ := LEFT.Address_Property_,SELF := LEFT));
END;
