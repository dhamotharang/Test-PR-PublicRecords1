//HPCC Systems KEL Compiler Version 1.2.0beta4
IMPORT KEL12 AS KEL;
IMPORT B_Person_Vehicle_6,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Vehicle_5(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_6(__cfg).__ENH_Person_Vehicle_6) __ENH_Person_Vehicle_6 := B_Person_Vehicle_6(__cfg).__ENH_Person_Vehicle_6;
  SHARED __EE29598 := __ENH_Person_Vehicle_6;
  EXPORT __ST10163_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_At_First_Seen_;
    KEL.typ.nfloat Age_Year_At_First_Seen_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nint Depreciated_Price_;
    KEL.typ.nbool Flag_Depreciated_Price_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST10163_Layout __ND29855__Project(B_Person_Vehicle_6(__cfg).__ST10645_Layout __PP29391) := TRANSFORM
    SELF.Flag_Depreciated_Price_ := __OP2(__PP29391.Depreciated_Price_,>=,__CN(0));
    SELF := __PP29391;
  END;
  EXPORT __ENH_Person_Vehicle_5 := PROJECT(__EE29598,__ND29855__Project(LEFT));
END;
