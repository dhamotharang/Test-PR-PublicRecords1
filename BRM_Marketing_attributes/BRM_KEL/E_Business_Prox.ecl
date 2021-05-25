//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT E_Business_Prox(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
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
    KEL.typ.nstr Deleted_Key_;
    KEL.typ.nstr D_U_N_S_Number_;
    KEL.typ.nstr Name_;
    KEL.typ.nstr O_S_H_A_Previous_Activity_Type_;
    KEL.typ.nstr O_S_H_A_Previous_Activity_Type_Description_;
    KEL.typ.nbool O_S_H_A_Advance_Notice_Flag_;
    KEL.typ.nkdate O_S_H_A_Inspection_Opening_Date_;
    KEL.typ.nkdate O_S_H_A_Inspection_Close_Date_;
    KEL.typ.nstr O_S_H_A_Safety_Health_Flag_;
    KEL.typ.nstr O_S_H_A_Inspection_Type_;
    KEL.typ.nstr O_S_H_A_Inspection_Scope_;
    KEL.typ.nbool O_S_H_A_Walk_Around_Flag_;
    KEL.typ.nbool O_S_H_A_Employees_Interviewed_Flag_;
    KEL.typ.nbool O_S_H_A_Union_Flag_;
    KEL.typ.nbool O_S_H_A_Case_Closed_Flag_;
    KEL.typ.nstr O_S_H_A_No_Inspection_Code_;
    KEL.typ.nint O_S_H_A_Inspection_Type_Code_;
    KEL.typ.nint O_S_H_A_Total_Violations_;
    KEL.typ.nint O_S_H_A_Total_Serious_Violations_;
    KEL.typ.nint O_S_H_A_Number_Of_Violations_;
    KEL.typ.nint O_S_H_A_Number_Of_Events_;
    KEL.typ.nint O_S_H_A_Number_Of_Hazardous_Substance_;
    KEL.typ.nint O_S_H_A_Number_Of_Accidents_;
    KEL.typ.nstr O_S_H_A_Owner_Type_;
    KEL.typ.nstr O_S_H_A_Owner_Type_Description_;
    KEL.typ.nint O_S_H_A_Employee_Count12_Months_;
    KEL.typ.nstr Best_Company_Name_;
    KEL.typ.nint Best_Company_Name_Rank_;
    KEL.typ.nint Best_S_I_C_Code_;
    KEL.typ.nint Best_S_I_C_Code_Rank_;
    KEL.typ.nint Best_N_A_I_C_S_Code_;
    KEL.typ.nint Best_N_A_I_C_S_Code_Rank_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Corporation_Code_;
    KEL.typ.nstr Contact_First_Name_;
    KEL.typ.nstr Contact_Middle_Name_;
    KEL.typ.nstr Contact_Last_Name_;
    KEL.typ.nstr Contact_Name_Suffix_;
    KEL.typ.nstr Contact_Primary_Range_;
    KEL.typ.nstr Contact_Predirectional_;
    KEL.typ.nstr Contact_Primary_Name_;
    KEL.typ.nstr Contact_Suffix_;
    KEL.typ.nstr Contact_Postdirectional_;
    KEL.typ.nstr Contact_Secondary_Range_;
    KEL.typ.nstr Contact_State_;
    KEL.typ.nint Contact_Z_I_P5_;
    KEL.typ.nint Contact_S_S_N_;
    KEL.typ.nint Contact_Phone_Number_;
    KEL.typ.nint Contact_Score_;
    KEL.typ.nstr Contact_Type_;
    KEL.typ.nstr Contact_Email_;
    KEL.typ.nstr Contact_Email_Username_;
    KEL.typ.nstr Contact_Email_Domain_;
    KEL.typ.nint Cortera_Ultimate_Link_I_D_;
    KEL.typ.nint Cortera_Link_I_D_;
    KEL.typ.nstr Contact_Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nstr Location_Corp_Hierarchy_;
    KEL.typ.nstr Company_Status_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.nbool Contact_Is_Executive_;
    KEL.typ.nbool Is_Contact_;
    KEL.typ.nint Contact_Executive_Order_;
    KEL.typ.nstr Record_Status_;
    KEL.typ.nint Equifax_I_D_;
    KEL.typ.nbool Is_Small_Business_Home_Office_;
    KEL.typ.nstr U_R_L_;
    KEL.typ.nint Employee_Count_;
    KEL.typ.nstr Employee_Count_Code_;
    KEL.typ.nint Financial_Amount_Figure_;
    KEL.typ.nstr Financial_Amount_Code_;
    KEL.typ.nstr Financial_Amount_Type_;
    KEL.typ.nstr Financial_Amount_Precision_;
    KEL.typ.nbool Is_Dead_;
    KEL.typ.nkdate Date_Dead_;
    KEL.typ.nbool Associated_Addr_Commercial_;
    KEL.typ.nbool Associated_Addr_Residential_;
    KEL.typ.nint General_Marketability_Score_;
    KEL.typ.nstr General_Marketability_Indicator_;
    KEL.typ.nbool Is_Vacant_;
    KEL.typ.nbool Is_Seasonal_;
    KEL.typ.nbool Is_Minority_Owned_;
    KEL.typ.nbool Is_Woman_Owned_;
    KEL.typ.nbool Is_Minority_Woman_Owned_;
    KEL.typ.nbool Is_S_B_A_Disadvantaged_Owned_;
    KEL.typ.nbool Is_S_B_A_H_U_B_Zone_;
    KEL.typ.nbool Is_Disadvantage_Owned_;
    KEL.typ.nbool Is_Veteran_Owned_;
    KEL.typ.nbool Is_Disabled_Vet_Owned_;
    KEL.typ.nbool Is_S_B_A8_A_Owned_;
    KEL.typ.nkdate S_B_A8_A_Owned_Date_;
    KEL.typ.nbool Is_Disabled_Owned_;
    KEL.typ.nbool Is_Hist_Black_College_;
    KEL.typ.nbool Is_Gay_Lesbian_Owned_;
    KEL.typ.nbool Is_Woman_Owned_S_B_E_;
    KEL.typ.nbool Is_Veteran_Owned_S_B_E_;
    KEL.typ.nbool Is_Disabled_Vet_Owned_S_B_E_;
    KEL.typ.nbool Is_S_B_E_;
    KEL.typ.nbool Is_Not_S_B_E_;
    KEL.typ.nbool Is_Goverment_;
    KEL.typ.nbool Is_Federal_Goverment_;
    KEL.typ.nstr Merchant_Type_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nint Year_Established_;
    KEL.typ.nstr Public_Private_Indicator_;
    KEL.typ.nstr Business_Size_;
    KEL.typ.nstr Goverment_Type_;
    KEL.typ.nbool Is_Non_Profit_;
    KEL.typ.nstr Minority_Woman_Status_;
    KEL.typ.nbool Is_N_M_S_D_C_Certified_;
    KEL.typ.nbool Is_W_B_E_N_C_Certified_;
    KEL.typ.nbool Is_California_P_U_C_Certified_;
    KEL.typ.nbool Is_Texas_H_U_B_Certified_;
    KEL.typ.nbool Is_California_Caltrans_Certified_;
    KEL.typ.nbool Is_Educational_Institution_;
    KEL.typ.nbool Is_Minority_Institue_;
    KEL.typ.nbool Is_Alaska_Native_Corporation_;
    KEL.typ.nkdate Date_Last_Seen_Location_;
    KEL.typ.nkdate Date_Regustered_Agent_Resigned_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),proxid(DEFAULT:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_BIPV2__Key_BH_Linking_kfetch2((UNSIGNED)proxid<>0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d1_KELfiltered := __in.Dataset_Corp2__Kfetch_LinkIDs_Corp((UNSIGNED)proxid<>0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d2_KELfiltered := __in.Dataset_BusReg__kfetch_busreg_company_linkids((UNSIGNED)proxid<>0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d3_KELfiltered := __in.Dataset_Cortera__kfetch_LinkID((UNSIGNED)proxid<>0);
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d4_KELfiltered := __in.Dataset_EBR_kfetch_5600_Demographic_Data_linkids((UNSIGNED)proxid<>0);
  SHARED __d4_Trim := PROJECT(__d4_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d5_KELfiltered := __in.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds((UNSIGNED)proxid<>0);
  SHARED __d5_Trim := PROJECT(__d5_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d6_KELfiltered := __in.Dataset_Equifax_Business__Data_kfetch_LinkIDs((UNSIGNED)proxid<>0);
  SHARED __d6_Trim := PROJECT(__d6_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d7_KELfiltered := __in.Dataset_BIPV2_Build__kfetch_contact_linkids((UNSIGNED)contact_did = 0 AND (UNSIGNED)proxid<>0);
  SHARED __d7_Trim := PROJECT(__d7_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d8_KELfiltered := __in.Dataset_BIPV2_Build__kfetch_contact_linkids((UNSIGNED)proxid<>0);
  SHARED __d8_Trim := PROJECT(__d8_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d9_KELfiltered := __in.Dataset_BIPV2_Build__kfetch_contact_linkids_slim((UNSIGNED)proxid<>0);
  SHARED __d9_Trim := PROJECT(__d9_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d10_KELfiltered := __in.Dataset_BIPV2_Best__Key_LinkIds(proxid != 0 AND seleid != 0 AND company_name != '');
  SHARED __d10_Trim := PROJECT(__d10_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d11_KELfiltered := __in.Dataset_BIPV2_Best__Key_LinkIds(proxid != 0 AND seleid != 0 AND company_sic_code1 <> '');
  SHARED __d11_Trim := PROJECT(__d11_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d12_KELfiltered := __in.Dataset_BIPV2_Best__Key_LinkIds(proxid != 0 AND seleid != 0 AND company_naics_code1 <> '');
  SHARED __d12_Trim := PROJECT(__d12_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  SHARED __d13_KELfiltered := __in.Dataset_Gong__Key_History_LinkIds((UNSIGNED)proxid<>0);
  SHARED __d13_Trim := PROJECT(__d13_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim + __d6_Trim + __d7_Trim + __d8_Trim + __d9_Trim + __d10_Trim + __d11_Trim + __d12_Trim + __d13_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parent_proxid(OVERRIDE:Parent_Prox_I_D_:0),sele_proxid(OVERRIDE:Sele_Prox_I_D_:0),org_proxid(OVERRIDE:Org_Prox_I_D_:0),ultimate_proxid(OVERRIDE:Ult_Prox_I_D_:0),levels_from_top(OVERRIDE:Levels_From_Top_:0),nodes_below(OVERRIDE:Nodes_Below_:0),prox_seg(OVERRIDE:Prox_Segment_:\'\'),cnp_store_number(OVERRIDE:Store_Number_:\'\'),active_duns_number(OVERRIDE:Active_Duns_Number_:\'\'),hist_duns_number(OVERRIDE:Hist_Duns_Number_:\'\'),deleted_key(OVERRIDE:Deleted_Key_:\'\'),duns_number(OVERRIDE:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2__Key_BH_Linking_kfetch2);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d0_Prox_Sele__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d0_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d0_Prox_Sele__Mapped := IF(__d0_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d0_UID_Mapped,TRANSFORM(__d0_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_UID_Mapped,__d0_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid := __d0_Prox_Sele__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Prox_Sele__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),corp_ra_fname1(OVERRIDE:Contact_First_Name_:\'\'),corp_ra_mname1(OVERRIDE:Contact_Middle_Name_:\'\'),corp_ra_lname1(OVERRIDE:Contact_Last_Name_:\'\'),corp_ra_name_suffix1(OVERRIDE:Contact_Name_Suffix_:\'\'),corp_ra_prim_range(OVERRIDE:Contact_Primary_Range_:\'\'),corp_ra_predir(OVERRIDE:Contact_Predirectional_:\'\'),corp_ra_prim_name(OVERRIDE:Contact_Primary_Name_:\'\'),corp_ra_addr_suffix(OVERRIDE:Contact_Suffix_:\'\'),corp_ra_postdir(OVERRIDE:Contact_Postdirectional_:\'\'),corp_ra_sec_range(OVERRIDE:Contact_Secondary_Range_:\'\'),corp_ra_state(OVERRIDE:Contact_State_:\'\'),corp_ra_zip5(OVERRIDE:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),corp_ra_phone10(OVERRIDE:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),corp_ra_title_desc(OVERRIDE:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),corp_ra_resign_date(OVERRIDE:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),corp_ra_dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),corp_ra_dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Corp2__Kfetch_LinkIDs_Corp);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d1_Prox_Sele__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d1_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d1_Prox_Sele__Mapped := IF(__d1_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d1_UID_Mapped,TRANSFORM(__d1_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_UID_Mapped,__d1_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d1_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_Invalid := __d1_Prox_Sele__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_Prox_Sele__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),rawfields.corpcode(OVERRIDE:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),rawfields.emp_size(OVERRIDE:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_BusReg__kfetch_busreg_company_linkids,TRANSFORM(RECORDOF(__in.Dataset_BusReg__kfetch_busreg_company_linkids),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BusReg__kfetch_busreg_company_linkids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d2_Prox_Sele__Layout := RECORD
    RECORDOF(__d2_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d2_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d2_Prox_Sele__Mapped := IF(__d2_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d2_UID_Mapped,TRANSFORM(__d2_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_UID_Mapped,__d2_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d2_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BusReg__kfetch_busreg_company_linkids_Invalid := __d2_Prox_Sele__Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_Prox_Sele__Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),ultimate_linkid(OVERRIDE:Cortera_Ultimate_Link_I_D_:0),link_id(OVERRIDE:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),position_type(OVERRIDE:Location_Corp_Hierarchy_:\'\'),status(OVERRIDE:Company_Status_:\'\'),is_closed(OVERRIDE:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),loc_date_last_seen(OVERRIDE:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),closed_date(OVERRIDE:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Cortera__kfetch_LinkID,TRANSFORM(RECORDOF(__in.Dataset_Cortera__kfetch_LinkID),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Cortera__kfetch_LinkID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d3_Prox_Sele__Layout := RECORD
    RECORDOF(__d3_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d3_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d3_Prox_Sele__Mapped := IF(__d3_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d3_UID_Mapped,TRANSFORM(__d3_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_UID_Mapped,__d3_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d3_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera__kfetch_LinkID_Invalid := __d3_Prox_Sele__Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_Prox_Sele__Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),location_code(OVERRIDE:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_EBR_kfetch_5600_Demographic_Data_linkids,TRANSFORM(RECORDOF(__in.Dataset_EBR_kfetch_5600_Demographic_Data_linkids),SELF:=RIGHT));
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_EBR_kfetch_5600_Demographic_Data_linkids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(__d4_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d4_Prox_Sele__Layout := RECORD
    RECORDOF(__d4_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d4_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d4_Prox_Sele__Mapped := IF(__d4_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d4_UID_Mapped,TRANSFORM(__d4_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_UID_Mapped,__d4_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d4_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_EBR_kfetch_5600_Demographic_Data_linkids_Invalid := __d4_Prox_Sele__Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_Prox_Sele__Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),duns_number(OVERRIDE:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),previous_activity_type(OVERRIDE:O_S_H_A_Previous_Activity_Type_:\'\'),prev_activity_type_desc(OVERRIDE:O_S_H_A_Previous_Activity_Type_Description_:\'\'),advance_notice_flag(OVERRIDE:O_S_H_A_Advance_Notice_Flag_),inspection_opening_date(OVERRIDE:O_S_H_A_Inspection_Opening_Date_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),inspection_close_date(OVERRIDE:O_S_H_A_Inspection_Close_Date_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH),safety_health_flag(OVERRIDE:O_S_H_A_Safety_Health_Flag_:\'\'),inspection_type(OVERRIDE:O_S_H_A_Inspection_Type_:\'\'),inspection_scope(OVERRIDE:O_S_H_A_Inspection_Scope_:\'\'),walk_around_flag(OVERRIDE:O_S_H_A_Walk_Around_Flag_),employees_interviewed_flag(OVERRIDE:O_S_H_A_Employees_Interviewed_Flag_),union_flag(OVERRIDE:O_S_H_A_Union_Flag_),closed_case_flag(OVERRIDE:O_S_H_A_Case_Closed_Flag_),why_no_inspection_code(OVERRIDE:O_S_H_A_No_Inspection_Code_:\'\'),inspection_type_code(OVERRIDE:O_S_H_A_Inspection_Type_Code_:\'\'),total_violations(OVERRIDE:O_S_H_A_Total_Violations_:0),total_serious_violations(OVERRIDE:O_S_H_A_Total_Serious_Violations_:0),number_violations(OVERRIDE:O_S_H_A_Number_Of_Violations_:0),number_event(OVERRIDE:O_S_H_A_Number_Of_Events_:0),number_hazardous_substance(OVERRIDE:O_S_H_A_Number_Of_Hazardous_Substance_:0),number_accident(OVERRIDE:O_S_H_A_Number_Of_Accidents_:0),owner_type(OVERRIDE:O_S_H_A_Owner_Type_:\'\'),own_type_desc(OVERRIDE:O_S_H_A_Owner_Type_Description_:\'\'),number_in_establishment(OVERRIDE:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds),SELF:=RIGHT));
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_OSHAIR__kfetch_OSHAIR_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(__d5_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d5_Prox_Sele__Layout := RECORD
    RECORDOF(__d5_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d5_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d5_Prox_Sele__Mapped := IF(__d5_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d5_UID_Mapped,TRANSFORM(__d5_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_UID_Mapped,__d5_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d5_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_OSHAIR__kfetch_OSHAIR_LinkIds_Invalid := __d5_Prox_Sele__Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_Prox_Sele__Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),record_type(OVERRIDE:Record_Status_:\'\'),efx_id(OVERRIDE:Equifax_I_D_:0),efx_soho(OVERRIDE:Is_Small_Business_Home_Office_),efx_web(OVERRIDE:U_R_L_:\'\'),efx_locempcnt(OVERRIDE:Employee_Count_:\'\'),efx_locempcd(OVERRIDE:Employee_Count_Code_:\'\'),efx_locamount(OVERRIDE:Financial_Amount_Figure_:\'\'),efx_locamountcd(OVERRIDE:Financial_Amount_Code_:\'\'),efx_locamounttp(OVERRIDE:Financial_Amount_Type_:\'\'),efx_locamountprec(OVERRIDE:Financial_Amount_Precision_:\'\'),efx_dead(OVERRIDE:Is_Dead_),efx_deaddt(OVERRIDE:Date_Dead_:DATE),efx_biz(OVERRIDE:Associated_Addr_Commercial_),efx_res(OVERRIDE:Associated_Addr_Residential_),efx_mrkt_totalscore(OVERRIDE:General_Marketability_Score_:0),efx_mrkt_totalind(OVERRIDE:General_Marketability_Indicator_:\'\'),efx_mrkt_vacant(OVERRIDE:Is_Vacant_),efx_mrkt_seasonal(OVERRIDE:Is_Seasonal_),efx_mbe(OVERRIDE:Is_Minority_Owned_),efx_wbe(OVERRIDE:Is_Woman_Owned_),efx_mwbe(OVERRIDE:Is_Minority_Woman_Owned_),efx_sdb(OVERRIDE:Is_S_B_A_Disadvantaged_Owned_),efx_hubzone(OVERRIDE:Is_S_B_A_H_U_B_Zone_),efx_dbe(OVERRIDE:Is_Disadvantage_Owned_),efx_vet(OVERRIDE:Is_Veteran_Owned_),efx_dvet(OVERRIDE:Is_Disabled_Vet_Owned_),efx_8a(OVERRIDE:Is_S_B_A8_A_Owned_),efx_8aexpdt(OVERRIDE:S_B_A8_A_Owned_Date_:DATE),efx_dis(OVERRIDE:Is_Disabled_Owned_),efx_hbcu(OVERRIDE:Is_Hist_Black_College_),efx_gaylesbian(OVERRIDE:Is_Gay_Lesbian_Owned_),efx_wsbe(OVERRIDE:Is_Woman_Owned_S_B_E_),efx_vsbe(OVERRIDE:Is_Veteran_Owned_S_B_E_),efx_dvsbe(OVERRIDE:Is_Disabled_Vet_Owned_S_B_E_),efx_sbe(OVERRIDE:Is_S_B_E_),efx_lbe(OVERRIDE:Is_Not_S_B_E_),efx_gov(OVERRIDE:Is_Goverment_),efx_fgov(OVERRIDE:Is_Federal_Goverment_),efx_merctype(OVERRIDE:Merchant_Type_:\'\'),process_date(OVERRIDE:Process_Date_:DATE),efx_yrest(OVERRIDE:Year_Established_:\'\'),efx_public(OVERRIDE:Public_Private_Indicator_:\'\'),efx_bussize(OVERRIDE:Business_Size_:\'\'),efx_gov1057(OVERRIDE:Goverment_Type_:\'\'),efx_nonprofit(OVERRIDE:Is_Non_Profit_),efx_mwbestatus(OVERRIDE:Minority_Woman_Status_:\'\'),efx_nmsdc(OVERRIDE:Is_N_M_S_D_C_Certified_),efx_wbenc(OVERRIDE:Is_W_B_E_N_C_Certified_),efx_ca_puc(OVERRIDE:Is_California_P_U_C_Certified_),efx_tx_hub(OVERRIDE:Is_Texas_H_U_B_Certified_),efx_caltrans(OVERRIDE:Is_California_Caltrans_Certified_),efx_edu(OVERRIDE:Is_Educational_Institution_),efx_mi(OVERRIDE:Is_Minority_Institue_),efx_anc(OVERRIDE:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  SHARED __d6_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Equifax_Business__Data_kfetch_LinkIDs);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d6_UID_Mapped := JOIN(__d6_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d6_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d6_Prox_Sele__Layout := RECORD
    RECORDOF(__d6_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d6_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d6_Prox_Sele__Mapped := IF(__d6_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d6_UID_Mapped,TRANSFORM(__d6_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_UID_Mapped,__d6_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d6_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid := __d6_Prox_Sele__Mapped(UID = 0);
  SHARED __d6_Prefiltered := __d6_Prox_Sele__Mapped(UID <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),corporationcode(DEFAULT:Corporation_Code_:\'\'),contact_name.fname(OVERRIDE:Contact_First_Name_:\'\'),contact_name.mname(OVERRIDE:Contact_Middle_Name_:\'\'),contact_name.lname(OVERRIDE:Contact_Last_Name_:\'\'),contact_name.name_suffix(OVERRIDE:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contact_ssn(OVERRIDE:Contact_S_S_N_:0),contact_phone(OVERRIDE:Contact_Phone_Number_:0),contact_score(OVERRIDE:Contact_Score_:0),contact_type_derived(OVERRIDE:Contact_Type_:\'\'),contact_email(OVERRIDE:Contact_Email_:\'\'),contact_email_username(OVERRIDE:Contact_Email_Username_:\'\'),contact_email_domain(OVERRIDE:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),jobtitle(OVERRIDE:Contact_Job_Title_:\'\'),status(OVERRIDE:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),executive_ind(OVERRIDE:Contact_Is_Executive_),executive_ind_order(OVERRIDE:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_7Rule),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_7Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF.Is_Contact_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids),SELF:=RIGHT));
  SHARED __d7_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2_Build__kfetch_contact_linkids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d7_UID_Mapped := JOIN(__d7_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d7_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d7_Prox_Sele__Layout := RECORD
    RECORDOF(__d7_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d7_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d7_Prox_Sele__Mapped := IF(__d7_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d7_UID_Mapped,TRANSFORM(__d7_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_UID_Mapped,__d7_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d7_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_1_Invalid := __d7_Prox_Sele__Mapped(UID = 0);
  SHARED __d7_Prefiltered := __d7_Prox_Sele__Mapped(UID <> 0);
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping7_Transform(LEFT)));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids),SELF:=RIGHT));
  SHARED __d8_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2_Build__kfetch_contact_linkids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d8_UID_Mapped := JOIN(__d8_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d8_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d8_Prox_Sele__Layout := RECORD
    RECORDOF(__d8_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d8_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d8_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d8_Prox_Sele__Mapped := IF(__d8_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d8_UID_Mapped,TRANSFORM(__d8_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d8_UID_Mapped,__d8_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d8_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_2_Invalid := __d8_Prox_Sele__Mapped(UID = 0);
  SHARED __d8_Prefiltered := __d8_Prox_Sele__Mapped(UID <> 0);
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping8_Transform(LEFT)));
  SHARED Date_First_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_9Rule),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping9_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids_slim,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids_slim),SELF:=RIGHT));
  SHARED __d9_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2_Build__kfetch_contact_linkids_slim);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d9_UID_Mapped := JOIN(__d9_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d9_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d9_Prox_Sele__Layout := RECORD
    RECORDOF(__d9_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d9_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d9_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d9_Prox_Sele__Mapped := IF(__d9_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d9_UID_Mapped,TRANSFORM(__d9_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d9_UID_Mapped,__d9_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d9_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_slim_Invalid := __d9_Prox_Sele__Mapped(UID = 0);
  SHARED __d9_Prefiltered := __d9_Prox_Sele__Mapped(UID <> 0);
  SHARED __d9 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping9_Transform(LEFT)));
  SHARED __Mapping10 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),company_name(OVERRIDE:Best_Company_Name_:\'\'),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping10_Transform(InLayout __r) := TRANSFORM
    SELF.Best_Company_Name_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  SHARED __d10_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2_Best__Key_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d10_UID_Mapped := JOIN(__d10_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d10_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d10_Prox_Sele__Layout := RECORD
    RECORDOF(__d10_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d10_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d10_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d10_Prox_Sele__Mapped := IF(__d10_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d10_UID_Mapped,TRANSFORM(__d10_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d10_UID_Mapped,__d10_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d10_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_1_Invalid := __d10_Prox_Sele__Mapped(UID = 0);
  SHARED __d10_Prefiltered := __d10_Prox_Sele__Mapped(UID <> 0);
  SHARED __d10 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping10_Transform(LEFT)));
  SHARED __Mapping11 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),company_sic_code1(OVERRIDE:Best_S_I_C_Code_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping11_Transform(InLayout __r) := TRANSFORM
    SELF.Best_S_I_C_Code_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  SHARED __d11_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2_Best__Key_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d11_UID_Mapped := JOIN(__d11_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d11_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d11_Prox_Sele__Layout := RECORD
    RECORDOF(__d11_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d11_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d11_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d11_Prox_Sele__Mapped := IF(__d11_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d11_UID_Mapped,TRANSFORM(__d11_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d11_UID_Mapped,__d11_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d11_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_2_Invalid := __d11_Prox_Sele__Mapped(UID = 0);
  SHARED __d11_Prefiltered := __d11_Prox_Sele__Mapped(UID <> 0);
  SHARED __d11 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping11_Transform(LEFT)));
  SHARED __Mapping12 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),name(DEFAULT:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),company_naics_code1(OVERRIDE:Best_N_A_I_C_S_Code_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping12_Transform(InLayout __r) := TRANSFORM
    SELF.Best_N_A_I_C_S_Code_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  SHARED __d12_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2_Best__Key_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d12_UID_Mapped := JOIN(__d12_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d12_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d12_Prox_Sele__Layout := RECORD
    RECORDOF(__d12_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d12_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d12_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d12_Prox_Sele__Mapped := IF(__d12_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d12_UID_Mapped,TRANSFORM(__d12_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d12_UID_Mapped,__d12_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d12_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_3_Invalid := __d12_Prox_Sele__Mapped(UID = 0);
  SHARED __d12_Prefiltered := __d12_Prox_Sele__Mapped(UID <> 0);
  SHARED __d12 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping12_Transform(LEFT)));
  SHARED __Mapping13 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),Prox_Sele_(DEFAULT:Prox_Sele_:0),parentproxid(DEFAULT:Parent_Prox_I_D_:0),seleproxid(DEFAULT:Sele_Prox_I_D_:0),orgproxid(DEFAULT:Org_Prox_I_D_:0),ultproxid(DEFAULT:Ult_Prox_I_D_:0),levelsfromtop(DEFAULT:Levels_From_Top_:0),nodesbelow(DEFAULT:Nodes_Below_:0),proxsegment(DEFAULT:Prox_Segment_:\'\'),storenumber(DEFAULT:Store_Number_:\'\'),activedunsnumber(DEFAULT:Active_Duns_Number_:\'\'),histdunsnumber(DEFAULT:Hist_Duns_Number_:\'\'),deletedkey(DEFAULT:Deleted_Key_:\'\'),dunsnumber(DEFAULT:D_U_N_S_Number_:\'\'),listed_name(OVERRIDE:Name_:\'\'),oshapreviousactivitytype(DEFAULT:O_S_H_A_Previous_Activity_Type_:\'\'),oshapreviousactivitytypedescription(DEFAULT:O_S_H_A_Previous_Activity_Type_Description_:\'\'),oshaadvancenoticeflag(DEFAULT:O_S_H_A_Advance_Notice_Flag_),oshainspectionopeningdate(DEFAULT:O_S_H_A_Inspection_Opening_Date_:DATE),oshainspectionclosedate(DEFAULT:O_S_H_A_Inspection_Close_Date_:DATE),oshasafetyhealthflag(DEFAULT:O_S_H_A_Safety_Health_Flag_:\'\'),oshainspectiontype(DEFAULT:O_S_H_A_Inspection_Type_:\'\'),oshainspectionscope(DEFAULT:O_S_H_A_Inspection_Scope_:\'\'),oshawalkaroundflag(DEFAULT:O_S_H_A_Walk_Around_Flag_),oshaemployeesinterviewedflag(DEFAULT:O_S_H_A_Employees_Interviewed_Flag_),oshaunionflag(DEFAULT:O_S_H_A_Union_Flag_),oshacaseclosedflag(DEFAULT:O_S_H_A_Case_Closed_Flag_),oshanoinspectioncode(DEFAULT:O_S_H_A_No_Inspection_Code_:\'\'),oshainspectiontypecode(DEFAULT:O_S_H_A_Inspection_Type_Code_:\'\'),oshatotalviolations(DEFAULT:O_S_H_A_Total_Violations_:0),oshatotalseriousviolations(DEFAULT:O_S_H_A_Total_Serious_Violations_:0),oshanumberofviolations(DEFAULT:O_S_H_A_Number_Of_Violations_:0),oshanumberofevents(DEFAULT:O_S_H_A_Number_Of_Events_:0),oshanumberofhazardoussubstance(DEFAULT:O_S_H_A_Number_Of_Hazardous_Substance_:0),oshanumberofaccidents(DEFAULT:O_S_H_A_Number_Of_Accidents_:0),oshaownertype(DEFAULT:O_S_H_A_Owner_Type_:\'\'),oshaownertypedescription(DEFAULT:O_S_H_A_Owner_Type_Description_:\'\'),oshaemployeecount12months(DEFAULT:O_S_H_A_Employee_Count12_Months_:0),bestcompanyname(DEFAULT:Best_Company_Name_:\'\'),bestcompanynamerank(DEFAULT:Best_Company_Name_Rank_:0),bestsiccode(DEFAULT:Best_S_I_C_Code_:0),bestsiccoderank(DEFAULT:Best_S_I_C_Code_Rank_:0),bestnaicscode(DEFAULT:Best_N_A_I_C_S_Code_:0),bestnaicscoderank(DEFAULT:Best_N_A_I_C_S_Code_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),corporationcode(DEFAULT:Corporation_Code_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactprimaryrange(DEFAULT:Contact_Primary_Range_:\'\'),contactpredirectional(DEFAULT:Contact_Predirectional_:\'\'),contactprimaryname(DEFAULT:Contact_Primary_Name_:\'\'),contactsuffix(DEFAULT:Contact_Suffix_:\'\'),contactpostdirectional(DEFAULT:Contact_Postdirectional_:\'\'),contactsecondaryrange(DEFAULT:Contact_Secondary_Range_:\'\'),contactstate(DEFAULT:Contact_State_:\'\'),contactzip5(DEFAULT:Contact_Z_I_P5_:0),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),corteraultimatelinkid(DEFAULT:Cortera_Ultimate_Link_I_D_:0),corteralinkid(DEFAULT:Cortera_Link_I_D_:0),contactjobtitle(DEFAULT:Contact_Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),locationcorphierarchy(DEFAULT:Location_Corp_Hierarchy_:\'\'),companystatus(DEFAULT:Company_Status_:\'\'),isclosed(DEFAULT:Is_Closed_),contactisexecutive(DEFAULT:Contact_Is_Executive_),iscontact(DEFAULT:Is_Contact_),contactexecutiveorder(DEFAULT:Contact_Executive_Order_:0),recordstatus(DEFAULT:Record_Status_:\'\'),equifaxid(DEFAULT:Equifax_I_D_:0),issmallbusinesshomeoffice(DEFAULT:Is_Small_Business_Home_Office_),url(DEFAULT:U_R_L_:\'\'),employeecount(DEFAULT:Employee_Count_:\'\'),employeecountcode(DEFAULT:Employee_Count_Code_:\'\'),financialamountfigure(DEFAULT:Financial_Amount_Figure_:\'\'),financialamountcode(DEFAULT:Financial_Amount_Code_:\'\'),financialamounttype(DEFAULT:Financial_Amount_Type_:\'\'),financialamountprecision(DEFAULT:Financial_Amount_Precision_:\'\'),isdead(DEFAULT:Is_Dead_),datedead(DEFAULT:Date_Dead_:DATE),associatedaddrcommercial(DEFAULT:Associated_Addr_Commercial_),associatedaddrresidential(DEFAULT:Associated_Addr_Residential_),generalmarketabilityscore(DEFAULT:General_Marketability_Score_:0),generalmarketabilityindicator(DEFAULT:General_Marketability_Indicator_:\'\'),isvacant(DEFAULT:Is_Vacant_),isseasonal(DEFAULT:Is_Seasonal_),isminorityowned(DEFAULT:Is_Minority_Owned_),iswomanowned(DEFAULT:Is_Woman_Owned_),isminoritywomanowned(DEFAULT:Is_Minority_Woman_Owned_),issbadisadvantagedowned(DEFAULT:Is_S_B_A_Disadvantaged_Owned_),issbahubzone(DEFAULT:Is_S_B_A_H_U_B_Zone_),isdisadvantageowned(DEFAULT:Is_Disadvantage_Owned_),isveteranowned(DEFAULT:Is_Veteran_Owned_),isdisabledvetowned(DEFAULT:Is_Disabled_Vet_Owned_),issba8aowned(DEFAULT:Is_S_B_A8_A_Owned_),sba8aowneddate(DEFAULT:S_B_A8_A_Owned_Date_:DATE),isdisabledowned(DEFAULT:Is_Disabled_Owned_),ishistblackcollege(DEFAULT:Is_Hist_Black_College_),isgaylesbianowned(DEFAULT:Is_Gay_Lesbian_Owned_),iswomanownedsbe(DEFAULT:Is_Woman_Owned_S_B_E_),isveteranownedsbe(DEFAULT:Is_Veteran_Owned_S_B_E_),isdisabledvetownedsbe(DEFAULT:Is_Disabled_Vet_Owned_S_B_E_),issbe(DEFAULT:Is_S_B_E_),isnotsbe(DEFAULT:Is_Not_S_B_E_),isgoverment(DEFAULT:Is_Goverment_),isfederalgoverment(DEFAULT:Is_Federal_Goverment_),merchanttype(DEFAULT:Merchant_Type_:\'\'),processdate(DEFAULT:Process_Date_:DATE),yearestablished(DEFAULT:Year_Established_:\'\'),publicprivateindicator(DEFAULT:Public_Private_Indicator_:\'\'),businesssize(DEFAULT:Business_Size_:\'\'),govermenttype(DEFAULT:Goverment_Type_:\'\'),isnonprofit(DEFAULT:Is_Non_Profit_),minoritywomanstatus(DEFAULT:Minority_Woman_Status_:\'\'),isnmsdccertified(DEFAULT:Is_N_M_S_D_C_Certified_),iswbenccertified(DEFAULT:Is_W_B_E_N_C_Certified_),iscaliforniapuccertified(DEFAULT:Is_California_P_U_C_Certified_),istexashubcertified(DEFAULT:Is_Texas_H_U_B_Certified_),iscaliforniacaltranscertified(DEFAULT:Is_California_Caltrans_Certified_),iseducationalinstitution(DEFAULT:Is_Educational_Institution_),isminorityinstitue(DEFAULT:Is_Minority_Institue_),isalaskanativecorporation(DEFAULT:Is_Alaska_Native_Corporation_),datelastseenlocation(DEFAULT:Date_Last_Seen_Location_:DATE),dateregusteredagentresigned(DEFAULT:Date_Regustered_Agent_Resigned_:DATE),dateclosed(DEFAULT:Date_Closed_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_LinkIds),SELF:=RIGHT));
  SHARED __d13_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Gong__Key_History_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d13_UID_Mapped := JOIN(__d13_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d13_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d13_Prox_Sele__Layout := RECORD
    RECORDOF(__d13_UID_Mapped);
    KEL.typ.uid Prox_Sele_;
  END;
  SHARED __d13_Missing_Prox_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d13_UID_Mapped,'ultid,orgid,seleid','__in');
  SHARED __d13_Prox_Sele__Mapped := IF(__d13_Missing_Prox_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d13_UID_Mapped,TRANSFORM(__d13_Prox_Sele__Layout,SELF.Prox_Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d13_UID_Mapped,__d13_Missing_Prox_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d13_Prox_Sele__Layout,SELF.Prox_Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid := __d13_Prox_Sele__Mapped(UID = 0);
  SHARED __d13_Prefiltered := __d13_Prox_Sele__Mapped(UID <> 0);
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13;
  EXPORT Cortera_Layout := RECORD
    KEL.typ.nint Cortera_Ultimate_Link_I_D_;
    KEL.typ.nint Cortera_Link_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Deleted_I_D_Numbers_Layout := RECORD
    KEL.typ.nstr Deleted_Key_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Company_Names_Layout := RECORD
    KEL.typ.nstr Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Best_Company_Names_Layout := RECORD
    KEL.typ.nstr Best_Company_Name_;
    KEL.typ.nint Best_Company_Name_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Best_S_I_C_Codes_Layout := RECORD
    KEL.typ.nint Best_S_I_C_Code_;
    KEL.typ.nint Best_S_I_C_Code_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Best_N_A_I_C_S_Codes_Layout := RECORD
    KEL.typ.nint Best_N_A_I_C_S_Code_;
    KEL.typ.nint Best_N_A_I_C_S_Code_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT O_S_H_A_Inspection_Layout := RECORD
    KEL.typ.nkdate O_S_H_A_Inspection_Opening_Date_;
    KEL.typ.nkdate O_S_H_A_Inspection_Close_Date_;
    KEL.typ.nbool O_S_H_A_Advance_Notice_Flag_;
    KEL.typ.nbool O_S_H_A_Union_Flag_;
    KEL.typ.nstr O_S_H_A_Inspection_Type_;
    KEL.typ.nint O_S_H_A_Inspection_Type_Code_;
    KEL.typ.nstr O_S_H_A_Inspection_Scope_;
    KEL.typ.nbool O_S_H_A_Walk_Around_Flag_;
    KEL.typ.nbool O_S_H_A_Employees_Interviewed_Flag_;
    KEL.typ.nstr O_S_H_A_No_Inspection_Code_;
    KEL.typ.nbool O_S_H_A_Case_Closed_Flag_;
    KEL.typ.nstr O_S_H_A_Previous_Activity_Type_;
    KEL.typ.nstr O_S_H_A_Previous_Activity_Type_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT O_S_H_A_Violations_Layout := RECORD
    KEL.typ.nint O_S_H_A_Total_Violations_;
    KEL.typ.nint O_S_H_A_Total_Serious_Violations_;
    KEL.typ.nint O_S_H_A_Number_Of_Violations_;
    KEL.typ.nint O_S_H_A_Number_Of_Events_;
    KEL.typ.nint O_S_H_A_Number_Of_Hazardous_Substance_;
    KEL.typ.nint O_S_H_A_Number_Of_Accidents_;
    KEL.typ.nstr O_S_H_A_Safety_Health_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT O_S_H_A_Business_Information_Layout := RECORD
    KEL.typ.nstr O_S_H_A_Owner_Type_;
    KEL.typ.nstr O_S_H_A_Owner_Type_Description_;
    KEL.typ.nint O_S_H_A_Employee_Count12_Months_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vendor_Dates_Layout := RECORD
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Associated_Address_Type_Layout := RECORD
    KEL.typ.nbool Associated_Addr_Commercial_;
    KEL.typ.nbool Associated_Addr_Residential_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Business_Characteristics_Layout := RECORD
    KEL.typ.nint Year_Established_;
    KEL.typ.nstr Public_Private_Indicator_;
    KEL.typ.nstr Corporation_Code_;
    KEL.typ.nkdate Date_Last_Seen_Location_;
    KEL.typ.nstr Location_Corp_Hierarchy_;
    KEL.typ.nbool Is_S_B_E_;
    KEL.typ.nbool Is_Small_Business_Home_Office_;
    KEL.typ.nbool Is_Not_S_B_E_;
    KEL.typ.nbool Is_Goverment_;
    KEL.typ.nbool Is_Federal_Goverment_;
    KEL.typ.nstr Goverment_Type_;
    KEL.typ.nbool Is_Non_Profit_;
    KEL.typ.nstr Minority_Woman_Status_;
    KEL.typ.nbool Is_N_M_S_D_C_Certified_;
    KEL.typ.nbool Is_W_B_E_N_C_Certified_;
    KEL.typ.nbool Is_California_P_U_C_Certified_;
    KEL.typ.nbool Is_Texas_H_U_B_Certified_;
    KEL.typ.nbool Is_California_Caltrans_Certified_;
    KEL.typ.nbool Is_Educational_Institution_;
    KEL.typ.nbool Is_Minority_Institue_;
    KEL.typ.nbool Is_Alaska_Native_Corporation_;
    KEL.typ.nbool Is_S_B_A_H_U_B_Zone_;
    KEL.typ.nbool Is_Hist_Black_College_;
    KEL.typ.nstr Merchant_Type_;
    KEL.typ.nint Employee_Count_;
    KEL.typ.nstr Employee_Count_Code_;
    KEL.typ.nstr Business_Size_;
    KEL.typ.nint Financial_Amount_Figure_;
    KEL.typ.nstr Financial_Amount_Code_;
    KEL.typ.nstr Financial_Amount_Type_;
    KEL.typ.nstr Financial_Amount_Precision_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Location_Status_Layout := RECORD
    KEL.typ.nstr Company_Status_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nbool Is_Dead_;
    KEL.typ.nkdate Date_Dead_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Marketability_Layout := RECORD
    KEL.typ.nint General_Marketability_Score_;
    KEL.typ.nstr General_Marketability_Indicator_;
    KEL.typ.nbool Is_Vacant_;
    KEL.typ.nbool Is_Seasonal_;
    KEL.typ.nstr U_R_L_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Business_Owned_Characteristics_Layout := RECORD
    KEL.typ.nbool Is_Minority_Owned_;
    KEL.typ.nbool Is_Woman_Owned_;
    KEL.typ.nbool Is_Woman_Owned_S_B_E_;
    KEL.typ.nbool Is_Minority_Woman_Owned_;
    KEL.typ.nbool Is_Disadvantage_Owned_;
    KEL.typ.nbool Is_Veteran_Owned_;
    KEL.typ.nbool Is_Veteran_Owned_S_B_E_;
    KEL.typ.nbool Is_Disabled_Vet_Owned_;
    KEL.typ.nbool Is_Disabled_Vet_Owned_S_B_E_;
    KEL.typ.nbool Is_S_B_A_Disadvantaged_Owned_;
    KEL.typ.nbool Is_S_B_A8_A_Owned_;
    KEL.typ.nkdate S_B_A8_A_Owned_Date_;
    KEL.typ.nbool Is_Disabled_Owned_;
    KEL.typ.nbool Is_Gay_Lesbian_Owned_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Contacts_Layout := RECORD
    KEL.typ.nstr Contact_First_Name_;
    KEL.typ.nstr Contact_Middle_Name_;
    KEL.typ.nstr Contact_Last_Name_;
    KEL.typ.nstr Contact_Name_Suffix_;
    KEL.typ.nstr Contact_Primary_Range_;
    KEL.typ.nstr Contact_Predirectional_;
    KEL.typ.nstr Contact_Primary_Name_;
    KEL.typ.nstr Contact_Suffix_;
    KEL.typ.nstr Contact_Postdirectional_;
    KEL.typ.nstr Contact_Secondary_Range_;
    KEL.typ.nstr Contact_State_;
    KEL.typ.nint Contact_Z_I_P5_;
    KEL.typ.nint Contact_S_S_N_;
    KEL.typ.nint Contact_Phone_Number_;
    KEL.typ.nint Contact_Score_;
    KEL.typ.nstr Contact_Type_;
    KEL.typ.nstr Contact_Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nbool Contact_Is_Executive_;
    KEL.typ.nint Contact_Executive_Order_;
    KEL.typ.nbool Is_Contact_;
    KEL.typ.nstr Contact_Email_;
    KEL.typ.nstr Contact_Email_Username_;
    KEL.typ.nstr Contact_Email_Domain_;
    KEL.typ.nkdate Date_Regustered_Agent_Resigned_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Record_Status_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
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
    KEL.typ.ndataset(Cortera_Layout) Cortera_;
    KEL.typ.ndataset(Deleted_I_D_Numbers_Layout) Deleted_I_D_Numbers_;
    KEL.typ.ndataset(Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(O_S_H_A_Inspection_Layout) O_S_H_A_Inspection_;
    KEL.typ.ndataset(O_S_H_A_Violations_Layout) O_S_H_A_Violations_;
    KEL.typ.ndataset(O_S_H_A_Business_Information_Layout) O_S_H_A_Business_Information_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Associated_Address_Type_Layout) Associated_Address_Type_;
    KEL.typ.ndataset(Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(Location_Status_Layout) Location_Status_;
    KEL.typ.ndataset(Marketability_Layout) Marketability_;
    KEL.typ.ndataset(Business_Owned_Characteristics_Layout) Business_Owned_Characteristics_;
    KEL.typ.ndataset(Contacts_Layout) Contacts_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Prox_Group := __PostFilter;
  Layout Business_Prox__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Prox_I_D_ := KEL.Intake.SingleValue(__recs,Prox_I_D_);
    SELF.Prox_Sele_ := KEL.Intake.SingleValue(__recs,Prox_Sele_);
    SELF.Parent_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Parent_Prox_I_D_);
    SELF.Sele_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Sele_Prox_I_D_);
    SELF.Org_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Org_Prox_I_D_);
    SELF.Ult_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Ult_Prox_I_D_);
    SELF.Levels_From_Top_ := KEL.Intake.SingleValue(__recs,Levels_From_Top_);
    SELF.Nodes_Below_ := KEL.Intake.SingleValue(__recs,Nodes_Below_);
    SELF.Prox_Segment_ := KEL.Intake.SingleValue(__recs,Prox_Segment_);
    SELF.Store_Number_ := KEL.Intake.SingleValue(__recs,Store_Number_);
    SELF.Active_Duns_Number_ := KEL.Intake.SingleValue(__recs,Active_Duns_Number_);
    SELF.Hist_Duns_Number_ := KEL.Intake.SingleValue(__recs,Hist_Duns_Number_);
    SELF.D_U_N_S_Number_ := KEL.Intake.SingleValue(__recs,D_U_N_S_Number_);
    SELF.Equifax_I_D_ := KEL.Intake.SingleValue(__recs,Equifax_I_D_);
    SELF.Cortera_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Cortera_Ultimate_Link_I_D_,Cortera_Link_I_D_},Cortera_Ultimate_Link_I_D_,Cortera_Link_I_D_),Cortera_Layout)(__NN(Cortera_Ultimate_Link_I_D_) OR __NN(Cortera_Link_I_D_)));
    SELF.Deleted_I_D_Numbers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Deleted_Key_},Deleted_Key_),Deleted_I_D_Numbers_Layout)(__NN(Deleted_Key_)));
    SELF.Company_Names_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_,Source_},Name_,Source_),Company_Names_Layout)(__NN(Name_) OR __NN(Source_)));
    SELF.Best_Company_Names_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_Company_Name_,Best_Company_Name_Rank_},Best_Company_Name_,Best_Company_Name_Rank_),Best_Company_Names_Layout)(__NN(Best_Company_Name_) OR __NN(Best_Company_Name_Rank_)));
    SELF.Best_S_I_C_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_S_I_C_Code_,Best_S_I_C_Code_Rank_},Best_S_I_C_Code_,Best_S_I_C_Code_Rank_),Best_S_I_C_Codes_Layout)(__NN(Best_S_I_C_Code_) OR __NN(Best_S_I_C_Code_Rank_)));
    SELF.Best_N_A_I_C_S_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_N_A_I_C_S_Code_,Best_N_A_I_C_S_Code_Rank_},Best_N_A_I_C_S_Code_,Best_N_A_I_C_S_Code_Rank_),Best_N_A_I_C_S_Codes_Layout)(__NN(Best_N_A_I_C_S_Code_) OR __NN(Best_N_A_I_C_S_Code_Rank_)));
    SELF.O_S_H_A_Inspection_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),O_S_H_A_Inspection_Opening_Date_,O_S_H_A_Inspection_Close_Date_,O_S_H_A_Advance_Notice_Flag_,O_S_H_A_Union_Flag_,O_S_H_A_Inspection_Type_,O_S_H_A_Inspection_Type_Code_,O_S_H_A_Inspection_Scope_,O_S_H_A_Walk_Around_Flag_,O_S_H_A_Employees_Interviewed_Flag_,O_S_H_A_No_Inspection_Code_,O_S_H_A_Case_Closed_Flag_,O_S_H_A_Previous_Activity_Type_,O_S_H_A_Previous_Activity_Type_Description_},O_S_H_A_Inspection_Opening_Date_,O_S_H_A_Inspection_Close_Date_,O_S_H_A_Advance_Notice_Flag_,O_S_H_A_Union_Flag_,O_S_H_A_Inspection_Type_,O_S_H_A_Inspection_Type_Code_,O_S_H_A_Inspection_Scope_,O_S_H_A_Walk_Around_Flag_,O_S_H_A_Employees_Interviewed_Flag_,O_S_H_A_No_Inspection_Code_,O_S_H_A_Case_Closed_Flag_,O_S_H_A_Previous_Activity_Type_,O_S_H_A_Previous_Activity_Type_Description_),O_S_H_A_Inspection_Layout)(__NN(O_S_H_A_Inspection_Opening_Date_) OR __NN(O_S_H_A_Inspection_Close_Date_) OR __NN(O_S_H_A_Advance_Notice_Flag_) OR __NN(O_S_H_A_Union_Flag_) OR __NN(O_S_H_A_Inspection_Type_) OR __NN(O_S_H_A_Inspection_Type_Code_) OR __NN(O_S_H_A_Inspection_Scope_) OR __NN(O_S_H_A_Walk_Around_Flag_) OR __NN(O_S_H_A_Employees_Interviewed_Flag_) OR __NN(O_S_H_A_No_Inspection_Code_) OR __NN(O_S_H_A_Case_Closed_Flag_) OR __NN(O_S_H_A_Previous_Activity_Type_) OR __NN(O_S_H_A_Previous_Activity_Type_Description_)));
    SELF.O_S_H_A_Violations_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),O_S_H_A_Total_Violations_,O_S_H_A_Total_Serious_Violations_,O_S_H_A_Number_Of_Violations_,O_S_H_A_Number_Of_Events_,O_S_H_A_Number_Of_Hazardous_Substance_,O_S_H_A_Number_Of_Accidents_,O_S_H_A_Safety_Health_Flag_},O_S_H_A_Total_Violations_,O_S_H_A_Total_Serious_Violations_,O_S_H_A_Number_Of_Violations_,O_S_H_A_Number_Of_Events_,O_S_H_A_Number_Of_Hazardous_Substance_,O_S_H_A_Number_Of_Accidents_,O_S_H_A_Safety_Health_Flag_),O_S_H_A_Violations_Layout)(__NN(O_S_H_A_Total_Violations_) OR __NN(O_S_H_A_Total_Serious_Violations_) OR __NN(O_S_H_A_Number_Of_Violations_) OR __NN(O_S_H_A_Number_Of_Events_) OR __NN(O_S_H_A_Number_Of_Hazardous_Substance_) OR __NN(O_S_H_A_Number_Of_Accidents_) OR __NN(O_S_H_A_Safety_Health_Flag_)));
    SELF.O_S_H_A_Business_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),O_S_H_A_Owner_Type_,O_S_H_A_Owner_Type_Description_,O_S_H_A_Employee_Count12_Months_},O_S_H_A_Owner_Type_,O_S_H_A_Owner_Type_Description_,O_S_H_A_Employee_Count12_Months_),O_S_H_A_Business_Information_Layout)(__NN(O_S_H_A_Owner_Type_) OR __NN(O_S_H_A_Owner_Type_Description_) OR __NN(O_S_H_A_Employee_Count12_Months_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Process_Date_,Source_},Process_Date_,Source_),Vendor_Dates_Layout)(__NN(Process_Date_) OR __NN(Source_)));
    SELF.Associated_Address_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Associated_Addr_Commercial_,Associated_Addr_Residential_},Associated_Addr_Commercial_,Associated_Addr_Residential_),Associated_Address_Type_Layout)(__NN(Associated_Addr_Commercial_) OR __NN(Associated_Addr_Residential_)));
    SELF.Business_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Year_Established_,Public_Private_Indicator_,Corporation_Code_,Date_Last_Seen_Location_,Location_Corp_Hierarchy_,Is_S_B_E_,Is_Small_Business_Home_Office_,Is_Not_S_B_E_,Is_Goverment_,Is_Federal_Goverment_,Goverment_Type_,Is_Non_Profit_,Minority_Woman_Status_,Is_N_M_S_D_C_Certified_,Is_W_B_E_N_C_Certified_,Is_California_P_U_C_Certified_,Is_Texas_H_U_B_Certified_,Is_California_Caltrans_Certified_,Is_Educational_Institution_,Is_Minority_Institue_,Is_Alaska_Native_Corporation_,Is_S_B_A_H_U_B_Zone_,Is_Hist_Black_College_,Merchant_Type_,Employee_Count_,Employee_Count_Code_,Business_Size_,Financial_Amount_Figure_,Financial_Amount_Code_,Financial_Amount_Type_,Financial_Amount_Precision_,Source_},Year_Established_,Public_Private_Indicator_,Corporation_Code_,Date_Last_Seen_Location_,Location_Corp_Hierarchy_,Is_S_B_E_,Is_Small_Business_Home_Office_,Is_Not_S_B_E_,Is_Goverment_,Is_Federal_Goverment_,Goverment_Type_,Is_Non_Profit_,Minority_Woman_Status_,Is_N_M_S_D_C_Certified_,Is_W_B_E_N_C_Certified_,Is_California_P_U_C_Certified_,Is_Texas_H_U_B_Certified_,Is_California_Caltrans_Certified_,Is_Educational_Institution_,Is_Minority_Institue_,Is_Alaska_Native_Corporation_,Is_S_B_A_H_U_B_Zone_,Is_Hist_Black_College_,Merchant_Type_,Employee_Count_,Employee_Count_Code_,Business_Size_,Financial_Amount_Figure_,Financial_Amount_Code_,Financial_Amount_Type_,Financial_Amount_Precision_,Source_),Business_Characteristics_Layout)(__NN(Year_Established_) OR __NN(Public_Private_Indicator_) OR __NN(Corporation_Code_) OR __NN(Date_Last_Seen_Location_) OR __NN(Location_Corp_Hierarchy_) OR __NN(Is_S_B_E_) OR __NN(Is_Small_Business_Home_Office_) OR __NN(Is_Not_S_B_E_) OR __NN(Is_Goverment_) OR __NN(Is_Federal_Goverment_) OR __NN(Goverment_Type_) OR __NN(Is_Non_Profit_) OR __NN(Minority_Woman_Status_) OR __NN(Is_N_M_S_D_C_Certified_) OR __NN(Is_W_B_E_N_C_Certified_) OR __NN(Is_California_P_U_C_Certified_) OR __NN(Is_Texas_H_U_B_Certified_) OR __NN(Is_California_Caltrans_Certified_) OR __NN(Is_Educational_Institution_) OR __NN(Is_Minority_Institue_) OR __NN(Is_Alaska_Native_Corporation_) OR __NN(Is_S_B_A_H_U_B_Zone_) OR __NN(Is_Hist_Black_College_) OR __NN(Merchant_Type_) OR __NN(Employee_Count_) OR __NN(Employee_Count_Code_) OR __NN(Business_Size_) OR __NN(Financial_Amount_Figure_) OR __NN(Financial_Amount_Code_) OR __NN(Financial_Amount_Type_) OR __NN(Financial_Amount_Precision_) OR __NN(Source_)));
    SELF.Location_Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Company_Status_,Is_Closed_,Date_Closed_,Is_Dead_,Date_Dead_},Company_Status_,Is_Closed_,Date_Closed_,Is_Dead_,Date_Dead_),Location_Status_Layout)(__NN(Company_Status_) OR __NN(Is_Closed_) OR __NN(Date_Closed_) OR __NN(Is_Dead_) OR __NN(Date_Dead_)));
    SELF.Marketability_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),General_Marketability_Score_,General_Marketability_Indicator_,Is_Vacant_,Is_Seasonal_,U_R_L_},General_Marketability_Score_,General_Marketability_Indicator_,Is_Vacant_,Is_Seasonal_,U_R_L_),Marketability_Layout)(__NN(General_Marketability_Score_) OR __NN(General_Marketability_Indicator_) OR __NN(Is_Vacant_) OR __NN(Is_Seasonal_) OR __NN(U_R_L_)));
    SELF.Business_Owned_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_Minority_Owned_,Is_Woman_Owned_,Is_Woman_Owned_S_B_E_,Is_Minority_Woman_Owned_,Is_Disadvantage_Owned_,Is_Veteran_Owned_,Is_Veteran_Owned_S_B_E_,Is_Disabled_Vet_Owned_,Is_Disabled_Vet_Owned_S_B_E_,Is_S_B_A_Disadvantaged_Owned_,Is_S_B_A8_A_Owned_,S_B_A8_A_Owned_Date_,Is_Disabled_Owned_,Is_Gay_Lesbian_Owned_},Is_Minority_Owned_,Is_Woman_Owned_,Is_Woman_Owned_S_B_E_,Is_Minority_Woman_Owned_,Is_Disadvantage_Owned_,Is_Veteran_Owned_,Is_Veteran_Owned_S_B_E_,Is_Disabled_Vet_Owned_,Is_Disabled_Vet_Owned_S_B_E_,Is_S_B_A_Disadvantaged_Owned_,Is_S_B_A8_A_Owned_,S_B_A8_A_Owned_Date_,Is_Disabled_Owned_,Is_Gay_Lesbian_Owned_),Business_Owned_Characteristics_Layout)(__NN(Is_Minority_Owned_) OR __NN(Is_Woman_Owned_) OR __NN(Is_Woman_Owned_S_B_E_) OR __NN(Is_Minority_Woman_Owned_) OR __NN(Is_Disadvantage_Owned_) OR __NN(Is_Veteran_Owned_) OR __NN(Is_Veteran_Owned_S_B_E_) OR __NN(Is_Disabled_Vet_Owned_) OR __NN(Is_Disabled_Vet_Owned_S_B_E_) OR __NN(Is_S_B_A_Disadvantaged_Owned_) OR __NN(Is_S_B_A8_A_Owned_) OR __NN(S_B_A8_A_Owned_Date_) OR __NN(Is_Disabled_Owned_) OR __NN(Is_Gay_Lesbian_Owned_)));
    SELF.Contacts_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Contact_First_Name_,Contact_Middle_Name_,Contact_Last_Name_,Contact_Name_Suffix_,Contact_Primary_Range_,Contact_Predirectional_,Contact_Primary_Name_,Contact_Suffix_,Contact_Postdirectional_,Contact_Secondary_Range_,Contact_State_,Contact_Z_I_P5_,Contact_S_S_N_,Contact_Phone_Number_,Contact_Score_,Contact_Type_,Contact_Job_Title_,Contact_Status_,Contact_Is_Executive_,Contact_Executive_Order_,Is_Contact_,Contact_Email_,Contact_Email_Username_,Contact_Email_Domain_,Date_Regustered_Agent_Resigned_,Header_Hit_Flag_,Source_},Contact_First_Name_,Contact_Middle_Name_,Contact_Last_Name_,Contact_Name_Suffix_,Contact_Primary_Range_,Contact_Predirectional_,Contact_Primary_Name_,Contact_Suffix_,Contact_Postdirectional_,Contact_Secondary_Range_,Contact_State_,Contact_Z_I_P5_,Contact_S_S_N_,Contact_Phone_Number_,Contact_Score_,Contact_Type_,Contact_Job_Title_,Contact_Status_,Contact_Is_Executive_,Contact_Executive_Order_,Is_Contact_,Contact_Email_,Contact_Email_Username_,Contact_Email_Domain_,Date_Regustered_Agent_Resigned_,Header_Hit_Flag_,Source_),Contacts_Layout)(__NN(Contact_First_Name_) OR __NN(Contact_Middle_Name_) OR __NN(Contact_Last_Name_) OR __NN(Contact_Name_Suffix_) OR __NN(Contact_Primary_Range_) OR __NN(Contact_Predirectional_) OR __NN(Contact_Primary_Name_) OR __NN(Contact_Suffix_) OR __NN(Contact_Postdirectional_) OR __NN(Contact_Secondary_Range_) OR __NN(Contact_State_) OR __NN(Contact_Z_I_P5_) OR __NN(Contact_S_S_N_) OR __NN(Contact_Phone_Number_) OR __NN(Contact_Score_) OR __NN(Contact_Type_) OR __NN(Contact_Job_Title_) OR __NN(Contact_Status_) OR __NN(Contact_Is_Executive_) OR __NN(Contact_Executive_Order_) OR __NN(Is_Contact_) OR __NN(Contact_Email_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Date_Regustered_Agent_Resigned_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Header_Hit_Flag_,Record_Status_},Source_,Header_Hit_Flag_,Record_Status_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(Record_Status_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Business_Prox__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Cortera_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Cortera_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Cortera_Ultimate_Link_I_D_) OR __NN(Cortera_Link_I_D_)));
    SELF.Deleted_I_D_Numbers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Deleted_I_D_Numbers_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Deleted_Key_)));
    SELF.Company_Names_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Company_Names_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Name_) OR __NN(Source_)));
    SELF.Best_Company_Names_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_Company_Names_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Best_Company_Name_) OR __NN(Best_Company_Name_Rank_)));
    SELF.Best_S_I_C_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_S_I_C_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Best_S_I_C_Code_) OR __NN(Best_S_I_C_Code_Rank_)));
    SELF.Best_N_A_I_C_S_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_N_A_I_C_S_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Best_N_A_I_C_S_Code_) OR __NN(Best_N_A_I_C_S_Code_Rank_)));
    SELF.O_S_H_A_Inspection_ := __CN(PROJECT(DATASET(__r),TRANSFORM(O_S_H_A_Inspection_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(O_S_H_A_Inspection_Opening_Date_) OR __NN(O_S_H_A_Inspection_Close_Date_) OR __NN(O_S_H_A_Advance_Notice_Flag_) OR __NN(O_S_H_A_Union_Flag_) OR __NN(O_S_H_A_Inspection_Type_) OR __NN(O_S_H_A_Inspection_Type_Code_) OR __NN(O_S_H_A_Inspection_Scope_) OR __NN(O_S_H_A_Walk_Around_Flag_) OR __NN(O_S_H_A_Employees_Interviewed_Flag_) OR __NN(O_S_H_A_No_Inspection_Code_) OR __NN(O_S_H_A_Case_Closed_Flag_) OR __NN(O_S_H_A_Previous_Activity_Type_) OR __NN(O_S_H_A_Previous_Activity_Type_Description_)));
    SELF.O_S_H_A_Violations_ := __CN(PROJECT(DATASET(__r),TRANSFORM(O_S_H_A_Violations_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(O_S_H_A_Total_Violations_) OR __NN(O_S_H_A_Total_Serious_Violations_) OR __NN(O_S_H_A_Number_Of_Violations_) OR __NN(O_S_H_A_Number_Of_Events_) OR __NN(O_S_H_A_Number_Of_Hazardous_Substance_) OR __NN(O_S_H_A_Number_Of_Accidents_) OR __NN(O_S_H_A_Safety_Health_Flag_)));
    SELF.O_S_H_A_Business_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(O_S_H_A_Business_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(O_S_H_A_Owner_Type_) OR __NN(O_S_H_A_Owner_Type_Description_) OR __NN(O_S_H_A_Employee_Count12_Months_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Process_Date_) OR __NN(Source_)));
    SELF.Associated_Address_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Associated_Address_Type_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Associated_Addr_Commercial_) OR __NN(Associated_Addr_Residential_)));
    SELF.Business_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Business_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Year_Established_) OR __NN(Public_Private_Indicator_) OR __NN(Corporation_Code_) OR __NN(Date_Last_Seen_Location_) OR __NN(Location_Corp_Hierarchy_) OR __NN(Is_S_B_E_) OR __NN(Is_Small_Business_Home_Office_) OR __NN(Is_Not_S_B_E_) OR __NN(Is_Goverment_) OR __NN(Is_Federal_Goverment_) OR __NN(Goverment_Type_) OR __NN(Is_Non_Profit_) OR __NN(Minority_Woman_Status_) OR __NN(Is_N_M_S_D_C_Certified_) OR __NN(Is_W_B_E_N_C_Certified_) OR __NN(Is_California_P_U_C_Certified_) OR __NN(Is_Texas_H_U_B_Certified_) OR __NN(Is_California_Caltrans_Certified_) OR __NN(Is_Educational_Institution_) OR __NN(Is_Minority_Institue_) OR __NN(Is_Alaska_Native_Corporation_) OR __NN(Is_S_B_A_H_U_B_Zone_) OR __NN(Is_Hist_Black_College_) OR __NN(Merchant_Type_) OR __NN(Employee_Count_) OR __NN(Employee_Count_Code_) OR __NN(Business_Size_) OR __NN(Financial_Amount_Figure_) OR __NN(Financial_Amount_Code_) OR __NN(Financial_Amount_Type_) OR __NN(Financial_Amount_Precision_) OR __NN(Source_)));
    SELF.Location_Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Location_Status_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Company_Status_) OR __NN(Is_Closed_) OR __NN(Date_Closed_) OR __NN(Is_Dead_) OR __NN(Date_Dead_)));
    SELF.Marketability_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Marketability_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(General_Marketability_Score_) OR __NN(General_Marketability_Indicator_) OR __NN(Is_Vacant_) OR __NN(Is_Seasonal_) OR __NN(U_R_L_)));
    SELF.Business_Owned_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Business_Owned_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_Minority_Owned_) OR __NN(Is_Woman_Owned_) OR __NN(Is_Woman_Owned_S_B_E_) OR __NN(Is_Minority_Woman_Owned_) OR __NN(Is_Disadvantage_Owned_) OR __NN(Is_Veteran_Owned_) OR __NN(Is_Veteran_Owned_S_B_E_) OR __NN(Is_Disabled_Vet_Owned_) OR __NN(Is_Disabled_Vet_Owned_S_B_E_) OR __NN(Is_S_B_A_Disadvantaged_Owned_) OR __NN(Is_S_B_A8_A_Owned_) OR __NN(S_B_A8_A_Owned_Date_) OR __NN(Is_Disabled_Owned_) OR __NN(Is_Gay_Lesbian_Owned_)));
    SELF.Contacts_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Contacts_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Contact_First_Name_) OR __NN(Contact_Middle_Name_) OR __NN(Contact_Last_Name_) OR __NN(Contact_Name_Suffix_) OR __NN(Contact_Primary_Range_) OR __NN(Contact_Predirectional_) OR __NN(Contact_Primary_Name_) OR __NN(Contact_Suffix_) OR __NN(Contact_Postdirectional_) OR __NN(Contact_Secondary_Range_) OR __NN(Contact_State_) OR __NN(Contact_Z_I_P5_) OR __NN(Contact_S_S_N_) OR __NN(Contact_Phone_Number_) OR __NN(Contact_Score_) OR __NN(Contact_Type_) OR __NN(Contact_Job_Title_) OR __NN(Contact_Status_) OR __NN(Contact_Is_Executive_) OR __NN(Contact_Executive_Order_) OR __NN(Is_Contact_) OR __NN(Contact_Email_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Date_Regustered_Agent_Resigned_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(Record_Status_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Prox_Group,COUNT(ROWS(LEFT))=1),GROUP,Business_Prox__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Prox_Group,COUNT(ROWS(LEFT))>1),GROUP,Business_Prox__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sele_I_D_);
  EXPORT Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Prox_I_D_);
  EXPORT Prox_Sele__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Prox_Sele_);
  EXPORT Parent_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Parent_Prox_I_D_);
  EXPORT Sele_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sele_Prox_I_D_);
  EXPORT Org_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Org_Prox_I_D_);
  EXPORT Ult_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Ult_Prox_I_D_);
  EXPORT Levels_From_Top__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Levels_From_Top_);
  EXPORT Nodes_Below__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Nodes_Below_);
  EXPORT Prox_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Prox_Segment_);
  EXPORT Store_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Store_Number_);
  EXPORT Active_Duns_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Active_Duns_Number_);
  EXPORT Hist_Duns_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Hist_Duns_Number_);
  EXPORT D_U_N_S_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,D_U_N_S_Number_);
  EXPORT Equifax_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Equifax_I_D_);
  EXPORT Prox_Sele__Orphan := JOIN(InData(__NN(Prox_Sele_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Prox_Sele_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Prox_Sele__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BusReg__kfetch_busreg_company_linkids_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera__kfetch_LinkID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_EBR_kfetch_5600_Demographic_Data_linkids_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_OSHAIR__kfetch_OSHAIR_LinkIds_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_slim_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_3_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid),COUNT(Prox_I_D__SingleValue_Invalid),COUNT(Prox_Sele__SingleValue_Invalid),COUNT(Parent_Prox_I_D__SingleValue_Invalid),COUNT(Sele_Prox_I_D__SingleValue_Invalid),COUNT(Org_Prox_I_D__SingleValue_Invalid),COUNT(Ult_Prox_I_D__SingleValue_Invalid),COUNT(Levels_From_Top__SingleValue_Invalid),COUNT(Nodes_Below__SingleValue_Invalid),COUNT(Prox_Segment__SingleValue_Invalid),COUNT(Store_Number__SingleValue_Invalid),COUNT(Active_Duns_Number__SingleValue_Invalid),COUNT(Hist_Duns_Number__SingleValue_Invalid),COUNT(D_U_N_S_Number__SingleValue_Invalid),COUNT(Equifax_I_D__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Prox_Sele__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BusReg__kfetch_busreg_company_linkids_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera__kfetch_LinkID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_EBR_kfetch_5600_Demographic_Data_linkids_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_OSHAIR__kfetch_OSHAIR_LinkIds_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_slim_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_3_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid,KEL.typ.int Prox_I_D__SingleValue_Invalid,KEL.typ.int Prox_Sele__SingleValue_Invalid,KEL.typ.int Parent_Prox_I_D__SingleValue_Invalid,KEL.typ.int Sele_Prox_I_D__SingleValue_Invalid,KEL.typ.int Org_Prox_I_D__SingleValue_Invalid,KEL.typ.int Ult_Prox_I_D__SingleValue_Invalid,KEL.typ.int Levels_From_Top__SingleValue_Invalid,KEL.typ.int Nodes_Below__SingleValue_Invalid,KEL.typ.int Prox_Segment__SingleValue_Invalid,KEL.typ.int Store_Number__SingleValue_Invalid,KEL.typ.int Active_Duns_Number__SingleValue_Invalid,KEL.typ.int Hist_Duns_Number__SingleValue_Invalid,KEL.typ.int D_U_N_S_Number__SingleValue_Invalid,KEL.typ.int Equifax_I_D__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid),COUNT(__d0)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d0(__NL(Prox_I_D_))),COUNT(__d0(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d0(__NL(Prox_Sele_))),COUNT(__d0(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','parent_proxid',COUNT(__d0(__NL(Parent_Prox_I_D_))),COUNT(__d0(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sele_proxid',COUNT(__d0(__NL(Sele_Prox_I_D_))),COUNT(__d0(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','org_proxid',COUNT(__d0(__NL(Org_Prox_I_D_))),COUNT(__d0(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultimate_proxid',COUNT(__d0(__NL(Ult_Prox_I_D_))),COUNT(__d0(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','levels_from_top',COUNT(__d0(__NL(Levels_From_Top_))),COUNT(__d0(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nodes_below',COUNT(__d0(__NL(Nodes_Below_))),COUNT(__d0(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prox_seg',COUNT(__d0(__NL(Prox_Segment_))),COUNT(__d0(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cnp_store_number',COUNT(__d0(__NL(Store_Number_))),COUNT(__d0(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','active_duns_number',COUNT(__d0(__NL(Active_Duns_Number_))),COUNT(__d0(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hist_duns_number',COUNT(__d0(__NL(Hist_Duns_Number_))),COUNT(__d0(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','deleted_key',COUNT(__d0(__NL(Deleted_Key_))),COUNT(__d0(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','duns_number',COUNT(__d0(__NL(D_U_N_S_Number_))),COUNT(__d0(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d0(__NL(Name_))),COUNT(__d0(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d0(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d0(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d0(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d0(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d0(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d0(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d0(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d0(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d0(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d0(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d0(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d0(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d0(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d0(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d0(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d0(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d0(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d0(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d0(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d0(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d0(__NL(O_S_H_A_Union_Flag_))),COUNT(__d0(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d0(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d0(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d0(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d0(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d0(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d0(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d0(__NL(O_S_H_A_Total_Violations_))),COUNT(__d0(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d0(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d0(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d0(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d0(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d0(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d0(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d0(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d0(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d0(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d0(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d0(__NL(O_S_H_A_Owner_Type_))),COUNT(__d0(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d0(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d0(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d0(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d0(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d0(__NL(Best_Company_Name_))),COUNT(__d0(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d0(__NL(Best_Company_Name_Rank_))),COUNT(__d0(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d0(__NL(Best_S_I_C_Code_))),COUNT(__d0(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d0(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d0(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d0(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d0(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d0(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d0(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d0(__NL(Corporation_Code_))),COUNT(__d0(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d0(__NL(Contact_First_Name_))),COUNT(__d0(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d0(__NL(Contact_Middle_Name_))),COUNT(__d0(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d0(__NL(Contact_Last_Name_))),COUNT(__d0(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d0(__NL(Contact_Name_Suffix_))),COUNT(__d0(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d0(__NL(Contact_Primary_Range_))),COUNT(__d0(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d0(__NL(Contact_Predirectional_))),COUNT(__d0(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d0(__NL(Contact_Primary_Name_))),COUNT(__d0(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d0(__NL(Contact_Suffix_))),COUNT(__d0(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d0(__NL(Contact_Postdirectional_))),COUNT(__d0(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d0(__NL(Contact_Secondary_Range_))),COUNT(__d0(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d0(__NL(Contact_State_))),COUNT(__d0(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d0(__NL(Contact_Z_I_P5_))),COUNT(__d0(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d0(__NL(Contact_S_S_N_))),COUNT(__d0(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d0(__NL(Contact_Phone_Number_))),COUNT(__d0(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d0(__NL(Contact_Score_))),COUNT(__d0(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d0(__NL(Contact_Type_))),COUNT(__d0(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d0(__NL(Contact_Email_))),COUNT(__d0(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d0(__NL(Contact_Email_Username_))),COUNT(__d0(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d0(__NL(Contact_Email_Domain_))),COUNT(__d0(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d0(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d0(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d0(__NL(Cortera_Link_I_D_))),COUNT(__d0(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d0(__NL(Contact_Job_Title_))),COUNT(__d0(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d0(__NL(Contact_Status_))),COUNT(__d0(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d0(__NL(Location_Corp_Hierarchy_))),COUNT(__d0(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d0(__NL(Company_Status_))),COUNT(__d0(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d0(__NL(Is_Closed_))),COUNT(__d0(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d0(__NL(Contact_Is_Executive_))),COUNT(__d0(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d0(__NL(Is_Contact_))),COUNT(__d0(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d0(__NL(Contact_Executive_Order_))),COUNT(__d0(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d0(__NL(Record_Status_))),COUNT(__d0(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d0(__NL(Equifax_I_D_))),COUNT(__d0(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d0(__NL(Is_Small_Business_Home_Office_))),COUNT(__d0(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d0(__NL(U_R_L_))),COUNT(__d0(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d0(__NL(Employee_Count_))),COUNT(__d0(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d0(__NL(Employee_Count_Code_))),COUNT(__d0(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d0(__NL(Financial_Amount_Figure_))),COUNT(__d0(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d0(__NL(Financial_Amount_Code_))),COUNT(__d0(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d0(__NL(Financial_Amount_Type_))),COUNT(__d0(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d0(__NL(Financial_Amount_Precision_))),COUNT(__d0(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d0(__NL(Is_Dead_))),COUNT(__d0(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d0(__NL(Date_Dead_))),COUNT(__d0(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d0(__NL(Associated_Addr_Commercial_))),COUNT(__d0(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d0(__NL(Associated_Addr_Residential_))),COUNT(__d0(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d0(__NL(General_Marketability_Score_))),COUNT(__d0(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d0(__NL(General_Marketability_Indicator_))),COUNT(__d0(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d0(__NL(Is_Vacant_))),COUNT(__d0(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d0(__NL(Is_Seasonal_))),COUNT(__d0(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d0(__NL(Is_Minority_Owned_))),COUNT(__d0(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d0(__NL(Is_Woman_Owned_))),COUNT(__d0(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d0(__NL(Is_Minority_Woman_Owned_))),COUNT(__d0(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d0(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d0(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d0(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d0(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d0(__NL(Is_Disadvantage_Owned_))),COUNT(__d0(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d0(__NL(Is_Veteran_Owned_))),COUNT(__d0(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d0(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d0(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d0(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d0(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d0(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d0(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d0(__NL(Is_Disabled_Owned_))),COUNT(__d0(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d0(__NL(Is_Hist_Black_College_))),COUNT(__d0(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d0(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d0(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d0(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d0(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d0(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d0(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d0(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d0(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d0(__NL(Is_S_B_E_))),COUNT(__d0(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d0(__NL(Is_Not_S_B_E_))),COUNT(__d0(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d0(__NL(Is_Goverment_))),COUNT(__d0(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d0(__NL(Is_Federal_Goverment_))),COUNT(__d0(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d0(__NL(Merchant_Type_))),COUNT(__d0(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d0(__NL(Year_Established_))),COUNT(__d0(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d0(__NL(Public_Private_Indicator_))),COUNT(__d0(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d0(__NL(Business_Size_))),COUNT(__d0(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d0(__NL(Goverment_Type_))),COUNT(__d0(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d0(__NL(Is_Non_Profit_))),COUNT(__d0(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d0(__NL(Minority_Woman_Status_))),COUNT(__d0(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d0(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d0(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d0(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d0(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d0(__NL(Is_California_P_U_C_Certified_))),COUNT(__d0(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d0(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d0(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d0(__NL(Is_California_Caltrans_Certified_))),COUNT(__d0(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d0(__NL(Is_Educational_Institution_))),COUNT(__d0(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d0(__NL(Is_Minority_Institue_))),COUNT(__d0(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d0(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d0(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d0(__NL(Date_Last_Seen_Location_))),COUNT(__d0(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d0(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d0(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d0(__NL(Date_Closed_))),COUNT(__d0(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_Invalid),COUNT(__d1)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d1(__NL(Ult_I_D_))),COUNT(__d1(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d1(__NL(Org_I_D_))),COUNT(__d1(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d1(__NL(Sele_I_D_))),COUNT(__d1(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d1(__NL(Prox_I_D_))),COUNT(__d1(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d1(__NL(Prox_Sele_))),COUNT(__d1(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d1(__NL(Parent_Prox_I_D_))),COUNT(__d1(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d1(__NL(Sele_Prox_I_D_))),COUNT(__d1(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d1(__NL(Org_Prox_I_D_))),COUNT(__d1(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d1(__NL(Ult_Prox_I_D_))),COUNT(__d1(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d1(__NL(Levels_From_Top_))),COUNT(__d1(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d1(__NL(Nodes_Below_))),COUNT(__d1(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d1(__NL(Prox_Segment_))),COUNT(__d1(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d1(__NL(Store_Number_))),COUNT(__d1(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d1(__NL(Active_Duns_Number_))),COUNT(__d1(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d1(__NL(Hist_Duns_Number_))),COUNT(__d1(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d1(__NL(Deleted_Key_))),COUNT(__d1(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d1(__NL(D_U_N_S_Number_))),COUNT(__d1(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d1(__NL(Name_))),COUNT(__d1(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d1(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d1(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d1(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d1(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d1(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d1(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d1(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d1(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d1(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d1(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d1(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d1(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d1(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d1(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d1(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d1(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d1(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d1(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d1(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d1(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d1(__NL(O_S_H_A_Union_Flag_))),COUNT(__d1(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d1(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d1(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d1(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d1(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d1(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d1(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d1(__NL(O_S_H_A_Total_Violations_))),COUNT(__d1(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d1(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d1(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d1(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d1(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d1(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d1(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d1(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d1(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d1(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d1(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d1(__NL(O_S_H_A_Owner_Type_))),COUNT(__d1(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d1(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d1(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d1(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d1(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d1(__NL(Best_Company_Name_))),COUNT(__d1(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d1(__NL(Best_Company_Name_Rank_))),COUNT(__d1(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d1(__NL(Best_S_I_C_Code_))),COUNT(__d1(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d1(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d1(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d1(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d1(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d1(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d1(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d1(__NL(Header_Hit_Flag_))),COUNT(__d1(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d1(__NL(Corporation_Code_))),COUNT(__d1(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_fname1',COUNT(__d1(__NL(Contact_First_Name_))),COUNT(__d1(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_mname1',COUNT(__d1(__NL(Contact_Middle_Name_))),COUNT(__d1(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_lname1',COUNT(__d1(__NL(Contact_Last_Name_))),COUNT(__d1(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_name_suffix1',COUNT(__d1(__NL(Contact_Name_Suffix_))),COUNT(__d1(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_range',COUNT(__d1(__NL(Contact_Primary_Range_))),COUNT(__d1(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_predir',COUNT(__d1(__NL(Contact_Predirectional_))),COUNT(__d1(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_name',COUNT(__d1(__NL(Contact_Primary_Name_))),COUNT(__d1(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_addr_suffix',COUNT(__d1(__NL(Contact_Suffix_))),COUNT(__d1(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_postdir',COUNT(__d1(__NL(Contact_Postdirectional_))),COUNT(__d1(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_sec_range',COUNT(__d1(__NL(Contact_Secondary_Range_))),COUNT(__d1(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_state',COUNT(__d1(__NL(Contact_State_))),COUNT(__d1(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_zip5',COUNT(__d1(__NL(Contact_Z_I_P5_))),COUNT(__d1(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d1(__NL(Contact_S_S_N_))),COUNT(__d1(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_phone10',COUNT(__d1(__NL(Contact_Phone_Number_))),COUNT(__d1(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d1(__NL(Contact_Score_))),COUNT(__d1(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d1(__NL(Contact_Type_))),COUNT(__d1(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d1(__NL(Contact_Email_))),COUNT(__d1(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d1(__NL(Contact_Email_Username_))),COUNT(__d1(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d1(__NL(Contact_Email_Domain_))),COUNT(__d1(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d1(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d1(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d1(__NL(Cortera_Link_I_D_))),COUNT(__d1(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_title_desc',COUNT(__d1(__NL(Contact_Job_Title_))),COUNT(__d1(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d1(__NL(Contact_Status_))),COUNT(__d1(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d1(__NL(Location_Corp_Hierarchy_))),COUNT(__d1(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d1(__NL(Company_Status_))),COUNT(__d1(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d1(__NL(Is_Closed_))),COUNT(__d1(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d1(__NL(Contact_Is_Executive_))),COUNT(__d1(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d1(__NL(Is_Contact_))),COUNT(__d1(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d1(__NL(Contact_Executive_Order_))),COUNT(__d1(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d1(__NL(Record_Status_))),COUNT(__d1(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d1(__NL(Equifax_I_D_))),COUNT(__d1(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d1(__NL(Is_Small_Business_Home_Office_))),COUNT(__d1(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d1(__NL(U_R_L_))),COUNT(__d1(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d1(__NL(Employee_Count_))),COUNT(__d1(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d1(__NL(Employee_Count_Code_))),COUNT(__d1(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d1(__NL(Financial_Amount_Figure_))),COUNT(__d1(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d1(__NL(Financial_Amount_Code_))),COUNT(__d1(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d1(__NL(Financial_Amount_Type_))),COUNT(__d1(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d1(__NL(Financial_Amount_Precision_))),COUNT(__d1(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d1(__NL(Is_Dead_))),COUNT(__d1(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d1(__NL(Date_Dead_))),COUNT(__d1(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d1(__NL(Associated_Addr_Commercial_))),COUNT(__d1(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d1(__NL(Associated_Addr_Residential_))),COUNT(__d1(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d1(__NL(General_Marketability_Score_))),COUNT(__d1(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d1(__NL(General_Marketability_Indicator_))),COUNT(__d1(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d1(__NL(Is_Vacant_))),COUNT(__d1(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d1(__NL(Is_Seasonal_))),COUNT(__d1(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d1(__NL(Is_Minority_Owned_))),COUNT(__d1(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d1(__NL(Is_Woman_Owned_))),COUNT(__d1(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d1(__NL(Is_Minority_Woman_Owned_))),COUNT(__d1(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d1(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d1(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d1(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d1(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d1(__NL(Is_Disadvantage_Owned_))),COUNT(__d1(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d1(__NL(Is_Veteran_Owned_))),COUNT(__d1(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d1(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d1(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d1(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d1(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d1(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d1(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d1(__NL(Is_Disabled_Owned_))),COUNT(__d1(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d1(__NL(Is_Hist_Black_College_))),COUNT(__d1(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d1(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d1(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d1(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d1(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d1(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d1(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d1(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d1(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d1(__NL(Is_S_B_E_))),COUNT(__d1(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d1(__NL(Is_Not_S_B_E_))),COUNT(__d1(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d1(__NL(Is_Goverment_))),COUNT(__d1(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d1(__NL(Is_Federal_Goverment_))),COUNT(__d1(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d1(__NL(Merchant_Type_))),COUNT(__d1(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d1(__NL(Process_Date_))),COUNT(__d1(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d1(__NL(Year_Established_))),COUNT(__d1(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d1(__NL(Public_Private_Indicator_))),COUNT(__d1(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d1(__NL(Business_Size_))),COUNT(__d1(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d1(__NL(Goverment_Type_))),COUNT(__d1(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d1(__NL(Is_Non_Profit_))),COUNT(__d1(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d1(__NL(Minority_Woman_Status_))),COUNT(__d1(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d1(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d1(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d1(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d1(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d1(__NL(Is_California_P_U_C_Certified_))),COUNT(__d1(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d1(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d1(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d1(__NL(Is_California_Caltrans_Certified_))),COUNT(__d1(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d1(__NL(Is_Educational_Institution_))),COUNT(__d1(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d1(__NL(Is_Minority_Institue_))),COUNT(__d1(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d1(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d1(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d1(__NL(Date_Last_Seen_Location_))),COUNT(__d1(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_resign_date',COUNT(__d1(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d1(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d1(__NL(Date_Closed_))),COUNT(__d1(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BusReg__kfetch_busreg_company_linkids_Invalid),COUNT(__d2)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d2(__NL(Ult_I_D_))),COUNT(__d2(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d2(__NL(Org_I_D_))),COUNT(__d2(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d2(__NL(Sele_I_D_))),COUNT(__d2(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d2(__NL(Prox_I_D_))),COUNT(__d2(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d2(__NL(Prox_Sele_))),COUNT(__d2(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d2(__NL(Parent_Prox_I_D_))),COUNT(__d2(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d2(__NL(Sele_Prox_I_D_))),COUNT(__d2(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d2(__NL(Org_Prox_I_D_))),COUNT(__d2(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d2(__NL(Ult_Prox_I_D_))),COUNT(__d2(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d2(__NL(Levels_From_Top_))),COUNT(__d2(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d2(__NL(Nodes_Below_))),COUNT(__d2(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d2(__NL(Prox_Segment_))),COUNT(__d2(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d2(__NL(Store_Number_))),COUNT(__d2(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d2(__NL(Active_Duns_Number_))),COUNT(__d2(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d2(__NL(Hist_Duns_Number_))),COUNT(__d2(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d2(__NL(Deleted_Key_))),COUNT(__d2(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d2(__NL(D_U_N_S_Number_))),COUNT(__d2(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d2(__NL(Name_))),COUNT(__d2(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d2(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d2(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d2(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d2(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d2(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d2(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d2(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d2(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d2(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d2(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d2(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d2(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d2(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d2(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d2(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d2(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d2(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d2(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d2(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d2(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d2(__NL(O_S_H_A_Union_Flag_))),COUNT(__d2(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d2(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d2(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d2(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d2(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d2(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d2(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d2(__NL(O_S_H_A_Total_Violations_))),COUNT(__d2(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d2(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d2(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d2(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d2(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d2(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d2(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d2(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d2(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d2(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d2(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d2(__NL(O_S_H_A_Owner_Type_))),COUNT(__d2(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d2(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d2(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d2(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d2(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d2(__NL(Best_Company_Name_))),COUNT(__d2(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d2(__NL(Best_Company_Name_Rank_))),COUNT(__d2(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d2(__NL(Best_S_I_C_Code_))),COUNT(__d2(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d2(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d2(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d2(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d2(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d2(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d2(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rawfields.corpcode',COUNT(__d2(__NL(Corporation_Code_))),COUNT(__d2(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d2(__NL(Contact_First_Name_))),COUNT(__d2(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d2(__NL(Contact_Middle_Name_))),COUNT(__d2(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d2(__NL(Contact_Last_Name_))),COUNT(__d2(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d2(__NL(Contact_Name_Suffix_))),COUNT(__d2(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d2(__NL(Contact_Primary_Range_))),COUNT(__d2(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d2(__NL(Contact_Predirectional_))),COUNT(__d2(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d2(__NL(Contact_Primary_Name_))),COUNT(__d2(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d2(__NL(Contact_Suffix_))),COUNT(__d2(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d2(__NL(Contact_Postdirectional_))),COUNT(__d2(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d2(__NL(Contact_Secondary_Range_))),COUNT(__d2(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d2(__NL(Contact_State_))),COUNT(__d2(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d2(__NL(Contact_Z_I_P5_))),COUNT(__d2(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d2(__NL(Contact_S_S_N_))),COUNT(__d2(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d2(__NL(Contact_Phone_Number_))),COUNT(__d2(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d2(__NL(Contact_Score_))),COUNT(__d2(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d2(__NL(Contact_Type_))),COUNT(__d2(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d2(__NL(Contact_Email_))),COUNT(__d2(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d2(__NL(Contact_Email_Username_))),COUNT(__d2(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d2(__NL(Contact_Email_Domain_))),COUNT(__d2(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d2(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d2(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d2(__NL(Cortera_Link_I_D_))),COUNT(__d2(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d2(__NL(Contact_Job_Title_))),COUNT(__d2(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d2(__NL(Contact_Status_))),COUNT(__d2(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d2(__NL(Location_Corp_Hierarchy_))),COUNT(__d2(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d2(__NL(Company_Status_))),COUNT(__d2(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d2(__NL(Is_Closed_))),COUNT(__d2(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d2(__NL(Contact_Is_Executive_))),COUNT(__d2(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d2(__NL(Is_Contact_))),COUNT(__d2(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d2(__NL(Contact_Executive_Order_))),COUNT(__d2(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d2(__NL(Record_Status_))),COUNT(__d2(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d2(__NL(Equifax_I_D_))),COUNT(__d2(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d2(__NL(Is_Small_Business_Home_Office_))),COUNT(__d2(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d2(__NL(U_R_L_))),COUNT(__d2(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rawfields.emp_size',COUNT(__d2(__NL(Employee_Count_))),COUNT(__d2(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d2(__NL(Employee_Count_Code_))),COUNT(__d2(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d2(__NL(Financial_Amount_Figure_))),COUNT(__d2(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d2(__NL(Financial_Amount_Code_))),COUNT(__d2(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d2(__NL(Financial_Amount_Type_))),COUNT(__d2(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d2(__NL(Financial_Amount_Precision_))),COUNT(__d2(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d2(__NL(Is_Dead_))),COUNT(__d2(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d2(__NL(Date_Dead_))),COUNT(__d2(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d2(__NL(Associated_Addr_Commercial_))),COUNT(__d2(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d2(__NL(Associated_Addr_Residential_))),COUNT(__d2(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d2(__NL(General_Marketability_Score_))),COUNT(__d2(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d2(__NL(General_Marketability_Indicator_))),COUNT(__d2(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d2(__NL(Is_Vacant_))),COUNT(__d2(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d2(__NL(Is_Seasonal_))),COUNT(__d2(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d2(__NL(Is_Minority_Owned_))),COUNT(__d2(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d2(__NL(Is_Woman_Owned_))),COUNT(__d2(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d2(__NL(Is_Minority_Woman_Owned_))),COUNT(__d2(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d2(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d2(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d2(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d2(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d2(__NL(Is_Disadvantage_Owned_))),COUNT(__d2(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d2(__NL(Is_Veteran_Owned_))),COUNT(__d2(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d2(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d2(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d2(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d2(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d2(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d2(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d2(__NL(Is_Disabled_Owned_))),COUNT(__d2(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d2(__NL(Is_Hist_Black_College_))),COUNT(__d2(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d2(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d2(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d2(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d2(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d2(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d2(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d2(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d2(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d2(__NL(Is_S_B_E_))),COUNT(__d2(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d2(__NL(Is_Not_S_B_E_))),COUNT(__d2(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d2(__NL(Is_Goverment_))),COUNT(__d2(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d2(__NL(Is_Federal_Goverment_))),COUNT(__d2(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d2(__NL(Merchant_Type_))),COUNT(__d2(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d2(__NL(Process_Date_))),COUNT(__d2(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d2(__NL(Year_Established_))),COUNT(__d2(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d2(__NL(Public_Private_Indicator_))),COUNT(__d2(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d2(__NL(Business_Size_))),COUNT(__d2(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d2(__NL(Goverment_Type_))),COUNT(__d2(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d2(__NL(Is_Non_Profit_))),COUNT(__d2(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d2(__NL(Minority_Woman_Status_))),COUNT(__d2(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d2(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d2(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d2(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d2(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d2(__NL(Is_California_P_U_C_Certified_))),COUNT(__d2(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d2(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d2(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d2(__NL(Is_California_Caltrans_Certified_))),COUNT(__d2(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d2(__NL(Is_Educational_Institution_))),COUNT(__d2(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d2(__NL(Is_Minority_Institue_))),COUNT(__d2(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d2(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d2(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d2(__NL(Date_Last_Seen_Location_))),COUNT(__d2(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d2(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d2(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d2(__NL(Date_Closed_))),COUNT(__d2(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera__kfetch_LinkID_Invalid),COUNT(__d3)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d3(__NL(Ult_I_D_))),COUNT(__d3(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d3(__NL(Org_I_D_))),COUNT(__d3(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d3(__NL(Sele_I_D_))),COUNT(__d3(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d3(__NL(Prox_I_D_))),COUNT(__d3(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d3(__NL(Prox_Sele_))),COUNT(__d3(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d3(__NL(Parent_Prox_I_D_))),COUNT(__d3(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d3(__NL(Sele_Prox_I_D_))),COUNT(__d3(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d3(__NL(Org_Prox_I_D_))),COUNT(__d3(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d3(__NL(Ult_Prox_I_D_))),COUNT(__d3(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d3(__NL(Levels_From_Top_))),COUNT(__d3(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d3(__NL(Nodes_Below_))),COUNT(__d3(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d3(__NL(Prox_Segment_))),COUNT(__d3(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d3(__NL(Store_Number_))),COUNT(__d3(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d3(__NL(Active_Duns_Number_))),COUNT(__d3(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d3(__NL(Hist_Duns_Number_))),COUNT(__d3(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d3(__NL(Deleted_Key_))),COUNT(__d3(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d3(__NL(D_U_N_S_Number_))),COUNT(__d3(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d3(__NL(Name_))),COUNT(__d3(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d3(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d3(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d3(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d3(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d3(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d3(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d3(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d3(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d3(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d3(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d3(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d3(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d3(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d3(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d3(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d3(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d3(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d3(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d3(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d3(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d3(__NL(O_S_H_A_Union_Flag_))),COUNT(__d3(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d3(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d3(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d3(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d3(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d3(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d3(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d3(__NL(O_S_H_A_Total_Violations_))),COUNT(__d3(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d3(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d3(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d3(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d3(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d3(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d3(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d3(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d3(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d3(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d3(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d3(__NL(O_S_H_A_Owner_Type_))),COUNT(__d3(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d3(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d3(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d3(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d3(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d3(__NL(Best_Company_Name_))),COUNT(__d3(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d3(__NL(Best_Company_Name_Rank_))),COUNT(__d3(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d3(__NL(Best_S_I_C_Code_))),COUNT(__d3(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d3(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d3(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d3(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d3(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d3(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d3(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d3(__NL(Corporation_Code_))),COUNT(__d3(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d3(__NL(Contact_First_Name_))),COUNT(__d3(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d3(__NL(Contact_Middle_Name_))),COUNT(__d3(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d3(__NL(Contact_Last_Name_))),COUNT(__d3(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d3(__NL(Contact_Name_Suffix_))),COUNT(__d3(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d3(__NL(Contact_Primary_Range_))),COUNT(__d3(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d3(__NL(Contact_Predirectional_))),COUNT(__d3(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d3(__NL(Contact_Primary_Name_))),COUNT(__d3(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d3(__NL(Contact_Suffix_))),COUNT(__d3(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d3(__NL(Contact_Postdirectional_))),COUNT(__d3(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d3(__NL(Contact_Secondary_Range_))),COUNT(__d3(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d3(__NL(Contact_State_))),COUNT(__d3(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d3(__NL(Contact_Z_I_P5_))),COUNT(__d3(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d3(__NL(Contact_S_S_N_))),COUNT(__d3(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d3(__NL(Contact_Phone_Number_))),COUNT(__d3(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d3(__NL(Contact_Score_))),COUNT(__d3(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d3(__NL(Contact_Type_))),COUNT(__d3(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d3(__NL(Contact_Email_))),COUNT(__d3(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d3(__NL(Contact_Email_Username_))),COUNT(__d3(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d3(__NL(Contact_Email_Domain_))),COUNT(__d3(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultimate_linkid',COUNT(__d3(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d3(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','link_id',COUNT(__d3(__NL(Cortera_Link_I_D_))),COUNT(__d3(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d3(__NL(Contact_Job_Title_))),COUNT(__d3(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d3(__NL(Contact_Status_))),COUNT(__d3(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','position_type',COUNT(__d3(__NL(Location_Corp_Hierarchy_))),COUNT(__d3(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','status',COUNT(__d3(__NL(Company_Status_))),COUNT(__d3(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_closed',COUNT(__d3(__NL(Is_Closed_))),COUNT(__d3(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d3(__NL(Contact_Is_Executive_))),COUNT(__d3(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d3(__NL(Is_Contact_))),COUNT(__d3(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d3(__NL(Contact_Executive_Order_))),COUNT(__d3(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d3(__NL(Record_Status_))),COUNT(__d3(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d3(__NL(Equifax_I_D_))),COUNT(__d3(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d3(__NL(Is_Small_Business_Home_Office_))),COUNT(__d3(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d3(__NL(U_R_L_))),COUNT(__d3(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d3(__NL(Employee_Count_))),COUNT(__d3(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d3(__NL(Employee_Count_Code_))),COUNT(__d3(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d3(__NL(Financial_Amount_Figure_))),COUNT(__d3(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d3(__NL(Financial_Amount_Code_))),COUNT(__d3(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d3(__NL(Financial_Amount_Type_))),COUNT(__d3(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d3(__NL(Financial_Amount_Precision_))),COUNT(__d3(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d3(__NL(Is_Dead_))),COUNT(__d3(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d3(__NL(Date_Dead_))),COUNT(__d3(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d3(__NL(Associated_Addr_Commercial_))),COUNT(__d3(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d3(__NL(Associated_Addr_Residential_))),COUNT(__d3(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d3(__NL(General_Marketability_Score_))),COUNT(__d3(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d3(__NL(General_Marketability_Indicator_))),COUNT(__d3(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d3(__NL(Is_Vacant_))),COUNT(__d3(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d3(__NL(Is_Seasonal_))),COUNT(__d3(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d3(__NL(Is_Minority_Owned_))),COUNT(__d3(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d3(__NL(Is_Woman_Owned_))),COUNT(__d3(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d3(__NL(Is_Minority_Woman_Owned_))),COUNT(__d3(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d3(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d3(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d3(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d3(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d3(__NL(Is_Disadvantage_Owned_))),COUNT(__d3(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d3(__NL(Is_Veteran_Owned_))),COUNT(__d3(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d3(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d3(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d3(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d3(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d3(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d3(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d3(__NL(Is_Disabled_Owned_))),COUNT(__d3(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d3(__NL(Is_Hist_Black_College_))),COUNT(__d3(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d3(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d3(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d3(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d3(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d3(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d3(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d3(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d3(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d3(__NL(Is_S_B_E_))),COUNT(__d3(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d3(__NL(Is_Not_S_B_E_))),COUNT(__d3(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d3(__NL(Is_Goverment_))),COUNT(__d3(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d3(__NL(Is_Federal_Goverment_))),COUNT(__d3(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d3(__NL(Merchant_Type_))),COUNT(__d3(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d3(__NL(Process_Date_))),COUNT(__d3(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d3(__NL(Year_Established_))),COUNT(__d3(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d3(__NL(Public_Private_Indicator_))),COUNT(__d3(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d3(__NL(Business_Size_))),COUNT(__d3(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d3(__NL(Goverment_Type_))),COUNT(__d3(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d3(__NL(Is_Non_Profit_))),COUNT(__d3(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d3(__NL(Minority_Woman_Status_))),COUNT(__d3(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d3(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d3(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d3(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d3(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d3(__NL(Is_California_P_U_C_Certified_))),COUNT(__d3(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d3(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d3(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d3(__NL(Is_California_Caltrans_Certified_))),COUNT(__d3(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d3(__NL(Is_Educational_Institution_))),COUNT(__d3(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d3(__NL(Is_Minority_Institue_))),COUNT(__d3(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d3(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d3(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','loc_date_last_seen',COUNT(__d3(__NL(Date_Last_Seen_Location_))),COUNT(__d3(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d3(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d3(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','closed_date',COUNT(__d3(__NL(Date_Closed_))),COUNT(__d3(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_EBR_kfetch_5600_Demographic_Data_linkids_Invalid),COUNT(__d4)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d4(__NL(Ult_I_D_))),COUNT(__d4(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d4(__NL(Org_I_D_))),COUNT(__d4(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d4(__NL(Sele_I_D_))),COUNT(__d4(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d4(__NL(Prox_I_D_))),COUNT(__d4(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d4(__NL(Prox_Sele_))),COUNT(__d4(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d4(__NL(Parent_Prox_I_D_))),COUNT(__d4(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d4(__NL(Sele_Prox_I_D_))),COUNT(__d4(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d4(__NL(Org_Prox_I_D_))),COUNT(__d4(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d4(__NL(Ult_Prox_I_D_))),COUNT(__d4(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d4(__NL(Levels_From_Top_))),COUNT(__d4(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d4(__NL(Nodes_Below_))),COUNT(__d4(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d4(__NL(Prox_Segment_))),COUNT(__d4(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d4(__NL(Store_Number_))),COUNT(__d4(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d4(__NL(Active_Duns_Number_))),COUNT(__d4(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d4(__NL(Hist_Duns_Number_))),COUNT(__d4(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d4(__NL(Deleted_Key_))),COUNT(__d4(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d4(__NL(D_U_N_S_Number_))),COUNT(__d4(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d4(__NL(Name_))),COUNT(__d4(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d4(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d4(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d4(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d4(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d4(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d4(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d4(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d4(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d4(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d4(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d4(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d4(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d4(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d4(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d4(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d4(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d4(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d4(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d4(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d4(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d4(__NL(O_S_H_A_Union_Flag_))),COUNT(__d4(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d4(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d4(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d4(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d4(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d4(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d4(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d4(__NL(O_S_H_A_Total_Violations_))),COUNT(__d4(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d4(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d4(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d4(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d4(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d4(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d4(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d4(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d4(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d4(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d4(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d4(__NL(O_S_H_A_Owner_Type_))),COUNT(__d4(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d4(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d4(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d4(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d4(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d4(__NL(Best_Company_Name_))),COUNT(__d4(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d4(__NL(Best_Company_Name_Rank_))),COUNT(__d4(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d4(__NL(Best_S_I_C_Code_))),COUNT(__d4(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d4(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d4(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d4(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d4(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d4(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d4(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d4(__NL(Corporation_Code_))),COUNT(__d4(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d4(__NL(Contact_First_Name_))),COUNT(__d4(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d4(__NL(Contact_Middle_Name_))),COUNT(__d4(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d4(__NL(Contact_Last_Name_))),COUNT(__d4(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d4(__NL(Contact_Name_Suffix_))),COUNT(__d4(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d4(__NL(Contact_Primary_Range_))),COUNT(__d4(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d4(__NL(Contact_Predirectional_))),COUNT(__d4(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d4(__NL(Contact_Primary_Name_))),COUNT(__d4(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d4(__NL(Contact_Suffix_))),COUNT(__d4(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d4(__NL(Contact_Postdirectional_))),COUNT(__d4(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d4(__NL(Contact_Secondary_Range_))),COUNT(__d4(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d4(__NL(Contact_State_))),COUNT(__d4(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d4(__NL(Contact_Z_I_P5_))),COUNT(__d4(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d4(__NL(Contact_S_S_N_))),COUNT(__d4(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d4(__NL(Contact_Phone_Number_))),COUNT(__d4(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d4(__NL(Contact_Score_))),COUNT(__d4(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d4(__NL(Contact_Type_))),COUNT(__d4(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d4(__NL(Contact_Email_))),COUNT(__d4(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d4(__NL(Contact_Email_Username_))),COUNT(__d4(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d4(__NL(Contact_Email_Domain_))),COUNT(__d4(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d4(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d4(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d4(__NL(Cortera_Link_I_D_))),COUNT(__d4(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d4(__NL(Contact_Job_Title_))),COUNT(__d4(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d4(__NL(Contact_Status_))),COUNT(__d4(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','location_code',COUNT(__d4(__NL(Location_Corp_Hierarchy_))),COUNT(__d4(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d4(__NL(Company_Status_))),COUNT(__d4(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d4(__NL(Is_Closed_))),COUNT(__d4(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d4(__NL(Contact_Is_Executive_))),COUNT(__d4(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d4(__NL(Is_Contact_))),COUNT(__d4(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d4(__NL(Contact_Executive_Order_))),COUNT(__d4(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d4(__NL(Record_Status_))),COUNT(__d4(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d4(__NL(Equifax_I_D_))),COUNT(__d4(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d4(__NL(Is_Small_Business_Home_Office_))),COUNT(__d4(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d4(__NL(U_R_L_))),COUNT(__d4(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d4(__NL(Employee_Count_))),COUNT(__d4(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d4(__NL(Employee_Count_Code_))),COUNT(__d4(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d4(__NL(Financial_Amount_Figure_))),COUNT(__d4(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d4(__NL(Financial_Amount_Code_))),COUNT(__d4(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d4(__NL(Financial_Amount_Type_))),COUNT(__d4(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d4(__NL(Financial_Amount_Precision_))),COUNT(__d4(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d4(__NL(Is_Dead_))),COUNT(__d4(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d4(__NL(Date_Dead_))),COUNT(__d4(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d4(__NL(Associated_Addr_Commercial_))),COUNT(__d4(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d4(__NL(Associated_Addr_Residential_))),COUNT(__d4(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d4(__NL(General_Marketability_Score_))),COUNT(__d4(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d4(__NL(General_Marketability_Indicator_))),COUNT(__d4(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d4(__NL(Is_Vacant_))),COUNT(__d4(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d4(__NL(Is_Seasonal_))),COUNT(__d4(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d4(__NL(Is_Minority_Owned_))),COUNT(__d4(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d4(__NL(Is_Woman_Owned_))),COUNT(__d4(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d4(__NL(Is_Minority_Woman_Owned_))),COUNT(__d4(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d4(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d4(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d4(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d4(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d4(__NL(Is_Disadvantage_Owned_))),COUNT(__d4(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d4(__NL(Is_Veteran_Owned_))),COUNT(__d4(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d4(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d4(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d4(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d4(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d4(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d4(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d4(__NL(Is_Disabled_Owned_))),COUNT(__d4(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d4(__NL(Is_Hist_Black_College_))),COUNT(__d4(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d4(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d4(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d4(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d4(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d4(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d4(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d4(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d4(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d4(__NL(Is_S_B_E_))),COUNT(__d4(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d4(__NL(Is_Not_S_B_E_))),COUNT(__d4(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d4(__NL(Is_Goverment_))),COUNT(__d4(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d4(__NL(Is_Federal_Goverment_))),COUNT(__d4(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d4(__NL(Merchant_Type_))),COUNT(__d4(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d4(__NL(Process_Date_))),COUNT(__d4(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d4(__NL(Year_Established_))),COUNT(__d4(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d4(__NL(Public_Private_Indicator_))),COUNT(__d4(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d4(__NL(Business_Size_))),COUNT(__d4(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d4(__NL(Goverment_Type_))),COUNT(__d4(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d4(__NL(Is_Non_Profit_))),COUNT(__d4(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d4(__NL(Minority_Woman_Status_))),COUNT(__d4(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d4(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d4(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d4(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d4(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d4(__NL(Is_California_P_U_C_Certified_))),COUNT(__d4(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d4(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d4(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d4(__NL(Is_California_Caltrans_Certified_))),COUNT(__d4(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d4(__NL(Is_Educational_Institution_))),COUNT(__d4(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d4(__NL(Is_Minority_Institue_))),COUNT(__d4(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d4(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d4(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d4(__NL(Date_Last_Seen_Location_))),COUNT(__d4(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d4(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d4(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d4(__NL(Date_Closed_))),COUNT(__d4(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_OSHAIR__kfetch_OSHAIR_LinkIds_Invalid),COUNT(__d5)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d5(__NL(Ult_I_D_))),COUNT(__d5(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d5(__NL(Org_I_D_))),COUNT(__d5(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d5(__NL(Sele_I_D_))),COUNT(__d5(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d5(__NL(Prox_I_D_))),COUNT(__d5(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d5(__NL(Prox_Sele_))),COUNT(__d5(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d5(__NL(Parent_Prox_I_D_))),COUNT(__d5(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d5(__NL(Sele_Prox_I_D_))),COUNT(__d5(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d5(__NL(Org_Prox_I_D_))),COUNT(__d5(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d5(__NL(Ult_Prox_I_D_))),COUNT(__d5(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d5(__NL(Levels_From_Top_))),COUNT(__d5(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d5(__NL(Nodes_Below_))),COUNT(__d5(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d5(__NL(Prox_Segment_))),COUNT(__d5(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d5(__NL(Store_Number_))),COUNT(__d5(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d5(__NL(Active_Duns_Number_))),COUNT(__d5(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d5(__NL(Hist_Duns_Number_))),COUNT(__d5(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d5(__NL(Deleted_Key_))),COUNT(__d5(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','duns_number',COUNT(__d5(__NL(D_U_N_S_Number_))),COUNT(__d5(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d5(__NL(Name_))),COUNT(__d5(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','previous_activity_type',COUNT(__d5(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d5(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prev_activity_type_desc',COUNT(__d5(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d5(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','advance_notice_flag',COUNT(__d5(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d5(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inspection_opening_date',COUNT(__d5(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d5(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inspection_close_date',COUNT(__d5(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d5(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','safety_health_flag',COUNT(__d5(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d5(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inspection_type',COUNT(__d5(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d5(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inspection_scope',COUNT(__d5(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d5(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','walk_around_flag',COUNT(__d5(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d5(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','employees_interviewed_flag',COUNT(__d5(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d5(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','union_flag',COUNT(__d5(__NL(O_S_H_A_Union_Flag_))),COUNT(__d5(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','closed_case_flag',COUNT(__d5(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d5(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','why_no_inspection_code',COUNT(__d5(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d5(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inspection_type_code',COUNT(__d5(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d5(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','total_violations',COUNT(__d5(__NL(O_S_H_A_Total_Violations_))),COUNT(__d5(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','total_serious_violations',COUNT(__d5(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d5(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','number_violations',COUNT(__d5(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d5(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','number_event',COUNT(__d5(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d5(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','number_hazardous_substance',COUNT(__d5(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d5(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','number_accident',COUNT(__d5(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d5(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owner_type',COUNT(__d5(__NL(O_S_H_A_Owner_Type_))),COUNT(__d5(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','own_type_desc',COUNT(__d5(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d5(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','number_in_establishment',COUNT(__d5(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d5(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d5(__NL(Best_Company_Name_))),COUNT(__d5(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d5(__NL(Best_Company_Name_Rank_))),COUNT(__d5(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d5(__NL(Best_S_I_C_Code_))),COUNT(__d5(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d5(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d5(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d5(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d5(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d5(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d5(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d5(__NL(Corporation_Code_))),COUNT(__d5(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d5(__NL(Contact_First_Name_))),COUNT(__d5(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d5(__NL(Contact_Middle_Name_))),COUNT(__d5(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d5(__NL(Contact_Last_Name_))),COUNT(__d5(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d5(__NL(Contact_Name_Suffix_))),COUNT(__d5(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d5(__NL(Contact_Primary_Range_))),COUNT(__d5(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d5(__NL(Contact_Predirectional_))),COUNT(__d5(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d5(__NL(Contact_Primary_Name_))),COUNT(__d5(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d5(__NL(Contact_Suffix_))),COUNT(__d5(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d5(__NL(Contact_Postdirectional_))),COUNT(__d5(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d5(__NL(Contact_Secondary_Range_))),COUNT(__d5(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d5(__NL(Contact_State_))),COUNT(__d5(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d5(__NL(Contact_Z_I_P5_))),COUNT(__d5(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d5(__NL(Contact_S_S_N_))),COUNT(__d5(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d5(__NL(Contact_Phone_Number_))),COUNT(__d5(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d5(__NL(Contact_Score_))),COUNT(__d5(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d5(__NL(Contact_Type_))),COUNT(__d5(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d5(__NL(Contact_Email_))),COUNT(__d5(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d5(__NL(Contact_Email_Username_))),COUNT(__d5(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d5(__NL(Contact_Email_Domain_))),COUNT(__d5(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d5(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d5(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d5(__NL(Cortera_Link_I_D_))),COUNT(__d5(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d5(__NL(Contact_Job_Title_))),COUNT(__d5(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d5(__NL(Contact_Status_))),COUNT(__d5(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d5(__NL(Location_Corp_Hierarchy_))),COUNT(__d5(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d5(__NL(Company_Status_))),COUNT(__d5(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d5(__NL(Is_Closed_))),COUNT(__d5(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d5(__NL(Contact_Is_Executive_))),COUNT(__d5(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d5(__NL(Is_Contact_))),COUNT(__d5(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d5(__NL(Contact_Executive_Order_))),COUNT(__d5(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d5(__NL(Record_Status_))),COUNT(__d5(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d5(__NL(Equifax_I_D_))),COUNT(__d5(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d5(__NL(Is_Small_Business_Home_Office_))),COUNT(__d5(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d5(__NL(U_R_L_))),COUNT(__d5(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d5(__NL(Employee_Count_))),COUNT(__d5(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d5(__NL(Employee_Count_Code_))),COUNT(__d5(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d5(__NL(Financial_Amount_Figure_))),COUNT(__d5(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d5(__NL(Financial_Amount_Code_))),COUNT(__d5(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d5(__NL(Financial_Amount_Type_))),COUNT(__d5(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d5(__NL(Financial_Amount_Precision_))),COUNT(__d5(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d5(__NL(Is_Dead_))),COUNT(__d5(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d5(__NL(Date_Dead_))),COUNT(__d5(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d5(__NL(Associated_Addr_Commercial_))),COUNT(__d5(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d5(__NL(Associated_Addr_Residential_))),COUNT(__d5(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d5(__NL(General_Marketability_Score_))),COUNT(__d5(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d5(__NL(General_Marketability_Indicator_))),COUNT(__d5(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d5(__NL(Is_Vacant_))),COUNT(__d5(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d5(__NL(Is_Seasonal_))),COUNT(__d5(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d5(__NL(Is_Minority_Owned_))),COUNT(__d5(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d5(__NL(Is_Woman_Owned_))),COUNT(__d5(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d5(__NL(Is_Minority_Woman_Owned_))),COUNT(__d5(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d5(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d5(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d5(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d5(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d5(__NL(Is_Disadvantage_Owned_))),COUNT(__d5(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d5(__NL(Is_Veteran_Owned_))),COUNT(__d5(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d5(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d5(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d5(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d5(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d5(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d5(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d5(__NL(Is_Disabled_Owned_))),COUNT(__d5(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d5(__NL(Is_Hist_Black_College_))),COUNT(__d5(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d5(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d5(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d5(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d5(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d5(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d5(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d5(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d5(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d5(__NL(Is_S_B_E_))),COUNT(__d5(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d5(__NL(Is_Not_S_B_E_))),COUNT(__d5(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d5(__NL(Is_Goverment_))),COUNT(__d5(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d5(__NL(Is_Federal_Goverment_))),COUNT(__d5(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d5(__NL(Merchant_Type_))),COUNT(__d5(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d5(__NL(Process_Date_))),COUNT(__d5(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d5(__NL(Year_Established_))),COUNT(__d5(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d5(__NL(Public_Private_Indicator_))),COUNT(__d5(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d5(__NL(Business_Size_))),COUNT(__d5(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d5(__NL(Goverment_Type_))),COUNT(__d5(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d5(__NL(Is_Non_Profit_))),COUNT(__d5(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d5(__NL(Minority_Woman_Status_))),COUNT(__d5(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d5(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d5(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d5(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d5(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d5(__NL(Is_California_P_U_C_Certified_))),COUNT(__d5(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d5(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d5(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d5(__NL(Is_California_Caltrans_Certified_))),COUNT(__d5(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d5(__NL(Is_Educational_Institution_))),COUNT(__d5(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d5(__NL(Is_Minority_Institue_))),COUNT(__d5(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d5(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d5(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d5(__NL(Date_Last_Seen_Location_))),COUNT(__d5(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d5(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d5(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d5(__NL(Date_Closed_))),COUNT(__d5(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid),COUNT(__d6)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d6(__NL(Ult_I_D_))),COUNT(__d6(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d6(__NL(Org_I_D_))),COUNT(__d6(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d6(__NL(Sele_I_D_))),COUNT(__d6(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d6(__NL(Prox_I_D_))),COUNT(__d6(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d6(__NL(Prox_Sele_))),COUNT(__d6(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d6(__NL(Parent_Prox_I_D_))),COUNT(__d6(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d6(__NL(Sele_Prox_I_D_))),COUNT(__d6(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d6(__NL(Org_Prox_I_D_))),COUNT(__d6(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d6(__NL(Ult_Prox_I_D_))),COUNT(__d6(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d6(__NL(Levels_From_Top_))),COUNT(__d6(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d6(__NL(Nodes_Below_))),COUNT(__d6(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d6(__NL(Prox_Segment_))),COUNT(__d6(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d6(__NL(Store_Number_))),COUNT(__d6(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d6(__NL(Active_Duns_Number_))),COUNT(__d6(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d6(__NL(Hist_Duns_Number_))),COUNT(__d6(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d6(__NL(Deleted_Key_))),COUNT(__d6(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d6(__NL(D_U_N_S_Number_))),COUNT(__d6(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d6(__NL(Name_))),COUNT(__d6(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d6(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d6(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d6(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d6(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d6(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d6(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d6(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d6(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d6(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d6(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d6(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d6(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d6(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d6(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d6(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d6(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d6(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d6(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d6(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d6(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d6(__NL(O_S_H_A_Union_Flag_))),COUNT(__d6(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d6(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d6(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d6(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d6(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d6(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d6(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d6(__NL(O_S_H_A_Total_Violations_))),COUNT(__d6(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d6(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d6(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d6(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d6(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d6(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d6(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d6(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d6(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d6(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d6(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d6(__NL(O_S_H_A_Owner_Type_))),COUNT(__d6(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d6(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d6(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d6(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d6(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d6(__NL(Best_Company_Name_))),COUNT(__d6(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d6(__NL(Best_Company_Name_Rank_))),COUNT(__d6(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d6(__NL(Best_S_I_C_Code_))),COUNT(__d6(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d6(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d6(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d6(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d6(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d6(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d6(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d6(__NL(Corporation_Code_))),COUNT(__d6(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d6(__NL(Contact_First_Name_))),COUNT(__d6(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d6(__NL(Contact_Middle_Name_))),COUNT(__d6(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d6(__NL(Contact_Last_Name_))),COUNT(__d6(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d6(__NL(Contact_Name_Suffix_))),COUNT(__d6(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d6(__NL(Contact_Primary_Range_))),COUNT(__d6(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d6(__NL(Contact_Predirectional_))),COUNT(__d6(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d6(__NL(Contact_Primary_Name_))),COUNT(__d6(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d6(__NL(Contact_Suffix_))),COUNT(__d6(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d6(__NL(Contact_Postdirectional_))),COUNT(__d6(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d6(__NL(Contact_Secondary_Range_))),COUNT(__d6(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d6(__NL(Contact_State_))),COUNT(__d6(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d6(__NL(Contact_Z_I_P5_))),COUNT(__d6(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d6(__NL(Contact_S_S_N_))),COUNT(__d6(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d6(__NL(Contact_Phone_Number_))),COUNT(__d6(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d6(__NL(Contact_Score_))),COUNT(__d6(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d6(__NL(Contact_Type_))),COUNT(__d6(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d6(__NL(Contact_Email_))),COUNT(__d6(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d6(__NL(Contact_Email_Username_))),COUNT(__d6(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d6(__NL(Contact_Email_Domain_))),COUNT(__d6(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d6(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d6(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d6(__NL(Cortera_Link_I_D_))),COUNT(__d6(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d6(__NL(Contact_Job_Title_))),COUNT(__d6(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d6(__NL(Contact_Status_))),COUNT(__d6(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d6(__NL(Location_Corp_Hierarchy_))),COUNT(__d6(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d6(__NL(Company_Status_))),COUNT(__d6(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d6(__NL(Is_Closed_))),COUNT(__d6(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d6(__NL(Contact_Is_Executive_))),COUNT(__d6(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d6(__NL(Is_Contact_))),COUNT(__d6(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d6(__NL(Contact_Executive_Order_))),COUNT(__d6(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d6(__NL(Record_Status_))),COUNT(__d6(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_id',COUNT(__d6(__NL(Equifax_I_D_))),COUNT(__d6(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_soho',COUNT(__d6(__NL(Is_Small_Business_Home_Office_))),COUNT(__d6(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_web',COUNT(__d6(__NL(U_R_L_))),COUNT(__d6(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_locempcnt',COUNT(__d6(__NL(Employee_Count_))),COUNT(__d6(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_locempcd',COUNT(__d6(__NL(Employee_Count_Code_))),COUNT(__d6(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_locamount',COUNT(__d6(__NL(Financial_Amount_Figure_))),COUNT(__d6(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_locamountcd',COUNT(__d6(__NL(Financial_Amount_Code_))),COUNT(__d6(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_locamounttp',COUNT(__d6(__NL(Financial_Amount_Type_))),COUNT(__d6(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_locamountprec',COUNT(__d6(__NL(Financial_Amount_Precision_))),COUNT(__d6(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_dead',COUNT(__d6(__NL(Is_Dead_))),COUNT(__d6(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_deaddt',COUNT(__d6(__NL(Date_Dead_))),COUNT(__d6(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_BIZ',COUNT(__d6(__NL(Associated_Addr_Commercial_))),COUNT(__d6(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_RES',COUNT(__d6(__NL(Associated_Addr_Residential_))),COUNT(__d6(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_totalscore',COUNT(__d6(__NL(General_Marketability_Score_))),COUNT(__d6(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_totalind',COUNT(__d6(__NL(General_Marketability_Indicator_))),COUNT(__d6(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_vacant',COUNT(__d6(__NL(Is_Vacant_))),COUNT(__d6(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_seasonal',COUNT(__d6(__NL(Is_Seasonal_))),COUNT(__d6(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mbe',COUNT(__d6(__NL(Is_Minority_Owned_))),COUNT(__d6(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_wbe',COUNT(__d6(__NL(Is_Woman_Owned_))),COUNT(__d6(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mwbe',COUNT(__d6(__NL(Is_Minority_Woman_Owned_))),COUNT(__d6(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_sdb',COUNT(__d6(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d6(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_hubzone',COUNT(__d6(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d6(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_dbe',COUNT(__d6(__NL(Is_Disadvantage_Owned_))),COUNT(__d6(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_vet',COUNT(__d6(__NL(Is_Veteran_Owned_))),COUNT(__d6(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_dvet',COUNT(__d6(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d6(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_8a',COUNT(__d6(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d6(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_8aexpdt',COUNT(__d6(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d6(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_dis',COUNT(__d6(__NL(Is_Disabled_Owned_))),COUNT(__d6(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_hbcu',COUNT(__d6(__NL(Is_Hist_Black_College_))),COUNT(__d6(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_gaylesbian',COUNT(__d6(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d6(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_wsbe',COUNT(__d6(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d6(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_vsbe',COUNT(__d6(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d6(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_dvsbe',COUNT(__d6(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d6(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_sbe',COUNT(__d6(__NL(Is_S_B_E_))),COUNT(__d6(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_lbe',COUNT(__d6(__NL(Is_Not_S_B_E_))),COUNT(__d6(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_gov',COUNT(__d6(__NL(Is_Goverment_))),COUNT(__d6(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_fgov',COUNT(__d6(__NL(Is_Federal_Goverment_))),COUNT(__d6(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_merctype',COUNT(__d6(__NL(Merchant_Type_))),COUNT(__d6(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d6(__NL(Process_Date_))),COUNT(__d6(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_YREST',COUNT(__d6(__NL(Year_Established_))),COUNT(__d6(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_PUBLIC',COUNT(__d6(__NL(Public_Private_Indicator_))),COUNT(__d6(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_BUSSIZE',COUNT(__d6(__NL(Business_Size_))),COUNT(__d6(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_GOV1057',COUNT(__d6(__NL(Goverment_Type_))),COUNT(__d6(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_NONPROFIT',COUNT(__d6(__NL(Is_Non_Profit_))),COUNT(__d6(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_MWBESTATUS',COUNT(__d6(__NL(Minority_Woman_Status_))),COUNT(__d6(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_NMSDC',COUNT(__d6(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d6(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_WBENC',COUNT(__d6(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d6(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_CA_PUC',COUNT(__d6(__NL(Is_California_P_U_C_Certified_))),COUNT(__d6(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_TX_HUB',COUNT(__d6(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d6(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_CALTRANS',COUNT(__d6(__NL(Is_California_Caltrans_Certified_))),COUNT(__d6(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_EDU',COUNT(__d6(__NL(Is_Educational_Institution_))),COUNT(__d6(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_MI',COUNT(__d6(__NL(Is_Minority_Institue_))),COUNT(__d6(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EFX_ANC',COUNT(__d6(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d6(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d6(__NL(Date_Last_Seen_Location_))),COUNT(__d6(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d6(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d6(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d6(__NL(Date_Closed_))),COUNT(__d6(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_1_Invalid),COUNT(__d7)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d7(__NL(Ult_I_D_))),COUNT(__d7(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d7(__NL(Org_I_D_))),COUNT(__d7(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d7(__NL(Sele_I_D_))),COUNT(__d7(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d7(__NL(Prox_I_D_))),COUNT(__d7(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d7(__NL(Prox_Sele_))),COUNT(__d7(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d7(__NL(Parent_Prox_I_D_))),COUNT(__d7(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d7(__NL(Sele_Prox_I_D_))),COUNT(__d7(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d7(__NL(Org_Prox_I_D_))),COUNT(__d7(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d7(__NL(Ult_Prox_I_D_))),COUNT(__d7(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d7(__NL(Levels_From_Top_))),COUNT(__d7(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d7(__NL(Nodes_Below_))),COUNT(__d7(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d7(__NL(Prox_Segment_))),COUNT(__d7(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d7(__NL(Store_Number_))),COUNT(__d7(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d7(__NL(Active_Duns_Number_))),COUNT(__d7(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d7(__NL(Hist_Duns_Number_))),COUNT(__d7(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d7(__NL(Deleted_Key_))),COUNT(__d7(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d7(__NL(D_U_N_S_Number_))),COUNT(__d7(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d7(__NL(Name_))),COUNT(__d7(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d7(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d7(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d7(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d7(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d7(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d7(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d7(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d7(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d7(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d7(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d7(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d7(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d7(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d7(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d7(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d7(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d7(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d7(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d7(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d7(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d7(__NL(O_S_H_A_Union_Flag_))),COUNT(__d7(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d7(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d7(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d7(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d7(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d7(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d7(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d7(__NL(O_S_H_A_Total_Violations_))),COUNT(__d7(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d7(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d7(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d7(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d7(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d7(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d7(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d7(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d7(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d7(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d7(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d7(__NL(O_S_H_A_Owner_Type_))),COUNT(__d7(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d7(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d7(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d7(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d7(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d7(__NL(Best_Company_Name_))),COUNT(__d7(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d7(__NL(Best_Company_Name_Rank_))),COUNT(__d7(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d7(__NL(Best_S_I_C_Code_))),COUNT(__d7(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d7(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d7(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d7(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d7(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d7(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d7(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d7(__NL(Corporation_Code_))),COUNT(__d7(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.fname',COUNT(__d7(__NL(Contact_First_Name_))),COUNT(__d7(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.mname',COUNT(__d7(__NL(Contact_Middle_Name_))),COUNT(__d7(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.lname',COUNT(__d7(__NL(Contact_Last_Name_))),COUNT(__d7(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.name_suffix',COUNT(__d7(__NL(Contact_Name_Suffix_))),COUNT(__d7(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d7(__NL(Contact_Primary_Range_))),COUNT(__d7(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d7(__NL(Contact_Predirectional_))),COUNT(__d7(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d7(__NL(Contact_Primary_Name_))),COUNT(__d7(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d7(__NL(Contact_Suffix_))),COUNT(__d7(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d7(__NL(Contact_Postdirectional_))),COUNT(__d7(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d7(__NL(Contact_Secondary_Range_))),COUNT(__d7(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d7(__NL(Contact_State_))),COUNT(__d7(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d7(__NL(Contact_Z_I_P5_))),COUNT(__d7(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_ssn',COUNT(__d7(__NL(Contact_S_S_N_))),COUNT(__d7(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_phone',COUNT(__d7(__NL(Contact_Phone_Number_))),COUNT(__d7(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_score',COUNT(__d7(__NL(Contact_Score_))),COUNT(__d7(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_type_derived',COUNT(__d7(__NL(Contact_Type_))),COUNT(__d7(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email',COUNT(__d7(__NL(Contact_Email_))),COUNT(__d7(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_username',COUNT(__d7(__NL(Contact_Email_Username_))),COUNT(__d7(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_domain',COUNT(__d7(__NL(Contact_Email_Domain_))),COUNT(__d7(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d7(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d7(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d7(__NL(Cortera_Link_I_D_))),COUNT(__d7(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JobTitle',COUNT(__d7(__NL(Contact_Job_Title_))),COUNT(__d7(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Status',COUNT(__d7(__NL(Contact_Status_))),COUNT(__d7(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d7(__NL(Location_Corp_Hierarchy_))),COUNT(__d7(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d7(__NL(Company_Status_))),COUNT(__d7(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d7(__NL(Is_Closed_))),COUNT(__d7(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind',COUNT(__d7(__NL(Contact_Is_Executive_))),COUNT(__d7(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind_order',COUNT(__d7(__NL(Contact_Executive_Order_))),COUNT(__d7(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d7(__NL(Record_Status_))),COUNT(__d7(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d7(__NL(Equifax_I_D_))),COUNT(__d7(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d7(__NL(Is_Small_Business_Home_Office_))),COUNT(__d7(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d7(__NL(U_R_L_))),COUNT(__d7(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d7(__NL(Employee_Count_))),COUNT(__d7(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d7(__NL(Employee_Count_Code_))),COUNT(__d7(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d7(__NL(Financial_Amount_Figure_))),COUNT(__d7(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d7(__NL(Financial_Amount_Code_))),COUNT(__d7(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d7(__NL(Financial_Amount_Type_))),COUNT(__d7(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d7(__NL(Financial_Amount_Precision_))),COUNT(__d7(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d7(__NL(Is_Dead_))),COUNT(__d7(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d7(__NL(Date_Dead_))),COUNT(__d7(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d7(__NL(Associated_Addr_Commercial_))),COUNT(__d7(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d7(__NL(Associated_Addr_Residential_))),COUNT(__d7(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d7(__NL(General_Marketability_Score_))),COUNT(__d7(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d7(__NL(General_Marketability_Indicator_))),COUNT(__d7(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d7(__NL(Is_Vacant_))),COUNT(__d7(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d7(__NL(Is_Seasonal_))),COUNT(__d7(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d7(__NL(Is_Minority_Owned_))),COUNT(__d7(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d7(__NL(Is_Woman_Owned_))),COUNT(__d7(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d7(__NL(Is_Minority_Woman_Owned_))),COUNT(__d7(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d7(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d7(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d7(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d7(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d7(__NL(Is_Disadvantage_Owned_))),COUNT(__d7(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d7(__NL(Is_Veteran_Owned_))),COUNT(__d7(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d7(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d7(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d7(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d7(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d7(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d7(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d7(__NL(Is_Disabled_Owned_))),COUNT(__d7(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d7(__NL(Is_Hist_Black_College_))),COUNT(__d7(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d7(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d7(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d7(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d7(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d7(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d7(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d7(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d7(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d7(__NL(Is_S_B_E_))),COUNT(__d7(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d7(__NL(Is_Not_S_B_E_))),COUNT(__d7(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d7(__NL(Is_Goverment_))),COUNT(__d7(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d7(__NL(Is_Federal_Goverment_))),COUNT(__d7(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d7(__NL(Merchant_Type_))),COUNT(__d7(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d7(__NL(Process_Date_))),COUNT(__d7(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d7(__NL(Year_Established_))),COUNT(__d7(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d7(__NL(Public_Private_Indicator_))),COUNT(__d7(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d7(__NL(Business_Size_))),COUNT(__d7(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d7(__NL(Goverment_Type_))),COUNT(__d7(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d7(__NL(Is_Non_Profit_))),COUNT(__d7(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d7(__NL(Minority_Woman_Status_))),COUNT(__d7(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d7(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d7(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d7(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d7(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d7(__NL(Is_California_P_U_C_Certified_))),COUNT(__d7(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d7(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d7(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d7(__NL(Is_California_Caltrans_Certified_))),COUNT(__d7(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d7(__NL(Is_Educational_Institution_))),COUNT(__d7(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d7(__NL(Is_Minority_Institue_))),COUNT(__d7(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d7(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d7(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d7(__NL(Date_Last_Seen_Location_))),COUNT(__d7(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d7(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d7(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d7(__NL(Date_Closed_))),COUNT(__d7(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_2_Invalid),COUNT(__d8)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d8(__NL(Ult_I_D_))),COUNT(__d8(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d8(__NL(Org_I_D_))),COUNT(__d8(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d8(__NL(Sele_I_D_))),COUNT(__d8(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d8(__NL(Prox_I_D_))),COUNT(__d8(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d8(__NL(Prox_Sele_))),COUNT(__d8(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d8(__NL(Parent_Prox_I_D_))),COUNT(__d8(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d8(__NL(Sele_Prox_I_D_))),COUNT(__d8(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d8(__NL(Org_Prox_I_D_))),COUNT(__d8(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d8(__NL(Ult_Prox_I_D_))),COUNT(__d8(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d8(__NL(Levels_From_Top_))),COUNT(__d8(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d8(__NL(Nodes_Below_))),COUNT(__d8(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d8(__NL(Prox_Segment_))),COUNT(__d8(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d8(__NL(Store_Number_))),COUNT(__d8(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d8(__NL(Active_Duns_Number_))),COUNT(__d8(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d8(__NL(Hist_Duns_Number_))),COUNT(__d8(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d8(__NL(Deleted_Key_))),COUNT(__d8(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d8(__NL(D_U_N_S_Number_))),COUNT(__d8(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d8(__NL(Name_))),COUNT(__d8(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d8(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d8(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d8(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d8(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d8(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d8(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d8(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d8(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d8(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d8(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d8(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d8(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d8(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d8(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d8(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d8(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d8(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d8(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d8(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d8(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d8(__NL(O_S_H_A_Union_Flag_))),COUNT(__d8(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d8(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d8(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d8(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d8(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d8(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d8(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d8(__NL(O_S_H_A_Total_Violations_))),COUNT(__d8(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d8(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d8(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d8(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d8(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d8(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d8(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d8(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d8(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d8(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d8(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d8(__NL(O_S_H_A_Owner_Type_))),COUNT(__d8(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d8(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d8(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d8(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d8(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d8(__NL(Best_Company_Name_))),COUNT(__d8(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d8(__NL(Best_Company_Name_Rank_))),COUNT(__d8(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d8(__NL(Best_S_I_C_Code_))),COUNT(__d8(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d8(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d8(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d8(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d8(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d8(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d8(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d8(__NL(Corporation_Code_))),COUNT(__d8(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d8(__NL(Contact_First_Name_))),COUNT(__d8(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d8(__NL(Contact_Middle_Name_))),COUNT(__d8(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d8(__NL(Contact_Last_Name_))),COUNT(__d8(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d8(__NL(Contact_Name_Suffix_))),COUNT(__d8(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d8(__NL(Contact_Primary_Range_))),COUNT(__d8(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d8(__NL(Contact_Predirectional_))),COUNT(__d8(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d8(__NL(Contact_Primary_Name_))),COUNT(__d8(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d8(__NL(Contact_Suffix_))),COUNT(__d8(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d8(__NL(Contact_Postdirectional_))),COUNT(__d8(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d8(__NL(Contact_Secondary_Range_))),COUNT(__d8(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d8(__NL(Contact_State_))),COUNT(__d8(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d8(__NL(Contact_Z_I_P5_))),COUNT(__d8(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d8(__NL(Contact_S_S_N_))),COUNT(__d8(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d8(__NL(Contact_Phone_Number_))),COUNT(__d8(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d8(__NL(Contact_Score_))),COUNT(__d8(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d8(__NL(Contact_Type_))),COUNT(__d8(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d8(__NL(Contact_Email_))),COUNT(__d8(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d8(__NL(Contact_Email_Username_))),COUNT(__d8(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d8(__NL(Contact_Email_Domain_))),COUNT(__d8(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d8(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d8(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d8(__NL(Cortera_Link_I_D_))),COUNT(__d8(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d8(__NL(Contact_Job_Title_))),COUNT(__d8(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d8(__NL(Contact_Status_))),COUNT(__d8(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d8(__NL(Location_Corp_Hierarchy_))),COUNT(__d8(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d8(__NL(Company_Status_))),COUNT(__d8(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d8(__NL(Is_Closed_))),COUNT(__d8(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d8(__NL(Contact_Is_Executive_))),COUNT(__d8(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d8(__NL(Is_Contact_))),COUNT(__d8(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d8(__NL(Contact_Executive_Order_))),COUNT(__d8(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d8(__NL(Record_Status_))),COUNT(__d8(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d8(__NL(Equifax_I_D_))),COUNT(__d8(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d8(__NL(Is_Small_Business_Home_Office_))),COUNT(__d8(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d8(__NL(U_R_L_))),COUNT(__d8(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d8(__NL(Employee_Count_))),COUNT(__d8(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d8(__NL(Employee_Count_Code_))),COUNT(__d8(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d8(__NL(Financial_Amount_Figure_))),COUNT(__d8(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d8(__NL(Financial_Amount_Code_))),COUNT(__d8(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d8(__NL(Financial_Amount_Type_))),COUNT(__d8(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d8(__NL(Financial_Amount_Precision_))),COUNT(__d8(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d8(__NL(Is_Dead_))),COUNT(__d8(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d8(__NL(Date_Dead_))),COUNT(__d8(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d8(__NL(Associated_Addr_Commercial_))),COUNT(__d8(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d8(__NL(Associated_Addr_Residential_))),COUNT(__d8(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d8(__NL(General_Marketability_Score_))),COUNT(__d8(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d8(__NL(General_Marketability_Indicator_))),COUNT(__d8(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d8(__NL(Is_Vacant_))),COUNT(__d8(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d8(__NL(Is_Seasonal_))),COUNT(__d8(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d8(__NL(Is_Minority_Owned_))),COUNT(__d8(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d8(__NL(Is_Woman_Owned_))),COUNT(__d8(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d8(__NL(Is_Minority_Woman_Owned_))),COUNT(__d8(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d8(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d8(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d8(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d8(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d8(__NL(Is_Disadvantage_Owned_))),COUNT(__d8(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d8(__NL(Is_Veteran_Owned_))),COUNT(__d8(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d8(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d8(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d8(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d8(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d8(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d8(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d8(__NL(Is_Disabled_Owned_))),COUNT(__d8(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d8(__NL(Is_Hist_Black_College_))),COUNT(__d8(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d8(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d8(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d8(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d8(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d8(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d8(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d8(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d8(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d8(__NL(Is_S_B_E_))),COUNT(__d8(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d8(__NL(Is_Not_S_B_E_))),COUNT(__d8(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d8(__NL(Is_Goverment_))),COUNT(__d8(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d8(__NL(Is_Federal_Goverment_))),COUNT(__d8(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d8(__NL(Merchant_Type_))),COUNT(__d8(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d8(__NL(Process_Date_))),COUNT(__d8(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d8(__NL(Year_Established_))),COUNT(__d8(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d8(__NL(Public_Private_Indicator_))),COUNT(__d8(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d8(__NL(Business_Size_))),COUNT(__d8(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d8(__NL(Goverment_Type_))),COUNT(__d8(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d8(__NL(Is_Non_Profit_))),COUNT(__d8(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d8(__NL(Minority_Woman_Status_))),COUNT(__d8(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d8(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d8(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d8(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d8(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d8(__NL(Is_California_P_U_C_Certified_))),COUNT(__d8(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d8(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d8(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d8(__NL(Is_California_Caltrans_Certified_))),COUNT(__d8(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d8(__NL(Is_Educational_Institution_))),COUNT(__d8(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d8(__NL(Is_Minority_Institue_))),COUNT(__d8(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d8(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d8(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d8(__NL(Date_Last_Seen_Location_))),COUNT(__d8(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d8(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d8(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d8(__NL(Date_Closed_))),COUNT(__d8(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__kfetch_contact_linkids_slim_Invalid),COUNT(__d9)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d9(__NL(Ult_I_D_))),COUNT(__d9(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d9(__NL(Org_I_D_))),COUNT(__d9(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d9(__NL(Sele_I_D_))),COUNT(__d9(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d9(__NL(Prox_I_D_))),COUNT(__d9(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d9(__NL(Prox_Sele_))),COUNT(__d9(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d9(__NL(Parent_Prox_I_D_))),COUNT(__d9(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d9(__NL(Sele_Prox_I_D_))),COUNT(__d9(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d9(__NL(Org_Prox_I_D_))),COUNT(__d9(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d9(__NL(Ult_Prox_I_D_))),COUNT(__d9(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d9(__NL(Levels_From_Top_))),COUNT(__d9(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d9(__NL(Nodes_Below_))),COUNT(__d9(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d9(__NL(Prox_Segment_))),COUNT(__d9(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d9(__NL(Store_Number_))),COUNT(__d9(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d9(__NL(Active_Duns_Number_))),COUNT(__d9(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d9(__NL(Hist_Duns_Number_))),COUNT(__d9(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d9(__NL(Deleted_Key_))),COUNT(__d9(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d9(__NL(D_U_N_S_Number_))),COUNT(__d9(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d9(__NL(Name_))),COUNT(__d9(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d9(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d9(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d9(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d9(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d9(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d9(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d9(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d9(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d9(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d9(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d9(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d9(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d9(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d9(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d9(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d9(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d9(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d9(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d9(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d9(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d9(__NL(O_S_H_A_Union_Flag_))),COUNT(__d9(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d9(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d9(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d9(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d9(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d9(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d9(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d9(__NL(O_S_H_A_Total_Violations_))),COUNT(__d9(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d9(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d9(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d9(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d9(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d9(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d9(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d9(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d9(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d9(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d9(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d9(__NL(O_S_H_A_Owner_Type_))),COUNT(__d9(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d9(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d9(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d9(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d9(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d9(__NL(Best_Company_Name_))),COUNT(__d9(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d9(__NL(Best_Company_Name_Rank_))),COUNT(__d9(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d9(__NL(Best_S_I_C_Code_))),COUNT(__d9(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d9(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d9(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d9(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d9(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d9(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d9(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d9(__NL(Corporation_Code_))),COUNT(__d9(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d9(__NL(Contact_First_Name_))),COUNT(__d9(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d9(__NL(Contact_Middle_Name_))),COUNT(__d9(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d9(__NL(Contact_Last_Name_))),COUNT(__d9(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d9(__NL(Contact_Name_Suffix_))),COUNT(__d9(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d9(__NL(Contact_Primary_Range_))),COUNT(__d9(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d9(__NL(Contact_Predirectional_))),COUNT(__d9(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d9(__NL(Contact_Primary_Name_))),COUNT(__d9(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d9(__NL(Contact_Suffix_))),COUNT(__d9(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d9(__NL(Contact_Postdirectional_))),COUNT(__d9(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d9(__NL(Contact_Secondary_Range_))),COUNT(__d9(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d9(__NL(Contact_State_))),COUNT(__d9(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d9(__NL(Contact_Z_I_P5_))),COUNT(__d9(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d9(__NL(Contact_S_S_N_))),COUNT(__d9(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d9(__NL(Contact_Phone_Number_))),COUNT(__d9(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d9(__NL(Contact_Score_))),COUNT(__d9(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d9(__NL(Contact_Type_))),COUNT(__d9(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d9(__NL(Contact_Email_))),COUNT(__d9(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d9(__NL(Contact_Email_Username_))),COUNT(__d9(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d9(__NL(Contact_Email_Domain_))),COUNT(__d9(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d9(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d9(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d9(__NL(Cortera_Link_I_D_))),COUNT(__d9(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d9(__NL(Contact_Job_Title_))),COUNT(__d9(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d9(__NL(Contact_Status_))),COUNT(__d9(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d9(__NL(Location_Corp_Hierarchy_))),COUNT(__d9(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d9(__NL(Company_Status_))),COUNT(__d9(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d9(__NL(Is_Closed_))),COUNT(__d9(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d9(__NL(Contact_Is_Executive_))),COUNT(__d9(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d9(__NL(Is_Contact_))),COUNT(__d9(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d9(__NL(Contact_Executive_Order_))),COUNT(__d9(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d9(__NL(Record_Status_))),COUNT(__d9(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d9(__NL(Equifax_I_D_))),COUNT(__d9(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d9(__NL(Is_Small_Business_Home_Office_))),COUNT(__d9(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d9(__NL(U_R_L_))),COUNT(__d9(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d9(__NL(Employee_Count_))),COUNT(__d9(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d9(__NL(Employee_Count_Code_))),COUNT(__d9(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d9(__NL(Financial_Amount_Figure_))),COUNT(__d9(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d9(__NL(Financial_Amount_Code_))),COUNT(__d9(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d9(__NL(Financial_Amount_Type_))),COUNT(__d9(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d9(__NL(Financial_Amount_Precision_))),COUNT(__d9(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d9(__NL(Is_Dead_))),COUNT(__d9(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d9(__NL(Date_Dead_))),COUNT(__d9(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d9(__NL(Associated_Addr_Commercial_))),COUNT(__d9(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d9(__NL(Associated_Addr_Residential_))),COUNT(__d9(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d9(__NL(General_Marketability_Score_))),COUNT(__d9(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d9(__NL(General_Marketability_Indicator_))),COUNT(__d9(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d9(__NL(Is_Vacant_))),COUNT(__d9(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d9(__NL(Is_Seasonal_))),COUNT(__d9(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d9(__NL(Is_Minority_Owned_))),COUNT(__d9(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d9(__NL(Is_Woman_Owned_))),COUNT(__d9(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d9(__NL(Is_Minority_Woman_Owned_))),COUNT(__d9(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d9(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d9(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d9(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d9(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d9(__NL(Is_Disadvantage_Owned_))),COUNT(__d9(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d9(__NL(Is_Veteran_Owned_))),COUNT(__d9(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d9(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d9(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d9(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d9(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d9(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d9(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d9(__NL(Is_Disabled_Owned_))),COUNT(__d9(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d9(__NL(Is_Hist_Black_College_))),COUNT(__d9(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d9(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d9(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d9(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d9(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d9(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d9(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d9(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d9(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d9(__NL(Is_S_B_E_))),COUNT(__d9(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d9(__NL(Is_Not_S_B_E_))),COUNT(__d9(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d9(__NL(Is_Goverment_))),COUNT(__d9(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d9(__NL(Is_Federal_Goverment_))),COUNT(__d9(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d9(__NL(Merchant_Type_))),COUNT(__d9(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d9(__NL(Process_Date_))),COUNT(__d9(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d9(__NL(Year_Established_))),COUNT(__d9(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d9(__NL(Public_Private_Indicator_))),COUNT(__d9(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d9(__NL(Business_Size_))),COUNT(__d9(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d9(__NL(Goverment_Type_))),COUNT(__d9(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d9(__NL(Is_Non_Profit_))),COUNT(__d9(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d9(__NL(Minority_Woman_Status_))),COUNT(__d9(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d9(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d9(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d9(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d9(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d9(__NL(Is_California_P_U_C_Certified_))),COUNT(__d9(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d9(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d9(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d9(__NL(Is_California_Caltrans_Certified_))),COUNT(__d9(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d9(__NL(Is_Educational_Institution_))),COUNT(__d9(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d9(__NL(Is_Minority_Institue_))),COUNT(__d9(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d9(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d9(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d9(__NL(Date_Last_Seen_Location_))),COUNT(__d9(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d9(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d9(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d9(__NL(Date_Closed_))),COUNT(__d9(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_1_Invalid),COUNT(__d10)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d10(__NL(Ult_I_D_))),COUNT(__d10(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d10(__NL(Org_I_D_))),COUNT(__d10(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d10(__NL(Sele_I_D_))),COUNT(__d10(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d10(__NL(Prox_I_D_))),COUNT(__d10(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d10(__NL(Prox_Sele_))),COUNT(__d10(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d10(__NL(Parent_Prox_I_D_))),COUNT(__d10(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d10(__NL(Sele_Prox_I_D_))),COUNT(__d10(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d10(__NL(Org_Prox_I_D_))),COUNT(__d10(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d10(__NL(Ult_Prox_I_D_))),COUNT(__d10(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d10(__NL(Levels_From_Top_))),COUNT(__d10(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d10(__NL(Nodes_Below_))),COUNT(__d10(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d10(__NL(Prox_Segment_))),COUNT(__d10(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d10(__NL(Store_Number_))),COUNT(__d10(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d10(__NL(Active_Duns_Number_))),COUNT(__d10(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d10(__NL(Hist_Duns_Number_))),COUNT(__d10(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d10(__NL(Deleted_Key_))),COUNT(__d10(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d10(__NL(D_U_N_S_Number_))),COUNT(__d10(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d10(__NL(Name_))),COUNT(__d10(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d10(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d10(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d10(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d10(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d10(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d10(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d10(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d10(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d10(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d10(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d10(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d10(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d10(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d10(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d10(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d10(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d10(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d10(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d10(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d10(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d10(__NL(O_S_H_A_Union_Flag_))),COUNT(__d10(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d10(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d10(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d10(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d10(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d10(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d10(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d10(__NL(O_S_H_A_Total_Violations_))),COUNT(__d10(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d10(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d10(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d10(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d10(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d10(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d10(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d10(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d10(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d10(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d10(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d10(__NL(O_S_H_A_Owner_Type_))),COUNT(__d10(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d10(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d10(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d10(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d10(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_name',COUNT(__d10(__NL(Best_Company_Name_))),COUNT(__d10(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d10(__NL(Best_S_I_C_Code_))),COUNT(__d10(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d10(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d10(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d10(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d10(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d10(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d10(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d10(__NL(Corporation_Code_))),COUNT(__d10(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d10(__NL(Contact_First_Name_))),COUNT(__d10(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d10(__NL(Contact_Middle_Name_))),COUNT(__d10(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d10(__NL(Contact_Last_Name_))),COUNT(__d10(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d10(__NL(Contact_Name_Suffix_))),COUNT(__d10(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d10(__NL(Contact_Primary_Range_))),COUNT(__d10(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d10(__NL(Contact_Predirectional_))),COUNT(__d10(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d10(__NL(Contact_Primary_Name_))),COUNT(__d10(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d10(__NL(Contact_Suffix_))),COUNT(__d10(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d10(__NL(Contact_Postdirectional_))),COUNT(__d10(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d10(__NL(Contact_Secondary_Range_))),COUNT(__d10(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d10(__NL(Contact_State_))),COUNT(__d10(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d10(__NL(Contact_Z_I_P5_))),COUNT(__d10(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d10(__NL(Contact_S_S_N_))),COUNT(__d10(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d10(__NL(Contact_Phone_Number_))),COUNT(__d10(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d10(__NL(Contact_Score_))),COUNT(__d10(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d10(__NL(Contact_Type_))),COUNT(__d10(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d10(__NL(Contact_Email_))),COUNT(__d10(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d10(__NL(Contact_Email_Username_))),COUNT(__d10(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d10(__NL(Contact_Email_Domain_))),COUNT(__d10(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d10(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d10(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d10(__NL(Cortera_Link_I_D_))),COUNT(__d10(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d10(__NL(Contact_Job_Title_))),COUNT(__d10(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d10(__NL(Contact_Status_))),COUNT(__d10(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d10(__NL(Location_Corp_Hierarchy_))),COUNT(__d10(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d10(__NL(Company_Status_))),COUNT(__d10(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d10(__NL(Is_Closed_))),COUNT(__d10(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d10(__NL(Contact_Is_Executive_))),COUNT(__d10(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d10(__NL(Is_Contact_))),COUNT(__d10(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d10(__NL(Contact_Executive_Order_))),COUNT(__d10(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d10(__NL(Record_Status_))),COUNT(__d10(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d10(__NL(Equifax_I_D_))),COUNT(__d10(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d10(__NL(Is_Small_Business_Home_Office_))),COUNT(__d10(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d10(__NL(U_R_L_))),COUNT(__d10(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d10(__NL(Employee_Count_))),COUNT(__d10(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d10(__NL(Employee_Count_Code_))),COUNT(__d10(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d10(__NL(Financial_Amount_Figure_))),COUNT(__d10(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d10(__NL(Financial_Amount_Code_))),COUNT(__d10(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d10(__NL(Financial_Amount_Type_))),COUNT(__d10(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d10(__NL(Financial_Amount_Precision_))),COUNT(__d10(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d10(__NL(Is_Dead_))),COUNT(__d10(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d10(__NL(Date_Dead_))),COUNT(__d10(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d10(__NL(Associated_Addr_Commercial_))),COUNT(__d10(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d10(__NL(Associated_Addr_Residential_))),COUNT(__d10(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d10(__NL(General_Marketability_Score_))),COUNT(__d10(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d10(__NL(General_Marketability_Indicator_))),COUNT(__d10(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d10(__NL(Is_Vacant_))),COUNT(__d10(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d10(__NL(Is_Seasonal_))),COUNT(__d10(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d10(__NL(Is_Minority_Owned_))),COUNT(__d10(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d10(__NL(Is_Woman_Owned_))),COUNT(__d10(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d10(__NL(Is_Minority_Woman_Owned_))),COUNT(__d10(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d10(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d10(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d10(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d10(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d10(__NL(Is_Disadvantage_Owned_))),COUNT(__d10(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d10(__NL(Is_Veteran_Owned_))),COUNT(__d10(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d10(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d10(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d10(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d10(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d10(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d10(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d10(__NL(Is_Disabled_Owned_))),COUNT(__d10(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d10(__NL(Is_Hist_Black_College_))),COUNT(__d10(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d10(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d10(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d10(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d10(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d10(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d10(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d10(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d10(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d10(__NL(Is_S_B_E_))),COUNT(__d10(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d10(__NL(Is_Not_S_B_E_))),COUNT(__d10(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d10(__NL(Is_Goverment_))),COUNT(__d10(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d10(__NL(Is_Federal_Goverment_))),COUNT(__d10(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d10(__NL(Merchant_Type_))),COUNT(__d10(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d10(__NL(Process_Date_))),COUNT(__d10(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d10(__NL(Year_Established_))),COUNT(__d10(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d10(__NL(Public_Private_Indicator_))),COUNT(__d10(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d10(__NL(Business_Size_))),COUNT(__d10(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d10(__NL(Goverment_Type_))),COUNT(__d10(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d10(__NL(Is_Non_Profit_))),COUNT(__d10(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d10(__NL(Minority_Woman_Status_))),COUNT(__d10(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d10(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d10(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d10(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d10(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d10(__NL(Is_California_P_U_C_Certified_))),COUNT(__d10(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d10(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d10(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d10(__NL(Is_California_Caltrans_Certified_))),COUNT(__d10(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d10(__NL(Is_Educational_Institution_))),COUNT(__d10(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d10(__NL(Is_Minority_Institue_))),COUNT(__d10(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d10(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d10(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d10(__NL(Date_Last_Seen_Location_))),COUNT(__d10(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d10(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d10(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d10(__NL(Date_Closed_))),COUNT(__d10(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_2_Invalid),COUNT(__d11)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d11(__NL(Ult_I_D_))),COUNT(__d11(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d11(__NL(Org_I_D_))),COUNT(__d11(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d11(__NL(Sele_I_D_))),COUNT(__d11(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d11(__NL(Prox_I_D_))),COUNT(__d11(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d11(__NL(Prox_Sele_))),COUNT(__d11(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d11(__NL(Parent_Prox_I_D_))),COUNT(__d11(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d11(__NL(Sele_Prox_I_D_))),COUNT(__d11(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d11(__NL(Org_Prox_I_D_))),COUNT(__d11(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d11(__NL(Ult_Prox_I_D_))),COUNT(__d11(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d11(__NL(Levels_From_Top_))),COUNT(__d11(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d11(__NL(Nodes_Below_))),COUNT(__d11(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d11(__NL(Prox_Segment_))),COUNT(__d11(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d11(__NL(Store_Number_))),COUNT(__d11(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d11(__NL(Active_Duns_Number_))),COUNT(__d11(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d11(__NL(Hist_Duns_Number_))),COUNT(__d11(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d11(__NL(Deleted_Key_))),COUNT(__d11(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d11(__NL(D_U_N_S_Number_))),COUNT(__d11(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d11(__NL(Name_))),COUNT(__d11(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d11(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d11(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d11(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d11(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d11(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d11(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d11(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d11(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d11(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d11(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d11(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d11(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d11(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d11(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d11(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d11(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d11(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d11(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d11(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d11(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d11(__NL(O_S_H_A_Union_Flag_))),COUNT(__d11(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d11(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d11(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d11(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d11(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d11(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d11(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d11(__NL(O_S_H_A_Total_Violations_))),COUNT(__d11(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d11(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d11(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d11(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d11(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d11(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d11(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d11(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d11(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d11(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d11(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d11(__NL(O_S_H_A_Owner_Type_))),COUNT(__d11(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d11(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d11(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d11(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d11(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d11(__NL(Best_Company_Name_))),COUNT(__d11(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d11(__NL(Best_Company_Name_Rank_))),COUNT(__d11(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code1',COUNT(__d11(__NL(Best_S_I_C_Code_))),COUNT(__d11(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d11(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d11(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d11(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d11(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d11(__NL(Header_Hit_Flag_))),COUNT(__d11(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d11(__NL(Corporation_Code_))),COUNT(__d11(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d11(__NL(Contact_First_Name_))),COUNT(__d11(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d11(__NL(Contact_Middle_Name_))),COUNT(__d11(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d11(__NL(Contact_Last_Name_))),COUNT(__d11(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d11(__NL(Contact_Name_Suffix_))),COUNT(__d11(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d11(__NL(Contact_Primary_Range_))),COUNT(__d11(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d11(__NL(Contact_Predirectional_))),COUNT(__d11(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d11(__NL(Contact_Primary_Name_))),COUNT(__d11(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d11(__NL(Contact_Suffix_))),COUNT(__d11(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d11(__NL(Contact_Postdirectional_))),COUNT(__d11(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d11(__NL(Contact_Secondary_Range_))),COUNT(__d11(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d11(__NL(Contact_State_))),COUNT(__d11(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d11(__NL(Contact_Z_I_P5_))),COUNT(__d11(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d11(__NL(Contact_S_S_N_))),COUNT(__d11(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d11(__NL(Contact_Phone_Number_))),COUNT(__d11(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d11(__NL(Contact_Score_))),COUNT(__d11(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d11(__NL(Contact_Type_))),COUNT(__d11(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d11(__NL(Contact_Email_))),COUNT(__d11(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d11(__NL(Contact_Email_Username_))),COUNT(__d11(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d11(__NL(Contact_Email_Domain_))),COUNT(__d11(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d11(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d11(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d11(__NL(Cortera_Link_I_D_))),COUNT(__d11(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d11(__NL(Contact_Job_Title_))),COUNT(__d11(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d11(__NL(Contact_Status_))),COUNT(__d11(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d11(__NL(Location_Corp_Hierarchy_))),COUNT(__d11(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d11(__NL(Company_Status_))),COUNT(__d11(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d11(__NL(Is_Closed_))),COUNT(__d11(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d11(__NL(Contact_Is_Executive_))),COUNT(__d11(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d11(__NL(Is_Contact_))),COUNT(__d11(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d11(__NL(Contact_Executive_Order_))),COUNT(__d11(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d11(__NL(Record_Status_))),COUNT(__d11(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d11(__NL(Equifax_I_D_))),COUNT(__d11(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d11(__NL(Is_Small_Business_Home_Office_))),COUNT(__d11(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d11(__NL(U_R_L_))),COUNT(__d11(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d11(__NL(Employee_Count_))),COUNT(__d11(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d11(__NL(Employee_Count_Code_))),COUNT(__d11(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d11(__NL(Financial_Amount_Figure_))),COUNT(__d11(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d11(__NL(Financial_Amount_Code_))),COUNT(__d11(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d11(__NL(Financial_Amount_Type_))),COUNT(__d11(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d11(__NL(Financial_Amount_Precision_))),COUNT(__d11(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d11(__NL(Is_Dead_))),COUNT(__d11(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d11(__NL(Date_Dead_))),COUNT(__d11(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d11(__NL(Associated_Addr_Commercial_))),COUNT(__d11(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d11(__NL(Associated_Addr_Residential_))),COUNT(__d11(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d11(__NL(General_Marketability_Score_))),COUNT(__d11(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d11(__NL(General_Marketability_Indicator_))),COUNT(__d11(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d11(__NL(Is_Vacant_))),COUNT(__d11(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d11(__NL(Is_Seasonal_))),COUNT(__d11(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d11(__NL(Is_Minority_Owned_))),COUNT(__d11(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d11(__NL(Is_Woman_Owned_))),COUNT(__d11(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d11(__NL(Is_Minority_Woman_Owned_))),COUNT(__d11(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d11(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d11(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d11(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d11(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d11(__NL(Is_Disadvantage_Owned_))),COUNT(__d11(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d11(__NL(Is_Veteran_Owned_))),COUNT(__d11(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d11(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d11(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d11(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d11(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d11(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d11(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d11(__NL(Is_Disabled_Owned_))),COUNT(__d11(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d11(__NL(Is_Hist_Black_College_))),COUNT(__d11(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d11(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d11(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d11(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d11(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d11(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d11(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d11(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d11(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d11(__NL(Is_S_B_E_))),COUNT(__d11(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d11(__NL(Is_Not_S_B_E_))),COUNT(__d11(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d11(__NL(Is_Goverment_))),COUNT(__d11(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d11(__NL(Is_Federal_Goverment_))),COUNT(__d11(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d11(__NL(Merchant_Type_))),COUNT(__d11(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d11(__NL(Process_Date_))),COUNT(__d11(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d11(__NL(Year_Established_))),COUNT(__d11(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d11(__NL(Public_Private_Indicator_))),COUNT(__d11(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d11(__NL(Business_Size_))),COUNT(__d11(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d11(__NL(Goverment_Type_))),COUNT(__d11(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d11(__NL(Is_Non_Profit_))),COUNT(__d11(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d11(__NL(Minority_Woman_Status_))),COUNT(__d11(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d11(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d11(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d11(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d11(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d11(__NL(Is_California_P_U_C_Certified_))),COUNT(__d11(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d11(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d11(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d11(__NL(Is_California_Caltrans_Certified_))),COUNT(__d11(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d11(__NL(Is_Educational_Institution_))),COUNT(__d11(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d11(__NL(Is_Minority_Institue_))),COUNT(__d11(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d11(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d11(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d11(__NL(Date_Last_Seen_Location_))),COUNT(__d11(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d11(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d11(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d11(__NL(Date_Closed_))),COUNT(__d11(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Best__Key_LinkIds_3_Invalid),COUNT(__d12)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d12(__NL(Ult_I_D_))),COUNT(__d12(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d12(__NL(Org_I_D_))),COUNT(__d12(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d12(__NL(Sele_I_D_))),COUNT(__d12(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d12(__NL(Prox_I_D_))),COUNT(__d12(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d12(__NL(Prox_Sele_))),COUNT(__d12(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d12(__NL(Parent_Prox_I_D_))),COUNT(__d12(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d12(__NL(Sele_Prox_I_D_))),COUNT(__d12(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d12(__NL(Org_Prox_I_D_))),COUNT(__d12(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d12(__NL(Ult_Prox_I_D_))),COUNT(__d12(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d12(__NL(Levels_From_Top_))),COUNT(__d12(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d12(__NL(Nodes_Below_))),COUNT(__d12(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d12(__NL(Prox_Segment_))),COUNT(__d12(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d12(__NL(Store_Number_))),COUNT(__d12(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d12(__NL(Active_Duns_Number_))),COUNT(__d12(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d12(__NL(Hist_Duns_Number_))),COUNT(__d12(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d12(__NL(Deleted_Key_))),COUNT(__d12(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d12(__NL(D_U_N_S_Number_))),COUNT(__d12(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name',COUNT(__d12(__NL(Name_))),COUNT(__d12(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d12(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d12(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d12(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d12(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d12(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d12(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d12(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d12(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d12(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d12(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d12(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d12(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d12(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d12(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d12(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d12(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d12(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d12(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d12(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d12(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d12(__NL(O_S_H_A_Union_Flag_))),COUNT(__d12(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d12(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d12(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d12(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d12(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d12(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d12(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d12(__NL(O_S_H_A_Total_Violations_))),COUNT(__d12(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d12(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d12(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d12(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d12(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d12(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d12(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d12(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d12(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d12(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d12(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d12(__NL(O_S_H_A_Owner_Type_))),COUNT(__d12(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d12(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d12(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d12(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d12(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d12(__NL(Best_Company_Name_))),COUNT(__d12(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d12(__NL(Best_Company_Name_Rank_))),COUNT(__d12(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d12(__NL(Best_S_I_C_Code_))),COUNT(__d12(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d12(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d12(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code1',COUNT(__d12(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d12(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d12(__NL(Header_Hit_Flag_))),COUNT(__d12(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d12(__NL(Corporation_Code_))),COUNT(__d12(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d12(__NL(Contact_First_Name_))),COUNT(__d12(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d12(__NL(Contact_Middle_Name_))),COUNT(__d12(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d12(__NL(Contact_Last_Name_))),COUNT(__d12(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d12(__NL(Contact_Name_Suffix_))),COUNT(__d12(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d12(__NL(Contact_Primary_Range_))),COUNT(__d12(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d12(__NL(Contact_Predirectional_))),COUNT(__d12(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d12(__NL(Contact_Primary_Name_))),COUNT(__d12(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d12(__NL(Contact_Suffix_))),COUNT(__d12(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d12(__NL(Contact_Postdirectional_))),COUNT(__d12(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d12(__NL(Contact_Secondary_Range_))),COUNT(__d12(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d12(__NL(Contact_State_))),COUNT(__d12(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d12(__NL(Contact_Z_I_P5_))),COUNT(__d12(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d12(__NL(Contact_S_S_N_))),COUNT(__d12(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d12(__NL(Contact_Phone_Number_))),COUNT(__d12(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d12(__NL(Contact_Score_))),COUNT(__d12(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d12(__NL(Contact_Type_))),COUNT(__d12(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d12(__NL(Contact_Email_))),COUNT(__d12(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d12(__NL(Contact_Email_Username_))),COUNT(__d12(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d12(__NL(Contact_Email_Domain_))),COUNT(__d12(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d12(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d12(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d12(__NL(Cortera_Link_I_D_))),COUNT(__d12(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d12(__NL(Contact_Job_Title_))),COUNT(__d12(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d12(__NL(Contact_Status_))),COUNT(__d12(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d12(__NL(Location_Corp_Hierarchy_))),COUNT(__d12(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d12(__NL(Company_Status_))),COUNT(__d12(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d12(__NL(Is_Closed_))),COUNT(__d12(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d12(__NL(Contact_Is_Executive_))),COUNT(__d12(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d12(__NL(Is_Contact_))),COUNT(__d12(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d12(__NL(Contact_Executive_Order_))),COUNT(__d12(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d12(__NL(Record_Status_))),COUNT(__d12(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d12(__NL(Equifax_I_D_))),COUNT(__d12(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d12(__NL(Is_Small_Business_Home_Office_))),COUNT(__d12(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d12(__NL(U_R_L_))),COUNT(__d12(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d12(__NL(Employee_Count_))),COUNT(__d12(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d12(__NL(Employee_Count_Code_))),COUNT(__d12(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d12(__NL(Financial_Amount_Figure_))),COUNT(__d12(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d12(__NL(Financial_Amount_Code_))),COUNT(__d12(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d12(__NL(Financial_Amount_Type_))),COUNT(__d12(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d12(__NL(Financial_Amount_Precision_))),COUNT(__d12(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d12(__NL(Is_Dead_))),COUNT(__d12(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d12(__NL(Date_Dead_))),COUNT(__d12(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d12(__NL(Associated_Addr_Commercial_))),COUNT(__d12(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d12(__NL(Associated_Addr_Residential_))),COUNT(__d12(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d12(__NL(General_Marketability_Score_))),COUNT(__d12(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d12(__NL(General_Marketability_Indicator_))),COUNT(__d12(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d12(__NL(Is_Vacant_))),COUNT(__d12(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d12(__NL(Is_Seasonal_))),COUNT(__d12(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d12(__NL(Is_Minority_Owned_))),COUNT(__d12(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d12(__NL(Is_Woman_Owned_))),COUNT(__d12(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d12(__NL(Is_Minority_Woman_Owned_))),COUNT(__d12(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d12(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d12(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d12(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d12(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d12(__NL(Is_Disadvantage_Owned_))),COUNT(__d12(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d12(__NL(Is_Veteran_Owned_))),COUNT(__d12(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d12(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d12(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d12(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d12(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d12(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d12(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d12(__NL(Is_Disabled_Owned_))),COUNT(__d12(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d12(__NL(Is_Hist_Black_College_))),COUNT(__d12(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d12(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d12(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d12(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d12(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d12(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d12(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d12(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d12(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d12(__NL(Is_S_B_E_))),COUNT(__d12(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d12(__NL(Is_Not_S_B_E_))),COUNT(__d12(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d12(__NL(Is_Goverment_))),COUNT(__d12(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d12(__NL(Is_Federal_Goverment_))),COUNT(__d12(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d12(__NL(Merchant_Type_))),COUNT(__d12(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d12(__NL(Process_Date_))),COUNT(__d12(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d12(__NL(Year_Established_))),COUNT(__d12(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d12(__NL(Public_Private_Indicator_))),COUNT(__d12(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d12(__NL(Business_Size_))),COUNT(__d12(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d12(__NL(Goverment_Type_))),COUNT(__d12(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d12(__NL(Is_Non_Profit_))),COUNT(__d12(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d12(__NL(Minority_Woman_Status_))),COUNT(__d12(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d12(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d12(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d12(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d12(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d12(__NL(Is_California_P_U_C_Certified_))),COUNT(__d12(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d12(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d12(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d12(__NL(Is_California_Caltrans_Certified_))),COUNT(__d12(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d12(__NL(Is_Educational_Institution_))),COUNT(__d12(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d12(__NL(Is_Minority_Institue_))),COUNT(__d12(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d12(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d12(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d12(__NL(Date_Last_Seen_Location_))),COUNT(__d12(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d12(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d12(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d12(__NL(Date_Closed_))),COUNT(__d12(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid),COUNT(__d13)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d13(__NL(Ult_I_D_))),COUNT(__d13(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d13(__NL(Org_I_D_))),COUNT(__d13(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d13(__NL(Sele_I_D_))),COUNT(__d13(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d13(__NL(Prox_I_D_))),COUNT(__d13(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSele',COUNT(__d13(__NL(Prox_Sele_))),COUNT(__d13(__NN(Prox_Sele_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParentProxID',COUNT(__d13(__NL(Parent_Prox_I_D_))),COUNT(__d13(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleProxID',COUNT(__d13(__NL(Sele_Prox_I_D_))),COUNT(__d13(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgProxID',COUNT(__d13(__NL(Org_Prox_I_D_))),COUNT(__d13(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltProxID',COUNT(__d13(__NL(Ult_Prox_I_D_))),COUNT(__d13(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LevelsFromTop',COUNT(__d13(__NL(Levels_From_Top_))),COUNT(__d13(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NodesBelow',COUNT(__d13(__NL(Nodes_Below_))),COUNT(__d13(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxSegment',COUNT(__d13(__NL(Prox_Segment_))),COUNT(__d13(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StoreNumber',COUNT(__d13(__NL(Store_Number_))),COUNT(__d13(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDunsNumber',COUNT(__d13(__NL(Active_Duns_Number_))),COUNT(__d13(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistDunsNumber',COUNT(__d13(__NL(Hist_Duns_Number_))),COUNT(__d13(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeletedKey',COUNT(__d13(__NL(Deleted_Key_))),COUNT(__d13(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DUNSNumber',COUNT(__d13(__NL(D_U_N_S_Number_))),COUNT(__d13(__NN(D_U_N_S_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listed_name',COUNT(__d13(__NL(Name_))),COUNT(__d13(__NN(Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityType',COUNT(__d13(__NL(O_S_H_A_Previous_Activity_Type_))),COUNT(__d13(__NN(O_S_H_A_Previous_Activity_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAPreviousActivityTypeDescription',COUNT(__d13(__NL(O_S_H_A_Previous_Activity_Type_Description_))),COUNT(__d13(__NN(O_S_H_A_Previous_Activity_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAAdvanceNoticeFlag',COUNT(__d13(__NL(O_S_H_A_Advance_Notice_Flag_))),COUNT(__d13(__NN(O_S_H_A_Advance_Notice_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionOpeningDate',COUNT(__d13(__NL(O_S_H_A_Inspection_Opening_Date_))),COUNT(__d13(__NN(O_S_H_A_Inspection_Opening_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionCloseDate',COUNT(__d13(__NL(O_S_H_A_Inspection_Close_Date_))),COUNT(__d13(__NN(O_S_H_A_Inspection_Close_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHASafetyHealthFlag',COUNT(__d13(__NL(O_S_H_A_Safety_Health_Flag_))),COUNT(__d13(__NN(O_S_H_A_Safety_Health_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionType',COUNT(__d13(__NL(O_S_H_A_Inspection_Type_))),COUNT(__d13(__NN(O_S_H_A_Inspection_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionScope',COUNT(__d13(__NL(O_S_H_A_Inspection_Scope_))),COUNT(__d13(__NN(O_S_H_A_Inspection_Scope_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAWalkAroundFlag',COUNT(__d13(__NL(O_S_H_A_Walk_Around_Flag_))),COUNT(__d13(__NN(O_S_H_A_Walk_Around_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeesInterviewedFlag',COUNT(__d13(__NL(O_S_H_A_Employees_Interviewed_Flag_))),COUNT(__d13(__NN(O_S_H_A_Employees_Interviewed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAUnionFlag',COUNT(__d13(__NL(O_S_H_A_Union_Flag_))),COUNT(__d13(__NN(O_S_H_A_Union_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHACaseClosedFlag',COUNT(__d13(__NL(O_S_H_A_Case_Closed_Flag_))),COUNT(__d13(__NN(O_S_H_A_Case_Closed_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANoInspectionCode',COUNT(__d13(__NL(O_S_H_A_No_Inspection_Code_))),COUNT(__d13(__NN(O_S_H_A_No_Inspection_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAInspectionTypeCode',COUNT(__d13(__NL(O_S_H_A_Inspection_Type_Code_))),COUNT(__d13(__NN(O_S_H_A_Inspection_Type_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalViolations',COUNT(__d13(__NL(O_S_H_A_Total_Violations_))),COUNT(__d13(__NN(O_S_H_A_Total_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHATotalSeriousViolations',COUNT(__d13(__NL(O_S_H_A_Total_Serious_Violations_))),COUNT(__d13(__NN(O_S_H_A_Total_Serious_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfViolations',COUNT(__d13(__NL(O_S_H_A_Number_Of_Violations_))),COUNT(__d13(__NN(O_S_H_A_Number_Of_Violations_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfEvents',COUNT(__d13(__NL(O_S_H_A_Number_Of_Events_))),COUNT(__d13(__NN(O_S_H_A_Number_Of_Events_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfHazardousSubstance',COUNT(__d13(__NL(O_S_H_A_Number_Of_Hazardous_Substance_))),COUNT(__d13(__NN(O_S_H_A_Number_Of_Hazardous_Substance_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHANumberOfAccidents',COUNT(__d13(__NL(O_S_H_A_Number_Of_Accidents_))),COUNT(__d13(__NN(O_S_H_A_Number_Of_Accidents_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerType',COUNT(__d13(__NL(O_S_H_A_Owner_Type_))),COUNT(__d13(__NN(O_S_H_A_Owner_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAOwnerTypeDescription',COUNT(__d13(__NL(O_S_H_A_Owner_Type_Description_))),COUNT(__d13(__NN(O_S_H_A_Owner_Type_Description_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OSHAEmployeeCount12Months',COUNT(__d13(__NL(O_S_H_A_Employee_Count12_Months_))),COUNT(__d13(__NN(O_S_H_A_Employee_Count12_Months_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyName',COUNT(__d13(__NL(Best_Company_Name_))),COUNT(__d13(__NN(Best_Company_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCompanyNameRank',COUNT(__d13(__NL(Best_Company_Name_Rank_))),COUNT(__d13(__NN(Best_Company_Name_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCode',COUNT(__d13(__NL(Best_S_I_C_Code_))),COUNT(__d13(__NN(Best_S_I_C_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSICCodeRank',COUNT(__d13(__NL(Best_S_I_C_Code_Rank_))),COUNT(__d13(__NN(Best_S_I_C_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCode',COUNT(__d13(__NL(Best_N_A_I_C_S_Code_))),COUNT(__d13(__NN(Best_N_A_I_C_S_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNAICSCodeRank',COUNT(__d13(__NL(Best_N_A_I_C_S_Code_Rank_))),COUNT(__d13(__NN(Best_N_A_I_C_S_Code_Rank_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d13(__NL(Header_Hit_Flag_))),COUNT(__d13(__NN(Header_Hit_Flag_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporationCode',COUNT(__d13(__NL(Corporation_Code_))),COUNT(__d13(__NN(Corporation_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d13(__NL(Contact_First_Name_))),COUNT(__d13(__NN(Contact_First_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d13(__NL(Contact_Middle_Name_))),COUNT(__d13(__NN(Contact_Middle_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d13(__NL(Contact_Last_Name_))),COUNT(__d13(__NN(Contact_Last_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d13(__NL(Contact_Name_Suffix_))),COUNT(__d13(__NN(Contact_Name_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryRange',COUNT(__d13(__NL(Contact_Primary_Range_))),COUNT(__d13(__NN(Contact_Primary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPredirectional',COUNT(__d13(__NL(Contact_Predirectional_))),COUNT(__d13(__NN(Contact_Predirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPrimaryName',COUNT(__d13(__NL(Contact_Primary_Name_))),COUNT(__d13(__NN(Contact_Primary_Name_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSuffix',COUNT(__d13(__NL(Contact_Suffix_))),COUNT(__d13(__NN(Contact_Suffix_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPostdirectional',COUNT(__d13(__NL(Contact_Postdirectional_))),COUNT(__d13(__NN(Contact_Postdirectional_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSecondaryRange',COUNT(__d13(__NL(Contact_Secondary_Range_))),COUNT(__d13(__NN(Contact_Secondary_Range_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactState',COUNT(__d13(__NL(Contact_State_))),COUNT(__d13(__NN(Contact_State_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactZIP5',COUNT(__d13(__NL(Contact_Z_I_P5_))),COUNT(__d13(__NN(Contact_Z_I_P5_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d13(__NL(Contact_S_S_N_))),COUNT(__d13(__NN(Contact_S_S_N_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d13(__NL(Contact_Phone_Number_))),COUNT(__d13(__NN(Contact_Phone_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d13(__NL(Contact_Score_))),COUNT(__d13(__NN(Contact_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d13(__NL(Contact_Type_))),COUNT(__d13(__NN(Contact_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d13(__NL(Contact_Email_))),COUNT(__d13(__NN(Contact_Email_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d13(__NL(Contact_Email_Username_))),COUNT(__d13(__NN(Contact_Email_Username_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d13(__NL(Contact_Email_Domain_))),COUNT(__d13(__NN(Contact_Email_Domain_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraUltimateLinkID',COUNT(__d13(__NL(Cortera_Ultimate_Link_I_D_))),COUNT(__d13(__NN(Cortera_Ultimate_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorteraLinkID',COUNT(__d13(__NL(Cortera_Link_I_D_))),COUNT(__d13(__NN(Cortera_Link_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactJobTitle',COUNT(__d13(__NL(Contact_Job_Title_))),COUNT(__d13(__NN(Contact_Job_Title_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d13(__NL(Contact_Status_))),COUNT(__d13(__NN(Contact_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationCorpHierarchy',COUNT(__d13(__NL(Location_Corp_Hierarchy_))),COUNT(__d13(__NN(Location_Corp_Hierarchy_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyStatus',COUNT(__d13(__NL(Company_Status_))),COUNT(__d13(__NN(Company_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsClosed',COUNT(__d13(__NL(Is_Closed_))),COUNT(__d13(__NN(Is_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactIsExecutive',COUNT(__d13(__NL(Contact_Is_Executive_))),COUNT(__d13(__NN(Contact_Is_Executive_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsContact',COUNT(__d13(__NL(Is_Contact_))),COUNT(__d13(__NN(Is_Contact_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactExecutiveOrder',COUNT(__d13(__NL(Contact_Executive_Order_))),COUNT(__d13(__NN(Contact_Executive_Order_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordStatus',COUNT(__d13(__NL(Record_Status_))),COUNT(__d13(__NN(Record_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EquifaxID',COUNT(__d13(__NL(Equifax_I_D_))),COUNT(__d13(__NN(Equifax_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSmallBusinessHomeOffice',COUNT(__d13(__NL(Is_Small_Business_Home_Office_))),COUNT(__d13(__NN(Is_Small_Business_Home_Office_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','URL',COUNT(__d13(__NL(U_R_L_))),COUNT(__d13(__NN(U_R_L_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCount',COUNT(__d13(__NL(Employee_Count_))),COUNT(__d13(__NN(Employee_Count_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmployeeCountCode',COUNT(__d13(__NL(Employee_Count_Code_))),COUNT(__d13(__NN(Employee_Count_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountFigure',COUNT(__d13(__NL(Financial_Amount_Figure_))),COUNT(__d13(__NN(Financial_Amount_Figure_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountCode',COUNT(__d13(__NL(Financial_Amount_Code_))),COUNT(__d13(__NN(Financial_Amount_Code_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountType',COUNT(__d13(__NL(Financial_Amount_Type_))),COUNT(__d13(__NN(Financial_Amount_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FinancialAmountPrecision',COUNT(__d13(__NL(Financial_Amount_Precision_))),COUNT(__d13(__NN(Financial_Amount_Precision_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDead',COUNT(__d13(__NL(Is_Dead_))),COUNT(__d13(__NN(Is_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateDead',COUNT(__d13(__NL(Date_Dead_))),COUNT(__d13(__NN(Date_Dead_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrCommercial',COUNT(__d13(__NL(Associated_Addr_Commercial_))),COUNT(__d13(__NN(Associated_Addr_Commercial_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssociatedAddrResidential',COUNT(__d13(__NL(Associated_Addr_Residential_))),COUNT(__d13(__NN(Associated_Addr_Residential_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityScore',COUNT(__d13(__NL(General_Marketability_Score_))),COUNT(__d13(__NN(General_Marketability_Score_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeneralMarketabilityIndicator',COUNT(__d13(__NL(General_Marketability_Indicator_))),COUNT(__d13(__NN(General_Marketability_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVacant',COUNT(__d13(__NL(Is_Vacant_))),COUNT(__d13(__NN(Is_Vacant_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSeasonal',COUNT(__d13(__NL(Is_Seasonal_))),COUNT(__d13(__NN(Is_Seasonal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityOwned',COUNT(__d13(__NL(Is_Minority_Owned_))),COUNT(__d13(__NN(Is_Minority_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwned',COUNT(__d13(__NL(Is_Woman_Owned_))),COUNT(__d13(__NN(Is_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityWomanOwned',COUNT(__d13(__NL(Is_Minority_Woman_Owned_))),COUNT(__d13(__NN(Is_Minority_Woman_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBADisadvantagedOwned',COUNT(__d13(__NL(Is_S_B_A_Disadvantaged_Owned_))),COUNT(__d13(__NN(Is_S_B_A_Disadvantaged_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBAHUBZone',COUNT(__d13(__NL(Is_S_B_A_H_U_B_Zone_))),COUNT(__d13(__NN(Is_S_B_A_H_U_B_Zone_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisadvantageOwned',COUNT(__d13(__NL(Is_Disadvantage_Owned_))),COUNT(__d13(__NN(Is_Disadvantage_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwned',COUNT(__d13(__NL(Is_Veteran_Owned_))),COUNT(__d13(__NN(Is_Veteran_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwned',COUNT(__d13(__NL(Is_Disabled_Vet_Owned_))),COUNT(__d13(__NN(Is_Disabled_Vet_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBA8AOwned',COUNT(__d13(__NL(Is_S_B_A8_A_Owned_))),COUNT(__d13(__NN(Is_S_B_A8_A_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SBA8AOwnedDate',COUNT(__d13(__NL(S_B_A8_A_Owned_Date_))),COUNT(__d13(__NN(S_B_A8_A_Owned_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledOwned',COUNT(__d13(__NL(Is_Disabled_Owned_))),COUNT(__d13(__NN(Is_Disabled_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHistBlackCollege',COUNT(__d13(__NL(Is_Hist_Black_College_))),COUNT(__d13(__NN(Is_Hist_Black_College_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGayLesbianOwned',COUNT(__d13(__NL(Is_Gay_Lesbian_Owned_))),COUNT(__d13(__NN(Is_Gay_Lesbian_Owned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWomanOwnedSBE',COUNT(__d13(__NL(Is_Woman_Owned_S_B_E_))),COUNT(__d13(__NN(Is_Woman_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsVeteranOwnedSBE',COUNT(__d13(__NL(Is_Veteran_Owned_S_B_E_))),COUNT(__d13(__NN(Is_Veteran_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDisabledVetOwnedSBE',COUNT(__d13(__NL(Is_Disabled_Vet_Owned_S_B_E_))),COUNT(__d13(__NN(Is_Disabled_Vet_Owned_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsSBE',COUNT(__d13(__NL(Is_S_B_E_))),COUNT(__d13(__NN(Is_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNotSBE',COUNT(__d13(__NL(Is_Not_S_B_E_))),COUNT(__d13(__NN(Is_Not_S_B_E_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsGoverment',COUNT(__d13(__NL(Is_Goverment_))),COUNT(__d13(__NN(Is_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFederalGoverment',COUNT(__d13(__NL(Is_Federal_Goverment_))),COUNT(__d13(__NN(Is_Federal_Goverment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MerchantType',COUNT(__d13(__NL(Merchant_Type_))),COUNT(__d13(__NN(Merchant_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d13(__NL(Process_Date_))),COUNT(__d13(__NN(Process_Date_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearEstablished',COUNT(__d13(__NL(Year_Established_))),COUNT(__d13(__NN(Year_Established_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublicPrivateIndicator',COUNT(__d13(__NL(Public_Private_Indicator_))),COUNT(__d13(__NN(Public_Private_Indicator_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessSize',COUNT(__d13(__NL(Business_Size_))),COUNT(__d13(__NN(Business_Size_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GovermentType',COUNT(__d13(__NL(Goverment_Type_))),COUNT(__d13(__NN(Goverment_Type_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNonProfit',COUNT(__d13(__NL(Is_Non_Profit_))),COUNT(__d13(__NN(Is_Non_Profit_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinorityWomanStatus',COUNT(__d13(__NL(Minority_Woman_Status_))),COUNT(__d13(__NN(Minority_Woman_Status_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsNMSDCCertified',COUNT(__d13(__NL(Is_N_M_S_D_C_Certified_))),COUNT(__d13(__NN(Is_N_M_S_D_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsWBENCCertified',COUNT(__d13(__NL(Is_W_B_E_N_C_Certified_))),COUNT(__d13(__NN(Is_W_B_E_N_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaPUCCertified',COUNT(__d13(__NL(Is_California_P_U_C_Certified_))),COUNT(__d13(__NN(Is_California_P_U_C_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsTexasHUBCertified',COUNT(__d13(__NL(Is_Texas_H_U_B_Certified_))),COUNT(__d13(__NN(Is_Texas_H_U_B_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCaliforniaCaltransCertified',COUNT(__d13(__NL(Is_California_Caltrans_Certified_))),COUNT(__d13(__NN(Is_California_Caltrans_Certified_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsEducationalInstitution',COUNT(__d13(__NL(Is_Educational_Institution_))),COUNT(__d13(__NN(Is_Educational_Institution_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinorityInstitue',COUNT(__d13(__NL(Is_Minority_Institue_))),COUNT(__d13(__NN(Is_Minority_Institue_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAlaskaNativeCorporation',COUNT(__d13(__NL(Is_Alaska_Native_Corporation_))),COUNT(__d13(__NN(Is_Alaska_Native_Corporation_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenLocation',COUNT(__d13(__NL(Date_Last_Seen_Location_))),COUNT(__d13(__NN(Date_Last_Seen_Location_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateRegusteredAgentResigned',COUNT(__d13(__NL(Date_Regustered_Agent_Resigned_))),COUNT(__d13(__NN(Date_Regustered_Agent_Resigned_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateClosed',COUNT(__d13(__NL(Date_Closed_))),COUNT(__d13(__NN(Date_Closed_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d13(Archive___Date_=0)),COUNT(__d13(Archive___Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d13(Hybrid_Archive_Date_=0)),COUNT(__d13(Hybrid_Archive_Date_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d13(Vault_Date_Last_Seen_=0)),COUNT(__d13(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
