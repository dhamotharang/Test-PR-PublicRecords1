//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Vehicle_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Vehicle_1(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Vehicle_2(__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2(__cfg).__ENH_Sele_Vehicle_2;
  SHARED __EE8526813 := __ENH_Sele_Vehicle_2;
  EXPORT __ST199965_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Vehicle_Key_;
    KEL.typ.ndataset(E_Sele_Vehicle(__cfg).Party_Layout) Party_;
    KEL.typ.ndataset(E_Sele_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Sele_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Sele_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Sele_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Commercial_Type_;
    KEL.typ.nbool Other_Type_;
    KEL.typ.nbool Private_Type_;
    KEL.typ.nbool Seen___In___Last___Two___Years_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST199965_Layout __ND8527019__Project(B_Sele_Vehicle_2(__cfg).__ST218610_Layout __PP8526814) := TRANSFORM
    __CC14939 := ['AG','AR','CLG','CML','DE','DLR','EA','EMR','ENV','FGV','FNL','FOR','LGV','LIV','MFG','MIL','MUB','OFF','POL','SCB','SGV','TAX'];
    SELF.Commercial_Type_ := __OP2(__PP8526814.Vehicle_Type_Code_,IN,__CN(__CC14939));
    __CC14949 := ['BOT','EXT','MOT','OTH','TRL','UNK','VAN','XSR'];
    SELF.Other_Type_ := __OR(__OR(__OP2(__PP8526814.Vehicle_Type_Code_,IN,__CN(__CC14949)),__OP2(__PP8526814.Vehicle_Type_Code_,=,__CN(''))),__NT(__PP8526814.Vehicle_Type_Code_));
    __CC14915 := ['ANQ','DAV','HCP','MH','PRV'];
    SELF.Private_Type_ := __OP2(__PP8526814.Vehicle_Type_Code_,IN,__CN(__CC14915));
    SELF := __PP8526814;
  END;
  EXPORT __ENH_Sele_Vehicle_1 := PROJECT(__EE8526813,__ND8527019__Project(LEFT));
END;
