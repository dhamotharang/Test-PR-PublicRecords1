//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Criminal_Offense_6,B_Criminal_Offense_7,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_Email_2,B_Email_3,B_First_Degree_Relative_5,B_Input_P_I_I,B_Input_P_I_I_1,B_Input_P_I_I_10,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Inquiry_10,B_Inquiry_11,B_Inquiry_3,B_Inquiry_4,B_Inquiry_5,B_Inquiry_6,B_Inquiry_7,B_Inquiry_8,B_Inquiry_9,B_Lien_Judgment_13,B_Person,B_Person_1,B_Person_10,B_Person_11,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Accident_8,B_Person_Address_2,B_Person_Address_3,B_Person_Inquiry_3,B_Person_Inquiry_4,B_Person_Inquiry_5,B_Person_Inquiry_6,B_Person_Inquiry_7,B_Person_Inquiry_8,B_Person_Lien_Judgment_12,B_Person_Property_1,B_Person_Property_2,B_Person_Property_3,B_Person_Property_4,B_Person_Property_5,B_Person_Property_6,B_Person_Property_7,B_Person_Property_8,B_Person_S_S_N_1,B_Person_S_S_N_2,B_Person_S_S_N_3,B_Person_S_S_N_4,B_Person_S_S_N_5,B_Person_S_S_N_6,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property_2,B_Property_3,B_Property_4,B_Property_5,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Property_Event_6,B_Property_Event_7,B_Property_Event_8,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Property,E_Address_Slim,E_Address_Summary,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Criminal_Offense,E_Education,E_Email,E_Email_Inquiry,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_Household,E_Household_Member,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Name_Summary,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Education,E_Person_Email,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offenses,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Phone_Summary,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_S_S_N_Inquiry,E_S_S_N_Summary,E_Sele_Person,E_Social_Security_Number,E_Surname,E_Utility,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT Q_Input_Attributes_V1_Hybrid(DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, KEL.typ.kdate __PRunDateToMimic, DATA57 __PDPM, KEL.typ.bool __PisFCRA, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),p_lexid(OVERRIDE:Subject_:0|DEFAULT:P___Lex_I_D_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'|OVERRIDE:Z_I_P5_:0),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),Input_Clean_Email_(OVERRIDE:Input_Clean_Email_:0),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'|OVERRIDE:Input_Clean_Phone_:0|OVERRIDE:Telephone_Summary_:0),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'|OVERRIDE:Input_Clean_S_S_N_:0|OVERRIDE:Social_Summary_:0),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),Slim_Location_(DEFAULT:Slim_Location_:0),Name_Summ_(DEFAULT:Name_Summ_:0),Location_Summary_(DEFAULT:Location_Summary_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
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
    SHARED __d0_Slim_Location__Layout := RECORD
      RECORDOF(__d0_Input_Clean_Email__Mapped);
      KEL.typ.uid Slim_Location_;
    END;
    SHARED __d0_Missing_Slim_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Input_Clean_Email__Mapped,'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5','__PInputPIIDataset');
    SHARED __d0_Slim_Location__Mapped := IF(__d0_Missing_Slim_Location__UIDComponents = 'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5',PROJECT(__d0_Input_Clean_Email__Mapped,TRANSFORM(__d0_Slim_Location__Layout,SELF.Slim_Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Input_Clean_Email__Mapped,__d0_Missing_Slim_Location__UIDComponents),E_Address_Slim(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPreDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSffx) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPostDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrZip5) = RIGHT.KeyVal,TRANSFORM(__d0_Slim_Location__Layout,SELF.Slim_Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Name_Summ__Layout := RECORD
      RECORDOF(__d0_Slim_Location__Mapped);
      KEL.typ.uid Name_Summ_;
    END;
    SHARED __d0_Missing_Name_Summ__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Slim_Location__Mapped,'P_InpClnNameFirst,P_InpClnNameLast,P_InpClnDOB','__PInputPIIDataset');
    SHARED __d0_Name_Summ__Mapped := IF(__d0_Missing_Name_Summ__UIDComponents = 'P_InpClnNameFirst,P_InpClnNameLast,P_InpClnDOB',PROJECT(__d0_Slim_Location__Mapped,TRANSFORM(__d0_Name_Summ__Layout,SELF.Name_Summ_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Slim_Location__Mapped,__d0_Missing_Name_Summ__UIDComponents),E_Name_Summary(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnNameFirst) + '|' + TRIM((STRING)LEFT.P_InpClnNameLast) + '|' + TRIM((STRING)LEFT.P_InpClnDOB) = RIGHT.KeyVal,TRANSFORM(__d0_Name_Summ__Layout,SELF.Name_Summ_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
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
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Inquiry_Filtered := MODULE(E_Address_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Filtered := MODULE(E_Address_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Owner_Filtered := MODULE(E_Aircraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Bankruptcy_Filtered := MODULE(E_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offense_Filtered := MODULE(E_Criminal_Offense(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_Filtered := MODULE(E_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Filtered := MODULE(E_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Inquiry_Filtered := MODULE(E_Email_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Associations_Filtered := MODULE(E_First_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Relative_Filtered := MODULE(E_First_Degree_Relative(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Filtered := MODULE(E_Household(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Member_Filtered := MODULE(E_Household_Member(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Lien_Judgment_Filtered := MODULE(E_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Accident_Filtered := MODULE(E_Person_Accident(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Address_Filtered := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Bankruptcy_Filtered := MODULE(E_Person_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Education_Filtered := MODULE(E_Person_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Email_Filtered := MODULE(E_Person_Email(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Inquiry_Filtered := MODULE(E_Person_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Lien_Judgment_Filtered := MODULE(E_Person_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offenses_Filtered := MODULE(E_Person_Offenses(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Filtered := MODULE(E_Person_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Event_Filtered := MODULE(E_Person_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_S_S_N_Filtered := MODULE(E_Person_S_S_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered := MODULE(E_Person_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Filtered := MODULE(E_Phone(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Inquiry_Filtered := MODULE(E_Phone_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Filtered := MODULE(E_Professional_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Person_Filtered := MODULE(E_Professional_License_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Event_Filtered := MODULE(E_Property_Event(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Inquiry_Filtered := MODULE(E_S_S_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Archive___Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Person_Filtered := MODULE(E_Utility_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PRunDateToMimic)),AND,__OP2(KEL.era.ToDateMaxNull(__ds.Vault_Date_Last_Seen_),>=,__CN(__PRunDateToMimic)))) AND __T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
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
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_10(__in,__cfg_Local).__ENH_Input_P_I_I_10) __ENH_Input_P_I_I_10 := B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10;
  END;
  SHARED B_Inquiry_9_Local := MODULE(B_Inquiry_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_10(__in,__cfg_Local).__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10_Local.__ENH_Inquiry_10;
  END;
  SHARED B_Person_9_Local := MODULE(B_Person_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_10(__in,__cfg_Local).__ENH_Input_P_I_I_10) __ENH_Input_P_I_I_10 := B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10;
    SHARED TYPEOF(B_Person_10(__in,__cfg_Local).__ENH_Person_10) __ENH_Person_10 := B_Person_10_Local.__ENH_Person_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Inquiry_8_Local := MODULE(B_Inquiry_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_9(__in,__cfg_Local).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
  END;
  SHARED B_Person_8_Local := MODULE(B_Person_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
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
  SHARED B_Criminal_Offense_7_Local := MODULE(B_Criminal_Offense_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Inquiry_7_Local := MODULE(B_Inquiry_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_8(__in,__cfg_Local).__ENH_Inquiry_8) __ENH_Inquiry_8 := B_Inquiry_8_Local.__ENH_Inquiry_8;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
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
  SHARED B_Criminal_Offense_6_Local := MODULE(B_Criminal_Offense_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_7(__in,__cfg_Local).__ENH_Criminal_Offense_7) __ENH_Criminal_Offense_7 := B_Criminal_Offense_7_Local.__ENH_Criminal_Offense_7;
  END;
  SHARED B_Education_6_Local := MODULE(B_Education_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
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
  SHARED B_Person_S_S_N_6_Local := MODULE(B_Person_S_S_N_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_7(__in,__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
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
    SHARED TYPEOF(B_Criminal_Offense_6(__in,__cfg_Local).__ENH_Criminal_Offense_6) __ENH_Criminal_Offense_6 := B_Criminal_Offense_6_Local.__ENH_Criminal_Offense_6;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_6(__in,__cfg_Local).__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_First_Degree_Relative_5_Local := MODULE(B_First_Degree_Relative_5(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Inquiry_5_Local := MODULE(B_Inquiry_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_6(__in,__cfg_Local).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6_Local.__ENH_Inquiry_6;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_6(__in,__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
    SHARED TYPEOF(B_Person_S_S_N_6(__in,__cfg_Local).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6;
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
  SHARED B_Person_S_S_N_5_Local := MODULE(B_Person_S_S_N_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_6(__in,__cfg_Local).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6;
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
  SHARED B_Person_S_S_N_4_Local := MODULE(B_Person_S_S_N_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_5(__in,__cfg_Local).__ENH_Person_S_S_N_5) __ENH_Person_S_S_N_5 := B_Person_S_S_N_5_Local.__ENH_Person_S_S_N_5;
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
  SHARED B_Email_3_Local := MODULE(B_Email_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Email(__in,__cfg_Local).__Result) __E_Email := E_Email_Filtered.__Result;
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
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Person_S_S_N_3_Local := MODULE(B_Person_S_S_N_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_4(__in,__cfg_Local).__ENH_Person_S_S_N_4) __ENH_Person_S_S_N_4 := B_Person_S_S_N_4_Local.__ENH_Person_S_S_N_4;
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
  SHARED B_Aircraft_Owner_2_Local := MODULE(B_Aircraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local := MODULE(B_Bankruptcy_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
  END;
  SHARED B_Criminal_Offense_2_Local := MODULE(B_Criminal_Offense_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
  END;
  SHARED B_Education_2_Local := MODULE(B_Education_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_3(__in,__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
  END;
  SHARED B_Email_2_Local := MODULE(B_Email_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Email_3(__in,__cfg_Local).__ENH_Email_3) __ENH_Email_3 := B_Email_3_Local.__ENH_Email_3;
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
    SHARED TYPEOF(B_Email_3(__in,__cfg_Local).__ENH_Email_3) __ENH_Email_3 := B_Email_3_Local.__ENH_Email_3;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_Inquiry_3(__in,__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
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
  SHARED B_Person_Address_2_Local := MODULE(B_Person_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
  END;
  SHARED B_Person_Property_2_Local := MODULE(B_Person_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_3(__in,__cfg_Local).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3_Local.__ENH_Person_Property_3;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_3(__in,__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Person_S_S_N_2_Local := MODULE(B_Person_S_S_N_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_3(__in,__cfg_Local).__ENH_Person_S_S_N_3) __ENH_Person_S_S_N_3 := B_Person_S_S_N_3_Local.__ENH_Person_S_S_N_3;
  END;
  SHARED B_Person_Vehicle_2_Local := MODULE(B_Person_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local := MODULE(B_Professional_License_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
  END;
  SHARED B_Property_2_Local := MODULE(B_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_3(__in,__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
  END;
  SHARED B_Property_Event_2_Local := MODULE(B_Property_Event_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Watercraft_Owner_2_Local := MODULE(B_Watercraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Aircraft_Owner_1_Local := MODULE(B_Aircraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local := MODULE(B_Bankruptcy_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
  END;
  SHARED B_Criminal_Offense_1_Local := MODULE(B_Criminal_Offense_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
  END;
  SHARED B_Education_1_Local := MODULE(B_Education_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_2(__in,__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
  END;
  SHARED B_Input_P_I_I_1_Local := MODULE(B_Input_P_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered.__Result;
    SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Education_2(__in,__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
    SHARED TYPEOF(B_Email_2(__in,__cfg_Local).__ENH_Email_2) __ENH_Email_2 := B_Email_2_Local.__ENH_Email_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(B_Person_Address_2(__in,__cfg_Local).__ENH_Person_Address_2) __ENH_Person_Address_2 := B_Person_Address_2_Local.__ENH_Person_Address_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_2(__in,__cfg_Local).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2_Local.__ENH_Person_Property_2;
    SHARED TYPEOF(B_Person_S_S_N_2(__in,__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Property_1_Local := MODULE(B_Person_Property_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_2(__in,__cfg_Local).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2_Local.__ENH_Person_Property_2;
    SHARED TYPEOF(B_Property_2(__in,__cfg_Local).__ENH_Property_2) __ENH_Property_2 := B_Property_2_Local.__ENH_Property_2;
  END;
  SHARED B_Person_S_S_N_1_Local := MODULE(B_Person_S_S_N_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_2(__in,__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
  END;
  SHARED B_Person_Vehicle_1_Local := MODULE(B_Person_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local := MODULE(B_Professional_License_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
  END;
  SHARED B_Property_Event_1_Local := MODULE(B_Property_Event_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
  END;
  SHARED B_Watercraft_Owner_1_Local := MODULE(B_Watercraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Input_P_I_I_Local := MODULE(B_Input_P_I_I(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1(__in,__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_1(__in,__cfg_Local).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Education_1(__in,__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_1(__in,__cfg_Local).__ENH_Person_Property_1) __ENH_Person_Property_1 := B_Person_Property_1_Local.__ENH_Person_Property_1;
    SHARED TYPEOF(B_Person_S_S_N_1(__in,__cfg_Local).__ENH_Person_S_S_N_1) __ENH_Person_S_S_N_1 := B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg_Local).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_1(__in,__cfg_Local).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg_Local).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1;
  END;
  SHARED TYPEOF(B_Input_P_I_I(__in,__cfg_Local).__ENH_Input_P_I_I) __ENH_Input_P_I_I := B_Input_P_I_I_Local.__ENH_Input_P_I_I;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED __EE12178985 := __ENH_Input_P_I_I;
  SHARED __EE12178988 := __ENH_Person;
  SHARED __ST5442146_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
    KEL.typ.nint P___Inp_Cln_Arch_Dt_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nint I_Rep_Number_Value_;
    KEL.typ.nstr Input_Account_Value_;
    KEL.typ.nstr Input_Address_Status_Clean_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Value_;
    KEL.typ.nstr Input_Archive_Date_Clean_Value_;
    KEL.typ.nstr Input_Archive_Date_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_City_Post_Clean_Value_;
    KEL.typ.nstr Input_City_Value_;
    KEL.typ.nstr Input_County_Clean_Value_;
    KEL.typ.nstr Input_D_L_Clean_Value_;
    KEL.typ.nstr Input_D_L_State_Clean_Value_;
    KEL.typ.nstr Input_D_L_State_Value_;
    KEL.typ.nstr Input_D_L_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.nstr Input_Email_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Value_;
    KEL.typ.nstr Input_I_P_Addr_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.nint Input_Lex_I_D_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Prefix_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_State_Code_Clean_Value_;
    KEL.typ.nstr Input_State_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Street_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Work_Phone_Clean_Value_;
    KEL.typ.nstr Input_Work_Phone_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr Input_Zip_Value_;
    KEL.typ.nstr Ins_Phone_Hit_;
    KEL.typ.nstr Ins_Phone_Src_;
    KEL.typ.nstr P_I___Alrt_Inp_Name_On_Watchlist_Flag_;
    KEL.typ.nstr P_I___Alrt_Inp_Name_Watchlist_Rec_Num_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Conf_Score_;
    KEL.typ.nfloat P_I___Inp_Addr_A_V_M_Ratio1_Y_;
    KEL.typ.nfloat P_I___Inp_Addr_A_V_M_Ratio5_Y_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Val_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Val_A1_Y_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Val_A5_Y_;
    KEL.typ.int P_I___Inp_Addr_Is_Apt_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_C_M_R_A_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_College_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_D_N_D_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Drop_Delivery_Flag_ := 0;
    KEL.typ.str P_I___Inp_Addr_Is_Military_Flag_ := '';
    KEL.typ.int P_I___Inp_Addr_Is_Multi_Unit_Flag_ := 0;
    KEL.typ.str P_I___Inp_Addr_Is_P_O_Box_Flag_ := '';
    KEL.typ.int P_I___Inp_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Throwback_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Vacant_Flag_ := 0;
    KEL.typ.nstr P_I___Inp_Addr_New_Dt_;
    KEL.typ.int P_I___Inp_Addr_O_W_G_M_Flag_ := 0;
    KEL.typ.nstr P_I___Inp_Addr_Old_Dt_;
    KEL.typ.int P_I___Inp_Addr_On_File_Flag_Ev_ := 0;
    KEL.typ.int P_I___Inp_Addr_Seasonal_Type_ := 0;
    KEL.typ.int P_I___Inp_Addr_State_D_L_Avail_Flag___Non_F_C_R_A_ := 0;
    KEL.typ.int P_I___Inp_Addr_State_Voter_Avail_Flag___F_C_R_A_ := 0;
    KEL.typ.int P_I___Inp_Addr_State_Voter_Avail_Flag___Non_F_C_R_A_ := 0;
    KEL.typ.int P_I___Inp_Addr_Subj_Flag_ := 0;
    KEL.typ.nstr P_I___Inp_Addr_Subj_New_Dt_;
    KEL.typ.nint P_I___Inp_Addr_Subj_New_Msnc_;
    KEL.typ.nstr P_I___Inp_Addr_Subj_Old_Dt_;
    KEL.typ.nint P_I___Inp_Addr_Subj_Old_Msnc_;
    KEL.typ.nint P_I___Inp_Addr_Subj_Res_Span_;
    KEL.typ.nint P_I___Inp_D_O_B_Age_;
    KEL.typ.str P_I___Inp_Phone_Is_Bus_Phone_Flag_ := '';
    KEL.typ.str P_I___Inp_Phone_Is_H_R_Correct_Fac_Flag_ := '';
    KEL.typ.nstr P_I___Inp_Phone_N_A_I_C_S_Code_H_R_List_;
    KEL.typ.nstr P_I___Inp_Phone_S_I_C_Code_H_R_List_;
    KEL.typ.str P_I___Inp_Phone_Type_ := '';
    KEL.typ.nint P_I___Inp_S_S_N_Deceased_Dt_;
    KEL.typ.int P_I___Inp_S_S_N_Is_Deceased_Flag_ := 0;
    KEL.typ.int P_I___Srch_Addr_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_D_O_B_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_L_Name_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_L_Name_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Email_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Phone_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Per_Inp_Email_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Per_Inp_Phone_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_S_S_N_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.str P___Inp_Acct_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Addr_Line2_Value_;
    KEL.typ.str P___Inp_Addr_St_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.str P___Inp_Arch_Dt_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_City_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_Flag_Value_;
    KEL.typ.nint P___Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_Flag_Value_;
    KEL.typ.str P___Inp_Cln_Arch_Dt_F1_Y_ := '';
    KEL.typ.str P___Inp_Cln_Arch_Dt_F2_Y_ := '';
    KEL.typ.str P___Inp_Cln_Arch_Dt_F6_M_ := '';
    KEL.typ.str P___Inp_Cln_Arch_Dt_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_D_L_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Email_Dom_;
    KEL.typ.nstr P___Inp_Cln_Email_Ext_;
    KEL.typ.nstr P___Inp_Cln_Email_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Email_User_;
    KEL.typ.nstr P___Inp_Cln_I_P_Addr_;
    KEL.typ.nstr P___Inp_Cln_I_P_Addr_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_Flag_Value_;
    KEL.typ.str P___Inp_D_L_Flag_Value_ := '';
    KEL.typ.str P___Inp_D_L_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_D_O_B_Flag_Value_ := '';
    KEL.typ.str P___Inp_Email_Flag_Value_ := '';
    KEL.typ.str P___Inp_I_P_Addr_Flag_Value_ := '';
    KEL.typ.str P___Inp_Lex_I_D_Flag_Value_ := '';
    KEL.typ.str P___Inp_Name_First_Flag_Value_ := '';
    KEL.typ.str P___Inp_Name_Last_Flag_Value_ := '';
    KEL.typ.str P___Inp_Name_Mid_Flag_Value_ := '';
    KEL.typ.str P___Inp_Phone_Home_Flag_Value_ := '';
    KEL.typ.str P___Inp_Phone_Work_Flag_Value_ := '';
    KEL.typ.str P___Inp_S_S_N_Flag_Value_ := '';
    KEL.typ.str P___Inp_S_S_N_Is4_Digits_ := '';
    KEL.typ.nstr P___Inp_Val_Addr_St_Invalid_Flag_;
    KEL.typ.nint P___Inp_Val_Addr_State_Bad_Abbr_Flag_Value_;
    KEL.typ.nint P___Inp_Val_Addr_Zip_All_Zero_Flag_Value_;
    KEL.typ.int P___Inp_Val_Addr_Zip_Bad_Len_Flag_Value_ := 0;
    KEL.typ.nstr P___Inp_Val_Arch_Dt_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_D_L_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_D_L_State_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_D_O_B_Invalid_Flag_;
    KEL.typ.nint P___Inp_Val_Email_Bogus_Flag_Value_;
    KEL.typ.nint P___Inp_Val_Email_Dom_All_Zero_Flag_Value_;
    KEL.typ.nint P___Inp_Val_Email_Dom_Bad_Char_Flag_Value_;
    KEL.typ.nstr P___Inp_Val_Email_Invalid_Flag_;
    KEL.typ.nint P___Inp_Val_Email_User_All_Zero_Flag_Value_;
    KEL.typ.nint P___Inp_Val_Email_User_Bad_Char_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.nstr P___Inp_Val_Name_Invalid_Flag_;
    KEL.typ.int P___Inp_Val_Phone_Home_Bad_Char_Flag_ := 0;
    KEL.typ.nint P___Inp_Val_Phone_Home_Bad_Len_Flag_;
    KEL.typ.int P___Inp_Val_Phone_Home_Bogus_Flag_ := 0;
    KEL.typ.nstr P___Inp_Val_Phone_Home_Invalid_Flag_;
    KEL.typ.int P___Inp_Val_Phone_Work_Bad_Char_Flag_ := 0;
    KEL.typ.nint P___Inp_Val_Phone_Work_Bad_Len_Flag_;
    KEL.typ.int P___Inp_Val_Phone_Work_Bogus_Flag_ := 0;
    KEL.typ.nstr P___Inp_Val_Phone_Work_Invalid_Flag_;
    KEL.typ.int P___Inp_Val_S_S_N_Bad_Char_Flag_Value_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Bad_Len_Flag_Value_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Bogus_Flag_Value_ := 0;
    KEL.typ.nstr P___Inp_Val_S_S_N_Invalid_Flag_;
    KEL.typ.int P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_Value_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Non_S_S_A_Flag_Value_ := 0;
    KEL.typ.nstr Targus_Royalty_;
    KEL.typ.nstr Targus_Src_;
    KEL.typ.nstr _ipaddr_;
    KEL.typ.nstr _ipresponse_;
    KEL.typ.nint _netacuityroyalty_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST182189_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST182205_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST182221_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST101661_Layout) A_V_M_List_;
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg_Local).__ST276134_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg_Local).__ST106990_Layout) Accident_Recs_Formatted_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg_Local).__ST106990_Layout) Accident_Recs_Formatted_Dedup_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg_Local).__ST106990_Layout) Accident_Recs_Sorted_;
    KEL.typ.int Accidents_Count1_Y_ := 0;
    KEL.typ.nint Accidents_Count_Total_;
    KEL.typ.nstr Active_Professional_License_Category_;
    KEL.typ.nstr Active_Professional_License_Exp_Dt_;
    KEL.typ.nstr Active_Professional_License_Issue_Dt_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST96912_Layout) Active_Professional_License_Issue_Exp_Date_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST97090_Layout) Active_Professional_License_Issue_Exp_Date_Group_;
    KEL.typ.nstr Active_Professional_License_Occupation_;
    KEL.typ.nstr Active_Professional_License_Source_;
    KEL.typ.nstr Active_Professional_License_Type_;
    KEL.typ.bool Addr_Hist_On_File_ := FALSE;
    KEL.typ.ndataset(B_Person_10(__in,__cfg_Local).__ST85371_Layout) Address_Hierarchy_Set_;
    KEL.typ.nint Age_;
    KEL.typ.nbool Age_More_Than18_;
    KEL.typ.nkdate Aircraft_Build_Current_Date_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST102765_Layout) All_Inquiries_Past5_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST2683467_Layout) All_Lien_Data_;
    KEL.typ.int Asset_Property_Count_Ever_ := 0;
    KEL.typ.int Asset_Property_Current_Count_ := 0;
    KEL.typ.int Asset_Property_Sale_Count_ := 0;
    KEL.typ.nstr B_K_Ln_J_L_T_D_Min_Old_Date_;
    KEL.typ.nstr B_K_Ln_J_L_T_D_Min_Old_Date_Blank_;
    KEL.typ.nint B_K_Ln_J_L_T_D_New_Date_Min_Msnc_;
    KEL.typ.nint B_K_Ln_J_L_T_D_Old_Date_Max_Msnc_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST99768_Layout) Banko_List_;
    KEL.typ.nkdate Best_D_O_B_;
    KEL.typ.nint Best_D_O_B_Age_;
    KEL.typ.nstr Best_First_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Mid_Name_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Best_S_S_N_;
    KEL.typ.int Bk_Cnt10_Y_Business_Type_ := 0;
    KEL.typ.int Bk_Cnt10_Y_Filing_Type_All_Null_ := 0;
    KEL.typ.int Bk_Cnt10y_No_Chpt_ := 0;
    KEL.typ.int Bk_Cnt1_Y_Business_Type_ := 0;
    KEL.typ.int Bk_Cnt1_Y_Filing_Type_All_Null_ := 0;
    KEL.typ.int Bk_Cnt1y_No_Chpt_ := 0;
    KEL.typ.int Bk_Cnt7_Y_Business_Type_ := 0;
    KEL.typ.int Bk_Cnt7_Y_Filing_Type_All_Null_ := 0;
    KEL.typ.int Bk_Cnt7y_No_Chpt_ := 0;
    KEL.typ.nstr C_R_B_K_Ln_J_L_T_D_Min_Old_Date_;
    KEL.typ.nint C_R_B_K_Ln_J_L_T_D_New_Date_Min_Msnc_;
    KEL.typ.nint C_R_B_K_Ln_J_L_T_D_Old_Date_Max_Msnc_;
    KEL.typ.int Ch13_Cnt10_Y_ := 0;
    KEL.typ.int Ch13_Cnt1_Y_ := 0;
    KEL.typ.int Ch13_Cnt7_Y_ := 0;
    KEL.typ.int Ch7_Cnt10_Y_ := 0;
    KEL.typ.int Ch7_Cnt1_Y_ := 0;
    KEL.typ.int Ch7_Cnt7_Y_ := 0;
    KEL.typ.int Contact_Bus_Cnt_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST99753_Layout) Crim_List_;
    KEL.typ.nkdate Curr_Addr_Date_First_Seen_;
    KEL.typ.nkdate Curr_Addr_Date_Last_Seen_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg_Local).__ST85371_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ntyp(E_Address().Typ) Curr_Addr_Helper_Attribute_;
    KEL.typ.int Curr_Addr_Sec_Rng_Empty_Check_ := 0;
    KEL.typ.int Curr_Addr_Unit_Dsg_Empty_Check_ := 0;
    B_Person_10(__in,__cfg_Local).__ST85371_Layout Current_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Postdirectional_;
    KEL.typ.nstr Date_List_;
    KEL.typ.int Drg_Cnt_Contact_ := 0;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST99892_Layout) Edu_Coll_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST99892_Layout) Edu_Coll_Rec_Ver_Source_List_Filtered_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST99892_Layout) Edu_H_S_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST99892_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg_Local).__ST99865_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST99892_Layout) Edu_Rec_Ver_Source_List_Sorted_;
    KEL.typ.int Email_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int Email_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int Email_Corp_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int Email_Corp_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int Email_Edu_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int Email_Edu_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int Email_Free_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int Email_Free_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int Email_I_S_P_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int Email_I_S_P_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int Email_Unknown_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int Email_Unknown_Cnt_Ev_Non_F_C_R_A_ := 0;
    E_Person_Address(__in,__cfg_Local).Address_Hierarchy_Layout Emerging_;
    KEL.typ.nstr Emerging_Addr_Cnty_;
    KEL.typ.nstr Emerging_Addr_Geo_;
    KEL.typ.nstr Emerging_Addr_Pre_Dir_;
    KEL.typ.nstr Emerging_Addr_Prim_Name_;
    KEL.typ.nstr Emerging_Addr_Prim_Rng_;
    KEL.typ.nstr Emerging_Addr_Sec_Rng_;
    KEL.typ.nstr Emerging_Addr_Sffx_;
    KEL.typ.nstr Emerging_Addr_State_;
    KEL.typ.nstr Emerging_Addr_State_Code_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Emerging_Addr_Zip5_;
    KEL.typ.nstr Emerging_Postdirectional_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg_Local).Address_Hierarchy_Layout) Emerging_Temp_;
    KEL.typ.nkdate Emrg_Date_;
    KEL.typ.ntyp(E_Household().Typ) H_H_I_D_;
    KEL.typ.int H_H_Mmbr_Under18_Cnt_ := 0;
    KEL.typ.int H_H_Mmbr_With_Suject_Under18cnt_ := 0;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST102348_Layout) Inquiries5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Auto_Srch5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST103012_Layout) Inquiries_Auto_Srch5_Y_List_Sorted_;
    KEL.typ.nint Inquiries_Banking5_Y_Count_;
    KEL.typ.nstr Inquiries_Banking5_Y_List_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST102814_Layout) Inquiries_Banking5_Y_Sorted_;
    KEL.typ.nint Inquiries_Comm5_Y_Count_;
    KEL.typ.nstr Inquiries_Comm5_Y_List_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST103810_Layout) Inquiries_Comm5_Y_Sorted_;
    KEL.typ.nstr Inquiries_Dt5_Y_List_;
    KEL.typ.nstr Inquiries_High_Risk5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST102572_Layout) Inquiries_High_Risk5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Mortgage5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST103211_Layout) Inquiries_Mortgage5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Other5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST104730_Layout) Inquiries_Other5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Over_All5_Y_Dt_List_;
    KEL.typ.nstr Inquiries_Prepaid_Card5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST103609_Layout) Inquiries_Prepaid_Card5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Quiz_Provider5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST104406_Layout) Inquiries_Quiz_Provider5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Retail_Payment5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST104207_Layout) Inquiries_Retail_Payment5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Student_Loan5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST104008_Layout) Inquiries_Student_Loan5_Y_List_Sorted_;
    KEL.typ.nstr Inquiries_Utility5_Y_Dt_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST103410_Layout) Inquiries_Utility5_Y_List_Sorted_;
    KEL.typ.nstr Inquiry5_Y_New_Date_;
    KEL.typ.nstr Inquiry5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Auto_Srch5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Auto_Srch5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Banking5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Banking5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Comm5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Comm5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_High_Risk5_Y_New_Date_;
    KEL.typ.nstr Inquiry_High_Risk5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Mortgage5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Mortgage5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Other5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Other5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Over_All5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Over_All5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Prepaid_Card5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Prepaid_Card5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Quiz_Provider5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Quiz_Provider5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Retail_Payment5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Retail_Payment5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Student_Loan5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Student_Loan5_Y_Old_Date_;
    KEL.typ.nstr Inquiry_Utility5_Y_New_Date_;
    KEL.typ.nstr Inquiry_Utility5_Y_Old_Date_;
    KEL.typ.nbool Is_Bureau_Only_Source_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST106654_Layout) Is_Bureau_Source_Test_;
    KEL.typ.bool Is_Person_Under18_ := FALSE;
    KEL.typ.bool Is_Postal_Source_ := FALSE;
    KEL.typ.bool Is_Previous_Postal_Source_ := FALSE;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST99801_Layout) L_T_D7_Y_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST98768_Layout) L_T_D7_Y_List_Sorted_;
    KEL.typ.nstr L_T_D7_Y_New_Date_;
    KEL.typ.nstr L_T_D7_Y_Old_Date_;
    KEL.typ.nstr L_T_D_Amount7_Y_List_;
    KEL.typ.nstr L_T_D_Dates7_Y_List_;
    B_Person_6(__in,__cfg_Local).__ST106990_Layout Latest_Acc_With_Amount_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST99784_Layout) Ln_J7_Y_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST99348_Layout) Ln_J7_Y_List_Sorted_;
    KEL.typ.nstr Ln_J7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.nstr Ln_J_Amount7_Y_List_;
    KEL.typ.nstr Ln_J_Dates7_Y_List_;
    KEL.typ.nstr Ln_J_L_T_D_Min_Old_Date_;
    KEL.typ.nint Ln_J_L_T_D_New_Date_Min_Msnc_;
    KEL.typ.nint Ln_J_L_T_D_Old_Date_Max_Msnc_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST106495_Layout) Members_Not_Subject_;
    KEL.typ.nint Months_Since_;
    KEL.typ.nstr Most_Recent_Chapter10_Y_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST95168_Layout) Most_Recent_Chapter10_Y_List_;
    KEL.typ.nstr Most_Recent_Chapter10_Y_With_Null_;
    KEL.typ.nstr Most_Recent_Chapter1_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST94962_Layout) Most_Recent_Chapter1_Y_List_;
    KEL.typ.nstr Most_Recent_Chapter1_Y_With_Null_;
    KEL.typ.nstr Most_Recent_Chapter7_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95065_Layout) Most_Recent_Chapter7_Y_List_;
    KEL.typ.nstr Most_Recent_Chapter7_Y_With_Null_;
    KEL.typ.nstr Most_Recent_Dispo10_Y_;
    KEL.typ.nstr Most_Recent_Dispo1_Y_;
    KEL.typ.nstr Most_Recent_Dispo7_Y_;
    KEL.typ.nstr Most_Recent_Dispo_Dte10_Y_;
    KEL.typ.nstr Most_Recent_Dispo_Dte1_Y_;
    KEL.typ.nstr Most_Recent_Dispo_Dte7_Y_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST95957_Layout) Most_Recent_Dispo_List10_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95853_Layout) Most_Recent_Dispo_List1_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95905_Layout) Most_Recent_Dispo_List7_Y_;
    KEL.typ.nstr Most_Recent_Dt_Of_Bks10_Y_With_Null_;
    KEL.typ.nstr Most_Recent_Dt_Of_Bks1_Y_With_Null_;
    KEL.typ.nstr Most_Recent_Dt_Of_Bks7_Y_With_Null_;
    KEL.typ.nstr Most_Recent_Update10_Y_;
    KEL.typ.nstr Most_Recent_Update1_Y_;
    KEL.typ.nstr Most_Recent_Update7_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95578_Layout) Most_Recent_Update_Bks10_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95452_Layout) Most_Recent_Update_Bks1_Y_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95515_Layout) Most_Recent_Update_Bks7_Y_;
    B_Person_1(__in,__cfg_Local).__ST97718_Layout Only_Curr_Address_Helper_Flag_;
    B_Person_1(__in,__cfg_Local).__ST98374_Layout Only_Previous_Address_Helper_Flag_;
    KEL.typ.int Over_All_Drg_Cnt7_Y_ := 0;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Acc_Cnt1_Y_ := 0;
    KEL.typ.nint P_L___Acc_Cnt_Ev_;
    KEL.typ.nstr P_L___Acc_Dmg_Amt_List_Ev_;
    KEL.typ.int P_L___Acc_Dmg_Tot_Ev_ := 0;
    KEL.typ.nstr P_L___Acc_Dt_List_Ev_;
    KEL.typ.nstr P_L___Acc_Flag_Ev_;
    KEL.typ.nint P_L___Acc_New_Dmg_Amt_Ev_;
    KEL.typ.nstr P_L___Acc_New_Dt_Ev_;
    KEL.typ.nstr P_L___Acc_New_Msnc_Ev_;
    KEL.typ.int P_L___Addr_Emrg_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt15_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt2_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt3_M_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt3_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt5_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt6_M_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt7_Y_ := 0;
    KEL.typ.str P_L___Addr_Hist_On_File_Flag_ := '';
    KEL.typ.str P_L___Alrt_Cons_Statement_Flag_ := '';
    KEL.typ.str P_L___Alrt_Corrected_Flag_ := '';
    KEL.typ.str P_L___Alrt_Dispute_Flag_ := '';
    KEL.typ.str P_L___Alrt_I_D_Theft_Flag_ := '';
    KEL.typ.str P_L___Alrt_Security_Alert_Flag_ := '';
    KEL.typ.str P_L___Alrt_Security_Freeze_Flag_ := '';
    KEL.typ.int P_L___Ast_Prop_Bus_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Prop_Bus_Curr_Cnt_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Bus_Curr_Tax_Val_List_;
    KEL.typ.int P_L___Ast_Prop_Bus_Curr_Tax_Val_Tot_ := 0;
    KEL.typ.int P_L___Ast_Prop_Bus_Curr_W_Tax_Val_Cnt_ := 0;
    KEL.typ.int P_L___Ast_Prop_Cnt_Ev_ := 0;
    KEL.typ.nfloat P_L___Ast_Prop_Curr_A_V_M_Val_Avg_;
    KEL.typ.nstr P_L___Ast_Prop_Curr_A_V_M_Val_List_;
    KEL.typ.nint P_L___Ast_Prop_Curr_A_V_M_Val_Tot_;
    KEL.typ.int P_L___Ast_Prop_Curr_Cnt_ := 0;
    KEL.typ.nint P_L___Ast_Prop_Curr_Flag_;
    KEL.typ.nstr P_L___Ast_Prop_Curr_Mkt_Val_List_;
    KEL.typ.nstr P_L___Ast_Prop_Curr_Tax_Val_List_;
    KEL.typ.int P_L___Ast_Prop_Curr_Tax_Val_Tot_ := 0;
    KEL.typ.int P_L___Ast_Prop_Curr_W_A_V_M_Val_Cnt_ := 0;
    KEL.typ.int P_L___Ast_Prop_Curr_W_Mkt_Val_Cnt_ := 0;
    KEL.typ.int P_L___Ast_Prop_Curr_W_Tax_Val_Cnt_ := 0;
    KEL.typ.nint P_L___Ast_Prop_Flag_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_New_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Old_Dt_List_Ev_;
    KEL.typ.nint P_L___Ast_Prop_Ownership_Indx_;
    KEL.typ.int P_L___Ast_Prop_Purch_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Ast_Prop_Purch_Cnt5_Y_ := 0;
    KEL.typ.int P_L___Ast_Prop_Purch_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Purch_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_Old_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Sale_Amt_List_Ev_;
    KEL.typ.int P_L___Ast_Prop_Sale_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Sale_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Sale_New_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Prop_Sale_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Sale_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Prop_Sale_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Prop_Sale_Tot_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Air_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST92550_Layout) P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_Pre_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_New_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt2_Y_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST4343639_Layout) P_L___Ast_Veh_Auto_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Old_Msnc_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST4343659_Layout) P_L___Ast_Veh_Auto_Last_Dt_List_Ev_;
    KEL.typ.int P_L___Ast_Veh_Wtr_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST92810_Layout) P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_Pre_;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_New_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Wtr_Emrg_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Wtr_Emrg_Old_Msnc_Ev_;
    KEL.typ.nstr P_L___Best_D_O_B_;
    KEL.typ.nint P_L___Best_D_O_B_Age_;
    KEL.typ.nstr P_L___Best_Name_First_;
    KEL.typ.nstr P_L___Best_Name_Last_;
    KEL.typ.nstr P_L___Best_Name_Mid_;
    KEL.typ.nstr P_L___Best_S_S_N_;
    KEL.typ.nstr P_L___Curr_Addr_Cnty_;
    KEL.typ.nstr P_L___Curr_Addr_Full_;
    KEL.typ.nstr P_L___Curr_Addr_Geo_;
    KEL.typ.int P_L___Curr_Addr_Is_Apt_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_C_M_R_A_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_College_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_D_N_D_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Drop_Delivery_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Multi_Unit_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Throwback_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Vacant_Flag_ := 0;
    KEL.typ.nstr P_L___Curr_Addr_Lat_;
    KEL.typ.nstr P_L___Curr_Addr_Lng_;
    KEL.typ.nstr P_L___Curr_Addr_Loc_I_D_;
    KEL.typ.int P_L___Curr_Addr_Seasonal_Type_ := 0;
    KEL.typ.nstr P_L___Curr_Addr_Status_;
    KEL.typ.nstr P_L___Curr_Addr_Type_;
    KEL.typ.int P_L___Drg_Arst_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Arst_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Arst_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Arst_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Arst_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Arst_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Arst_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Arst_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Arst_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Arst_Old_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag7_Y_;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Ch_List10_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST94863_Layout) P_L___Drg_Bk_Ch_List10_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Ch_List1_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST94779_Layout) P_L___Drg_Bk_Ch_List1_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Ch_List7_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST94821_Layout) P_L___Drg_Bk_Ch_List7_Y_Pre_;
    KEL.typ.int P_L___Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt1_Y_F1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Disp_List10_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST95766_Layout) P_L___Drg_Bk_Disp_List10_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Disp_List1_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST95674_Layout) P_L___Drg_Bk_Disp_List1_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Disp_List7_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST95720_Layout) P_L___Drg_Bk_Disp_List7_Y_Pre_;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Dt_List10_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST94527_Layout) P_L___Drg_Bk_Dt_List10_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Dt_List1_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST94457_Layout) P_L___Drg_Bk_Dt_List1_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Dt_List7_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST94492_Layout) P_L___Drg_Bk_Dt_List7_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc10_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc10_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc7_Y_;
    KEL.typ.str P_L___Drg_Bk_Severity_Indx10_Y_ := '';
    KEL.typ.nstr P_L___Drg_Bk_Type_List10_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST96410_Layout) P_L___Drg_Bk_Type_List10_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Type_List1_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST96318_Layout) P_L___Drg_Bk_Type_List1_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Type_List7_Y_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST96364_Layout) P_L___Drg_Bk_Type_List7_Y_Pre_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Behavior_Indx7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Behavior_Indx7_Y_F_C_R_A_;
    KEL.typ.int P_L___Drg_Crim_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt1_Y_F1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt1_Y_F_C_R_A_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt7_Y_F_C_R_A_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt1_Y_F_C_R_A_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt7_Y_F_C_R_A_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc1_Y_F_C_R_A_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc7_Y_F_C_R_A_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt1_Y_F_C_R_A_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt7_Y_F_C_R_A_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc1_Y_F_C_R_A_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc7_Y_F_C_R_A_;
    KEL.typ.nstr P_L___Drg_Crim_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_New_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_Old_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Old_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Severity_Indx7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Severity_Indx7_Y_F_C_R_A_;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D1_Y_F1_Y_ := 0;
    KEL.typ.nstr P_L___Drg_L_T_D_Amt_List7_Y_;
    KEL.typ.int P_L___Drg_L_T_D_Amt_Tot7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_L_T_D_Dt_List7_Y_;
    KEL.typ.nstr P_L___Drg_L_T_D_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_L_T_D_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_L_T_D_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_L_T_D_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Lien_Cnt1_Y_F1_Y_ := 0;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.float P_L___Drg_Ln_J_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr P_L___Drg_Ln_J_Amt_List7_Y_;
    KEL.typ.int P_L___Drg_Ln_J_Amt_Tot7_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Ln_J_Dt_List7_Y_;
    KEL.typ.nstr P_L___Drg_Ln_J_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Ln_J_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Ln_J_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Ln_J_Old_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Old_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Suit_Amt_List7_Y_;
    KEL.typ.int P_L___Drg_Suit_Amt_Tot7_Y_ := 0;
    KEL.typ.int P_L___Drg_Suit_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Suit_Dt_List7_Y_;
    KEL.typ.nint P_L___Drg_Suit_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Suit_Old_Msnc7_Y_;
    KEL.typ.str P_L___Edu_Coll_Rec_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Edu_Coll_Rec_Span_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_New_Dt_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_Old_Msnc_Ev_;
    KEL.typ.str P_L___Edu_H_S_Rec_Flag_Ev_ := '';
    KEL.typ.str P_L___Edu_Rec_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Edu_Src_List_Ev_;
    KEL.typ.int P_L___Email_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_Corp_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_Corp_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_Edu_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_Edu_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.nstr P_L___Email_Flag_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Email_Flag_Ev_Non_F_C_R_A_;
    KEL.typ.int P_L___Email_Free_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_Free_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_I_S_P_Cnt_Ev_F_C_R_A_ := 0;
    KEL.typ.int P_L___Email_I_S_P_Cnt_Ev_Non_F_C_R_A_ := 0;
    KEL.typ.nint P_L___Emrg_Age_;
    KEL.typ.ntyp(E_Household().Typ) P_L___H_H_I_D_;
    KEL.typ.int P_L___H_H_Mmbr_Age18u_Cnt_ := 0;
    KEL.typ.nint P_L___H_H_Mmbr_Bureau_Only_Cnt_;
    KEL.typ.nint P_L___H_H_Mmbr_Cnt_;
    KEL.typ.nint P_L___Inq_Addr_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_D_O_B_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_F_Name_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_L_Name_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.int P_L___Inq_Per_Lex_I_D_Cnt1_Y_ := 0;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_A_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_S_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Phone_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_S_S_N_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nstr P_L___Prev_Addr_Cnty_;
    KEL.typ.nstr P_L___Prev_Addr_Full_;
    KEL.typ.nstr P_L___Prev_Addr_Geo_;
    KEL.typ.int P_L___Prev_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_L___Prev_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.nstr P_L___Prev_Addr_Lat_;
    KEL.typ.nstr P_L___Prev_Addr_Lng_;
    KEL.typ.nstr P_L___Prev_Addr_Loc_I_D_;
    KEL.typ.nstr P_L___Prev_Addr_Status_;
    KEL.typ.nstr P_L___Prev_Addr_Type_;
    KEL.typ.str P_L___Prof_Lic_Actv_Flag_ := '';
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Exp_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Indx_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Issue_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Src_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Title_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Type_;
    KEL.typ.int P_L___Prof_Lic_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Prof_Lic_Exp_Dt_List_Ev_;
    KEL.typ.str P_L___Prof_Lic_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Prof_Lic_Indx_By_Lic_List_Ev_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST96860_Layout) P_L___Prof_Lic_Indx_By_Lic_List_Ev_Pre_;
    KEL.typ.nstr P_L___Prof_Lic_Issue_Dt_List_Ev_;
    KEL.typ.nint P_L___S_T_L_Cnt1_Y_;
    KEL.typ.nint P_L___S_T_L_Cnt2_Y_;
    KEL.typ.nint P_L___S_T_L_Cnt5_Y_;
    KEL.typ.nstr P_L___S_T_L_Dt_List5_Y_;
    KEL.typ.nint P_L___Srch_Addr_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Auto_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Auto_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Auto_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Auto_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Auto_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Auto_Old_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Bank_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Bank_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Bank_New_Dt5_Y_;
    KEL.typ.nstr P_L___Srch_Bank_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Bank_Old_Dt5_Y_;
    KEL.typ.nstr P_L___Srch_Bank_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Cnt5_Y_;
    KEL.typ.nint P_L___Srch_Coll_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Coll_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Coll_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Coll_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Coll_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Coll_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Comm_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Comm_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Comm_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Comm_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Comm_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Comm_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Credit_H_R_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Credit_H_R_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Credit_H_R_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Credit_H_R_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Credit_H_R_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Credit_H_R_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_D_O_B_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nstr P_L___Srch_Dt_List5_Y_;
    KEL.typ.nint P_L___Srch_Email_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_F_Name_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_L_Name_Per_Curr_Addr_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_L_Name_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Lex_I_D_Per_Curr_Addr_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Mtge_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Mtge_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Mtge_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Mtge_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Mtge_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Mtge_Old_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Other_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Other_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Other_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Other_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Other_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Other_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Per_Curr_Addr_Cnt1_Y_;
    KEL.typ.int P_L___Srch_Per_Lex_I_D_Cnt1_Y_ := 0;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_A_S_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_F_L_A_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_F_L_A_S_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_F_L_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_F_L_S_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Per_Lex_I_D_W_Inp_S_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Phone_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Prepay_Card_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Prepay_Card_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Prepay_Card_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Prepay_Card_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Prepay_Card_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Prepay_Card_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Quiz_Prov_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Quiz_Prov_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Quiz_Prov_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Quiz_Prov_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Quiz_Prov_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Quiz_Prov_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Retail_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Retail_Dt_List5_Y_;
    KEL.typ.nint P_L___Srch_Retail_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Retail_New_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Retail_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Retail_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Retail_Pymt_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Retail_Pymt_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Retail_Pymt_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Retail_Pymt_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Retail_Pymt_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Retail_Pymt_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_S_S_N_Per_Curr_Addr_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_S_S_N_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Srch_Stdnt_Loan_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Stdnt_Loan_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Stdnt_Loan_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Stdnt_Loan_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Stdnt_Loan_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Stdnt_Loan_Old_Msnc5_Y_;
    KEL.typ.nint P_L___Srch_Util_Cnt5_Y_;
    KEL.typ.nstr P_L___Srch_Util_Dt_List5_Y_;
    KEL.typ.nstr P_L___Srch_Util_New_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Util_New_Msnc5_Y_;
    KEL.typ.nstr P_L___Srch_Util_Old_Dt5_Y_;
    KEL.typ.nint P_L___Srch_Util_Old_Msnc5_Y_;
    KEL.typ.int P_L___Util_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Util_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Util_Old_Dt_List_Ev_;
    KEL.typ.nint P_L___Util_Old_Msnc_Ev_;
    KEL.typ.nint P_L___Ver_Name_First_Src_Cnt_Ev_F_C_R_A_;
    KEL.typ.nint P_L___Ver_Name_First_Src_Cnt_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_Emrg_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_Emrg_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_Last_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_Last_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_List_Ev_Non_F_C_R_A_;
    KEL.typ.nint P_L___Ver_Name_Last_Src_Cnt_Ev_F_C_R_A_;
    KEL.typ.nint P_L___Ver_Name_Last_Src_Cnt_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_Emrg_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_Emrg_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_Last_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_Last_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_List_Ev_Non_F_C_R_A_;
    KEL.typ.nint P_L___Ver_S_S_N_Src_Cnt_Ev_F_C_R_A_;
    KEL.typ.nint P_L___Ver_S_S_N_Src_Cnt_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_Emrg_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_Emrg_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_Last_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_Last_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_List_Ev_Non_F_C_R_A_;
    KEL.typ.nint P_L___Ver_Src_Cnt_Ev_F_C_R_A_;
    KEL.typ.nint P_L___Ver_Src_Cnt_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_Emrg_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_Emrg_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_Last_Dt_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_Last_Dt_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_List_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_List_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_New_Dt_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_New_Dt_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_Old_Dt_Ev_F_C_R_A_;
    KEL.typ.nstr P_L___Ver_Src_Old_Dt_Ev_Non_F_C_R_A_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_Raw_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_Raw_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_Raw_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_Raw_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_Raw_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_Raw_;
    KEL.typ.nstr P___Inp_Cln_D_O_B__1_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_First__1_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last__1_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home__1_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N__1_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_Raw_;
    KEL.typ.nstr P___Lex_I_D_Category_;
    KEL.typ.str P___Lex_I_D_Is_Deceased_Flag_ := '';
    KEL.typ.str P___Lex_I_D_Rstd_Only_Flag_F_C_R_A_ := '';
    KEL.typ.str P___Lex_I_D_Rstd_Only_Flag_Non_F_C_R_A_ := '';
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.str P___Lex_I_D_Seen_Flag_F_C_R_A_ := '';
    KEL.typ.str P___Lex_I_D_Seen_Flag_N_O_W_ := '';
    KEL.typ.nint Person_Address_Hierarchy_Valid_Cnt_;
    KEL.typ.nint Person_Curr_Addr_Loc_I_D_;
    KEL.typ.nint Person_Prev_Addr_Loc_I_D_;
    KEL.typ.nint Person_Prev_Address_Hierarchy_Valid_Cnt_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST1069978_Layout) Person_S_S_N_Match_Sources_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST107913_Layout) Person_S_S_N_Match_Sources_Pre_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg_Local).__ST85371_Layout) Prev_Addr_Full_Set_;
    B_Person_10(__in,__cfg_Local).__ST85371_Layout Previous_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Addr_Helper_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Postdirectional_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST96812_Layout) Professional_License_Dates_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST101323_Layout) Property_Data_Set_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST101323_Layout) Property_Date_First_Seen_Sorted_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST101323_Layout) Property_Date_Last_Seen_Sorted_;
    KEL.typ.nstr Property_Min_Date_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST101323_Layout) Property_Sales_Sorted_;
    KEL.typ.int Purchase1_Y_Count_ := 0;
    KEL.typ.int Purchase5_Y_Count_ := 0;
    KEL.typ.int Purchase_Count_Ever_ := 0;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST102018_Layout) Purchase_Date_List_Sorted_;
    KEL.typ.nstr Purchase_New_Date_Ev_;
    KEL.typ.nstr Purchase_Old_Date_Ev_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg_Local).__ST85371_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST104598_Layout) Retail_Inquiries5_Yrs_;
    KEL.typ.nkdate Select_Age_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST107330_Layout) Short_Term_Loans1_Y_Sorted_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST107330_Layout) Short_Term_Loans2_Y_Sorted_;
    KEL.typ.nstr Short_Term_Loans5_Y_List_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST107330_Layout) Short_Term_Loans5_Y_Sorted_;
    KEL.typ.nstr Suit7_Y_New_Date_;
    KEL.typ.nstr Suit7_Y_Old_Date_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST99127_Layout) Suits7_Y_List_Sorted_;
    KEL.typ.nstr Suits_Amount7_Y_List_;
    KEL.typ.nstr Suits_Dates7_Y_List_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST107330_Layout) Thrive_Data_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST137514_Layout) Top1_Chapter10_Y_List_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST95116_Layout) Top1_Chapter10_Y_List_With_Null_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST137436_Layout) Top1_Chapter1_Y_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST94907_Layout) Top1_Chapter1_Y_List_With_Null_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST137475_Layout) Top1_Chapter7_Y_List_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST95013_Layout) Top1_Chapter7_Y_List_With_Null_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST96575_Layout) Top1_Dt_Of_Bks_List10_Y_With_Null_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST137546_Layout) Top1_Dt_Of_Bks_List1_Y_With_Null_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST137584_Layout) Top1_Dt_Of_Bks_List7_Y_With_Null_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg_Local).__ST578594_Layout) Translated_Sources_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST2684290_Layout) Unique_Addresses_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST100882_Layout) Util_List_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST100864_Layout) Util_List_Pre_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST100882_Layout) Util_List_Sorted_;
    KEL.typ.nkdate Vehicle_Build_Current_Date_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST137854_Layout) Velocity_Inquiries_Per_Curr_Addr_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_A_S_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_A_S_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_F_L_A_P_S_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_F_L_A_P_S_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_F_L_A_S_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_F_L_A_S_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_F_L_P_S_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_F_L_P_S_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_F_L_S_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_F_L_S_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_P_S_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_P_S_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671119_Layout) Velocity_Inquiries_With_S_D_Match_F_C_R_A_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg_Local).__ST1671140_Layout) Velocity_Inquiries_With_S_D_Match_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST110250_Layout) Velocity_Inquiry_Addrs_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105515_Layout) Velocity_Inquiry_Addrs_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST110338_Layout) Velocity_Inquiry_D_O_Bs_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105591_Layout) Velocity_Inquiry_D_O_Bs_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105609_Layout) Velocity_Inquiry_Emails_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST110296_Layout) Velocity_Inquiry_First_Names_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105555_Layout) Velocity_Inquiry_First_Names_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST137877_Layout) Velocity_Inquiry_Last_Names_Per_Curr_Addr_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST110275_Layout) Velocity_Inquiry_Last_Names_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105537_Layout) Velocity_Inquiry_Last_Names_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST137870_Layout) Velocity_Inquiry_Lex_I_Ds_Per_Curr_Addr_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST110317_Layout) Velocity_Inquiry_Phones_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105573_Layout) Velocity_Inquiry_Phones_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST137884_Layout) Velocity_Inquiry_S_S_Ns_Per_Curr_Addr_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST110229_Layout) Velocity_Inquiry_S_S_Ns_Per_Lex_I_D_F_C_R_A_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST105497_Layout) Velocity_Inquiry_S_S_Ns_Per_Lex_I_D_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748592_Layout) Ver_Inp_F_Names_Source_List_Sorted_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748592_Layout) Ver_Inp_F_Names_Source_List_Sorted_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748607_Layout) Ver_Inp_L_Names_Source_List_Sorted_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748607_Layout) Ver_Inp_L_Names_Source_List_Sorted_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST1069978_Layout) Ver_S_S_N_Source_List_Sorted_F_C_R_A_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST1069978_Layout) Ver_S_S_N_Source_List_Sorted_Non_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST106634_Layout) Ver_Source_List_;
    KEL.typ.ndataset(B_Person_3(__in,__cfg_Local).__ST106654_Layout) Ver_Source_List_Sorted_;
    KEL.typ.ndataset(B_Person_1(__in,__cfg_Local).__ST135056_Layout) Ver_Source_List_Sorted_F_C_R_A_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg_Local).__ST107562_Layout) Verified_First_Name_Sources_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748592_Layout) Verified_First_Name_Sources_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748592_Layout) Verified_First_Name_Sources_With_Dates_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg_Local).__ST107724_Layout) Verified_Last_Name_Sources_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748607_Layout) Verified_Last_Name_Sources_F_C_R_A_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg_Local).__ST748607_Layout) Verified_Last_Name_Sources_With_Dates_;
    KEL.typ.ndataset(E_Household(__in,__cfg_Local).Layout) Verson_One_House_Holds_;
    KEL.typ.nkdate Watercraft_Build_Current_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC12182361(B_Input_P_I_I(__in,__cfg_Local).__ST167260_Layout __EE12178985, B_Person(__in,__cfg_Local).__ST182183_Layout __EE12178988) := __EEQP(__EE12178985.Subject_,__EE12178988.UID);
  __ST5442146_Layout __JT12182361(B_Input_P_I_I(__in,__cfg_Local).__ST167260_Layout __l, B_Person(__in,__cfg_Local).__ST182183_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Addr_Pre_Dir__1_ := __r.P___Inp_Cln_Addr_Pre_Dir_;
    SELF.P___Inp_Cln_Addr_Prim_Name__1_ := __r.P___Inp_Cln_Addr_Prim_Name_;
    SELF.P___Inp_Cln_Addr_Prim_Rng__1_ := __r.P___Inp_Cln_Addr_Prim_Rng_;
    SELF.P___Inp_Cln_Addr_Sec_Rng__1_ := __r.P___Inp_Cln_Addr_Sec_Rng_;
    SELF.P___Inp_Cln_Addr_Sffx__1_ := __r.P___Inp_Cln_Addr_Sffx_;
    SELF.P___Inp_Cln_Addr_Zip5__1_ := __r.P___Inp_Cln_Addr_Zip5_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF.P___Inp_Cln_Name_First__1_ := __r.P___Inp_Cln_Name_First_;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_Phone_Home__1_ := __r.P___Inp_Cln_Phone_Home_;
    SELF.P___Inp_Cln_S_S_N__1_ := __r.P___Inp_Cln_S_S_N_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE12182362 := JOIN(__EE12178988,__EE12178985,__JC12182361(RIGHT,LEFT),__JT12182361(RIGHT,LEFT),RIGHT OUTER,HASH);
  SHARED __ST132826_Layout := RECORD
    KEL.typ.nuid G___Proc_U_I_D_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.str P___Inp_Acct_Flag_ := '';
    KEL.typ.str P___Inp_Lex_I_D_Flag_ := '';
    KEL.typ.str P___Inp_Name_First_Flag_ := '';
    KEL.typ.str P___Inp_Name_Mid_Flag_ := '';
    KEL.typ.str P___Inp_Name_Last_Flag_ := '';
    KEL.typ.str P___Inp_Addr_St_Flag_ := '';
    KEL.typ.str P___Inp_Addr_City_Flag_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_ := '';
    KEL.typ.str P___Inp_S_S_N_Flag_ := '';
    KEL.typ.str P___Inp_D_O_B_Flag_ := '';
    KEL.typ.str P___Inp_D_L_Flag_ := '';
    KEL.typ.str P___Inp_D_L_State_Flag_ := '';
    KEL.typ.str P___Inp_Phone_Home_Flag_ := '';
    KEL.typ.str P___Inp_Phone_Work_Flag_ := '';
    KEL.typ.str P___Inp_Email_Flag_ := '';
    KEL.typ.str P___Inp_I_P_Addr_Flag_ := '';
    KEL.typ.str P___Inp_Arch_Dt_Flag_ := '';
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_;
    KEL.typ.nstr P___Inp_Cln_Addr_Full_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nint P___Inp_Cln_Addr_Loc_I_D_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.nstr P___Inp_Cln_Arch_Dt_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_Flag_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Flag_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_Flag_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Flag_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_Flag_;
    KEL.typ.int P___Inp_Val_Addr_Zip_Bad_Len_Flag_ := 0;
    KEL.typ.nint P___Inp_Val_Addr_Zip_All_Zero_Flag_;
    KEL.typ.nint P___Inp_Val_Addr_State_Bad_Abbr_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Full_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_Flag_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_Flag_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_Flag_;
    KEL.typ.int P___Inp_Val_S_S_N_Bad_Char_Flag_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Bad_Len_Flag_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Bogus_Flag_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Non_S_S_A_Flag_ := 0;
    KEL.typ.int P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_ := 0;
    KEL.typ.str P___Inp_S_S_N_Is4_Digits_ := '';
    KEL.typ.nstr P___Inp_Cln_D_O_B_Flag_;
    KEL.typ.nstr P___Inp_Cln_D_L_Flag_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_Flag_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_Flag_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_Flag_;
    KEL.typ.nstr P___Inp_Cln_Email_Flag_;
    KEL.typ.nstr P___Inp_Cln_I_P_Addr_Flag_;
    KEL.typ.nint P___Inp_Val_Email_Bogus_Flag_;
    KEL.typ.nint P___Inp_Val_Email_User_All_Zero_Flag_;
    KEL.typ.nint P___Inp_Val_Email_User_Bad_Char_Flag_;
    KEL.typ.nint P___Inp_Val_Email_Dom_All_Zero_Flag_;
    KEL.typ.nint P___Inp_Val_Email_Dom_Bad_Char_Flag_;
    KEL.typ.nstr P___Inp_Cln_Email_User_;
    KEL.typ.nstr P___Inp_Cln_Email_Dom_;
    KEL.typ.nstr P___Inp_Cln_Email_Ext_;
    KEL.typ.nstr P___Inp_Cln_I_P_Addr_;
    KEL.typ.str P___Inp_Cln_Arch_Dt_Flag_ := '';
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.int P___Inp_Val_Phone_Home_Bad_Char_Flag_ := 0;
    KEL.typ.nint P___Inp_Val_Phone_Home_Bad_Len_Flag_;
    KEL.typ.int P___Inp_Val_Phone_Home_Bogus_Flag_ := 0;
    KEL.typ.int P___Inp_Val_Phone_Work_Bad_Char_Flag_ := 0;
    KEL.typ.nint P___Inp_Val_Phone_Work_Bad_Len_Flag_;
    KEL.typ.int P___Inp_Val_Phone_Work_Bogus_Flag_ := 0;
    KEL.typ.nstr P___Inp_Val_Name_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_Addr_St_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_Phone_Home_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_Phone_Work_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_S_S_N_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_D_L_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_D_L_State_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_D_O_B_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_Email_Invalid_Flag_;
    KEL.typ.nstr P___Inp_Val_Arch_Dt_Invalid_Flag_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Val_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Val_A1_Y_;
    KEL.typ.nfloat P_I___Inp_Addr_A_V_M_Ratio1_Y_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Val_A5_Y_;
    KEL.typ.nfloat P_I___Inp_Addr_A_V_M_Ratio5_Y_;
    KEL.typ.nint P_I___Inp_Addr_A_V_M_Conf_Score_;
    KEL.typ.int P_I___Inp_Addr_On_File_Flag_Ev_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Vacant_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Throwback_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Seasonal_Type_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_D_N_D_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_College_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_C_M_R_A_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Drop_Delivery_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_O_W_G_M_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Multi_Unit_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_Is_Apt_Flag_ := 0;
    KEL.typ.nint P_I___Inp_D_O_B_Age_;
    KEL.typ.int P_I___Inp_S_S_N_Is_Deceased_Flag_ := 0;
    KEL.typ.nint P_I___Inp_S_S_N_Deceased_Dt_;
    KEL.typ.int P_I___Inp_Addr_State_D_L_Avail_Flag_ := 0;
    KEL.typ.int P_I___Inp_Addr_State_Voter_Avail_Flag_ := 0;
    KEL.typ.nstr P_I___Inp_Phone_S_I_C_Code_H_R_List_;
    KEL.typ.nstr P_I___Inp_Phone_N_A_I_C_S_Code_H_R_List_;
    KEL.typ.str P_I___Inp_Phone_Is_H_R_Correct_Fac_Flag_ := '';
    KEL.typ.str P_I___Inp_Phone_Type_ := '';
    KEL.typ.str P_I___Inp_Phone_Is_Bus_Phone_Flag_ := '';
    KEL.typ.int P_I___Srch_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_L_Name_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Addr_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_D_O_B_Per_Inp_S_S_N_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_L_Name_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_S_S_N_Per_Inp_Addr_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Per_Inp_Email_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Email_Cnt1_Y_ := 0;
    KEL.typ.str P_I___Inp_Addr_Is_P_O_Box_Flag_ := '';
    KEL.typ.str P_I___Inp_Addr_Is_Military_Flag_ := '';
    KEL.typ.int P_I___Srch_Per_Inp_Phone_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Phone_Cnt1_Y_ := 0;
    KEL.typ.nstr P_I___Inp_Addr_Old_Dt_;
    KEL.typ.nstr P_I___Inp_Addr_New_Dt_;
    KEL.typ.int P_I___Inp_Addr_Subj_Flag_ := 0;
    KEL.typ.nstr P_I___Inp_Addr_Subj_Old_Dt_;
    KEL.typ.nstr P_I___Inp_Addr_Subj_New_Dt_;
    KEL.typ.nint P_I___Inp_Addr_Subj_Old_Msnc_;
    KEL.typ.nint P_I___Inp_Addr_Subj_New_Msnc_;
    KEL.typ.nint P_I___Inp_Addr_Subj_Res_Span_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nstr I_Paddr_;
    KEL.typ.nstr I_Presponse_;
    KEL.typ.nint Net_Acuity_Royalty_;
    KEL.typ.nstr P_I___Alrt_Inp_Name_Watchlist_Rec_Num_;
    KEL.typ.nstr P_I___Alrt_Inp_Name_On_Watchlist_Flag_;
    KEL.typ.nstr Targus_Royalty_;
    KEL.typ.nstr Targus_Src_;
    KEL.typ.nstr Ins_Phone_Hit_;
    KEL.typ.nstr Ins_Phone_Src_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST132826_Layout __ND12187874__Project(__ST5442146_Layout __PP12178998) := TRANSFORM
    SELF.G___Proc_U_I_D_ := __PP12178998.UID;
    SELF.P___Inp_Acct_ := __PP12178998.Input_Account_Value_;
    SELF.P___Inp_Lex_I_D_ := __PP12178998.Input_Lex_I_D_Value_;
    SELF.P___Inp_Name_First_ := __PP12178998.Input_First_Name_Value_;
    SELF.P___Inp_Name_Mid_ := __PP12178998.Input_Middle_Name_Value_;
    SELF.P___Inp_Name_Last_ := __PP12178998.Input_Last_Name_Value_;
    SELF.P___Inp_Addr_Line1_ := __PP12178998.Input_Street_Value_;
    SELF.P___Inp_Addr_Line2_ := __PP12178998.P___Inp_Addr_Line2_Value_;
    SELF.P___Inp_Addr_City_ := __PP12178998.Input_City_Value_;
    SELF.P___Inp_Addr_State_ := __PP12178998.Input_State_Value_;
    SELF.P___Inp_Addr_Zip_ := __PP12178998.Input_Zip_Value_;
    SELF.P___Inp_S_S_N_ := __PP12178998.Input_S_S_N_Value_;
    SELF.P___Inp_D_O_B_ := __PP12178998.Input_D_O_B_Value_;
    SELF.P___Inp_D_L_ := __PP12178998.Input_D_L_Value_;
    SELF.P___Inp_D_L_State_ := __PP12178998.Input_D_L_State_Value_;
    SELF.P___Inp_Phone_Home_ := __PP12178998.Input_Home_Phone_Value_;
    SELF.P___Inp_Phone_Work_ := __PP12178998.Input_Work_Phone_Value_;
    SELF.P___Inp_Email_ := __PP12178998.Input_Email_Value_;
    SELF.P___Inp_I_P_Addr_ := __PP12178998.Input_I_P_Addr_Value_;
    SELF.P___Inp_Arch_Dt_ := __PP12178998.Input_Archive_Date_Value_;
    SELF.P___Inp_Acct_Flag_ := __PP12178998.P___Inp_Acct_Flag_Value_;
    SELF.P___Inp_Lex_I_D_Flag_ := __PP12178998.P___Inp_Lex_I_D_Flag_Value_;
    SELF.P___Inp_Name_First_Flag_ := __PP12178998.P___Inp_Name_First_Flag_Value_;
    SELF.P___Inp_Name_Mid_Flag_ := __PP12178998.P___Inp_Name_Mid_Flag_Value_;
    SELF.P___Inp_Name_Last_Flag_ := __PP12178998.P___Inp_Name_Last_Flag_Value_;
    SELF.P___Inp_Addr_St_Flag_ := __PP12178998.P___Inp_Addr_St_Flag_Value_;
    SELF.P___Inp_Addr_City_Flag_ := __PP12178998.P___Inp_Addr_City_Flag_Value_;
    SELF.P___Inp_Addr_State_Flag_ := __PP12178998.P___Inp_Addr_State_Flag_Value_;
    SELF.P___Inp_Addr_Zip_Flag_ := __PP12178998.P___Inp_Addr_Zip_Flag_Value_;
    SELF.P___Inp_S_S_N_Flag_ := __PP12178998.P___Inp_S_S_N_Flag_Value_;
    SELF.P___Inp_D_O_B_Flag_ := __PP12178998.P___Inp_D_O_B_Flag_Value_;
    SELF.P___Inp_D_L_Flag_ := __PP12178998.P___Inp_D_L_Flag_Value_;
    SELF.P___Inp_D_L_State_Flag_ := __PP12178998.P___Inp_D_L_State_Flag_Value_;
    SELF.P___Inp_Phone_Home_Flag_ := __PP12178998.P___Inp_Phone_Home_Flag_Value_;
    SELF.P___Inp_Phone_Work_Flag_ := __PP12178998.P___Inp_Phone_Work_Flag_Value_;
    SELF.P___Inp_Email_Flag_ := __PP12178998.P___Inp_Email_Flag_Value_;
    SELF.P___Inp_I_P_Addr_Flag_ := __PP12178998.P___Inp_I_P_Addr_Flag_Value_;
    SELF.P___Inp_Arch_Dt_Flag_ := __PP12178998.P___Inp_Arch_Dt_Flag_Value_;
    SELF.P___Inp_Cln_Name_Prfx_ := __PP12178998.Input_Prefix_Clean_Value_;
    SELF.P___Inp_Cln_Name_First_ := __PP12178998.Input_First_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Mid_ := __PP12178998.Input_Middle_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Last_ := __PP12178998.Input_Last_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Sffx_ := __PP12178998.Input_Suffix_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_ := __PP12178998.Input_Primary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Pre_Dir_ := __PP12178998.Input_Pre_Direction_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Name_ := __PP12178998.Input_Primary_Name_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Sffx_ := __PP12178998.Input_Address_Suffix_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Post_Dir_ := __PP12178998.Input_Post_Direction_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Unit_Desig_ := __PP12178998.Input_Unit_Desig_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Sec_Rng_ := __PP12178998.Input_Secondary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_City_ := __PP12178998.Input_City_Clean_Value_;
    SELF.P___Inp_Cln_Addr_City_Post_ := __PP12178998.Input_City_Post_Clean_Value_;
    SELF.P___Inp_Cln_Addr_State_ := __PP12178998.Input_State_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_ := __PP12178998.Input_Zip5_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip4_ := __PP12178998.Input_Zip4_Clean_Value_;
    SELF.P___Inp_Cln_Addr_St_ := __PP12178998.Input_Street_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Full_ := __PP12178998.Input_Full_Address_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Lat_ := __PP12178998.Input_Latitude_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Lng_ := __PP12178998.Input_Longitude_Clean_Value_;
    SELF.P___Inp_Cln_Addr_State_Code_ := __PP12178998.Input_State_Code_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Cnty_ := __PP12178998.Input_County_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Geo_ := __PP12178998.Input_Geoblock_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Type_ := __PP12178998.Input_Address_Type_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Status_ := __PP12178998.Input_Address_Status_Clean_Value_;
    SELF.P___Inp_Cln_S_S_N_ := __PP12178998.Input_S_S_N_Clean_Value_;
    SELF.P___Inp_Cln_D_O_B_ := __PP12178998.Input_D_O_B_Clean_Value_;
    SELF.P___Inp_Cln_D_L_ := __PP12178998.Input_D_L_Clean_Value_;
    SELF.P___Inp_Cln_D_L_State_ := __PP12178998.Input_D_L_State_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Home_ := __PP12178998.Input_Home_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Work_ := __PP12178998.Input_Work_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Email_ := __PP12178998.Input_Email_Clean_Value_;
    SELF.P___Inp_Cln_Arch_Dt_ := __PP12178998.Input_Archive_Date_Clean_Value_;
    SELF.P___Inp_Cln_Name_Prfx_Flag_ := __PP12178998.P___Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.P___Inp_Cln_Name_First_Flag_ := __PP12178998.P___Inp_Cln_Name_First_Flag_Value_;
    SELF.P___Inp_Cln_Name_Mid_Flag_ := __PP12178998.P___Inp_Cln_Name_Mid_Flag_Value_;
    SELF.P___Inp_Cln_Name_Last_Flag_ := __PP12178998.P___Inp_Cln_Name_Last_Flag_Value_;
    SELF.P___Inp_Cln_Name_Sffx_Flag_ := __PP12178998.P___Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_Flag_ := __PP12178998.P___Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Pre_Dir_Flag_ := __PP12178998.P___Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Name_Flag_ := __PP12178998.P___Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Sffx_Flag_ := __PP12178998.P___Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Post_Dir_Flag_ := __PP12178998.P___Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Unit_Desig_Flag_ := __PP12178998.P___Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Sec_Rng_Flag_ := __PP12178998.P___Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_City_Flag_ := __PP12178998.P___Inp_Cln_Addr_City_Flag_Value_;
    SELF.P___Inp_Cln_Addr_City_Post_Flag_ := __PP12178998.P___Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.P___Inp_Cln_Addr_State_Flag_ := __PP12178998.P___Inp_Cln_Addr_State_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_Flag_ := __PP12178998.P___Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Zip4_Flag_ := __PP12178998.P___Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.P___Inp_Val_Addr_Zip_Bad_Len_Flag_ := __PP12178998.P___Inp_Val_Addr_Zip_Bad_Len_Flag_Value_;
    SELF.P___Inp_Val_Addr_Zip_All_Zero_Flag_ := __PP12178998.P___Inp_Val_Addr_Zip_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Addr_State_Bad_Abbr_Flag_ := __PP12178998.P___Inp_Val_Addr_State_Bad_Abbr_Flag_Value_;
    SELF.P___Inp_Cln_Addr_St_Flag_ := __PP12178998.P___Inp_Cln_Addr_St_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Full_Flag_ := __PP12178998.P___Inp_Cln_Addr_Full_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Lat_Flag_ := __PP12178998.P___Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Lng_Flag_ := __PP12178998.P___Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Cnty_Flag_ := __PP12178998.P___Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Geo_Flag_ := __PP12178998.P___Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Type_Flag_ := __PP12178998.P___Inp_Cln_Addr_Type_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Status_Flag_ := __PP12178998.P___Inp_Cln_Addr_Status_Flag_Value_;
    SELF.P___Inp_Cln_S_S_N_Flag_ := __PP12178998.P___Inp_Cln_S_S_N_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bad_Char_Flag_ := __PP12178998.P___Inp_Val_S_S_N_Bad_Char_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bad_Len_Flag_ := __PP12178998.P___Inp_Val_S_S_N_Bad_Len_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bogus_Flag_ := __PP12178998.P___Inp_Val_S_S_N_Bogus_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Non_S_S_A_Flag_ := __PP12178998.P___Inp_Val_S_S_N_Non_S_S_A_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_ := __PP12178998.P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_Value_;
    SELF.P___Inp_Cln_D_O_B_Flag_ := __PP12178998.P___Inp_Cln_D_O_B_Flag_Value_;
    SELF.P___Inp_Cln_D_L_Flag_ := __PP12178998.P___Inp_Cln_D_L_Flag_Value_;
    SELF.P___Inp_Cln_D_L_State_Flag_ := __PP12178998.P___Inp_Cln_D_L_State_Flag_Value_;
    SELF.P___Inp_Cln_Phone_Home_Flag_ := __PP12178998.P___Inp_Cln_Phone_Home_Flag_Value_;
    SELF.P___Inp_Cln_Phone_Work_Flag_ := __PP12178998.P___Inp_Cln_Phone_Work_Flag_Value_;
    SELF.P___Inp_Cln_Email_Flag_ := __PP12178998.P___Inp_Cln_Email_Flag_Value_;
    SELF.P___Inp_Cln_I_P_Addr_Flag_ := __PP12178998.P___Inp_Cln_I_P_Addr_Flag_Value_;
    SELF.P___Inp_Val_Email_Bogus_Flag_ := __PP12178998.P___Inp_Val_Email_Bogus_Flag_Value_;
    SELF.P___Inp_Val_Email_User_All_Zero_Flag_ := __PP12178998.P___Inp_Val_Email_User_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Email_User_Bad_Char_Flag_ := __PP12178998.P___Inp_Val_Email_User_Bad_Char_Flag_Value_;
    SELF.P___Inp_Val_Email_Dom_All_Zero_Flag_ := __PP12178998.P___Inp_Val_Email_Dom_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Email_Dom_Bad_Char_Flag_ := __PP12178998.P___Inp_Val_Email_Dom_Bad_Char_Flag_Value_;
    SELF.P___Inp_Cln_Arch_Dt_Flag_ := __PP12178998.P___Inp_Cln_Arch_Dt_Flag_Value_;
    SELF.P_I___Inp_Addr_State_D_L_Avail_Flag_ := __PP12178998.P_I___Inp_Addr_State_D_L_Avail_Flag___Non_F_C_R_A_;
    SELF.P_I___Inp_Addr_State_Voter_Avail_Flag_ := IF(__PisFCRA,__PP12178998.P_I___Inp_Addr_State_Voter_Avail_Flag___F_C_R_A_,__PP12178998.P_I___Inp_Addr_State_Voter_Avail_Flag___Non_F_C_R_A_);
    __CC13567 := -99999;
    SELF.P_I___Inp_Addr_Subj_Flag_ := IF(__PisFCRA AND __PP12178998.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13567,__PP12178998.P_I___Inp_Addr_Subj_Flag_);
    __CC13564 := '-99999';
    SELF.P_I___Inp_Addr_Subj_Old_Dt_ := IF(__PisFCRA AND __PP12178998.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC13564)),__ECAST(KEL.typ.nstr,__PP12178998.P_I___Inp_Addr_Subj_Old_Dt_));
    SELF.P_I___Inp_Addr_Subj_New_Dt_ := IF(__PisFCRA AND __PP12178998.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC13564)),__ECAST(KEL.typ.nstr,__PP12178998.P_I___Inp_Addr_Subj_New_Dt_));
    SELF.P_I___Inp_Addr_Subj_Old_Msnc_ := IF(__PisFCRA AND __PP12178998.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13567)),__ECAST(KEL.typ.nint,__PP12178998.P_I___Inp_Addr_Subj_Old_Msnc_));
    SELF.P_I___Inp_Addr_Subj_New_Msnc_ := IF(__PisFCRA AND __PP12178998.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13567)),__ECAST(KEL.typ.nint,__PP12178998.P_I___Inp_Addr_Subj_New_Msnc_));
    SELF.P_I___Inp_Addr_Subj_Res_Span_ := IF(__PisFCRA AND __PP12178998.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13567)),__ECAST(KEL.typ.nint,__PP12178998.P_I___Inp_Addr_Subj_Res_Span_));
    SELF.Rep_Number_ := __PP12178998.I_Rep_Number_Value_;
    SELF.I_Paddr_ := __PP12178998._ipaddr_;
    SELF.I_Presponse_ := __PP12178998._ipresponse_;
    SELF.Net_Acuity_Royalty_ := __PP12178998._netacuityroyalty_;
    SELF := __PP12178998;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE12182362,__ND12187874__Project(LEFT)));
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
  EXPORT DBG_E_Input_P_I_I_Intermediate_10 := __UNWRAP(B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10);
  EXPORT DBG_E_Inquiry_Intermediate_10 := __UNWRAP(B_Inquiry_10_Local.__ENH_Inquiry_10);
  EXPORT DBG_E_Person_Intermediate_10 := __UNWRAP(B_Person_10_Local.__ENH_Person_10);
  EXPORT DBG_E_Input_P_I_I_Intermediate_9 := __UNWRAP(B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9);
  EXPORT DBG_E_Inquiry_Intermediate_9 := __UNWRAP(B_Inquiry_9_Local.__ENH_Inquiry_9);
  EXPORT DBG_E_Person_Intermediate_9 := __UNWRAP(B_Person_9_Local.__ENH_Person_9);
  EXPORT DBG_E_Bankruptcy_Intermediate_8 := __UNWRAP(B_Bankruptcy_8_Local.__ENH_Bankruptcy_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Inquiry_Intermediate_8 := __UNWRAP(B_Inquiry_8_Local.__ENH_Inquiry_8);
  EXPORT DBG_E_Person_Intermediate_8 := __UNWRAP(B_Person_8_Local.__ENH_Person_8);
  EXPORT DBG_E_Person_Accident_Intermediate_8 := __UNWRAP(B_Person_Accident_8_Local.__ENH_Person_Accident_8);
  EXPORT DBG_E_Person_Inquiry_Intermediate_8 := __UNWRAP(B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8);
  EXPORT DBG_E_Person_Property_Intermediate_8 := __UNWRAP(B_Person_Property_8_Local.__ENH_Person_Property_8);
  EXPORT DBG_E_Property_Event_Intermediate_8 := __UNWRAP(B_Property_Event_8_Local.__ENH_Property_Event_8);
  EXPORT DBG_E_Bankruptcy_Intermediate_7 := __UNWRAP(B_Bankruptcy_7_Local.__ENH_Bankruptcy_7);
  EXPORT DBG_E_Criminal_Offense_Intermediate_7 := __UNWRAP(B_Criminal_Offense_7_Local.__ENH_Criminal_Offense_7);
  EXPORT DBG_E_Education_Intermediate_7 := __UNWRAP(B_Education_7_Local.__ENH_Education_7);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Inquiry_Intermediate_7 := __UNWRAP(B_Inquiry_7_Local.__ENH_Inquiry_7);
  EXPORT DBG_E_Person_Intermediate_7 := __UNWRAP(B_Person_7_Local.__ENH_Person_7);
  EXPORT DBG_E_Person_Inquiry_Intermediate_7 := __UNWRAP(B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7);
  EXPORT DBG_E_Person_Property_Intermediate_7 := __UNWRAP(B_Person_Property_7_Local.__ENH_Person_Property_7);
  EXPORT DBG_E_Property_Event_Intermediate_7 := __UNWRAP(B_Property_Event_7_Local.__ENH_Property_Event_7);
  EXPORT DBG_E_Sele_Person_Intermediate_7 := __UNWRAP(B_Sele_Person_7_Local.__ENH_Sele_Person_7);
  EXPORT DBG_E_Address_Intermediate_6 := __UNWRAP(B_Address_6_Local.__ENH_Address_6);
  EXPORT DBG_E_Bankruptcy_Intermediate_6 := __UNWRAP(B_Bankruptcy_6_Local.__ENH_Bankruptcy_6);
  EXPORT DBG_E_Criminal_Offense_Intermediate_6 := __UNWRAP(B_Criminal_Offense_6_Local.__ENH_Criminal_Offense_6);
  EXPORT DBG_E_Education_Intermediate_6 := __UNWRAP(B_Education_6_Local.__ENH_Education_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Inquiry_Intermediate_6 := __UNWRAP(B_Inquiry_6_Local.__ENH_Inquiry_6);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local.__ENH_Person_6);
  EXPORT DBG_E_Person_Inquiry_Intermediate_6 := __UNWRAP(B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6);
  EXPORT DBG_E_Person_Property_Intermediate_6 := __UNWRAP(B_Person_Property_6_Local.__ENH_Person_Property_6);
  EXPORT DBG_E_Person_S_S_N_Intermediate_6 := __UNWRAP(B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6);
  EXPORT DBG_E_Property_Event_Intermediate_6 := __UNWRAP(B_Property_Event_6_Local.__ENH_Property_Event_6);
  EXPORT DBG_E_Sele_Person_Intermediate_6 := __UNWRAP(B_Sele_Person_6_Local.__ENH_Sele_Person_6);
  EXPORT DBG_E_Address_Intermediate_5 := __UNWRAP(B_Address_5_Local.__ENH_Address_5);
  EXPORT DBG_E_Bankruptcy_Intermediate_5 := __UNWRAP(B_Bankruptcy_5_Local.__ENH_Bankruptcy_5);
  EXPORT DBG_E_Criminal_Offense_Intermediate_5 := __UNWRAP(B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5);
  EXPORT DBG_E_Education_Intermediate_5 := __UNWRAP(B_Education_5_Local.__ENH_Education_5);
  EXPORT DBG_E_First_Degree_Relative_Intermediate_5 := __UNWRAP(B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5);
  EXPORT DBG_E_Input_P_I_I_Intermediate_5 := __UNWRAP(B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5);
  EXPORT DBG_E_Inquiry_Intermediate_5 := __UNWRAP(B_Inquiry_5_Local.__ENH_Inquiry_5);
  EXPORT DBG_E_Person_Intermediate_5 := __UNWRAP(B_Person_5_Local.__ENH_Person_5);
  EXPORT DBG_E_Person_Inquiry_Intermediate_5 := __UNWRAP(B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5);
  EXPORT DBG_E_Person_Property_Intermediate_5 := __UNWRAP(B_Person_Property_5_Local.__ENH_Person_Property_5);
  EXPORT DBG_E_Person_S_S_N_Intermediate_5 := __UNWRAP(B_Person_S_S_N_5_Local.__ENH_Person_S_S_N_5);
  EXPORT DBG_E_Professional_License_Intermediate_5 := __UNWRAP(B_Professional_License_5_Local.__ENH_Professional_License_5);
  EXPORT DBG_E_Property_Intermediate_5 := __UNWRAP(B_Property_5_Local.__ENH_Property_5);
  EXPORT DBG_E_Property_Event_Intermediate_5 := __UNWRAP(B_Property_Event_5_Local.__ENH_Property_Event_5);
  EXPORT DBG_E_Sele_Person_Intermediate_5 := __UNWRAP(B_Sele_Person_5_Local.__ENH_Sele_Person_5);
  EXPORT DBG_E_Address_Intermediate_4 := __UNWRAP(B_Address_4_Local.__ENH_Address_4);
  EXPORT DBG_E_Bankruptcy_Intermediate_4 := __UNWRAP(B_Bankruptcy_4_Local.__ENH_Bankruptcy_4);
  EXPORT DBG_E_Criminal_Offense_Intermediate_4 := __UNWRAP(B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4);
  EXPORT DBG_E_Education_Intermediate_4 := __UNWRAP(B_Education_4_Local.__ENH_Education_4);
  EXPORT DBG_E_Input_P_I_I_Intermediate_4 := __UNWRAP(B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4);
  EXPORT DBG_E_Inquiry_Intermediate_4 := __UNWRAP(B_Inquiry_4_Local.__ENH_Inquiry_4);
  EXPORT DBG_E_Person_Intermediate_4 := __UNWRAP(B_Person_4_Local.__ENH_Person_4);
  EXPORT DBG_E_Person_Inquiry_Intermediate_4 := __UNWRAP(B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4);
  EXPORT DBG_E_Person_Property_Intermediate_4 := __UNWRAP(B_Person_Property_4_Local.__ENH_Person_Property_4);
  EXPORT DBG_E_Person_S_S_N_Intermediate_4 := __UNWRAP(B_Person_S_S_N_4_Local.__ENH_Person_S_S_N_4);
  EXPORT DBG_E_Professional_License_Intermediate_4 := __UNWRAP(B_Professional_License_4_Local.__ENH_Professional_License_4);
  EXPORT DBG_E_Property_Intermediate_4 := __UNWRAP(B_Property_4_Local.__ENH_Property_4);
  EXPORT DBG_E_Property_Event_Intermediate_4 := __UNWRAP(B_Property_Event_4_Local.__ENH_Property_Event_4);
  EXPORT DBG_E_Sele_Person_Intermediate_4 := __UNWRAP(B_Sele_Person_4_Local.__ENH_Sele_Person_4);
  EXPORT DBG_E_Address_Intermediate_3 := __UNWRAP(B_Address_3_Local.__ENH_Address_3);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_3 := __UNWRAP(B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3);
  EXPORT DBG_E_Bankruptcy_Intermediate_3 := __UNWRAP(B_Bankruptcy_3_Local.__ENH_Bankruptcy_3);
  EXPORT DBG_E_Criminal_Offense_Intermediate_3 := __UNWRAP(B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3);
  EXPORT DBG_E_Education_Intermediate_3 := __UNWRAP(B_Education_3_Local.__ENH_Education_3);
  EXPORT DBG_E_Email_Intermediate_3 := __UNWRAP(B_Email_3_Local.__ENH_Email_3);
  EXPORT DBG_E_Input_P_I_I_Intermediate_3 := __UNWRAP(B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3);
  EXPORT DBG_E_Inquiry_Intermediate_3 := __UNWRAP(B_Inquiry_3_Local.__ENH_Inquiry_3);
  EXPORT DBG_E_Person_Intermediate_3 := __UNWRAP(B_Person_3_Local.__ENH_Person_3);
  EXPORT DBG_E_Person_Address_Intermediate_3 := __UNWRAP(B_Person_Address_3_Local.__ENH_Person_Address_3);
  EXPORT DBG_E_Person_Inquiry_Intermediate_3 := __UNWRAP(B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3);
  EXPORT DBG_E_Person_Property_Intermediate_3 := __UNWRAP(B_Person_Property_3_Local.__ENH_Person_Property_3);
  EXPORT DBG_E_Person_S_S_N_Intermediate_3 := __UNWRAP(B_Person_S_S_N_3_Local.__ENH_Person_S_S_N_3);
  EXPORT DBG_E_Person_Vehicle_Intermediate_3 := __UNWRAP(B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3);
  EXPORT DBG_E_Professional_License_Intermediate_3 := __UNWRAP(B_Professional_License_3_Local.__ENH_Professional_License_3);
  EXPORT DBG_E_Property_Intermediate_3 := __UNWRAP(B_Property_3_Local.__ENH_Property_3);
  EXPORT DBG_E_Property_Event_Intermediate_3 := __UNWRAP(B_Property_Event_3_Local.__ENH_Property_Event_3);
  EXPORT DBG_E_Sele_Person_Intermediate_3 := __UNWRAP(B_Sele_Person_3_Local.__ENH_Sele_Person_3);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_3 := __UNWRAP(B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3);
  EXPORT DBG_E_Address_Intermediate_2 := __UNWRAP(B_Address_2_Local.__ENH_Address_2);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_2 := __UNWRAP(B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2);
  EXPORT DBG_E_Bankruptcy_Intermediate_2 := __UNWRAP(B_Bankruptcy_2_Local.__ENH_Bankruptcy_2);
  EXPORT DBG_E_Criminal_Offense_Intermediate_2 := __UNWRAP(B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2);
  EXPORT DBG_E_Education_Intermediate_2 := __UNWRAP(B_Education_2_Local.__ENH_Education_2);
  EXPORT DBG_E_Email_Intermediate_2 := __UNWRAP(B_Email_2_Local.__ENH_Email_2);
  EXPORT DBG_E_Input_P_I_I_Intermediate_2 := __UNWRAP(B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local.__ENH_Person_2);
  EXPORT DBG_E_Person_Address_Intermediate_2 := __UNWRAP(B_Person_Address_2_Local.__ENH_Person_Address_2);
  EXPORT DBG_E_Person_Property_Intermediate_2 := __UNWRAP(B_Person_Property_2_Local.__ENH_Person_Property_2);
  EXPORT DBG_E_Person_S_S_N_Intermediate_2 := __UNWRAP(B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2);
  EXPORT DBG_E_Person_Vehicle_Intermediate_2 := __UNWRAP(B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2);
  EXPORT DBG_E_Professional_License_Intermediate_2 := __UNWRAP(B_Professional_License_2_Local.__ENH_Professional_License_2);
  EXPORT DBG_E_Property_Intermediate_2 := __UNWRAP(B_Property_2_Local.__ENH_Property_2);
  EXPORT DBG_E_Property_Event_Intermediate_2 := __UNWRAP(B_Property_Event_2_Local.__ENH_Property_Event_2);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_2 := __UNWRAP(B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2);
  EXPORT DBG_E_Address_Intermediate_1 := __UNWRAP(B_Address_1_Local.__ENH_Address_1);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_1 := __UNWRAP(B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1);
  EXPORT DBG_E_Bankruptcy_Intermediate_1 := __UNWRAP(B_Bankruptcy_1_Local.__ENH_Bankruptcy_1);
  EXPORT DBG_E_Criminal_Offense_Intermediate_1 := __UNWRAP(B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1);
  EXPORT DBG_E_Education_Intermediate_1 := __UNWRAP(B_Education_1_Local.__ENH_Education_1);
  EXPORT DBG_E_Input_P_I_I_Intermediate_1 := __UNWRAP(B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1);
  EXPORT DBG_E_Person_Intermediate_1 := __UNWRAP(B_Person_1_Local.__ENH_Person_1);
  EXPORT DBG_E_Person_Property_Intermediate_1 := __UNWRAP(B_Person_Property_1_Local.__ENH_Person_Property_1);
  EXPORT DBG_E_Person_S_S_N_Intermediate_1 := __UNWRAP(B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1);
  EXPORT DBG_E_Person_Vehicle_Intermediate_1 := __UNWRAP(B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1);
  EXPORT DBG_E_Professional_License_Intermediate_1 := __UNWRAP(B_Professional_License_1_Local.__ENH_Professional_License_1);
  EXPORT DBG_E_Property_Event_Intermediate_1 := __UNWRAP(B_Property_Event_1_Local.__ENH_Property_Event_1);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_1 := __UNWRAP(B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1);
  EXPORT DBG_E_Input_P_I_I_Annotated := __UNWRAP(B_Input_P_I_I_Local.__ENH_Input_P_I_I);
  EXPORT DBG_E_Person_Annotated := __UNWRAP(B_Person_Local.__ENH_Person);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_P_I_I_PreEntity_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Accident_Result,NAMED('DBG_E_Accident_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Result,NAMED('DBG_E_Address_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Inquiry_Result,NAMED('DBG_E_Address_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Property_Result,NAMED('DBG_E_Address_Property_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Aircraft_Owner_Result,NAMED('DBG_E_Aircraft_Owner_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Result,NAMED('DBG_E_Bankruptcy_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Result,NAMED('DBG_E_Criminal_Offense_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Result,NAMED('DBG_E_Education_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Email_Result,NAMED('DBG_E_Email_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Email_Inquiry_Result,NAMED('DBG_E_Email_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_First_Degree_Associations_Result,NAMED('DBG_E_First_Degree_Associations_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_First_Degree_Relative_Result,NAMED('DBG_E_First_Degree_Relative_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Household_Result,NAMED('DBG_E_Household_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Household_Member_Result,NAMED('DBG_E_Household_Member_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Lien_Judgment_Result,NAMED('DBG_E_Lien_Judgment_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Accident_Result,NAMED('DBG_E_Person_Accident_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Address_Result,NAMED('DBG_E_Person_Address_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Bankruptcy_Result,NAMED('DBG_E_Person_Bankruptcy_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Education_Result,NAMED('DBG_E_Person_Education_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Email_Result,NAMED('DBG_E_Person_Email_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Result,NAMED('DBG_E_Person_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Result,NAMED('DBG_E_Person_Lien_Judgment_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Offenses_Result,NAMED('DBG_E_Person_Offenses_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Result,NAMED('DBG_E_Person_Property_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Event_Result,NAMED('DBG_E_Person_Property_Event_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Result,NAMED('DBG_E_Person_S_S_N_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Vehicle_Result,NAMED('DBG_E_Person_Vehicle_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Phone_Result,NAMED('DBG_E_Phone_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Phone_Inquiry_Result,NAMED('DBG_E_Phone_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Result,NAMED('DBG_E_Professional_License_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Person_Result,NAMED('DBG_E_Professional_License_Person_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Result,NAMED('DBG_E_Property_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Result,NAMED('DBG_E_Property_Event_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_S_S_N_Inquiry_Result,NAMED('DBG_E_S_S_N_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Sele_Person_Result,NAMED('DBG_E_Sele_Person_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Social_Security_Number_Result,NAMED('DBG_E_Social_Security_Number_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Utility_Person_Result,NAMED('DBG_E_Utility_Person_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Watercraft_Owner_Result,NAMED('DBG_E_Watercraft_Owner_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Zip_Code_Result,NAMED('DBG_E_Zip_Code_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_13,NAMED('DBG_E_Lien_Judgment_Intermediate_13_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Person_Lien_Judgment_Intermediate_12_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_11,NAMED('DBG_E_Inquiry_Intermediate_11_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_11,NAMED('DBG_E_Person_Intermediate_11_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_10,NAMED('DBG_E_Input_P_I_I_Intermediate_10_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_10,NAMED('DBG_E_Inquiry_Intermediate_10_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_10,NAMED('DBG_E_Person_Intermediate_10_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_9,NAMED('DBG_E_Input_P_I_I_Intermediate_9_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_9,NAMED('DBG_E_Inquiry_Intermediate_9_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_9,NAMED('DBG_E_Person_Intermediate_9_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_8,NAMED('DBG_E_Bankruptcy_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_8,NAMED('DBG_E_Inquiry_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_8,NAMED('DBG_E_Person_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Accident_Intermediate_8,NAMED('DBG_E_Person_Accident_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_8,NAMED('DBG_E_Person_Inquiry_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_8,NAMED('DBG_E_Person_Property_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_8,NAMED('DBG_E_Property_Event_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_7,NAMED('DBG_E_Bankruptcy_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_7,NAMED('DBG_E_Criminal_Offense_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_7,NAMED('DBG_E_Education_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_7,NAMED('DBG_E_Inquiry_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_7,NAMED('DBG_E_Person_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_7,NAMED('DBG_E_Person_Inquiry_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_7,NAMED('DBG_E_Person_Property_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_7,NAMED('DBG_E_Property_Event_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_7,NAMED('DBG_E_Sele_Person_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_6,NAMED('DBG_E_Address_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_6,NAMED('DBG_E_Bankruptcy_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_6,NAMED('DBG_E_Criminal_Offense_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_6,NAMED('DBG_E_Education_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_6,NAMED('DBG_E_Inquiry_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_6,NAMED('DBG_E_Person_Inquiry_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_6,NAMED('DBG_E_Person_Property_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_6,NAMED('DBG_E_Person_S_S_N_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_6,NAMED('DBG_E_Property_Event_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_6,NAMED('DBG_E_Sele_Person_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_5,NAMED('DBG_E_Address_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_5,NAMED('DBG_E_Bankruptcy_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_5,NAMED('DBG_E_Criminal_Offense_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_5,NAMED('DBG_E_Education_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_First_Degree_Relative_Intermediate_5,NAMED('DBG_E_First_Degree_Relative_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_5,NAMED('DBG_E_Inquiry_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_5,NAMED('DBG_E_Person_Inquiry_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_5,NAMED('DBG_E_Person_Property_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_5,NAMED('DBG_E_Person_S_S_N_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Intermediate_5,NAMED('DBG_E_Professional_License_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Intermediate_5,NAMED('DBG_E_Property_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_5,NAMED('DBG_E_Property_Event_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_5,NAMED('DBG_E_Sele_Person_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_4,NAMED('DBG_E_Address_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_4,NAMED('DBG_E_Bankruptcy_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_4,NAMED('DBG_E_Criminal_Offense_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_4,NAMED('DBG_E_Education_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_4,NAMED('DBG_E_Inquiry_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_4,NAMED('DBG_E_Person_Inquiry_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_4,NAMED('DBG_E_Person_Property_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_4,NAMED('DBG_E_Person_S_S_N_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Intermediate_4,NAMED('DBG_E_Professional_License_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Intermediate_4,NAMED('DBG_E_Property_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_4,NAMED('DBG_E_Property_Event_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_4,NAMED('DBG_E_Sele_Person_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_3,NAMED('DBG_E_Address_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_3,NAMED('DBG_E_Aircraft_Owner_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_3,NAMED('DBG_E_Bankruptcy_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_3,NAMED('DBG_E_Criminal_Offense_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_3,NAMED('DBG_E_Education_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Email_Intermediate_3,NAMED('DBG_E_Email_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_3,NAMED('DBG_E_Inquiry_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Address_Intermediate_3,NAMED('DBG_E_Person_Address_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_3,NAMED('DBG_E_Person_Inquiry_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_3,NAMED('DBG_E_Person_Property_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_3,NAMED('DBG_E_Person_S_S_N_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_3,NAMED('DBG_E_Person_Vehicle_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Intermediate_3,NAMED('DBG_E_Professional_License_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Intermediate_3,NAMED('DBG_E_Property_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_3,NAMED('DBG_E_Property_Event_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Sele_Person_Intermediate_3,NAMED('DBG_E_Sele_Person_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_3,NAMED('DBG_E_Watercraft_Owner_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_2,NAMED('DBG_E_Address_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_2,NAMED('DBG_E_Aircraft_Owner_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_2,NAMED('DBG_E_Bankruptcy_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_2,NAMED('DBG_E_Criminal_Offense_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_2,NAMED('DBG_E_Education_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Email_Intermediate_2,NAMED('DBG_E_Email_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_2,NAMED('DBG_E_Input_P_I_I_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Address_Intermediate_2,NAMED('DBG_E_Person_Address_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_2,NAMED('DBG_E_Person_Property_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_2,NAMED('DBG_E_Person_S_S_N_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_2,NAMED('DBG_E_Person_Vehicle_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Intermediate_2,NAMED('DBG_E_Professional_License_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Intermediate_2,NAMED('DBG_E_Property_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_2,NAMED('DBG_E_Property_Event_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_2,NAMED('DBG_E_Watercraft_Owner_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_1,NAMED('DBG_E_Address_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_1,NAMED('DBG_E_Aircraft_Owner_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_1,NAMED('DBG_E_Bankruptcy_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_1,NAMED('DBG_E_Criminal_Offense_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Education_Intermediate_1,NAMED('DBG_E_Education_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_1,NAMED('DBG_E_Input_P_I_I_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Intermediate_1,NAMED('DBG_E_Person_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Property_Intermediate_1,NAMED('DBG_E_Person_Property_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_1,NAMED('DBG_E_Person_S_S_N_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Vehicle_Intermediate_1,NAMED('DBG_E_Person_Vehicle_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Professional_License_Intermediate_1,NAMED('DBG_E_Professional_License_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Event_Intermediate_1,NAMED('DBG_E_Property_Event_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_1,NAMED('DBG_E_Watercraft_Owner_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Annotated,NAMED('DBG_E_Input_P_I_I_Annotated_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Person_Annotated,NAMED('DBG_E_Person_Annotated_Q_Input_Attributes_V1_Hybrid'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
