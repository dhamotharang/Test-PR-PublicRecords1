﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_1,B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Input_P_I_I,B_Input_P_I_I_1,B_Input_P_I_I_2,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Input_P_I_I_5,B_Input_P_I_I_6,B_Input_P_I_I_7,B_Input_P_I_I_8,B_Input_P_I_I_9,B_Inquiry_10,B_Inquiry_11,B_Inquiry_3,B_Inquiry_4,B_Inquiry_5,B_Inquiry_6,B_Inquiry_7,B_Inquiry_8,B_Inquiry_9,B_Property_4,B_Property_5,CFG_Compile,E_Address,E_Address_Inquiry,E_Address_Property,E_Email,E_Email_Inquiry,E_Geo_Link,E_Input_P_I_I,E_Inquiry,E_Person,E_Phone,E_Phone_Inquiry,E_Property,E_S_S_N_Inquiry,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT Q_Input_Attributes_V1_Hybrid(DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, KEL.typ.bool __PisFCRA, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'g_procuid(OVERRIDE:UID),p_lexid(OVERRIDE:Subject_:0|DEFAULT:P___Lex_I_D_:0),p_inpacct(DEFAULT:P___Inp_Acct_:\'\'),p_inplexid(DEFAULT:P___Inp_Lex_I_D_:0),p_inpnamefirst(DEFAULT:P___Inp_Name_First_:\'\'),p_inpnamemid(DEFAULT:P___Inp_Name_Mid_:\'\'),p_inpnamelast(DEFAULT:P___Inp_Name_Last_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),p_inpaddrline1(DEFAULT:P___Inp_Addr_Line1_:\'\'),p_inpaddrline2(DEFAULT:P___Inp_Addr_Line2_:\'\'),p_inpaddrcity(DEFAULT:P___Inp_Addr_City_:\'\'),p_inpaddrstate(DEFAULT:P___Inp_Addr_State_:\'\'),p_inpaddrzip(DEFAULT:P___Inp_Addr_Zip_:\'\'),p_inpphonehome(DEFAULT:P___Inp_Phone_Home_:\'\'),p_inpssn(DEFAULT:P___Inp_S_S_N_:\'\'),p_inpdob(DEFAULT:P___Inp_D_O_B_:\'\'),p_inpphonework(DEFAULT:P___Inp_Phone_Work_:\'\'),inputincomeecho(DEFAULT:Input_Income_Echo_:\'\'),p_inpdl(DEFAULT:P___Inp_D_L_:\'\'),p_inpdlstate(DEFAULT:P___Inp_D_L_State_:\'\'),inputbalanceecho(DEFAULT:Input_Balance_Echo_:\'\'),inputchargeoffdecho(DEFAULT:Input_Charge_Offd_Echo_:\'\'),inputformernameecho(DEFAULT:Input_Former_Name_Echo_:\'\'),p_inpemail(DEFAULT:P___Inp_Email_:\'\'),p_inpipaddr(DEFAULT:P___Inp_I_P_Addr_:\'\'),inputemploymentecho(DEFAULT:Input_Employment_Echo_:\'\'),p_inparchdt(DEFAULT:P___Inp_Arch_Dt_:\'\'),p_lexidscore(DEFAULT:P___Lex_I_D_Score_:0),p_inpclnnameprfx(DEFAULT:P___Inp_Cln_Name_Prfx_:\'\'),p_inpclnnamefirst(DEFAULT:P___Inp_Cln_Name_First_:\'\'),p_inpclnnamemid(DEFAULT:P___Inp_Cln_Name_Mid_:\'\'),p_inpclnnamelast(DEFAULT:P___Inp_Cln_Name_Last_:\'\'),p_inpclnnamesffx(DEFAULT:P___Inp_Cln_Name_Sffx_:\'\'),Prop_(DEFAULT:Prop_:0),Location_(DEFAULT:Location_:0),p_inpclnaddrprimrng(DEFAULT:P___Inp_Cln_Addr_Prim_Rng_:\'\'),p_inpclnaddrpredir(DEFAULT:P___Inp_Cln_Addr_Pre_Dir_:\'\'),p_inpclnaddrprimname(DEFAULT:P___Inp_Cln_Addr_Prim_Name_:\'\'),p_inpclnaddrsffx(DEFAULT:P___Inp_Cln_Addr_Sffx_:\'\'),p_inpclnaddrpostdir(DEFAULT:P___Inp_Cln_Addr_Post_Dir_:\'\'),p_inpclnaddrunitdesig(DEFAULT:P___Inp_Cln_Addr_Unit_Desig_:\'\'),p_inpclnaddrsecrng(DEFAULT:P___Inp_Cln_Addr_Sec_Rng_:\'\'),p_inpclnaddrcity(DEFAULT:P___Inp_Cln_Addr_City_:\'\'),p_inpclnaddrcitypost(DEFAULT:P___Inp_Cln_Addr_City_Post_:\'\'),p_inpclnaddrstate(DEFAULT:P___Inp_Cln_Addr_State_:\'\'),p_inpclnaddrzip5(DEFAULT:P___Inp_Cln_Addr_Zip5_:\'\'),p_inpclnaddrzip4(DEFAULT:P___Inp_Cln_Addr_Zip4_:\'\'),p_inpclnaddrlat(DEFAULT:P___Inp_Cln_Addr_Lat_:\'\'),p_inpclnaddrlng(DEFAULT:P___Inp_Cln_Addr_Lng_:\'\'),p_inpclnaddrstatecode(DEFAULT:P___Inp_Cln_Addr_State_Code_:\'\'),p_inpclnaddrcnty(DEFAULT:P___Inp_Cln_Addr_Cnty_:\'\'),p_inpclnaddrgeo(DEFAULT:P___Inp_Cln_Addr_Geo_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),p_inpclnaddrtype(DEFAULT:P___Inp_Cln_Addr_Type_:\'\'),p_inpclnaddrstatus(DEFAULT:P___Inp_Cln_Addr_Status_:\'\'),p_inpclnemail(DEFAULT:P___Inp_Cln_Email_:\'\'),Input_Clean_Email_(OVERRIDE:Input_Clean_Email_:0),p_inpclnphonehome(DEFAULT:P___Inp_Cln_Phone_Home_:\'\'|OVERRIDE:Input_Clean_Phone_:0),p_inpclnphonework(DEFAULT:P___Inp_Cln_Phone_Work_:\'\'),p_inpclndl(DEFAULT:P___Inp_Cln_D_L_:\'\'),p_inpclndlstate(DEFAULT:P___Inp_Cln_D_L_State_:\'\'),p_inpclndob(DEFAULT:P___Inp_Cln_D_O_B_:DATE),p_inpclnssn(DEFAULT:P___Inp_Cln_S_S_N_:\'\'|OVERRIDE:Input_Clean_S_S_N_:0),p_inpclnarchdt(DEFAULT:P___Inp_Cln_Arch_Dt_:0),g_procbusuid(DEFAULT:G___Proc_Bus_U_I_D_:0),phoneverificationbureau(DEFAULT:Phone_Verification_Bureau_:\'\'),dialindicator(DEFAULT:Dial_Indicator_:\'\'),pointid(DEFAULT:Point_I_D_:\'\'),nxxtype(DEFAULT:N_X_X_Type_:\'\'),zipmatch(DEFAULT:Z_I_P_Match_),coctype(DEFAULT:C_O_C_Type_:\'\'),ssc(DEFAULT:S_S_C_:\'\'),wirelessindicator(DEFAULT:Wireless_Indicator_:\'\'),repnumber(DEFAULT:Rep_Number_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
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
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Inquiry_Filtered := MODULE(E_Address_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Filtered := MODULE(E_Address_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Inquiry_Filtered := MODULE(E_Email_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Input_P_I_I_Filtered := MODULE(E_Input_P_I_I_Params(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Inquiry_Filtered := MODULE(E_Phone_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Filtered := MODULE(E_Property(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Inquiry_Filtered := MODULE(E_S_S_N_Inquiry(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.Era.nkdateFromNtimestamp(KEL.era.ToTimestampMinNull(__ds.Hybrid_Archive_Date_)),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Social_Security_Number_Filtered := MODULE(E_Social_Security_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Hybrid_Archive_Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Inquiry_11_Local := MODULE(B_Inquiry_11(__in,__cfg_Local))
    SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  END;
  SHARED B_Inquiry_10_Local := MODULE(B_Inquiry_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_11(__in,__cfg_Local).__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11_Local.__ENH_Inquiry_11;
  END;
  SHARED B_Input_P_I_I_9_Local := MODULE(B_Input_P_I_I_9(__in,__cfg_Local))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg_Local).__Result) __E_Input_P_I_I := E_Input_P_I_I_Filtered.__Result;
  END;
  SHARED B_Inquiry_9_Local := MODULE(B_Inquiry_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_10(__in,__cfg_Local).__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10_Local.__ENH_Inquiry_10;
  END;
  SHARED B_Input_P_I_I_8_Local := MODULE(B_Input_P_I_I_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_9(__in,__cfg_Local).__ENH_Input_P_I_I_9) __ENH_Input_P_I_I_9 := B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9;
  END;
  SHARED B_Inquiry_8_Local := MODULE(B_Inquiry_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_9(__in,__cfg_Local).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
  END;
  SHARED B_Input_P_I_I_7_Local := MODULE(B_Input_P_I_I_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_8(__in,__cfg_Local).__ENH_Input_P_I_I_8) __ENH_Input_P_I_I_8 := B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8;
  END;
  SHARED B_Inquiry_7_Local := MODULE(B_Inquiry_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_8(__in,__cfg_Local).__ENH_Inquiry_8) __ENH_Inquiry_8 := B_Inquiry_8_Local.__ENH_Inquiry_8;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_6_Local := MODULE(B_Input_P_I_I_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_7(__in,__cfg_Local).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7;
  END;
  SHARED B_Inquiry_6_Local := MODULE(B_Inquiry_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_7(__in,__cfg_Local).__ENH_Inquiry_7) __ENH_Inquiry_7 := B_Inquiry_7_Local.__ENH_Inquiry_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Input_P_I_I_5_Local := MODULE(B_Input_P_I_I_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Input_P_I_I_6(__in,__cfg_Local).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6;
  END;
  SHARED B_Inquiry_5_Local := MODULE(B_Inquiry_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_6(__in,__cfg_Local).__ENH_Inquiry_6) __ENH_Inquiry_6 := B_Inquiry_6_Local.__ENH_Inquiry_6;
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
  SHARED B_Inquiry_4_Local := MODULE(B_Inquiry_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Inquiry_5(__in,__cfg_Local).__ENH_Inquiry_5) __ENH_Inquiry_5 := B_Inquiry_5_Local.__ENH_Inquiry_5;
  END;
  SHARED B_Property_4_Local := MODULE(B_Property_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
    SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered.__Result;
    SHARED TYPEOF(B_Property_5(__in,__cfg_Local).__ENH_Property_5) __ENH_Property_5 := B_Property_5_Local.__ENH_Property_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
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
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_2_Local := MODULE(B_Input_P_I_I_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Email_Inquiry(__in,__cfg_Local).__Result) __E_Email_Inquiry := E_Email_Inquiry_Filtered.__Result;
    SHARED TYPEOF(B_Input_P_I_I_3(__in,__cfg_Local).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3;
    SHARED TYPEOF(B_Inquiry_3(__in,__cfg_Local).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3_Local.__ENH_Inquiry_3;
    SHARED TYPEOF(E_Phone_Inquiry(__in,__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered.__Result;
    SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered.__Result;
  END;
  SHARED B_Address_1_Local := MODULE(B_Address_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
  END;
  SHARED B_Input_P_I_I_1_Local := MODULE(B_Input_P_I_I_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg_Local).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2;
    SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  END;
  SHARED B_Input_P_I_I_Local := MODULE(B_Input_P_I_I(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_1(__in,__cfg_Local).__ENH_Address_1) __ENH_Address_1 := B_Address_1_Local.__ENH_Address_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg_Local).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1;
    SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered.__Result;
  END;
  SHARED TYPEOF(B_Input_P_I_I(__in,__cfg_Local).__ENH_Input_P_I_I) __ENH_Input_P_I_I := B_Input_P_I_I_Local.__ENH_Input_P_I_I;
  SHARED __EE11566825 := __ENH_Input_P_I_I;
  SHARED __ST119713_Layout := RECORD
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
    KEL.typ.str P_I___Inp_Addr_State_D_L_Avail_Flag_ := '';
    KEL.typ.int P_I___Inp_Addr_State_Voter_Avail_Flag_ := 0;
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
    KEL.typ.int P_I___Srch_Per_Inp_Phone_Cnt1_Y_ := 0;
    KEL.typ.int P_I___Srch_Lex_I_D_Per_Inp_Phone_Cnt1_Y_ := 0;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST119713_Layout __ND11566830__Project(B_Input_P_I_I(__in,__cfg_Local).__ST151805_Layout __PP11566826) := TRANSFORM
    SELF.G___Proc_U_I_D_ := __PP11566826.UID;
    SELF.P___Inp_Acct_ := __PP11566826.Input_Account_Value_;
    SELF.P___Inp_Lex_I_D_ := __PP11566826.Input_Lex_I_D_Value_;
    SELF.P___Inp_Name_First_ := __PP11566826.Input_First_Name_Value_;
    SELF.P___Inp_Name_Mid_ := __PP11566826.Input_Middle_Name_Value_;
    SELF.P___Inp_Name_Last_ := __PP11566826.Input_Last_Name_Value_;
    SELF.P___Inp_Addr_Line1_ := __PP11566826.Input_Street_Value_;
    SELF.P___Inp_Addr_Line2_ := __PP11566826.P___Inp_Addr_Line2_Value_;
    SELF.P___Inp_Addr_City_ := __PP11566826.Input_City_Value_;
    SELF.P___Inp_Addr_State_ := __PP11566826.Input_State_Value_;
    SELF.P___Inp_Addr_Zip_ := __PP11566826.Input_Zip_Value_;
    SELF.P___Inp_S_S_N_ := __PP11566826.Input_S_S_N_Value_;
    SELF.P___Inp_D_O_B_ := __PP11566826.Input_D_O_B_Value_;
    SELF.P___Inp_D_L_ := __PP11566826.Input_D_L_Value_;
    SELF.P___Inp_D_L_State_ := __PP11566826.Input_D_L_State_Value_;
    SELF.P___Inp_Phone_Home_ := __PP11566826.Input_Home_Phone_Value_;
    SELF.P___Inp_Phone_Work_ := __PP11566826.Input_Work_Phone_Value_;
    SELF.P___Inp_Email_ := __PP11566826.Input_Email_Value_;
    SELF.P___Inp_I_P_Addr_ := __PP11566826.Input_I_P_Addr_Value_;
    SELF.P___Inp_Arch_Dt_ := __PP11566826.Input_Archive_Date_Value_;
    SELF.P___Inp_Acct_Flag_ := __PP11566826.P___Inp_Acct_Flag_Value_;
    SELF.P___Inp_Lex_I_D_Flag_ := __PP11566826.P___Inp_Lex_I_D_Flag_Value_;
    SELF.P___Inp_Name_First_Flag_ := __PP11566826.P___Inp_Name_First_Flag_Value_;
    SELF.P___Inp_Name_Mid_Flag_ := __PP11566826.P___Inp_Name_Mid_Flag_Value_;
    SELF.P___Inp_Name_Last_Flag_ := __PP11566826.P___Inp_Name_Last_Flag_Value_;
    SELF.P___Inp_Addr_St_Flag_ := __PP11566826.P___Inp_Addr_St_Flag_Value_;
    SELF.P___Inp_Addr_City_Flag_ := __PP11566826.P___Inp_Addr_City_Flag_Value_;
    SELF.P___Inp_Addr_State_Flag_ := __PP11566826.P___Inp_Addr_State_Flag_Value_;
    SELF.P___Inp_Addr_Zip_Flag_ := __PP11566826.P___Inp_Addr_Zip_Flag_Value_;
    SELF.P___Inp_S_S_N_Flag_ := __PP11566826.P___Inp_S_S_N_Flag_Value_;
    SELF.P___Inp_D_O_B_Flag_ := __PP11566826.P___Inp_D_O_B_Flag_Value_;
    SELF.P___Inp_D_L_Flag_ := __PP11566826.P___Inp_D_L_Flag_Value_;
    SELF.P___Inp_D_L_State_Flag_ := __PP11566826.P___Inp_D_L_State_Flag_Value_;
    SELF.P___Inp_Phone_Home_Flag_ := __PP11566826.P___Inp_Phone_Home_Flag_Value_;
    SELF.P___Inp_Phone_Work_Flag_ := __PP11566826.P___Inp_Phone_Work_Flag_Value_;
    SELF.P___Inp_Email_Flag_ := __PP11566826.P___Inp_Email_Flag_Value_;
    SELF.P___Inp_I_P_Addr_Flag_ := __PP11566826.P___Inp_I_P_Addr_Flag_Value_;
    SELF.P___Inp_Arch_Dt_Flag_ := __PP11566826.P___Inp_Arch_Dt_Flag_Value_;
    SELF.P___Inp_Cln_Name_Prfx_ := __PP11566826.Input_Prefix_Clean_Value_;
    SELF.P___Inp_Cln_Name_First_ := __PP11566826.Input_First_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Mid_ := __PP11566826.Input_Middle_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Last_ := __PP11566826.Input_Last_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Sffx_ := __PP11566826.Input_Suffix_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_ := __PP11566826.Input_Primary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Pre_Dir_ := __PP11566826.Input_Pre_Direction_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Name_ := __PP11566826.Input_Primary_Name_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Sffx_ := __PP11566826.Input_Address_Suffix_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Post_Dir_ := __PP11566826.Input_Post_Direction_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Unit_Desig_ := __PP11566826.Input_Unit_Desig_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Sec_Rng_ := __PP11566826.Input_Secondary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_City_ := __PP11566826.Input_City_Clean_Value_;
    SELF.P___Inp_Cln_Addr_City_Post_ := __PP11566826.Input_City_Post_Clean_Value_;
    SELF.P___Inp_Cln_Addr_State_ := __PP11566826.Input_State_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_ := __PP11566826.Input_Zip5_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip4_ := __PP11566826.Input_Zip4_Clean_Value_;
    SELF.P___Inp_Cln_Addr_St_ := __PP11566826.Input_Street_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Full_ := __PP11566826.Input_Full_Address_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Lat_ := __PP11566826.Input_Latitude_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Lng_ := __PP11566826.Input_Longitude_Clean_Value_;
    SELF.P___Inp_Cln_Addr_State_Code_ := __PP11566826.Input_State_Code_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Cnty_ := __PP11566826.Input_County_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Geo_ := __PP11566826.Input_Geoblock_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Type_ := __PP11566826.Input_Address_Type_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Status_ := __PP11566826.Input_Address_Status_Clean_Value_;
    SELF.P___Inp_Cln_S_S_N_ := __PP11566826.Input_S_S_N_Clean_Value_;
    SELF.P___Inp_Cln_D_O_B_ := __PP11566826.Input_D_O_B_Clean_Value_;
    SELF.P___Inp_Cln_D_L_ := __PP11566826.Input_D_L_Clean_Value_;
    SELF.P___Inp_Cln_D_L_State_ := __PP11566826.Input_D_L_State_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Home_ := __PP11566826.Input_Home_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Work_ := __PP11566826.Input_Work_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Email_ := __PP11566826.Input_Email_Clean_Value_;
    SELF.P___Inp_Cln_Arch_Dt_ := __PP11566826.Input_Archive_Date_Clean_Value_;
    SELF.P___Inp_Cln_Name_Prfx_Flag_ := __PP11566826.P___Inp_Cln_Name_Prfx_Flag_Value_;
    SELF.P___Inp_Cln_Name_First_Flag_ := __PP11566826.P___Inp_Cln_Name_First_Flag_Value_;
    SELF.P___Inp_Cln_Name_Mid_Flag_ := __PP11566826.P___Inp_Cln_Name_Mid_Flag_Value_;
    SELF.P___Inp_Cln_Name_Last_Flag_ := __PP11566826.P___Inp_Cln_Name_Last_Flag_Value_;
    SELF.P___Inp_Cln_Name_Sffx_Flag_ := __PP11566826.P___Inp_Cln_Name_Sffx_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_Flag_ := __PP11566826.P___Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Pre_Dir_Flag_ := __PP11566826.P___Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Name_Flag_ := __PP11566826.P___Inp_Cln_Addr_Prim_Name_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Sffx_Flag_ := __PP11566826.P___Inp_Cln_Addr_Sffx_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Post_Dir_Flag_ := __PP11566826.P___Inp_Cln_Addr_Post_Dir_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Unit_Desig_Flag_ := __PP11566826.P___Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Sec_Rng_Flag_ := __PP11566826.P___Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_City_Flag_ := __PP11566826.P___Inp_Cln_Addr_City_Flag_Value_;
    SELF.P___Inp_Cln_Addr_City_Post_Flag_ := __PP11566826.P___Inp_Cln_Addr_City_Post_Flag_Value_;
    SELF.P___Inp_Cln_Addr_State_Flag_ := __PP11566826.P___Inp_Cln_Addr_State_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_Flag_ := __PP11566826.P___Inp_Cln_Addr_Zip5_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Zip4_Flag_ := __PP11566826.P___Inp_Cln_Addr_Zip4_Flag_Value_;
    SELF.P___Inp_Val_Addr_Zip_Bad_Len_Flag_ := __PP11566826.P___Inp_Val_Addr_Zip_Bad_Len_Flag_Value_;
    SELF.P___Inp_Val_Addr_Zip_All_Zero_Flag_ := __PP11566826.P___Inp_Val_Addr_Zip_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Addr_State_Bad_Abbr_Flag_ := __PP11566826.P___Inp_Val_Addr_State_Bad_Abbr_Flag_Value_;
    SELF.P___Inp_Cln_Addr_St_Flag_ := __PP11566826.P___Inp_Cln_Addr_St_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Full_Flag_ := __PP11566826.P___Inp_Cln_Addr_Full_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Lat_Flag_ := __PP11566826.P___Inp_Cln_Addr_Lat_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Lng_Flag_ := __PP11566826.P___Inp_Cln_Addr_Lng_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Cnty_Flag_ := __PP11566826.P___Inp_Cln_Addr_Cnty_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Geo_Flag_ := __PP11566826.P___Inp_Cln_Addr_Geo_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Type_Flag_ := __PP11566826.P___Inp_Cln_Addr_Type_Flag_Value_;
    SELF.P___Inp_Cln_Addr_Status_Flag_ := __PP11566826.P___Inp_Cln_Addr_Status_Flag_Value_;
    SELF.P___Inp_Cln_S_S_N_Flag_ := __PP11566826.P___Inp_Cln_S_S_N_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bad_Char_Flag_ := __PP11566826.P___Inp_Val_S_S_N_Bad_Char_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bad_Len_Flag_ := __PP11566826.P___Inp_Val_S_S_N_Bad_Len_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Bogus_Flag_ := __PP11566826.P___Inp_Val_S_S_N_Bogus_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Non_S_S_A_Flag_ := __PP11566826.P___Inp_Val_S_S_N_Non_S_S_A_Flag_Value_;
    SELF.P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_ := __PP11566826.P___Inp_Val_S_S_N_Is_I_T_I_N_Flag_Value_;
    SELF.P___Inp_Cln_D_O_B_Flag_ := __PP11566826.P___Inp_Cln_D_O_B_Flag_Value_;
    SELF.P___Inp_Cln_D_L_Flag_ := __PP11566826.P___Inp_Cln_D_L_Flag_Value_;
    SELF.P___Inp_Cln_D_L_State_Flag_ := __PP11566826.P___Inp_Cln_D_L_State_Flag_Value_;
    SELF.P___Inp_Cln_Phone_Home_Flag_ := __PP11566826.P___Inp_Cln_Phone_Home_Flag_Value_;
    SELF.P___Inp_Cln_Phone_Work_Flag_ := __PP11566826.P___Inp_Cln_Phone_Work_Flag_Value_;
    SELF.P___Inp_Cln_Email_Flag_ := __PP11566826.P___Inp_Cln_Email_Flag_Value_;
    SELF.P___Inp_Cln_I_P_Addr_Flag_ := __PP11566826.P___Inp_Cln_I_P_Addr_Flag_Value_;
    SELF.P___Inp_Val_Email_Bogus_Flag_ := __PP11566826.P___Inp_Val_Email_Bogus_Flag_Value_;
    SELF.P___Inp_Val_Email_User_All_Zero_Flag_ := __PP11566826.P___Inp_Val_Email_User_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Email_User_Bad_Char_Flag_ := __PP11566826.P___Inp_Val_Email_User_Bad_Char_Flag_Value_;
    SELF.P___Inp_Val_Email_Dom_All_Zero_Flag_ := __PP11566826.P___Inp_Val_Email_Dom_All_Zero_Flag_Value_;
    SELF.P___Inp_Val_Email_Dom_Bad_Char_Flag_ := __PP11566826.P___Inp_Val_Email_Dom_Bad_Char_Flag_Value_;
    SELF.P___Inp_Cln_Arch_Dt_Flag_ := __PP11566826.P___Inp_Cln_Arch_Dt_Flag_Value_;
    SELF.P_I___Inp_Addr_State_D_L_Avail_Flag_ := IF(__PisFCRA,'',(KEL.typ.str)(__PP11566826.P_I___Inp_Addr_State_D_L_Avail_Flag___Non_F_C_R_A_));
    SELF.P_I___Inp_Addr_State_Voter_Avail_Flag_ := IF(__PisFCRA,__PP11566826.P_I___Inp_Addr_State_Voter_Avail_Flag___F_C_R_A_,__PP11566826.P_I___Inp_Addr_State_Voter_Avail_Flag___Non_F_C_R_A_);
    SELF.Rep_Number_ := __PP11566826.I_Rep_Number_Value_;
    SELF := __PP11566826;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE11566825,__ND11566830__Project(LEFT)));
  EXPORT DBG_E_Input_P_I_I_PreEntity := __UNWRAP(E_Input_P_I_I_Params(__in,__cfg_Local).InData);
  EXPORT DBG_E_Input_P_I_I_Result := __UNWRAP(E_Input_P_I_I_Filtered.__Result);
  EXPORT DBG_E_Address_Result := __UNWRAP(E_Address_Filtered.__Result);
  EXPORT DBG_E_Address_Inquiry_Result := __UNWRAP(E_Address_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Address_Property_Result := __UNWRAP(E_Address_Property_Filtered.__Result);
  EXPORT DBG_E_Email_Inquiry_Result := __UNWRAP(E_Email_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Inquiry_Result := __UNWRAP(E_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Phone_Inquiry_Result := __UNWRAP(E_Phone_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Property_Result := __UNWRAP(E_Property_Filtered.__Result);
  EXPORT DBG_E_S_S_N_Inquiry_Result := __UNWRAP(E_S_S_N_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Social_Security_Number_Result := __UNWRAP(E_Social_Security_Number_Filtered.__Result);
  EXPORT DBG_E_Zip_Code_Result := __UNWRAP(E_Zip_Code_Filtered.__Result);
  EXPORT DBG_E_Inquiry_Intermediate_11 := __UNWRAP(B_Inquiry_11_Local.__ENH_Inquiry_11);
  EXPORT DBG_E_Inquiry_Intermediate_10 := __UNWRAP(B_Inquiry_10_Local.__ENH_Inquiry_10);
  EXPORT DBG_E_Input_P_I_I_Intermediate_9 := __UNWRAP(B_Input_P_I_I_9_Local.__ENH_Input_P_I_I_9);
  EXPORT DBG_E_Inquiry_Intermediate_9 := __UNWRAP(B_Inquiry_9_Local.__ENH_Inquiry_9);
  EXPORT DBG_E_Input_P_I_I_Intermediate_8 := __UNWRAP(B_Input_P_I_I_8_Local.__ENH_Input_P_I_I_8);
  EXPORT DBG_E_Inquiry_Intermediate_8 := __UNWRAP(B_Inquiry_8_Local.__ENH_Inquiry_8);
  EXPORT DBG_E_Input_P_I_I_Intermediate_7 := __UNWRAP(B_Input_P_I_I_7_Local.__ENH_Input_P_I_I_7);
  EXPORT DBG_E_Inquiry_Intermediate_7 := __UNWRAP(B_Inquiry_7_Local.__ENH_Inquiry_7);
  EXPORT DBG_E_Address_Intermediate_6 := __UNWRAP(B_Address_6_Local.__ENH_Address_6);
  EXPORT DBG_E_Input_P_I_I_Intermediate_6 := __UNWRAP(B_Input_P_I_I_6_Local.__ENH_Input_P_I_I_6);
  EXPORT DBG_E_Inquiry_Intermediate_6 := __UNWRAP(B_Inquiry_6_Local.__ENH_Inquiry_6);
  EXPORT DBG_E_Address_Intermediate_5 := __UNWRAP(B_Address_5_Local.__ENH_Address_5);
  EXPORT DBG_E_Input_P_I_I_Intermediate_5 := __UNWRAP(B_Input_P_I_I_5_Local.__ENH_Input_P_I_I_5);
  EXPORT DBG_E_Inquiry_Intermediate_5 := __UNWRAP(B_Inquiry_5_Local.__ENH_Inquiry_5);
  EXPORT DBG_E_Property_Intermediate_5 := __UNWRAP(B_Property_5_Local.__ENH_Property_5);
  EXPORT DBG_E_Address_Intermediate_4 := __UNWRAP(B_Address_4_Local.__ENH_Address_4);
  EXPORT DBG_E_Input_P_I_I_Intermediate_4 := __UNWRAP(B_Input_P_I_I_4_Local.__ENH_Input_P_I_I_4);
  EXPORT DBG_E_Inquiry_Intermediate_4 := __UNWRAP(B_Inquiry_4_Local.__ENH_Inquiry_4);
  EXPORT DBG_E_Property_Intermediate_4 := __UNWRAP(B_Property_4_Local.__ENH_Property_4);
  EXPORT DBG_E_Address_Intermediate_3 := __UNWRAP(B_Address_3_Local.__ENH_Address_3);
  EXPORT DBG_E_Input_P_I_I_Intermediate_3 := __UNWRAP(B_Input_P_I_I_3_Local.__ENH_Input_P_I_I_3);
  EXPORT DBG_E_Inquiry_Intermediate_3 := __UNWRAP(B_Inquiry_3_Local.__ENH_Inquiry_3);
  EXPORT DBG_E_Address_Intermediate_2 := __UNWRAP(B_Address_2_Local.__ENH_Address_2);
  EXPORT DBG_E_Input_P_I_I_Intermediate_2 := __UNWRAP(B_Input_P_I_I_2_Local.__ENH_Input_P_I_I_2);
  EXPORT DBG_E_Address_Intermediate_1 := __UNWRAP(B_Address_1_Local.__ENH_Address_1);
  EXPORT DBG_E_Input_P_I_I_Intermediate_1 := __UNWRAP(B_Input_P_I_I_1_Local.__ENH_Input_P_I_I_1);
  EXPORT DBG_E_Input_P_I_I_Annotated := __UNWRAP(B_Input_P_I_I_Local.__ENH_Input_P_I_I);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Input_P_I_I_PreEntity,NAMED('DBG_E_Input_P_I_I_PreEntity_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Result,NAMED('DBG_E_Input_P_I_I_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Result,NAMED('DBG_E_Address_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Inquiry_Result,NAMED('DBG_E_Address_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Property_Result,NAMED('DBG_E_Address_Property_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Email_Inquiry_Result,NAMED('DBG_E_Email_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Phone_Inquiry_Result,NAMED('DBG_E_Phone_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Result,NAMED('DBG_E_Property_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_S_S_N_Inquiry_Result,NAMED('DBG_E_S_S_N_Inquiry_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Social_Security_Number_Result,NAMED('DBG_E_Social_Security_Number_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Zip_Code_Result,NAMED('DBG_E_Zip_Code_Result_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_11,NAMED('DBG_E_Inquiry_Intermediate_11_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_10,NAMED('DBG_E_Inquiry_Intermediate_10_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_9,NAMED('DBG_E_Input_P_I_I_Intermediate_9_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_9,NAMED('DBG_E_Inquiry_Intermediate_9_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_8,NAMED('DBG_E_Input_P_I_I_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_8,NAMED('DBG_E_Inquiry_Intermediate_8_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_7,NAMED('DBG_E_Input_P_I_I_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_7,NAMED('DBG_E_Inquiry_Intermediate_7_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_6,NAMED('DBG_E_Address_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_6,NAMED('DBG_E_Input_P_I_I_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_6,NAMED('DBG_E_Inquiry_Intermediate_6_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_5,NAMED('DBG_E_Address_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_5,NAMED('DBG_E_Input_P_I_I_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_5,NAMED('DBG_E_Inquiry_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Intermediate_5,NAMED('DBG_E_Property_Intermediate_5_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_4,NAMED('DBG_E_Address_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_4,NAMED('DBG_E_Input_P_I_I_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_4,NAMED('DBG_E_Inquiry_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Property_Intermediate_4,NAMED('DBG_E_Property_Intermediate_4_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_3,NAMED('DBG_E_Address_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_3,NAMED('DBG_E_Input_P_I_I_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Inquiry_Intermediate_3,NAMED('DBG_E_Inquiry_Intermediate_3_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_2,NAMED('DBG_E_Address_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_2,NAMED('DBG_E_Input_P_I_I_Intermediate_2_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Address_Intermediate_1,NAMED('DBG_E_Address_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Intermediate_1,NAMED('DBG_E_Input_P_I_I_Intermediate_1_Q_Input_Attributes_V1_Hybrid')),
    OUTPUT(DBG_E_Input_P_I_I_Annotated,NAMED('DBG_E_Input_P_I_I_Annotated_Q_Input_Attributes_V1_Hybrid'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
