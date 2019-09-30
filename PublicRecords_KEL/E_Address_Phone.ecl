//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Phone,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Address_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nint Best_Address_Match_Flag_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phonenumber(DEFAULT:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),zip5(DEFAULT:Z_I_P5_:0),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)phone != 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)phone != 0);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d1_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_Address),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)zip != 0);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d2_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_DID),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)zip != 0);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d3_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Kfetch2_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Kfetch2_LinkIds),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)zip != 0 AND (UNSIGNED)phone != 0);
  SHARED __d4_Location__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d4_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d4_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Prefiltered := __d4_Location__Mapped;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),source(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),pub_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_YellowPages__kfetch_yellowpages_linkids,TRANSFORM(RECORDOF(__in.Dataset_YellowPages__kfetch_yellowpages_linkids),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d5_Location__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d5_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d5_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d5_Prefiltered := __d5_Location__Mapped;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),z5(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_DID,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_DID),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d6_Location__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d6_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d6_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d6_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d6_Prefiltered := __d6_Location__Mapped;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),z5(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Address,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Address),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d7_Location__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d7_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d7_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d7_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d7_Prefiltered := __d7_Location__Mapped;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping8 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),z5(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Phone,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Phone),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d8_Location__Layout := RECORD
    RECORDOF(__d8_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d8_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d8_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d8_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d8_Prefiltered := __d8_Location__Mapped;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping9 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),z5(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_LinkIds),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d9_Location__Layout := RECORD
    RECORDOF(__d9_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d9_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d9_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d9_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d9_Prefiltered := __d9_Location__Mapped;
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping10 := 'phone_number(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_10Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_10Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Address),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d10_Location__Layout := RECORD
    RECORDOF(__d10_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d10_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d10_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d10_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d10_Prefiltered := __d10_Location__Mapped;
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping11 := 'phone_number(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_11Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_11Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d11_KELfiltered := __d11_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d11_Location__Layout := RECORD
    RECORDOF(__d11_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d11_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d11_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d11_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d11_Prefiltered := __d11_Location__Mapped;
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping12 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_12Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_12Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_InfutorCID__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_InfutorCID__Key_Phone),SELF:=RIGHT));
  EXPORT __d12_KELfiltered := __d12_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)phone != 0);
  SHARED __d12_Location__Layout := RECORD
    RECORDOF(__d12_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d12_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d12_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d12_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d12_Prefiltered := __d12_Location__Mapped;
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_13Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_13Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping13 := 'cellphone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip5(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_13Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_13Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone),SELF:=RIGHT));
  EXPORT __d13_KELfiltered := __d13_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d13_Location__Layout := RECORD
    RECORDOF(__d13_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d13_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d13_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d13_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d13_Prefiltered := __d13_Location__Mapped;
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping14 := 'cellphone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip5(OVERRIDE:Z_I_P5_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_14Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_14Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address),SELF:=RIGHT));
  EXPORT __d14_KELfiltered := __d14_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d14_Location__Layout := RECORD
    RECORDOF(__d14_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d14_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d14_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d14_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d14_Prefiltered := __d14_Location__Mapped;
  SHARED __d14 := __SourceFilter(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_15Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_15Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping15 := 'cellphone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip5(OVERRIDE:Z_I_P5_:0),source(OVERRIDE:Source_:\'\'),src(OVERRIDE:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_15Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_15Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records),SELF:=RIGHT));
  EXPORT __d15_KELfiltered := __d15_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d15_Location__Layout := RECORD
    RECORDOF(__d15_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d15_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d15_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d15_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d15_Prefiltered := __d15_Location__Mapped;
  SHARED __d15 := __SourceFilter(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nint Best_Address_Match_Flag_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Phone_Number_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,Best_Address_Match_Flag_,ALL));
  Address_Phone_Group := __PostFilter;
  Layout Address_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address_Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Address_Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Address_Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Phone_Number__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan)}],{KEL.typ.int Phone_Number__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan});
  EXPORT NullCounts := DATASET([
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d0(__NL(Best_Address_Match_Flag_))),COUNT(__d0(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d1(__NL(Best_Address_Match_Flag_))),COUNT(__d1(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d2(__NL(Best_Address_Match_Flag_))),COUNT(__d2(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d3(__NL(Best_Address_Match_Flag_))),COUNT(__d3(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d4(__NL(Phone_Number_))),COUNT(__d4(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d4(__NL(Location_))),COUNT(__d4(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d4(__NL(Best_Address_Match_Flag_))),COUNT(__d4(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d5(__NL(Phone_Number_))),COUNT(__d5(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d5(__NL(Location_))),COUNT(__d5(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d5(__NL(Best_Address_Match_Flag_))),COUNT(__d5(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d6(__NL(Phone_Number_))),COUNT(__d6(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d6(__NL(Location_))),COUNT(__d6(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d6(__NL(Best_Address_Match_Flag_))),COUNT(__d6(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','z5',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d7(__NL(Phone_Number_))),COUNT(__d7(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d7(__NL(Location_))),COUNT(__d7(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d7(__NL(Best_Address_Match_Flag_))),COUNT(__d7(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','z5',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d8(__NL(Phone_Number_))),COUNT(__d8(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d8(__NL(Location_))),COUNT(__d8(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d8(__NL(Best_Address_Match_Flag_))),COUNT(__d8(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d8(__NL(Primary_Range_))),COUNT(__d8(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d8(__NL(Predirectional_))),COUNT(__d8(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d8(__NL(Primary_Name_))),COUNT(__d8(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d8(__NL(Suffix_))),COUNT(__d8(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d8(__NL(Postdirectional_))),COUNT(__d8(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d8(__NL(Secondary_Range_))),COUNT(__d8(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','z5',COUNT(__d8(__NL(Z_I_P5_))),COUNT(__d8(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d9(__NL(Phone_Number_))),COUNT(__d9(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d9(__NL(Location_))),COUNT(__d9(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d9(__NL(Best_Address_Match_Flag_))),COUNT(__d9(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d9(__NL(Primary_Range_))),COUNT(__d9(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d9(__NL(Predirectional_))),COUNT(__d9(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d9(__NL(Primary_Name_))),COUNT(__d9(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d9(__NL(Suffix_))),COUNT(__d9(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d9(__NL(Postdirectional_))),COUNT(__d9(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d9(__NL(Secondary_Range_))),COUNT(__d9(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','z5',COUNT(__d9(__NL(Z_I_P5_))),COUNT(__d9(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d9(__NL(Original_Source_))),COUNT(__d9(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d10(__NL(Phone_Number_))),COUNT(__d10(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d10(__NL(Location_))),COUNT(__d10(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d10(__NL(Best_Address_Match_Flag_))),COUNT(__d10(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d10(__NL(Primary_Range_))),COUNT(__d10(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d10(__NL(Predirectional_))),COUNT(__d10(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d10(__NL(Primary_Name_))),COUNT(__d10(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d10(__NL(Suffix_))),COUNT(__d10(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d10(__NL(Postdirectional_))),COUNT(__d10(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d10(__NL(Secondary_Range_))),COUNT(__d10(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d10(__NL(Z_I_P5_))),COUNT(__d10(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d10(__NL(Original_Source_))),COUNT(__d10(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d11(__NL(Phone_Number_))),COUNT(__d11(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d11(__NL(Location_))),COUNT(__d11(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d11(__NL(Best_Address_Match_Flag_))),COUNT(__d11(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d11(__NL(Primary_Range_))),COUNT(__d11(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d11(__NL(Predirectional_))),COUNT(__d11(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d11(__NL(Primary_Name_))),COUNT(__d11(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d11(__NL(Suffix_))),COUNT(__d11(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d11(__NL(Postdirectional_))),COUNT(__d11(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d11(__NL(Secondary_Range_))),COUNT(__d11(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d11(__NL(Z_I_P5_))),COUNT(__d11(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d11(__NL(Original_Source_))),COUNT(__d11(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d12(__NL(Phone_Number_))),COUNT(__d12(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d12(__NL(Location_))),COUNT(__d12(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d12(__NL(Best_Address_Match_Flag_))),COUNT(__d12(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d12(__NL(Primary_Range_))),COUNT(__d12(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d12(__NL(Predirectional_))),COUNT(__d12(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d12(__NL(Primary_Name_))),COUNT(__d12(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d12(__NL(Suffix_))),COUNT(__d12(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d12(__NL(Postdirectional_))),COUNT(__d12(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d12(__NL(Secondary_Range_))),COUNT(__d12(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d12(__NL(Z_I_P5_))),COUNT(__d12(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d12(__NL(Original_Source_))),COUNT(__d12(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d13(__NL(Phone_Number_))),COUNT(__d13(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d13(__NL(Location_))),COUNT(__d13(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d13(__NL(Best_Address_Match_Flag_))),COUNT(__d13(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d13(__NL(Primary_Range_))),COUNT(__d13(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d13(__NL(Predirectional_))),COUNT(__d13(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d13(__NL(Primary_Name_))),COUNT(__d13(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d13(__NL(Suffix_))),COUNT(__d13(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d13(__NL(Postdirectional_))),COUNT(__d13(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d13(__NL(Secondary_Range_))),COUNT(__d13(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d13(__NL(Z_I_P5_))),COUNT(__d13(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d13(__NL(Original_Source_))),COUNT(__d13(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d14(__NL(Phone_Number_))),COUNT(__d14(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d14(__NL(Location_))),COUNT(__d14(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d14(__NL(Best_Address_Match_Flag_))),COUNT(__d14(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d14(__NL(Primary_Range_))),COUNT(__d14(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d14(__NL(Predirectional_))),COUNT(__d14(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d14(__NL(Primary_Name_))),COUNT(__d14(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d14(__NL(Suffix_))),COUNT(__d14(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d14(__NL(Postdirectional_))),COUNT(__d14(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d14(__NL(Secondary_Range_))),COUNT(__d14(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d14(__NL(Z_I_P5_))),COUNT(__d14(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d14(__NL(Original_Source_))),COUNT(__d14(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d15(__NL(Phone_Number_))),COUNT(__d15(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d15(__NL(Location_))),COUNT(__d15(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressMatchFlag',COUNT(__d15(__NL(Best_Address_Match_Flag_))),COUNT(__d15(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d15(__NL(Primary_Range_))),COUNT(__d15(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d15(__NL(Predirectional_))),COUNT(__d15(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d15(__NL(Primary_Name_))),COUNT(__d15(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d15(__NL(Suffix_))),COUNT(__d15(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d15(__NL(Postdirectional_))),COUNT(__d15(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d15(__NL(Secondary_Range_))),COUNT(__d15(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d15(__NL(Z_I_P5_))),COUNT(__d15(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d15(__NL(Original_Source_))),COUNT(__d15(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
