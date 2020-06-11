//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Social_Security_Number,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_S_S_N_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'social(DEFAULT:Social_:0),Location_(DEFAULT:Location_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),zip5(DEFAULT:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d1_Location__Mapped := IF(__d1_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'person_q.ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)person_q.ssn != 0 AND (STRING) person_q.prim_name !='' AND (UNSIGNED)person_q.zip != 0);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range','__in');
  SHARED __d2_Location__Mapped := IF(__d2_Missing_Location__UIDComponents = 'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.person_q.prim_range) + '|' + TRIM((STRING)LEFT.person_q.predir) + '|' + TRIM((STRING)LEFT.person_q.prim_name) + '|' + TRIM((STRING)LEFT.person_q.addr_suffix) + '|' + TRIM((STRING)LEFT.person_q.postdir) + '|' + TRIM((STRING)LEFT.person_q.zip5) + '|' + TRIM((STRING)LEFT.person_q.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_3Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header_Address,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header_Address),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d3_Location__Mapped := IF(__d3_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Fraudpoint3__Key_SSN,TRANSFORM(RECORDOF(__in.Dataset_Fraudpoint3__Key_SSN),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((STRING28)prim_name != '' AND (UNSIGNED)zip != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d4_Location__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d4_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d4_Location__Mapped := IF(__d4_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d4_KELfiltered,TRANSFORM(__d4_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_KELfiltered,__d4_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d4_Prefiltered := __d4_Location__Mapped;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_SSN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_SSN),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)ssn != 0 AND (STRING) person_q.prim_name !='' AND (unsigned) person_q.ssn != 0);
  SHARED __d5_Location__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d5_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_KELfiltered,'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range','__in');
  SHARED __d5_Location__Mapped := IF(__d5_Missing_Location__UIDComponents = 'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range',PROJECT(__d5_KELfiltered,TRANSFORM(__d5_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_KELfiltered,__d5_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.person_q.prim_range) + '|' + TRIM((STRING)LEFT.person_q.predir) + '|' + TRIM((STRING)LEFT.person_q.prim_name) + '|' + TRIM((STRING)LEFT.person_q.addr_suffix) + '|' + TRIM((STRING)LEFT.person_q.postdir) + '|' + TRIM((STRING)LEFT.person_q.zip5) + '|' + TRIM((STRING)LEFT.person_q.sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d5_Prefiltered := __d5_Location__Mapped;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)ssn != 0 AND (STRING) person_q.prim_name !='' AND (UNSIGNED)person_q.zip != 0);
  SHARED __d6_Location__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d6_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_KELfiltered,'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range','__in');
  SHARED __d6_Location__Mapped := IF(__d6_Missing_Location__UIDComponents = 'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range',PROJECT(__d6_KELfiltered,TRANSFORM(__d6_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_KELfiltered,__d6_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.person_q.prim_range) + '|' + TRIM((STRING)LEFT.person_q.predir) + '|' + TRIM((STRING)LEFT.person_q.prim_name) + '|' + TRIM((STRING)LEFT.person_q.addr_suffix) + '|' + TRIM((STRING)LEFT.person_q.postdir) + '|' + TRIM((STRING)LEFT.person_q.zip5) + '|' + TRIM((STRING)LEFT.person_q.sec_range) = RIGHT.KeyVal,TRANSFORM(__d6_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d6_Prefiltered := __d6_Location__Mapped;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'ssn(OVERRIDE:Social_:0),Location_(DEFAULT:Location_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_Update_SSN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Update_SSN),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)ssn != 0 AND (STRING) person_q.prim_name !='' AND (UNSIGNED)person_q.zip != 0);
  SHARED __d7_Location__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d7_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_KELfiltered,'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range','__in');
  SHARED __d7_Location__Mapped := IF(__d7_Missing_Location__UIDComponents = 'person_q.prim_range,person_q.predir,person_q.prim_name,person_q.addr_suffix,person_q.postdir,person_q.zip5,person_q.sec_range',PROJECT(__d7_KELfiltered,TRANSFORM(__d7_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_KELfiltered,__d7_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.person_q.prim_range) + '|' + TRIM((STRING)LEFT.person_q.predir) + '|' + TRIM((STRING)LEFT.person_q.prim_name) + '|' + TRIM((STRING)LEFT.person_q.addr_suffix) + '|' + TRIM((STRING)LEFT.person_q.postdir) + '|' + TRIM((STRING)LEFT.person_q.zip5) + '|' + TRIM((STRING)LEFT.person_q.sec_range) = RIGHT.KeyVal,TRANSFORM(__d7_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d7_Prefiltered := __d7_Location__Mapped;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Social_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,ALL));
  S_S_N_Address_Group := __PostFilter;
  Layout S_S_N_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout S_S_N_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(S_S_N_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,S_S_N_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(S_S_N_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,S_S_N_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number(__in,__cfg).__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Social__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan)}],{KEL.typ.int Social__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan});
  EXPORT NullCounts := DATASET([
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d0(__NL(Header_Hit_Flag_))),COUNT(__d0(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d1(__NL(Social_))),COUNT(__d1(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d1(__NL(Header_Hit_Flag_))),COUNT(__d1(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d2(__NL(Social_))),COUNT(__d2(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d3(__NL(Social_))),COUNT(__d3(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d4(__NL(Social_))),COUNT(__d4(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d4(__NL(Location_))),COUNT(__d4(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(Date_Vendor_First_Reported_=0)),COUNT(__d4(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(Date_Vendor_Last_Reported_=0)),COUNT(__d4(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d5(__NL(Social_))),COUNT(__d5(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d5(__NL(Location_))),COUNT(__d5(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d5(Date_Vendor_First_Reported_=0)),COUNT(__d5(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d5(Date_Vendor_Last_Reported_=0)),COUNT(__d5(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d6(__NL(Social_))),COUNT(__d6(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d6(__NL(Location_))),COUNT(__d6(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d6(Date_Vendor_First_Reported_=0)),COUNT(__d6(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d6(Date_Vendor_Last_Reported_=0)),COUNT(__d6(Date_Vendor_Last_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d7(__NL(Social_))),COUNT(__d7(__NN(Social_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d7(__NL(Location_))),COUNT(__d7(__NN(Location_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d7(Date_Vendor_First_Reported_=0)),COUNT(__d7(Date_Vendor_First_Reported_!=0))},
    {'SSNAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d7(Date_Vendor_Last_Reported_=0)),COUNT(__d7(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
