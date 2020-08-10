//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Input_P_I_I,B_Input_P_I_I_1,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Property_4,B_Property_5,CFG_Compile,E_Address,E_Geo_Link,E_Input_P_I_I,E_Person,E_Property,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Input_Attributes_V1(DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),p_lexid(OVERRIDE:Subject_:0|DEFAULT:P___Lex_I_D_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
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
    SHARED __d0_Prefiltered := __d0_Geo_Link_I_D__Mapped((KEL.typ.uid)G_ProcUID <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'InputPIIDataset'));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7(__in,__cfg_Local).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Property_5_Local := MODULE(B_Property_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered.__Result;
  END;
  SHARED B_Address_4_Local := MODULE(B_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
  END;
  SHARED B_Input_P_I_I_4_Local := MODULE(B_Input_P_I_I_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_5(__in,__cfg_Local).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5;
  END;
  SHARED B_Property_4_Local := MODULE(B_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Property_5(__in,__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
  END;
  SHARED B_Input_P_I_I_3_Local := MODULE(B_Input_P_I_I_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_4(__in,__cfg_Local).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4;
    SHARED TYPEOF(B_Property_4(__in,__cfg_Local).__ENH_Property_4) __ENH_Property_4 := B_Property_4_Local.__ENH_Property_4;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_2_Local := MODULE(B_Input_P_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Input_P_I_I_1_Local := MODULE(B_Input_P_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
  END;
  SHARED B_Input_P_I_I_Local := MODULE(B_Input_P_I_I(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1(__in,__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
  END;
  SHARED TYPEOF(B_Input_P_I_I(__in,__cfg_Local).__ENH_Input_P_I_I) __ENH_Input_P_I_I := B_Input_P_I_I_Local.__ENH_Input_P_I_I;
  SHARED __EE6200225 := __ENH_Input_P_I_I;
  SHARED __ST58721_Layout := RECORD
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
    KEL.typ.str P___Inp_Addr_S_S_N_Flag_ := '';
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
    KEL.typ.nstr Input_First_Cln_Name_Value_;
    KEL.typ.nstr Input_Middle_Cln_Name_Value_;
    KEL.typ.nstr Input_Last_Cln_Name_Value_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST58721_Layout __ND6200230__Project(B_Input_P_I_I(__in,__cfg_Local).__ST125150_Layout __PP6200226) := TRANSFORM
    SELF.G___Proc_U_I_D_ := __PP6200226.UID;
    SELF.P___Inp_Acct_ := __PP6200226.Input_Account_Value_;
    SELF.P___Inp_Lex_I_D_ := __PP6200226.Input_Lex_I_D_Value_;
    SELF.P___Inp_Name_First_ := __PP6200226.Input_First_Name_Value_;
    SELF.P___Inp_Name_Mid_ := __PP6200226.Input_Middle_Name_Value_;
    SELF.P___Inp_Name_Last_ := __PP6200226.Input_Last_Name_Value_;
    SELF.P___Inp_Addr_Line1_ := __PP6200226.Input_Street_Value_;
    SELF.P___Inp_Addr_Line2_ := __PP6200226.P___Inp_Addr_Line2_Value_;
    SELF.P___Inp_Addr_City_ := __PP6200226.Input_City_Value_;
    SELF.P___Inp_Addr_State_ := __PP6200226.Input_State_Value_;
    SELF.P___Inp_Addr_Zip_ := __PP6200226.Input_Zip_Value_;
    SELF.P___Inp_S_S_N_ := __PP6200226.Input_S_S_N_Value_;
    SELF.P___Inp_D_O_B_ := __PP6200226.Input_D_O_B_Value_;
    SELF.P___Inp_D_L_ := __PP6200226.Input_D_L_Value_;
    SELF.P___Inp_D_L_State_ := __PP6200226.Input_D_L_State_Value_;
    SELF.P___Inp_Phone_Home_ := __PP6200226.Input_Home_Phone_Value_;
    SELF.P___Inp_Phone_Work_ := __PP6200226.Input_Work_Phone_Value_;
    SELF.P___Inp_Email_ := __PP6200226.Input_Email_Value_;
    SELF.P___Inp_I_P_Addr_ := __PP6200226.Input_I_P_Addr_Value_;
    SELF.P___Inp_Arch_Dt_ := __PP6200226.Input_Archive_Date_Value_;
    SELF.P___Inp_Acct_Flag_ := __PP6200226.P___Inp_Acct_Flag_Value_;
    SELF.P___Inp_Lex_I_D_Flag_ := __PP6200226.P___Inp_Lex_I_D_Flag_Value_;
    SELF.P___Inp_Name_First_Flag_ := __PP6200226.P___Inp_Name_First_Flag_Value_;
    SELF.P___Inp_Name_Mid_Flag_ := __PP6200226.P___Inp_Name_Mid_Flag_Value_;
    SELF.P___Inp_Name_Last_Flag_ := __PP6200226.P___Inp_Name_Last_Flag_Value_;
    SELF.P___Inp_Addr_St_Flag_ := __PP6200226.P___Inp_Addr_St_Flag_Value_;
    SELF.P___Inp_Addr_City_Flag_ := __PP6200226.P___Inp_Addr_City_Flag_Value_;
    SELF.P___Inp_Addr_State_Flag_ := __PP6200226.P___Inp_Addr_State_Flag_Value_;
    SELF.P___Inp_Addr_Zip_Flag_ := __PP6200226.P___Inp_Addr_Zip_Flag_Value_;
    SELF.P___Inp_Addr_S_S_N_Flag_ := __PP6200226.P___Inp_Addr_S_S_N_Flag_Value_;
    SELF.P___Inp_D_O_B_Flag_ := __PP6200226.P___Inp_D_O_B_Flag_Value_;
    SELF.P___Inp_D_L_Flag_ := __PP6200226.P___Inp_D_L_Flag_Value_;
    SELF.P___Inp_D_L_State_Flag_ := __PP6200226.P___Inp_D_L_State_Flag_Value_;
    SELF.P___Inp_Phone_Home_Flag_ := __PP6200226.P___Inp_Phone_Home_Flag_Value_;
    SELF.P___Inp_Phone_Work_Flag_ := __PP6200226.P___Inp_Phone_Work_Flag_Value_;
    SELF.P___Inp_Email_Flag_ := __PP6200226.P___Inp_Email_Flag_Value_;
    SELF.P___Inp_I_P_Addr_Flag_ := __PP6200226.P___Inp_I_P_Addr_Flag_Value_;
    SELF.P___Inp_Arch_Dt_Flag_ := __PP6200226.P___Inp_Arch_Dt_Flag_Value_;
    SELF.P___Inp_Cln_Name_Prfx_ := __PP6200226.Input_Prefix_Clean_Value_;
    SELF.P___Inp_Cln_Name_First_ := __PP6200226.Input_First_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Mid_ := __PP6200226.Input_Middle_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Last_ := __PP6200226.Input_Last_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Sffx_ := __PP6200226.Input_Suffix_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_ := __PP6200226.Input_Primary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Pre_Dir_ := __PP6200226.Input_Pre_Direction_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Name_ := __PP6200226.Input_Primary_Name_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Sffx_ := __PP6200226.Input_Address_Suffix_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Post_Dir_ := __PP6200226.Input_Post_Direction_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Unit_Desig_ := __PP6200226.Input_Unit_Desig_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Sec_Rng_ := __PP6200226.Input_Secondary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_City_ := __PP6200226.Input_City_Clean_Value_;
    SELF.P___Inp_Cln_Addr_City_Post_ := __PP6200226.Input_City_Post_Clean_Value_;
    SELF.P___Inp_Cln_Addr_State_ := __PP6200226.Input_State_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_ := __PP6200226.Input_Zip5_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip4_ := __PP6200226.Input_Zip4_Clean_Value_;
    SELF.P___Inp_Cln_Addr_St_ := __PP6200226.Input_Street_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Full_ := __PP6200226.Input_Full_Address_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Lat_ := __PP6200226.Input_Latitude_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Lng_ := __PP6200226.Input_Longitude_Clean_Value_;
    SELF.P___Inp_Cln_Addr_State_Code_ := __PP6200226.Input_State_Code_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Cnty_ := __PP6200226.Input_County_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Geo_ := __PP6200226.Input_Geoblock_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Type_ := __PP6200226.Input_Address_Type_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Status_ := __PP6200226.Input_Address_Status_Clean_Value_;
    SELF.P___Inp_Cln_S_S_N_ := __PP6200226.Input_S_S_N_Clean_Value_;
    SELF.P___Inp_Cln_D_O_B_ := __PP6200226.Input_D_O_B_Clean_Value_;
    SELF.P___Inp_Cln_D_L_ := __PP6200226.Input_D_L_Clean_Value_;
    SELF.P___Inp_Cln_D_L_State_ := __PP6200226.Input_D_L_State_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Home_ := __PP6200226.Input_Home_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Work_ := __PP6200226.Input_Work_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Email_ := __PP6200226.Input_Email_Clean_Value_;
    SELF.P___Inp_Cln_Arch_Dt_ := __PP6200226.Input_Archive_Date_Clean_Value_;
    SELF.P___Inp_Cln_Name_Prfx_Flag_ := __PP6200226.P___Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.P___Inp_Cln_Name_First_Flag_ := __PP6200226.P___Inp_Cln_Name_First_Flag_Value_;
    SELF.P___Inp_Cln_Name_Mid_Flag_ := __PP6200226.P___Inp_Cln_Name_Mid_Flag_Value_;
    SELF.P___Inp_Cln_Name_Last_Flag_ := __PP6200226.P___Inp_Cln_Name_Last_Flag_Value_;
    SELF.P___Inp_Cln_Name_Sffx_Flag_ := __PP6200226.P___Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_Flag_ := __PP6200226.P___Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Pre_Dir_Flag_ := __PP6200226.P___Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Name_Flag_ := __PP6200226.P___Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Sffx_Flag_ := __PP6200226.P___Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Post_Dir_Flag_ := __PP6200226.P___Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Unit_Desig_Flag_ := __PP6200226.P___Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Sec_Rng_Flag_ := __PP6200226.P___Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_City_Flag_ := __PP6200226.P___Inp_Cln_Addr_City_Flag_Value_;
    SELF.P___Inp_Cln_Addr_City_Post_Flag_ := __PP6200226.P___Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.P___Inp_Cln_Addr_State_Flag_ := __PP6200226.P___Inp_Cln_Addr_State_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_Flag_ := __PP6200226.P___Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Zip4_Flag_ := __PP6200226.P___Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.P___Inp_Val_Addr_Zip_Bad_Len_Flag_ := __PP6200226.P___Inp_Val_Addr_Zip_Bad_Len_Flag_Value_;
    SELF.P___Inp_Val_Addr_Zip_All_Zero_Flag_ := __PP6200226.P___Inp_Val_Addr_Zip_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Addr_State_Bad_Abbr_Flag_ := __PP6200226.P___Inp_Val_Addr_State_Bad_Abbr_Flag_Value_;
    SELF.P___Inp_Cln_Addr_St_Flag_ := __PP6200226.P___Inp_Cln_Addr_St_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Full_Flag_ := __PP6200226.P___Inp_Cln_Addr_Full_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Lat_Flag_ := __PP6200226.P___Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Lng_Flag_ := __PP6200226.P___Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Cnty_Flag_ := __PP6200226.P___Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Geo_Flag_ := __PP6200226.P___Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Type_Flag_ := __PP6200226.P___Inp_Cln_Addr_Type_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Status_Flag_ := __PP6200226.P___Inp_Cln_Addr_Status_Flag_Value_;
    SELF.P___Inp_Cln_S_S_N_Flag_ := __PP6200226.P___Inp_Cln_S_S_N_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bad_Char_Flag_ := __PP6200226.P___Inp_Val_S_S_N_Bad_Char_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bad_Len_Flag_ := __PP6200226.P___Inp_Val_S_S_N_Bad_Len_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bogus_Flag_ := __PP6200226.P___Inp_Val_S_S_N_Bogus_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Non_S_S_A_Flag_ := __PP6200226.P___Inp_Val_S_S_N_Non_S_S_A_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_ := __PP6200226.P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_Value_;
    SELF.P___Inp_Cln_D_O_B_Flag_ := __PP6200226.P___Inp_Cln_D_O_B_Flag_Value_;
    SELF.P___Inp_Cln_D_L_Flag_ := __PP6200226.P___Inp_Cln_D_L_Flag_Value_;
    SELF.P___Inp_Cln_D_L_State_Flag_ := __PP6200226.P___Inp_Cln_D_L_State_Flag_Value_;
    SELF.P___Inp_Cln_Phone_Home_Flag_ := __PP6200226.P___Inp_Cln_Phone_Home_Flag_Value_;
    SELF.P___Inp_Cln_Phone_Work_Flag_ := __PP6200226.P___Inp_Cln_Phone_Work_Flag_Value_;
    SELF.P___Inp_Cln_Email_Flag_ := __PP6200226.P___Inp_Cln_Email_Flag_Value_;
    SELF.P___Inp_Cln_I_P_Addr_Flag_ := __PP6200226.P___Inp_Cln_I_P_Addr_Flag_Value_;
    SELF.P___Inp_Val_Email_Bogus_Flag_ := __PP6200226.P___Inp_Val_Email_Bogus_Flag_Value_;
    SELF.P___Inp_Val_Email_User_All_Zero_Flag_ := __PP6200226.P___Inp_Val_Email_User_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Email_User_Bad_Char_Flag_ := __PP6200226.P___Inp_Val_Email_User_Bad_Char_Flag_Value_;
    SELF.P___Inp_Val_Email_Dom_All_Zero_Flag_ := __PP6200226.P___Inp_Val_Email_Dom_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Email_Dom_Bad_Char_Flag_ := __PP6200226.P___Inp_Val_Email_Dom_Bad_Char_Flag_Value_;
    SELF.P___Inp_Cln_Arch_Dt_Flag_ := __PP6200226.P___Inp_Cln_Arch_Dt_Flag_Value_;
    SELF.Rep_Number_ := __PP6200226.I_Rep_Number_Value_;
    SELF := __PP6200226;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE6200225,__ND6200230__Project(LEFT)));
END;
