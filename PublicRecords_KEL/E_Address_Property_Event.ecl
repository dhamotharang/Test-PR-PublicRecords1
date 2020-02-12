﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Address_Property_Event(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nbool Is_Owner_Address_;
    KEL.typ.nbool Is_Seller_Address_;
    KEL.typ.nbool Is_Property_Address_;
    KEL.typ.nbool Is_Borrower_Address_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Event_(DEFAULT:Event_:0),Location_(DEFAULT:Location_:0),lnfaresid(DEFAULT:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),zip5(DEFAULT:Z_I_P5_:0),isowneraddress(DEFAULT:Is_Owner_Address_),isselleraddress(DEFAULT:Is_Seller_Address_),ispropertyaddress(DEFAULT:Is_Property_Address_),isborroweraddress(DEFAULT:Is_Borrower_Address_),processdate(DEFAULT:Process_Date_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'Event_(DEFAULT:Event_:0),Location_(DEFAULT:Location_:0),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),owneraddress(OVERRIDE:Is_Owner_Address_),selleraddress(OVERRIDE:Is_Seller_Address_),propertyaddress(OVERRIDE:Is_Property_Address_),borroweraddress(OVERRIDE:Is_Borrower_Address_),process_date(OVERRIDE:Process_Date_:DATE),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),src(OVERRIDE:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Search_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Search_Fid),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(ln_fares_id != '' AND (STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d0_Event__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Event_;
  END;
  SHARED __d0_Missing_Event__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ln_fares_id','__in');
  SHARED __d0_Event__Mapped := IF(__d0_Missing_Event__UIDComponents = 'ln_fares_id',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Event__Layout,SELF.Event_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Event__UIDComponents),E_Property_Event(__in,__cfg).Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d0_Event__Layout,SELF.Event_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH));
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Event__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Event__Mapped,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d0_Event__Mapped,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Event__Mapped,__d0_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH));
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Address_Characteristics_Layout := RECORD
    KEL.typ.nbool Is_Owner_Address_;
    KEL.typ.nbool Is_Seller_Address_;
    KEL.typ.nbool Is_Property_Address_;
    KEL.typ.nbool Is_Borrower_Address_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Layout := RECORD
    KEL.typ.nkdate Process_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ndataset(Address_Characteristics_Layout) Address_Characteristics_;
    KEL.typ.ndataset(Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Event_,Location_,L_N_Fares_I_D_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,ALL));
  Address_Property_Event_Group := __PostFilter;
  Layout Address_Property_Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Address_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Is_Owner_Address_,Is_Seller_Address_,Is_Property_Address_,Is_Borrower_Address_,Vendor_Source_Code_},Is_Owner_Address_,Is_Seller_Address_,Is_Property_Address_,Is_Borrower_Address_,Vendor_Source_Code_),Address_Characteristics_Layout)(__NN(Is_Owner_Address_) OR __NN(Is_Seller_Address_) OR __NN(Is_Property_Address_) OR __NN(Is_Borrower_Address_) OR __NN(Vendor_Source_Code_)));
    SELF.Reported_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Process_Date_},Process_Date_),Reported_Dates_Layout)(__NN(Process_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address_Property_Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Is_Owner_Address_) OR __NN(Is_Seller_Address_) OR __NN(Is_Property_Address_) OR __NN(Is_Borrower_Address_) OR __NN(Vendor_Source_Code_)));
    SELF.Reported_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Process_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Property_Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Address_Property_Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Property_Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Address_Property_Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Event__Orphan := JOIN(InData(__NN(Event_)),E_Property_Event(__in,__cfg).__Result,__EEQP(LEFT.Event_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Event__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan)}],{KEL.typ.int Event__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan});
  EXPORT NullCounts := DATASET([
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Event',COUNT(__d0(__NL(Event_))),COUNT(__d0(__NN(Event_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d0(__NL(L_N_Fares_I_D_))),COUNT(__d0(__NN(L_N_Fares_I_D_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owneraddress',COUNT(__d0(__NL(Is_Owner_Address_))),COUNT(__d0(__NN(Is_Owner_Address_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','selleraddress',COUNT(__d0(__NL(Is_Seller_Address_))),COUNT(__d0(__NN(Is_Seller_Address_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','propertyaddress',COUNT(__d0(__NL(Is_Property_Address_))),COUNT(__d0(__NN(Is_Property_Address_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','borroweraddress',COUNT(__d0(__NL(Is_Borrower_Address_))),COUNT(__d0(__NN(Is_Borrower_Address_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d0(__NL(Vendor_Source_Code_))),COUNT(__d0(__NN(Vendor_Source_Code_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'AddressPropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
