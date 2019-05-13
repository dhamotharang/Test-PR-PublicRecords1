//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Business_Sele(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Family_;
    KEL.typ.nstr Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nstr Is_Corporation_;
    KEL.typ.nstr Company_Name_;
    KEL.typ.nstr Company_Name_Type_;
    KEL.typ.nstr Corporation_Number_;
    KEL.typ.nstr Business_Type_;
    KEL.typ.nstr Low_Value_Works_;
    KEL.typ.nstr Corporation_Legal_Name_;
    KEL.typ.nstr Doing_Business_As_;
    KEL.typ.nstr Active_Enterprise_Number_;
    KEL.typ.nstr Hist_Enterprise_Number_;
    KEL.typ.nstr Ebr_File_Number_;
    KEL.typ.nstr Active_Domestic_Corporation_Key_;
    KEL.typ.nstr Hist_Domestic_Corporation_Key_;
    KEL.typ.nstr Foreign_Corporation_Key_;
    KEL.typ.nstr Unknown_Corporation_Key_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Company_Organization_Structure_;
    KEL.typ.nkdate Company_Incorporation_Date_;
    KEL.typ.nint Standard_Industrial_Classification_Code1_;
    KEL.typ.nint Standard_Industrial_Classification_Code2_;
    KEL.typ.nint Standard_Industrial_Classification_Code3_;
    KEL.typ.nint Standard_Industrial_Classification_Code4_;
    KEL.typ.nint Standard_Industrial_Classification_Code5_;
    KEL.typ.nint North_American_Industry_Classification_System_Code1_;
    KEL.typ.nint North_American_Industry_Classification_System_Code2_;
    KEL.typ.nint North_American_Industry_Classification_System_Code3_;
    KEL.typ.nint North_American_Industry_Classification_System_Code4_;
    KEL.typ.nint North_American_Industry_Classification_System_Code5_;
    KEL.typ.nstr Company_Ticker_;
    KEL.typ.nstr Company_Ticker_Exchange_;
    KEL.typ.nstr Company_Foreign_Domestic_;
    KEL.typ.nstr Company_U_R_L_;
    KEL.typ.nstr State_Incorporated_;
    KEL.typ.nstr Charter_Number_;
    KEL.typ.nkdate Company_Filing_Date_;
    KEL.typ.nkdate Company_Status_Date_;
    KEL.typ.nkdate Company_Foreign_Date_;
    KEL.typ.nkdate Event_Filing_Date_;
    KEL.typ.nstr Company_Name_Status_;
    KEL.typ.nstr Company_Status_;
    KEL.typ.nkdate Date_First_Seen_Company_Name_;
    KEL.typ.nkdate Date_Last_Seen_Company_Name_;
    KEL.typ.nstr Current_Indicator_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),Family_(Family_:0),selegold(Sele_Gold_:\'\'),isselelevel(Is_Sele_Level_),isorglevel(Is_Org_Level_),isultlevel(Is_Ult_Level_),selesegment(Sele_Segment_:\'\'),iscorporation(Is_Corporation_:\'\'),companyname(Company_Name_:\'\'),companynametype(Company_Name_Type_:\'\'),corporationnumber(Corporation_Number_:\'\'),businesstype(Business_Type_:\'\'),lowvalueworks(Low_Value_Works_:\'\'),corporationlegalname(Corporation_Legal_Name_:\'\'),doingbusinessas(Doing_Business_As_:\'\'),activeenterprisenumber(Active_Enterprise_Number_:\'\'),histenterprisenumber(Hist_Enterprise_Number_:\'\'),ebrfilenumber(Ebr_File_Number_:\'\'),activedomesticcorporationkey(Active_Domestic_Corporation_Key_:\'\'),histdomesticcorporationkey(Hist_Domestic_Corporation_Key_:\'\'),foreigncorporationkey(Foreign_Corporation_Key_:\'\'),unknowncorporationkey(Unknown_Corporation_Key_:\'\'),datevendorfirstreported(Date_Vendor_First_Reported_:DATE),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),companyorganizationstructure(Company_Organization_Structure_:\'\'),companyincorporationdate(Company_Incorporation_Date_:DATE),standardindustrialclassificationcode1(Standard_Industrial_Classification_Code1_:0),standardindustrialclassificationcode2(Standard_Industrial_Classification_Code2_:0),standardindustrialclassificationcode3(Standard_Industrial_Classification_Code3_:0),standardindustrialclassificationcode4(Standard_Industrial_Classification_Code4_:0),standardindustrialclassificationcode5(Standard_Industrial_Classification_Code5_:0),northamericanindustryclassificationsystemcode1(North_American_Industry_Classification_System_Code1_:0),northamericanindustryclassificationsystemcode2(North_American_Industry_Classification_System_Code2_:0),northamericanindustryclassificationsystemcode3(North_American_Industry_Classification_System_Code3_:0),northamericanindustryclassificationsystemcode4(North_American_Industry_Classification_System_Code4_:0),northamericanindustryclassificationsystemcode5(North_American_Industry_Classification_System_Code5_:0),companyticker(Company_Ticker_:\'\'),companytickerexchange(Company_Ticker_Exchange_:\'\'),companyforeigndomestic(Company_Foreign_Domestic_:\'\'),companyurl(Company_U_R_L_:\'\'),stateincorporated(State_Incorporated_:\'\'),charternumber(Charter_Number_:\'\'),companyfilingdate(Company_Filing_Date_:DATE),companystatusdate(Company_Status_Date_:DATE),companyforeigndate(Company_Foreign_Date_:DATE),eventfilingdate(Event_Filing_Date_:DATE),companynamestatus(Company_Name_Status_:\'\'),companystatus(Company_Status_:\'\'),datefirstseencompanyname(Date_First_Seen_Company_Name_:DATE),datelastseencompanyname(Date_Last_Seen_Company_Name_:DATE),currentindicator(Current_Indicator_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),Family_(Family_:0),sele_gold(Sele_Gold_:\'\'),is_sele_level(Is_Sele_Level_),is_org_level(Is_Org_Level_),is_ult_level(Is_Ult_Level_),sele_seg(Sele_Segment_:\'\'),iscorp(Is_Corporation_:\'\'),company_name(Company_Name_:\'\'),company_name_type_derived(Company_Name_Type_:\'\'),cnp_number(Corporation_Number_:\'\'),cnp_btype(Business_Type_:\'\'),cnp_lowv(Low_Value_Works_:\'\'),corp_legal_name(Corporation_Legal_Name_:\'\'),dba_name(Doing_Business_As_:\'\'),active_enterprise_number(Active_Enterprise_Number_:\'\'),hist_enterprise_number(Hist_Enterprise_Number_:\'\'),ebr_file_number(Ebr_File_Number_:\'\'),active_domestic_corp_key(Active_Domestic_Corporation_Key_:\'\'),hist_domestic_corp_key(Hist_Domestic_Corporation_Key_:\'\'),foreign_corp_key(Foreign_Corporation_Key_:\'\'),unk_corp_key(Unknown_Corporation_Key_:\'\'),dt_vendor_first_reported(Date_Vendor_First_Reported_:DATE),dt_vendor_last_reported(Date_Vendor_Last_Reported_:DATE),company_org_structure_raw(Company_Organization_Structure_:\'\'),company_incorporation_date(Company_Incorporation_Date_:DATE),company_sic_code1(Standard_Industrial_Classification_Code1_:0),company_sic_code2(Standard_Industrial_Classification_Code2_:0),company_sic_code3(Standard_Industrial_Classification_Code3_:0),company_sic_code4(Standard_Industrial_Classification_Code4_:0),company_sic_code5(Standard_Industrial_Classification_Code5_:0),company_naics_code1(North_American_Industry_Classification_System_Code1_:0),company_naics_code2(North_American_Industry_Classification_System_Code2_:0),company_naics_code3(North_American_Industry_Classification_System_Code3_:0),company_naics_code4(North_American_Industry_Classification_System_Code4_:0),company_naics_code5(North_American_Industry_Classification_System_Code5_:0),company_ticker(Company_Ticker_:\'\'),company_ticker_exchange(Company_Ticker_Exchange_:\'\'),company_foreign_domestic(Company_Foreign_Domestic_:\'\'),company_url(Company_U_R_L_:\'\'),company_inc_state(State_Incorporated_:\'\'),company_charter_number(Charter_Number_:\'\'),company_filing_date(Company_Filing_Date_:DATE),company_status_date(Company_Status_Date_:DATE),company_foreign_date(Company_Foreign_Date_:DATE),event_filing_date(Event_Filing_Date_:DATE),company_name_status_raw(Company_Name_Status_:\'\'),company_status_raw(Company_Status_:\'\'),dt_first_seen_company_name(Date_First_Seen_Company_Name_:DATE),dt_last_seen_company_name(Date_Last_Seen_Company_Name_:DATE),current(Current_Indicator_:\'\'),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2__Key_BH_Linking_Ids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d0_Family__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Family_;
  END;
  SHARED __d0_Family__Mapped := JOIN(__d0_UID_Mapped,E_Business_Org(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) = RIGHT.KeyVal,TRANSFORM(__d0_Family__Layout,SELF.Family_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid := __d0_Family__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Family__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Reported_Company_Names_Layout := RECORD
    KEL.typ.nstr Company_Name_;
    KEL.typ.nstr Company_Name_Type_;
    KEL.typ.nstr Company_Name_Status_;
    KEL.typ.nkdate Date_First_Seen_Company_Name_;
    KEL.typ.nkdate Date_Last_Seen_Company_Name_;
    KEL.typ.nstr Corporation_Legal_Name_;
    KEL.typ.nstr Doing_Business_As_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Current_Record_Indicator_Layout := RECORD
    KEL.typ.nstr Current_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vendor_Dates_Layout := RECORD
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Family_;
    KEL.typ.nstr Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nstr Is_Corporation_;
    KEL.typ.nstr Corporation_Number_;
    KEL.typ.nstr Business_Type_;
    KEL.typ.nstr Low_Value_Works_;
    KEL.typ.nstr Active_Enterprise_Number_;
    KEL.typ.nstr Hist_Enterprise_Number_;
    KEL.typ.nstr Ebr_File_Number_;
    KEL.typ.nstr Active_Domestic_Corporation_Key_;
    KEL.typ.nstr Hist_Domestic_Corporation_Key_;
    KEL.typ.nstr Foreign_Corporation_Key_;
    KEL.typ.nstr Unknown_Corporation_Key_;
    KEL.typ.nstr Company_Organization_Structure_;
    KEL.typ.nkdate Company_Incorporation_Date_;
    KEL.typ.nint Standard_Industrial_Classification_Code1_;
    KEL.typ.nint Standard_Industrial_Classification_Code2_;
    KEL.typ.nint Standard_Industrial_Classification_Code3_;
    KEL.typ.nint Standard_Industrial_Classification_Code4_;
    KEL.typ.nint Standard_Industrial_Classification_Code5_;
    KEL.typ.nint North_American_Industry_Classification_System_Code1_;
    KEL.typ.nint North_American_Industry_Classification_System_Code2_;
    KEL.typ.nint North_American_Industry_Classification_System_Code3_;
    KEL.typ.nint North_American_Industry_Classification_System_Code4_;
    KEL.typ.nint North_American_Industry_Classification_System_Code5_;
    KEL.typ.nstr Company_Ticker_;
    KEL.typ.nstr Company_Ticker_Exchange_;
    KEL.typ.nstr Company_Foreign_Domestic_;
    KEL.typ.nstr Company_U_R_L_;
    KEL.typ.nstr State_Incorporated_;
    KEL.typ.nstr Charter_Number_;
    KEL.typ.nkdate Company_Filing_Date_;
    KEL.typ.nkdate Company_Status_Date_;
    KEL.typ.nkdate Company_Foreign_Date_;
    KEL.typ.nkdate Event_Filing_Date_;
    KEL.typ.nstr Company_Status_;
    KEL.typ.ndataset(Reported_Company_Names_Layout) Reported_Company_Names_;
    KEL.typ.ndataset(Current_Record_Indicator_Layout) Current_Record_Indicator_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Sele_Group := __PostFilter;
  Layout Business_Sele__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Family_ := KEL.Intake.SingleValue(__recs,Family_);
    SELF.Sele_Gold_ := KEL.Intake.SingleValue(__recs,Sele_Gold_);
    SELF.Is_Sele_Level_ := KEL.Intake.SingleValue(__recs,Is_Sele_Level_);
    SELF.Is_Org_Level_ := KEL.Intake.SingleValue(__recs,Is_Org_Level_);
    SELF.Is_Ult_Level_ := KEL.Intake.SingleValue(__recs,Is_Ult_Level_);
    SELF.Sele_Segment_ := KEL.Intake.SingleValue(__recs,Sele_Segment_);
    SELF.Is_Corporation_ := KEL.Intake.SingleValue(__recs,Is_Corporation_);
    SELF.Corporation_Number_ := KEL.Intake.SingleValue(__recs,Corporation_Number_);
    SELF.Business_Type_ := KEL.Intake.SingleValue(__recs,Business_Type_);
    SELF.Low_Value_Works_ := KEL.Intake.SingleValue(__recs,Low_Value_Works_);
    SELF.Active_Enterprise_Number_ := KEL.Intake.SingleValue(__recs,Active_Enterprise_Number_);
    SELF.Hist_Enterprise_Number_ := KEL.Intake.SingleValue(__recs,Hist_Enterprise_Number_);
    SELF.Ebr_File_Number_ := KEL.Intake.SingleValue(__recs,Ebr_File_Number_);
    SELF.Active_Domestic_Corporation_Key_ := KEL.Intake.SingleValue(__recs,Active_Domestic_Corporation_Key_);
    SELF.Hist_Domestic_Corporation_Key_ := KEL.Intake.SingleValue(__recs,Hist_Domestic_Corporation_Key_);
    SELF.Foreign_Corporation_Key_ := KEL.Intake.SingleValue(__recs,Foreign_Corporation_Key_);
    SELF.Unknown_Corporation_Key_ := KEL.Intake.SingleValue(__recs,Unknown_Corporation_Key_);
    SELF.Company_Organization_Structure_ := KEL.Intake.SingleValue(__recs,Company_Organization_Structure_);
    SELF.Company_Incorporation_Date_ := KEL.Intake.SingleValue(__recs,Company_Incorporation_Date_);
    SELF.Standard_Industrial_Classification_Code1_ := KEL.Intake.SingleValue(__recs,Standard_Industrial_Classification_Code1_);
    SELF.Standard_Industrial_Classification_Code2_ := KEL.Intake.SingleValue(__recs,Standard_Industrial_Classification_Code2_);
    SELF.Standard_Industrial_Classification_Code3_ := KEL.Intake.SingleValue(__recs,Standard_Industrial_Classification_Code3_);
    SELF.Standard_Industrial_Classification_Code4_ := KEL.Intake.SingleValue(__recs,Standard_Industrial_Classification_Code4_);
    SELF.Standard_Industrial_Classification_Code5_ := KEL.Intake.SingleValue(__recs,Standard_Industrial_Classification_Code5_);
    SELF.North_American_Industry_Classification_System_Code1_ := KEL.Intake.SingleValue(__recs,North_American_Industry_Classification_System_Code1_);
    SELF.North_American_Industry_Classification_System_Code2_ := KEL.Intake.SingleValue(__recs,North_American_Industry_Classification_System_Code2_);
    SELF.North_American_Industry_Classification_System_Code3_ := KEL.Intake.SingleValue(__recs,North_American_Industry_Classification_System_Code3_);
    SELF.North_American_Industry_Classification_System_Code4_ := KEL.Intake.SingleValue(__recs,North_American_Industry_Classification_System_Code4_);
    SELF.North_American_Industry_Classification_System_Code5_ := KEL.Intake.SingleValue(__recs,North_American_Industry_Classification_System_Code5_);
    SELF.Company_Ticker_ := KEL.Intake.SingleValue(__recs,Company_Ticker_);
    SELF.Company_Ticker_Exchange_ := KEL.Intake.SingleValue(__recs,Company_Ticker_Exchange_);
    SELF.Company_Foreign_Domestic_ := KEL.Intake.SingleValue(__recs,Company_Foreign_Domestic_);
    SELF.Company_U_R_L_ := KEL.Intake.SingleValue(__recs,Company_U_R_L_);
    SELF.State_Incorporated_ := KEL.Intake.SingleValue(__recs,State_Incorporated_);
    SELF.Charter_Number_ := KEL.Intake.SingleValue(__recs,Charter_Number_);
    SELF.Company_Filing_Date_ := KEL.Intake.SingleValue(__recs,Company_Filing_Date_);
    SELF.Company_Status_Date_ := KEL.Intake.SingleValue(__recs,Company_Status_Date_);
    SELF.Company_Foreign_Date_ := KEL.Intake.SingleValue(__recs,Company_Foreign_Date_);
    SELF.Event_Filing_Date_ := KEL.Intake.SingleValue(__recs,Event_Filing_Date_);
    SELF.Company_Status_ := KEL.Intake.SingleValue(__recs,Company_Status_);
    SELF.Reported_Company_Names_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Company_Name_,Company_Name_Type_,Company_Name_Status_,Date_First_Seen_Company_Name_,Date_Last_Seen_Company_Name_,Corporation_Legal_Name_,Doing_Business_As_},Company_Name_,Company_Name_Type_,Company_Name_Status_,Date_First_Seen_Company_Name_,Date_Last_Seen_Company_Name_,Corporation_Legal_Name_,Doing_Business_As_),Reported_Company_Names_Layout)(__NN(Company_Name_) OR __NN(Company_Name_Type_) OR __NN(Company_Name_Status_) OR __NN(Date_First_Seen_Company_Name_) OR __NN(Date_Last_Seen_Company_Name_) OR __NN(Corporation_Legal_Name_) OR __NN(Doing_Business_As_)));
    SELF.Current_Record_Indicator_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Current_Indicator_},Current_Indicator_),Current_Record_Indicator_Layout)(__NN(Current_Indicator_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Vendor_Dates_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Business_Sele__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Reported_Company_Names_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Company_Names_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Company_Name_) OR __NN(Company_Name_Type_) OR __NN(Company_Name_Status_) OR __NN(Date_First_Seen_Company_Name_) OR __NN(Date_Last_Seen_Company_Name_) OR __NN(Corporation_Legal_Name_) OR __NN(Doing_Business_As_)));
    SELF.Current_Record_Indicator_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Current_Record_Indicator_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Current_Indicator_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Sele_Group,COUNT(ROWS(LEFT))=1),GROUP,Business_Sele__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Sele_Group,COUNT(ROWS(LEFT))>1),GROUP,Business_Sele__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_I_D_);
  EXPORT Family__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Family_);
  EXPORT Sele_Gold__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_Gold_);
  EXPORT Is_Sele_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Sele_Level_);
  EXPORT Is_Org_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Org_Level_);
  EXPORT Is_Ult_Level__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Ult_Level_);
  EXPORT Sele_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_Segment_);
  EXPORT Is_Corporation__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Corporation_);
  EXPORT Corporation_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Corporation_Number_);
  EXPORT Business_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Business_Type_);
  EXPORT Low_Value_Works__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Low_Value_Works_);
  EXPORT Active_Enterprise_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Active_Enterprise_Number_);
  EXPORT Hist_Enterprise_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Hist_Enterprise_Number_);
  EXPORT Ebr_File_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ebr_File_Number_);
  EXPORT Active_Domestic_Corporation_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Active_Domestic_Corporation_Key_);
  EXPORT Hist_Domestic_Corporation_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Hist_Domestic_Corporation_Key_);
  EXPORT Foreign_Corporation_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreign_Corporation_Key_);
  EXPORT Unknown_Corporation_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Unknown_Corporation_Key_);
  EXPORT Company_Organization_Structure__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Organization_Structure_);
  EXPORT Company_Incorporation_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Incorporation_Date_);
  EXPORT Standard_Industrial_Classification_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standard_Industrial_Classification_Code1_);
  EXPORT Standard_Industrial_Classification_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standard_Industrial_Classification_Code2_);
  EXPORT Standard_Industrial_Classification_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standard_Industrial_Classification_Code3_);
  EXPORT Standard_Industrial_Classification_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standard_Industrial_Classification_Code4_);
  EXPORT Standard_Industrial_Classification_Code5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standard_Industrial_Classification_Code5_);
  EXPORT North_American_Industry_Classification_System_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,North_American_Industry_Classification_System_Code1_);
  EXPORT North_American_Industry_Classification_System_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,North_American_Industry_Classification_System_Code2_);
  EXPORT North_American_Industry_Classification_System_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,North_American_Industry_Classification_System_Code3_);
  EXPORT North_American_Industry_Classification_System_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,North_American_Industry_Classification_System_Code4_);
  EXPORT North_American_Industry_Classification_System_Code5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,North_American_Industry_Classification_System_Code5_);
  EXPORT Company_Ticker__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Ticker_);
  EXPORT Company_Ticker_Exchange__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Ticker_Exchange_);
  EXPORT Company_Foreign_Domestic__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Foreign_Domestic_);
  EXPORT Company_U_R_L__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_U_R_L_);
  EXPORT State_Incorporated__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Incorporated_);
  EXPORT Charter_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Charter_Number_);
  EXPORT Company_Filing_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Filing_Date_);
  EXPORT Company_Status_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Status_Date_);
  EXPORT Company_Foreign_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Foreign_Date_);
  EXPORT Event_Filing_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Event_Filing_Date_);
  EXPORT Company_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Status_);
  EXPORT Family__Orphan := JOIN(InData(__NN(Family_)),E_Business_Org(__in,__cfg).__Result,__EEQP(LEFT.Family_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Family__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid),COUNT(Family__SingleValue_Invalid),COUNT(Sele_Gold__SingleValue_Invalid),COUNT(Is_Sele_Level__SingleValue_Invalid),COUNT(Is_Org_Level__SingleValue_Invalid),COUNT(Is_Ult_Level__SingleValue_Invalid),COUNT(Sele_Segment__SingleValue_Invalid),COUNT(Is_Corporation__SingleValue_Invalid),COUNT(Corporation_Number__SingleValue_Invalid),COUNT(Business_Type__SingleValue_Invalid),COUNT(Low_Value_Works__SingleValue_Invalid),COUNT(Active_Enterprise_Number__SingleValue_Invalid),COUNT(Hist_Enterprise_Number__SingleValue_Invalid),COUNT(Ebr_File_Number__SingleValue_Invalid),COUNT(Active_Domestic_Corporation_Key__SingleValue_Invalid),COUNT(Hist_Domestic_Corporation_Key__SingleValue_Invalid),COUNT(Foreign_Corporation_Key__SingleValue_Invalid),COUNT(Unknown_Corporation_Key__SingleValue_Invalid),COUNT(Company_Organization_Structure__SingleValue_Invalid),COUNT(Company_Incorporation_Date__SingleValue_Invalid),COUNT(Standard_Industrial_Classification_Code1__SingleValue_Invalid),COUNT(Standard_Industrial_Classification_Code2__SingleValue_Invalid),COUNT(Standard_Industrial_Classification_Code3__SingleValue_Invalid),COUNT(Standard_Industrial_Classification_Code4__SingleValue_Invalid),COUNT(Standard_Industrial_Classification_Code5__SingleValue_Invalid),COUNT(North_American_Industry_Classification_System_Code1__SingleValue_Invalid),COUNT(North_American_Industry_Classification_System_Code2__SingleValue_Invalid),COUNT(North_American_Industry_Classification_System_Code3__SingleValue_Invalid),COUNT(North_American_Industry_Classification_System_Code4__SingleValue_Invalid),COUNT(North_American_Industry_Classification_System_Code5__SingleValue_Invalid),COUNT(Company_Ticker__SingleValue_Invalid),COUNT(Company_Ticker_Exchange__SingleValue_Invalid),COUNT(Company_Foreign_Domestic__SingleValue_Invalid),COUNT(Company_U_R_L__SingleValue_Invalid),COUNT(State_Incorporated__SingleValue_Invalid),COUNT(Charter_Number__SingleValue_Invalid),COUNT(Company_Filing_Date__SingleValue_Invalid),COUNT(Company_Status_Date__SingleValue_Invalid),COUNT(Company_Foreign_Date__SingleValue_Invalid),COUNT(Event_Filing_Date__SingleValue_Invalid),COUNT(Company_Status__SingleValue_Invalid)}],{KEL.typ.int Family__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid,KEL.typ.int Family__SingleValue_Invalid,KEL.typ.int Sele_Gold__SingleValue_Invalid,KEL.typ.int Is_Sele_Level__SingleValue_Invalid,KEL.typ.int Is_Org_Level__SingleValue_Invalid,KEL.typ.int Is_Ult_Level__SingleValue_Invalid,KEL.typ.int Sele_Segment__SingleValue_Invalid,KEL.typ.int Is_Corporation__SingleValue_Invalid,KEL.typ.int Corporation_Number__SingleValue_Invalid,KEL.typ.int Business_Type__SingleValue_Invalid,KEL.typ.int Low_Value_Works__SingleValue_Invalid,KEL.typ.int Active_Enterprise_Number__SingleValue_Invalid,KEL.typ.int Hist_Enterprise_Number__SingleValue_Invalid,KEL.typ.int Ebr_File_Number__SingleValue_Invalid,KEL.typ.int Active_Domestic_Corporation_Key__SingleValue_Invalid,KEL.typ.int Hist_Domestic_Corporation_Key__SingleValue_Invalid,KEL.typ.int Foreign_Corporation_Key__SingleValue_Invalid,KEL.typ.int Unknown_Corporation_Key__SingleValue_Invalid,KEL.typ.int Company_Organization_Structure__SingleValue_Invalid,KEL.typ.int Company_Incorporation_Date__SingleValue_Invalid,KEL.typ.int Standard_Industrial_Classification_Code1__SingleValue_Invalid,KEL.typ.int Standard_Industrial_Classification_Code2__SingleValue_Invalid,KEL.typ.int Standard_Industrial_Classification_Code3__SingleValue_Invalid,KEL.typ.int Standard_Industrial_Classification_Code4__SingleValue_Invalid,KEL.typ.int Standard_Industrial_Classification_Code5__SingleValue_Invalid,KEL.typ.int North_American_Industry_Classification_System_Code1__SingleValue_Invalid,KEL.typ.int North_American_Industry_Classification_System_Code2__SingleValue_Invalid,KEL.typ.int North_American_Industry_Classification_System_Code3__SingleValue_Invalid,KEL.typ.int North_American_Industry_Classification_System_Code4__SingleValue_Invalid,KEL.typ.int North_American_Industry_Classification_System_Code5__SingleValue_Invalid,KEL.typ.int Company_Ticker__SingleValue_Invalid,KEL.typ.int Company_Ticker_Exchange__SingleValue_Invalid,KEL.typ.int Company_Foreign_Domestic__SingleValue_Invalid,KEL.typ.int Company_U_R_L__SingleValue_Invalid,KEL.typ.int State_Incorporated__SingleValue_Invalid,KEL.typ.int Charter_Number__SingleValue_Invalid,KEL.typ.int Company_Filing_Date__SingleValue_Invalid,KEL.typ.int Company_Status_Date__SingleValue_Invalid,KEL.typ.int Company_Foreign_Date__SingleValue_Invalid,KEL.typ.int Event_Filing_Date__SingleValue_Invalid,KEL.typ.int Company_Status__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(__d0)},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Family',COUNT(__d0(__NL(Family_))),COUNT(__d0(__NN(Family_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sele_gold',COUNT(__d0(__NL(Sele_Gold_))),COUNT(__d0(__NN(Sele_Gold_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_sele_level',COUNT(__d0(__NL(Is_Sele_Level_))),COUNT(__d0(__NN(Is_Sele_Level_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_org_level',COUNT(__d0(__NL(Is_Org_Level_))),COUNT(__d0(__NN(Is_Org_Level_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_ult_level',COUNT(__d0(__NL(Is_Ult_Level_))),COUNT(__d0(__NN(Is_Ult_Level_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sele_seg',COUNT(__d0(__NL(Sele_Segment_))),COUNT(__d0(__NN(Sele_Segment_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iscorp',COUNT(__d0(__NL(Is_Corporation_))),COUNT(__d0(__NN(Is_Corporation_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_name',COUNT(__d0(__NL(Company_Name_))),COUNT(__d0(__NN(Company_Name_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_name_type_derived',COUNT(__d0(__NL(Company_Name_Type_))),COUNT(__d0(__NN(Company_Name_Type_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cnp_number',COUNT(__d0(__NL(Corporation_Number_))),COUNT(__d0(__NN(Corporation_Number_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cnp_btype',COUNT(__d0(__NL(Business_Type_))),COUNT(__d0(__NN(Business_Type_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cnp_lowv',COUNT(__d0(__NL(Low_Value_Works_))),COUNT(__d0(__NN(Low_Value_Works_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_legal_name',COUNT(__d0(__NL(Corporation_Legal_Name_))),COUNT(__d0(__NN(Corporation_Legal_Name_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dba_name',COUNT(__d0(__NL(Doing_Business_As_))),COUNT(__d0(__NN(Doing_Business_As_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','active_enterprise_number',COUNT(__d0(__NL(Active_Enterprise_Number_))),COUNT(__d0(__NN(Active_Enterprise_Number_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hist_enterprise_number',COUNT(__d0(__NL(Hist_Enterprise_Number_))),COUNT(__d0(__NN(Hist_Enterprise_Number_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ebr_file_number',COUNT(__d0(__NL(Ebr_File_Number_))),COUNT(__d0(__NN(Ebr_File_Number_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','active_domestic_corp_key',COUNT(__d0(__NL(Active_Domestic_Corporation_Key_))),COUNT(__d0(__NN(Active_Domestic_Corporation_Key_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hist_domestic_corp_key',COUNT(__d0(__NL(Hist_Domestic_Corporation_Key_))),COUNT(__d0(__NN(Hist_Domestic_Corporation_Key_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','foreign_corp_key',COUNT(__d0(__NL(Foreign_Corporation_Key_))),COUNT(__d0(__NN(Foreign_Corporation_Key_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unk_corp_key',COUNT(__d0(__NL(Unknown_Corporation_Key_))),COUNT(__d0(__NN(Unknown_Corporation_Key_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_org_structure_raw',COUNT(__d0(__NL(Company_Organization_Structure_))),COUNT(__d0(__NN(Company_Organization_Structure_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_incorporation_date',COUNT(__d0(__NL(Company_Incorporation_Date_))),COUNT(__d0(__NN(Company_Incorporation_Date_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code1',COUNT(__d0(__NL(Standard_Industrial_Classification_Code1_))),COUNT(__d0(__NN(Standard_Industrial_Classification_Code1_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code2',COUNT(__d0(__NL(Standard_Industrial_Classification_Code2_))),COUNT(__d0(__NN(Standard_Industrial_Classification_Code2_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code3',COUNT(__d0(__NL(Standard_Industrial_Classification_Code3_))),COUNT(__d0(__NN(Standard_Industrial_Classification_Code3_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code4',COUNT(__d0(__NL(Standard_Industrial_Classification_Code4_))),COUNT(__d0(__NN(Standard_Industrial_Classification_Code4_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code5',COUNT(__d0(__NL(Standard_Industrial_Classification_Code5_))),COUNT(__d0(__NN(Standard_Industrial_Classification_Code5_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code1',COUNT(__d0(__NL(North_American_Industry_Classification_System_Code1_))),COUNT(__d0(__NN(North_American_Industry_Classification_System_Code1_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code2',COUNT(__d0(__NL(North_American_Industry_Classification_System_Code2_))),COUNT(__d0(__NN(North_American_Industry_Classification_System_Code2_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code3',COUNT(__d0(__NL(North_American_Industry_Classification_System_Code3_))),COUNT(__d0(__NN(North_American_Industry_Classification_System_Code3_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code4',COUNT(__d0(__NL(North_American_Industry_Classification_System_Code4_))),COUNT(__d0(__NN(North_American_Industry_Classification_System_Code4_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code5',COUNT(__d0(__NL(North_American_Industry_Classification_System_Code5_))),COUNT(__d0(__NN(North_American_Industry_Classification_System_Code5_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_ticker',COUNT(__d0(__NL(Company_Ticker_))),COUNT(__d0(__NN(Company_Ticker_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_ticker_exchange',COUNT(__d0(__NL(Company_Ticker_Exchange_))),COUNT(__d0(__NN(Company_Ticker_Exchange_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_foreign_domestic',COUNT(__d0(__NL(Company_Foreign_Domestic_))),COUNT(__d0(__NN(Company_Foreign_Domestic_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_url',COUNT(__d0(__NL(Company_U_R_L_))),COUNT(__d0(__NN(Company_U_R_L_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_inc_state',COUNT(__d0(__NL(State_Incorporated_))),COUNT(__d0(__NN(State_Incorporated_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_charter_number',COUNT(__d0(__NL(Charter_Number_))),COUNT(__d0(__NN(Charter_Number_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_filing_date',COUNT(__d0(__NL(Company_Filing_Date_))),COUNT(__d0(__NN(Company_Filing_Date_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_status_date',COUNT(__d0(__NL(Company_Status_Date_))),COUNT(__d0(__NN(Company_Status_Date_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_foreign_date',COUNT(__d0(__NL(Company_Foreign_Date_))),COUNT(__d0(__NN(Company_Foreign_Date_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','event_filing_date',COUNT(__d0(__NL(Event_Filing_Date_))),COUNT(__d0(__NN(Event_Filing_Date_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_name_status_raw',COUNT(__d0(__NL(Company_Name_Status_))),COUNT(__d0(__NN(Company_Name_Status_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_status_raw',COUNT(__d0(__NL(Company_Status_))),COUNT(__d0(__NN(Company_Status_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_name',COUNT(__d0(__NL(Date_First_Seen_Company_Name_))),COUNT(__d0(__NN(Date_First_Seen_Company_Name_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_name',COUNT(__d0(__NL(Date_Last_Seen_Company_Name_))),COUNT(__d0(__NN(Date_Last_Seen_Company_Name_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current',COUNT(__d0(__NL(Current_Indicator_))),COUNT(__d0(__NN(Current_Indicator_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BusinessSele','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
