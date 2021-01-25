//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_3,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox_2,B_Business_Prox_3,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Business_Sele_Overflow_1,B_Business_Sele_Overflow_2,B_Business_Sele_Overflow_3,B_Business_Sele_Overflow_4,B_Business_Sele_Overflow_5,B_Business_Sele_Overflow_6,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_First_Degree_Relative_5,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Inquiry_10,B_Inquiry_11,B_Inquiry_3,B_Inquiry_4,B_Inquiry_5,B_Inquiry_6,B_Inquiry_7,B_Inquiry_8,B_Inquiry_9,B_Lien_Judgment_12,B_Lien_Judgment_13,B_Person_10,B_Person_11,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Accident_8,B_Person_Address_3,B_Person_Inquiry_3,B_Person_Inquiry_4,B_Person_Inquiry_5,B_Person_Inquiry_6,B_Person_Inquiry_7,B_Person_Inquiry_8,B_Person_Lien_Judgment_12,B_Person_Property_3,B_Person_Property_4,B_Person_Property_5,B_Person_Property_6,B_Person_Vehicle_3,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property_3,B_Property_4,B_Property_5,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Property_Event_6,B_Sele_Address_1,B_Sele_Address_2,B_Sele_Address_3,B_Sele_Address_4,B_Sele_Address_5,B_Sele_Address_6,B_Sele_Lien_Judgment_11,B_Sele_Person_1,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Sele_Phone_Number_3,B_Sele_Phone_Number_4,B_Sele_Phone_Number_5,B_Sele_Phone_Number_6,B_Sele_Property_1,B_Sele_Property_2,B_Sele_Property_3,B_Sele_Property_4,B_Sele_T_I_N_3,B_Sele_T_I_N_4,B_Sele_T_I_N_5,B_Sele_T_I_N_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_U_C_C_7,B_Sele_U_C_C_8,B_Sele_U_C_C_9,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C_10,B_U_C_C_11,B_U_C_C_12,B_U_C_C_13,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_U_C_C_8,B_U_C_C_9,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Property,E_Address_Property_Event,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Criminal_Offense,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Education,E_Person_Email,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offenses,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_S_S_N_Inquiry,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_T_I_N,E_Tradeline,E_U_C_C,E_Utility_Person,E_Vehicle,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)) __PInputBIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Input_B_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_B_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procbusuid(OVERRIDE:UID|DEFAULT:G___Proc_Bus_U_I_D_:0),Legal_(DEFAULT:Legal_:0),b_inplexidult(DEFAULT:B___Inp_Lex_I_D_Ult_:0),b_inplexidorg(DEFAULT:B___Inp_Lex_I_D_Org_:0),b_inplexidlegal(DEFAULT:B___Inp_Lex_I_D_Legal_:0),b_inplexidsite(DEFAULT:B___Inp_Lex_I_D_Site_:0),b_inplexidloc(DEFAULT:B___Inp_Lex_I_D_Loc_:0),b_inpname(DEFAULT:B___Inp_Name_:\'\'),b_inpaltname(DEFAULT:B___Inp_Alt_Name_:\'\'),b_inpaddrline1(DEFAULT:B___Inp_Addr_Line1_:\'\'),b_inpaddrline2(DEFAULT:B___Inp_Addr_Line2_:\'\'),b_inpaddrcity(DEFAULT:B___Inp_Addr_City_:\'\'),b_inpaddrstate(DEFAULT:B___Inp_Addr_State_:\'\'),b_inpaddrzip(DEFAULT:B___Inp_Addr_Zip_:\'\'),b_inpphone(DEFAULT:B___Inp_Phone_:\'\'),businesstin(DEFAULT:Business_T_I_N_:\'\'),b_inpipaddr(DEFAULT:B___Inp_I_P_Addr_:\'\'),b_inpurl(DEFAULT:B___Inp_U_R_L_:\'\'),b_inpemail(DEFAULT:B___Inp_Email_:\'\'),b_inpsiccode(DEFAULT:B___Inp_S_I_C_Code_:\'\'),b_inpnaicscode(DEFAULT:B___Inp_N_A_I_C_S_Code_:\'\'),b_inptin(DEFAULT:B___Inp_T_I_N_:\'\'),b_inparchdt(DEFAULT:B___Inp_Arch_Dt_:\'\'),b_lexidult(DEFAULT:B___Lex_I_D_Ult_:0),b_lexidorg(DEFAULT:B___Lex_I_D_Org_:0),b_lexidlegal(DEFAULT:B___Lex_I_D_Legal_:0),b_lexidsite(DEFAULT:B___Lex_I_D_Site_:0),b_lexidloc(DEFAULT:B___Lex_I_D_Loc_:0),b_lexidlegalscore(DEFAULT:B___Lex_I_D_Legal_Score_:0),b_lexidlegalwgt(DEFAULT:B___Lex_I_D_Legal_Wgt_:0),b_inpclnname(DEFAULT:B___Inp_Cln_Name_:\'\'),b_inpclnaltname(DEFAULT:B___Inp_Cln_Alt_Name_:\'\'),b_inpclnaddrprimrng(DEFAULT:B___Inp_Cln_Addr_Prim_Rng_:\'\'),b_inpclnaddrpredir(DEFAULT:B___Inp_Cln_Addr_Pre_Dir_:\'\'),b_inpclnaddrprimname(DEFAULT:B___Inp_Cln_Addr_Prim_Name_:\'\'),b_inpclnaddrsffx(DEFAULT:B___Inp_Cln_Addr_Sffx_:\'\'),b_inpclnaddrpostdir(DEFAULT:B___Inp_Cln_Addr_Post_Dir_:\'\'),b_inpclnaddrunitdesig(DEFAULT:B___Inp_Cln_Addr_Unit_Desig_:\'\'),b_inpclnaddrsecrng(DEFAULT:B___Inp_Cln_Addr_Sec_Rng_:\'\'),b_inpclnaddrcity(DEFAULT:B___Inp_Cln_Addr_City_:\'\'),b_inpclnaddrcitypost(DEFAULT:B___Inp_Cln_Addr_City_Post_:\'\'),b_inpclnaddrstate(DEFAULT:B___Inp_Cln_Addr_State_:\'\'),b_inpclnaddrzip5(DEFAULT:B___Inp_Cln_Addr_Zip5_:\'\'),b_inpclnaddrzip4(DEFAULT:B___Inp_Cln_Addr_Zip4_:\'\'),b_inpclnaddrlat(DEFAULT:B___Inp_Cln_Addr_Lat_:\'\'),b_inpclnaddrlng(DEFAULT:B___Inp_Cln_Addr_Lng_:\'\'),b_inpclnaddrstatecode(DEFAULT:B___Inp_Cln_Addr_State_Code_:\'\'),b_inpclnaddrcnty(DEFAULT:B___Inp_Cln_Addr_Cnty_:\'\'),b_inpclnaddrgeo(DEFAULT:B___Inp_Cln_Addr_Geo_:\'\'),b_inpclnaddrtype(DEFAULT:B___Inp_Cln_Addr_Type_:\'\'),b_inpclnaddrstatus(DEFAULT:B___Inp_Cln_Addr_Status_:\'\'),b_inpclnphone(DEFAULT:B___Inp_Cln_Phone_:\'\'),b_inpclnemail(DEFAULT:B___Inp_Cln_Email_:\'\'),b_inpclntin(DEFAULT:B___Inp_Cln_T_I_N_:\'\'),b_inpclnarchdt(DEFAULT:B___Inp_Cln_Arch_Dt_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),archivedate(DEFAULT:Archive_Date_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
    SHARED __d0_Legal__Layout := RECORD
      RECORDOF(__PInputBIIDataset);
      KEL.typ.uid Legal_;
    END;
    SHARED __d0_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__PInputBIIDataset,'B_LexIDUlt,B_LexIDOrg,B_LexIDLegal','__PInputBIIDataset');
    SHARED __d0_Legal__Mapped := IF(__d0_Missing_Legal__UIDComponents = 'B_LexIDUlt,B_LexIDOrg,B_LexIDLegal',PROJECT(__PInputBIIDataset,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__PInputBIIDataset,__d0_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.B_LexIDUlt) + '|' + TRIM((STRING)LEFT.B_LexIDOrg) + '|' + TRIM((STRING)LEFT.B_LexIDLegal) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Prefiltered := __d0_Legal__Mapped((KEL.typ.uid)G_ProcBusUID <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputBIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Input_B_I_I_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_B_I_I_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:P_I_I_:0),g_procbusuid(OVERRIDE:B_I_I_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
    SHARED __d0_Prefiltered := __PInputPIIDataset;
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),subject(DEFAULT:Subject_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexid(DEFAULT:P___Lex_I_D_:0),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),Input_Clean_Email_(DEFAULT:Input_Clean_Email_:0),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'),inputcleanphone(DEFAULT:Input_Clean_Phone_:0),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'),inputcleanssn(DEFAULT:Input_Clean_S_S_N_:0),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
    SHARED __d0_Last_Name__Layout := RECORD
      RECORDOF(__PInputPIIDataset);
      KEL.typ.uid Last_Name_;
    END;
    SHARED __d0_Missing_Last_Name__UIDComponents := KEL.Intake.ConstructMissingFieldList(__PInputPIIDataset,'LastName','__PInputPIIDataset');
    SHARED __d0_Last_Name__Mapped := IF(__d0_Missing_Last_Name__UIDComponents = 'LastName',PROJECT(__PInputPIIDataset,TRANSFORM(__d0_Last_Name__Layout,SELF.Last_Name_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__PInputPIIDataset,__d0_Missing_Last_Name__UIDComponents),E_Surname(__in,__cfg).Lookup,TRIM((STRING)LEFT.LastName) = RIGHT.KeyVal,TRANSFORM(__d0_Last_Name__Layout,SELF.Last_Name_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Prop__Layout := RECORD
      RECORDOF(__d0_Last_Name__Mapped);
      KEL.typ.uid Prop_;
    END;
    SHARED __d0_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Last_Name__Mapped,'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5,P_InpClnAddrSecRng','__PInputPIIDataset');
    SHARED __d0_Prop__Mapped := IF(__d0_Missing_Prop__UIDComponents = 'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5,P_InpClnAddrSecRng',PROJECT(__d0_Last_Name__Mapped,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Last_Name__Mapped,__d0_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPreDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSffx) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPostDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrZip5) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSecRng) = RIGHT.KeyVal,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Location__Layout := RECORD
      RECORDOF(__d0_Prop__Mapped);
      KEL.typ.uid Location_;
    END;
    SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Prop__Mapped,'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5,P_InpClnAddrSecRng','__PInputPIIDataset');
    SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5,P_InpClnAddrSecRng',PROJECT(__d0_Prop__Mapped,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Prop__Mapped,__d0_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPreDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSffx) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPostDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrZip5) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSecRng) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Geo_Link_I_D__Layout := RECORD
      RECORDOF(__d0_Location__Mapped);
      KEL.typ.uid Geo_Link_I_D_;
    END;
    SHARED __d0_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Location__Mapped,'GeoLinkID','__PInputPIIDataset');
    SHARED __d0_Geo_Link_I_D__Mapped := IF(__d0_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d0_Location__Mapped,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Location__Mapped,__d0_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__in,__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Input_Clean_Email__Layout := RECORD
      RECORDOF(__d0_Geo_Link_I_D__Mapped);
      KEL.typ.uid Input_Clean_Email_;
    END;
    SHARED __d0_Missing_Input_Clean_Email__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Geo_Link_I_D__Mapped,'P_InpClnEmail','__PInputPIIDataset');
    SHARED __d0_Input_Clean_Email__Mapped := IF(__d0_Missing_Input_Clean_Email__UIDComponents = 'P_InpClnEmail',PROJECT(__d0_Geo_Link_I_D__Mapped,TRANSFORM(__d0_Input_Clean_Email__Layout,SELF.Input_Clean_Email_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Geo_Link_I_D__Mapped,__d0_Missing_Input_Clean_Email__UIDComponents),E_Email(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnEmail) = RIGHT.KeyVal,TRANSFORM(__d0_Input_Clean_Email__Layout,SELF.Input_Clean_Email_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Prefiltered := __d0_Input_Clean_Email__Mapped((KEL.typ.uid)G_ProcUID <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Accident_Filtered := MODULE(E_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Inquiry_Filtered := MODULE(E_Address_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Filtered := MODULE(E_Address_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Event_Filtered := MODULE(E_Address_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Owner_Filtered := MODULE(E_Aircraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Bankruptcy_Filtered := MODULE(E_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Prox_Filtered := MODULE(E_Business_Prox(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Sele_Filtered := MODULE(E_Business_Sele(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Sele_Overflow_Filtered := MODULE(E_Business_Sele_Overflow(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offense_Filtered := MODULE(E_Criminal_Offense(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_Filtered := MODULE(E_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Filtered := MODULE(E_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Inquiry_Filtered := MODULE(E_Email_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Associations_Filtered := MODULE(E_First_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Relative_Filtered := MODULE(E_First_Degree_Relative(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Filtered := MODULE(E_Household(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Member_Filtered := MODULE(E_Household_Member(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_B_I_I_Filtered := MODULE(E_Input_B_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_B_I_I_Input_P_I_I_Filtered := MODULE(E_Input_B_I_I_Input_P_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Lien_Judgment_Filtered := MODULE(E_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Accident_Filtered := MODULE(E_Person_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Address_Filtered := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Bankruptcy_Filtered := MODULE(E_Person_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Education_Filtered := MODULE(E_Person_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Email_Filtered := MODULE(E_Person_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Inquiry_Filtered := MODULE(E_Person_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Lien_Judgment_Filtered := MODULE(E_Person_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offenses_Filtered := MODULE(E_Person_Offenses(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Filtered := MODULE(E_Person_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Event_Filtered := MODULE(E_Person_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_S_S_N_Filtered := MODULE(E_Person_S_S_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered := MODULE(E_Person_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Inquiry_Filtered := MODULE(E_Phone_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Filtered := MODULE(E_Professional_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Person_Filtered := MODULE(E_Professional_License_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Event_Filtered := MODULE(E_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Address_Filtered := MODULE(E_Prox_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Phone_Number_Filtered := MODULE(E_Prox_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_T_I_N_Filtered := MODULE(E_Prox_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Inquiry_Filtered := MODULE(E_S_S_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Address_Filtered := MODULE(E_Sele_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Aircraft_Filtered := MODULE(E_Sele_Aircraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Bankruptcy_Filtered := MODULE(E_Sele_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered := MODULE(E_Sele_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Phone_Number_Filtered := MODULE(E_Sele_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Property_Filtered := MODULE(E_Sele_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Property_Event_Filtered := MODULE(E_Sele_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_T_I_N_Filtered := MODULE(E_Sele_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Tradeline_Filtered := MODULE(E_Sele_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_U_C_C_Filtered := MODULE(E_Sele_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Vehicle_Filtered := MODULE(E_Sele_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Watercraft_Filtered := MODULE(E_Sele_Watercraft(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Tradeline_Filtered := MODULE(E_Tradeline(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_U_C_C_Filtered := MODULE(E_U_C_C(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Person_Filtered := MODULE(E_Utility_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Vehicle_Filtered := MODULE(E_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Lien_Judgment_13_Local := MODULE(B_Lien_Judgment_13(__in,__cfg_Local))
    SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_13_Local := MODULE(B_U_C_C_13(__in,__cfg_Local))
    SHARED TYPEOF(E_U_C_C(__in,__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_12_Local := MODULE(B_Lien_Judgment_12(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_13(__in,__cfg_Local).__ENH_Lien_Judgment_13) __ENH_Lien_Judgment_13 := B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13;
  END;
  SHARED B_Person_Lien_Judgment_12_Local := MODULE(B_Person_Lien_Judgment_12(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_13(__in,__cfg_Local).__ENH_Lien_Judgment_13) __ENH_Lien_Judgment_13 := B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13;
    SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_12_Local := MODULE(B_U_C_C_12(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_13(__in,__cfg_Local).__ENH_U_C_C_13) __ENH_U_C_C_13 := B_U_C_C_13_Local.__ENH_U_C_C_13;
  END;
  SHARED B_Inquiry_11_Local := MODULE(B_Inquiry_11(__in,__cfg_Local))
    SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  END;
  SHARED B_Person_11_Local := MODULE(B_Person_11(__in,__cfg_Local))
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(B_Person_Lien_Judgment_12(__in,__cfg_Local).__ENH_Person_Lien_Judgment_12) __ENH_Person_Lien_Judgment_12 := B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12;
  END;
  SHARED B_Sele_Lien_Judgment_11_Local := MODULE(B_Sele_Lien_Judgment_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12(__in,__cfg_Local).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
    SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_U_C_C_11_Local := MODULE(B_U_C_C_11(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_12(__in,__cfg_Local).__ENH_U_C_C_12) __ENH_U_C_C_12 := B_U_C_C_12_Local.__ENH_U_C_C_12;
  END;
  SHARED B_Business_Sele_10_Local := MODULE(B_Business_Sele_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered.__Result;
    SHARED TYPEOF(E_Input_B_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg_Local).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11_Local.__ENH_Sele_Lien_Judgment_11;
  END;
  SHARED B_Input_B_I_I_10_Local := MODULE(B_Input_B_I_I_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_B_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
  END;
  SHARED B_Inquiry_10_Local := MODULE(B_Inquiry_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_11(__in,__cfg_Local).__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11_Local.__ENH_Inquiry_11;
  END;
  SHARED B_Person_10_Local := MODULE(B_Person_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_11(__in,__cfg_Local).__ENH_Person_11) __ENH_Person_11 := B_Person_11_Local.__ENH_Person_11;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Tradeline_10_Local := MODULE(B_Tradeline_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Tradeline(__in,__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered.__Result;
  END;
  SHARED B_U_C_C_10_Local := MODULE(B_U_C_C_10(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_11(__in,__cfg_Local).__ENH_U_C_C_11) __ENH_U_C_C_11 := B_U_C_C_11_Local.__ENH_U_C_C_11;
  END;
  SHARED B_Business_Sele_9_Local := MODULE(B_Business_Sele_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_10(__in,__cfg_Local).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10_Local.__ENH_Business_Sele_10;
    SHARED TYPEOF(B_Input_B_I_I_10(__in,__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_B_I_I_9_Local := MODULE(B_Input_B_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_10(__in,__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Inquiry_9_Local := MODULE(B_Inquiry_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_10(__in,__cfg_Local).__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10_Local.__ENH_Inquiry_10;
  END;
  SHARED B_Person_9_Local := MODULE(B_Person_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_10(__in,__cfg_Local).__ENH_Person_10) __ENH_Person_10 := B_Person_10_Local.__ENH_Person_10;
  END;
  SHARED B_Sele_U_C_C_9_Local := MODULE(B_Sele_U_C_C_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered.__Result;
  END;
  SHARED B_Tradeline_9_Local := MODULE(B_Tradeline_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg_Local).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local.__ENH_Tradeline_10;
  END;
  SHARED B_U_C_C_9_Local := MODULE(B_U_C_C_9(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_10(__in,__cfg_Local).__ENH_U_C_C_10) __ENH_U_C_C_10 := B_U_C_C_10_Local.__ENH_U_C_C_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Business_Sele_8_Local := MODULE(B_Business_Sele_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_9(__in,__cfg_Local).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9_Local.__ENH_Business_Sele_9;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_8_Local := MODULE(B_Input_B_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_9(__in,__cfg_Local).__ENH_Input_B_I_I_9) __ENH_Input_B_I_I_9 := B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Inquiry_8_Local := MODULE(B_Inquiry_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_9(__in,__cfg_Local).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
  END;
  SHARED B_Person_8_Local := MODULE(B_Person_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_9(__in,__cfg_Local).__ENH_Person_9) __ENH_Person_9 := B_Person_9_Local.__ENH_Person_9;
  END;
  SHARED B_Person_Accident_8_Local := MODULE(B_Person_Accident_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Accident(__in,__cfg_Local).__Result) __E_Accident := E_Accident_Filtered.__Result;
    SHARED TYPEOF(E_Person_Accident(__in,__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_8_Local := MODULE(B_Person_Inquiry_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_9(__in,__cfg_Local).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
    SHARED TYPEOF(E_Person_Inquiry(__in,__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_8_Local := MODULE(B_Sele_U_C_C_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_9(__in,__cfg_Local).__ENH_Sele_U_C_C_9) __ENH_Sele_U_C_C_9 := B_Sele_U_C_C_9_Local.__ENH_Sele_U_C_C_9;
    SHARED TYPEOF(B_U_C_C_9(__in,__cfg_Local).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Tradeline_8_Local := MODULE(B_Tradeline_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg_Local).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local.__ENH_Tradeline_9;
  END;
  SHARED B_U_C_C_8_Local := MODULE(B_U_C_C_8(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_9(__in,__cfg_Local).__ENH_U_C_C_9) __ENH_U_C_C_9 := B_U_C_C_9_Local.__ENH_U_C_C_9;
  END;
  SHARED B_Bankruptcy_7_Local := MODULE(B_Bankruptcy_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg_Local).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local.__ENH_Bankruptcy_8;
  END;
  SHARED B_Business_Sele_7_Local := MODULE(B_Business_Sele_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_8(__in,__cfg_Local).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local.__ENH_Business_Sele_8;
    SHARED TYPEOF(B_Input_B_I_I_8(__in,__cfg_Local).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_7_Local := MODULE(B_Input_B_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_8(__in,__cfg_Local).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Inquiry_7_Local := MODULE(B_Inquiry_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_8(__in,__cfg_Local).__ENH_Inquiry_8) __ENH_Inquiry_8 := B_Inquiry_8_Local.__ENH_Inquiry_8;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_8(__in,__cfg_Local).__ENH_Person_8) __ENH_Person_8 := B_Person_8_Local.__ENH_Person_8;
    SHARED TYPEOF(B_Person_Accident_8(__in,__cfg_Local).__ENH_Person_Accident_8) __ENH_Person_Accident_8 := B_Person_Accident_8_Local.__ENH_Person_Accident_8;
  END;
  SHARED B_Person_Inquiry_7_Local := MODULE(B_Person_Inquiry_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_8(__in,__cfg_Local).__ENH_Person_Inquiry_8) __ENH_Person_Inquiry_8 := B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8;
  END;
  SHARED B_Sele_Person_7_Local := MODULE(B_Sele_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_7_Local := MODULE(B_Sele_U_C_C_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_8(__in,__cfg_Local).__ENH_Sele_U_C_C_8) __ENH_Sele_U_C_C_8 := B_Sele_U_C_C_8_Local.__ENH_Sele_U_C_C_8;
  END;
  SHARED B_Tradeline_7_Local := MODULE(B_Tradeline_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg_Local).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local.__ENH_Tradeline_8;
  END;
  SHARED B_U_C_C_7_Local := MODULE(B_U_C_C_7(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_8(__in,__cfg_Local).__ENH_U_C_C_8) __ENH_U_C_C_8 := B_U_C_C_8_Local.__ENH_U_C_C_8;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_6_Local := MODULE(B_Bankruptcy_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg_Local).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local.__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local := MODULE(B_Business_Sele_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg_Local).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_Business_Sele_Overflow_6_Local := MODULE(B_Business_Sele_Overflow_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Sele_Overflow(__in,__cfg_Local).__Result) __E_Business_Sele_Overflow := E_Business_Sele_Overflow_Filtered.__Result;
  END;
  SHARED B_Education_6_Local := MODULE(B_Education_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
  END;
  SHARED B_Input_B_I_I_6_Local := MODULE(B_Input_B_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_7(__in,__cfg_Local).__ENH_Input_B_I_I_7) __ENH_Input_B_I_I_7 := B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7(__in,__cfg_Local).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Inquiry_6_Local := MODULE(B_Inquiry_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_7(__in,__cfg_Local).__ENH_Inquiry_7) __ENH_Inquiry_7 := B_Inquiry_7_Local.__ENH_Inquiry_7;
  END;
  SHARED B_Person_6_Local := MODULE(B_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Accident(__in,__cfg_Local).__Result) __E_Accident := E_Accident_Filtered.__Result;
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
    SHARED TYPEOF(B_Person_7(__in,__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_6_Local := MODULE(B_Person_Inquiry_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_7(__in,__cfg_Local).__ENH_Person_Inquiry_7) __ENH_Person_Inquiry_7 := B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7;
  END;
  SHARED B_Person_Property_6_Local := MODULE(B_Person_Property_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Property(__in,__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered.__Result;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Property_Event_6_Local := MODULE(B_Property_Event_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Address_6_Local := MODULE(B_Sele_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered.__Result;
  END;
  SHARED B_Sele_Person_6_Local := MODULE(B_Sele_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_7(__in,__cfg_Local).__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7_Local.__ENH_Sele_Person_7;
  END;
  SHARED B_Sele_Phone_Number_6_Local := MODULE(B_Sele_Phone_Number_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_6_Local := MODULE(B_Sele_T_I_N_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg_Local).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local.__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered.__Result;
  END;
  SHARED B_Sele_U_C_C_6_Local := MODULE(B_Sele_U_C_C_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_7(__in,__cfg_Local).__ENH_Sele_U_C_C_7) __ENH_Sele_U_C_C_7 := B_Sele_U_C_C_7_Local.__ENH_Sele_U_C_C_7;
  END;
  SHARED B_Tradeline_6_Local := MODULE(B_Tradeline_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg_Local).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local.__ENH_Tradeline_7;
  END;
  SHARED B_U_C_C_6_Local := MODULE(B_U_C_C_6(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_7(__in,__cfg_Local).__ENH_U_C_C_7) __ENH_U_C_C_7 := B_U_C_C_7_Local.__ENH_U_C_C_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg_Local).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local := MODULE(B_Business_Sele_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg_Local).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local.__ENH_Business_Sele_6;
    SHARED TYPEOF(B_Sele_Address_6(__in,__cfg_Local).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
    SHARED TYPEOF(B_Sele_Phone_Number_6(__in,__cfg_Local).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
    SHARED TYPEOF(B_Sele_T_I_N_6(__in,__cfg_Local).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
    SHARED TYPEOF(B_Sele_U_C_C_6(__in,__cfg_Local).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
    SHARED TYPEOF(B_U_C_C_6(__in,__cfg_Local).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Business_Sele_Overflow_5_Local := MODULE(B_Business_Sele_Overflow_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_6(__in,__cfg_Local).__ENH_Business_Sele_Overflow_6) __ENH_Business_Sele_Overflow_6 := B_Business_Sele_Overflow_6_Local.__ENH_Business_Sele_Overflow_6;
  END;
  SHARED B_Criminal_Offense_5_Local := MODULE(B_Criminal_Offense_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_6(__in,__cfg_Local).__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_First_Degree_Relative_5_Local := MODULE(B_First_Degree_Relative_5(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_5_Local := MODULE(B_Input_B_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_6(__in,__cfg_Local).__ENH_Input_B_I_I_6) __ENH_Input_B_I_I_6 := B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Inquiry_5_Local := MODULE(B_Inquiry_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_6(__in,__cfg_Local).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6_Local.__ENH_Inquiry_6;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_6(__in,__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
  END;
  SHARED B_Person_Inquiry_5_Local := MODULE(B_Person_Inquiry_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_6(__in,__cfg_Local).__ENH_Person_Inquiry_6) __ENH_Person_Inquiry_6 := B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6;
  END;
  SHARED B_Person_Property_5_Local := MODULE(B_Person_Property_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_6(__in,__cfg_Local).__ENH_Person_Property_6) __ENH_Person_Property_6 := B_Person_Property_6_Local.__ENH_Person_Property_6;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_6(__in,__cfg_Local).__ENH_Property_Event_6) __ENH_Property_Event_6 := B_Property_Event_6_Local.__ENH_Property_Event_6;
  END;
  SHARED B_Professional_License_5_Local := MODULE(B_Professional_License_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  END;
  SHARED B_Property_5_Local := MODULE(B_Property_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  END;
  SHARED B_Property_Event_5_Local := MODULE(B_Property_Event_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_6(__in,__cfg_Local).__ENH_Property_Event_6) __ENH_Property_Event_6 := B_Property_Event_6_Local.__ENH_Property_Event_6;
  END;
  SHARED B_Sele_Address_5_Local := MODULE(B_Sele_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_6(__in,__cfg_Local).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6_Local.__ENH_Sele_Address_6;
  END;
  SHARED B_Sele_Person_5_Local := MODULE(B_Sele_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_6(__in,__cfg_Local).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local.__ENH_Sele_Person_6;
  END;
  SHARED B_Sele_Phone_Number_5_Local := MODULE(B_Sele_Phone_Number_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_6(__in,__cfg_Local).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6;
  END;
  SHARED B_Sele_T_I_N_5_Local := MODULE(B_Sele_T_I_N_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_6(__in,__cfg_Local).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6;
  END;
  SHARED B_Sele_U_C_C_5_Local := MODULE(B_Sele_U_C_C_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_6(__in,__cfg_Local).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6;
  END;
  SHARED B_Tradeline_5_Local := MODULE(B_Tradeline_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg_Local).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local.__ENH_Tradeline_6;
  END;
  SHARED B_U_C_C_5_Local := MODULE(B_U_C_C_5(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_6(__in,__cfg_Local).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local.__ENH_U_C_C_6;
  END;
  SHARED B_Address_4_Local := MODULE(B_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
  END;
  SHARED B_Bankruptcy_4_Local := MODULE(B_Bankruptcy_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Sele_4_Local := MODULE(B_Business_Sele_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg_Local).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local.__ENH_Business_Sele_5;
    SHARED TYPEOF(B_Sele_Address_5(__in,__cfg_Local).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg_Local).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg_Local).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg_Local).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Business_Sele_Overflow_4_Local := MODULE(B_Business_Sele_Overflow_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_5(__in,__cfg_Local).__ENH_Business_Sele_Overflow_5) __ENH_Business_Sele_Overflow_5 := B_Business_Sele_Overflow_5_Local.__ENH_Business_Sele_Overflow_5;
  END;
  SHARED B_Criminal_Offense_4_Local := MODULE(B_Criminal_Offense_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_5(__in,__cfg_Local).__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5;
  END;
  SHARED B_Education_4_Local := MODULE(B_Education_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_5(__in,__cfg_Local).__ENH_Education_5) __ENH_Education_5 := B_Education_5_Local.__ENH_Education_5;
  END;
  SHARED B_Input_B_I_I_4_Local := MODULE(B_Input_B_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_5(__in,__cfg_Local).__ENH_Input_B_I_I_5) __ENH_Input_B_I_I_5 := B_Input_B_I_I_5_Local.__ENH_Input_B_I_I_5;
  END;
  SHARED B_Input_P_I_I_4_Local := MODULE(B_Input_P_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_Inquiry_4_Local := MODULE(B_Inquiry_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_5(__in,__cfg_Local).__ENH_Inquiry_5) __ENH_Inquiry_5 := B_Inquiry_5_Local.__ENH_Inquiry_5;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(E_Household(__in,__cfg_Local).__Result) __E_Household := E_Household_Filtered.__Result;
    SHARED TYPEOF(E_Household_Member(__in,__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
    SHARED TYPEOF(B_Person_5(__in,__cfg_Local).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Person_Inquiry_5(__in,__cfg_Local).__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5;
    SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_4_Local := MODULE(B_Person_Inquiry_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_5(__in,__cfg_Local).__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5;
  END;
  SHARED B_Person_Property_4_Local := MODULE(B_Person_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_5(__in,__cfg_Local).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5_Local.__ENH_Person_Property_5;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_5(__in,__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
    SHARED TYPEOF(B_Property_Event_5(__in,__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
  END;
  SHARED B_Professional_License_4_Local := MODULE(B_Professional_License_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg_Local).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local.__ENH_Professional_License_5;
  END;
  SHARED B_Property_4_Local := MODULE(B_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_5(__in,__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
  END;
  SHARED B_Property_Event_4_Local := MODULE(B_Property_Event_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__in,__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
  END;
  SHARED B_Sele_Address_4_Local := MODULE(B_Sele_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_5(__in,__cfg_Local).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5_Local.__ENH_Sele_Address_5;
  END;
  SHARED B_Sele_Person_4_Local := MODULE(B_Sele_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__in,__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
  END;
  SHARED B_Sele_Phone_Number_4_Local := MODULE(B_Sele_Phone_Number_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_5(__in,__cfg_Local).__ENH_Sele_Phone_Number_5) __ENH_Sele_Phone_Number_5 := B_Sele_Phone_Number_5_Local.__ENH_Sele_Phone_Number_5;
  END;
  SHARED B_Sele_Property_4_Local := MODULE(B_Sele_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__in,__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
    SHARED TYPEOF(E_Sele_Property(__in,__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_T_I_N_4_Local := MODULE(B_Sele_T_I_N_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_5(__in,__cfg_Local).__ENH_Sele_T_I_N_5) __ENH_Sele_T_I_N_5 := B_Sele_T_I_N_5_Local.__ENH_Sele_T_I_N_5;
  END;
  SHARED B_Sele_U_C_C_4_Local := MODULE(B_Sele_U_C_C_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg_Local).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5;
  END;
  SHARED B_Tradeline_4_Local := MODULE(B_Tradeline_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg_Local).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local.__ENH_Tradeline_5;
  END;
  SHARED B_U_C_C_4_Local := MODULE(B_U_C_C_4(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg_Local).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local.__ENH_U_C_C_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
  END;
  SHARED B_Aircraft_Owner_3_Local := MODULE(B_Aircraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_3_Local := MODULE(B_Bankruptcy_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local := MODULE(B_Business_Prox_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  END;
  SHARED B_Business_Sele_3_Local := MODULE(B_Business_Sele_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
    SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg_Local).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local.__ENH_Business_Sele_4;
    SHARED TYPEOF(B_Business_Sele_Overflow_4(__in,__cfg_Local).__ENH_Business_Sele_Overflow_4) __ENH_Business_Sele_Overflow_4 := B_Business_Sele_Overflow_4_Local.__ENH_Business_Sele_Overflow_4;
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
    SHARED TYPEOF(B_Sele_Address_4(__in,__cfg_Local).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
    SHARED TYPEOF(B_Sele_Property_4(__in,__cfg_Local).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg_Local).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg_Local).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Business_Sele_Overflow_3_Local := MODULE(B_Business_Sele_Overflow_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_4(__in,__cfg_Local).__ENH_Business_Sele_Overflow_4) __ENH_Business_Sele_Overflow_4 := B_Business_Sele_Overflow_4_Local.__ENH_Business_Sele_Overflow_4;
  END;
  SHARED B_Criminal_Offense_3_Local := MODULE(B_Criminal_Offense_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
  END;
  SHARED B_Education_3_Local := MODULE(B_Education_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_4(__in,__cfg_Local).__ENH_Education_4) __ENH_Education_4 := B_Education_4_Local.__ENH_Education_4;
  END;
  SHARED B_Input_B_I_I_3_Local := MODULE(B_Input_B_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_4(__in,__cfg_Local).__ENH_Input_B_I_I_4) __ENH_Input_B_I_I_4 := B_Input_B_I_I_4_Local.__ENH_Input_B_I_I_4;
  END;
  SHARED B_Input_P_I_I_3_Local := MODULE(B_Input_P_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
    SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Inquiry_4(__in,__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Inquiry_3_Local := MODULE(B_Inquiry_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_4(__in,__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
    SHARED TYPEOF(E_Household_Member(__in,__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Inquiry_4(__in,__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Person_Inquiry_4(__in,__cfg_Local).__ENH_Person_Inquiry_4) __ENH_Person_Inquiry_4 := B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_4(__in,__cfg_Local).__ENH_Person_Property_4) __ENH_Person_Property_4 := B_Person_Property_4_Local.__ENH_Person_Property_4;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  END;
  SHARED B_Person_Address_3_Local := MODULE(B_Person_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_3_Local := MODULE(B_Person_Inquiry_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_4(__in,__cfg_Local).__ENH_Person_Inquiry_4) __ENH_Person_Inquiry_4 := B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4;
  END;
  SHARED B_Person_Property_3_Local := MODULE(B_Person_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_4(__in,__cfg_Local).__ENH_Person_Property_4) __ENH_Person_Property_4 := B_Person_Property_4_Local.__ENH_Person_Property_4;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Person_Vehicle_3_Local := MODULE(B_Person_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Property_3_Local := MODULE(B_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Property_Event_3_Local := MODULE(B_Property_Event_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Sele_Address_3_Local := MODULE(B_Sele_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_4(__in,__cfg_Local).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4_Local.__ENH_Sele_Address_4;
  END;
  SHARED B_Sele_Person_3_Local := MODULE(B_Sele_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
  END;
  SHARED B_Sele_Phone_Number_3_Local := MODULE(B_Sele_Phone_Number_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Phone_Number_4(__in,__cfg_Local).__ENH_Sele_Phone_Number_4) __ENH_Sele_Phone_Number_4 := B_Sele_Phone_Number_4_Local.__ENH_Sele_Phone_Number_4;
  END;
  SHARED B_Sele_Property_3_Local := MODULE(B_Sele_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Property_4(__in,__cfg_Local).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4_Local.__ENH_Sele_Property_4;
  END;
  SHARED B_Sele_T_I_N_3_Local := MODULE(B_Sele_T_I_N_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_T_I_N_4(__in,__cfg_Local).__ENH_Sele_T_I_N_4) __ENH_Sele_T_I_N_4 := B_Sele_T_I_N_4_Local.__ENH_Sele_T_I_N_4;
  END;
  SHARED B_Sele_Tradeline_3_Local := MODULE(B_Sele_Tradeline_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_Sele_U_C_C_3_Local := MODULE(B_Sele_U_C_C_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg_Local).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4;
  END;
  SHARED B_Sele_Vehicle_3_Local := MODULE(B_Sele_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered.__Result;
  END;
  SHARED B_Tradeline_3_Local := MODULE(B_Tradeline_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg_Local).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local.__ENH_Tradeline_4;
  END;
  SHARED B_U_C_C_3_Local := MODULE(B_U_C_C_3(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg_Local).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local.__ENH_U_C_C_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_2_Local := MODULE(B_Bankruptcy_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
  END;
  SHARED B_Business_Prox_2_Local := MODULE(B_Business_Prox_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  END;
  SHARED B_Business_Sele_2_Local := MODULE(B_Business_Sele_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg_Local).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local.__ENH_Business_Sele_3;
    SHARED TYPEOF(B_Business_Sele_Overflow_3(__in,__cfg_Local).__ENH_Business_Sele_Overflow_3) __ENH_Business_Sele_Overflow_3 := B_Business_Sele_Overflow_3_Local.__ENH_Business_Sele_Overflow_3;
    SHARED TYPEOF(B_Input_B_I_I_3(__in,__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Sele_Address_3(__in,__cfg_Local).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(B_Sele_Phone_Number_3(__in,__cfg_Local).__ENH_Sele_Phone_Number_3) __ENH_Sele_Phone_Number_3 := B_Sele_Phone_Number_3_Local.__ENH_Sele_Phone_Number_3;
    SHARED TYPEOF(B_Sele_Property_3(__in,__cfg_Local).__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(B_Sele_T_I_N_3(__in,__cfg_Local).__ENH_Sele_T_I_N_3) __ENH_Sele_T_I_N_3 := B_Sele_T_I_N_3_Local.__ENH_Sele_T_I_N_3;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg_Local).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_U_C_C_3(__in,__cfg_Local).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg_Local).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg_Local).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
    SHARED TYPEOF(B_U_C_C_3(__in,__cfg_Local).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Business_Sele_Overflow_2_Local := MODULE(B_Business_Sele_Overflow_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_3(__in,__cfg_Local).__ENH_Business_Sele_Overflow_3) __ENH_Business_Sele_Overflow_3 := B_Business_Sele_Overflow_3_Local.__ENH_Business_Sele_Overflow_3;
  END;
  SHARED B_Input_B_I_I_2_Local := MODULE(B_Input_B_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_3(__in,__cfg_Local).__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Input_P_I_I_2_Local := MODULE(B_Input_P_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Email_Inquiry(__in,__cfg_Local).__Result) __E_Email_Inquiry := E_Email_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_Inquiry_3(__in,__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
    SHARED TYPEOF(E_Phone_Inquiry(__in,__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered.__Result;
    SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered.__Result;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Education_3(__in,__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
    SHARED TYPEOF(B_Inquiry_3(__in,__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(B_Person_Inquiry_3(__in,__cfg_Local).__ENH_Person_Inquiry_3) __ENH_Person_Inquiry_3 := B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_3(__in,__cfg_Local).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3_Local.__ENH_Person_Property_3;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Property_Event_2_Local := MODULE(B_Property_Event_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Sele_Address_2_Local := MODULE(B_Sele_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_3(__in,__cfg_Local).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3_Local.__ENH_Sele_Address_3;
  END;
  SHARED B_Sele_Person_2_Local := MODULE(B_Sele_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
  END;
  SHARED B_Sele_Property_2_Local := MODULE(B_Sele_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_3(__in,__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
    SHARED TYPEOF(B_Sele_Property_3(__in,__cfg_Local).__ENH_Sele_Property_3) __ENH_Sele_Property_3 := B_Sele_Property_3_Local.__ENH_Sele_Property_3;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Tradeline_2_Local := MODULE(B_Sele_Tradeline_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg_Local).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_U_C_C_2_Local := MODULE(B_Sele_U_C_C_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_U_C_C_3(__in,__cfg_Local).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3;
  END;
  SHARED B_Sele_Vehicle_2_Local := MODULE(B_Sele_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg_Local).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local := MODULE(B_Tradeline_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg_Local).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local.__ENH_Tradeline_3;
  END;
  SHARED B_U_C_C_2_Local := MODULE(B_U_C_C_2(__in,__cfg_Local))
    SHARED TYPEOF(B_U_C_C_3(__in,__cfg_Local).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local.__ENH_U_C_C_3;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Bankruptcy_1_Local := MODULE(B_Bankruptcy_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Sele_1_Local := MODULE(B_Business_Sele_1(__in,__cfg_Local))
    SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg_Local).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local.__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Business_Sele_Overflow_2(__in,__cfg_Local).__ENH_Business_Sele_Overflow_2) __ENH_Business_Sele_Overflow_2 := B_Business_Sele_Overflow_2_Local.__ENH_Business_Sele_Overflow_2;
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Address_2(__in,__cfg_Local).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_2(__in,__cfg_Local).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
    SHARED TYPEOF(B_Sele_Property_2(__in,__cfg_Local).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg_Local).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_U_C_C_2(__in,__cfg_Local).__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2_Local.__ENH_Sele_U_C_C_2;
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg_Local).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg_Local).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
    SHARED TYPEOF(B_U_C_C_2(__in,__cfg_Local).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local.__ENH_U_C_C_2;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Business_Sele_Overflow_1_Local := MODULE(B_Business_Sele_Overflow_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Sele_Overflow_2(__in,__cfg_Local).__ENH_Business_Sele_Overflow_2) __ENH_Business_Sele_Overflow_2 := B_Business_Sele_Overflow_2_Local.__ENH_Business_Sele_Overflow_2;
  END;
  SHARED B_Input_B_I_I_1_Local := MODULE(B_Input_B_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Sele_Address_1_Local := MODULE(B_Sele_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Address_2(__in,__cfg_Local).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2_Local.__ENH_Sele_Address_2;
  END;
  SHARED B_Sele_Person_1_Local := MODULE(B_Sele_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_2(__in,__cfg_Local).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local.__ENH_Sele_Person_2;
  END;
  SHARED B_Sele_Property_1_Local := MODULE(B_Sele_Property_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Sele_Property_2(__in,__cfg_Local).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2_Local.__ENH_Sele_Property_2;
    SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered.__Result;
  END;
  SHARED B_Sele_Tradeline_1_Local := MODULE(B_Sele_Tradeline_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg_Local).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local := MODULE(B_Sele_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg_Local).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Tradeline_1_Local := MODULE(B_Tradeline_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg_Local).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local.__ENH_Tradeline_2;
  END;
  SHARED B_Business_Sele_Local := MODULE(B_Business_Sele(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1(__in,__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1(__in,__cfg_Local).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local.__ENH_Business_Sele_1;
    SHARED TYPEOF(B_Business_Sele_Overflow_1(__in,__cfg_Local).__ENH_Business_Sele_Overflow_1) __ENH_Business_Sele_Overflow_1 := B_Business_Sele_Overflow_1_Local.__ENH_Business_Sele_Overflow_1;
    SHARED TYPEOF(B_Input_B_I_I_1(__in,__cfg_Local).__ENH_Input_B_I_I_1) __ENH_Input_B_I_I_1 := B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1;
    SHARED TYPEOF(B_Sele_Address_1(__in,__cfg_Local).__ENH_Sele_Address_1) __ENH_Sele_Address_1 := B_Sele_Address_1_Local.__ENH_Sele_Address_1;
    SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered.__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_1(__in,__cfg_Local).__ENH_Sele_Person_1) __ENH_Sele_Person_1 := B_Sele_Person_1_Local.__ENH_Sele_Person_1;
    SHARED TYPEOF(B_Sele_Property_1(__in,__cfg_Local).__ENH_Sele_Property_1) __ENH_Sele_Property_1 := B_Sele_Property_1_Local.__ENH_Sele_Property_1;
    SHARED TYPEOF(B_Sele_Tradeline_1(__in,__cfg_Local).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local.__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1(__in,__cfg_Local).__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local.__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered.__Result;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg_Local).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local.__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle(__in,__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local.__ENH_Business_Sele;
  SHARED __EE11567002 := __ENH_Business_Sele;
  SHARED __EE11570428 := __EE11567002(__T(__AND(__OP2(__EE11567002.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE11567002.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE11567002.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST118818_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.str B___Lex_I_D_Legal_Seen_Flag_ := '';
    KEL.typ.nstr B_E___Ver_Src_List_Ev_;
    KEL.typ.nint B_E___Ver_Src_Cnt_Ev_;
    KEL.typ.nstr B_E___Ver_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Ver_Src_New_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Src_Old_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_Src_New_Msnc_Ev_;
    KEL.typ.str B_E___Ver_Src_Rpt_New_Bus_Flag_ := '';
    KEL.typ.nint B_E___Ver_Src_Cred_Cnt_Ev_;
    KEL.typ.str B_E___Ver_Src_Bureau_Flag_ := '';
    KEL.typ.nstr B_E___Ver_Src_Bureau_Old_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Src_Bureau_Old_Msnc_Ev_;
    KEL.typ.int B_E___D_B_A_Name_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Addr_P_O_Box_Flag_ := 0;
    KEL.typ.int B_E___U_R_L_Flag_ := 0;
    KEL.typ.int B_E___Ver_Name_Flag_ := 0;
    KEL.typ.nstr B_E___Ver_Name_Src_List_Ev_;
    KEL.typ.nint B_E___Ver_Name_Src_Cnt_Ev_;
    KEL.typ.nstr B_E___Ver_Name_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Name_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Name_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Ver_Name_Src_New_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Name_Src_Old_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_Name_Src_New_Msnc_Ev_;
    KEL.typ.int B_E___Ver_Addr_Flag_ := 0;
    KEL.typ.nstr B_E___Ver_Addr_Src_List_Ev_;
    KEL.typ.nint B_E___Ver_Addr_Src_Cnt_Ev_;
    KEL.typ.nstr B_E___Ver_Addr_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Addr_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Addr_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Ver_Addr_Src_New_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Addr_Src_Old_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_Addr_Src_New_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_Addr_Src_Dt_Span_Ev_;
    KEL.typ.int B_E___Ver_T_I_N_Flag_ := 0;
    KEL.typ.nstr B_E___Ver_T_I_N_Src_List_Ev_;
    KEL.typ.nint B_E___Ver_T_I_N_Src_Cnt_Ev_;
    KEL.typ.nstr B_E___Ver_T_I_N_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_T_I_N_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_T_I_N_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Ver_T_I_N_Src_New_Dt_Ev_;
    KEL.typ.nint B_E___Ver_T_I_N_Src_Old_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_T_I_N_Src_New_Msnc_Ev_;
    KEL.typ.int B_E___Ver_Phone_Flag_ := 0;
    KEL.typ.nstr B_E___Ver_Phone_Src_List_Ev_;
    KEL.typ.nint B_E___Ver_Phone_Src_Cnt_Ev_;
    KEL.typ.nstr B_E___Ver_Phone_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Phone_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Phone_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Ver_Phone_Src_New_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Phone_Src_Old_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_Phone_Src_New_Msnc_Ev_;
    KEL.typ.nint B_E___B2_B_Cnt_Ev_;
    KEL.typ.int B_E___B2_B_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt2_Y_ := 0;
    KEL.typ.float B_E___B2_B_Carr_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Flt_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Mat_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Ops_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Oth_Pct2_Y_ := 0.0;
    KEL.typ.nstr B_E___B2_B_Old_Dt_Ev_;
    KEL.typ.nint B_E___B2_B_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___B2_B_Old_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_New_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Old_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_New_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Actv_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Pct_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_;
    KEL.typ.int B_E___B2_B_Actv_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Bal_Max_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max_Msnc2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Seg_Type2_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Worst_Perf_Indx_;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.str B_E___B2_B_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Carr_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Flt_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Mat_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Ops_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Oth_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.nstr B_E___B2_B_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Worst_Perf_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_ := 0;
    KEL.typ.str B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.nint B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Carr_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Flt_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Mat_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Ops_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Oth_Bal_Vol24_Mc_;
    KEL.typ.int B_E___Ast_Veh_Air_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Ast_Veh_Wtr_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Pers_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Comm_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Other_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Val_Tot2_Y_ := 0;
    KEL.typ.nint B_E___Ast_Veh_Auto_Emrg_New_Msnc_Ev_;
    KEL.typ.nstr B_E___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.int B_E___Ast_Prop_Cnt_Ev_ := 0;
    KEL.typ.nint B_E___Ast_Prop_State_Cnt_Ev_;
    KEL.typ.int B_E___Ast_Prop_Curr_Cnt_ := 0;
    KEL.typ.nint B_E___Ast_Prop_Curr_State_Cnt_;
    KEL.typ.nstr B_E___Ast_Prop_Old_Dt_Ev_;
    KEL.typ.nint B_E___Ast_Prop_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___Ast_Prop_New_Dt_Ev_;
    KEL.typ.nint B_E___Ast_Prop_New_Msnc_Ev_;
    KEL.typ.int B_E___Ast_Prop_Curr_Tax_Val_Tot_ := 0;
    KEL.typ.int B_E___Ast_Prop_Curr_Mkt_Val_Tot_ := 0;
    KEL.typ.int B_E___Ast_Prop_Curr_Val_Tot_ := 0;
    KEL.typ.float B_E___Ast_Prop_Curr_Lot_Size_Tot_ := 0.0;
    KEL.typ.int B_E___Ast_Prop_Curr_Bldg_Size_Tot_ := 0;
    KEL.typ.nint B_E___Ast_Prop_Indx_Ev_;
    KEL.typ.int B_E___Drg_Bk_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Bk_Old_Dt10_Y_;
    KEL.typ.nint B_E___Drg_Bk_Old_Msnc10_Y_;
    KEL.typ.nstr B_E___Drg_Bk_New_Dt10_Y_;
    KEL.typ.nint B_E___Drg_Bk_New_Msnc10_Y_;
    KEL.typ.nstr B_E___Drg_Bk_Updt_New_Dt10_Y_;
    KEL.typ.nstr B_E___Drg_Bk_Updt_New_Msnc10_Y_;
    KEL.typ.int B_E___Drg_Bk_Disp_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Dsch_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Dsms_Cnt10_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Bk_New_Disp_Type10_Y_;
    KEL.typ.int B_E___Drg_Bk_Ch7_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Ch11_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Ch13_Cnt10_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Bk_New_Ch_Type10_Y_;
    KEL.typ.int B_E___S_O_S_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___S_O_S_New_Dt_Ev_;
    KEL.typ.nstr B_E___S_O_S_Old_Dt_Ev_;
    KEL.typ.nint B_E___S_O_S_New_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_Old_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_State_Cnt_Ev_;
    KEL.typ.int B_E___S_O_S_Dom_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___S_O_S_Dom_New_Dt_Ev_;
    KEL.typ.nstr B_E___S_O_S_Dom_Old_Dt_Ev_;
    KEL.typ.nint B_E___S_O_S_Dom_New_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_Dom_Old_Msnc_Ev_;
    KEL.typ.int B_E___S_O_S_Frgn_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___S_O_S_Frgn_New_Dt_Ev_;
    KEL.typ.nstr B_E___S_O_S_Frgn_Old_Dt_Ev_;
    KEL.typ.nint B_E___S_O_S_Frgn_New_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_Frgn_Old_Msnc_Ev_;
    KEL.typ.int B_E___S_O_S_Dom_Status_Indx_Ev_ := 0;
    KEL.typ.nstr B_E___Best_Name_;
    KEL.typ.nint B_E___Best_Addr_Loc_I_D_;
    KEL.typ.nstr B_E___Best_Addr_St_;
    KEL.typ.nstr B_E___Best_Addr_City_;
    KEL.typ.nstr B_E___Best_Addr_City_Post_;
    KEL.typ.nstr B_E___Best_Addr_State_;
    KEL.typ.nstr B_E___Best_Addr_Zip_;
    KEL.typ.nstr B_E___Best_T_I_N_;
    KEL.typ.nstr B_E___Best_Phone_;
    KEL.typ.nstr B_E___Drg_Gov_Debarred_Flag_Ev_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code1_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code1_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code1_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_S_I_C_Code2_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code2_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code2_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_S_I_C_Code3_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code3_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code3_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_S_I_C_Code4_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code4_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code4_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code1_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code1_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code1_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code2_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code2_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code2_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code3_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code3_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code3_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code4_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code4_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code4_Group_Desc_ := '';
    KEL.typ.nint B_E___Bus_Empl_Count_Curr_;
    KEL.typ.int B_E___Bus_Empl_Count_Curr_Rnge_ := 0;
    KEL.typ.nint B_E___Bus_Annual_Sales_Curr_;
    KEL.typ.str B_E___Bus_Annual_Sales_Curr_Rnge_ := '';
    KEL.typ.str B_E___Bus_Is_Non_Profit_Flag_ := '';
    KEL.typ.str B_E___Bus_Is_Franchise_Flag_ := '';
    KEL.typ.str B_E___Bus_Offers401k_Flag_ := '';
    KEL.typ.str B_E___Bus_Has_New_Location_Flag1_Y_ := '';
    KEL.typ.int B_E___Bus_Loc_Actv_Cnt_ := 0;
    KEL.typ.str B_E___Bus_Is_S_B_E_Flag_ := '';
    KEL.typ.nstr B_E___Bus_Infer_Female_Owned_Flag_;
    KEL.typ.nstr B_E___Bus_Infer_Family_Owned_Flag_;
    KEL.typ.str B_E___Bus_Is_Female_Owned_Flag_ := '';
    KEL.typ.str B_E___Bus_Is_Minority_Owned_Flag_ := '';
    KEL.typ.str B_E___Bus_Is_Public_Flag_ := '';
    KEL.typ.int B_E___Drg_L_T_D_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_L_T_D_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_L_T_D_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_L_T_D_New_Dt7_Y_;
    KEL.typ.nstr B_E___Drg_L_T_D_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_L_T_D_New_Msnc7_Y_;
    KEL.typ.nint B_E___Drg_L_T_D_Old_Msnc7_Y_;
    KEL.typ.int B_E___U_C_C_Cnt_Ev_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___U_C_C_Debtor_Old_Dt_Ev_;
    KEL.typ.nint B_E___U_C_C_Debtor_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___U_C_C_Debtor_New_Dt_Ev_;
    KEL.typ.nint B_E___U_C_C_Debtor_New_Msnc_Ev_;
    KEL.typ.int B_E___U_C_C_Actv_Cnt_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Actv_Cnt_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Term_Cnt_Ev_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Other_Cnt_Ev_ := 0;
    KEL.typ.float B_E___U_C_C_Debtor_Actv_Pct_ := 0.0;
    KEL.typ.float B_E___U_C_C_Debtor_Term_Pct_Ev_ := 0.0;
    KEL.typ.float B_E___U_C_C_Debtor_Other_Pct_Ev_ := 0.0;
    KEL.typ.nstr B_E___U_C_C_Debtor_Term_New_Dt_Ev_;
    KEL.typ.nint B_E___U_C_C_Debtor_Term_New_Msnc_Ev_;
    KEL.typ.int B_E___U_C_C_Creditor_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___U_C_C_Role_Indx_Ev_;
    KEL.typ.nstr B_E___U_C_C_Actv_Role_Indx_;
    KEL.typ.int B_E___Drg_Lien_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_Lien_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_Lien_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_Fed_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_Fed_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Fed_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Fed_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Fed_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Fed_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_State_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_State_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_State_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_State_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_State_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_State_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_Other_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_Other_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Other_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Other_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Other_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Other_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Other_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Other_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Other_New_Dt7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Other_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Other_New_Msnc7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Other_Old_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_Judg_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_Judg_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Civ_Crt_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Civ_Crt_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Judg_Civ_Crt_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Civ_Crt_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_Civ_Crt_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Civ_Crt_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Sm_Claim_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Sm_Claim_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Judg_Sm_Claim_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Sm_Claim_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_Sm_Claim_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Sm_Claim_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Frcl_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Frcl_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Judg_Frcl_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Frcl_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_Frcl_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Frcl_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Ln_J_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Ln_J_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_Ln_J_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_Ln_J_New_Dt7_Y_;
    KEL.typ.nstr B_E___Drg_Ln_J_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Ln_J_New_Msnc7_Y_;
    KEL.typ.nint B_E___Drg_Ln_J_Old_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Suit_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Suit_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Suit_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Suit_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Suit_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Suit_New_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_New_Type7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_New_Type7_Y_;
    KEL.typ.int B_E___Drg_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Cnt7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Flag7_Y_;
    KEL.typ.nstr B_E___Drg_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_New_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Old_Msnc7_Y_;
    KEL.typ.int B_E___Assoc_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Assoc_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Pct2_Y_ := 0.0;
    KEL.typ.int B_E___Assoc_Exec_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Assoc_Exec_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Exec_Pct2_Y_ := 0.0;
    KEL.typ.int B_E___Assoc_Nexec_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Nexec_Pct2_Y_ := 0.0;
    KEL.typ.str B_E___Assoc_Email_Flag2_Y_ := '';
    KEL.typ.str B_E___Assoc_Exec_Email_Flag2_Y_ := '';
    KEL.typ.str B_E___Assoc_Nexec_Email_Flag2_Y_ := '';
    KEL.typ.nint B_E___Assoc_Age_Avg2_Y_;
    KEL.typ.nint B_E___Assoc_Exec_Age_Avg2_Y_;
    KEL.typ.nint B_E___Assoc_Nexec_Age_Avg2_Y_;
    KEL.typ.int B_E___Assoc_W_Edu_Coll_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Edu_Coll_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Edu_Coll_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Crim_Fel_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Crim_Fel_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Crim_Fel_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Crim_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Crim_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Crim_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Bk_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Bk_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Bk_Cnt2_Y_ := 0;
    KEL.typ.nint B_E___Assoc_Emrg_Msnc_Avg2_Y_;
    KEL.typ.nint B_E___Assoc_Exec_Emrg_Msnc_Avg2_Y_;
    KEL.typ.nint B_E___Assoc_Nexec_Emrg_Msnc_Avg2_Y_;
    KEL.typ.int B_E___Assoc_Exec_Female_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Exec_Female_Pct2_Y_ := 0.0;
    KEL.typ.int B_E___Assoc_Exec_Related_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Exec_Related_Pct2_Y_ := 0.0;
    KEL.typ.int B_E___Assoc_W_Drg_Judg_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Judg_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Judg_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_L_T_D_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_L_T_D_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_L_T_D_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Lien_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Lien_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Lien_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Bus_Cnt_Avg2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_Bus_Cnt_Avg2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_Bus_Cnt_Avg2_Y_ := 0;
    KEL.typ.int B_E___Best_Addr_Seen_Flag_ := 0;
    KEL.typ.nstr B_E___Best_Addr_Src_List_Ev_;
    KEL.typ.int B_E___Best_Addr_Src_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___Best_Addr_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Best_Addr_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Best_Addr_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Best_Addr_Src_New_Dt_Ev_;
    KEL.typ.nstr B_E___Best_Addr_Src_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___Best_Addr_Src_New_Msnc_Ev_;
    KEL.typ.str B_E___Best_Addr_Is_Residential_Flag_ := '';
    KEL.typ.str B_E___Bus_Is_Residential_Flag_ := '';
    KEL.typ.int B_E___Best_Addr_Bldg_Is_Multi_Unit_Flag_ := 0;
    KEL.typ.nstr B_E___Best_Addr_Bldg_Type_;
    KEL.typ.int B_E___Best_Addr_Is_P_O_Box_Flag_ := 0;
    KEL.typ.int B_E___Best_Addr_Is_Vacant_Flag_ := 0;
    KEL.typ.int B_E___Best_Addr_Is_Owned_Flag_ := 0;
    KEL.typ.nint B_E___Best_Addr_New_Mkt_Val_Ev_;
    KEL.typ.nint B_E___Best_Addr_New_Tax_Val_Ev_;
    KEL.typ.nstr B_E___Best_Addr_New_Mkt_Val_Yr_Ev_;
    KEL.typ.nstr B_E___Best_Addr_New_Tax_Val_Yr_Ev_;
    KEL.typ.nfloat B_E___Best_Addr_Lot_Size_;
    KEL.typ.nint B_E___Best_Addr_Bldg_Size_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST118818_Layout __ND11570433__Project(B_Business_Sele(__in,__cfg_Local).__ST144914_Layout __PP11570429) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP11570429.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP11570429.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP11570429.Sele_I_D_;
    SELF := __PP11570429;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE11570428,__ND11570433__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Seen_Flag_,B_E___Ver_Src_List_Ev_,B_E___Ver_Src_Cnt_Ev_,B_E___Ver_Src_Emrg_Dt_List_Ev_,B_E___Ver_Src_Last_Dt_List_Ev_,B_E___Ver_Src_Old_Dt_Ev_,B_E___Ver_Src_New_Dt_Ev_,B_E___Ver_Src_Old_Msnc_Ev_,B_E___Ver_Src_New_Msnc_Ev_,B_E___Ver_Src_Rpt_New_Bus_Flag_,B_E___Ver_Src_Cred_Cnt_Ev_,B_E___Ver_Src_Bureau_Flag_,B_E___Ver_Src_Bureau_Old_Dt_Ev_,B_E___Ver_Src_Bureau_Old_Msnc_Ev_,B_E___D_B_A_Name_Cnt2_Y_,B_E___Addr_P_O_Box_Flag_,B_E___U_R_L_Flag_,B_E___Ver_Name_Flag_,B_E___Ver_Name_Src_List_Ev_,B_E___Ver_Name_Src_Cnt_Ev_,B_E___Ver_Name_Src_Emrg_Dt_List_Ev_,B_E___Ver_Name_Src_Last_Dt_List_Ev_,B_E___Ver_Name_Src_Old_Dt_Ev_,B_E___Ver_Name_Src_New_Dt_Ev_,B_E___Ver_Name_Src_Old_Msnc_Ev_,B_E___Ver_Name_Src_New_Msnc_Ev_,B_E___Ver_Addr_Flag_,B_E___Ver_Addr_Src_List_Ev_,B_E___Ver_Addr_Src_Cnt_Ev_,B_E___Ver_Addr_Src_Emrg_Dt_List_Ev_,B_E___Ver_Addr_Src_Last_Dt_List_Ev_,B_E___Ver_Addr_Src_Old_Dt_Ev_,B_E___Ver_Addr_Src_New_Dt_Ev_,B_E___Ver_Addr_Src_Old_Msnc_Ev_,B_E___Ver_Addr_Src_New_Msnc_Ev_,B_E___Ver_Addr_Src_Dt_Span_Ev_,B_E___Ver_T_I_N_Flag_,B_E___Ver_T_I_N_Src_List_Ev_,B_E___Ver_T_I_N_Src_Cnt_Ev_,B_E___Ver_T_I_N_Src_Emrg_Dt_List_Ev_,B_E___Ver_T_I_N_Src_Last_Dt_List_Ev_,B_E___Ver_T_I_N_Src_Old_Dt_Ev_,B_E___Ver_T_I_N_Src_New_Dt_Ev_,B_E___Ver_T_I_N_Src_Old_Msnc_Ev_,B_E___Ver_T_I_N_Src_New_Msnc_Ev_,B_E___Ver_Phone_Flag_,B_E___Ver_Phone_Src_List_Ev_,B_E___Ver_Phone_Src_Cnt_Ev_,B_E___Ver_Phone_Src_Emrg_Dt_List_Ev_,B_E___Ver_Phone_Src_Last_Dt_List_Ev_,B_E___Ver_Phone_Src_Old_Dt_Ev_,B_E___Ver_Phone_Src_New_Dt_Ev_,B_E___Ver_Phone_Src_Old_Msnc_Ev_,B_E___Ver_Phone_Src_New_Msnc_Ev_,B_E___B2_B_Cnt_Ev_,B_E___B2_B_Cnt2_Y_,B_E___B2_B_Carr_Cnt2_Y_,B_E___B2_B_Flt_Cnt2_Y_,B_E___B2_B_Mat_Cnt2_Y_,B_E___B2_B_Ops_Cnt2_Y_,B_E___B2_B_Oth_Cnt2_Y_,B_E___B2_B_Carr_Pct2_Y_,B_E___B2_B_Flt_Pct2_Y_,B_E___B2_B_Mat_Pct2_Y_,B_E___B2_B_Ops_Pct2_Y_,B_E___B2_B_Oth_Pct2_Y_,B_E___B2_B_Old_Dt_Ev_,B_E___B2_B_Old_Msnc_Ev_,B_E___B2_B_Old_Dt2_Y_,B_E___B2_B_New_Dt2_Y_,B_E___B2_B_Old_Msnc2_Y_,B_E___B2_B_New_Msnc2_Y_,B_E___B2_B_Actv_Cnt_,B_E___B2_B_Actv_Carr_Cnt_,B_E___B2_B_Actv_Flt_Cnt_,B_E___B2_B_Actv_Mat_Cnt_,B_E___B2_B_Actv_Ops_Cnt_,B_E___B2_B_Actv_Oth_Cnt_,B_E___B2_B_Actv_Carr_Pct_,B_E___B2_B_Actv_Flt_Pct_,B_E___B2_B_Actv_Mat_Pct_,B_E___B2_B_Actv_Ops_Pct_,B_E___B2_B_Actv_Oth_Pct_,B_E___B2_B_Actv_Cnt_A1_Y_,B_E___B2_B_Actv_Carr_Cnt_A1_Y_,B_E___B2_B_Actv_Flt_Cnt_A1_Y_,B_E___B2_B_Actv_Mat_Cnt_A1_Y_,B_E___B2_B_Actv_Ops_Cnt_A1_Y_,B_E___B2_B_Actv_Oth_Cnt_A1_Y_,B_E___B2_B_Actv_Cnt_Grow1_Y_,B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_,B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_,B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_,B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_,B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_,B_E___B2_B_Actv_Flt_Bal_Tot_,B_E___B2_B_Actv_Mat_Bal_Tot_,B_E___B2_B_Actv_Ops_Bal_Tot_,B_E___B2_B_Actv_Oth_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_Pct_,B_E___B2_B_Actv_Flt_Bal_Pct_,B_E___B2_B_Actv_Mat_Bal_Pct_,B_E___B2_B_Actv_Ops_Bal_Pct_,B_E___B2_B_Actv_Oth_Bal_Pct_,B_E___B2_B_Actv_Bal_Tot_Rnge_,B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_,B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_,B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_,B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_,B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_,B_E___B2_B_Actv_Bal_Avg_,B_E___B2_B_Actv_Carr_Bal_Avg_,B_E___B2_B_Actv_Flt_Bal_Avg_,B_E___B2_B_Actv_Mat_Bal_Avg_,B_E___B2_B_Actv_Ops_Bal_Avg_,B_E___B2_B_Actv_Oth_Bal_Avg_,B_E___B2_B_Actv_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Bal_Max2_Y_,B_E___B2_B_Carr_Bal_Max2_Y_,B_E___B2_B_Flt_Bal_Max2_Y_,B_E___B2_B_Mat_Bal_Max2_Y_,B_E___B2_B_Ops_Bal_Max2_Y_,B_E___B2_B_Oth_Bal_Max2_Y_,B_E___B2_B_Bal_Max_Dt2_Y_,B_E___B2_B_Carr_Bal_Max_Dt2_Y_,B_E___B2_B_Flt_Bal_Max_Dt2_Y_,B_E___B2_B_Mat_Bal_Max_Dt2_Y_,B_E___B2_B_Ops_Bal_Max_Dt2_Y_,B_E___B2_B_Oth_Bal_Max_Dt2_Y_,B_E___B2_B_Bal_Max_Msnc2_Y_,B_E___B2_B_Carr_Bal_Max_Msnc2_Y_,B_E___B2_B_Flt_Bal_Max_Msnc2_Y_,B_E___B2_B_Mat_Bal_Max_Msnc2_Y_,B_E___B2_B_Ops_Bal_Max_Msnc2_Y_,B_E___B2_B_Oth_Bal_Max_Msnc2_Y_,B_E___B2_B_Bal_Max_Seg_Type2_Y_,B_E___B2_B_Actv_Worst_Perf_Indx_,B_E___B2_B_Actv_Carr_Worst_Perf_Indx_,B_E___B2_B_Actv_Flt_Worst_Perf_Indx_,B_E___B2_B_Actv_Mat_Worst_Perf_Indx_,B_E___B2_B_Actv_Ops_Worst_Perf_Indx_,B_E___B2_B_Actv_Oth_Worst_Perf_Indx_,B_E___B2_B_Actv1p_Dpd_Cnt_,B_E___B2_B_Actv31p_Dpd_Cnt_,B_E___B2_B_Actv61p_Dpd_Cnt_,B_E___B2_B_Actv91p_Dpd_Cnt_,B_E___B2_B_Actv1p_Dpd_Pct_,B_E___B2_B_Actv31p_Dpd_Pct_,B_E___B2_B_Actv61p_Dpd_Pct_,B_E___B2_B_Actv91p_Dpd_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Worst_Perf_Indx2_Y_,B_E___B2_B_Carr_Worst_Perf_Indx2_Y_,B_E___B2_B_Flt_Worst_Perf_Indx2_Y_,B_E___B2_B_Mat_Worst_Perf_Indx2_Y_,B_E___B2_B_Ops_Worst_Perf_Indx2_Y_,B_E___B2_B_Oth_Worst_Perf_Indx2_Y_,B_E___B2_B_Worst_Perf_Dt2_Y_,B_E___B2_B_Carr_Worst_Perf_Dt2_Y_,B_E___B2_B_Flt_Worst_Perf_Dt2_Y_,B_E___B2_B_Mat_Worst_Perf_Dt2_Y_,B_E___B2_B_Ops_Worst_Perf_Dt2_Y_,B_E___B2_B_Oth_Worst_Perf_Dt2_Y_,B_E___B2_B_Worst_Perf_Msnc2_Y_,B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_,B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_,B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_,B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_,B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_,B_E___B2_B_Cnt24_Mc_,B_E___B2_B_Carr_Cnt24_Mc_,B_E___B2_B_Flt_Cnt24_Mc_,B_E___B2_B_Mat_Cnt24_Mc_,B_E___B2_B_Ops_Cnt24_Mc_,B_E___B2_B_Oth_Cnt24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Bal_Vol24_Mc_,B_E___B2_B_Carr_Bal_Vol24_Mc_,B_E___B2_B_Flt_Bal_Vol24_Mc_,B_E___B2_B_Mat_Bal_Vol24_Mc_,B_E___B2_B_Ops_Bal_Vol24_Mc_,B_E___B2_B_Oth_Bal_Vol24_Mc_,B_E___Ast_Veh_Air_Cnt_Ev_,B_E___Ast_Veh_Wtr_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt2_Y_,B_E___Ast_Veh_Auto_Pers_Cnt2_Y_,B_E___Ast_Veh_Auto_Comm_Cnt2_Y_,B_E___Ast_Veh_Auto_Other_Cnt2_Y_,B_E___Ast_Veh_Auto_Val_Tot2_Y_,B_E___Ast_Veh_Auto_Emrg_New_Msnc_Ev_,B_E___Ast_Veh_Auto_Emrg_New_Dt_Ev_,B_E___Ast_Prop_Cnt_Ev_,B_E___Ast_Prop_State_Cnt_Ev_,B_E___Ast_Prop_Curr_Cnt_,B_E___Ast_Prop_Curr_State_Cnt_,B_E___Ast_Prop_Old_Dt_Ev_,B_E___Ast_Prop_Old_Msnc_Ev_,B_E___Ast_Prop_New_Dt_Ev_,B_E___Ast_Prop_New_Msnc_Ev_,B_E___Ast_Prop_Curr_Tax_Val_Tot_,B_E___Ast_Prop_Curr_Mkt_Val_Tot_,B_E___Ast_Prop_Curr_Val_Tot_,B_E___Ast_Prop_Curr_Lot_Size_Tot_,B_E___Ast_Prop_Curr_Bldg_Size_Tot_,B_E___Ast_Prop_Indx_Ev_,B_E___Drg_Bk_Cnt1_Y_,B_E___Drg_Bk_Cnt7_Y_,B_E___Drg_Bk_Cnt10_Y_,B_E___Drg_Bk_Old_Dt10_Y_,B_E___Drg_Bk_Old_Msnc10_Y_,B_E___Drg_Bk_New_Dt10_Y_,B_E___Drg_Bk_New_Msnc10_Y_,B_E___Drg_Bk_Updt_New_Dt10_Y_,B_E___Drg_Bk_Updt_New_Msnc10_Y_,B_E___Drg_Bk_Disp_Cnt10_Y_,B_E___Drg_Bk_Dsch_Cnt10_Y_,B_E___Drg_Bk_Dsms_Cnt10_Y_,B_E___Drg_Bk_New_Disp_Type10_Y_,B_E___Drg_Bk_Ch7_Cnt10_Y_,B_E___Drg_Bk_Ch11_Cnt10_Y_,B_E___Drg_Bk_Ch13_Cnt10_Y_,B_E___Drg_Bk_New_Ch_Type10_Y_,B_E___S_O_S_Cnt_Ev_,B_E___S_O_S_New_Dt_Ev_,B_E___S_O_S_Old_Dt_Ev_,B_E___S_O_S_New_Msnc_Ev_,B_E___S_O_S_Old_Msnc_Ev_,B_E___S_O_S_State_Cnt_Ev_,B_E___S_O_S_Dom_Cnt_Ev_,B_E___S_O_S_Dom_New_Dt_Ev_,B_E___S_O_S_Dom_Old_Dt_Ev_,B_E___S_O_S_Dom_New_Msnc_Ev_,B_E___S_O_S_Dom_Old_Msnc_Ev_,B_E___S_O_S_Frgn_Cnt_Ev_,B_E___S_O_S_Frgn_New_Dt_Ev_,B_E___S_O_S_Frgn_Old_Dt_Ev_,B_E___S_O_S_Frgn_New_Msnc_Ev_,B_E___S_O_S_Frgn_Old_Msnc_Ev_,B_E___S_O_S_Dom_Status_Indx_Ev_,B_E___Best_Name_,B_E___Best_Addr_Loc_I_D_,B_E___Best_Addr_St_,B_E___Best_Addr_City_,B_E___Best_Addr_City_Post_,B_E___Best_Addr_State_,B_E___Best_Addr_Zip_,B_E___Best_T_I_N_,B_E___Best_Phone_,B_E___Drg_Gov_Debarred_Flag_Ev_,B_E___Bus_S_I_C_Code1_,B_E___Bus_S_I_C_Code1_Desc_,B_E___Bus_S_I_C_Code1_Group_Desc_,B_E___Bus_S_I_C_Code2_,B_E___Bus_S_I_C_Code2_Desc_,B_E___Bus_S_I_C_Code2_Group_Desc_,B_E___Bus_S_I_C_Code3_,B_E___Bus_S_I_C_Code3_Desc_,B_E___Bus_S_I_C_Code3_Group_Desc_,B_E___Bus_S_I_C_Code4_,B_E___Bus_S_I_C_Code4_Desc_,B_E___Bus_S_I_C_Code4_Group_Desc_,B_E___Bus_N_A_I_C_S_Code1_,B_E___Bus_N_A_I_C_S_Code1_Desc_,B_E___Bus_N_A_I_C_S_Code1_Group_Desc_,B_E___Bus_N_A_I_C_S_Code2_,B_E___Bus_N_A_I_C_S_Code2_Desc_,B_E___Bus_N_A_I_C_S_Code2_Group_Desc_,B_E___Bus_N_A_I_C_S_Code3_,B_E___Bus_N_A_I_C_S_Code3_Desc_,B_E___Bus_N_A_I_C_S_Code3_Group_Desc_,B_E___Bus_N_A_I_C_S_Code4_,B_E___Bus_N_A_I_C_S_Code4_Desc_,B_E___Bus_N_A_I_C_S_Code4_Group_Desc_,B_E___Bus_Empl_Count_Curr_,B_E___Bus_Empl_Count_Curr_Rnge_,B_E___Bus_Annual_Sales_Curr_,B_E___Bus_Annual_Sales_Curr_Rnge_,B_E___Bus_Is_Non_Profit_Flag_,B_E___Bus_Is_Franchise_Flag_,B_E___Bus_Offers401k_Flag_,B_E___Bus_Has_New_Location_Flag1_Y_,B_E___Bus_Loc_Actv_Cnt_,B_E___Bus_Is_S_B_E_Flag_,B_E___Bus_Infer_Female_Owned_Flag_,B_E___Bus_Infer_Family_Owned_Flag_,B_E___Bus_Is_Female_Owned_Flag_,B_E___Bus_Is_Minority_Owned_Flag_,B_E___Bus_Is_Public_Flag_,B_E___Drg_L_T_D_Cnt1_Y_,B_E___Drg_L_T_D_Cnt7_Y_,B_E___Drg_L_T_D_Amt_Tot7_Y_,B_E___Drg_L_T_D_Amt_Avg7_Y_,B_E___Drg_L_T_D_New_Dt7_Y_,B_E___Drg_L_T_D_Old_Dt7_Y_,B_E___Drg_L_T_D_New_Msnc7_Y_,B_E___Drg_L_T_D_Old_Msnc7_Y_,B_E___U_C_C_Cnt_Ev_,B_E___U_C_C_Debtor_Cnt_Ev_,B_E___U_C_C_Debtor_Old_Dt_Ev_,B_E___U_C_C_Debtor_Old_Msnc_Ev_,B_E___U_C_C_Debtor_New_Dt_Ev_,B_E___U_C_C_Debtor_New_Msnc_Ev_,B_E___U_C_C_Actv_Cnt_,B_E___U_C_C_Debtor_Actv_Cnt_,B_E___U_C_C_Debtor_Term_Cnt_Ev_,B_E___U_C_C_Debtor_Other_Cnt_Ev_,B_E___U_C_C_Debtor_Actv_Pct_,B_E___U_C_C_Debtor_Term_Pct_Ev_,B_E___U_C_C_Debtor_Other_Pct_Ev_,B_E___U_C_C_Debtor_Term_New_Dt_Ev_,B_E___U_C_C_Debtor_Term_New_Msnc_Ev_,B_E___U_C_C_Creditor_Cnt_Ev_,B_E___U_C_C_Role_Indx_Ev_,B_E___U_C_C_Actv_Role_Indx_,B_E___Drg_Lien_Cnt1_Y_,B_E___Drg_Lien_Cnt7_Y_,B_E___Drg_Lien_Amt_Tot7_Y_,B_E___Drg_Lien_Amt_Avg7_Y_,B_E___Drg_Lien_Old_Dt7_Y_,B_E___Drg_Lien_Old_Msnc7_Y_,B_E___Drg_Lien_New_Dt7_Y_,B_E___Drg_Lien_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Cnt7_Y_,B_E___Drg_Lien_Tax_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_New_Dt7_Y_,B_E___Drg_Lien_Tax_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_Cnt7_Y_,B_E___Drg_Lien_Tax_Fed_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_New_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_New_Msnc7_Y_,B_E___Drg_Lien_Tax_State_Cnt7_Y_,B_E___Drg_Lien_Tax_State_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_State_Old_Dt7_Y_,B_E___Drg_Lien_Tax_State_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_State_New_Dt7_Y_,B_E___Drg_Lien_Tax_State_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_Cnt7_Y_,B_E___Drg_Lien_Tax_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Other_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Other_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_New_Dt7_Y_,B_E___Drg_Lien_Tax_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Cnt7_Y_,B_E___Drg_Lien_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Other_New_Dt7_Y_,B_E___Drg_Lien_Other_Old_Dt7_Y_,B_E___Drg_Lien_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Old_Msnc7_Y_,B_E___Drg_Judg_Cnt1_Y_,B_E___Drg_Judg_Cnt7_Y_,B_E___Drg_Judg_Amt_Tot7_Y_,B_E___Drg_Judg_Amt_Avg7_Y_,B_E___Drg_Judg_Old_Dt7_Y_,B_E___Drg_Judg_Old_Msnc7_Y_,B_E___Drg_Judg_New_Dt7_Y_,B_E___Drg_Judg_New_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_Cnt7_Y_,B_E___Drg_Judg_Civ_Crt_Amt_Tot7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_New_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_New_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_Cnt7_Y_,B_E___Drg_Judg_Sm_Claim_Amt_Tot7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_New_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_New_Msnc7_Y_,B_E___Drg_Judg_Frcl_Cnt7_Y_,B_E___Drg_Judg_Frcl_Amt_Tot7_Y_,B_E___Drg_Judg_Frcl_Old_Dt7_Y_,B_E___Drg_Judg_Frcl_Old_Msnc7_Y_,B_E___Drg_Judg_Frcl_New_Dt7_Y_,B_E___Drg_Judg_Frcl_New_Msnc7_Y_,B_E___Drg_Ln_J_Cnt1_Y_,B_E___Drg_Ln_J_Cnt7_Y_,B_E___Drg_Ln_J_Amt_Tot7_Y_,B_E___Drg_Ln_J_Amt_Avg7_Y_,B_E___Drg_Ln_J_New_Dt7_Y_,B_E___Drg_Ln_J_Old_Dt7_Y_,B_E___Drg_Ln_J_New_Msnc7_Y_,B_E___Drg_Ln_J_Old_Msnc7_Y_,B_E___Drg_Suit_Cnt7_Y_,B_E___Drg_Suit_Amt_Tot7_Y_,B_E___Drg_Suit_Old_Dt7_Y_,B_E___Drg_Suit_Old_Msnc7_Y_,B_E___Drg_Suit_New_Dt7_Y_,B_E___Drg_Suit_New_Msnc7_Y_,B_E___Drg_Judg_New_Type7_Y_,B_E___Drg_Lien_New_Type7_Y_,B_E___Drg_Cnt1_Y_,B_E___Drg_Cnt7_Y_,B_E___Drg_Flag7_Y_,B_E___Drg_New_Dt7_Y_,B_E___Drg_New_Msnc7_Y_,B_E___Drg_Old_Dt7_Y_,B_E___Drg_Old_Msnc7_Y_,B_E___Assoc_Cnt_Ev_,B_E___Assoc_Cnt2_Y_,B_E___Assoc_Pct2_Y_,B_E___Assoc_Exec_Cnt_Ev_,B_E___Assoc_Exec_Cnt2_Y_,B_E___Assoc_Exec_Pct2_Y_,B_E___Assoc_Nexec_Cnt_Ev_,B_E___Assoc_Nexec_Cnt2_Y_,B_E___Assoc_Nexec_Pct2_Y_,B_E___Assoc_Email_Flag2_Y_,B_E___Assoc_Exec_Email_Flag2_Y_,B_E___Assoc_Nexec_Email_Flag2_Y_,B_E___Assoc_Age_Avg2_Y_,B_E___Assoc_Exec_Age_Avg2_Y_,B_E___Assoc_Nexec_Age_Avg2_Y_,B_E___Assoc_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Exec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Nexec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Emrg_Msnc_Avg2_Y_,B_E___Assoc_Exec_Emrg_Msnc_Avg2_Y_,B_E___Assoc_Nexec_Emrg_Msnc_Avg2_Y_,B_E___Assoc_Exec_Female_Cnt2_Y_,B_E___Assoc_Exec_Female_Pct2_Y_,B_E___Assoc_Exec_Related_Cnt2_Y_,B_E___Assoc_Exec_Related_Pct2_Y_,B_E___Assoc_W_Drg_Judg_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Judg_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Judg_Cnt2_Y_,B_E___Assoc_W_Drg_L_T_D_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_L_T_D_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_L_T_D_Cnt2_Y_,B_E___Assoc_W_Drg_Lien_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Lien_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Lien_Cnt2_Y_,B_E___Assoc_W_Drg_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Cnt2_Y_,B_E___Assoc_Bus_Cnt_Avg2_Y_,B_E___Assoc_Exec_Bus_Cnt_Avg2_Y_,B_E___Assoc_Nexec_Bus_Cnt_Avg2_Y_,B_E___Best_Addr_Seen_Flag_,B_E___Best_Addr_Src_List_Ev_,B_E___Best_Addr_Src_Cnt_Ev_,B_E___Best_Addr_Src_Emrg_Dt_List_Ev_,B_E___Best_Addr_Src_Last_Dt_List_Ev_,B_E___Best_Addr_Src_Old_Dt_Ev_,B_E___Best_Addr_Src_New_Dt_Ev_,B_E___Best_Addr_Src_Old_Msnc_Ev_,B_E___Best_Addr_Src_New_Msnc_Ev_,B_E___Best_Addr_Is_Residential_Flag_,B_E___Bus_Is_Residential_Flag_,B_E___Best_Addr_Bldg_Is_Multi_Unit_Flag_,B_E___Best_Addr_Bldg_Type_,B_E___Best_Addr_Is_P_O_Box_Flag_,B_E___Best_Addr_Is_Vacant_Flag_,B_E___Best_Addr_Is_Owned_Flag_,B_E___Best_Addr_New_Mkt_Val_Ev_,B_E___Best_Addr_New_Tax_Val_Ev_,B_E___Best_Addr_New_Mkt_Val_Yr_Ev_,B_E___Best_Addr_New_Tax_Val_Yr_Ev_,B_E___Best_Addr_Lot_Size_,B_E___Best_Addr_Bldg_Size_},B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Seen_Flag_,B_E___Ver_Src_List_Ev_,B_E___Ver_Src_Cnt_Ev_,B_E___Ver_Src_Emrg_Dt_List_Ev_,B_E___Ver_Src_Last_Dt_List_Ev_,B_E___Ver_Src_Old_Dt_Ev_,B_E___Ver_Src_New_Dt_Ev_,B_E___Ver_Src_Old_Msnc_Ev_,B_E___Ver_Src_New_Msnc_Ev_,B_E___Ver_Src_Rpt_New_Bus_Flag_,B_E___Ver_Src_Cred_Cnt_Ev_,B_E___Ver_Src_Bureau_Flag_,B_E___Ver_Src_Bureau_Old_Dt_Ev_,B_E___Ver_Src_Bureau_Old_Msnc_Ev_,B_E___D_B_A_Name_Cnt2_Y_,B_E___Addr_P_O_Box_Flag_,B_E___U_R_L_Flag_,B_E___Ver_Name_Flag_,B_E___Ver_Name_Src_List_Ev_,B_E___Ver_Name_Src_Cnt_Ev_,B_E___Ver_Name_Src_Emrg_Dt_List_Ev_,B_E___Ver_Name_Src_Last_Dt_List_Ev_,B_E___Ver_Name_Src_Old_Dt_Ev_,B_E___Ver_Name_Src_New_Dt_Ev_,B_E___Ver_Name_Src_Old_Msnc_Ev_,B_E___Ver_Name_Src_New_Msnc_Ev_,B_E___Ver_Addr_Flag_,B_E___Ver_Addr_Src_List_Ev_,B_E___Ver_Addr_Src_Cnt_Ev_,B_E___Ver_Addr_Src_Emrg_Dt_List_Ev_,B_E___Ver_Addr_Src_Last_Dt_List_Ev_,B_E___Ver_Addr_Src_Old_Dt_Ev_,B_E___Ver_Addr_Src_New_Dt_Ev_,B_E___Ver_Addr_Src_Old_Msnc_Ev_,B_E___Ver_Addr_Src_New_Msnc_Ev_,B_E___Ver_Addr_Src_Dt_Span_Ev_,B_E___Ver_T_I_N_Flag_,B_E___Ver_T_I_N_Src_List_Ev_,B_E___Ver_T_I_N_Src_Cnt_Ev_,B_E___Ver_T_I_N_Src_Emrg_Dt_List_Ev_,B_E___Ver_T_I_N_Src_Last_Dt_List_Ev_,B_E___Ver_T_I_N_Src_Old_Dt_Ev_,B_E___Ver_T_I_N_Src_New_Dt_Ev_,B_E___Ver_T_I_N_Src_Old_Msnc_Ev_,B_E___Ver_T_I_N_Src_New_Msnc_Ev_,B_E___Ver_Phone_Flag_,B_E___Ver_Phone_Src_List_Ev_,B_E___Ver_Phone_Src_Cnt_Ev_,B_E___Ver_Phone_Src_Emrg_Dt_List_Ev_,B_E___Ver_Phone_Src_Last_Dt_List_Ev_,B_E___Ver_Phone_Src_Old_Dt_Ev_,B_E___Ver_Phone_Src_New_Dt_Ev_,B_E___Ver_Phone_Src_Old_Msnc_Ev_,B_E___Ver_Phone_Src_New_Msnc_Ev_,B_E___B2_B_Cnt_Ev_,B_E___B2_B_Cnt2_Y_,B_E___B2_B_Carr_Cnt2_Y_,B_E___B2_B_Flt_Cnt2_Y_,B_E___B2_B_Mat_Cnt2_Y_,B_E___B2_B_Ops_Cnt2_Y_,B_E___B2_B_Oth_Cnt2_Y_,B_E___B2_B_Carr_Pct2_Y_,B_E___B2_B_Flt_Pct2_Y_,B_E___B2_B_Mat_Pct2_Y_,B_E___B2_B_Ops_Pct2_Y_,B_E___B2_B_Oth_Pct2_Y_,B_E___B2_B_Old_Dt_Ev_,B_E___B2_B_Old_Msnc_Ev_,B_E___B2_B_Old_Dt2_Y_,B_E___B2_B_New_Dt2_Y_,B_E___B2_B_Old_Msnc2_Y_,B_E___B2_B_New_Msnc2_Y_,B_E___B2_B_Actv_Cnt_,B_E___B2_B_Actv_Carr_Cnt_,B_E___B2_B_Actv_Flt_Cnt_,B_E___B2_B_Actv_Mat_Cnt_,B_E___B2_B_Actv_Ops_Cnt_,B_E___B2_B_Actv_Oth_Cnt_,B_E___B2_B_Actv_Carr_Pct_,B_E___B2_B_Actv_Flt_Pct_,B_E___B2_B_Actv_Mat_Pct_,B_E___B2_B_Actv_Ops_Pct_,B_E___B2_B_Actv_Oth_Pct_,B_E___B2_B_Actv_Cnt_A1_Y_,B_E___B2_B_Actv_Carr_Cnt_A1_Y_,B_E___B2_B_Actv_Flt_Cnt_A1_Y_,B_E___B2_B_Actv_Mat_Cnt_A1_Y_,B_E___B2_B_Actv_Ops_Cnt_A1_Y_,B_E___B2_B_Actv_Oth_Cnt_A1_Y_,B_E___B2_B_Actv_Cnt_Grow1_Y_,B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_,B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_,B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_,B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_,B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_,B_E___B2_B_Actv_Flt_Bal_Tot_,B_E___B2_B_Actv_Mat_Bal_Tot_,B_E___B2_B_Actv_Ops_Bal_Tot_,B_E___B2_B_Actv_Oth_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_Pct_,B_E___B2_B_Actv_Flt_Bal_Pct_,B_E___B2_B_Actv_Mat_Bal_Pct_,B_E___B2_B_Actv_Ops_Bal_Pct_,B_E___B2_B_Actv_Oth_Bal_Pct_,B_E___B2_B_Actv_Bal_Tot_Rnge_,B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_,B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_,B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_,B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_,B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_,B_E___B2_B_Actv_Bal_Avg_,B_E___B2_B_Actv_Carr_Bal_Avg_,B_E___B2_B_Actv_Flt_Bal_Avg_,B_E___B2_B_Actv_Mat_Bal_Avg_,B_E___B2_B_Actv_Ops_Bal_Avg_,B_E___B2_B_Actv_Oth_Bal_Avg_,B_E___B2_B_Actv_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Bal_Max2_Y_,B_E___B2_B_Carr_Bal_Max2_Y_,B_E___B2_B_Flt_Bal_Max2_Y_,B_E___B2_B_Mat_Bal_Max2_Y_,B_E___B2_B_Ops_Bal_Max2_Y_,B_E___B2_B_Oth_Bal_Max2_Y_,B_E___B2_B_Bal_Max_Dt2_Y_,B_E___B2_B_Carr_Bal_Max_Dt2_Y_,B_E___B2_B_Flt_Bal_Max_Dt2_Y_,B_E___B2_B_Mat_Bal_Max_Dt2_Y_,B_E___B2_B_Ops_Bal_Max_Dt2_Y_,B_E___B2_B_Oth_Bal_Max_Dt2_Y_,B_E___B2_B_Bal_Max_Msnc2_Y_,B_E___B2_B_Carr_Bal_Max_Msnc2_Y_,B_E___B2_B_Flt_Bal_Max_Msnc2_Y_,B_E___B2_B_Mat_Bal_Max_Msnc2_Y_,B_E___B2_B_Ops_Bal_Max_Msnc2_Y_,B_E___B2_B_Oth_Bal_Max_Msnc2_Y_,B_E___B2_B_Bal_Max_Seg_Type2_Y_,B_E___B2_B_Actv_Worst_Perf_Indx_,B_E___B2_B_Actv_Carr_Worst_Perf_Indx_,B_E___B2_B_Actv_Flt_Worst_Perf_Indx_,B_E___B2_B_Actv_Mat_Worst_Perf_Indx_,B_E___B2_B_Actv_Ops_Worst_Perf_Indx_,B_E___B2_B_Actv_Oth_Worst_Perf_Indx_,B_E___B2_B_Actv1p_Dpd_Cnt_,B_E___B2_B_Actv31p_Dpd_Cnt_,B_E___B2_B_Actv61p_Dpd_Cnt_,B_E___B2_B_Actv91p_Dpd_Cnt_,B_E___B2_B_Actv1p_Dpd_Pct_,B_E___B2_B_Actv31p_Dpd_Pct_,B_E___B2_B_Actv61p_Dpd_Pct_,B_E___B2_B_Actv91p_Dpd_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Worst_Perf_Indx2_Y_,B_E___B2_B_Carr_Worst_Perf_Indx2_Y_,B_E___B2_B_Flt_Worst_Perf_Indx2_Y_,B_E___B2_B_Mat_Worst_Perf_Indx2_Y_,B_E___B2_B_Ops_Worst_Perf_Indx2_Y_,B_E___B2_B_Oth_Worst_Perf_Indx2_Y_,B_E___B2_B_Worst_Perf_Dt2_Y_,B_E___B2_B_Carr_Worst_Perf_Dt2_Y_,B_E___B2_B_Flt_Worst_Perf_Dt2_Y_,B_E___B2_B_Mat_Worst_Perf_Dt2_Y_,B_E___B2_B_Ops_Worst_Perf_Dt2_Y_,B_E___B2_B_Oth_Worst_Perf_Dt2_Y_,B_E___B2_B_Worst_Perf_Msnc2_Y_,B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_,B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_,B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_,B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_,B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_,B_E___B2_B_Cnt24_Mc_,B_E___B2_B_Carr_Cnt24_Mc_,B_E___B2_B_Flt_Cnt24_Mc_,B_E___B2_B_Mat_Cnt24_Mc_,B_E___B2_B_Ops_Cnt24_Mc_,B_E___B2_B_Oth_Cnt24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Bal_Vol24_Mc_,B_E___B2_B_Carr_Bal_Vol24_Mc_,B_E___B2_B_Flt_Bal_Vol24_Mc_,B_E___B2_B_Mat_Bal_Vol24_Mc_,B_E___B2_B_Ops_Bal_Vol24_Mc_,B_E___B2_B_Oth_Bal_Vol24_Mc_,B_E___Ast_Veh_Air_Cnt_Ev_,B_E___Ast_Veh_Wtr_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt2_Y_,B_E___Ast_Veh_Auto_Pers_Cnt2_Y_,B_E___Ast_Veh_Auto_Comm_Cnt2_Y_,B_E___Ast_Veh_Auto_Other_Cnt2_Y_,B_E___Ast_Veh_Auto_Val_Tot2_Y_,B_E___Ast_Veh_Auto_Emrg_New_Msnc_Ev_,B_E___Ast_Veh_Auto_Emrg_New_Dt_Ev_,B_E___Ast_Prop_Cnt_Ev_,B_E___Ast_Prop_State_Cnt_Ev_,B_E___Ast_Prop_Curr_Cnt_,B_E___Ast_Prop_Curr_State_Cnt_,B_E___Ast_Prop_Old_Dt_Ev_,B_E___Ast_Prop_Old_Msnc_Ev_,B_E___Ast_Prop_New_Dt_Ev_,B_E___Ast_Prop_New_Msnc_Ev_,B_E___Ast_Prop_Curr_Tax_Val_Tot_,B_E___Ast_Prop_Curr_Mkt_Val_Tot_,B_E___Ast_Prop_Curr_Val_Tot_,B_E___Ast_Prop_Curr_Lot_Size_Tot_,B_E___Ast_Prop_Curr_Bldg_Size_Tot_,B_E___Ast_Prop_Indx_Ev_,B_E___Drg_Bk_Cnt1_Y_,B_E___Drg_Bk_Cnt7_Y_,B_E___Drg_Bk_Cnt10_Y_,B_E___Drg_Bk_Old_Dt10_Y_,B_E___Drg_Bk_Old_Msnc10_Y_,B_E___Drg_Bk_New_Dt10_Y_,B_E___Drg_Bk_New_Msnc10_Y_,B_E___Drg_Bk_Updt_New_Dt10_Y_,B_E___Drg_Bk_Updt_New_Msnc10_Y_,B_E___Drg_Bk_Disp_Cnt10_Y_,B_E___Drg_Bk_Dsch_Cnt10_Y_,B_E___Drg_Bk_Dsms_Cnt10_Y_,B_E___Drg_Bk_New_Disp_Type10_Y_,B_E___Drg_Bk_Ch7_Cnt10_Y_,B_E___Drg_Bk_Ch11_Cnt10_Y_,B_E___Drg_Bk_Ch13_Cnt10_Y_,B_E___Drg_Bk_New_Ch_Type10_Y_,B_E___S_O_S_Cnt_Ev_,B_E___S_O_S_New_Dt_Ev_,B_E___S_O_S_Old_Dt_Ev_,B_E___S_O_S_New_Msnc_Ev_,B_E___S_O_S_Old_Msnc_Ev_,B_E___S_O_S_State_Cnt_Ev_,B_E___S_O_S_Dom_Cnt_Ev_,B_E___S_O_S_Dom_New_Dt_Ev_,B_E___S_O_S_Dom_Old_Dt_Ev_,B_E___S_O_S_Dom_New_Msnc_Ev_,B_E___S_O_S_Dom_Old_Msnc_Ev_,B_E___S_O_S_Frgn_Cnt_Ev_,B_E___S_O_S_Frgn_New_Dt_Ev_,B_E___S_O_S_Frgn_Old_Dt_Ev_,B_E___S_O_S_Frgn_New_Msnc_Ev_,B_E___S_O_S_Frgn_Old_Msnc_Ev_,B_E___S_O_S_Dom_Status_Indx_Ev_,B_E___Best_Name_,B_E___Best_Addr_Loc_I_D_,B_E___Best_Addr_St_,B_E___Best_Addr_City_,B_E___Best_Addr_City_Post_,B_E___Best_Addr_State_,B_E___Best_Addr_Zip_,B_E___Best_T_I_N_,B_E___Best_Phone_,B_E___Drg_Gov_Debarred_Flag_Ev_,B_E___Bus_S_I_C_Code1_,B_E___Bus_S_I_C_Code1_Desc_,B_E___Bus_S_I_C_Code1_Group_Desc_,B_E___Bus_S_I_C_Code2_,B_E___Bus_S_I_C_Code2_Desc_,B_E___Bus_S_I_C_Code2_Group_Desc_,B_E___Bus_S_I_C_Code3_,B_E___Bus_S_I_C_Code3_Desc_,B_E___Bus_S_I_C_Code3_Group_Desc_,B_E___Bus_S_I_C_Code4_,B_E___Bus_S_I_C_Code4_Desc_,B_E___Bus_S_I_C_Code4_Group_Desc_,B_E___Bus_N_A_I_C_S_Code1_,B_E___Bus_N_A_I_C_S_Code1_Desc_,B_E___Bus_N_A_I_C_S_Code1_Group_Desc_,B_E___Bus_N_A_I_C_S_Code2_,B_E___Bus_N_A_I_C_S_Code2_Desc_,B_E___Bus_N_A_I_C_S_Code2_Group_Desc_,B_E___Bus_N_A_I_C_S_Code3_,B_E___Bus_N_A_I_C_S_Code3_Desc_,B_E___Bus_N_A_I_C_S_Code3_Group_Desc_,B_E___Bus_N_A_I_C_S_Code4_,B_E___Bus_N_A_I_C_S_Code4_Desc_,B_E___Bus_N_A_I_C_S_Code4_Group_Desc_,B_E___Bus_Empl_Count_Curr_,B_E___Bus_Empl_Count_Curr_Rnge_,B_E___Bus_Annual_Sales_Curr_,B_E___Bus_Annual_Sales_Curr_Rnge_,B_E___Bus_Is_Non_Profit_Flag_,B_E___Bus_Is_Franchise_Flag_,B_E___Bus_Offers401k_Flag_,B_E___Bus_Has_New_Location_Flag1_Y_,B_E___Bus_Loc_Actv_Cnt_,B_E___Bus_Is_S_B_E_Flag_,B_E___Bus_Infer_Female_Owned_Flag_,B_E___Bus_Infer_Family_Owned_Flag_,B_E___Bus_Is_Female_Owned_Flag_,B_E___Bus_Is_Minority_Owned_Flag_,B_E___Bus_Is_Public_Flag_,B_E___Drg_L_T_D_Cnt1_Y_,B_E___Drg_L_T_D_Cnt7_Y_,B_E___Drg_L_T_D_Amt_Tot7_Y_,B_E___Drg_L_T_D_Amt_Avg7_Y_,B_E___Drg_L_T_D_New_Dt7_Y_,B_E___Drg_L_T_D_Old_Dt7_Y_,B_E___Drg_L_T_D_New_Msnc7_Y_,B_E___Drg_L_T_D_Old_Msnc7_Y_,B_E___U_C_C_Cnt_Ev_,B_E___U_C_C_Debtor_Cnt_Ev_,B_E___U_C_C_Debtor_Old_Dt_Ev_,B_E___U_C_C_Debtor_Old_Msnc_Ev_,B_E___U_C_C_Debtor_New_Dt_Ev_,B_E___U_C_C_Debtor_New_Msnc_Ev_,B_E___U_C_C_Actv_Cnt_,B_E___U_C_C_Debtor_Actv_Cnt_,B_E___U_C_C_Debtor_Term_Cnt_Ev_,B_E___U_C_C_Debtor_Other_Cnt_Ev_,B_E___U_C_C_Debtor_Actv_Pct_,B_E___U_C_C_Debtor_Term_Pct_Ev_,B_E___U_C_C_Debtor_Other_Pct_Ev_,B_E___U_C_C_Debtor_Term_New_Dt_Ev_,B_E___U_C_C_Debtor_Term_New_Msnc_Ev_,B_E___U_C_C_Creditor_Cnt_Ev_,B_E___U_C_C_Role_Indx_Ev_,B_E___U_C_C_Actv_Role_Indx_,B_E___Drg_Lien_Cnt1_Y_,B_E___Drg_Lien_Cnt7_Y_,B_E___Drg_Lien_Amt_Tot7_Y_,B_E___Drg_Lien_Amt_Avg7_Y_,B_E___Drg_Lien_Old_Dt7_Y_,B_E___Drg_Lien_Old_Msnc7_Y_,B_E___Drg_Lien_New_Dt7_Y_,B_E___Drg_Lien_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Cnt7_Y_,B_E___Drg_Lien_Tax_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_New_Dt7_Y_,B_E___Drg_Lien_Tax_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_Cnt7_Y_,B_E___Drg_Lien_Tax_Fed_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_New_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_New_Msnc7_Y_,B_E___Drg_Lien_Tax_State_Cnt7_Y_,B_E___Drg_Lien_Tax_State_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_State_Old_Dt7_Y_,B_E___Drg_Lien_Tax_State_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_State_New_Dt7_Y_,B_E___Drg_Lien_Tax_State_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_Cnt7_Y_,B_E___Drg_Lien_Tax_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Other_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Other_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_New_Dt7_Y_,B_E___Drg_Lien_Tax_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Cnt7_Y_,B_E___Drg_Lien_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Other_New_Dt7_Y_,B_E___Drg_Lien_Other_Old_Dt7_Y_,B_E___Drg_Lien_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Old_Msnc7_Y_,B_E___Drg_Judg_Cnt1_Y_,B_E___Drg_Judg_Cnt7_Y_,B_E___Drg_Judg_Amt_Tot7_Y_,B_E___Drg_Judg_Amt_Avg7_Y_,B_E___Drg_Judg_Old_Dt7_Y_,B_E___Drg_Judg_Old_Msnc7_Y_,B_E___Drg_Judg_New_Dt7_Y_,B_E___Drg_Judg_New_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_Cnt7_Y_,B_E___Drg_Judg_Civ_Crt_Amt_Tot7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_New_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_New_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_Cnt7_Y_,B_E___Drg_Judg_Sm_Claim_Amt_Tot7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_New_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_New_Msnc7_Y_,B_E___Drg_Judg_Frcl_Cnt7_Y_,B_E___Drg_Judg_Frcl_Amt_Tot7_Y_,B_E___Drg_Judg_Frcl_Old_Dt7_Y_,B_E___Drg_Judg_Frcl_Old_Msnc7_Y_,B_E___Drg_Judg_Frcl_New_Dt7_Y_,B_E___Drg_Judg_Frcl_New_Msnc7_Y_,B_E___Drg_Ln_J_Cnt1_Y_,B_E___Drg_Ln_J_Cnt7_Y_,B_E___Drg_Ln_J_Amt_Tot7_Y_,B_E___Drg_Ln_J_Amt_Avg7_Y_,B_E___Drg_Ln_J_New_Dt7_Y_,B_E___Drg_Ln_J_Old_Dt7_Y_,B_E___Drg_Ln_J_New_Msnc7_Y_,B_E___Drg_Ln_J_Old_Msnc7_Y_,B_E___Drg_Suit_Cnt7_Y_,B_E___Drg_Suit_Amt_Tot7_Y_,B_E___Drg_Suit_Old_Dt7_Y_,B_E___Drg_Suit_Old_Msnc7_Y_,B_E___Drg_Suit_New_Dt7_Y_,B_E___Drg_Suit_New_Msnc7_Y_,B_E___Drg_Judg_New_Type7_Y_,B_E___Drg_Lien_New_Type7_Y_,B_E___Drg_Cnt1_Y_,B_E___Drg_Cnt7_Y_,B_E___Drg_Flag7_Y_,B_E___Drg_New_Dt7_Y_,B_E___Drg_New_Msnc7_Y_,B_E___Drg_Old_Dt7_Y_,B_E___Drg_Old_Msnc7_Y_,B_E___Assoc_Cnt_Ev_,B_E___Assoc_Cnt2_Y_,B_E___Assoc_Pct2_Y_,B_E___Assoc_Exec_Cnt_Ev_,B_E___Assoc_Exec_Cnt2_Y_,B_E___Assoc_Exec_Pct2_Y_,B_E___Assoc_Nexec_Cnt_Ev_,B_E___Assoc_Nexec_Cnt2_Y_,B_E___Assoc_Nexec_Pct2_Y_,B_E___Assoc_Email_Flag2_Y_,B_E___Assoc_Exec_Email_Flag2_Y_,B_E___Assoc_Nexec_Email_Flag2_Y_,B_E___Assoc_Age_Avg2_Y_,B_E___Assoc_Exec_Age_Avg2_Y_,B_E___Assoc_Nexec_Age_Avg2_Y_,B_E___Assoc_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Exec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Nexec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Emrg_Msnc_Avg2_Y_,B_E___Assoc_Exec_Emrg_Msnc_Avg2_Y_,B_E___Assoc_Nexec_Emrg_Msnc_Avg2_Y_,B_E___Assoc_Exec_Female_Cnt2_Y_,B_E___Assoc_Exec_Female_Pct2_Y_,B_E___Assoc_Exec_Related_Cnt2_Y_,B_E___Assoc_Exec_Related_Pct2_Y_,B_E___Assoc_W_Drg_Judg_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Judg_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Judg_Cnt2_Y_,B_E___Assoc_W_Drg_L_T_D_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_L_T_D_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_L_T_D_Cnt2_Y_,B_E___Assoc_W_Drg_Lien_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Lien_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Lien_Cnt2_Y_,B_E___Assoc_W_Drg_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Cnt2_Y_,B_E___Assoc_Bus_Cnt_Avg2_Y_,B_E___Assoc_Exec_Bus_Cnt_Avg2_Y_,B_E___Assoc_Nexec_Bus_Cnt_Avg2_Y_,B_E___Best_Addr_Seen_Flag_,B_E___Best_Addr_Src_List_Ev_,B_E___Best_Addr_Src_Cnt_Ev_,B_E___Best_Addr_Src_Emrg_Dt_List_Ev_,B_E___Best_Addr_Src_Last_Dt_List_Ev_,B_E___Best_Addr_Src_Old_Dt_Ev_,B_E___Best_Addr_Src_New_Dt_Ev_,B_E___Best_Addr_Src_Old_Msnc_Ev_,B_E___Best_Addr_Src_New_Msnc_Ev_,B_E___Best_Addr_Is_Residential_Flag_,B_E___Bus_Is_Residential_Flag_,B_E___Best_Addr_Bldg_Is_Multi_Unit_Flag_,B_E___Best_Addr_Bldg_Type_,B_E___Best_Addr_Is_P_O_Box_Flag_,B_E___Best_Addr_Is_Vacant_Flag_,B_E___Best_Addr_Is_Owned_Flag_,B_E___Best_Addr_New_Mkt_Val_Ev_,B_E___Best_Addr_New_Tax_Val_Ev_,B_E___Best_Addr_New_Mkt_Val_Yr_Ev_,B_E___Best_Addr_New_Tax_Val_Yr_Ev_,B_E___Best_Addr_Lot_Size_,B_E___Best_Addr_Bldg_Size_,MERGE),__ST118818_Layout));
  EXPORT DBG_E_Input_B_I_I_PreEntity := __UNWRAP(E_Input_B_I_I_Params(__in,__cfg_Local).InData);
  EXPORT DBG_E_Input_B_I_I_Result := __UNWRAP(E_Input_B_I_I_Filtered.__Result);
  EXPORT DBG_E_Input_B_I_I_Input_P_I_I_PreEntity := __UNWRAP(E_Input_B_I_I_Input_P_I_I_Params(__in,__cfg_Local).InData);
  EXPORT DBG_E_Input_B_I_I_Input_P_I_I_Result := __UNWRAP(E_Input_B_I_I_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_Input_P_I_I_PreEntity := __UNWRAP(E_Input_P_I_I_Params(__in,__cfg_Local).InData);
  EXPORT DBG_E_Input_P_I_I_Result := __UNWRAP(E_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_Accident_Result := __UNWRAP(E_Accident_Filtered.__Result);
  EXPORT DBG_E_Address_Result := __UNWRAP(E_Address_Filtered.__Result);
  EXPORT DBG_E_Address_Inquiry_Result := __UNWRAP(E_Address_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Address_Property_Result := __UNWRAP(E_Address_Property_Filtered.__Result);
  EXPORT DBG_E_Address_Property_Event_Result := __UNWRAP(E_Address_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Aircraft_Owner_Result := __UNWRAP(E_Aircraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Bankruptcy_Result := __UNWRAP(E_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Business_Prox_Result := __UNWRAP(E_Business_Prox_Filtered.__Result);
  EXPORT DBG_E_Business_Sele_Result := __UNWRAP(E_Business_Sele_Filtered.__Result);
  EXPORT DBG_E_Business_Sele_Overflow_Result := __UNWRAP(E_Business_Sele_Overflow_Filtered.__Result);
  EXPORT DBG_E_Criminal_Offense_Result := __UNWRAP(E_Criminal_Offense_Filtered.__Result);
  EXPORT DBG_E_Education_Result := __UNWRAP(E_Education_Filtered.__Result);
  EXPORT DBG_E_Email_Result := __UNWRAP(E_Email_Filtered.__Result);
  EXPORT DBG_E_Email_Inquiry_Result := __UNWRAP(E_Email_Inquiry_Filtered.__Result);
  EXPORT DBG_E_First_Degree_Associations_Result := __UNWRAP(E_First_Degree_Associations_Filtered.__Result);
  EXPORT DBG_E_First_Degree_Relative_Result := __UNWRAP(E_First_Degree_Relative_Filtered.__Result);
  EXPORT DBG_E_Household_Result := __UNWRAP(E_Household_Filtered.__Result);
  EXPORT DBG_E_Household_Member_Result := __UNWRAP(E_Household_Member_Filtered.__Result);
  EXPORT DBG_E_Inquiry_Result := __UNWRAP(E_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Result := __UNWRAP(E_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Person_Result := __UNWRAP(E_Person_Filtered.__Result);
  EXPORT DBG_E_Person_Accident_Result := __UNWRAP(E_Person_Accident_Filtered.__Result);
  EXPORT DBG_E_Person_Address_Result := __UNWRAP(E_Person_Address_Filtered.__Result);
  EXPORT DBG_E_Person_Bankruptcy_Result := __UNWRAP(E_Person_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Person_Education_Result := __UNWRAP(E_Person_Education_Filtered.__Result);
  EXPORT DBG_E_Person_Email_Result := __UNWRAP(E_Person_Email_Filtered.__Result);
  EXPORT DBG_E_Person_Inquiry_Result := __UNWRAP(E_Person_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Person_Lien_Judgment_Result := __UNWRAP(E_Person_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Person_Offenses_Result := __UNWRAP(E_Person_Offenses_Filtered.__Result);
  EXPORT DBG_E_Person_Property_Result := __UNWRAP(E_Person_Property_Filtered.__Result);
  EXPORT DBG_E_Person_Property_Event_Result := __UNWRAP(E_Person_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Person_S_S_N_Result := __UNWRAP(E_Person_S_S_N_Filtered.__Result);
  EXPORT DBG_E_Person_Vehicle_Result := __UNWRAP(E_Person_Vehicle_Filtered.__Result);
  EXPORT DBG_E_Phone_Inquiry_Result := __UNWRAP(E_Phone_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Result := __UNWRAP(E_Professional_License_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Person_Result := __UNWRAP(E_Professional_License_Person_Filtered.__Result);
  EXPORT DBG_E_Property_Result := __UNWRAP(E_Property_Filtered.__Result);
  EXPORT DBG_E_Property_Event_Result := __UNWRAP(E_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Prox_Address_Result := __UNWRAP(E_Prox_Address_Filtered.__Result);
  EXPORT DBG_E_Prox_Phone_Number_Result := __UNWRAP(E_Prox_Phone_Number_Filtered.__Result);
  EXPORT DBG_E_Prox_T_I_N_Result := __UNWRAP(E_Prox_T_I_N_Filtered.__Result);
  EXPORT DBG_E_S_S_N_Inquiry_Result := __UNWRAP(E_S_S_N_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Sele_Address_Result := __UNWRAP(E_Sele_Address_Filtered.__Result);
  EXPORT DBG_E_Sele_Aircraft_Result := __UNWRAP(E_Sele_Aircraft_Filtered.__Result);
  EXPORT DBG_E_Sele_Bankruptcy_Result := __UNWRAP(E_Sele_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Sele_Lien_Judgment_Result := __UNWRAP(E_Sele_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Sele_Person_Result := __UNWRAP(E_Sele_Person_Filtered.__Result);
  EXPORT DBG_E_Sele_Phone_Number_Result := __UNWRAP(E_Sele_Phone_Number_Filtered.__Result);
  EXPORT DBG_E_Sele_Property_Result := __UNWRAP(E_Sele_Property_Filtered.__Result);
  EXPORT DBG_E_Sele_Property_Event_Result := __UNWRAP(E_Sele_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Sele_T_I_N_Result := __UNWRAP(E_Sele_T_I_N_Filtered.__Result);
  EXPORT DBG_E_Sele_Tradeline_Result := __UNWRAP(E_Sele_Tradeline_Filtered.__Result);
  EXPORT DBG_E_Sele_U_C_C_Result := __UNWRAP(E_Sele_U_C_C_Filtered.__Result);
  EXPORT DBG_E_Sele_Vehicle_Result := __UNWRAP(E_Sele_Vehicle_Filtered.__Result);
  EXPORT DBG_E_Sele_Watercraft_Result := __UNWRAP(E_Sele_Watercraft_Filtered.__Result);
  EXPORT DBG_E_Social_Security_Number_Result := __UNWRAP(E_Social_Security_Number_Filtered.__Result);
  EXPORT DBG_E_Tradeline_Result := __UNWRAP(E_Tradeline_Filtered.__Result);
  EXPORT DBG_E_U_C_C_Result := __UNWRAP(E_U_C_C_Filtered.__Result);
  EXPORT DBG_E_Utility_Person_Result := __UNWRAP(E_Utility_Person_Filtered.__Result);
  EXPORT DBG_E_Vehicle_Result := __UNWRAP(E_Vehicle_Filtered.__Result);
  EXPORT DBG_E_Watercraft_Owner_Result := __UNWRAP(E_Watercraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Zip_Code_Result := __UNWRAP(E_Zip_Code_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Intermediate_13 := __UNWRAP(B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13);
  EXPORT DBG_E_U_C_C_Intermediate_13 := __UNWRAP(B_U_C_C_13_Local.__ENH_U_C_C_13);
  EXPORT DBG_E_Lien_Judgment_Intermediate_12 := __UNWRAP(B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12);
  EXPORT DBG_E_Person_Lien_Judgment_Intermediate_12 := __UNWRAP(B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12);
  EXPORT DBG_E_U_C_C_Intermediate_12 := __UNWRAP(B_U_C_C_12_Local.__ENH_U_C_C_12);
  EXPORT DBG_E_Inquiry_Intermediate_11 := __UNWRAP(B_Inquiry_11_Local.__ENH_Inquiry_11);
  EXPORT DBG_E_Person_Intermediate_11 := __UNWRAP(B_Person_11_Local.__ENH_Person_11);
  EXPORT DBG_E_Sele_Lien_Judgment_Intermediate_11 := __UNWRAP(B_Sele_Lien_Judgment_11_Local.__ENH_Sele_Lien_Judgment_11);
  EXPORT DBG_E_U_C_C_Intermediate_11 := __UNWRAP(B_U_C_C_11_Local.__ENH_U_C_C_11);
  EXPORT DBG_E_Business_Sele_Intermediate_10 := __UNWRAP(B_Business_Sele_10_Local.__ENH_Business_Sele_10);
  EXPORT DBG_E_Input_B_I_I_Intermediate_10 := __UNWRAP(B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10);
  EXPORT DBG_E_Inquiry_Intermediate_10 := __UNWRAP(B_Inquiry_10_Local.__ENH_Inquiry_10);
  EXPORT DBG_E_Person_Intermediate_10 := __UNWRAP(B_Person_10_Local.__ENH_Person_10);
  EXPORT DBG_E_Tradeline_Intermediate_10 := __UNWRAP(B_Tradeline_10_Local.__ENH_Tradeline_10);
  EXPORT DBG_E_U_C_C_Intermediate_10 := __UNWRAP(B_U_C_C_10_Local.__ENH_U_C_C_10);
  EXPORT DBG_E_Business_Sele_Intermediate_9 := __UNWRAP(B_Business_Sele_9_Local.__ENH_Business_Sele_9);
  EXPORT DBG_E_Input_B_I_I_Intermediate_9 := __UNWRAP(B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9);
  EXPORT DBG_E_Input_P_I_I_Intermediate_9 := __UNWRAP(B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9);
  EXPORT DBG_E_Inquiry_Intermediate_9 := __UNWRAP(B_Inquiry_9_Local.__ENH_Inquiry_9);
  EXPORT DBG_E_Person_Intermediate_9 := __UNWRAP(B_Person_9_Local.__ENH_Person_9);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_9 := __UNWRAP(B_Sele_U_C_C_9_Local.__ENH_Sele_U_C_C_9);
  EXPORT DBG_E_Tradeline_Intermediate_9 := __UNWRAP(B_Tradeline_9_Local.__ENH_Tradeline_9);
  EXPORT DBG_E_U_C_C_Intermediate_9 := __UNWRAP(B_U_C_C_9_Local.__ENH_U_C_C_9);
  EXPORT DBG_E_Bankruptcy_Intermediate_8 := __UNWRAP(B_Bankruptcy_8_Local.__ENH_Bankruptcy_8);
  EXPORT DBG_E_Business_Sele_Intermediate_8 := __UNWRAP(B_Business_Sele_8_Local.__ENH_Business_Sele_8);
  EXPORT DBG_E_Input_B_I_I_Intermediate_8 := __UNWRAP(B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Inquiry_Intermediate_8 := __UNWRAP(B_Inquiry_8_Local.__ENH_Inquiry_8);
  EXPORT DBG_E_Person_Intermediate_8 := __UNWRAP(B_Person_8_Local.__ENH_Person_8);
  EXPORT DBG_E_Person_Accident_Intermediate_8 := __UNWRAP(B_Person_Accident_8_Local.__ENH_Person_Accident_8);
  EXPORT DBG_E_Person_Inquiry_Intermediate_8 := __UNWRAP(B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_8 := __UNWRAP(B_Sele_U_C_C_8_Local.__ENH_Sele_U_C_C_8);
  EXPORT DBG_E_Tradeline_Intermediate_8 := __UNWRAP(B_Tradeline_8_Local.__ENH_Tradeline_8);
  EXPORT DBG_E_U_C_C_Intermediate_8 := __UNWRAP(B_U_C_C_8_Local.__ENH_U_C_C_8);
  EXPORT DBG_E_Bankruptcy_Intermediate_7 := __UNWRAP(B_Bankruptcy_7_Local.__ENH_Bankruptcy_7);
  EXPORT DBG_E_Business_Sele_Intermediate_7 := __UNWRAP(B_Business_Sele_7_Local.__ENH_Business_Sele_7);
  EXPORT DBG_E_Education_Intermediate_7 := __UNWRAP(B_Education_7_Local.__ENH_Education_7);
  EXPORT DBG_E_Input_B_I_I_Intermediate_7 := __UNWRAP(B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Inquiry_Intermediate_7 := __UNWRAP(B_Inquiry_7_Local.__ENH_Inquiry_7);
  EXPORT DBG_E_Person_Intermediate_7 := __UNWRAP(B_Person_7_Local.__ENH_Person_7);
  EXPORT DBG_E_Person_Inquiry_Intermediate_7 := __UNWRAP(B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7);
  EXPORT DBG_E_Sele_Person_Intermediate_7 := __UNWRAP(B_Sele_Person_7_Local.__ENH_Sele_Person_7);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_7 := __UNWRAP(B_Sele_U_C_C_7_Local.__ENH_Sele_U_C_C_7);
  EXPORT DBG_E_Tradeline_Intermediate_7 := __UNWRAP(B_Tradeline_7_Local.__ENH_Tradeline_7);
  EXPORT DBG_E_U_C_C_Intermediate_7 := __UNWRAP(B_U_C_C_7_Local.__ENH_U_C_C_7);
  EXPORT DBG_E_Address_Intermediate_6 := __UNWRAP(B_Address_6_Local.__ENH_Address_6);
  EXPORT DBG_E_Bankruptcy_Intermediate_6 := __UNWRAP(B_Bankruptcy_6_Local.__ENH_Bankruptcy_6);
  EXPORT DBG_E_Business_Sele_Intermediate_6 := __UNWRAP(B_Business_Sele_6_Local.__ENH_Business_Sele_6);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_6 := __UNWRAP(B_Business_Sele_Overflow_6_Local.__ENH_Business_Sele_Overflow_6);
  EXPORT DBG_E_Education_Intermediate_6 := __UNWRAP(B_Education_6_Local.__ENH_Education_6);
  EXPORT DBG_E_Input_B_I_I_Intermediate_6 := __UNWRAP(B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Inquiry_Intermediate_6 := __UNWRAP(B_Inquiry_6_Local.__ENH_Inquiry_6);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local.__ENH_Person_6);
  EXPORT DBG_E_Person_Inquiry_Intermediate_6 := __UNWRAP(B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6);
  EXPORT DBG_E_Person_Property_Intermediate_6 := __UNWRAP(B_Person_Property_6_Local.__ENH_Person_Property_6);
  EXPORT DBG_E_Property_Event_Intermediate_6 := __UNWRAP(B_Property_Event_6_Local.__ENH_Property_Event_6);
  EXPORT DBG_E_Sele_Address_Intermediate_6 := __UNWRAP(B_Sele_Address_6_Local.__ENH_Sele_Address_6);
  EXPORT DBG_E_Sele_Person_Intermediate_6 := __UNWRAP(B_Sele_Person_6_Local.__ENH_Sele_Person_6);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_6 := __UNWRAP(B_Sele_Phone_Number_6_Local.__ENH_Sele_Phone_Number_6);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_6 := __UNWRAP(B_Sele_T_I_N_6_Local.__ENH_Sele_T_I_N_6);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_6 := __UNWRAP(B_Sele_U_C_C_6_Local.__ENH_Sele_U_C_C_6);
  EXPORT DBG_E_Tradeline_Intermediate_6 := __UNWRAP(B_Tradeline_6_Local.__ENH_Tradeline_6);
  EXPORT DBG_E_U_C_C_Intermediate_6 := __UNWRAP(B_U_C_C_6_Local.__ENH_U_C_C_6);
  EXPORT DBG_E_Address_Intermediate_5 := __UNWRAP(B_Address_5_Local.__ENH_Address_5);
  EXPORT DBG_E_Bankruptcy_Intermediate_5 := __UNWRAP(B_Bankruptcy_5_Local.__ENH_Bankruptcy_5);
  EXPORT DBG_E_Business_Sele_Intermediate_5 := __UNWRAP(B_Business_Sele_5_Local.__ENH_Business_Sele_5);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_5 := __UNWRAP(B_Business_Sele_Overflow_5_Local.__ENH_Business_Sele_Overflow_5);
  EXPORT DBG_E_Criminal_Offense_Intermediate_5 := __UNWRAP(B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5);
  EXPORT DBG_E_Education_Intermediate_5 := __UNWRAP(B_Education_5_Local.__ENH_Education_5);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_5 := __UNWRAP(B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5);
  EXPORT DBG_E_Input_B_I_I_Intermediate_5 := __UNWRAP(B_Input_B_I_I_5_Local.__ENH_Input_B_I_I_5);
  EXPORT DBG_E_Input_P_I_I_Intermediate_5 := __UNWRAP(B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5);
  EXPORT DBG_E_Inquiry_Intermediate_5 := __UNWRAP(B_Inquiry_5_Local.__ENH_Inquiry_5);
  EXPORT DBG_E_Person_Intermediate_5 := __UNWRAP(B_Person_5_Local.__ENH_Person_5);
  EXPORT DBG_E_Person_Inquiry_Intermediate_5 := __UNWRAP(B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5);
  EXPORT DBG_E_Person_Property_Intermediate_5 := __UNWRAP(B_Person_Property_5_Local.__ENH_Person_Property_5);
  EXPORT DBG_E_Professional_License_Intermediate_5 := __UNWRAP(B_Professional_License_5_Local.__ENH_Professional_License_5);
  EXPORT DBG_E_Property_Intermediate_5 := __UNWRAP(B_Property_5_Local.__ENH_Property_5);
  EXPORT DBG_E_Property_Event_Intermediate_5 := __UNWRAP(B_Property_Event_5_Local.__ENH_Property_Event_5);
  EXPORT DBG_E_Sele_Address_Intermediate_5 := __UNWRAP(B_Sele_Address_5_Local.__ENH_Sele_Address_5);
  EXPORT DBG_E_Sele_Person_Intermediate_5 := __UNWRAP(B_Sele_Person_5_Local.__ENH_Sele_Person_5);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_5 := __UNWRAP(B_Sele_Phone_Number_5_Local.__ENH_Sele_Phone_Number_5);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_5 := __UNWRAP(B_Sele_T_I_N_5_Local.__ENH_Sele_T_I_N_5);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_5 := __UNWRAP(B_Sele_U_C_C_5_Local.__ENH_Sele_U_C_C_5);
  EXPORT DBG_E_Tradeline_Intermediate_5 := __UNWRAP(B_Tradeline_5_Local.__ENH_Tradeline_5);
  EXPORT DBG_E_U_C_C_Intermediate_5 := __UNWRAP(B_U_C_C_5_Local.__ENH_U_C_C_5);
  EXPORT DBG_E_Address_Intermediate_4 := __UNWRAP(B_Address_4_Local.__ENH_Address_4);
  EXPORT DBG_E_Bankruptcy_Intermediate_4 := __UNWRAP(B_Bankruptcy_4_Local.__ENH_Bankruptcy_4);
  EXPORT DBG_E_Business_Sele_Intermediate_4 := __UNWRAP(B_Business_Sele_4_Local.__ENH_Business_Sele_4);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_4 := __UNWRAP(B_Business_Sele_Overflow_4_Local.__ENH_Business_Sele_Overflow_4);
  EXPORT DBG_E_Criminal_Offense_Intermediate_4 := __UNWRAP(B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4);
  EXPORT DBG_E_Education_Intermediate_4 := __UNWRAP(B_Education_4_Local.__ENH_Education_4);
  EXPORT DBG_E_Input_B_I_I_Intermediate_4 := __UNWRAP(B_Input_B_I_I_4_Local.__ENH_Input_B_I_I_4);
  EXPORT DBG_E_Input_P_I_I_Intermediate_4 := __UNWRAP(B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4);
  EXPORT DBG_E_Inquiry_Intermediate_4 := __UNWRAP(B_Inquiry_4_Local.__ENH_Inquiry_4);
  EXPORT DBG_E_Person_Intermediate_4 := __UNWRAP(B_Person_4_Local.__ENH_Person_4);
  EXPORT DBG_E_Person_Inquiry_Intermediate_4 := __UNWRAP(B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4);
  EXPORT DBG_E_Person_Property_Intermediate_4 := __UNWRAP(B_Person_Property_4_Local.__ENH_Person_Property_4);
  EXPORT DBG_E_Professional_License_Intermediate_4 := __UNWRAP(B_Professional_License_4_Local.__ENH_Professional_License_4);
  EXPORT DBG_E_Property_Intermediate_4 := __UNWRAP(B_Property_4_Local.__ENH_Property_4);
  EXPORT DBG_E_Property_Event_Intermediate_4 := __UNWRAP(B_Property_Event_4_Local.__ENH_Property_Event_4);
  EXPORT DBG_E_Sele_Address_Intermediate_4 := __UNWRAP(B_Sele_Address_4_Local.__ENH_Sele_Address_4);
  EXPORT DBG_E_Sele_Person_Intermediate_4 := __UNWRAP(B_Sele_Person_4_Local.__ENH_Sele_Person_4);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_4 := __UNWRAP(B_Sele_Phone_Number_4_Local.__ENH_Sele_Phone_Number_4);
  EXPORT DBG_E_Sele_Property_Intermediate_4 := __UNWRAP(B_Sele_Property_4_Local.__ENH_Sele_Property_4);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_4 := __UNWRAP(B_Sele_T_I_N_4_Local.__ENH_Sele_T_I_N_4);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_4 := __UNWRAP(B_Sele_U_C_C_4_Local.__ENH_Sele_U_C_C_4);
  EXPORT DBG_E_Tradeline_Intermediate_4 := __UNWRAP(B_Tradeline_4_Local.__ENH_Tradeline_4);
  EXPORT DBG_E_U_C_C_Intermediate_4 := __UNWRAP(B_U_C_C_4_Local.__ENH_U_C_C_4);
  EXPORT DBG_E_Address_Intermediate_3 := __UNWRAP(B_Address_3_Local.__ENH_Address_3);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_3 := __UNWRAP(B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3);
  EXPORT DBG_E_Bankruptcy_Intermediate_3 := __UNWRAP(B_Bankruptcy_3_Local.__ENH_Bankruptcy_3);
  EXPORT DBG_E_Business_Prox_Intermediate_3 := __UNWRAP(B_Business_Prox_3_Local.__ENH_Business_Prox_3);
  EXPORT DBG_E_Business_Sele_Intermediate_3 := __UNWRAP(B_Business_Sele_3_Local.__ENH_Business_Sele_3);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_3 := __UNWRAP(B_Business_Sele_Overflow_3_Local.__ENH_Business_Sele_Overflow_3);
  EXPORT DBG_E_Criminal_Offense_Intermediate_3 := __UNWRAP(B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3);
  EXPORT DBG_E_Education_Intermediate_3 := __UNWRAP(B_Education_3_Local.__ENH_Education_3);
  EXPORT DBG_E_Input_B_I_I_Intermediate_3 := __UNWRAP(B_Input_B_I_I_3_Local.__ENH_Input_B_I_I_3);
  EXPORT DBG_E_Input_P_I_I_Intermediate_3 := __UNWRAP(B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3);
  EXPORT DBG_E_Inquiry_Intermediate_3 := __UNWRAP(B_Inquiry_3_Local.__ENH_Inquiry_3);
  EXPORT DBG_E_Person_Intermediate_3 := __UNWRAP(B_Person_3_Local.__ENH_Person_3);
  EXPORT DBG_E_Person_Address_Intermediate_3 := __UNWRAP(B_Person_Address_3_Local.__ENH_Person_Address_3);
  EXPORT DBG_E_Person_Inquiry_Intermediate_3 := __UNWRAP(B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3);
  EXPORT DBG_E_Person_Property_Intermediate_3 := __UNWRAP(B_Person_Property_3_Local.__ENH_Person_Property_3);
  EXPORT DBG_E_Person_Vehicle_Intermediate_3 := __UNWRAP(B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3);
  EXPORT DBG_E_Professional_License_Intermediate_3 := __UNWRAP(B_Professional_License_3_Local.__ENH_Professional_License_3);
  EXPORT DBG_E_Property_Intermediate_3 := __UNWRAP(B_Property_3_Local.__ENH_Property_3);
  EXPORT DBG_E_Property_Event_Intermediate_3 := __UNWRAP(B_Property_Event_3_Local.__ENH_Property_Event_3);
  EXPORT DBG_E_Sele_Address_Intermediate_3 := __UNWRAP(B_Sele_Address_3_Local.__ENH_Sele_Address_3);
  EXPORT DBG_E_Sele_Person_Intermediate_3 := __UNWRAP(B_Sele_Person_3_Local.__ENH_Sele_Person_3);
  EXPORT DBG_E_Sele_Phone_Number_Intermediate_3 := __UNWRAP(B_Sele_Phone_Number_3_Local.__ENH_Sele_Phone_Number_3);
  EXPORT DBG_E_Sele_Property_Intermediate_3 := __UNWRAP(B_Sele_Property_3_Local.__ENH_Sele_Property_3);
  EXPORT DBG_E_Sele_T_I_N_Intermediate_3 := __UNWRAP(B_Sele_T_I_N_3_Local.__ENH_Sele_T_I_N_3);
  EXPORT DBG_E_Sele_Tradeline_Intermediate_3 := __UNWRAP(B_Sele_Tradeline_3_Local.__ENH_Sele_Tradeline_3);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_3 := __UNWRAP(B_Sele_U_C_C_3_Local.__ENH_Sele_U_C_C_3);
  EXPORT DBG_E_Sele_Vehicle_Intermediate_3 := __UNWRAP(B_Sele_Vehicle_3_Local.__ENH_Sele_Vehicle_3);
  EXPORT DBG_E_Tradeline_Intermediate_3 := __UNWRAP(B_Tradeline_3_Local.__ENH_Tradeline_3);
  EXPORT DBG_E_U_C_C_Intermediate_3 := __UNWRAP(B_U_C_C_3_Local.__ENH_U_C_C_3);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_3 := __UNWRAP(B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3);
  EXPORT DBG_E_Address_Intermediate_2 := __UNWRAP(B_Address_2_Local.__ENH_Address_2);
  EXPORT DBG_E_Bankruptcy_Intermediate_2 := __UNWRAP(B_Bankruptcy_2_Local.__ENH_Bankruptcy_2);
  EXPORT DBG_E_Business_Prox_Intermediate_2 := __UNWRAP(B_Business_Prox_2_Local.__ENH_Business_Prox_2);
  EXPORT DBG_E_Business_Sele_Intermediate_2 := __UNWRAP(B_Business_Sele_2_Local.__ENH_Business_Sele_2);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_2 := __UNWRAP(B_Business_Sele_Overflow_2_Local.__ENH_Business_Sele_Overflow_2);
  EXPORT DBG_E_Input_B_I_I_Intermediate_2 := __UNWRAP(B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2);
  EXPORT DBG_E_Input_P_I_I_Intermediate_2 := __UNWRAP(B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local.__ENH_Person_2);
  EXPORT DBG_E_Property_Event_Intermediate_2 := __UNWRAP(B_Property_Event_2_Local.__ENH_Property_Event_2);
  EXPORT DBG_E_Sele_Address_Intermediate_2 := __UNWRAP(B_Sele_Address_2_Local.__ENH_Sele_Address_2);
  EXPORT DBG_E_Sele_Person_Intermediate_2 := __UNWRAP(B_Sele_Person_2_Local.__ENH_Sele_Person_2);
  EXPORT DBG_E_Sele_Property_Intermediate_2 := __UNWRAP(B_Sele_Property_2_Local.__ENH_Sele_Property_2);
  EXPORT DBG_E_Sele_Tradeline_Intermediate_2 := __UNWRAP(B_Sele_Tradeline_2_Local.__ENH_Sele_Tradeline_2);
  EXPORT DBG_E_Sele_U_C_C_Intermediate_2 := __UNWRAP(B_Sele_U_C_C_2_Local.__ENH_Sele_U_C_C_2);
  EXPORT DBG_E_Sele_Vehicle_Intermediate_2 := __UNWRAP(B_Sele_Vehicle_2_Local.__ENH_Sele_Vehicle_2);
  EXPORT DBG_E_Tradeline_Intermediate_2 := __UNWRAP(B_Tradeline_2_Local.__ENH_Tradeline_2);
  EXPORT DBG_E_U_C_C_Intermediate_2 := __UNWRAP(B_U_C_C_2_Local.__ENH_U_C_C_2);
  EXPORT DBG_E_Address_Intermediate_1 := __UNWRAP(B_Address_1_Local.__ENH_Address_1);
  EXPORT DBG_E_Bankruptcy_Intermediate_1 := __UNWRAP(B_Bankruptcy_1_Local.__ENH_Bankruptcy_1);
  EXPORT DBG_E_Business_Sele_Intermediate_1 := __UNWRAP(B_Business_Sele_1_Local.__ENH_Business_Sele_1);
  EXPORT DBG_E_Business_Sele_Overflow_Intermediate_1 := __UNWRAP(B_Business_Sele_Overflow_1_Local.__ENH_Business_Sele_Overflow_1);
  EXPORT DBG_E_Input_B_I_I_Intermediate_1 := __UNWRAP(B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1);
  EXPORT DBG_E_Sele_Address_Intermediate_1 := __UNWRAP(B_Sele_Address_1_Local.__ENH_Sele_Address_1);
  EXPORT DBG_E_Sele_Person_Intermediate_1 := __UNWRAP(B_Sele_Person_1_Local.__ENH_Sele_Person_1);
  EXPORT DBG_E_Sele_Property_Intermediate_1 := __UNWRAP(B_Sele_Property_1_Local.__ENH_Sele_Property_1);
  EXPORT DBG_E_Sele_Tradeline_Intermediate_1 := __UNWRAP(B_Sele_Tradeline_1_Local.__ENH_Sele_Tradeline_1);
  EXPORT DBG_E_Sele_Vehicle_Intermediate_1 := __UNWRAP(B_Sele_Vehicle_1_Local.__ENH_Sele_Vehicle_1);
  EXPORT DBG_E_Tradeline_Intermediate_1 := __UNWRAP(B_Tradeline_1_Local.__ENH_Tradeline_1);
  EXPORT DBG_E_Business_Sele_Annotated := __UNWRAP(B_Business_Sele_Local.__ENH_Business_Sele);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Input_B_I_I_PreEntity,NAMED('DBG_E_Input_B_I_I_PreEntity_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Result,NAMED('DBG_E_Input_B_I_I_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_B_I_I_Input_P_I_I_PreEntity_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Input_P_I_I_Result,NAMED('DBG_E_Input_B_I_I_Input_P_I_I_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_P_I_I_PreEntity_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Accident_Result,NAMED('DBG_E_Accident_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Result,NAMED('DBG_E_Address_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Inquiry_Result,NAMED('DBG_E_Address_Inquiry_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Property_Result,NAMED('DBG_E_Address_Property_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Property_Event_Result,NAMED('DBG_E_Address_Property_Event_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Result,NAMED('DBG_E_Aircraft_Owner_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Result,NAMED('DBG_E_Bankruptcy_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Result,NAMED('DBG_E_Business_Prox_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Result,NAMED('DBG_E_Business_Sele_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Result,NAMED('DBG_E_Business_Sele_Overflow_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Result,NAMED('DBG_E_Criminal_Offense_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Result,NAMED('DBG_E_Education_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Result,NAMED('DBG_E_Email_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Inquiry_Result,NAMED('DBG_E_Email_Inquiry_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_First_Degree_Associations_Result,NAMED('DBG_E_First_Degree_Associations_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_First_Degree_Relative_Result,NAMED('DBG_E_First_Degree_Relative_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Household_Result,NAMED('DBG_E_Household_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Household_Member_Result,NAMED('DBG_E_Household_Member_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Result,NAMED('DBG_E_Lien_Judgment_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Accident_Result,NAMED('DBG_E_Person_Accident_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Address_Result,NAMED('DBG_E_Person_Address_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Bankruptcy_Result,NAMED('DBG_E_Person_Bankruptcy_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Education_Result,NAMED('DBG_E_Person_Education_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Email_Result,NAMED('DBG_E_Person_Email_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Result,NAMED('DBG_E_Person_Inquiry_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Result,NAMED('DBG_E_Person_Lien_Judgment_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Offenses_Result,NAMED('DBG_E_Person_Offenses_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Result,NAMED('DBG_E_Person_Property_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Event_Result,NAMED('DBG_E_Person_Property_Event_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Result,NAMED('DBG_E_Person_S_S_N_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Vehicle_Result,NAMED('DBG_E_Person_Vehicle_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Phone_Inquiry_Result,NAMED('DBG_E_Phone_Inquiry_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Result,NAMED('DBG_E_Professional_License_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Person_Result,NAMED('DBG_E_Professional_License_Person_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Result,NAMED('DBG_E_Property_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Result,NAMED('DBG_E_Property_Event_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Prox_Address_Result,NAMED('DBG_E_Prox_Address_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Prox_Phone_Number_Result,NAMED('DBG_E_Prox_Phone_Number_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Prox_T_I_N_Result,NAMED('DBG_E_Prox_T_I_N_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Inquiry_Result,NAMED('DBG_E_S_S_N_Inquiry_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Result,NAMED('DBG_E_Sele_Address_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Aircraft_Result,NAMED('DBG_E_Sele_Aircraft_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Bankruptcy_Result,NAMED('DBG_E_Sele_Bankruptcy_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Lien_Judgment_Result,NAMED('DBG_E_Sele_Lien_Judgment_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Result,NAMED('DBG_E_Sele_Person_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Phone_Number_Result,NAMED('DBG_E_Sele_Phone_Number_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Property_Result,NAMED('DBG_E_Sele_Property_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Property_Event_Result,NAMED('DBG_E_Sele_Property_Event_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_T_I_N_Result,NAMED('DBG_E_Sele_T_I_N_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Tradeline_Result,NAMED('DBG_E_Sele_Tradeline_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Result,NAMED('DBG_E_Sele_U_C_C_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Vehicle_Result,NAMED('DBG_E_Sele_Vehicle_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Watercraft_Result,NAMED('DBG_E_Sele_Watercraft_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Social_Security_Number_Result,NAMED('DBG_E_Social_Security_Number_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Result,NAMED('DBG_E_Tradeline_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Result,NAMED('DBG_E_U_C_C_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Utility_Person_Result,NAMED('DBG_E_Utility_Person_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Vehicle_Result,NAMED('DBG_E_Vehicle_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Result,NAMED('DBG_E_Watercraft_Owner_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Zip_Code_Result,NAMED('DBG_E_Zip_Code_Result_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_13,NAMED('DBG_E_Lien_Judgment_Intermediate_13_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_13,NAMED('DBG_E_U_C_C_Intermediate_13_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Lien_Judgment_Intermediate_12_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Person_Lien_Judgment_Intermediate_12_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_12,NAMED('DBG_E_U_C_C_Intermediate_12_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_11,NAMED('DBG_E_Inquiry_Intermediate_11_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_11,NAMED('DBG_E_Person_Intermediate_11_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Lien_Judgment_Intermediate_11,NAMED('DBG_E_Sele_Lien_Judgment_Intermediate_11_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_11,NAMED('DBG_E_U_C_C_Intermediate_11_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_10,NAMED('DBG_E_Business_Sele_Intermediate_10_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_10,NAMED('DBG_E_Input_B_I_I_Intermediate_10_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_10,NAMED('DBG_E_Inquiry_Intermediate_10_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_10,NAMED('DBG_E_Person_Intermediate_10_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_10,NAMED('DBG_E_Tradeline_Intermediate_10_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_10,NAMED('DBG_E_U_C_C_Intermediate_10_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_9,NAMED('DBG_E_Business_Sele_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_9,NAMED('DBG_E_Input_B_I_I_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_9,NAMED('DBG_E_Input_P_I_I_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_9,NAMED('DBG_E_Inquiry_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_9,NAMED('DBG_E_Person_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_9,NAMED('DBG_E_Sele_U_C_C_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_9,NAMED('DBG_E_Tradeline_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_9,NAMED('DBG_E_U_C_C_Intermediate_9_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_8,NAMED('DBG_E_Bankruptcy_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_8,NAMED('DBG_E_Business_Sele_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_8,NAMED('DBG_E_Input_B_I_I_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_8,NAMED('DBG_E_Inquiry_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_8,NAMED('DBG_E_Person_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Accident_Intermediate_8,NAMED('DBG_E_Person_Accident_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_8,NAMED('DBG_E_Person_Inquiry_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_8,NAMED('DBG_E_Sele_U_C_C_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_8,NAMED('DBG_E_Tradeline_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_8,NAMED('DBG_E_U_C_C_Intermediate_8_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_7,NAMED('DBG_E_Bankruptcy_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_7,NAMED('DBG_E_Business_Sele_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_7,NAMED('DBG_E_Education_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_7,NAMED('DBG_E_Input_B_I_I_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_7,NAMED('DBG_E_Inquiry_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_7,NAMED('DBG_E_Person_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_7,NAMED('DBG_E_Person_Inquiry_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_7,NAMED('DBG_E_Sele_Person_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_7,NAMED('DBG_E_Sele_U_C_C_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_7,NAMED('DBG_E_Tradeline_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_7,NAMED('DBG_E_U_C_C_Intermediate_7_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_6,NAMED('DBG_E_Address_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_6,NAMED('DBG_E_Bankruptcy_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_6,NAMED('DBG_E_Business_Sele_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_6,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_6,NAMED('DBG_E_Education_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_6,NAMED('DBG_E_Input_B_I_I_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_6,NAMED('DBG_E_Inquiry_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_6,NAMED('DBG_E_Person_Inquiry_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_6,NAMED('DBG_E_Person_Property_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_6,NAMED('DBG_E_Property_Event_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_6,NAMED('DBG_E_Sele_Address_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_6,NAMED('DBG_E_Sele_Person_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_6,NAMED('DBG_E_Sele_Phone_Number_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_6,NAMED('DBG_E_Sele_T_I_N_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_6,NAMED('DBG_E_Sele_U_C_C_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_6,NAMED('DBG_E_Tradeline_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_6,NAMED('DBG_E_U_C_C_Intermediate_6_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_5,NAMED('DBG_E_Address_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_5,NAMED('DBG_E_Bankruptcy_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_5,NAMED('DBG_E_Business_Sele_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_5,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_5,NAMED('DBG_E_Criminal_Offense_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_5,NAMED('DBG_E_Education_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_5,NAMED('DBG_E_First_Degree_Relative_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_5,NAMED('DBG_E_Input_B_I_I_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_5,NAMED('DBG_E_Inquiry_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_5,NAMED('DBG_E_Person_Inquiry_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_5,NAMED('DBG_E_Person_Property_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_5,NAMED('DBG_E_Professional_License_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Intermediate_5,NAMED('DBG_E_Property_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_5,NAMED('DBG_E_Property_Event_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_5,NAMED('DBG_E_Sele_Address_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_5,NAMED('DBG_E_Sele_Person_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_5,NAMED('DBG_E_Sele_Phone_Number_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_5,NAMED('DBG_E_Sele_T_I_N_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_5,NAMED('DBG_E_Sele_U_C_C_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_5,NAMED('DBG_E_Tradeline_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_5,NAMED('DBG_E_U_C_C_Intermediate_5_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_4,NAMED('DBG_E_Address_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_4,NAMED('DBG_E_Bankruptcy_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_4,NAMED('DBG_E_Business_Sele_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_4,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_4,NAMED('DBG_E_Criminal_Offense_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_4,NAMED('DBG_E_Education_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_4,NAMED('DBG_E_Input_B_I_I_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_4,NAMED('DBG_E_Inquiry_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_4,NAMED('DBG_E_Person_Inquiry_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_4,NAMED('DBG_E_Person_Property_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_4,NAMED('DBG_E_Professional_License_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Intermediate_4,NAMED('DBG_E_Property_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_4,NAMED('DBG_E_Property_Event_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_4,NAMED('DBG_E_Sele_Address_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_4,NAMED('DBG_E_Sele_Person_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_4,NAMED('DBG_E_Sele_Phone_Number_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_4,NAMED('DBG_E_Sele_Property_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_4,NAMED('DBG_E_Sele_T_I_N_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_4,NAMED('DBG_E_Sele_U_C_C_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_4,NAMED('DBG_E_Tradeline_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_4,NAMED('DBG_E_U_C_C_Intermediate_4_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_3,NAMED('DBG_E_Address_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_3,NAMED('DBG_E_Aircraft_Owner_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_3,NAMED('DBG_E_Bankruptcy_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_3,NAMED('DBG_E_Business_Prox_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_3,NAMED('DBG_E_Business_Sele_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_3,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_3,NAMED('DBG_E_Criminal_Offense_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_3,NAMED('DBG_E_Education_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_3,NAMED('DBG_E_Input_B_I_I_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_3,NAMED('DBG_E_Inquiry_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Address_Intermediate_3,NAMED('DBG_E_Person_Address_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_3,NAMED('DBG_E_Person_Inquiry_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_3,NAMED('DBG_E_Person_Property_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_3,NAMED('DBG_E_Person_Vehicle_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_3,NAMED('DBG_E_Professional_License_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Intermediate_3,NAMED('DBG_E_Property_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_3,NAMED('DBG_E_Property_Event_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_3,NAMED('DBG_E_Sele_Address_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_3,NAMED('DBG_E_Sele_Person_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Phone_Number_Intermediate_3,NAMED('DBG_E_Sele_Phone_Number_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_3,NAMED('DBG_E_Sele_Property_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_T_I_N_Intermediate_3,NAMED('DBG_E_Sele_T_I_N_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Tradeline_Intermediate_3,NAMED('DBG_E_Sele_Tradeline_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_3,NAMED('DBG_E_Sele_U_C_C_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Vehicle_Intermediate_3,NAMED('DBG_E_Sele_Vehicle_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_3,NAMED('DBG_E_Tradeline_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_3,NAMED('DBG_E_U_C_C_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_3,NAMED('DBG_E_Watercraft_Owner_Intermediate_3_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_2,NAMED('DBG_E_Address_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_2,NAMED('DBG_E_Bankruptcy_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_2,NAMED('DBG_E_Business_Prox_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_2,NAMED('DBG_E_Business_Sele_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_2,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_2,NAMED('DBG_E_Input_B_I_I_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_2,NAMED('DBG_E_Input_P_I_I_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_2,NAMED('DBG_E_Property_Event_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_2,NAMED('DBG_E_Sele_Address_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_2,NAMED('DBG_E_Sele_Person_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_2,NAMED('DBG_E_Sele_Property_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Tradeline_Intermediate_2,NAMED('DBG_E_Sele_Tradeline_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_U_C_C_Intermediate_2,NAMED('DBG_E_Sele_U_C_C_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Vehicle_Intermediate_2,NAMED('DBG_E_Sele_Vehicle_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_2,NAMED('DBG_E_Tradeline_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_U_C_C_Intermediate_2,NAMED('DBG_E_U_C_C_Intermediate_2_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_1,NAMED('DBG_E_Address_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_1,NAMED('DBG_E_Bankruptcy_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Intermediate_1,NAMED('DBG_E_Business_Sele_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Overflow_Intermediate_1,NAMED('DBG_E_Business_Sele_Overflow_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_1,NAMED('DBG_E_Input_B_I_I_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Address_Intermediate_1,NAMED('DBG_E_Sele_Address_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_1,NAMED('DBG_E_Sele_Person_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Property_Intermediate_1,NAMED('DBG_E_Sele_Property_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Tradeline_Intermediate_1,NAMED('DBG_E_Sele_Tradeline_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Vehicle_Intermediate_1,NAMED('DBG_E_Sele_Vehicle_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Tradeline_Intermediate_1,NAMED('DBG_E_Tradeline_Intermediate_1_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Sele_Annotated,NAMED('DBG_E_Business_Sele_Annotated_Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
