//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Person_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nint Address_Rank_;
    KEL.typ.nint Insurance_Source_Count_;
    KEL.typ.nint Property_Source_Count_;
    KEL.typ.nint Utility_Source_Count_;
    KEL.typ.nint Vehicle_Source_Count_;
    KEL.typ.nint D_L_Source_Count_;
    KEL.typ.nint Voter_Source_Count_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Geo_Mmatch_;
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
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Location_(DEFAULT:Location_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d0_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d0_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Location__Mapped,'GeoLinkID','__in');
  SHARED __d0_Geo_Link_I_D__Mapped := IF(__d0_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d0_Location__Mapped,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Location__Mapped,__d0_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__in,__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Geo_Link_I_D__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d1_Location__Mapped := IF(__d1_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d1_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d1_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Location__Mapped,'GeoLinkID','__in');
  SHARED __d1_Geo_Link_I_D__Mapped := IF(__d1_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d1_Location__Mapped,TRANSFORM(__d1_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Location__Mapped,__d1_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__in,__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d1_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Geo_Link_I_D__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 's_did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),v_city_name(OVERRIDE:Postal_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),address_history_seq(OVERRIDE:Address_Rank_:0),insurance_source_count(OVERRIDE:Insurance_Source_Count_:0),property_source_count(OVERRIDE:Property_Source_Count_:0),utility_source_count(OVERRIDE:Utility_Source_Count_:0),vehicle_source_count(OVERRIDE:Vehicle_Source_Count_:0),dl_source_count(OVERRIDE:D_L_Source_Count_:0),voter_source_count(OVERRIDE:Voter_Source_Count_:0),addresstype(OVERRIDE:Address_Type_:\'\'),statecode(OVERRIDE:State_Code_:\'\'),county(OVERRIDE:County_Code_:\'\'),geo_lat(OVERRIDE:Latitude_:\'\'),geo_long(OVERRIDE:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geo_blk(OVERRIDE:Geo_Blk_:\'\'),geo_match(OVERRIDE:Geo_Mmatch_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Header__Key_Addr_Hist,TRANSFORM(RECORDOF(__in.Dataset_Header__Key_Addr_Hist),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((STRING28)prim_name != '' AND (UNSIGNED)zip != 0 AND (UNSIGNED)s_did != 0);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d2_Location__Mapped := IF(__d2_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d2_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d2_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_Location__Mapped,'GeoLinkID','__in');
  SHARED __d2_Geo_Link_I_D__Mapped := IF(__d2_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d2_Location__Mapped,TRANSFORM(__d2_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_Location__Mapped,__d2_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__in,__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d2_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Geo_Link_I_D__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_3Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header_Address,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header_Address),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d3_Location__Mapped := IF(__d3_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d3_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d3_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_Location__Mapped,'GeoLinkID','__in');
  SHARED __d3_Geo_Link_I_D__Mapped := IF(__d3_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d3_Location__Mapped,TRANSFORM(__d3_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_Location__Mapped,__d3_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__in,__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d3_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Geo_Link_I_D__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping3_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Address_Rank_Details_Layout := RECORD
    KEL.typ.nint Address_Rank_;
    KEL.typ.nint Insurance_Source_Count_;
    KEL.typ.nint Property_Source_Count_;
    KEL.typ.nint Utility_Source_Count_;
    KEL.typ.nint Vehicle_Source_Count_;
    KEL.typ.nint D_L_Source_Count_;
    KEL.typ.nint Voter_Source_Count_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Hierarchy_Layout := RECORD
    KEL.typ.nint Address_Rank_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Geo_Mmatch_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
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
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ndataset(Address_Rank_Details_Layout) Address_Rank_Details_;
    KEL.typ.ndataset(Address_Hierarchy_Layout) Address_Hierarchy_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,ALL));
  Person_Address_Group := __PostFilter;
  Layout Person_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Address_Rank_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Address_Rank_,Insurance_Source_Count_,Property_Source_Count_,Utility_Source_Count_,Vehicle_Source_Count_,D_L_Source_Count_,Voter_Source_Count_,Address_Type_},Address_Rank_,Insurance_Source_Count_,Property_Source_Count_,Utility_Source_Count_,Vehicle_Source_Count_,D_L_Source_Count_,Voter_Source_Count_,Address_Type_),Address_Rank_Details_Layout)(__NN(Address_Rank_) OR __NN(Insurance_Source_Count_) OR __NN(Property_Source_Count_) OR __NN(Utility_Source_Count_) OR __NN(Vehicle_Source_Count_) OR __NN(D_L_Source_Count_) OR __NN(Voter_Source_Count_) OR __NN(Address_Type_)));
    SELF.Address_Hierarchy_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Address_Rank_,Address_Type_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,State_Code_,County_Code_,Latitude_,Longitude_,Geo_Blk_,Geo_Mmatch_,Geo_Link_I_D_},Address_Rank_,Address_Type_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,State_Code_,County_Code_,Latitude_,Longitude_,Geo_Blk_,Geo_Mmatch_,Geo_Link_I_D_),Address_Hierarchy_Layout)(__NN(Address_Rank_) OR __NN(Address_Type_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Unit_Designation_) OR __NN(Secondary_Range_) OR __NN(Postal_City_) OR __NN(State_) OR __NN(Z_I_P5_) OR __NN(Z_I_P4_) OR __NN(State_Code_) OR __NN(County_Code_) OR __NN(Latitude_) OR __NN(Longitude_) OR __NN(Geo_Blk_) OR __NN(Geo_Mmatch_) OR __NN(Geo_Link_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Rank_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Rank_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Address_Rank_) OR __NN(Insurance_Source_Count_) OR __NN(Property_Source_Count_) OR __NN(Utility_Source_Count_) OR __NN(Vehicle_Source_Count_) OR __NN(D_L_Source_Count_) OR __NN(Voter_Source_Count_) OR __NN(Address_Type_)));
    SELF.Address_Hierarchy_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Hierarchy_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Address_Rank_) OR __NN(Address_Type_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Unit_Designation_) OR __NN(Secondary_Range_) OR __NN(Postal_City_) OR __NN(State_) OR __NN(Z_I_P5_) OR __NN(Z_I_P4_) OR __NN(State_Code_) OR __NN(County_Code_) OR __NN(Latitude_) OR __NN(Longitude_) OR __NN(Geo_Blk_) OR __NN(Geo_Mmatch_) OR __NN(Geo_Link_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Geo_Link_I_D__Orphan := JOIN(InData(__NN(Geo_Link_I_D_)),E_Geo_Link(__in,__cfg).__Result,__EEQP(LEFT.Geo_Link_I_D_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan),COUNT(Geo_Link_I_D__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan,KEL.typ.int Geo_Link_I_D__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d0(__NL(Z_I_P4_))),COUNT(__d0(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d0(__NL(Address_Rank_))),COUNT(__d0(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d0(__NL(Insurance_Source_Count_))),COUNT(__d0(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d0(__NL(Property_Source_Count_))),COUNT(__d0(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d0(__NL(Utility_Source_Count_))),COUNT(__d0(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d0(__NL(Vehicle_Source_Count_))),COUNT(__d0(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d0(__NL(D_L_Source_Count_))),COUNT(__d0(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d0(__NL(Voter_Source_Count_))),COUNT(__d0(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d0(__NL(Address_Type_))),COUNT(__d0(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateCode',COUNT(__d0(__NL(State_Code_))),COUNT(__d0(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyCode',COUNT(__d0(__NL(County_Code_))),COUNT(__d0(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoLinkID',COUNT(__d0(__NL(Geo_Link_I_D_))),COUNT(__d0(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlk',COUNT(__d0(__NL(Geo_Blk_))),COUNT(__d0(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMmatch',COUNT(__d0(__NL(Geo_Mmatch_))),COUNT(__d0(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d1(__NL(Z_I_P4_))),COUNT(__d1(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d1(__NL(Address_Rank_))),COUNT(__d1(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d1(__NL(Insurance_Source_Count_))),COUNT(__d1(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d1(__NL(Property_Source_Count_))),COUNT(__d1(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d1(__NL(Utility_Source_Count_))),COUNT(__d1(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d1(__NL(Vehicle_Source_Count_))),COUNT(__d1(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d1(__NL(D_L_Source_Count_))),COUNT(__d1(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d1(__NL(Voter_Source_Count_))),COUNT(__d1(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d1(__NL(Address_Type_))),COUNT(__d1(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateCode',COUNT(__d1(__NL(State_Code_))),COUNT(__d1(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyCode',COUNT(__d1(__NL(County_Code_))),COUNT(__d1(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d1(__NL(Latitude_))),COUNT(__d1(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d1(__NL(Longitude_))),COUNT(__d1(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoLinkID',COUNT(__d1(__NL(Geo_Link_I_D_))),COUNT(__d1(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlk',COUNT(__d1(__NL(Geo_Blk_))),COUNT(__d1(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMmatch',COUNT(__d1(__NL(Geo_Mmatch_))),COUNT(__d1(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','s_did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d2(__NL(Unit_Designation_))),COUNT(__d2(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d2(__NL(Postal_City_))),COUNT(__d2(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d2(__NL(Z_I_P4_))),COUNT(__d2(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_history_seq',COUNT(__d2(__NL(Address_Rank_))),COUNT(__d2(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Insurance_Source_Count',COUNT(__d2(__NL(Insurance_Source_Count_))),COUNT(__d2(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Property_Source_Count',COUNT(__d2(__NL(Property_Source_Count_))),COUNT(__d2(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Utility_Source_Count',COUNT(__d2(__NL(Utility_Source_Count_))),COUNT(__d2(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Vehicle_Source_Count',COUNT(__d2(__NL(Vehicle_Source_Count_))),COUNT(__d2(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DL_Source_Count',COUNT(__d2(__NL(D_L_Source_Count_))),COUNT(__d2(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Voter_Source_Count',COUNT(__d2(__NL(Voter_Source_Count_))),COUNT(__d2(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d2(__NL(Address_Type_))),COUNT(__d2(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateCode',COUNT(__d2(__NL(State_Code_))),COUNT(__d2(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d2(__NL(County_Code_))),COUNT(__d2(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d2(__NL(Latitude_))),COUNT(__d2(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d2(__NL(Longitude_))),COUNT(__d2(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoLinkID',COUNT(__d2(__NL(Geo_Link_I_D_))),COUNT(__d2(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d2(__NL(Geo_Blk_))),COUNT(__d2(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d2(__NL(Geo_Mmatch_))),COUNT(__d2(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d3(__NL(Unit_Designation_))),COUNT(__d3(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d3(__NL(Postal_City_))),COUNT(__d3(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d3(__NL(Z_I_P4_))),COUNT(__d3(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRank',COUNT(__d3(__NL(Address_Rank_))),COUNT(__d3(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InsuranceSourceCount',COUNT(__d3(__NL(Insurance_Source_Count_))),COUNT(__d3(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertySourceCount',COUNT(__d3(__NL(Property_Source_Count_))),COUNT(__d3(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilitySourceCount',COUNT(__d3(__NL(Utility_Source_Count_))),COUNT(__d3(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSourceCount',COUNT(__d3(__NL(Vehicle_Source_Count_))),COUNT(__d3(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DLSourceCount',COUNT(__d3(__NL(D_L_Source_Count_))),COUNT(__d3(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VoterSourceCount',COUNT(__d3(__NL(Voter_Source_Count_))),COUNT(__d3(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressType',COUNT(__d3(__NL(Address_Type_))),COUNT(__d3(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateCode',COUNT(__d3(__NL(State_Code_))),COUNT(__d3(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyCode',COUNT(__d3(__NL(County_Code_))),COUNT(__d3(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d3(__NL(Latitude_))),COUNT(__d3(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d3(__NL(Longitude_))),COUNT(__d3(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoLinkID',COUNT(__d3(__NL(Geo_Link_I_D_))),COUNT(__d3(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlk',COUNT(__d3(__NL(Geo_Blk_))),COUNT(__d3(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMmatch',COUNT(__d3(__NL(Geo_Mmatch_))),COUNT(__d3(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'PersonAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
