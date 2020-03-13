//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person_5,B_Person_7,CFG_Compile,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_5(__in,__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5(__in,__cfg).__ENH_Person_5;
  SHARED __EE405555 := __ENH_Person_5;
  EXPORT __ST140655_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nbool D_O_B_Best_Not_Null_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST140640_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(__ST140655_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST53977_Layout) Address_Hierarchy_Set_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST53977_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST53977_Layout) Recent_Addr_Full_Set_;
    KEL.typ.nkdate Select_Age_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST140640_Layout __ND405425__Project(B_Person_5(__in,__cfg).__ST143295_Layout __PP403634) := TRANSFORM
    __EE405558 := __PP403634.Reported_Dates_Of_Birth_;
    SELF.Reported_Dates_Of_Birth_ := __BN(PROJECT(__T(__EE405558),__ST140655_Layout),__NL(__EE405558));
    __EE405420 := __PP403634.Curr_Addr_Full_Set_;
    SELF.Curr_Addr_Full_ := (__T(__EE405420))[1].Addr_Full_;
    __EE405439 := __PP403634.Reported_Dates_Of_Birth_;
    __BS405440 := __T(__EE405439);
    __EE405445 := __BS405440(__T(__T(__EE405439).D_O_B_Best_Not_Null_));
    SELF.Select_Age_ := (__EE405445)[1].Date_Of_Birth_;
    SELF := __PP403634;
  END;
  EXPORT __ENH_Person_4 := PROJECT(__EE405555,__ND405425__Project(LEFT));
END;
