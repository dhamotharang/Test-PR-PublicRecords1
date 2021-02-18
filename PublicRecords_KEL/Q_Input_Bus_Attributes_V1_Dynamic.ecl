//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_3,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_First_Degree_Relative_5,B_Input_B_I_I,B_Input_B_I_I_1,B_Input_B_I_I_10,B_Input_B_I_I_2,B_Input_B_I_I_3,B_Input_B_I_I_4,B_Input_B_I_I_5,B_Input_B_I_I_6,B_Input_B_I_I_7,B_Input_B_I_I_8,B_Input_B_I_I_9,B_Input_P_I_I_1,B_Input_P_I_I_10,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Inquiry_10,B_Inquiry_11,B_Inquiry_3,B_Inquiry_4,B_Inquiry_5,B_Inquiry_6,B_Inquiry_7,B_Inquiry_8,B_Inquiry_9,B_Lien_Judgment_13,B_Person_10,B_Person_11,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Accident_8,B_Person_Address_3,B_Person_Inquiry_3,B_Person_Inquiry_4,B_Person_Inquiry_5,B_Person_Inquiry_6,B_Person_Inquiry_7,B_Person_Inquiry_8,B_Person_Lien_Judgment_12,B_Person_Property_3,B_Person_Property_4,B_Person_Property_5,B_Person_Property_6,B_Person_Property_7,B_Person_Property_8,B_Person_Vehicle_3,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property_4,B_Property_5,B_Property_Event_6,B_Property_Event_7,B_Property_Event_8,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Property,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Criminal_Offense,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Household,E_Household_Member,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Education,E_Person_Email,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offenses,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_S_S_N_Inquiry,E_Sele_Person,E_Social_Security_Number,E_Utility_Person,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT Q_Input_Bus_Attributes_V1_Dynamic(DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)) __PInputBIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
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
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),p_lexid(OVERRIDE:Subject_:0|DEFAULT:P___Lex_I_D_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),Input_Clean_Email_(OVERRIDE:Input_Clean_Email_:0),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'|OVERRIDE:Input_Clean_Phone_:0|OVERRIDE:Telephone_Summary_:0),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'|OVERRIDE:Input_Clean_S_S_N_:0|OVERRIDE:Social_Summary_:0),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),Name_Summ_(DEFAULT:Name_Summ_:0),Location_Summary_(DEFAULT:Location_Summary_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
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
    SHARED __d0_Name_Summ__Layout := RECORD
      RECORDOF(__d0_Input_Clean_Email__Mapped);
      KEL.typ.uid Name_Summ_;
    END;
    SHARED __d0_Missing_Name_Summ__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Input_Clean_Email__Mapped,'P_InpClnNameFirst,P_InpClnNameLast,P_InpClnDOB','__PInputPIIDataset');
    SHARED __d0_Name_Summ__Mapped := IF(__d0_Missing_Name_Summ__UIDComponents = 'P_InpClnNameFirst,P_InpClnNameLast,P_InpClnDOB',PROJECT(__d0_Input_Clean_Email__Mapped,TRANSFORM(__d0_Name_Summ__Layout,SELF.Name_Summ_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Input_Clean_Email__Mapped,__d0_Missing_Name_Summ__UIDComponents),E_Name_Summary(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnNameFirst) + '|' + TRIM((STRING)LEFT.P_InpClnNameLast) + '|' + TRIM((STRING)LEFT.P_InpClnDOB) = RIGHT.KeyVal,TRANSFORM(__d0_Name_Summ__Layout,SELF.Name_Summ_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Location_Summary__Layout := RECORD
      RECORDOF(__d0_Name_Summ__Mapped);
      KEL.typ.uid Location_Summary_;
    END;
    SHARED __d0_Missing_Location_Summary__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Name_Summ__Mapped,'P_InpClnAddrPrimName,P_InpClnAddrPrimRng,P_InpClnAddrZip5','__PInputPIIDataset');
    SHARED __d0_Location_Summary__Mapped := IF(__d0_Missing_Location_Summary__UIDComponents = 'P_InpClnAddrPrimName,P_InpClnAddrPrimRng,P_InpClnAddrZip5',PROJECT(__d0_Name_Summ__Mapped,TRANSFORM(__d0_Location_Summary__Layout,SELF.Location_Summary_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Name_Summ__Mapped,__d0_Missing_Location_Summary__UIDComponents),E_Address_Summary(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + TRIM((STRING)LEFT.P_InpClnAddrZip5) = RIGHT.KeyVal,TRANSFORM(__d0_Location_Summary__Layout,SELF.Location_Summary_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Prefiltered := __d0_Location_Summary__Mapped((KEL.typ.uid)G_ProcUID <> 0);
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
  SHARED E_Phone_Filtered := MODULE(E_Phone(__in,__cfg_Local))
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
  SHARED E_S_S_N_Inquiry_Filtered := MODULE(E_S_S_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Person_Filtered := MODULE(E_Utility_Person(__in,__cfg_Local))
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
  SHARED B_Person_Lien_Judgment_12_Local := MODULE(B_Person_Lien_Judgment_12(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_13(__in,__cfg_Local).__ENH_Lien_Judgment_13) __ENH_Lien_Judgment_13 := B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13;
    SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_Inquiry_11_Local := MODULE(B_Inquiry_11(__in,__cfg_Local))
    SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  END;
  SHARED B_Person_11_Local := MODULE(B_Person_11(__in,__cfg_Local))
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(B_Person_Lien_Judgment_12(__in,__cfg_Local).__ENH_Person_Lien_Judgment_12) __ENH_Person_Lien_Judgment_12 := B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12;
  END;
  SHARED B_Input_B_I_I_10_Local := MODULE(B_Input_B_I_I_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_B_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I := E_Input_B_I_I_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_10_Local := MODULE(B_Input_P_I_I_10(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Inquiry_10_Local := MODULE(B_Inquiry_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_11(__in,__cfg_Local).__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11_Local.__ENH_Inquiry_11;
  END;
  SHARED B_Person_10_Local := MODULE(B_Person_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_11(__in,__cfg_Local).__ENH_Person_11) __ENH_Person_11 := B_Person_11_Local.__ENH_Person_11;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_9_Local := MODULE(B_Input_B_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_10(__in,__cfg_Local).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10;
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_10(__in,__cfg_Local).__ENH_Input_P_I_I_10) __ENH_Input_P_I_I_10 := B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10;
  END;
  SHARED B_Inquiry_9_Local := MODULE(B_Inquiry_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_10(__in,__cfg_Local).__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10_Local.__ENH_Inquiry_10;
  END;
  SHARED B_Person_9_Local := MODULE(B_Person_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_10(__in,__cfg_Local).__ENH_Person_10) __ENH_Person_10 := B_Person_10_Local.__ENH_Person_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
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
  SHARED B_Person_Property_8_Local := MODULE(B_Person_Property_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Property(__in,__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered.__Result;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Property_Event_8_Local := MODULE(B_Property_Event_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_7_Local := MODULE(B_Bankruptcy_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg_Local).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local.__ENH_Bankruptcy_8;
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
  SHARED B_Person_Property_7_Local := MODULE(B_Person_Property_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_8(__in,__cfg_Local).__ENH_Person_Property_8) __ENH_Person_Property_8 := B_Person_Property_8_Local.__ENH_Person_Property_8;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_8(__in,__cfg_Local).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8_Local.__ENH_Property_Event_8;
  END;
  SHARED B_Property_Event_7_Local := MODULE(B_Property_Event_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_8(__in,__cfg_Local).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8_Local.__ENH_Property_Event_8;
  END;
  SHARED B_Sele_Person_7_Local := MODULE(B_Sele_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_6_Local := MODULE(B_Bankruptcy_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg_Local).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local.__ENH_Bankruptcy_7;
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
    SHARED TYPEOF(B_Person_Property_7(__in,__cfg_Local).__ENH_Person_Property_7) __ENH_Person_Property_7 := B_Person_Property_7_Local.__ENH_Person_Property_7;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_7(__in,__cfg_Local).__ENH_Property_Event_7) __ENH_Property_Event_7 := B_Property_Event_7_Local.__ENH_Property_Event_7;
  END;
  SHARED B_Property_Event_6_Local := MODULE(B_Property_Event_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_7(__in,__cfg_Local).__ENH_Property_Event_7) __ENH_Property_Event_7 := B_Property_Event_7_Local.__ENH_Property_Event_7;
  END;
  SHARED B_Sele_Person_6_Local := MODULE(B_Sele_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_7(__in,__cfg_Local).__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7_Local.__ENH_Sele_Person_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg_Local).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
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
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_6(__in,__cfg_Local).__ENH_Property_Event_6) __ENH_Property_Event_6 := B_Property_Event_6_Local.__ENH_Property_Event_6;
  END;
  SHARED B_Professional_License_5_Local := MODULE(B_Professional_License_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  END;
  SHARED B_Property_5_Local := MODULE(B_Property_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  END;
  SHARED B_Sele_Person_5_Local := MODULE(B_Sele_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_6(__in,__cfg_Local).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local.__ENH_Sele_Person_6;
  END;
  SHARED B_Address_4_Local := MODULE(B_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
  END;
  SHARED B_Bankruptcy_4_Local := MODULE(B_Bankruptcy_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
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
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
    SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered.__Result;
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
    SHARED TYPEOF(B_Person_Property_5(__in,__cfg_Local).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5_Local.__ENH_Person_Property_5;
    SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_4_Local := MODULE(B_Person_Inquiry_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Inquiry_5(__in,__cfg_Local).__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5;
  END;
  SHARED B_Person_Property_4_Local := MODULE(B_Person_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_5(__in,__cfg_Local).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5_Local.__ENH_Person_Property_5;
  END;
  SHARED B_Professional_License_4_Local := MODULE(B_Professional_License_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg_Local).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local.__ENH_Professional_License_5;
  END;
  SHARED B_Property_4_Local := MODULE(B_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_5(__in,__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
  END;
  SHARED B_Sele_Person_4_Local := MODULE(B_Sele_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__in,__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
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
    SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Inquiry_4(__in,__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
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
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Person_Vehicle_3_Local := MODULE(B_Person_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Sele_Person_3_Local := MODULE(B_Sele_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
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
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
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
  SHARED B_Input_B_I_I_1_Local := MODULE(B_Input_B_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_2(__in,__cfg_Local).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Input_P_I_I_1_Local := MODULE(B_Input_P_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered.__Result;
    SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  END;
  SHARED B_Input_B_I_I_Local := MODULE(B_Input_B_I_I(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_B_I_I_1(__in,__cfg_Local).__ENH_Input_B_I_I_1) __ENH_Input_B_I_I_1 := B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
  END;
  SHARED TYPEOF(B_Input_B_I_I(__in,__cfg_Local).__ENH_Input_B_I_I) __ENH_Input_B_I_I := B_Input_B_I_I_Local.__ENH_Input_B_I_I;
  SHARED __EE11314227 := __ENH_Input_B_I_I;
  SHARED __ST84015_Layout := RECORD
    KEL.typ.nuid G___Proc_Bus_U_I_D_;
    KEL.typ.nstr B___Inp_Acct_;
    KEL.typ.nint G___Proc_Bus_U_I_D__1_;
    KEL.typ.nint B___Inp_Lex_I_D_Ult_;
    KEL.typ.nint B___Inp_Lex_I_D_Org_;
    KEL.typ.nint B___Inp_Lex_I_D_Legal_;
    KEL.typ.nint B___Inp_Lex_I_D_Site_;
    KEL.typ.nint B___Inp_Lex_I_D_Loc_;
    KEL.typ.nstr B___Inp_Name_;
    KEL.typ.nstr B___Inp_Alt_Name_;
    KEL.typ.nstr B___Inp_Addr_Line1_;
    KEL.typ.nstr B___Inp_Addr_Line2_;
    KEL.typ.nstr B___Inp_Addr_City_;
    KEL.typ.nstr B___Inp_Addr_State_;
    KEL.typ.nstr B___Inp_Addr_Zip_;
    KEL.typ.nstr B___Inp_Phone_;
    KEL.typ.nstr B___Inp_I_P_Addr_;
    KEL.typ.nstr B___Inp_U_R_L_;
    KEL.typ.nstr B___Inp_Email_;
    KEL.typ.nstr B___Inp_T_I_N_;
    KEL.typ.nstr B___Inp_S_I_C_Code_;
    KEL.typ.nstr B___Inp_N_A_I_C_S_Code_;
    KEL.typ.nstr B___Inp_Arch_Dt_;
    KEL.typ.nint B___Rep1_Inp_Lex_I_D_;
    KEL.typ.nstr B___Rep1_Inp_Name_First_;
    KEL.typ.nstr B___Rep1_Inp_Name_Mid_;
    KEL.typ.nstr B___Rep1_Inp_Name_Last_;
    KEL.typ.nstr B___Rep1_Inp_Addr_Line1_;
    KEL.typ.nstr B___Rep1_Inp_Addr_Line2_;
    KEL.typ.nstr B___Rep1_Inp_Addr_City_;
    KEL.typ.nstr B___Rep1_Inp_Addr_State_;
    KEL.typ.nstr B___Rep1_Inp_Addr_Zip_;
    KEL.typ.nstr B___Rep1_Inp_Phone_;
    KEL.typ.nstr B___Rep1_Inp_S_S_N_;
    KEL.typ.nstr B___Rep1_Inp_D_O_B_;
    KEL.typ.nstr B___Rep1_Inp_Email_;
    KEL.typ.nstr B___Rep1_Inp_D_L_;
    KEL.typ.nstr B___Rep1_Inp_D_L_State_;
    KEL.typ.nint B___Rep2_Inp_Lex_I_D_;
    KEL.typ.nstr B___Rep2_Inp_Name_First_;
    KEL.typ.nstr B___Rep2_Inp_Name_Mid_;
    KEL.typ.nstr B___Rep2_Inp_Name_Last_;
    KEL.typ.nstr B___Rep2_Inp_Addr_Line1_;
    KEL.typ.nstr B___Rep2_Inp_Addr_Line2_;
    KEL.typ.nstr B___Rep2_Inp_Addr_City_;
    KEL.typ.nstr B___Rep2_Inp_Addr_State_;
    KEL.typ.nstr B___Rep2_Inp_Addr_Zip_;
    KEL.typ.nstr B___Rep2_Inp_Phone_;
    KEL.typ.nstr B___Rep2_Inp_S_S_N_;
    KEL.typ.nstr B___Rep2_Inp_D_O_B_;
    KEL.typ.nstr B___Rep2_Inp_Email_;
    KEL.typ.nstr B___Rep2_Inp_D_L_;
    KEL.typ.nstr B___Rep2_Inp_D_L_State_;
    KEL.typ.nint B___Rep3_Inp_Lex_I_D_;
    KEL.typ.nstr B___Rep3_Inp_Name_First_;
    KEL.typ.nstr B___Rep3_Inp_Name_Mid_;
    KEL.typ.nstr B___Rep3_Inp_Name_Last_;
    KEL.typ.nstr B___Rep3_Inp_Addr_Line1_;
    KEL.typ.nstr B___Rep3_Inp_Addr_Line2_;
    KEL.typ.nstr B___Rep3_Inp_Addr_City_;
    KEL.typ.nstr B___Rep3_Inp_Addr_State_;
    KEL.typ.nstr B___Rep3_Inp_Addr_Zip_;
    KEL.typ.nstr B___Rep3_Inp_Phone_;
    KEL.typ.nstr B___Rep3_Inp_S_S_N_;
    KEL.typ.nstr B___Rep3_Inp_D_O_B_;
    KEL.typ.nstr B___Rep3_Inp_Email_;
    KEL.typ.nstr B___Rep3_Inp_D_L_;
    KEL.typ.nstr B___Rep3_Inp_D_L_State_;
    KEL.typ.nint B___Rep4_Inp_Lex_I_D_;
    KEL.typ.nstr B___Rep4_Inp_Name_First_;
    KEL.typ.nstr B___Rep4_Inp_Name_Mid_;
    KEL.typ.nstr B___Rep4_Inp_Name_Last_;
    KEL.typ.nstr B___Rep4_Inp_Addr_Line1_;
    KEL.typ.nstr B___Rep4_Inp_Addr_Line2_;
    KEL.typ.nstr B___Rep4_Inp_Addr_City_;
    KEL.typ.nstr B___Rep4_Inp_Addr_State_;
    KEL.typ.nstr B___Rep4_Inp_Addr_Zip_;
    KEL.typ.nstr B___Rep4_Inp_Phone_;
    KEL.typ.nstr B___Rep4_Inp_S_S_N_;
    KEL.typ.nstr B___Rep4_Inp_D_O_B_;
    KEL.typ.nstr B___Rep4_Inp_Email_;
    KEL.typ.nstr B___Rep4_Inp_D_L_;
    KEL.typ.nstr B___Rep4_Inp_D_L_State_;
    KEL.typ.nint B___Rep5_Inp_Lex_I_D_;
    KEL.typ.nstr B___Rep5_Inp_Name_First_;
    KEL.typ.nstr B___Rep5_Inp_Name_Mid_;
    KEL.typ.nstr B___Rep5_Inp_Name_Last_;
    KEL.typ.nstr B___Rep5_Inp_Addr_Line1_;
    KEL.typ.nstr B___Rep5_Inp_Addr_Line2_;
    KEL.typ.nstr B___Rep5_Inp_Addr_City_;
    KEL.typ.nstr B___Rep5_Inp_Addr_State_;
    KEL.typ.nstr B___Rep5_Inp_Addr_Zip_;
    KEL.typ.nstr B___Rep5_Inp_Phone_;
    KEL.typ.nstr B___Rep5_Inp_S_S_N_;
    KEL.typ.nstr B___Rep5_Inp_D_O_B_;
    KEL.typ.nstr B___Rep5_Inp_Email_;
    KEL.typ.nstr B___Rep5_Inp_D_L_;
    KEL.typ.nstr B___Rep5_Inp_D_L_State_;
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.nint B___Lex_I_D_Site_;
    KEL.typ.nint B___Lex_I_D_Loc_;
    KEL.typ.nint B___Lex_I_D_Legal_Score_;
    KEL.typ.nint B___Lex_I_D_Legal_Wgt_;
    KEL.typ.nstr B___Inp_Cln_Arch_Dt_;
    KEL.typ.nstr B___Inp_Cln_Name_;
    KEL.typ.nstr B___Inp_Cln_Alt_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Inp_Cln_Addr_St_;
    KEL.typ.nstr B___Inp_Cln_Addr_Full_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Inp_Cln_Addr_Status_;
    KEL.typ.nint B___Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr B___Inp_Cln_Phone_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_;
    KEL.typ.nstr B___Inp_Cln_I_P_Addr_;
    KEL.typ.nstr B___Inp_Cln_Email_;
    KEL.typ.nint B___Rep1_Lex_I_D_;
    KEL.typ.nint B___Rep1_Lex_I_D_Score_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Prfx_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_First_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Mid_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Last_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Sffx_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_St_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Full_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Status_;
    KEL.typ.nint B___Rep1_Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Phone_;
    KEL.typ.nstr B___Rep1_Inp_Cln_S_S_N_;
    KEL.typ.nstr B___Rep1_Inp_Cln_D_O_B_;
    KEL.typ.nstr B___Rep1_Inp_Cln_D_L_;
    KEL.typ.nstr B___Rep1_Inp_Cln_D_L_State_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Email_;
    KEL.typ.nint B___Rep2_Lex_I_D_;
    KEL.typ.nint B___Rep2_Lex_I_D_Score_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Prfx_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_First_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Mid_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Last_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Sffx_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_St_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Full_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Status_;
    KEL.typ.nint B___Rep2_Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Phone_;
    KEL.typ.nstr B___Rep2_Inp_Cln_S_S_N_;
    KEL.typ.nstr B___Rep2_Inp_Cln_D_O_B_;
    KEL.typ.nstr B___Rep2_Inp_Cln_D_L_;
    KEL.typ.nstr B___Rep2_Inp_Cln_D_L_State_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Email_;
    KEL.typ.nint B___Rep3_Lex_I_D_;
    KEL.typ.nint B___Rep3_Lex_I_D_Score_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Prfx_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_First_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Mid_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Last_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Sffx_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_St_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Full_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Status_;
    KEL.typ.nint B___Rep3_Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Phone_;
    KEL.typ.nstr B___Rep3_Inp_Cln_S_S_N_;
    KEL.typ.nstr B___Rep3_Inp_Cln_D_O_B_;
    KEL.typ.nstr B___Rep3_Inp_Cln_D_L_;
    KEL.typ.nstr B___Rep3_Inp_Cln_D_L_State_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Email_;
    KEL.typ.nint B___Rep4_Lex_I_D_;
    KEL.typ.nint B___Rep4_Lex_I_D_Score_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Prfx_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_First_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Mid_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Last_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Sffx_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_St_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Full_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Status_;
    KEL.typ.nint B___Rep4_Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Phone_;
    KEL.typ.nstr B___Rep4_Inp_Cln_S_S_N_;
    KEL.typ.nstr B___Rep4_Inp_Cln_D_O_B_;
    KEL.typ.nstr B___Rep4_Inp_Cln_D_L_;
    KEL.typ.nstr B___Rep4_Inp_Cln_D_L_State_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Email_;
    KEL.typ.nint B___Rep5_Lex_I_D_;
    KEL.typ.nint B___Rep5_Lex_I_D_Score_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Prfx_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_First_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Mid_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Last_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Sffx_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_St_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Full_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Status_;
    KEL.typ.nint B___Rep5_Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Phone_;
    KEL.typ.nstr B___Rep5_Inp_Cln_S_S_N_;
    KEL.typ.nstr B___Rep5_Inp_Cln_D_O_B_;
    KEL.typ.nstr B___Rep5_Inp_Cln_D_L_;
    KEL.typ.nstr B___Rep5_Inp_Cln_D_L_State_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Email_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Name_First_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Name_Mid_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Name_Last_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Rep6_Inp_Cln_Phone_;
    KEL.typ.nstr B___Rep6_Inp_Cln_S_S_N_;
    KEL.typ.str B___Inp_Arch_Dt_Flag_ := '';
    KEL.typ.str B___Inp_Name_Flag_ := '';
    KEL.typ.str B___Inp_Alt_Name_Flag_ := '';
    KEL.typ.str B___Inp_Addr_St_Flag_ := '';
    KEL.typ.str B___Inp_Addr_City_Flag_ := '';
    KEL.typ.str B___Inp_Addr_State_Flag_ := '';
    KEL.typ.str B___Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str B___Inp_Phone_Flag_ := '';
    KEL.typ.str B___Inp_I_P_Addr_Flag_ := '';
    KEL.typ.str B___Inp_T_I_N_Flag_ := '';
    KEL.typ.str B___Inp_S_I_C_Code_Flag_ := '';
    KEL.typ.str B___Inp_N_A_I_C_S_Code_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Lex_I_D_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Name_First_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Name_Mid_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Name_Last_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Addr_St_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Addr_City_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Addr_State_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Phone_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_S_S_N_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_D_O_B_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_Email_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_D_L_Flag_ := '';
    KEL.typ.str B___Rep1_Inp_D_L_State_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Lex_I_D_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Name_First_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Name_Mid_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Name_Last_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Addr_St_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Addr_City_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Addr_State_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Phone_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_S_S_N_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_D_O_B_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_Email_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_D_L_Flag_ := '';
    KEL.typ.str B___Rep2_Inp_D_L_State_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Lex_I_D_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Name_First_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Name_Mid_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Name_Last_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Addr_St_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Addr_City_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Addr_State_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Phone_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_S_S_N_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_D_O_B_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_Email_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_D_L_Flag_ := '';
    KEL.typ.str B___Rep3_Inp_D_L_State_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Lex_I_D_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Name_First_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Name_Mid_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Name_Last_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Addr_St_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Addr_City_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Addr_State_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Phone_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_S_S_N_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_D_O_B_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_Email_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_D_L_Flag_ := '';
    KEL.typ.str B___Rep4_Inp_D_L_State_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Lex_I_D_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Name_First_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Name_Mid_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Name_Last_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Addr_St_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Addr_City_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Addr_State_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Phone_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_S_S_N_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_D_O_B_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_Email_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_D_L_Flag_ := '';
    KEL.typ.str B___Rep5_Inp_D_L_State_Flag_ := '';
    KEL.typ.nstr B___Inp_Cln_Name_Flag_;
    KEL.typ.nstr B___Inp_Cln_Alt_Name_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr B___Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr B___Inp_Cln_Phone_Flag_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_Flag_;
    KEL.typ.nstr B___Inp_Cln_I_P_Addr_Flag_;
    KEL.typ.nstr B___Inp_Cln_Email_Flag_;
    KEL.typ.str B___Inp_Cln_Arch_Dt_Flag_ := '';
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Prfx_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_First_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Mid_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Last_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Name_Sffx_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Phone_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_S_S_N_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_D_O_B_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_Email_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_D_L_Flag_;
    KEL.typ.nstr B___Rep1_Inp_Cln_D_L_State_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Prfx_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_First_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Mid_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Last_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Name_Sffx_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Phone_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_S_S_N_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_D_O_B_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_Email_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_D_L_Flag_;
    KEL.typ.nstr B___Rep2_Inp_Cln_D_L_State_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Prfx_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_First_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Mid_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Last_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Name_Sffx_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Phone_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_S_S_N_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_D_O_B_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_Email_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_D_L_Flag_;
    KEL.typ.nstr B___Rep3_Inp_Cln_D_L_State_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Prfx_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_First_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Mid_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Last_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Name_Sffx_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Phone_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_S_S_N_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_D_O_B_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_Email_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_D_L_Flag_;
    KEL.typ.nstr B___Rep4_Inp_Cln_D_L_State_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Prfx_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_First_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Mid_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Last_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Name_Sffx_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Phone_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_S_S_N_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_D_O_B_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_Email_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_D_L_Flag_;
    KEL.typ.nstr B___Rep5_Inp_Cln_D_L_State_Flag_;
    KEL.typ.nint B___Inp_Val_Name_Invalid_Flag_;
    KEL.typ.nint B___Inp_Val_Alt_Name_Invalid_Flag_;
    KEL.typ.nint B___Inp_Val_Addr_St_Invalid_Flag_;
    KEL.typ.nint B___Inp_Val_Phone_Invalid_Flag_;
    KEL.typ.nint B___Inp_Val_T_I_N_Invalid_Flag_;
    KEL.typ.nint B___Inp_Val_Email_Invalid_Flag_;
    KEL.typ.nint B___Inp_Val_Addr_Zip_Bad_Len_Flag_;
    KEL.typ.int B___Inp_Val_Addr_Zip_All_Zero_Flag_ := 0;
    KEL.typ.int B___Inp_Val_Addr_State_Bad_Abbr_Flag_ := 0;
    KEL.typ.int B___Inp_Val_Phone_Bad_Char_Flag_ := 0;
    KEL.typ.nint B___Inp_Val_Phone_Bad_Len_Flag_;
    KEL.typ.int B___Inp_Val_Phone_Bogus_Flag_ := 0;
    KEL.typ.int B___Inp_Val_T_I_N_Bad_Char_Flag_ := 0;
    KEL.typ.nint B___Inp_Val_T_I_N_Bad_Len_Flag_;
    KEL.typ.int B___Inp_Val_T_I_N_Bogus_Flag_ := 0;
    KEL.typ.nint B___Inp_Val_Email_Bogus_Flag_;
    KEL.typ.nint B___Inp_Val_Email_User_Bad_Char_Flag_;
    KEL.typ.nint B___Inp_Val_Email_User_All_Zero_Flag_;
    KEL.typ.nint B___Inp_Val_Email_Dom_Bad_Char_Flag_;
    KEL.typ.nint B___Inp_Val_Email_Dom_All_Zero_Flag_;
    KEL.typ.str B___Inp_Val_Name_Bad_Char_Flag_ := '';
    KEL.typ.str B___Inp_Val_Alt_Name_Bad_Char_Flag_ := '';
    KEL.typ.nint B___Inp_Val_Name_Matches_Alt_Name_Flag_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST84015_Layout __ND11314232__Project(B_Input_B_I_I(__in,__cfg_Local).__ST152906_Layout __PP11314228) := TRANSFORM
    SELF.G___Proc_Bus_U_I_D_ := __PP11314228.UID;
    SELF.B___Inp_Acct_ := __PP11314228.Bus_Input_Account_Echo_Value_;
    SELF.G___Proc_Bus_U_I_D__1_ := __PP11314228.G___Proc_Bus_U_I_D_;
    SELF.B___Inp_Lex_I_D_Ult_ := __PP11314228.B___Inp_Lex_I_D_Ult_Value_;
    SELF.B___Inp_Lex_I_D_Org_ := __PP11314228.B___Inp_Lex_I_D_Org_Value_;
    SELF.B___Inp_Lex_I_D_Legal_ := __PP11314228.B___Inp_Lex_I_D_Legal_Value_;
    SELF.B___Inp_Lex_I_D_Site_ := __PP11314228.B___Inp_Lex_I_D_Site_Value_;
    SELF.B___Inp_Lex_I_D_Loc_ := __PP11314228.B___Inp_Lex_I_D_Loc_Value_;
    SELF.B___Inp_Name_ := __PP11314228.Bus_Input_Name_Echo_Value_;
    SELF.B___Inp_Alt_Name_ := __PP11314228.Bus_Input_Alternate_Name_Echo_Value_;
    SELF.B___Inp_Addr_Line1_ := __PP11314228.Bus_Input_Street_Echo_Value_;
    SELF.B___Inp_Addr_Line2_ := __PP11314228.B___Inp_Addr_Line2_Value_;
    SELF.B___Inp_Addr_City_ := __PP11314228.Bus_Input_City_Echo_Value_;
    SELF.B___Inp_Addr_State_ := __PP11314228.Bus_Input_State_Echo_Value_;
    SELF.B___Inp_Addr_Zip_ := __PP11314228.Bus_Input_Zip_Echo_Value_;
    SELF.B___Inp_Phone_ := __PP11314228.Bus_Input_Phone_Echo_Value_;
    SELF.B___Inp_I_P_Addr_ := __PP11314228.Bus_Input_I_P_Address_Echo_Value_;
    SELF.B___Inp_U_R_L_ := __PP11314228.Bus_Input_U_R_L_Echo_Value_;
    SELF.B___Inp_Email_ := __PP11314228.Bus_Input_Email_Echo_Value_;
    SELF.B___Inp_T_I_N_ := __PP11314228.Bus_Input_T_I_N_Echo_Value_;
    SELF.B___Inp_S_I_C_Code_ := __PP11314228.Bus_Input_S_I_C_Code_Echo_Value_;
    SELF.B___Inp_N_A_I_C_S_Code_ := __PP11314228.Bus_Input_N_A_I_C_S_Code_Echo_Value_;
    SELF.B___Inp_Arch_Dt_ := __PP11314228.Bus_Input_Archive_Date_Echo_Value_;
    SELF.B___Rep1_Inp_Lex_I_D_ := __PP11314228.Bus_Input_Rep1_Lex_I_D_Echo_Value_;
    SELF.B___Rep1_Inp_Name_First_ := __PP11314228.Bus_Input_Rep1_First_Name_Echo_Value_;
    SELF.B___Rep1_Inp_Name_Mid_ := __PP11314228.Bus_Input_Rep1_Middle_Name_Echo_Value_;
    SELF.B___Rep1_Inp_Name_Last_ := __PP11314228.Bus_Input_Rep1_Last_Name_Echo_Value_;
    SELF.B___Rep1_Inp_Addr_Line1_ := __PP11314228.Bus_Input_Rep1_Street_Echo_Value_;
    SELF.B___Rep1_Inp_Addr_Line2_ := __PP11314228.B___Rep1_Inp_Addr_Line2_Value_;
    SELF.B___Rep1_Inp_Addr_City_ := __PP11314228.Bus_Input_Rep1_City_Echo_Value_;
    SELF.B___Rep1_Inp_Addr_State_ := __PP11314228.Bus_Input_Rep1_State_Echo_Value_;
    SELF.B___Rep1_Inp_Addr_Zip_ := __PP11314228.Bus_Input_Rep1_Zip_Echo_Value_;
    SELF.B___Rep1_Inp_Phone_ := __PP11314228.Bus_Input_Rep1_Phone_Echo_Value_;
    SELF.B___Rep1_Inp_S_S_N_ := __PP11314228.Bus_Input_Rep1_S_S_N_Echo_Value_;
    SELF.B___Rep1_Inp_D_O_B_ := __PP11314228.Bus_Input_Rep1_D_O_B_Echo_Value_;
    SELF.B___Rep1_Inp_Email_ := __PP11314228.Bus_Input_Rep1_Email_Echo_Value_;
    SELF.B___Rep1_Inp_D_L_ := __PP11314228.Bus_Input_Rep1_D_L_Echo_Value_;
    SELF.B___Rep1_Inp_D_L_State_ := __PP11314228.Bus_Input_Rep1_D_L_State_Echo_Value_;
    SELF.B___Rep2_Inp_Lex_I_D_ := __PP11314228.Bus_Input_Rep2_Lex_I_D_Echo_Value_;
    SELF.B___Rep2_Inp_Name_First_ := __PP11314228.Bus_Input_Rep2_First_Name_Echo_Value_;
    SELF.B___Rep2_Inp_Name_Mid_ := __PP11314228.Bus_Input_Rep2_Middle_Name_Echo_Value_;
    SELF.B___Rep2_Inp_Name_Last_ := __PP11314228.Bus_Input_Rep2_Last_Name_Echo_Value_;
    SELF.B___Rep2_Inp_Addr_Line1_ := __PP11314228.Bus_Input_Rep2_Street_Echo_Value_;
    SELF.B___Rep2_Inp_Addr_Line2_ := __PP11314228.B___Rep2_Inp_Addr_Line2_Value_;
    SELF.B___Rep2_Inp_Addr_City_ := __PP11314228.Bus_Input_Rep2_City_Echo_Value_;
    SELF.B___Rep2_Inp_Addr_State_ := __PP11314228.Bus_Input_Rep2_State_Echo_Value_;
    SELF.B___Rep2_Inp_Addr_Zip_ := __PP11314228.Bus_Input_Rep2_Zip_Echo_Value_;
    SELF.B___Rep2_Inp_Phone_ := __PP11314228.Bus_Input_Rep2_Phone_Echo_Value_;
    SELF.B___Rep2_Inp_S_S_N_ := __PP11314228.Bus_Input_Rep2_S_S_N_Echo_Value_;
    SELF.B___Rep2_Inp_D_O_B_ := __PP11314228.Bus_Input_Rep2_D_O_B_Echo_Value_;
    SELF.B___Rep2_Inp_Email_ := __PP11314228.Bus_Input_Rep2_Email_Echo_Value_;
    SELF.B___Rep2_Inp_D_L_ := __PP11314228.Bus_Input_Rep2_D_L_Echo_Value_;
    SELF.B___Rep2_Inp_D_L_State_ := __PP11314228.Bus_Input_Rep2_D_L_State_Echo_Value_;
    SELF.B___Rep3_Inp_Lex_I_D_ := __PP11314228.Bus_Input_Rep3_Lex_I_D_Echo_Value_;
    SELF.B___Rep3_Inp_Name_First_ := __PP11314228.Bus_Input_Rep3_First_Name_Echo_Value_;
    SELF.B___Rep3_Inp_Name_Mid_ := __PP11314228.Bus_Input_Rep3_Middle_Name_Echo_Value_;
    SELF.B___Rep3_Inp_Name_Last_ := __PP11314228.Bus_Input_Rep3_Last_Name_Echo_Value_;
    SELF.B___Rep3_Inp_Addr_Line1_ := __PP11314228.Bus_Input_Rep3_Street_Echo_Value_;
    SELF.B___Rep3_Inp_Addr_Line2_ := __PP11314228.B___Rep3_Inp_Addr_Line2_Value_;
    SELF.B___Rep3_Inp_Addr_City_ := __PP11314228.Bus_Input_Rep3_City_Echo_Value_;
    SELF.B___Rep3_Inp_Addr_State_ := __PP11314228.Bus_Input_Rep3_State_Echo_Value_;
    SELF.B___Rep3_Inp_Addr_Zip_ := __PP11314228.Bus_Input_Rep3_Zip_Echo_Value_;
    SELF.B___Rep3_Inp_Phone_ := __PP11314228.Bus_Input_Rep3_Phone_Echo_Value_;
    SELF.B___Rep3_Inp_S_S_N_ := __PP11314228.Bus_Input_Rep3_S_S_N_Echo_Value_;
    SELF.B___Rep3_Inp_D_O_B_ := __PP11314228.Bus_Input_Rep3_D_O_B_Echo_Value_;
    SELF.B___Rep3_Inp_Email_ := __PP11314228.Bus_Input_Rep3_Email_Echo_Value_;
    SELF.B___Rep3_Inp_D_L_ := __PP11314228.Bus_Input_Rep3_D_L_Echo_Value_;
    SELF.B___Rep3_Inp_D_L_State_ := __PP11314228.Bus_Input_Rep3_D_L_State_Echo_Value_;
    SELF.B___Rep4_Inp_Lex_I_D_ := __PP11314228.Bus_Input_Rep4_Lex_I_D_Echo_Value_;
    SELF.B___Rep4_Inp_Name_First_ := __PP11314228.Bus_Input_Rep4_First_Name_Echo_Value_;
    SELF.B___Rep4_Inp_Name_Mid_ := __PP11314228.Bus_Input_Rep4_Middle_Name_Echo_Value_;
    SELF.B___Rep4_Inp_Name_Last_ := __PP11314228.Bus_Input_Rep4_Last_Name_Echo_Value_;
    SELF.B___Rep4_Inp_Addr_Line1_ := __PP11314228.Bus_Input_Rep4_Street_Echo_Value_;
    SELF.B___Rep4_Inp_Addr_Line2_ := __PP11314228.B___Rep4_Inp_Addr_Line2_Value_;
    SELF.B___Rep4_Inp_Addr_City_ := __PP11314228.Bus_Input_Rep4_City_Echo_Value_;
    SELF.B___Rep4_Inp_Addr_State_ := __PP11314228.Bus_Input_Rep4_State_Echo_Value_;
    SELF.B___Rep4_Inp_Addr_Zip_ := __PP11314228.Bus_Input_Rep4_Zip_Echo_Value_;
    SELF.B___Rep4_Inp_Phone_ := __PP11314228.Bus_Input_Rep4_Phone_Echo_Value_;
    SELF.B___Rep4_Inp_S_S_N_ := __PP11314228.Bus_Input_Rep4_S_S_N_Echo_Value_;
    SELF.B___Rep4_Inp_D_O_B_ := __PP11314228.Bus_Input_Rep4_D_O_B_Echo_Value_;
    SELF.B___Rep4_Inp_Email_ := __PP11314228.Bus_Input_Rep4_Email_Echo_Value_;
    SELF.B___Rep4_Inp_D_L_ := __PP11314228.Bus_Input_Rep4_D_L_Echo_Value_;
    SELF.B___Rep4_Inp_D_L_State_ := __PP11314228.Bus_Input_Rep4_D_L_State_Echo_Value_;
    SELF.B___Rep5_Inp_Lex_I_D_ := __PP11314228.Bus_Input_Rep5_Lex_I_D_Echo_Value_;
    SELF.B___Rep5_Inp_Name_First_ := __PP11314228.Bus_Input_Rep5_First_Name_Echo_Value_;
    SELF.B___Rep5_Inp_Name_Mid_ := __PP11314228.Bus_Input_Rep5_Middle_Name_Echo_Value_;
    SELF.B___Rep5_Inp_Name_Last_ := __PP11314228.Bus_Input_Rep5_Last_Name_Echo_Value_;
    SELF.B___Rep5_Inp_Addr_Line1_ := __PP11314228.Bus_Input_Rep5_Street_Echo_Value_;
    SELF.B___Rep5_Inp_Addr_Line2_ := __PP11314228.B___Rep5_Inp_Addr_Line2_Value_;
    SELF.B___Rep5_Inp_Addr_City_ := __PP11314228.Bus_Input_Rep5_City_Echo_Value_;
    SELF.B___Rep5_Inp_Addr_State_ := __PP11314228.Bus_Input_Rep5_State_Echo_Value_;
    SELF.B___Rep5_Inp_Addr_Zip_ := __PP11314228.Bus_Input_Rep5_Zip_Echo_Value_;
    SELF.B___Rep5_Inp_Phone_ := __PP11314228.Bus_Input_Rep5_Phone_Echo_Value_;
    SELF.B___Rep5_Inp_S_S_N_ := __PP11314228.Bus_Input_Rep5_S_S_N_Echo_Value_;
    SELF.B___Rep5_Inp_D_O_B_ := __PP11314228.Bus_Input_Rep5_D_O_B_Echo_Value_;
    SELF.B___Rep5_Inp_Email_ := __PP11314228.Bus_Input_Rep5_Email_Echo_Value_;
    SELF.B___Rep5_Inp_D_L_ := __PP11314228.Bus_Input_Rep5_D_L_Echo_Value_;
    SELF.B___Rep5_Inp_D_L_State_ := __PP11314228.Bus_Input_Rep5_D_L_State_Echo_Value_;
    SELF.B___Lex_I_D_Ult_ := __PP11314228.B___Lex_I_D_Ult_Value_;
    SELF.B___Lex_I_D_Org_ := __PP11314228.B___Lex_I_D_Org_Value_;
    SELF.B___Lex_I_D_Legal_ := __PP11314228.B___Lex_I_D_Legal_Value_;
    SELF.B___Lex_I_D_Site_ := __PP11314228.B___Lex_I_D_Site_Value_;
    SELF.B___Lex_I_D_Loc_ := __PP11314228.B___Lex_I_D_Loc_Value_;
    SELF.B___Lex_I_D_Legal_Score_ := __PP11314228.B___Lex_I_D_Legal_Score_Value_;
    SELF.B___Lex_I_D_Legal_Wgt_ := __PP11314228.B___Lex_I_D_Legal_Wgt_Value_;
    SELF.B___Inp_Cln_Arch_Dt_ := __PP11314228.Bus_Input_Archive_Date_Clean_Value_;
    SELF.B___Inp_Cln_Name_ := __PP11314228.Bus_Input_Name_Clean_Value_;
    SELF.B___Inp_Cln_Alt_Name_ := __PP11314228.Bus_Input_Alternate_Name_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Prim_Rng_ := __PP11314228.Bus_Input_Prim_Range_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Pre_Dir_ := __PP11314228.Bus_Input_Pre_Dir_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Prim_Name_ := __PP11314228.Bus_Input_Prim_Name_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Sffx_ := __PP11314228.Bus_Input_Addr_Suffix_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Post_Dir_ := __PP11314228.Bus_Input_Post_Dir_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Unit_Desig_ := __PP11314228.Bus_Input_Unit_Desig_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Sec_Rng_ := __PP11314228.Bus_Input_Sec_Range_Clean_Value_;
    SELF.B___Inp_Cln_Addr_City_ := __PP11314228.Bus_Input_City_Clean_Value_;
    SELF.B___Inp_Cln_Addr_City_Post_ := __PP11314228.Bus_Input_City_Post_Clean_Value_;
    SELF.B___Inp_Cln_Addr_State_ := __PP11314228.Bus_Input_State_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Zip5_ := __PP11314228.Bus_Input_Zip5_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Zip4_ := __PP11314228.Bus_Input_Zip4_Clean_Value_;
    SELF.B___Inp_Cln_Addr_St_ := __PP11314228.Bus_Input_Street_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Full_ := __PP11314228.Bus_Input_Full_Address_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Lat_ := __PP11314228.Bus_Input_Latitude_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Lng_ := __PP11314228.Bus_Input_Longitude_Clean_Value_;
    SELF.B___Inp_Cln_Addr_State_Code_ := __PP11314228.Bus_Input_State_Code_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Cnty_ := __PP11314228.Bus_Input_County_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Geo_ := __PP11314228.Bus_Input_Geoblock_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Type_ := __PP11314228.Bus_Input_Addr_Type_Clean_Value_;
    SELF.B___Inp_Cln_Addr_Status_ := __PP11314228.Bus_Input_Addr_Status_Clean_Value_;
    SELF.B___Inp_Cln_Phone_ := __PP11314228.Bus_Input_Phone_Clean_Value_;
    SELF.B___Inp_Cln_T_I_N_ := __PP11314228.Bus_Input_T_I_N_Clean_Value_;
    SELF.B___Inp_Cln_I_P_Addr_ := __PP11314228.Bus_Input_I_P_Clean_Value_;
    SELF.B___Inp_Cln_Email_ := __PP11314228.Bus_Input_Email_Clean_Value_;
    SELF.B___Inp_Arch_Dt_Flag_ := __PP11314228.B___Inp_Arch_Dt_Flag_Value_;
    SELF.B___Inp_Name_Flag_ := __PP11314228.B___Inp_Name_Flag_Value_;
    SELF.B___Inp_Alt_Name_Flag_ := __PP11314228.B___Inp_Alt_Name_Flag_Value_;
    SELF.B___Inp_Addr_St_Flag_ := __PP11314228.B___Inp_Addr_St_Flag_Value_;
    SELF.B___Inp_Addr_City_Flag_ := __PP11314228.B___Inp_Addr_City_Flag_Value_;
    SELF.B___Inp_Addr_State_Flag_ := __PP11314228.B___Inp_Addr_State_Flag_Value_;
    SELF.B___Inp_Addr_Zip_Flag_ := __PP11314228.B___Inp_Addr_Zip_Flag_Value_;
    SELF.B___Inp_Phone_Flag_ := __PP11314228.B___Inp_Phone_Flag_Value_;
    SELF.B___Inp_I_P_Addr_Flag_ := __PP11314228.B___Inp_I_P_Addr_Flag_Value_;
    SELF.B___Inp_T_I_N_Flag_ := __PP11314228.B___Inp_T_I_N_Flag_Value_;
    SELF.B___Inp_S_I_C_Code_Flag_ := __PP11314228.B___Inp_S_I_C_Code_Flag_Value_;
    SELF.B___Inp_N_A_I_C_S_Code_Flag_ := __PP11314228.B___Inp_N_A_I_C_S_Code_Flag_Value_;
    SELF.B___Rep1_Inp_Lex_I_D_Flag_ := __PP11314228.B___Rep1_Inp_Lex_I_D_Flag_Value_;
    SELF.B___Rep1_Inp_Name_First_Flag_ := __PP11314228.B___Rep1_Inp_Name_First_Flag_Value_;
    SELF.B___Rep1_Inp_Name_Mid_Flag_ := __PP11314228.B___Rep1_Inp_Name_Mid_Flag_Value_;
    SELF.B___Rep1_Inp_Name_Last_Flag_ := __PP11314228.B___Rep1_Inp_Name_Last_Flag_Value_;
    SELF.B___Rep1_Inp_Addr_St_Flag_ := __PP11314228.B___Rep1_Inp_Addr_St_Flag_Value_;
    SELF.B___Rep1_Inp_Addr_City_Flag_ := __PP11314228.B___Rep1_Inp_Addr_City_Flag_Value_;
    SELF.B___Rep1_Inp_Addr_State_Flag_ := __PP11314228.B___Rep1_Inp_Addr_State_Flag_Value_;
    SELF.B___Rep1_Inp_Addr_Zip_Flag_ := __PP11314228.B___Rep1_Inp_Addr_Zip_Flag_Value_;
    SELF.B___Rep1_Inp_Phone_Flag_ := __PP11314228.B___Rep1_Inp_Phone_Flag_Value_;
    SELF.B___Rep1_Inp_S_S_N_Flag_ := __PP11314228.B___Rep1_Inp_S_S_N_Flag_Value_;
    SELF.B___Rep1_Inp_D_O_B_Flag_ := __PP11314228.B___Rep1_Inp_D_O_B_Flag_Value_;
    SELF.B___Rep1_Inp_Email_Flag_ := __PP11314228.B___Rep1_Inp_Email_Flag_Value_;
    SELF.B___Rep1_Inp_D_L_Flag_ := __PP11314228.B___Rep1_Inp_D_L_Flag_Value_;
    SELF.B___Rep1_Inp_D_L_State_Flag_ := __PP11314228.B___Rep1_Inp_D_L_State_Flag_Value_;
    SELF.B___Rep2_Inp_Lex_I_D_Flag_ := __PP11314228.B___Rep2_Inp_Lex_I_D_Flag_Value_;
    SELF.B___Rep2_Inp_Name_First_Flag_ := __PP11314228.B___Rep2_Inp_Name_First_Flag_Value_;
    SELF.B___Rep2_Inp_Name_Mid_Flag_ := __PP11314228.B___Rep2_Inp_Name_Mid_Flag_Value_;
    SELF.B___Rep2_Inp_Name_Last_Flag_ := __PP11314228.B___Rep2_Inp_Name_Last_Flag_Value_;
    SELF.B___Rep2_Inp_Addr_St_Flag_ := __PP11314228.B___Rep2_Inp_Addr_St_Flag_Value_;
    SELF.B___Rep2_Inp_Addr_City_Flag_ := __PP11314228.B___Rep2_Inp_Addr_City_Flag_Value_;
    SELF.B___Rep2_Inp_Addr_State_Flag_ := __PP11314228.B___Rep2_Inp_Addr_State_Flag_Value_;
    SELF.B___Rep2_Inp_Addr_Zip_Flag_ := __PP11314228.B___Rep2_Inp_Addr_Zip_Flag_Value_;
    SELF.B___Rep2_Inp_Phone_Flag_ := __PP11314228.B___Rep2_Inp_Phone_Flag_Value_;
    SELF.B___Rep2_Inp_S_S_N_Flag_ := __PP11314228.B___Rep2_Inp_S_S_N_Flag_Value_;
    SELF.B___Rep2_Inp_D_O_B_Flag_ := __PP11314228.B___Rep2_Inp_D_O_B_Flag_Value_;
    SELF.B___Rep2_Inp_Email_Flag_ := __PP11314228.B___Rep2_Inp_Email_Flag_Value_;
    SELF.B___Rep2_Inp_D_L_Flag_ := __PP11314228.B___Rep2_Inp_D_L_Flag_Value_;
    SELF.B___Rep2_Inp_D_L_State_Flag_ := __PP11314228.B___Rep2_Inp_D_L_State_Flag_Value_;
    SELF.B___Rep3_Inp_Lex_I_D_Flag_ := __PP11314228.B___Rep3_Inp_Lex_I_D_Flag_Value_;
    SELF.B___Rep3_Inp_Name_First_Flag_ := __PP11314228.B___Rep3_Inp_Name_First_Flag_Value_;
    SELF.B___Rep3_Inp_Name_Mid_Flag_ := __PP11314228.B___Rep3_Inp_Name_Mid_Flag_Value_;
    SELF.B___Rep3_Inp_Name_Last_Flag_ := __PP11314228.B___Rep3_Inp_Name_Last_Flag_Value_;
    SELF.B___Rep3_Inp_Addr_St_Flag_ := __PP11314228.B___Rep3_Inp_Addr_St_Flag_Value_;
    SELF.B___Rep3_Inp_Addr_City_Flag_ := __PP11314228.B___Rep3_Inp_Addr_City_Flag_Value_;
    SELF.B___Rep3_Inp_Addr_State_Flag_ := __PP11314228.B___Rep3_Inp_Addr_State_Flag_Value_;
    SELF.B___Rep3_Inp_Addr_Zip_Flag_ := __PP11314228.B___Rep3_Inp_Addr_Zip_Flag_Value_;
    SELF.B___Rep3_Inp_Phone_Flag_ := __PP11314228.B___Rep3_Inp_Phone_Flag_Value_;
    SELF.B___Rep3_Inp_S_S_N_Flag_ := __PP11314228.B___Rep3_Inp_S_S_N_Flag_Value_;
    SELF.B___Rep3_Inp_D_O_B_Flag_ := __PP11314228.B___Rep3_Inp_D_O_B_Flag_Value_;
    SELF.B___Rep3_Inp_Email_Flag_ := __PP11314228.B___Rep3_Inp_Email_Flag_Value_;
    SELF.B___Rep3_Inp_D_L_Flag_ := __PP11314228.B___Rep3_Inp_D_L_Flag_Value_;
    SELF.B___Rep3_Inp_D_L_State_Flag_ := __PP11314228.B___Rep3_Inp_D_L_State_Flag_Value_;
    SELF.B___Rep4_Inp_Lex_I_D_Flag_ := __PP11314228.B___Rep4_Inp_Lex_I_D_Flag_Value_;
    SELF.B___Rep4_Inp_Name_First_Flag_ := __PP11314228.B___Rep4_Inp_Name_First_Flag_Value_;
    SELF.B___Rep4_Inp_Name_Mid_Flag_ := __PP11314228.B___Rep4_Inp_Name_Mid_Flag_Value_;
    SELF.B___Rep4_Inp_Name_Last_Flag_ := __PP11314228.B___Rep4_Inp_Name_Last_Flag_Value_;
    SELF.B___Rep4_Inp_Addr_St_Flag_ := __PP11314228.B___Rep4_Inp_Addr_St_Flag_Value_;
    SELF.B___Rep4_Inp_Addr_City_Flag_ := __PP11314228.B___Rep4_Inp_Addr_City_Flag_Value_;
    SELF.B___Rep4_Inp_Addr_State_Flag_ := __PP11314228.B___Rep4_Inp_Addr_State_Flag_Value_;
    SELF.B___Rep4_Inp_Addr_Zip_Flag_ := __PP11314228.B___Rep4_Inp_Addr_Zip_Flag_Value_;
    SELF.B___Rep4_Inp_Phone_Flag_ := __PP11314228.B___Rep4_Inp_Phone_Flag_Value_;
    SELF.B___Rep4_Inp_S_S_N_Flag_ := __PP11314228.B___Rep4_Inp_S_S_N_Flag_Value_;
    SELF.B___Rep4_Inp_D_O_B_Flag_ := __PP11314228.B___Rep4_Inp_D_O_B_Flag_Value_;
    SELF.B___Rep4_Inp_Email_Flag_ := __PP11314228.B___Rep4_Inp_Email_Flag_Value_;
    SELF.B___Rep4_Inp_D_L_Flag_ := __PP11314228.B___Rep4_Inp_D_L_Flag_Value_;
    SELF.B___Rep4_Inp_D_L_State_Flag_ := __PP11314228.B___Rep4_Inp_D_L_State_Flag_Value_;
    SELF.B___Rep5_Inp_Lex_I_D_Flag_ := __PP11314228.B___Rep5_Inp_Lex_I_D_Flag_Value_;
    SELF.B___Rep5_Inp_Name_First_Flag_ := __PP11314228.B___Rep5_Inp_Name_First_Flag_Value_;
    SELF.B___Rep5_Inp_Name_Mid_Flag_ := __PP11314228.B___Rep5_Inp_Name_Mid_Flag_Value_;
    SELF.B___Rep5_Inp_Name_Last_Flag_ := __PP11314228.B___Rep5_Inp_Name_Last_Flag_Value_;
    SELF.B___Rep5_Inp_Addr_St_Flag_ := __PP11314228.B___Rep5_Inp_Addr_St_Flag_Value_;
    SELF.B___Rep5_Inp_Addr_City_Flag_ := __PP11314228.B___Rep5_Inp_Addr_City_Flag_Value_;
    SELF.B___Rep5_Inp_Addr_State_Flag_ := __PP11314228.B___Rep5_Inp_Addr_State_Flag_Value_;
    SELF.B___Rep5_Inp_Addr_Zip_Flag_ := __PP11314228.B___Rep5_Inp_Addr_Zip_Flag_Value_;
    SELF.B___Rep5_Inp_Phone_Flag_ := __PP11314228.B___Rep5_Inp_Phone_Flag_Value_;
    SELF.B___Rep5_Inp_S_S_N_Flag_ := __PP11314228.B___Rep5_Inp_S_S_N_Flag_Value_;
    SELF.B___Rep5_Inp_D_O_B_Flag_ := __PP11314228.B___Rep5_Inp_D_O_B_Flag_Value_;
    SELF.B___Rep5_Inp_Email_Flag_ := __PP11314228.B___Rep5_Inp_Email_Flag_Value_;
    SELF.B___Rep5_Inp_D_L_Flag_ := __PP11314228.B___Rep5_Inp_D_L_Flag_Value_;
    SELF.B___Rep5_Inp_D_L_State_Flag_ := __PP11314228.B___Rep5_Inp_D_L_State_Flag_Value_;
    SELF.B___Inp_Cln_Name_Flag_ := __PP11314228.B___Inp_Cln_Name_Flag_Value_;
    SELF.B___Inp_Cln_Alt_Name_Flag_ := __PP11314228.B___Inp_Cln_Alt_Name_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11314228.B___Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11314228.B___Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Prim_Name_Flag_ := __PP11314228.B___Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Sffx_Flag_ := __PP11314228.B___Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Post_Dir_Flag_ := __PP11314228.B___Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11314228.B___Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11314228.B___Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.B___Inp_Cln_Addr_City_Flag_ := __PP11314228.B___Inp_Cln_Addr_City_Flag_Value_;
    SELF.B___Inp_Cln_Addr_City_Post_Flag_ := __PP11314228.B___Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.B___Inp_Cln_Addr_State_Flag_ := __PP11314228.B___Inp_Cln_Addr_State_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Zip5_Flag_ := __PP11314228.B___Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Zip4_Flag_ := __PP11314228.B___Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.B___Inp_Cln_Addr_St_Flag_ := __PP11314228.B___Inp_Cln_Addr_St_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Full_Flag_ := __PP11314228.B___Inp_Cln_Addr_Full_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Lat_Flag_ := __PP11314228.B___Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Lng_Flag_ := __PP11314228.B___Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Cnty_Flag_ := __PP11314228.B___Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Geo_Flag_ := __PP11314228.B___Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Type_Flag_ := __PP11314228.B___Inp_Cln_Addr_Type_Flag_Value_;
    SELF.B___Inp_Cln_Addr_Status_Flag_ := __PP11314228.B___Inp_Cln_Addr_Status_Flag_Value_;
    SELF.B___Inp_Cln_Phone_Flag_ := __PP11314228.B___Inp_Cln_Phone_Flag_Value_;
    SELF.B___Inp_Cln_T_I_N_Flag_ := __PP11314228.B___Inp_Cln_T_I_N_Flag_Value_;
    SELF.B___Inp_Cln_I_P_Addr_Flag_ := __PP11314228.B___Inp_Cln_I_P_Addr_Flag_Value_;
    SELF.B___Inp_Cln_Email_Flag_ := __PP11314228.B___Inp_Cln_Email_Flag_Value_;
    SELF.B___Inp_Cln_Arch_Dt_Flag_ := __PP11314228.B___Inp_Cln_Arch_Dt_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Name_Prfx_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Name_First_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Name_First_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Name_Mid_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Name_Mid_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Name_Last_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Name_Last_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Name_Sffx_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Prim_Name_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Sffx_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Post_Dir_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_City_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_City_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_City_Post_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_State_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_State_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Zip5_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Zip4_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_St_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_St_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Full_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Full_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Lat_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Lng_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Cnty_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Geo_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Type_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Type_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Addr_Status_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Addr_Status_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Phone_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Phone_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_S_S_N_Flag_ := __PP11314228.B___Rep1_Inp_Cln_S_S_N_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_D_O_B_Flag_ := __PP11314228.B___Rep1_Inp_Cln_D_O_B_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_Email_Flag_ := __PP11314228.B___Rep1_Inp_Cln_Email_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_D_L_Flag_ := __PP11314228.B___Rep1_Inp_Cln_D_L_Flag_Value_;
    SELF.B___Rep1_Inp_Cln_D_L_State_Flag_ := __PP11314228.B___Rep1_Inp_Cln_D_L_State_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Name_Prfx_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Name_First_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Name_First_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Name_Mid_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Name_Mid_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Name_Last_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Name_Last_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Name_Sffx_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Prim_Name_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Sffx_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Post_Dir_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_City_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_City_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_City_Post_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_State_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_State_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Zip5_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Zip4_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_St_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_St_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Full_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Full_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Lat_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Lng_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Cnty_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Geo_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Type_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Type_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Addr_Status_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Addr_Status_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Phone_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Phone_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_S_S_N_Flag_ := __PP11314228.B___Rep2_Inp_Cln_S_S_N_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_D_O_B_Flag_ := __PP11314228.B___Rep2_Inp_Cln_D_O_B_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_Email_Flag_ := __PP11314228.B___Rep2_Inp_Cln_Email_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_D_L_Flag_ := __PP11314228.B___Rep2_Inp_Cln_D_L_Flag_Value_;
    SELF.B___Rep2_Inp_Cln_D_L_State_Flag_ := __PP11314228.B___Rep2_Inp_Cln_D_L_State_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Name_Prfx_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Name_First_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Name_First_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Name_Mid_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Name_Mid_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Name_Last_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Name_Last_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Name_Sffx_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Prim_Name_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Sffx_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Post_Dir_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_City_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_City_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_City_Post_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_State_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_State_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Zip5_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Zip4_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_St_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_St_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Full_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Full_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Lat_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Lng_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Cnty_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Geo_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Type_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Type_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Addr_Status_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Addr_Status_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Phone_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Phone_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_S_S_N_Flag_ := __PP11314228.B___Rep3_Inp_Cln_S_S_N_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_D_O_B_Flag_ := __PP11314228.B___Rep3_Inp_Cln_D_O_B_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_Email_Flag_ := __PP11314228.B___Rep3_Inp_Cln_Email_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_D_L_Flag_ := __PP11314228.B___Rep3_Inp_Cln_D_L_Flag_Value_;
    SELF.B___Rep3_Inp_Cln_D_L_State_Flag_ := __PP11314228.B___Rep3_Inp_Cln_D_L_State_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Name_Prfx_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Name_First_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Name_First_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Name_Mid_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Name_Mid_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Name_Last_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Name_Last_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Name_Sffx_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Prim_Name_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Sffx_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Post_Dir_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_City_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_City_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_City_Post_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_State_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_State_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Zip5_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Zip4_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_St_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_St_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Full_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Full_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Lat_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Lng_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Cnty_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Geo_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Type_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Type_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Addr_Status_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Addr_Status_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Phone_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Phone_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_S_S_N_Flag_ := __PP11314228.B___Rep4_Inp_Cln_S_S_N_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_D_O_B_Flag_ := __PP11314228.B___Rep4_Inp_Cln_D_O_B_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_Email_Flag_ := __PP11314228.B___Rep4_Inp_Cln_Email_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_D_L_Flag_ := __PP11314228.B___Rep4_Inp_Cln_D_L_Flag_Value_;
    SELF.B___Rep4_Inp_Cln_D_L_State_Flag_ := __PP11314228.B___Rep4_Inp_Cln_D_L_State_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Name_Prfx_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Name_First_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Name_First_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Name_Mid_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Name_Mid_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Name_Last_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Name_Last_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Name_Sffx_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Prim_Name_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Sffx_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Post_Dir_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_City_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_City_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_City_Post_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_State_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_State_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Zip5_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Zip4_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_St_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_St_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Full_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Full_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Lat_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Lng_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Cnty_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Geo_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Type_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Type_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Addr_Status_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Addr_Status_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Phone_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Phone_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_S_S_N_Flag_ := __PP11314228.B___Rep5_Inp_Cln_S_S_N_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_D_O_B_Flag_ := __PP11314228.B___Rep5_Inp_Cln_D_O_B_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_Email_Flag_ := __PP11314228.B___Rep5_Inp_Cln_Email_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_D_L_Flag_ := __PP11314228.B___Rep5_Inp_Cln_D_L_Flag_Value_;
    SELF.B___Rep5_Inp_Cln_D_L_State_Flag_ := __PP11314228.B___Rep5_Inp_Cln_D_L_State_Flag_Value_;
    SELF := __PP11314228;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE11314227,__ND11314232__Project(LEFT)));
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
  EXPORT DBG_E_Aircraft_Owner_Result := __UNWRAP(E_Aircraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Bankruptcy_Result := __UNWRAP(E_Bankruptcy_Filtered.__Result);
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
  EXPORT DBG_E_Phone_Result := __UNWRAP(E_Phone_Filtered.__Result);
  EXPORT DBG_E_Phone_Inquiry_Result := __UNWRAP(E_Phone_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Result := __UNWRAP(E_Professional_License_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Person_Result := __UNWRAP(E_Professional_License_Person_Filtered.__Result);
  EXPORT DBG_E_Property_Result := __UNWRAP(E_Property_Filtered.__Result);
  EXPORT DBG_E_Property_Event_Result := __UNWRAP(E_Property_Event_Filtered.__Result);
  EXPORT DBG_E_S_S_N_Inquiry_Result := __UNWRAP(E_S_S_N_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Sele_Person_Result := __UNWRAP(E_Sele_Person_Filtered.__Result);
  EXPORT DBG_E_Social_Security_Number_Result := __UNWRAP(E_Social_Security_Number_Filtered.__Result);
  EXPORT DBG_E_Utility_Person_Result := __UNWRAP(E_Utility_Person_Filtered.__Result);
  EXPORT DBG_E_Watercraft_Owner_Result := __UNWRAP(E_Watercraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Zip_Code_Result := __UNWRAP(E_Zip_Code_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Intermediate_13 := __UNWRAP(B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13);
  EXPORT DBG_E_Person_Lien_Judgment_Intermediate_12 := __UNWRAP(B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12);
  EXPORT DBG_E_Inquiry_Intermediate_11 := __UNWRAP(B_Inquiry_11_Local.__ENH_Inquiry_11);
  EXPORT DBG_E_Person_Intermediate_11 := __UNWRAP(B_Person_11_Local.__ENH_Person_11);
  EXPORT DBG_E_Input_B_I_I_Intermediate_10 := __UNWRAP(B_Input_B_I_I_10_Local.__ENH_Input_B_I_I_10);
  EXPORT DBG_E_Input_P_I_I_Intermediate_10 := __UNWRAP(B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10);
  EXPORT DBG_E_Inquiry_Intermediate_10 := __UNWRAP(B_Inquiry_10_Local.__ENH_Inquiry_10);
  EXPORT DBG_E_Person_Intermediate_10 := __UNWRAP(B_Person_10_Local.__ENH_Person_10);
  EXPORT DBG_E_Input_B_I_I_Intermediate_9 := __UNWRAP(B_Input_B_I_I_9_Local.__ENH_Input_B_I_I_9);
  EXPORT DBG_E_Input_P_I_I_Intermediate_9 := __UNWRAP(B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9);
  EXPORT DBG_E_Inquiry_Intermediate_9 := __UNWRAP(B_Inquiry_9_Local.__ENH_Inquiry_9);
  EXPORT DBG_E_Person_Intermediate_9 := __UNWRAP(B_Person_9_Local.__ENH_Person_9);
  EXPORT DBG_E_Bankruptcy_Intermediate_8 := __UNWRAP(B_Bankruptcy_8_Local.__ENH_Bankruptcy_8);
  EXPORT DBG_E_Input_B_I_I_Intermediate_8 := __UNWRAP(B_Input_B_I_I_8_Local.__ENH_Input_B_I_I_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Inquiry_Intermediate_8 := __UNWRAP(B_Inquiry_8_Local.__ENH_Inquiry_8);
  EXPORT DBG_E_Person_Intermediate_8 := __UNWRAP(B_Person_8_Local.__ENH_Person_8);
  EXPORT DBG_E_Person_Accident_Intermediate_8 := __UNWRAP(B_Person_Accident_8_Local.__ENH_Person_Accident_8);
  EXPORT DBG_E_Person_Inquiry_Intermediate_8 := __UNWRAP(B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8);
  EXPORT DBG_E_Person_Property_Intermediate_8 := __UNWRAP(B_Person_Property_8_Local.__ENH_Person_Property_8);
  EXPORT DBG_E_Property_Event_Intermediate_8 := __UNWRAP(B_Property_Event_8_Local.__ENH_Property_Event_8);
  EXPORT DBG_E_Bankruptcy_Intermediate_7 := __UNWRAP(B_Bankruptcy_7_Local.__ENH_Bankruptcy_7);
  EXPORT DBG_E_Education_Intermediate_7 := __UNWRAP(B_Education_7_Local.__ENH_Education_7);
  EXPORT DBG_E_Input_B_I_I_Intermediate_7 := __UNWRAP(B_Input_B_I_I_7_Local.__ENH_Input_B_I_I_7);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Inquiry_Intermediate_7 := __UNWRAP(B_Inquiry_7_Local.__ENH_Inquiry_7);
  EXPORT DBG_E_Person_Intermediate_7 := __UNWRAP(B_Person_7_Local.__ENH_Person_7);
  EXPORT DBG_E_Person_Inquiry_Intermediate_7 := __UNWRAP(B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7);
  EXPORT DBG_E_Person_Property_Intermediate_7 := __UNWRAP(B_Person_Property_7_Local.__ENH_Person_Property_7);
  EXPORT DBG_E_Property_Event_Intermediate_7 := __UNWRAP(B_Property_Event_7_Local.__ENH_Property_Event_7);
  EXPORT DBG_E_Sele_Person_Intermediate_7 := __UNWRAP(B_Sele_Person_7_Local.__ENH_Sele_Person_7);
  EXPORT DBG_E_Address_Intermediate_6 := __UNWRAP(B_Address_6_Local.__ENH_Address_6);
  EXPORT DBG_E_Bankruptcy_Intermediate_6 := __UNWRAP(B_Bankruptcy_6_Local.__ENH_Bankruptcy_6);
  EXPORT DBG_E_Education_Intermediate_6 := __UNWRAP(B_Education_6_Local.__ENH_Education_6);
  EXPORT DBG_E_Input_B_I_I_Intermediate_6 := __UNWRAP(B_Input_B_I_I_6_Local.__ENH_Input_B_I_I_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Inquiry_Intermediate_6 := __UNWRAP(B_Inquiry_6_Local.__ENH_Inquiry_6);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local.__ENH_Person_6);
  EXPORT DBG_E_Person_Inquiry_Intermediate_6 := __UNWRAP(B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6);
  EXPORT DBG_E_Person_Property_Intermediate_6 := __UNWRAP(B_Person_Property_6_Local.__ENH_Person_Property_6);
  EXPORT DBG_E_Property_Event_Intermediate_6 := __UNWRAP(B_Property_Event_6_Local.__ENH_Property_Event_6);
  EXPORT DBG_E_Sele_Person_Intermediate_6 := __UNWRAP(B_Sele_Person_6_Local.__ENH_Sele_Person_6);
  EXPORT DBG_E_Address_Intermediate_5 := __UNWRAP(B_Address_5_Local.__ENH_Address_5);
  EXPORT DBG_E_Bankruptcy_Intermediate_5 := __UNWRAP(B_Bankruptcy_5_Local.__ENH_Bankruptcy_5);
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
  EXPORT DBG_E_Sele_Person_Intermediate_5 := __UNWRAP(B_Sele_Person_5_Local.__ENH_Sele_Person_5);
  EXPORT DBG_E_Address_Intermediate_4 := __UNWRAP(B_Address_4_Local.__ENH_Address_4);
  EXPORT DBG_E_Bankruptcy_Intermediate_4 := __UNWRAP(B_Bankruptcy_4_Local.__ENH_Bankruptcy_4);
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
  EXPORT DBG_E_Sele_Person_Intermediate_4 := __UNWRAP(B_Sele_Person_4_Local.__ENH_Sele_Person_4);
  EXPORT DBG_E_Address_Intermediate_3 := __UNWRAP(B_Address_3_Local.__ENH_Address_3);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_3 := __UNWRAP(B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3);
  EXPORT DBG_E_Bankruptcy_Intermediate_3 := __UNWRAP(B_Bankruptcy_3_Local.__ENH_Bankruptcy_3);
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
  EXPORT DBG_E_Sele_Person_Intermediate_3 := __UNWRAP(B_Sele_Person_3_Local.__ENH_Sele_Person_3);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_3 := __UNWRAP(B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3);
  EXPORT DBG_E_Address_Intermediate_2 := __UNWRAP(B_Address_2_Local.__ENH_Address_2);
  EXPORT DBG_E_Input_B_I_I_Intermediate_2 := __UNWRAP(B_Input_B_I_I_2_Local.__ENH_Input_B_I_I_2);
  EXPORT DBG_E_Input_P_I_I_Intermediate_2 := __UNWRAP(B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local.__ENH_Person_2);
  EXPORT DBG_E_Input_B_I_I_Intermediate_1 := __UNWRAP(B_Input_B_I_I_1_Local.__ENH_Input_B_I_I_1);
  EXPORT DBG_E_Input_P_I_I_Intermediate_1 := __UNWRAP(B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1);
  EXPORT DBG_E_Input_B_I_I_Annotated := __UNWRAP(B_Input_B_I_I_Local.__ENH_Input_B_I_I);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Input_B_I_I_PreEntity,NAMED('DBG_E_Input_B_I_I_PreEntity_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Result,NAMED('DBG_E_Input_B_I_I_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_B_I_I_Input_P_I_I_PreEntity_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Input_P_I_I_Result,NAMED('DBG_E_Input_B_I_I_Input_P_I_I_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_P_I_I_PreEntity_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Accident_Result,NAMED('DBG_E_Accident_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Result,NAMED('DBG_E_Address_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Inquiry_Result,NAMED('DBG_E_Address_Inquiry_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Property_Result,NAMED('DBG_E_Address_Property_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Result,NAMED('DBG_E_Aircraft_Owner_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Result,NAMED('DBG_E_Bankruptcy_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Result,NAMED('DBG_E_Criminal_Offense_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Result,NAMED('DBG_E_Education_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Result,NAMED('DBG_E_Email_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Inquiry_Result,NAMED('DBG_E_Email_Inquiry_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_First_Degree_Associations_Result,NAMED('DBG_E_First_Degree_Associations_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_First_Degree_Relative_Result,NAMED('DBG_E_First_Degree_Relative_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Household_Result,NAMED('DBG_E_Household_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Household_Member_Result,NAMED('DBG_E_Household_Member_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Result,NAMED('DBG_E_Lien_Judgment_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Accident_Result,NAMED('DBG_E_Person_Accident_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Address_Result,NAMED('DBG_E_Person_Address_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Bankruptcy_Result,NAMED('DBG_E_Person_Bankruptcy_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Education_Result,NAMED('DBG_E_Person_Education_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Email_Result,NAMED('DBG_E_Person_Email_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Result,NAMED('DBG_E_Person_Inquiry_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Result,NAMED('DBG_E_Person_Lien_Judgment_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Offenses_Result,NAMED('DBG_E_Person_Offenses_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Result,NAMED('DBG_E_Person_Property_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Event_Result,NAMED('DBG_E_Person_Property_Event_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Result,NAMED('DBG_E_Person_S_S_N_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Vehicle_Result,NAMED('DBG_E_Person_Vehicle_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Phone_Result,NAMED('DBG_E_Phone_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Phone_Inquiry_Result,NAMED('DBG_E_Phone_Inquiry_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Result,NAMED('DBG_E_Professional_License_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Person_Result,NAMED('DBG_E_Professional_License_Person_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Result,NAMED('DBG_E_Property_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Result,NAMED('DBG_E_Property_Event_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Inquiry_Result,NAMED('DBG_E_S_S_N_Inquiry_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Result,NAMED('DBG_E_Sele_Person_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Social_Security_Number_Result,NAMED('DBG_E_Social_Security_Number_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Utility_Person_Result,NAMED('DBG_E_Utility_Person_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Result,NAMED('DBG_E_Watercraft_Owner_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Zip_Code_Result,NAMED('DBG_E_Zip_Code_Result_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_13,NAMED('DBG_E_Lien_Judgment_Intermediate_13_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Person_Lien_Judgment_Intermediate_12_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_11,NAMED('DBG_E_Inquiry_Intermediate_11_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_11,NAMED('DBG_E_Person_Intermediate_11_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_10,NAMED('DBG_E_Input_B_I_I_Intermediate_10_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_10,NAMED('DBG_E_Input_P_I_I_Intermediate_10_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_10,NAMED('DBG_E_Inquiry_Intermediate_10_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_10,NAMED('DBG_E_Person_Intermediate_10_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_9,NAMED('DBG_E_Input_B_I_I_Intermediate_9_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_9,NAMED('DBG_E_Input_P_I_I_Intermediate_9_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_9,NAMED('DBG_E_Inquiry_Intermediate_9_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_9,NAMED('DBG_E_Person_Intermediate_9_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_8,NAMED('DBG_E_Bankruptcy_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_8,NAMED('DBG_E_Input_B_I_I_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_8,NAMED('DBG_E_Inquiry_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_8,NAMED('DBG_E_Person_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Accident_Intermediate_8,NAMED('DBG_E_Person_Accident_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_8,NAMED('DBG_E_Person_Inquiry_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_8,NAMED('DBG_E_Person_Property_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_8,NAMED('DBG_E_Property_Event_Intermediate_8_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_7,NAMED('DBG_E_Bankruptcy_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_7,NAMED('DBG_E_Education_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_7,NAMED('DBG_E_Input_B_I_I_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_7,NAMED('DBG_E_Inquiry_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_7,NAMED('DBG_E_Person_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_7,NAMED('DBG_E_Person_Inquiry_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_7,NAMED('DBG_E_Person_Property_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_7,NAMED('DBG_E_Property_Event_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_7,NAMED('DBG_E_Sele_Person_Intermediate_7_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_6,NAMED('DBG_E_Address_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_6,NAMED('DBG_E_Bankruptcy_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_6,NAMED('DBG_E_Education_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_6,NAMED('DBG_E_Input_B_I_I_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_6,NAMED('DBG_E_Inquiry_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_6,NAMED('DBG_E_Person_Inquiry_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_6,NAMED('DBG_E_Person_Property_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_6,NAMED('DBG_E_Property_Event_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_6,NAMED('DBG_E_Sele_Person_Intermediate_6_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_5,NAMED('DBG_E_Address_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_5,NAMED('DBG_E_Bankruptcy_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_5,NAMED('DBG_E_Criminal_Offense_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_5,NAMED('DBG_E_Education_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_5,NAMED('DBG_E_First_Degree_Relative_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_5,NAMED('DBG_E_Input_B_I_I_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_5,NAMED('DBG_E_Inquiry_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_5,NAMED('DBG_E_Person_Inquiry_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_5,NAMED('DBG_E_Person_Property_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_5,NAMED('DBG_E_Professional_License_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Intermediate_5,NAMED('DBG_E_Property_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_5,NAMED('DBG_E_Sele_Person_Intermediate_5_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_4,NAMED('DBG_E_Address_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_4,NAMED('DBG_E_Bankruptcy_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_4,NAMED('DBG_E_Criminal_Offense_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_4,NAMED('DBG_E_Education_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_4,NAMED('DBG_E_Input_B_I_I_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_4,NAMED('DBG_E_Inquiry_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_4,NAMED('DBG_E_Person_Inquiry_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_4,NAMED('DBG_E_Person_Property_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_4,NAMED('DBG_E_Professional_License_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Intermediate_4,NAMED('DBG_E_Property_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_4,NAMED('DBG_E_Sele_Person_Intermediate_4_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_3,NAMED('DBG_E_Address_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_3,NAMED('DBG_E_Aircraft_Owner_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_3,NAMED('DBG_E_Bankruptcy_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_3,NAMED('DBG_E_Criminal_Offense_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_3,NAMED('DBG_E_Education_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_3,NAMED('DBG_E_Input_B_I_I_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_3,NAMED('DBG_E_Inquiry_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Address_Intermediate_3,NAMED('DBG_E_Person_Address_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_3,NAMED('DBG_E_Person_Inquiry_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_3,NAMED('DBG_E_Person_Property_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_3,NAMED('DBG_E_Person_Vehicle_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_3,NAMED('DBG_E_Professional_License_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_3,NAMED('DBG_E_Sele_Person_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_3,NAMED('DBG_E_Watercraft_Owner_Intermediate_3_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_2,NAMED('DBG_E_Address_Intermediate_2_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_2,NAMED('DBG_E_Input_B_I_I_Intermediate_2_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_2,NAMED('DBG_E_Input_P_I_I_Intermediate_2_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Intermediate_1,NAMED('DBG_E_Input_B_I_I_Intermediate_1_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_1,NAMED('DBG_E_Input_P_I_I_Intermediate_1_Q_Input_Bus_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_B_I_I_Annotated,NAMED('DBG_E_Input_B_I_I_Annotated_Q_Input_Bus_Attributes_V1_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
