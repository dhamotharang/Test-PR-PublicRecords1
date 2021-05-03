//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Input_P_I_I_10,B_Input_P_I_I_11,B_Input_P_I_I_12,B_Input_P_I_I_13,B_Input_P_I_I_14,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_S_S_N_Summary,B_S_S_N_Summary_1,B_S_S_N_Summary_2,B_S_S_N_Summary_3,B_S_S_N_Summary_4,B_S_S_N_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic(KEL.typ.str __PSSN_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),p_lexid(OVERRIDE:Subject_:0|DEFAULT:P___Lex_I_D_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),Input_Clean_Email_(OVERRIDE:Input_Clean_Email_:0),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'|OVERRIDE:Input_Clean_Phone_:0|OVERRIDE:Telephone_Summary_:0),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'|OVERRIDE:Input_Clean_S_S_N_:0|OVERRIDE:Social_Summary_:0),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),Slim_Location_(DEFAULT:Slim_Location_:0),zip5(DEFAULT:Z_I_P5_:0),Name_Summ_(DEFAULT:Name_Summ_:0),Location_Summary_(DEFAULT:Location_Summary_:0),currentaddrprimrng(DEFAULT:Current_Addr_Prim_Rng_:\'\'),currentaddrpredir(DEFAULT:Current_Addr_Pre_Dir_:\'\'),currentaddrprimname(DEFAULT:Current_Addr_Prim_Name_:\'\'),currentaddrsffx(DEFAULT:Current_Addr_Sffx_:\'\'),currentaddrsecrng(DEFAULT:Current_Addr_Sec_Rng_:\'\'),currentaddrstate(DEFAULT:Current_Addr_State_:\'\'),currentaddrzip5(DEFAULT:Current_Addr_Zip5_:\'\'),currentaddrzip4(DEFAULT:Current_Addr_Zip4_:\'\'),currentaddrstatecode(DEFAULT:Current_Addr_State_Code_:\'\'),currentaddrcnty(DEFAULT:Current_Addr_Cnty_:\'\'),currentaddrgeo(DEFAULT:Current_Addr_Geo_:\'\'),currentaddrcity(DEFAULT:Current_Addr_City_:\'\'),currentaddrpostdir(DEFAULT:Current_Addr_Post_Dir_:\'\'),currentaddrlat(DEFAULT:Current_Addr_Lat_:\'\'),currentaddrlng(DEFAULT:Current_Addr_Lng_:\'\'),currentaddrunitdesignation(DEFAULT:Current_Addr_Unit_Designation_:\'\'),currentaddrtype(DEFAULT:Current_Addr_Type_:\'\'),currentaddrstatus(DEFAULT:Current_Addr_Status_:\'\'),currentaddrdatefirstseen(DEFAULT:Current_Addr_Date_First_Seen_:DATE),currentaddrdatelastseen(DEFAULT:Current_Addr_Date_Last_Seen_:DATE),currentaddrfull(DEFAULT:Current_Addr_Full_:\'\'),Current_Address_(DEFAULT:Current_Address_:0),previousaddrprimrng(DEFAULT:Previous_Addr_Prim_Rng_:\'\'),previousaddrpredir(DEFAULT:Previous_Addr_Pre_Dir_:\'\'),previousaddrprimname(DEFAULT:Previous_Addr_Prim_Name_:\'\'),previousaddrsffx(DEFAULT:Previous_Addr_Sffx_:\'\'),previousaddrsecrng(DEFAULT:Previous_Addr_Sec_Rng_:\'\'),previousaddrstate(DEFAULT:Previous_Addr_State_:\'\'),previousaddrzip5(DEFAULT:Previous_Addr_Zip5_:\'\'),previousaddrzip4(DEFAULT:Previous_Addr_Zip4_:\'\'),previousaddrstatecode(DEFAULT:Previous_Addr_State_Code_:\'\'),previousaddrcnty(DEFAULT:Previous_Addr_Cnty_:\'\'),previousaddrgeo(DEFAULT:Previous_Addr_Geo_:\'\'),previousaddrcity(DEFAULT:Previous_Addr_City_:\'\'),previousaddrpostdir(DEFAULT:Previous_Addr_Post_Dir_:\'\'),previousaddrlat(DEFAULT:Previous_Addr_Lat_:\'\'),previousaddrlng(DEFAULT:Previous_Addr_Lng_:\'\'),previousaddrunitdesignation(DEFAULT:Previous_Addr_Unit_Designation_:\'\'),previousaddrtype(DEFAULT:Previous_Addr_Type_:\'\'),previousaddrstatus(DEFAULT:Previous_Addr_Status_:\'\'),previousaddrdatefirstseen(DEFAULT:Previous_Addr_Date_First_Seen_:DATE),previousaddrdatelastseen(DEFAULT:Previous_Addr_Date_Last_Seen_:DATE),previousaddrfull(DEFAULT:Previous_Addr_Full_:\'\'),Previous_Address_(DEFAULT:Previous_Address_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
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
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Summary_Filtered := MODULE(E_S_S_N_Summary(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Input_P_I_I_14_Local := MODULE(B_Input_P_I_I_14(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_13_Local := MODULE(B_Input_P_I_I_13(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_14(__in,__cfg_Local).__ENH_Input_P_I_I_14) __ENH_Input_P_I_I_14 := B_Input_P_I_I_14_Local.__ENH_Input_P_I_I_14;
  END;
  SHARED B_Input_P_I_I_12_Local := MODULE(B_Input_P_I_I_12(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_13(__in,__cfg_Local).__ENH_Input_P_I_I_13) __ENH_Input_P_I_I_13 := B_Input_P_I_I_13_Local.__ENH_Input_P_I_I_13;
  END;
  SHARED B_Input_P_I_I_11_Local := MODULE(B_Input_P_I_I_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_12(__in,__cfg_Local).__ENH_Input_P_I_I_12) __ENH_Input_P_I_I_12 := B_Input_P_I_I_12_Local.__ENH_Input_P_I_I_12;
  END;
  SHARED B_Input_P_I_I_10_Local := MODULE(B_Input_P_I_I_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_11(__in,__cfg_Local).__ENH_Input_P_I_I_11) __ENH_Input_P_I_I_11 := B_Input_P_I_I_11_Local.__ENH_Input_P_I_I_11;
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_10(__in,__cfg_Local).__ENH_Input_P_I_I_10) __ENH_Input_P_I_I_10 := B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7(__in,__cfg_Local).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_S_S_N_Summary_5_Local := MODULE(B_S_S_N_Summary_5(__in,__cfg_Local))
    SHARED TYPEOF(E_S_S_N_Summary(__in,__cfg_Local).__Result) __E_S_S_N_Summary := E_S_S_N_Summary_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_4_Local := MODULE(B_Input_P_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_S_S_N_Summary_4_Local := MODULE(B_S_S_N_Summary_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
    SHARED TYPEOF(B_S_S_N_Summary_5(__in,__cfg_Local).__ENH_S_S_N_Summary_5) __ENH_S_S_N_Summary_5 := B_S_S_N_Summary_5_Local.__ENH_S_S_N_Summary_5;
  END;
  SHARED B_Input_P_I_I_3_Local := MODULE(B_Input_P_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
  END;
  SHARED B_S_S_N_Summary_3_Local := MODULE(B_S_S_N_Summary_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_S_S_N_Summary_4(__in,__cfg_Local).__ENH_S_S_N_Summary_4) __ENH_S_S_N_Summary_4 := B_S_S_N_Summary_4_Local.__ENH_S_S_N_Summary_4;
  END;
  SHARED B_S_S_N_Summary_2_Local := MODULE(B_S_S_N_Summary_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_S_S_N_Summary_3(__in,__cfg_Local).__ENH_S_S_N_Summary_3) __ENH_S_S_N_Summary_3 := B_S_S_N_Summary_3_Local.__ENH_S_S_N_Summary_3;
  END;
  SHARED B_S_S_N_Summary_1_Local := MODULE(B_S_S_N_Summary_1(__in,__cfg_Local))
    SHARED TYPEOF(B_S_S_N_Summary_2(__in,__cfg_Local).__ENH_S_S_N_Summary_2) __ENH_S_S_N_Summary_2 := B_S_S_N_Summary_2_Local.__ENH_S_S_N_Summary_2;
  END;
  SHARED B_S_S_N_Summary_Local := MODULE(B_S_S_N_Summary(__in,__cfg_Local))
    SHARED TYPEOF(B_S_S_N_Summary_1(__in,__cfg_Local).__ENH_S_S_N_Summary_1) __ENH_S_S_N_Summary_1 := B_S_S_N_Summary_1_Local.__ENH_S_S_N_Summary_1;
  END;
  SHARED TYPEOF(B_S_S_N_Summary(__in,__cfg_Local).__ENH_S_S_N_Summary) __ENH_S_S_N_Summary := B_S_S_N_Summary_Local.__ENH_S_S_N_Summary;
  SHARED __EE10500396 := __ENH_S_S_N_Summary;
  SHARED __EE10500584 := __EE10500396(__T(__OP2(__EE10500396.S_S_N_,=,__CN(__PSSN_in))));
  SHARED __ST82187_Layout := RECORD
    KEL.typ.nbool Exp1_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg_Local).__ST81614_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST82187_Layout __ND10500592__Project(B_S_S_N_Summary(__in,__cfg_Local).__ST164300_Layout __PP10500585) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP10500585.P___Inp_Cln_S_S_N_,=,__PP10500585.S_S_N_);
    SELF := __PP10500585;
  END;
  SHARED __ST82187_Layout __ND10500592__Rollup(__ST82187_Layout __r, DATASET(__ST82187_Layout) __recs) := TRANSFORM
    __recs_S_S_N_Summary_Source_List_Sorted_ := NORMALIZE(__recs,__T(LEFT.S_S_N_Summary_Source_List_Sorted_),TRANSFORM(B_S_S_N_Summary_3(__in,__cfg_Local).__ST81614_Layout,SELF:=RIGHT));
    __recs_S_S_N_Summary_Source_List_Sorted__allnull := NOT EXISTS(__recs(__NN(S_S_N_Summary_Source_List_Sorted_)));
    SELF.S_S_N_Summary_Source_List_Sorted_ := __BN(PROJECT(TABLE(__recs_S_S_N_Summary_Source_List_Sorted_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Primary_Name_Address_,Primary_Range_Address_,Zip_Address_,Translated_Source_Code_,Source_Date_First_Seen_,Source_Date_Last_Seen_},Primary_Name_Address_,Primary_Range_Address_,Zip_Address_,Translated_Source_Code_,Source_Date_First_Seen_,Source_Date_Last_Seen_),B_S_S_N_Summary_3(__in,__cfg_Local).__ST81614_Layout),__recs_S_S_N_Summary_Source_List_Sorted__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  EXPORT Res0 := __UNWRAP(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE10500584,__ND10500592__Project(LEFT)),'S_S_N_Summary_Source_List_Sorted_','s_s_n_summary_source_list_sorted_','clean','__recordcount,archive___date_,date_first_seen_,date_last_seen_,hybrid_archive_date_,vault_date_last_seen_'),Exp1_,P___Inp_Cln_Phone_Home_,S_S_N_Summary_Source_List_Sorted_Clean,P_I___Src_W_Inp_A_S_List_Ev_,P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_,P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_,P_I___Src_W_Inp_S_D_List_Ev_,P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_,P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_,P_I___Src_W_Inp_P_S_List_Ev_,P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_,P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_,P_I___Src_W_Inp_F_L_S_List_Ev_,P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_,P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_,ALL),GROUP,__ND10500592__Rollup(ROW(LEFT,__ST82187_Layout), PROJECT(ROWS(LEFT),__ST82187_Layout))));
  EXPORT DBG_E_Input_P_I_I_PreEntity := __UNWRAP(E_Input_P_I_I_Params(__in,__cfg_Local).InData);
  EXPORT DBG_E_Input_P_I_I_Result := __UNWRAP(E_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_S_S_N_Summary_Result := __UNWRAP(E_S_S_N_Summary_Filtered.__Result);
  EXPORT DBG_E_Input_P_I_I_Intermediate_14 := __UNWRAP(B_Input_P_I_I_14_Local.__ENH_Input_P_I_I_14);
  EXPORT DBG_E_Input_P_I_I_Intermediate_13 := __UNWRAP(B_Input_P_I_I_13_Local.__ENH_Input_P_I_I_13);
  EXPORT DBG_E_Input_P_I_I_Intermediate_12 := __UNWRAP(B_Input_P_I_I_12_Local.__ENH_Input_P_I_I_12);
  EXPORT DBG_E_Input_P_I_I_Intermediate_11 := __UNWRAP(B_Input_P_I_I_11_Local.__ENH_Input_P_I_I_11);
  EXPORT DBG_E_Input_P_I_I_Intermediate_10 := __UNWRAP(B_Input_P_I_I_10_Local.__ENH_Input_P_I_I_10);
  EXPORT DBG_E_Input_P_I_I_Intermediate_9 := __UNWRAP(B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_5 := __UNWRAP(B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5);
  EXPORT DBG_E_S_S_N_Summary_Intermediate_5 := __UNWRAP(B_S_S_N_Summary_5_Local.__ENH_S_S_N_Summary_5);
  EXPORT DBG_E_Input_P_I_I_Intermediate_4 := __UNWRAP(B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4);
  EXPORT DBG_E_S_S_N_Summary_Intermediate_4 := __UNWRAP(B_S_S_N_Summary_4_Local.__ENH_S_S_N_Summary_4);
  EXPORT DBG_E_Input_P_I_I_Intermediate_3 := __UNWRAP(B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3);
  EXPORT DBG_E_S_S_N_Summary_Intermediate_3 := __UNWRAP(B_S_S_N_Summary_3_Local.__ENH_S_S_N_Summary_3);
  EXPORT DBG_E_S_S_N_Summary_Intermediate_2 := __UNWRAP(B_S_S_N_Summary_2_Local.__ENH_S_S_N_Summary_2);
  EXPORT DBG_E_S_S_N_Summary_Intermediate_1 := __UNWRAP(B_S_S_N_Summary_1_Local.__ENH_S_S_N_Summary_1);
  EXPORT DBG_E_S_S_N_Summary_Annotated := __UNWRAP(B_S_S_N_Summary_Local.__ENH_S_S_N_Summary);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_P_I_I_PreEntity_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Result,NAMED('DBG_E_S_S_N_Summary_Result_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_14,NAMED('DBG_E_Input_P_I_I_Intermediate_14_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_13,NAMED('DBG_E_Input_P_I_I_Intermediate_13_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_12,NAMED('DBG_E_Input_P_I_I_Intermediate_12_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_11,NAMED('DBG_E_Input_P_I_I_Intermediate_11_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_10,NAMED('DBG_E_Input_P_I_I_Intermediate_10_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_9,NAMED('DBG_E_Input_P_I_I_Intermediate_9_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Intermediate_5,NAMED('DBG_E_S_S_N_Summary_Intermediate_5_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Intermediate_4,NAMED('DBG_E_S_S_N_Summary_Intermediate_4_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Intermediate_3,NAMED('DBG_E_S_S_N_Summary_Intermediate_3_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Intermediate_2,NAMED('DBG_E_S_S_N_Summary_Intermediate_2_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Intermediate_1,NAMED('DBG_E_S_S_N_Summary_Intermediate_1_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_S_S_N_Summary_Annotated,NAMED('DBG_E_S_S_N_Summary_Annotated_Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
