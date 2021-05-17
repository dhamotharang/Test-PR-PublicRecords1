//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_2,B_Address_3,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Criminal_Offense_6,B_Criminal_Offense_7,B_Criminal_Offense_8,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_Education_8,B_Email_2,B_Email_3,B_Input_P_I_I_1,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Inquiry_4,B_Inquiry_5,B_Inquiry_6,B_Inquiry_7,B_Lien_Judgment_13,B_Person,B_Person_1,B_Person_10,B_Person_11,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_9,B_Person_Lien_Judgment_12,B_Person_Property_1,B_Person_Property_2,B_Person_Property_3,B_Person_Property_4,B_Person_Property_5,B_Person_Property_6,B_Person_Property_7,B_Person_Property_8,B_Person_S_S_N_4,B_Person_S_S_N_5,B_Person_S_S_N_6,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property_3,B_Property_Event_1,B_Property_Event_2,B_Property_Event_3,B_Property_Event_4,B_Property_Event_5,B_Property_Event_6,B_Property_Event_7,B_Property_Event_8,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Criminal_Offense,E_Education,E_Email,E_Geo_Link,E_Input_P_I_I,E_Inquiry,E_Lien_Judgment,E_Name_Summary,E_Person,E_Person_Address,E_Person_Bankruptcy,E_Person_Education,E_Person_Email,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offenses,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Phone,E_Phone_Summary,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Watercraft,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT Q_F_C_R_A_Person_Attributes_V1_Dynamic(KEL.typ.uid __PLexID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),p_lexid(OVERRIDE:Subject_:0|DEFAULT:P___Lex_I_D_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),p_inpclnsurname1(DEFAULT:P___Inp_Cln_Surname1_:\'\'),p_inpclnsurname2(DEFAULT:P___Inp_Cln_Surname2_:\'\'),Last_Name1_(DEFAULT:Last_Name1_:0),Last_Name2_(DEFAULT:Last_Name2_:0),addressgeolink(DEFAULT:Address_Geo_Link_:\'\'),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),Input_Clean_Email_(OVERRIDE:Input_Clean_Email_:0),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'|OVERRIDE:Input_Clean_Phone_:0|OVERRIDE:Telephone_Summary_:0),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'|OVERRIDE:Input_Clean_S_S_N_:0|OVERRIDE:Social_Summary_:0),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),Slim_Location_(DEFAULT:Slim_Location_:0),zip5(DEFAULT:Z_I_P5_:0),Name_Summ_(DEFAULT:Name_Summ_:0),Location_Summary_(DEFAULT:Location_Summary_:0),currentaddrprimrng(DEFAULT:Current_Addr_Prim_Rng_:\'\'),currentaddrpredir(DEFAULT:Current_Addr_Pre_Dir_:\'\'),currentaddrprimname(DEFAULT:Current_Addr_Prim_Name_:\'\'),currentaddrsffx(DEFAULT:Current_Addr_Sffx_:\'\'),currentaddrsecrng(DEFAULT:Current_Addr_Sec_Rng_:\'\'),currentaddrstate(DEFAULT:Current_Addr_State_:\'\'),currentaddrzip5(DEFAULT:Current_Addr_Zip5_:\'\'),currentaddrzip4(DEFAULT:Current_Addr_Zip4_:\'\'),currentaddrstatecode(DEFAULT:Current_Addr_State_Code_:\'\'),currentaddrcnty(DEFAULT:Current_Addr_Cnty_:\'\'),currentaddrgeo(DEFAULT:Current_Addr_Geo_:\'\'),currentaddrcity(DEFAULT:Current_Addr_City_:\'\'),currentaddrpostdir(DEFAULT:Current_Addr_Post_Dir_:\'\'),currentaddrlat(DEFAULT:Current_Addr_Lat_:\'\'),currentaddrlng(DEFAULT:Current_Addr_Lng_:\'\'),currentaddrunitdesignation(DEFAULT:Current_Addr_Unit_Designation_:\'\'),currentaddrtype(DEFAULT:Current_Addr_Type_:\'\'),currentaddrstatus(DEFAULT:Current_Addr_Status_:\'\'),currentaddrdatefirstseen(DEFAULT:Current_Addr_Date_First_Seen_:DATE),currentaddrdatelastseen(DEFAULT:Current_Addr_Date_Last_Seen_:DATE),currentaddrfull(DEFAULT:Current_Addr_Full_:\'\'),Current_Address_(DEFAULT:Current_Address_:0),previousaddrprimrng(DEFAULT:Previous_Addr_Prim_Rng_:\'\'),previousaddrpredir(DEFAULT:Previous_Addr_Pre_Dir_:\'\'),previousaddrprimname(DEFAULT:Previous_Addr_Prim_Name_:\'\'),previousaddrsffx(DEFAULT:Previous_Addr_Sffx_:\'\'),previousaddrsecrng(DEFAULT:Previous_Addr_Sec_Rng_:\'\'),previousaddrstate(DEFAULT:Previous_Addr_State_:\'\'),previousaddrzip5(DEFAULT:Previous_Addr_Zip5_:\'\'),previousaddrzip4(DEFAULT:Previous_Addr_Zip4_:\'\'),previousaddrstatecode(DEFAULT:Previous_Addr_State_Code_:\'\'),previousaddrcnty(DEFAULT:Previous_Addr_Cnty_:\'\'),previousaddrgeo(DEFAULT:Previous_Addr_Geo_:\'\'),previousaddrcity(DEFAULT:Previous_Addr_City_:\'\'),previousaddrpostdir(DEFAULT:Previous_Addr_Post_Dir_:\'\'),previousaddrlat(DEFAULT:Previous_Addr_Lat_:\'\'),previousaddrlng(DEFAULT:Previous_Addr_Lng_:\'\'),previousaddrunitdesignation(DEFAULT:Previous_Addr_Unit_Designation_:\'\'),previousaddrtype(DEFAULT:Previous_Addr_Type_:\'\'),previousaddrstatus(DEFAULT:Previous_Addr_Status_:\'\'),previousaddrdatefirstseen(DEFAULT:Previous_Addr_Date_First_Seen_:DATE),previousaddrdatelastseen(DEFAULT:Previous_Addr_Date_Last_Seen_:DATE),previousaddrfull(DEFAULT:Previous_Addr_Full_:\'\'),Previous_Address_(DEFAULT:Previous_Address_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
    SHARED __d0_Last_Name1__Layout := RECORD
      RECORDOF(__PInputPIIDataset);
      KEL.typ.uid Last_Name1_;
    END;
    SHARED __d0_Missing_Last_Name1__UIDComponents := KEL.Intake.ConstructMissingFieldList(__PInputPIIDataset,'P_InpClnSurname1','__PInputPIIDataset');
    SHARED __d0_Last_Name1__Mapped := IF(__d0_Missing_Last_Name1__UIDComponents = 'P_InpClnSurname1',PROJECT(__PInputPIIDataset,TRANSFORM(__d0_Last_Name1__Layout,SELF.Last_Name1_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__PInputPIIDataset,__d0_Missing_Last_Name1__UIDComponents),E_Surname(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnSurname1) = RIGHT.KeyVal,TRANSFORM(__d0_Last_Name1__Layout,SELF.Last_Name1_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Last_Name2__Layout := RECORD
      RECORDOF(__d0_Last_Name1__Mapped);
      KEL.typ.uid Last_Name2_;
    END;
    SHARED __d0_Missing_Last_Name2__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Last_Name1__Mapped,'P_InpClnSurname2','__PInputPIIDataset');
    SHARED __d0_Last_Name2__Mapped := IF(__d0_Missing_Last_Name2__UIDComponents = 'P_InpClnSurname2',PROJECT(__d0_Last_Name1__Mapped,TRANSFORM(__d0_Last_Name2__Layout,SELF.Last_Name2_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Last_Name1__Mapped,__d0_Missing_Last_Name2__UIDComponents),E_Surname(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnSurname2) = RIGHT.KeyVal,TRANSFORM(__d0_Last_Name2__Layout,SELF.Last_Name2_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Prop__Layout := RECORD
      RECORDOF(__d0_Last_Name2__Mapped);
      KEL.typ.uid Prop_;
    END;
    SHARED __d0_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Last_Name2__Mapped,'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5,P_InpClnAddrSecRng','__PInputPIIDataset');
    SHARED __d0_Prop__Mapped := IF(__d0_Missing_Prop__UIDComponents = 'P_InpClnAddrPrimRng,P_InpClnAddrPreDir,P_InpClnAddrPrimName,P_InpClnAddrSffx,P_InpClnAddrPostDir,P_InpClnAddrZip5,P_InpClnAddrSecRng',PROJECT(__d0_Last_Name2__Mapped,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Last_Name2__Mapped,__d0_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPreDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSffx) + '|' + TRIM((STRING)LEFT.P_InpClnAddrPostDir) + '|' + TRIM((STRING)LEFT.P_InpClnAddrZip5) + '|' + TRIM((STRING)LEFT.P_InpClnAddrSecRng) = RIGHT.KeyVal,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
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
    SHARED __d0_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Location__Mapped,'AddressGeoLink','__PInputPIIDataset');
    SHARED __d0_Geo_Link_I_D__Mapped := IF(__d0_Missing_Geo_Link_I_D__UIDComponents = 'AddressGeoLink',PROJECT(__d0_Location__Mapped,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Location__Mapped,__d0_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__in,__cfg).Lookup,TRIM((STRING)LEFT.AddressGeoLink) = RIGHT.KeyVal,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
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
    SHARED __d0_Current_Address__Layout := RECORD
      RECORDOF(__d0_Location_Summary__Mapped);
      KEL.typ.uid Current_Address_;
    END;
    SHARED __d0_Missing_Current_Address__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Location_Summary__Mapped,'CurrentAddrPrimRng,CurrentAddrPreDir,CurrentAddrPrimName,CurrentAddrSffx,CurrentAddrPostDir,CurrentAddrZip5,CurrentAddrSecRng','__PInputPIIDataset');
    SHARED __d0_Current_Address__Mapped := IF(__d0_Missing_Current_Address__UIDComponents = 'CurrentAddrPrimRng,CurrentAddrPreDir,CurrentAddrPrimName,CurrentAddrSffx,CurrentAddrPostDir,CurrentAddrZip5,CurrentAddrSecRng',PROJECT(__d0_Location_Summary__Mapped,TRANSFORM(__d0_Current_Address__Layout,SELF.Current_Address_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Location_Summary__Mapped,__d0_Missing_Current_Address__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.CurrentAddrPrimRng) + '|' + TRIM((STRING)LEFT.CurrentAddrPreDir) + '|' + TRIM((STRING)LEFT.CurrentAddrPrimName) + '|' + TRIM((STRING)LEFT.CurrentAddrSffx) + '|' + TRIM((STRING)LEFT.CurrentAddrPostDir) + '|' + TRIM((STRING)LEFT.CurrentAddrZip5) + '|' + TRIM((STRING)LEFT.CurrentAddrSecRng) = RIGHT.KeyVal,TRANSFORM(__d0_Current_Address__Layout,SELF.Current_Address_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Previous_Address__Layout := RECORD
      RECORDOF(__d0_Current_Address__Mapped);
      KEL.typ.uid Previous_Address_;
    END;
    SHARED __d0_Missing_Previous_Address__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Current_Address__Mapped,'PreviousAddrPrimRng,PreviousAddrPreDir,PreviousAddrPrimName,PreviousAddrSffx,PreviousAddrPostDir,PreviousAddrZip5,PreviousAddrSecRng','__PInputPIIDataset');
    SHARED __d0_Previous_Address__Mapped := IF(__d0_Missing_Previous_Address__UIDComponents = 'PreviousAddrPrimRng,PreviousAddrPreDir,PreviousAddrPrimName,PreviousAddrSffx,PreviousAddrPostDir,PreviousAddrZip5,PreviousAddrSecRng',PROJECT(__d0_Current_Address__Mapped,TRANSFORM(__d0_Previous_Address__Layout,SELF.Previous_Address_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Current_Address__Mapped,__d0_Missing_Previous_Address__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.PreviousAddrPrimRng) + '|' + TRIM((STRING)LEFT.PreviousAddrPreDir) + '|' + TRIM((STRING)LEFT.PreviousAddrPrimName) + '|' + TRIM((STRING)LEFT.PreviousAddrSffx) + '|' + TRIM((STRING)LEFT.PreviousAddrPostDir) + '|' + TRIM((STRING)LEFT.PreviousAddrZip5) + '|' + TRIM((STRING)LEFT.PreviousAddrSecRng) = RIGHT.KeyVal,TRANSFORM(__d0_Previous_Address__Layout,SELF.Previous_Address_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
    SHARED __d0_Prefiltered := __d0_Previous_Address__Mapped((KEL.typ.uid)G_ProcUID <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
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
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
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
  SHARED B_Person_11_Local := MODULE(B_Person_11(__in,__cfg_Local))
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(B_Person_Lien_Judgment_12(__in,__cfg_Local).__ENH_Person_Lien_Judgment_12) __ENH_Person_Lien_Judgment_12 := B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12;
  END;
  SHARED B_Person_10_Local := MODULE(B_Person_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_11(__in,__cfg_Local).__ENH_Person_11) __ENH_Person_11 := B_Person_11_Local.__ENH_Person_11;
  END;
  SHARED B_Person_9_Local := MODULE(B_Person_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Person_10(__in,__cfg_Local).__ENH_Person_10) __ENH_Person_10 := B_Person_10_Local.__ENH_Person_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Criminal_Offense_8_Local := MODULE(B_Criminal_Offense_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_8_Local := MODULE(B_Education_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Person_8_Local := MODULE(B_Person_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
    SHARED TYPEOF(B_Person_9(__in,__cfg_Local).__ENH_Person_9) __ENH_Person_9 := B_Person_9_Local.__ENH_Person_9;
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
    SHARED TYPEOF(B_Criminal_Offense_8(__in,__cfg_Local).__ENH_Criminal_Offense_8) __ENH_Criminal_Offense_8 := B_Criminal_Offense_8_Local.__ENH_Criminal_Offense_8;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_8(__in,__cfg_Local).__ENH_Education_8) __ENH_Education_8 := B_Education_8_Local.__ENH_Education_8;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Inquiry_7_Local := MODULE(B_Inquiry_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_8(__in,__cfg_Local).__ENH_Education_8) __ENH_Education_8 := B_Education_8_Local.__ENH_Education_8;
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
    SHARED TYPEOF(B_Person_8(__in,__cfg_Local).__ENH_Person_8) __ENH_Person_8 := B_Person_8_Local.__ENH_Person_8;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  END;
  SHARED B_Person_Property_7_Local := MODULE(B_Person_Property_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_8(__in,__cfg_Local).__ENH_Person_Property_8) __ENH_Person_Property_8 := B_Person_Property_8_Local.__ENH_Person_Property_8;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_8(__in,__cfg_Local).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8_Local.__ENH_Property_Event_8;
  END;
  SHARED B_Property_Event_7_Local := MODULE(B_Property_Event_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_8(__in,__cfg_Local).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8_Local.__ENH_Property_Event_8;
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
    SHARED TYPEOF(B_Person_7(__in,__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
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
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg_Local).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
  END;
  SHARED B_Criminal_Offense_5_Local := MODULE(B_Criminal_Offense_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_6(__in,__cfg_Local).__ENH_Criminal_Offense_6) __ENH_Criminal_Offense_6 := B_Criminal_Offense_6_Local.__ENH_Criminal_Offense_6;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_6(__in,__cfg_Local).__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Inquiry_5_Local := MODULE(B_Inquiry_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_6(__in,__cfg_Local).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6_Local.__ENH_Inquiry_6;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
    SHARED TYPEOF(B_Person_6(__in,__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
    SHARED TYPEOF(B_Person_S_S_N_6(__in,__cfg_Local).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6;
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
  SHARED B_Property_Event_5_Local := MODULE(B_Property_Event_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_6(__in,__cfg_Local).__ENH_Property_Event_6) __ENH_Property_Event_6 := B_Property_Event_6_Local.__ENH_Property_Event_6;
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
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_Inquiry_4_Local := MODULE(B_Inquiry_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_5(__in,__cfg_Local).__ENH_Inquiry_5) __ENH_Inquiry_5 := B_Inquiry_5_Local.__ENH_Inquiry_5;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Criminal_Offense_5(__in,__cfg_Local).__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5;
    SHARED TYPEOF(B_Person_5(__in,__cfg_Local).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_5(__in,__cfg_Local).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5_Local.__ENH_Person_Property_5;
    SHARED TYPEOF(B_Person_S_S_N_5(__in,__cfg_Local).__ENH_Person_S_S_N_5) __ENH_Person_S_S_N_5 := B_Person_S_S_N_5_Local.__ENH_Person_S_S_N_5;
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
  SHARED B_Property_Event_4_Local := MODULE(B_Property_Event_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_5(__in,__cfg_Local).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5_Local.__ENH_Property_Event_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
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
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Inquiry_4(__in,__cfg_Local).__ENH_Inquiry_4) __ENH_Inquiry_4 := B_Inquiry_4_Local.__ENH_Inquiry_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Inquiry(__in,__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_4(__in,__cfg_Local).__ENH_Person_Property_4) __ENH_Person_Property_4 := B_Person_Property_4_Local.__ENH_Person_Property_4;
    SHARED TYPEOF(B_Person_S_S_N_4(__in,__cfg_Local).__ENH_Person_S_S_N_4) __ENH_Person_S_S_N_4 := B_Person_S_S_N_4_Local.__ENH_Person_S_S_N_4;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  END;
  SHARED B_Person_Property_3_Local := MODULE(B_Person_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_4(__in,__cfg_Local).__ENH_Person_Property_4) __ENH_Person_Property_4 := B_Person_Property_4_Local.__ENH_Person_Property_4;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Property_3_Local := MODULE(B_Property_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  END;
  SHARED B_Property_Event_3_Local := MODULE(B_Property_Event_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_4(__in,__cfg_Local).__ENH_Property_Event_4) __ENH_Property_Event_4 := B_Property_Event_4_Local.__ENH_Property_Event_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
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
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Email_3(__in,__cfg_Local).__ENH_Email_3) __ENH_Email_3 := B_Email_3_Local.__ENH_Email_3;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_3(__in,__cfg_Local).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3_Local.__ENH_Person_Property_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Property_2_Local := MODULE(B_Person_Property_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_3(__in,__cfg_Local).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3_Local.__ENH_Person_Property_3;
    SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered.__Result;
    SHARED TYPEOF(B_Property_3(__in,__cfg_Local).__ENH_Property_3) __ENH_Property_3 := B_Property_3_Local.__ENH_Property_3;
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Professional_License_2_Local := MODULE(B_Professional_License_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
  END;
  SHARED B_Property_Event_2_Local := MODULE(B_Property_Event_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_3(__in,__cfg_Local).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3_Local.__ENH_Property_Event_3;
  END;
  SHARED B_Watercraft_Owner_2_Local := MODULE(B_Watercraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
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
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Email_2(__in,__cfg_Local).__ENH_Email_2) __ENH_Email_2 := B_Email_2_Local.__ENH_Email_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_2(__in,__cfg_Local).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2_Local.__ENH_Person_Property_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Property_1_Local := MODULE(B_Person_Property_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Property_2(__in,__cfg_Local).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2_Local.__ENH_Person_Property_2;
  END;
  SHARED B_Professional_License_1_Local := MODULE(B_Professional_License_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
  END;
  SHARED B_Property_Event_1_Local := MODULE(B_Property_Event_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_Event_2(__in,__cfg_Local).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2_Local.__ENH_Property_Event_2;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Education_1(__in,__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Property_1(__in,__cfg_Local).__ENH_Person_Property_1) __ENH_Person_Property_1 := B_Person_Property_1_Local.__ENH_Person_Property_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Property_Event_1(__in,__cfg_Local).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1_Local.__ENH_Property_Event_1;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED __EE2500885 := __ENH_Person;
  SHARED __EE2503932 := __EE2500885(__T(__OP2(__EE2500885.UID,=,__CN(__PLexID_in))));
  SHARED __ST98249_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.str P___Lex_I_D_Is_Deceased_Flag_ := '';
    KEL.typ.int P_L___Ast_Veh_Air_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Veh_Wtr_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Wtr_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Wtr_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Crim_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Old_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Severity_Indx7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Behavior_Indx7_Y_;
    KEL.typ.int P_L___Drg_Bk_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Dt_List1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Dt_List7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Dt_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt10_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc10_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Ch_List1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Ch_List7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Ch_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type10_Y_;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt10_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Disp_List1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Disp_List7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Disp_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc10_Y_;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt10_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Type_List1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Type_List7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Type_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag10_Y_;
    KEL.typ.str P_L___Drg_Bk_Severity_Indx10_Y_ := '';
    KEL.typ.str P_L___Prof_Lic_Flag_Ev_ := '';
    KEL.typ.int P_L___Prof_Lic_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Prof_Lic_Issue_Dt_List_Ev_;
    KEL.typ.nstr P_L___Prof_Lic_Exp_Dt_List_Ev_;
    KEL.typ.nstr P_L___Prof_Lic_Indx_By_Lic_List_Ev_;
    KEL.typ.str P_L___Prof_Lic_Actv_Flag_ := '';
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Issue_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Exp_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Title_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Indx_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Src_Type_;
    KEL.typ.str P_L___Curr_Addr_Full_ := '';
    KEL.typ.nstr P_L___Curr_Addr_Loc_I_D_;
    KEL.typ.str P_L___Prev_Addr_Full_ := '';
    KEL.typ.nstr P_L___Prev_Addr_Loc_I_D_;
    KEL.typ.str P_L___Curr_Addr_Cnty_ := '';
    KEL.typ.str P_L___Curr_Addr_Geo_ := '';
    KEL.typ.str P_L___Curr_Addr_Lat_ := '';
    KEL.typ.str P_L___Curr_Addr_Lng_ := '';
    KEL.typ.str P_L___Curr_Addr_Type_ := '';
    KEL.typ.str P_L___Curr_Addr_Status_ := '';
    KEL.typ.str P_L___Prev_Addr_Cnty_ := '';
    KEL.typ.str P_L___Prev_Addr_Geo_ := '';
    KEL.typ.str P_L___Prev_Addr_Lat_ := '';
    KEL.typ.str P_L___Prev_Addr_Lng_ := '';
    KEL.typ.str P_L___Prev_Addr_Type_ := '';
    KEL.typ.str P_L___Prev_Addr_Status_ := '';
    KEL.typ.int P_L___Curr_Addr_Is_Vacant_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Throwback_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Seasonal_Type_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_D_N_D_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_College_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_C_M_R_A_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Drop_Delivery_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Multi_Unit_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Apt_Flag_ := 0;
    KEL.typ.str P_L___Addr_Hist_On_File_Flag_ := '';
    KEL.typ.int P_L___Addr_Emrg_Cnt3_M_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt6_M_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt2_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt3_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt5_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Addr_Emrg_Cnt15_Y_ := 0;
    KEL.typ.nstr P_L___Best_Name_First_;
    KEL.typ.nstr P_L___Best_Name_Mid_;
    KEL.typ.nstr P_L___Best_Name_Last_;
    KEL.typ.nstr P_L___Best_S_S_N_;
    KEL.typ.nstr P_L___Best_D_O_B_;
    KEL.typ.nint P_L___Best_D_O_B_Age_;
    KEL.typ.int P_L___Prev_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.int P_L___Prev_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_L_T_D_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_L_T_D_Old_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_L_T_D_Amt_List7_Y_;
    KEL.typ.nstr P_L___Drg_L_T_D_Dt_List7_Y_;
    KEL.typ.nint P_L___Drg_L_T_D_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_L_T_D_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Suit_Cnt7_Y_ := 0;
    KEL.typ.str P_L___Drg_Suit_Amt_List7_Y_ := '';
    KEL.typ.int P_L___Drg_Suit_Amt_Tot7_Y_ := 0;
    KEL.typ.str P_L___Drg_Suit_Dt_List7_Y_ := '';
    KEL.typ.int P_L___Drg_Suit_New_Msnc7_Y_ := 0;
    KEL.typ.int P_L___Drg_Suit_Old_Msnc7_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Ln_J_Amt_List7_Y_;
    KEL.typ.nstr P_L___Drg_Ln_J_Dt_List7_Y_;
    KEL.typ.nstr P_L___Drg_Ln_J_New_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Ln_J_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Ln_J_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Ln_J_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Cnt7_Y_ := 0;
    KEL.typ.nint P_L___Drg_Old_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_New_Msnc7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST92840_Layout) Crim_List_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST92861_Layout) Banko_List_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST92884_Layout) Ln_J7_Y_List_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST92907_Layout) L_T_D7_Y_List_;
    KEL.typ.str P_L___Edu_Rec_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Edu_Src_List_Ev_;
    KEL.typ.str P_L___Edu_H_S_Rec_Flag_Ev_ := '';
    KEL.typ.str P_L___Edu_Coll_Rec_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Edu_Coll_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_New_Dt_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_Old_Msnc_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Rec_Span_Ev_;
    KEL.typ.int P_L___Email_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Email_Flag_Ev_;
    KEL.typ.int P_L___Email_Free_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Email_I_S_P_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Email_Edu_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Email_Corp_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Prop_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_New_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Old_Dt_List_Ev_;
    KEL.typ.int P_L___Ast_Prop_Curr_Cnt_ := 0;
    KEL.typ.nint P_L___Ast_Prop_Flag_Ev_;
    KEL.typ.nint P_L___Ast_Prop_Curr_Flag_;
    KEL.typ.nint P_L___Ast_Prop_Ownership_Indx_;
    KEL.typ.int P_L___Ast_Prop_Curr_W_Mkt_Val_Cnt_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Curr_Mkt_Val_List_;
    KEL.typ.int P_L___Ast_Prop_Curr_W_Tax_Val_Cnt_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Curr_Tax_Val_List_;
    KEL.typ.int P_L___Ast_Prop_Curr_Tax_Val_Tot_ := 0;
    KEL.typ.int P_L___Ast_Prop_Curr_W_A_V_M_Val_Cnt_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Curr_A_V_M_Val_List_;
    KEL.typ.int P_L___Ast_Prop_Curr_A_V_M_Val_Tot_ := 0;
    KEL.typ.float P_L___Ast_Prop_Curr_A_V_M_Val_Avg_ := 0.0;
    KEL.typ.int P_L___Ast_Prop_Purch_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Purch_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Purch_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Prop_Purch_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Ast_Prop_Purch_Cnt5_Y_ := 0;
    KEL.typ.int P_L___Ast_Prop_Sale_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Sale_Amt_List_Ev_;
    KEL.typ.int P_L___Ast_Prop_Sale_Tot_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Prop_Sale_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Sale_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Prop_Sale_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Prop_Sale_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Prop_Sale_Old_Msnc_Ev_;
    KEL.typ.int P_L___Inq_Per_Lex_I_D_Cnt1_Y_ := 0;
    KEL.typ.nint P_L___Inq_S_S_N_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Addr_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_L_Name_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_F_Name_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Phone_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_D_O_B_Per_Lex_I_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_A_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_S_D_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_P_S_Cnt1_Y_;
    KEL.typ.nint P_L___S_T_L_Cnt1_Y_;
    KEL.typ.nint P_L___S_T_L_Cnt2_Y_;
    KEL.typ.nint P_L___S_T_L_Cnt5_Y_;
    KEL.typ.nstr P_L___S_T_L_Dt_List5_Y_;
    KEL.typ.int P_L___Ver_Src_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ver_Src_List_Ev_;
    KEL.typ.nstr P_L___Ver_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ver_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ver_Src_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Ver_Src_New_Dt_Ev_;
    KEL.typ.str P___Lex_I_D_Rstd_Only_Flag_ := '';
    KEL.typ.nint P_L___Ver_Name_First_Src_Cnt_Ev_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_List_Ev_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ver_Name_First_Src_Last_Dt_List_Ev_;
    KEL.typ.nint P_L___Ver_Name_Last_Src_Cnt_Ev_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_List_Ev_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ver_Name_Last_Src_Last_Dt_List_Ev_;
    KEL.typ.nint P_L___Ver_S_S_N_Src_Cnt_Ev_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_List_Ev_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ver_S_S_N_Src_Last_Dt_List_Ev_;
    KEL.typ.str P_L___Alrt_Corrected_Flag_ := '';
    KEL.typ.str P_L___Alrt_Cons_Statement_Flag_ := '';
    KEL.typ.str P_L___Alrt_Dispute_Flag_ := '';
    KEL.typ.str P_L___Alrt_Security_Freeze_Flag_ := '';
    KEL.typ.str P_L___Alrt_Security_Alert_Flag_ := '';
    KEL.typ.str P_L___Alrt_I_D_Theft_Flag_ := '';
    KEL.typ.nint P_L___Emrg_Age_;
    KEL.typ.str P_L___Ver_S_S_N_Lookup_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST98249_Layout __ND2503937__Project(B_Person(__in,__cfg_Local).__ST154557_Layout __PP2503933) := TRANSFORM
    SELF.Lex_I_D_ := __PP2503933.UID;
    SELF.P___Lex_I_D_Seen_Flag_ := __PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_;
    __CC14000 := '-99999';
    SELF.P___Lex_I_D_Is_Deceased_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P___Lex_I_D_Is_Deceased_Flag_);
    __CC13998 := -99999;
    SELF.P_L___Ast_Veh_Air_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Veh_Air_Cnt_Ev_);
    SELF.P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_));
    SELF.P_L___Ast_Veh_Air_Emrg_New_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Veh_Air_Emrg_New_Dt_Ev_));
    SELF.P_L___Ast_Veh_Air_Emrg_Old_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Veh_Air_Emrg_Old_Dt_Ev_));
    SELF.P_L___Ast_Veh_Air_Emrg_New_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Veh_Air_Emrg_New_Msnc_Ev_));
    SELF.P_L___Ast_Veh_Air_Emrg_Old_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Veh_Air_Emrg_Old_Msnc_Ev_));
    SELF.P_L___Ast_Veh_Wtr_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Veh_Wtr_Cnt_Ev_);
    SELF.P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_));
    SELF.P_L___Ast_Veh_Wtr_Emrg_New_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Veh_Wtr_Emrg_New_Dt_Ev_));
    SELF.P_L___Ast_Veh_Wtr_Emrg_Old_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Veh_Wtr_Emrg_Old_Dt_Ev_));
    SELF.P_L___Ast_Veh_Wtr_Emrg_New_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Veh_Wtr_Emrg_New_Msnc_Ev_));
    SELF.P_L___Ast_Veh_Wtr_Emrg_Old_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Veh_Wtr_Emrg_Old_Msnc_Ev_));
    SELF.P_L___Drg_Crim_Fel_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Crim_Fel_Cnt1_Y_F_C_R_A_);
    SELF.P_L___Drg_Crim_Fel_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Crim_Fel_Cnt7_Y_F_C_R_A_);
    SELF.P_L___Drg_Crim_Fel_New_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Fel_New_Dt1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_Old_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Fel_Old_Dt1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Fel_New_Dt7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_Old_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Fel_Old_Dt7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_New_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Fel_New_Msnc1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_Old_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Fel_Old_Msnc1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Fel_New_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Fel_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Fel_Old_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Crim_Nfel_Cnt1_Y_F_C_R_A_);
    SELF.P_L___Drg_Crim_Nfel_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Crim_Nfel_Cnt7_Y_F_C_R_A_);
    SELF.P_L___Drg_Crim_Nfel_New_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Nfel_New_Dt1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_Old_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Nfel_Old_Dt1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Nfel_New_Dt7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_Old_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Nfel_Old_Dt7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_New_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Nfel_New_Msnc1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_Old_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Nfel_Old_Msnc1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Nfel_New_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Nfel_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Nfel_Old_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Crim_Cnt1_Y_F_C_R_A_);
    SELF.P_L___Drg_Crim_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Crim_Cnt7_Y_F_C_R_A_);
    SELF.P_L___Drg_Crim_New_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_New_Dt1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Old_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Old_Dt1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_New_Dt7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Old_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Old_Dt7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_New_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_New_Msnc1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Old_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Old_Msnc1_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_New_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Crim_Old_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Severity_Indx7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Severity_Indx7_Y_F_C_R_A_));
    SELF.P_L___Drg_Crim_Behavior_Indx7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Crim_Behavior_Indx7_Y_F_C_R_A_));
    SELF.P_L___Drg_Bk_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Cnt1_Y_);
    SELF.P_L___Drg_Bk_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Cnt7_Y_);
    SELF.P_L___Drg_Bk_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Cnt10_Y_);
    SELF.P_L___Drg_Bk_Dt_List1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Dt_List1_Y_));
    SELF.P_L___Drg_Bk_Dt_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Dt_List7_Y_));
    SELF.P_L___Drg_Bk_Dt_List10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Dt_List10_Y_));
    SELF.P_L___Drg_Bk_New_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Dt1_Y_));
    SELF.P_L___Drg_Bk_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Dt7_Y_));
    SELF.P_L___Drg_Bk_New_Dt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Dt10_Y_));
    SELF.P_L___Drg_Bk_Old_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Old_Dt1_Y_));
    SELF.P_L___Drg_Bk_Old_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Old_Dt7_Y_));
    SELF.P_L___Drg_Bk_Old_Dt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Old_Dt10_Y_));
    SELF.P_L___Drg_Bk_New_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Bk_New_Msnc1_Y_));
    SELF.P_L___Drg_Bk_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Bk_New_Msnc7_Y_));
    SELF.P_L___Drg_Bk_New_Msnc10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Bk_New_Msnc10_Y_));
    SELF.P_L___Drg_Bk_Old_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Bk_Old_Msnc1_Y_));
    SELF.P_L___Drg_Bk_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Bk_Old_Msnc7_Y_));
    SELF.P_L___Drg_Bk_Old_Msnc10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Bk_Old_Msnc10_Y_));
    SELF.P_L___Drg_Bk_Ch_List1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Ch_List1_Y_));
    SELF.P_L___Drg_Bk_Ch_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Ch_List7_Y_));
    SELF.P_L___Drg_Bk_Ch_List10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Ch_List10_Y_));
    SELF.P_L___Drg_Bk_New_Ch_Type1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Ch_Type1_Y_));
    SELF.P_L___Drg_Bk_New_Ch_Type7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Ch_Type7_Y_));
    SELF.P_L___Drg_Bk_New_Ch_Type10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Ch_Type10_Y_));
    SELF.P_L___Drg_Bk_Ch7_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Ch7_Cnt1_Y_);
    SELF.P_L___Drg_Bk_Ch7_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Ch7_Cnt7_Y_);
    SELF.P_L___Drg_Bk_Ch7_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Ch7_Cnt10_Y_);
    SELF.P_L___Drg_Bk_Ch13_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Ch13_Cnt1_Y_);
    SELF.P_L___Drg_Bk_Ch13_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Ch13_Cnt7_Y_);
    SELF.P_L___Drg_Bk_Ch13_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Ch13_Cnt10_Y_);
    SELF.P_L___Drg_Bk_Updt_New_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Updt_New_Dt1_Y_));
    SELF.P_L___Drg_Bk_Updt_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Updt_New_Dt7_Y_));
    SELF.P_L___Drg_Bk_Updt_New_Dt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Updt_New_Dt10_Y_));
    SELF.P_L___Drg_Bk_Updt_New_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Updt_New_Msnc1_Y_));
    SELF.P_L___Drg_Bk_Updt_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Updt_New_Msnc7_Y_));
    SELF.P_L___Drg_Bk_Updt_New_Msnc10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Updt_New_Msnc10_Y_));
    SELF.P_L___Drg_Bk_Disp_List1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Disp_List1_Y_));
    SELF.P_L___Drg_Bk_Disp_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Disp_List7_Y_));
    SELF.P_L___Drg_Bk_Disp_List10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Disp_List10_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Type1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Type1_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Type7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Type7_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Type10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Type10_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Dt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Dt1_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Dt7_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Dt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Dt10_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Msnc1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Msnc1_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Msnc7_Y_));
    SELF.P_L___Drg_Bk_New_Disp_Msnc10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_New_Disp_Msnc10_Y_));
    SELF.P_L___Drg_Bk_Disp_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Disp_Cnt1_Y_);
    SELF.P_L___Drg_Bk_Disp_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Disp_Cnt7_Y_);
    SELF.P_L___Drg_Bk_Disp_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Disp_Cnt10_Y_);
    SELF.P_L___Drg_Bk_Dsms_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Dsms_Cnt1_Y_);
    SELF.P_L___Drg_Bk_Dsms_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Dsms_Cnt7_Y_);
    SELF.P_L___Drg_Bk_Dsms_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Dsms_Cnt10_Y_);
    SELF.P_L___Drg_Bk_Dsch_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Dsch_Cnt1_Y_);
    SELF.P_L___Drg_Bk_Dsch_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Dsch_Cnt7_Y_);
    SELF.P_L___Drg_Bk_Dsch_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Bk_Dsch_Cnt10_Y_);
    SELF.P_L___Drg_Bk_Type_List1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Type_List1_Y_));
    SELF.P_L___Drg_Bk_Type_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Type_List7_Y_));
    SELF.P_L___Drg_Bk_Type_List10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Type_List10_Y_));
    SELF.P_L___Drg_Bk_Bus_Flag1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Bus_Flag1_Y_));
    SELF.P_L___Drg_Bk_Bus_Flag7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Bus_Flag7_Y_));
    SELF.P_L___Drg_Bk_Bus_Flag10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Bk_Bus_Flag10_Y_));
    SELF.P_L___Drg_Bk_Severity_Indx10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Drg_Bk_Severity_Indx10_Y_);
    SELF.P_L___Prof_Lic_Flag_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prof_Lic_Flag_Ev_);
    SELF.P_L___Prof_Lic_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Prof_Lic_Cnt_Ev_);
    SELF.P_L___Prof_Lic_Issue_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Issue_Dt_List_Ev_));
    SELF.P_L___Prof_Lic_Exp_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Exp_Dt_List_Ev_));
    SELF.P_L___Prof_Lic_Indx_By_Lic_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Indx_By_Lic_List_Ev_));
    SELF.P_L___Prof_Lic_Actv_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prof_Lic_Actv_Flag_);
    SELF.P_L___Prof_Lic_Actv_New_Issue_Dt_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Actv_New_Issue_Dt_));
    SELF.P_L___Prof_Lic_Actv_New_Exp_Dt_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Actv_New_Exp_Dt_));
    SELF.P_L___Prof_Lic_Actv_New_Type_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Actv_New_Type_));
    SELF.P_L___Prof_Lic_Actv_New_Title_Type_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Actv_New_Title_Type_));
    SELF.P_L___Prof_Lic_Actv_New_Indx_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Actv_New_Indx_));
    SELF.P_L___Prof_Lic_Actv_New_Src_Type_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prof_Lic_Actv_New_Src_Type_));
    SELF.P_L___Curr_Addr_Full_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Full_);
    SELF.P_L___Curr_Addr_Loc_I_D_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Curr_Addr_Loc_I_D_));
    SELF.P_L___Prev_Addr_Full_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Full_);
    SELF.P_L___Prev_Addr_Loc_I_D_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Prev_Addr_Loc_I_D_));
    SELF.P_L___Curr_Addr_Cnty_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Cnty_);
    SELF.P_L___Curr_Addr_Geo_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Geo_);
    SELF.P_L___Curr_Addr_Lat_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Lat_);
    SELF.P_L___Curr_Addr_Lng_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Lng_);
    SELF.P_L___Curr_Addr_Type_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Type_);
    SELF.P_L___Curr_Addr_Status_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Curr_Addr_Status_);
    SELF.P_L___Prev_Addr_Cnty_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Cnty_);
    SELF.P_L___Prev_Addr_Geo_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Geo_);
    SELF.P_L___Prev_Addr_Lat_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Lat_);
    SELF.P_L___Prev_Addr_Lng_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Lng_);
    SELF.P_L___Prev_Addr_Type_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Type_);
    SELF.P_L___Prev_Addr_Status_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Prev_Addr_Status_);
    SELF.P_L___Curr_Addr_Is_Vacant_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Vacant_Flag_);
    SELF.P_L___Curr_Addr_Is_Throwback_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Throwback_Flag_);
    SELF.P_L___Curr_Addr_Seasonal_Type_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Seasonal_Type_);
    SELF.P_L___Curr_Addr_Is_D_N_D_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_D_N_D_Flag_);
    SELF.P_L___Curr_Addr_Is_College_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_College_Flag_);
    SELF.P_L___Curr_Addr_Is_C_M_R_A_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_C_M_R_A_Flag_);
    SELF.P_L___Curr_Addr_Is_Simp_Addr_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Simp_Addr_Flag_);
    SELF.P_L___Curr_Addr_Is_Drop_Delivery_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Drop_Delivery_Flag_);
    SELF.P_L___Curr_Addr_Is_Business_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Business_Flag_);
    SELF.P_L___Curr_Addr_Is_Multi_Unit_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Multi_Unit_Flag_);
    SELF.P_L___Curr_Addr_Is_Apt_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Curr_Addr_Is_Apt_Flag_);
    SELF.P_L___Addr_Hist_On_File_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Addr_Hist_On_File_Flag_);
    SELF.P_L___Addr_Emrg_Cnt3_M_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt3_M_);
    SELF.P_L___Addr_Emrg_Cnt6_M_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt6_M_);
    SELF.P_L___Addr_Emrg_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt1_Y_);
    SELF.P_L___Addr_Emrg_Cnt2_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt2_Y_);
    SELF.P_L___Addr_Emrg_Cnt3_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt3_Y_);
    SELF.P_L___Addr_Emrg_Cnt5_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt5_Y_);
    SELF.P_L___Addr_Emrg_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt7_Y_);
    SELF.P_L___Addr_Emrg_Cnt10_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt10_Y_);
    SELF.P_L___Addr_Emrg_Cnt15_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Addr_Emrg_Cnt15_Y_);
    SELF.P_L___Best_Name_First_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Best_Name_First_));
    SELF.P_L___Best_Name_Mid_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Best_Name_Mid_));
    SELF.P_L___Best_Name_Last_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Best_Name_Last_));
    SELF.P_L___Best_S_S_N_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Best_S_S_N_));
    SELF.P_L___Best_D_O_B_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Best_D_O_B_));
    SELF.P_L___Best_D_O_B_Age_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Best_D_O_B_Age_));
    SELF.P_L___Prev_Addr_Is_Simp_Addr_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Prev_Addr_Is_Simp_Addr_Flag_);
    SELF.P_L___Prev_Addr_Is_Business_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Prev_Addr_Is_Business_Flag_);
    SELF.P_L___Drg_Judg_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Judg_Cnt7_Y_);
    SELF.P_L___Drg_L_T_D_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_L_T_D_Cnt7_Y_);
    SELF.P_L___Drg_L_T_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_L_T_D_Cnt1_Y_);
    SELF.P_L___Drg_L_T_D_Amt_Tot7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_L_T_D_Amt_Tot7_Y_);
    SELF.P_L___Drg_L_T_D_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_L_T_D_New_Dt7_Y_));
    SELF.P_L___Drg_L_T_D_Old_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_L_T_D_Old_Dt7_Y_));
    SELF.P_L___Drg_L_T_D_Amt_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_L_T_D_Amt_List7_Y_));
    SELF.P_L___Drg_L_T_D_Dt_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_L_T_D_Dt_List7_Y_));
    SELF.P_L___Drg_L_T_D_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_L_T_D_New_Msnc7_Y_));
    SELF.P_L___Drg_L_T_D_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_L_T_D_Old_Msnc7_Y_));
    SELF.P_L___Drg_Lien_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Lien_Cnt7_Y_);
    SELF.P_L___Drg_Suit_Cnt7_Y_ := 0;
    SELF.P_L___Drg_Suit_Amt_List7_Y_ := '-99998';
    SELF.P_L___Drg_Suit_Amt_Tot7_Y_ := -99998;
    SELF.P_L___Drg_Suit_Dt_List7_Y_ := '-99998';
    SELF.P_L___Drg_Suit_New_Msnc7_Y_ := -99998;
    SELF.P_L___Drg_Suit_Old_Msnc7_Y_ := -99998;
    SELF.P_L___Drg_Ln_J_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Ln_J_Cnt7_Y_);
    SELF.P_L___Drg_Ln_J_Amt_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Ln_J_Amt_List7_Y_));
    SELF.P_L___Drg_Ln_J_Dt_List7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Ln_J_Dt_List7_Y_));
    SELF.P_L___Drg_Ln_J_New_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Ln_J_New_Dt7_Y_));
    SELF.P_L___Drg_Ln_J_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Ln_J_New_Msnc7_Y_));
    SELF.P_L___Drg_Ln_J_Old_Dt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Drg_Ln_J_Old_Dt7_Y_));
    SELF.P_L___Drg_Ln_J_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Ln_J_Old_Msnc7_Y_));
    SELF.P_L___Drg_Cnt7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Drg_Cnt7_Y_F_C_R_A_);
    SELF.P_L___Drg_Old_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_Old_Msnc7_Y_F_C_R_A_));
    SELF.P_L___Drg_New_Msnc7_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Drg_New_Msnc7_Y_F_C_R_A_));
    SELF.Crim_List_ := __PP2503933.Crim_List_F_C_R_A_;
    SELF.P_L___Edu_Rec_Flag_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Edu_Rec_Flag_Ev_);
    SELF.P_L___Edu_Src_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Src_List_Ev_));
    SELF.P_L___Edu_H_S_Rec_Flag_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Edu_H_S_Rec_Flag_Ev_);
    SELF.P_L___Edu_Coll_Rec_Flag_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Edu_Coll_Rec_Flag_Ev_);
    SELF.P_L___Edu_Coll_Src_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Src_Emrg_Dt_List_Ev_));
    SELF.P_L___Edu_Coll_Src_Last_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Src_Last_Dt_List_Ev_));
    SELF.P_L___Edu_Coll_Src_New_Rec_Old_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Src_New_Rec_Old_Dt_Ev_));
    SELF.P_L___Edu_Coll_Src_New_Rec_New_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Src_New_Rec_New_Dt_Ev_));
    SELF.P_L___Edu_Coll_Src_New_Rec_Old_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Src_New_Rec_Old_Msnc_Ev_));
    SELF.P_L___Edu_Coll_Src_New_Rec_New_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Src_New_Rec_New_Msnc_Ev_));
    SELF.P_L___Edu_Coll_Rec_Span_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Edu_Coll_Rec_Span_Ev_));
    SELF.P_L___Email_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Email_Cnt_Ev_F_C_R_A_);
    SELF.P_L___Email_Flag_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Email_Flag_Ev_F_C_R_A_));
    SELF.P_L___Email_Free_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Email_Free_Cnt_Ev_F_C_R_A_);
    SELF.P_L___Email_I_S_P_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Email_I_S_P_Cnt_Ev_F_C_R_A_);
    SELF.P_L___Email_Edu_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Email_Edu_Cnt_Ev_F_C_R_A_);
    SELF.P_L___Email_Corp_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Email_Corp_Cnt_Ev_F_C_R_A_);
    SELF.P_L___Ast_Prop_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Cnt_Ev_);
    SELF.P_L___Ast_Prop_New_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_New_Dt_List_Ev_));
    SELF.P_L___Ast_Prop_Old_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Old_Dt_List_Ev_));
    SELF.P_L___Ast_Prop_Curr_Cnt_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Curr_Cnt_);
    SELF.P_L___Ast_Prop_Flag_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Prop_Flag_Ev_));
    SELF.P_L___Ast_Prop_Curr_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Prop_Curr_Flag_));
    SELF.P_L___Ast_Prop_Ownership_Indx_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Prop_Ownership_Indx_));
    SELF.P_L___Ast_Prop_Curr_W_Mkt_Val_Cnt_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Curr_W_Mkt_Val_Cnt_);
    SELF.P_L___Ast_Prop_Curr_Mkt_Val_List_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Curr_Mkt_Val_List_));
    SELF.P_L___Ast_Prop_Curr_W_Tax_Val_Cnt_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Curr_W_Tax_Val_Cnt_);
    SELF.P_L___Ast_Prop_Curr_Tax_Val_List_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Curr_Tax_Val_List_));
    SELF.P_L___Ast_Prop_Curr_Tax_Val_Tot_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Curr_Tax_Val_Tot_);
    SELF.P_L___Ast_Prop_Curr_W_A_V_M_Val_Cnt_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Curr_W_A_V_M_Val_Cnt_);
    SELF.P_L___Ast_Prop_Curr_A_V_M_Val_List_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Curr_A_V_M_Val_List_));
    SELF.P_L___Ast_Prop_Curr_A_V_M_Val_Tot_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Curr_A_V_M_Val_Tot_);
    SELF.P_L___Ast_Prop_Curr_A_V_M_Val_Avg_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',(KEL.typ.float)__CC13998,__PP2503933.P_L___Ast_Prop_Curr_A_V_M_Val_Avg_);
    SELF.P_L___Ast_Prop_Purch_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Purch_Cnt_Ev_);
    SELF.P_L___Ast_Prop_Purch_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Purch_Dt_List_Ev_));
    SELF.P_L___Ast_Prop_Purch_New_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Purch_New_Dt_Ev_));
    SELF.P_L___Ast_Prop_Purch_Old_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Purch_Old_Dt_Ev_));
    SELF.P_L___Ast_Prop_Purch_New_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Purch_New_Msnc_Ev_));
    SELF.P_L___Ast_Prop_Purch_Old_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC13998))),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Purch_Old_Msnc_Ev_));
    SELF.P_L___Ast_Prop_Purch_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Purch_Cnt1_Y_);
    SELF.P_L___Ast_Prop_Purch_Cnt5_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Purch_Cnt5_Y_);
    SELF.P_L___Ast_Prop_Sale_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Sale_Cnt_Ev_);
    SELF.P_L___Ast_Prop_Sale_Amt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Sale_Amt_List_Ev_));
    SELF.P_L___Ast_Prop_Sale_Tot_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Ast_Prop_Sale_Tot_Ev_);
    SELF.P_L___Ast_Prop_Sale_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Sale_Dt_List_Ev_));
    SELF.P_L___Ast_Prop_Sale_New_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Sale_New_Dt_Ev_));
    SELF.P_L___Ast_Prop_Sale_Old_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ast_Prop_Sale_Old_Dt_Ev_));
    SELF.P_L___Ast_Prop_Sale_New_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Prop_Sale_New_Msnc_Ev_));
    SELF.P_L___Ast_Prop_Sale_Old_Msnc_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ast_Prop_Sale_Old_Msnc_Ev_));
    SELF.P_L___Inq_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__PP2503933.P_L___Inq_Per_Lex_I_D_Cnt1_Y_);
    SELF.P_L___Inq_S_S_N_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_S_S_N_Per_Lex_I_D_Cnt1_Y_));
    SELF.P_L___Inq_Addr_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Addr_Per_Lex_I_D_Cnt1_Y_));
    SELF.P_L___Inq_L_Name_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_L_Name_Per_Lex_I_D_Cnt1_Y_));
    SELF.P_L___Inq_F_Name_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_F_Name_Per_Lex_I_D_Cnt1_Y_));
    SELF.P_L___Inq_Phone_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Phone_Per_Lex_I_D_Cnt1_Y_));
    SELF.P_L___Inq_D_O_B_Per_Lex_I_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_D_O_B_Per_Lex_I_D_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_S_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_S_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_A_S_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_A_S_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_S_D_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_S_D_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_P_S_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_P_S_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_S_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_S_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_P_S_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_P_S_Cnt1_Y_));
    SELF.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_P_S_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_P_S_Cnt1_Y_));
    SELF.P_L___S_T_L_Cnt1_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___S_T_L_Cnt1_Y_));
    SELF.P_L___S_T_L_Cnt2_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___S_T_L_Cnt2_Y_));
    SELF.P_L___S_T_L_Cnt5_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___S_T_L_Cnt5_Y_));
    SELF.P_L___S_T_L_Dt_List5_Y_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___S_T_L_Dt_List5_Y_));
    SELF.P_L___Ver_Src_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC13998,__T(__PP2503933.P_L___Ver_Src_Cnt_Ev_F_C_R_A_));
    SELF.P_L___Ver_Src_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Src_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Src_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Src_Emrg_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Src_Last_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Src_Last_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Src_Old_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Src_Old_Dt_Ev_F_C_R_A_));
    SELF.P_L___Ver_Src_New_Dt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Src_New_Dt_Ev_F_C_R_A_));
    SELF.P___Lex_I_D_Rstd_Only_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P___Lex_I_D_Rstd_Only_Flag_F_C_R_A_);
    SELF.P_L___Ver_Name_First_Src_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ver_Name_First_Src_Cnt_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_First_Src_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Name_First_Src_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_First_Src_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Name_First_Src_Emrg_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_First_Src_Last_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Name_First_Src_Last_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_Last_Src_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ver_Name_Last_Src_Cnt_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_Last_Src_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Name_Last_Src_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_Last_Src_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Name_Last_Src_Emrg_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_Name_Last_Src_Last_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_Name_Last_Src_Last_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_S_S_N_Src_Cnt_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Ver_S_S_N_Src_Cnt_Ev_F_C_R_A_));
    SELF.P_L___Ver_S_S_N_Src_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_S_S_N_Src_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_S_S_N_Src_Emrg_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_S_S_N_Src_Emrg_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Ver_S_S_N_Src_Last_Dt_List_Ev_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14000)),__ECAST(KEL.typ.nstr,__PP2503933.P_L___Ver_S_S_N_Src_Last_Dt_List_Ev_F_C_R_A_));
    SELF.P_L___Alrt_Corrected_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Alrt_Corrected_Flag_);
    SELF.P_L___Alrt_Cons_Statement_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Alrt_Cons_Statement_Flag_);
    SELF.P_L___Alrt_Dispute_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Alrt_Dispute_Flag_);
    SELF.P_L___Alrt_Security_Freeze_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Alrt_Security_Freeze_Flag_);
    SELF.P_L___Alrt_Security_Alert_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Alrt_Security_Alert_Flag_);
    SELF.P_L___Alrt_I_D_Theft_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Alrt_I_D_Theft_Flag_);
    SELF.P_L___Emrg_Age_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nint,__CN(__CC13998)),__ECAST(KEL.typ.nint,__PP2503933.P_L___Emrg_Age_));
    SELF.P_L___Ver_S_S_N_Lookup_Flag_ := IF(__PP2503933.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__CC14000,__PP2503933.P_L___Ver_S_S_N_Lookup_Flag_);
    SELF := __PP2503933;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE2503932,__ND2503937__Project(LEFT)));
  EXPORT DBG_E_Input_P_I_I_PreEntity := __UNWRAP(E_Input_P_I_I_Params(__in,__cfg_Local).InData);
  EXPORT DBG_E_Input_P_I_I_Result := __UNWRAP(E_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_Address_Result := __UNWRAP(E_Address_Filtered.__Result);
  EXPORT DBG_E_Aircraft_Owner_Result := __UNWRAP(E_Aircraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Bankruptcy_Result := __UNWRAP(E_Bankruptcy_Filtered.__Result);
  EXPORT DBG_E_Criminal_Offense_Result := __UNWRAP(E_Criminal_Offense_Filtered.__Result);
  EXPORT DBG_E_Education_Result := __UNWRAP(E_Education_Filtered.__Result);
  EXPORT DBG_E_Email_Result := __UNWRAP(E_Email_Filtered.__Result);
  EXPORT DBG_E_Inquiry_Result := __UNWRAP(E_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Result := __UNWRAP(E_Lien_Judgment_Filtered.__Result);
  EXPORT DBG_E_Person_Result := __UNWRAP(E_Person_Filtered.__Result);
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
  EXPORT DBG_E_Professional_License_Result := __UNWRAP(E_Professional_License_Filtered.__Result);
  EXPORT DBG_E_Professional_License_Person_Result := __UNWRAP(E_Professional_License_Person_Filtered.__Result);
  EXPORT DBG_E_Property_Result := __UNWRAP(E_Property_Filtered.__Result);
  EXPORT DBG_E_Property_Event_Result := __UNWRAP(E_Property_Event_Filtered.__Result);
  EXPORT DBG_E_Watercraft_Owner_Result := __UNWRAP(E_Watercraft_Owner_Filtered.__Result);
  EXPORT DBG_E_Lien_Judgment_Intermediate_13 := __UNWRAP(B_Lien_Judgment_13_Local.__ENH_Lien_Judgment_13);
  EXPORT DBG_E_Person_Lien_Judgment_Intermediate_12 := __UNWRAP(B_Person_Lien_Judgment_12_Local.__ENH_Person_Lien_Judgment_12);
  EXPORT DBG_E_Person_Intermediate_11 := __UNWRAP(B_Person_11_Local.__ENH_Person_11);
  EXPORT DBG_E_Person_Intermediate_10 := __UNWRAP(B_Person_10_Local.__ENH_Person_10);
  EXPORT DBG_E_Person_Intermediate_9 := __UNWRAP(B_Person_9_Local.__ENH_Person_9);
  EXPORT DBG_E_Bankruptcy_Intermediate_8 := __UNWRAP(B_Bankruptcy_8_Local.__ENH_Bankruptcy_8);
  EXPORT DBG_E_Criminal_Offense_Intermediate_8 := __UNWRAP(B_Criminal_Offense_8_Local.__ENH_Criminal_Offense_8);
  EXPORT DBG_E_Education_Intermediate_8 := __UNWRAP(B_Education_8_Local.__ENH_Education_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Person_Intermediate_8 := __UNWRAP(B_Person_8_Local.__ENH_Person_8);
  EXPORT DBG_E_Person_Property_Intermediate_8 := __UNWRAP(B_Person_Property_8_Local.__ENH_Person_Property_8);
  EXPORT DBG_E_Property_Event_Intermediate_8 := __UNWRAP(B_Property_Event_8_Local.__ENH_Property_Event_8);
  EXPORT DBG_E_Bankruptcy_Intermediate_7 := __UNWRAP(B_Bankruptcy_7_Local.__ENH_Bankruptcy_7);
  EXPORT DBG_E_Criminal_Offense_Intermediate_7 := __UNWRAP(B_Criminal_Offense_7_Local.__ENH_Criminal_Offense_7);
  EXPORT DBG_E_Education_Intermediate_7 := __UNWRAP(B_Education_7_Local.__ENH_Education_7);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Inquiry_Intermediate_7 := __UNWRAP(B_Inquiry_7_Local.__ENH_Inquiry_7);
  EXPORT DBG_E_Person_Intermediate_7 := __UNWRAP(B_Person_7_Local.__ENH_Person_7);
  EXPORT DBG_E_Person_Property_Intermediate_7 := __UNWRAP(B_Person_Property_7_Local.__ENH_Person_Property_7);
  EXPORT DBG_E_Property_Event_Intermediate_7 := __UNWRAP(B_Property_Event_7_Local.__ENH_Property_Event_7);
  EXPORT DBG_E_Bankruptcy_Intermediate_6 := __UNWRAP(B_Bankruptcy_6_Local.__ENH_Bankruptcy_6);
  EXPORT DBG_E_Criminal_Offense_Intermediate_6 := __UNWRAP(B_Criminal_Offense_6_Local.__ENH_Criminal_Offense_6);
  EXPORT DBG_E_Education_Intermediate_6 := __UNWRAP(B_Education_6_Local.__ENH_Education_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Inquiry_Intermediate_6 := __UNWRAP(B_Inquiry_6_Local.__ENH_Inquiry_6);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local.__ENH_Person_6);
  EXPORT DBG_E_Person_Property_Intermediate_6 := __UNWRAP(B_Person_Property_6_Local.__ENH_Person_Property_6);
  EXPORT DBG_E_Person_S_S_N_Intermediate_6 := __UNWRAP(B_Person_S_S_N_6_Local.__ENH_Person_S_S_N_6);
  EXPORT DBG_E_Property_Event_Intermediate_6 := __UNWRAP(B_Property_Event_6_Local.__ENH_Property_Event_6);
  EXPORT DBG_E_Bankruptcy_Intermediate_5 := __UNWRAP(B_Bankruptcy_5_Local.__ENH_Bankruptcy_5);
  EXPORT DBG_E_Criminal_Offense_Intermediate_5 := __UNWRAP(B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5);
  EXPORT DBG_E_Education_Intermediate_5 := __UNWRAP(B_Education_5_Local.__ENH_Education_5);
  EXPORT DBG_E_Input_P_I_I_Intermediate_5 := __UNWRAP(B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5);
  EXPORT DBG_E_Inquiry_Intermediate_5 := __UNWRAP(B_Inquiry_5_Local.__ENH_Inquiry_5);
  EXPORT DBG_E_Person_Intermediate_5 := __UNWRAP(B_Person_5_Local.__ENH_Person_5);
  EXPORT DBG_E_Person_Property_Intermediate_5 := __UNWRAP(B_Person_Property_5_Local.__ENH_Person_Property_5);
  EXPORT DBG_E_Person_S_S_N_Intermediate_5 := __UNWRAP(B_Person_S_S_N_5_Local.__ENH_Person_S_S_N_5);
  EXPORT DBG_E_Professional_License_Intermediate_5 := __UNWRAP(B_Professional_License_5_Local.__ENH_Professional_License_5);
  EXPORT DBG_E_Property_Event_Intermediate_5 := __UNWRAP(B_Property_Event_5_Local.__ENH_Property_Event_5);
  EXPORT DBG_E_Bankruptcy_Intermediate_4 := __UNWRAP(B_Bankruptcy_4_Local.__ENH_Bankruptcy_4);
  EXPORT DBG_E_Criminal_Offense_Intermediate_4 := __UNWRAP(B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4);
  EXPORT DBG_E_Education_Intermediate_4 := __UNWRAP(B_Education_4_Local.__ENH_Education_4);
  EXPORT DBG_E_Input_P_I_I_Intermediate_4 := __UNWRAP(B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4);
  EXPORT DBG_E_Inquiry_Intermediate_4 := __UNWRAP(B_Inquiry_4_Local.__ENH_Inquiry_4);
  EXPORT DBG_E_Person_Intermediate_4 := __UNWRAP(B_Person_4_Local.__ENH_Person_4);
  EXPORT DBG_E_Person_Property_Intermediate_4 := __UNWRAP(B_Person_Property_4_Local.__ENH_Person_Property_4);
  EXPORT DBG_E_Person_S_S_N_Intermediate_4 := __UNWRAP(B_Person_S_S_N_4_Local.__ENH_Person_S_S_N_4);
  EXPORT DBG_E_Professional_License_Intermediate_4 := __UNWRAP(B_Professional_License_4_Local.__ENH_Professional_License_4);
  EXPORT DBG_E_Property_Event_Intermediate_4 := __UNWRAP(B_Property_Event_4_Local.__ENH_Property_Event_4);
  EXPORT DBG_E_Address_Intermediate_3 := __UNWRAP(B_Address_3_Local.__ENH_Address_3);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_3 := __UNWRAP(B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3);
  EXPORT DBG_E_Bankruptcy_Intermediate_3 := __UNWRAP(B_Bankruptcy_3_Local.__ENH_Bankruptcy_3);
  EXPORT DBG_E_Criminal_Offense_Intermediate_3 := __UNWRAP(B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3);
  EXPORT DBG_E_Education_Intermediate_3 := __UNWRAP(B_Education_3_Local.__ENH_Education_3);
  EXPORT DBG_E_Email_Intermediate_3 := __UNWRAP(B_Email_3_Local.__ENH_Email_3);
  EXPORT DBG_E_Input_P_I_I_Intermediate_3 := __UNWRAP(B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3);
  EXPORT DBG_E_Person_Intermediate_3 := __UNWRAP(B_Person_3_Local.__ENH_Person_3);
  EXPORT DBG_E_Person_Property_Intermediate_3 := __UNWRAP(B_Person_Property_3_Local.__ENH_Person_Property_3);
  EXPORT DBG_E_Professional_License_Intermediate_3 := __UNWRAP(B_Professional_License_3_Local.__ENH_Professional_License_3);
  EXPORT DBG_E_Property_Intermediate_3 := __UNWRAP(B_Property_3_Local.__ENH_Property_3);
  EXPORT DBG_E_Property_Event_Intermediate_3 := __UNWRAP(B_Property_Event_3_Local.__ENH_Property_Event_3);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_3 := __UNWRAP(B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3);
  EXPORT DBG_E_Address_Intermediate_2 := __UNWRAP(B_Address_2_Local.__ENH_Address_2);
  EXPORT DBG_E_Aircraft_Owner_Intermediate_2 := __UNWRAP(B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2);
  EXPORT DBG_E_Bankruptcy_Intermediate_2 := __UNWRAP(B_Bankruptcy_2_Local.__ENH_Bankruptcy_2);
  EXPORT DBG_E_Criminal_Offense_Intermediate_2 := __UNWRAP(B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2);
  EXPORT DBG_E_Education_Intermediate_2 := __UNWRAP(B_Education_2_Local.__ENH_Education_2);
  EXPORT DBG_E_Email_Intermediate_2 := __UNWRAP(B_Email_2_Local.__ENH_Email_2);
  EXPORT DBG_E_Input_P_I_I_Intermediate_2 := __UNWRAP(B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local.__ENH_Person_2);
  EXPORT DBG_E_Person_Property_Intermediate_2 := __UNWRAP(B_Person_Property_2_Local.__ENH_Person_Property_2);
  EXPORT DBG_E_Professional_License_Intermediate_2 := __UNWRAP(B_Professional_License_2_Local.__ENH_Professional_License_2);
  EXPORT DBG_E_Property_Event_Intermediate_2 := __UNWRAP(B_Property_Event_2_Local.__ENH_Property_Event_2);
  EXPORT DBG_E_Watercraft_Owner_Intermediate_2 := __UNWRAP(B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2);
  EXPORT DBG_E_Bankruptcy_Intermediate_1 := __UNWRAP(B_Bankruptcy_1_Local.__ENH_Bankruptcy_1);
  EXPORT DBG_E_Criminal_Offense_Intermediate_1 := __UNWRAP(B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1);
  EXPORT DBG_E_Education_Intermediate_1 := __UNWRAP(B_Education_1_Local.__ENH_Education_1);
  EXPORT DBG_E_Input_P_I_I_Intermediate_1 := __UNWRAP(B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1);
  EXPORT DBG_E_Person_Intermediate_1 := __UNWRAP(B_Person_1_Local.__ENH_Person_1);
  EXPORT DBG_E_Person_Property_Intermediate_1 := __UNWRAP(B_Person_Property_1_Local.__ENH_Person_Property_1);
  EXPORT DBG_E_Professional_License_Intermediate_1 := __UNWRAP(B_Professional_License_1_Local.__ENH_Professional_License_1);
  EXPORT DBG_E_Property_Event_Intermediate_1 := __UNWRAP(B_Property_Event_1_Local.__ENH_Property_Event_1);
  EXPORT DBG_E_Person_Annotated := __UNWRAP(B_Person_Local.__ENH_Person);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_P_I_I_PreEntity_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Result,NAMED('DBG_E_Address_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Result,NAMED('DBG_E_Aircraft_Owner_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Result,NAMED('DBG_E_Bankruptcy_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Result,NAMED('DBG_E_Criminal_Offense_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Result,NAMED('DBG_E_Education_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Result,NAMED('DBG_E_Email_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Result,NAMED('DBG_E_Lien_Judgment_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Address_Result,NAMED('DBG_E_Person_Address_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Bankruptcy_Result,NAMED('DBG_E_Person_Bankruptcy_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Education_Result,NAMED('DBG_E_Person_Education_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Email_Result,NAMED('DBG_E_Person_Email_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Inquiry_Result,NAMED('DBG_E_Person_Inquiry_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Result,NAMED('DBG_E_Person_Lien_Judgment_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Offenses_Result,NAMED('DBG_E_Person_Offenses_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Result,NAMED('DBG_E_Person_Property_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Event_Result,NAMED('DBG_E_Person_Property_Event_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Result,NAMED('DBG_E_Person_S_S_N_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Result,NAMED('DBG_E_Professional_License_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Person_Result,NAMED('DBG_E_Professional_License_Person_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Result,NAMED('DBG_E_Property_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Result,NAMED('DBG_E_Property_Event_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Result,NAMED('DBG_E_Watercraft_Owner_Result_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Lien_Judgment_Intermediate_13,NAMED('DBG_E_Lien_Judgment_Intermediate_13_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Lien_Judgment_Intermediate_12,NAMED('DBG_E_Person_Lien_Judgment_Intermediate_12_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_11,NAMED('DBG_E_Person_Intermediate_11_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_10,NAMED('DBG_E_Person_Intermediate_10_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_9,NAMED('DBG_E_Person_Intermediate_9_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_8,NAMED('DBG_E_Bankruptcy_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_8,NAMED('DBG_E_Criminal_Offense_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_8,NAMED('DBG_E_Education_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_8,NAMED('DBG_E_Person_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_8,NAMED('DBG_E_Person_Property_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_8,NAMED('DBG_E_Property_Event_Intermediate_8_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_7,NAMED('DBG_E_Bankruptcy_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_7,NAMED('DBG_E_Criminal_Offense_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_7,NAMED('DBG_E_Education_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_7,NAMED('DBG_E_Inquiry_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_7,NAMED('DBG_E_Person_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_7,NAMED('DBG_E_Person_Property_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_7,NAMED('DBG_E_Property_Event_Intermediate_7_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_6,NAMED('DBG_E_Bankruptcy_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_6,NAMED('DBG_E_Criminal_Offense_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_6,NAMED('DBG_E_Education_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_6,NAMED('DBG_E_Inquiry_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_6,NAMED('DBG_E_Person_Property_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_6,NAMED('DBG_E_Person_S_S_N_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_6,NAMED('DBG_E_Property_Event_Intermediate_6_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_5,NAMED('DBG_E_Bankruptcy_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_5,NAMED('DBG_E_Criminal_Offense_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_5,NAMED('DBG_E_Education_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_5,NAMED('DBG_E_Inquiry_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_5,NAMED('DBG_E_Person_Property_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_5,NAMED('DBG_E_Person_S_S_N_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_5,NAMED('DBG_E_Professional_License_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_5,NAMED('DBG_E_Property_Event_Intermediate_5_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_4,NAMED('DBG_E_Bankruptcy_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_4,NAMED('DBG_E_Criminal_Offense_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_4,NAMED('DBG_E_Education_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Inquiry_Intermediate_4,NAMED('DBG_E_Inquiry_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_4,NAMED('DBG_E_Person_Property_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_4,NAMED('DBG_E_Person_S_S_N_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_4,NAMED('DBG_E_Professional_License_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_4,NAMED('DBG_E_Property_Event_Intermediate_4_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_3,NAMED('DBG_E_Address_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_3,NAMED('DBG_E_Aircraft_Owner_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_3,NAMED('DBG_E_Bankruptcy_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_3,NAMED('DBG_E_Criminal_Offense_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_3,NAMED('DBG_E_Education_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Intermediate_3,NAMED('DBG_E_Email_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_3,NAMED('DBG_E_Person_Property_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_3,NAMED('DBG_E_Professional_License_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Intermediate_3,NAMED('DBG_E_Property_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_3,NAMED('DBG_E_Property_Event_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_3,NAMED('DBG_E_Watercraft_Owner_Intermediate_3_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Address_Intermediate_2,NAMED('DBG_E_Address_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Aircraft_Owner_Intermediate_2,NAMED('DBG_E_Aircraft_Owner_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_2,NAMED('DBG_E_Bankruptcy_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_2,NAMED('DBG_E_Criminal_Offense_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_2,NAMED('DBG_E_Education_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Email_Intermediate_2,NAMED('DBG_E_Email_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_2,NAMED('DBG_E_Input_P_I_I_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_2,NAMED('DBG_E_Person_Property_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_2,NAMED('DBG_E_Professional_License_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_2,NAMED('DBG_E_Property_Event_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Watercraft_Owner_Intermediate_2,NAMED('DBG_E_Watercraft_Owner_Intermediate_2_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Bankruptcy_Intermediate_1,NAMED('DBG_E_Bankruptcy_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Criminal_Offense_Intermediate_1,NAMED('DBG_E_Criminal_Offense_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Education_Intermediate_1,NAMED('DBG_E_Education_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_1,NAMED('DBG_E_Input_P_I_I_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_1,NAMED('DBG_E_Person_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Property_Intermediate_1,NAMED('DBG_E_Person_Property_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Professional_License_Intermediate_1,NAMED('DBG_E_Professional_License_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Property_Event_Intermediate_1,NAMED('DBG_E_Property_Event_Intermediate_1_Q_F_C_R_A_Person_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Person_Annotated,NAMED('DBG_E_Person_Annotated_Q_F_C_R_A_Person_Attributes_V1_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
