﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Input_B_I_I(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.nint Bus_Input_U_I_D_Append_;
    KEL.typ.nint Input_Lex_I_D_Bus_Extended_Family_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Legal_Family_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Legal_Entity_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Place_Group_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Place_Echo_;
    KEL.typ.nstr Bus_Input_Name_Echo_;
    KEL.typ.nstr Bus_Input_Alternate_Name_Echo_;
    KEL.typ.nstr Bus_Input_Street_Echo_;
    KEL.typ.nstr Bus_Input_City_Echo_;
    KEL.typ.nstr Bus_Input_State_Echo_;
    KEL.typ.nstr Bus_Input_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Phone_Echo_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr Bus_Input_I_P_Address_Echo_;
    KEL.typ.nstr Bus_Input_U_R_L_Echo_;
    KEL.typ.nstr Bus_Input_Email_Echo_;
    KEL.typ.nstr Bus_Input_S_I_C_Code_Echo_;
    KEL.typ.nstr Bus_Input_N_A_I_C_S_Code_Echo_;
    KEL.typ.nstr Bus_Input_T_I_N_Echo_;
    KEL.typ.nstr Bus_Input_Archive_Date_Echo_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_;
    KEL.typ.nstr Bus_Input_City_Clean_;
    KEL.typ.nstr Bus_Input_State_Clean_;
    KEL.typ.nstr Bus_Input_Zip5_Clean_;
    KEL.typ.nstr Bus_Input_Zip4_Clean_;
    KEL.typ.nstr Bus_Input_Latitude_Clean_;
    KEL.typ.nstr Bus_Input_Longitude_Clean_;
    KEL.typ.nstr Bus_Input_County_Clean_;
    KEL.typ.nstr Bus_Input_Geoblock_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Type_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Status_Clean_;
    KEL.typ.nstr Bus_Input_Phone_Clean_;
    KEL.typ.nstr Bus_Input_Email_Clean_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_;
    KEL.typ.nstr Bus_Input_Archive_Date_Clean_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED1 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'businputuidappend(UID|Bus_Input_U_I_D_Append_:0),company(Company_:0),inputlexidbusextendedfamilyecho(Input_Lex_I_D_Bus_Extended_Family_Echo_:0),inputlexidbuslegalfamilyecho(Input_Lex_I_D_Bus_Legal_Family_Echo_:0),inputlexidbuslegalentityecho(Input_Lex_I_D_Bus_Legal_Entity_Echo_:0),inputlexidbusplacegroupecho(Input_Lex_I_D_Bus_Place_Group_Echo_:0),inputlexidbusplaceecho(Input_Lex_I_D_Bus_Place_Echo_:0),businputnameecho(Bus_Input_Name_Echo_:\'\'),businputalternatenameecho(Bus_Input_Alternate_Name_Echo_:\'\'),businputstreetecho(Bus_Input_Street_Echo_:\'\'),businputcityecho(Bus_Input_City_Echo_:\'\'),businputstateecho(Bus_Input_State_Echo_:\'\'),businputzipecho(Bus_Input_Zip_Echo_:\'\'),businputphoneecho(Bus_Input_Phone_Echo_:\'\'),businesstin(Business_T_I_N_:\'\'),businputipaddressecho(Bus_Input_I_P_Address_Echo_:\'\'),businputurlecho(Bus_Input_U_R_L_Echo_:\'\'),businputemailecho(Bus_Input_Email_Echo_:\'\'),businputsiccodeecho(Bus_Input_S_I_C_Code_Echo_:\'\'),businputnaicscodeecho(Bus_Input_N_A_I_C_S_Code_Echo_:\'\'),businputtinecho(Bus_Input_T_I_N_Echo_:\'\'),businputarchivedateecho(Bus_Input_Archive_Date_Echo_:\'\'),businputprimrangeclean(Bus_Input_Prim_Range_Clean_:\'\'),businputpredirclean(Bus_Input_Pre_Dir_Clean_:\'\'),businputprimnameclean(Bus_Input_Prim_Name_Clean_:\'\'),businputaddrsuffixclean(Bus_Input_Addr_Suffix_Clean_:\'\'),businputpostdirclean(Bus_Input_Post_Dir_Clean_:\'\'),businputunitdesigclean(Bus_Input_Unit_Desig_Clean_:\'\'),businputsecrangeclean(Bus_Input_Sec_Range_Clean_:\'\'),businputcityclean(Bus_Input_City_Clean_:\'\'),businputstateclean(Bus_Input_State_Clean_:\'\'),businputzip5clean(Bus_Input_Zip5_Clean_:\'\'),businputzip4clean(Bus_Input_Zip4_Clean_:\'\'),businputlatitudeclean(Bus_Input_Latitude_Clean_:\'\'),businputlongitudeclean(Bus_Input_Longitude_Clean_:\'\'),businputcountyclean(Bus_Input_County_Clean_:\'\'),businputgeoblockclean(Bus_Input_Geoblock_Clean_:\'\'),businputaddrtypeclean(Bus_Input_Addr_Type_Clean_:\'\'),businputaddrstatusclean(Bus_Input_Addr_Status_Clean_:\'\'),businputphoneclean(Bus_Input_Phone_Clean_:\'\'),businputemailclean(Bus_Input_Email_Clean_:\'\'),businputtinclean(Bus_Input_T_I_N_Clean_:\'\'),businputarchivedateclean(Bus_Input_Archive_Date_Clean_:\'\'),archivedate(Archive_Date_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.nint Bus_Input_U_I_D_Append_;
    KEL.typ.nint Input_Lex_I_D_Bus_Extended_Family_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Legal_Family_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Legal_Entity_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Place_Group_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Place_Echo_;
    KEL.typ.nstr Bus_Input_Name_Echo_;
    KEL.typ.nstr Bus_Input_Alternate_Name_Echo_;
    KEL.typ.nstr Bus_Input_Street_Echo_;
    KEL.typ.nstr Bus_Input_City_Echo_;
    KEL.typ.nstr Bus_Input_State_Echo_;
    KEL.typ.nstr Bus_Input_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Phone_Echo_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr Bus_Input_I_P_Address_Echo_;
    KEL.typ.nstr Bus_Input_U_R_L_Echo_;
    KEL.typ.nstr Bus_Input_Email_Echo_;
    KEL.typ.nstr Bus_Input_S_I_C_Code_Echo_;
    KEL.typ.nstr Bus_Input_N_A_I_C_S_Code_Echo_;
    KEL.typ.nstr Bus_Input_T_I_N_Echo_;
    KEL.typ.nstr Bus_Input_Archive_Date_Echo_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_;
    KEL.typ.nstr Bus_Input_City_Clean_;
    KEL.typ.nstr Bus_Input_State_Clean_;
    KEL.typ.nstr Bus_Input_Zip5_Clean_;
    KEL.typ.nstr Bus_Input_Zip4_Clean_;
    KEL.typ.nstr Bus_Input_Latitude_Clean_;
    KEL.typ.nstr Bus_Input_Longitude_Clean_;
    KEL.typ.nstr Bus_Input_County_Clean_;
    KEL.typ.nstr Bus_Input_Geoblock_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Type_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Status_Clean_;
    KEL.typ.nstr Bus_Input_Phone_Clean_;
    KEL.typ.nstr Bus_Input_Email_Clean_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_;
    KEL.typ.nstr Bus_Input_Archive_Date_Clean_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Input_B_I_I_Group := __PostFilter;
  Layout Input_B_I_I__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Company_ := KEL.Intake.SingleValue(__recs,Company_);
    SELF.Bus_Input_U_I_D_Append_ := KEL.Intake.SingleValue(__recs,Bus_Input_U_I_D_Append_);
    SELF.Input_Lex_I_D_Bus_Extended_Family_Echo_ := KEL.Intake.SingleValue(__recs,Input_Lex_I_D_Bus_Extended_Family_Echo_);
    SELF.Input_Lex_I_D_Bus_Legal_Family_Echo_ := KEL.Intake.SingleValue(__recs,Input_Lex_I_D_Bus_Legal_Family_Echo_);
    SELF.Input_Lex_I_D_Bus_Legal_Entity_Echo_ := KEL.Intake.SingleValue(__recs,Input_Lex_I_D_Bus_Legal_Entity_Echo_);
    SELF.Input_Lex_I_D_Bus_Place_Group_Echo_ := KEL.Intake.SingleValue(__recs,Input_Lex_I_D_Bus_Place_Group_Echo_);
    SELF.Input_Lex_I_D_Bus_Place_Echo_ := KEL.Intake.SingleValue(__recs,Input_Lex_I_D_Bus_Place_Echo_);
    SELF.Bus_Input_Name_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Name_Echo_);
    SELF.Bus_Input_Alternate_Name_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Alternate_Name_Echo_);
    SELF.Bus_Input_Street_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Street_Echo_);
    SELF.Bus_Input_City_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_City_Echo_);
    SELF.Bus_Input_State_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_State_Echo_);
    SELF.Bus_Input_Zip_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Zip_Echo_);
    SELF.Bus_Input_Phone_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Phone_Echo_);
    SELF.Business_T_I_N_ := KEL.Intake.SingleValue(__recs,Business_T_I_N_);
    SELF.Bus_Input_I_P_Address_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_I_P_Address_Echo_);
    SELF.Bus_Input_U_R_L_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_U_R_L_Echo_);
    SELF.Bus_Input_Email_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Email_Echo_);
    SELF.Bus_Input_S_I_C_Code_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_S_I_C_Code_Echo_);
    SELF.Bus_Input_N_A_I_C_S_Code_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_N_A_I_C_S_Code_Echo_);
    SELF.Bus_Input_T_I_N_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_T_I_N_Echo_);
    SELF.Bus_Input_Archive_Date_Echo_ := KEL.Intake.SingleValue(__recs,Bus_Input_Archive_Date_Echo_);
    SELF.Bus_Input_Prim_Range_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Prim_Range_Clean_);
    SELF.Bus_Input_Pre_Dir_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Pre_Dir_Clean_);
    SELF.Bus_Input_Prim_Name_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Prim_Name_Clean_);
    SELF.Bus_Input_Addr_Suffix_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Addr_Suffix_Clean_);
    SELF.Bus_Input_Post_Dir_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Post_Dir_Clean_);
    SELF.Bus_Input_Unit_Desig_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Unit_Desig_Clean_);
    SELF.Bus_Input_Sec_Range_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Sec_Range_Clean_);
    SELF.Bus_Input_City_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_City_Clean_);
    SELF.Bus_Input_State_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_State_Clean_);
    SELF.Bus_Input_Zip5_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Zip5_Clean_);
    SELF.Bus_Input_Zip4_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Zip4_Clean_);
    SELF.Bus_Input_Latitude_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Latitude_Clean_);
    SELF.Bus_Input_Longitude_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Longitude_Clean_);
    SELF.Bus_Input_County_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_County_Clean_);
    SELF.Bus_Input_Geoblock_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Geoblock_Clean_);
    SELF.Bus_Input_Addr_Type_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Addr_Type_Clean_);
    SELF.Bus_Input_Addr_Status_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Addr_Status_Clean_);
    SELF.Bus_Input_Phone_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Phone_Clean_);
    SELF.Bus_Input_Email_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Email_Clean_);
    SELF.Bus_Input_T_I_N_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_T_I_N_Clean_);
    SELF.Bus_Input_Archive_Date_Clean_ := KEL.Intake.SingleValue(__recs,Bus_Input_Archive_Date_Clean_);
    SELF.Archive_Date_ := KEL.Intake.SingleValue(__recs,Archive_Date_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Input_B_I_I__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Input_B_I_I_Group,COUNT(ROWS(LEFT))=1),GROUP,Input_B_I_I__Single_Rollup(LEFT)) + ROLLUP(HAVING(Input_B_I_I_Group,COUNT(ROWS(LEFT))>1),GROUP,Input_B_I_I__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Company__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_);
  EXPORT Bus_Input_U_I_D_Append__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_U_I_D_Append_);
  EXPORT Input_Lex_I_D_Bus_Extended_Family_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Input_Lex_I_D_Bus_Extended_Family_Echo_);
  EXPORT Input_Lex_I_D_Bus_Legal_Family_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Input_Lex_I_D_Bus_Legal_Family_Echo_);
  EXPORT Input_Lex_I_D_Bus_Legal_Entity_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Input_Lex_I_D_Bus_Legal_Entity_Echo_);
  EXPORT Input_Lex_I_D_Bus_Place_Group_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Input_Lex_I_D_Bus_Place_Group_Echo_);
  EXPORT Input_Lex_I_D_Bus_Place_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Input_Lex_I_D_Bus_Place_Echo_);
  EXPORT Bus_Input_Name_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Name_Echo_);
  EXPORT Bus_Input_Alternate_Name_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Alternate_Name_Echo_);
  EXPORT Bus_Input_Street_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Street_Echo_);
  EXPORT Bus_Input_City_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_City_Echo_);
  EXPORT Bus_Input_State_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_State_Echo_);
  EXPORT Bus_Input_Zip_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Zip_Echo_);
  EXPORT Bus_Input_Phone_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Phone_Echo_);
  EXPORT Business_T_I_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Business_T_I_N_);
  EXPORT Bus_Input_I_P_Address_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_I_P_Address_Echo_);
  EXPORT Bus_Input_U_R_L_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_U_R_L_Echo_);
  EXPORT Bus_Input_Email_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Email_Echo_);
  EXPORT Bus_Input_S_I_C_Code_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_S_I_C_Code_Echo_);
  EXPORT Bus_Input_N_A_I_C_S_Code_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_N_A_I_C_S_Code_Echo_);
  EXPORT Bus_Input_T_I_N_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_T_I_N_Echo_);
  EXPORT Bus_Input_Archive_Date_Echo__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Archive_Date_Echo_);
  EXPORT Bus_Input_Prim_Range_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Prim_Range_Clean_);
  EXPORT Bus_Input_Pre_Dir_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Pre_Dir_Clean_);
  EXPORT Bus_Input_Prim_Name_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Prim_Name_Clean_);
  EXPORT Bus_Input_Addr_Suffix_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Addr_Suffix_Clean_);
  EXPORT Bus_Input_Post_Dir_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Post_Dir_Clean_);
  EXPORT Bus_Input_Unit_Desig_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Unit_Desig_Clean_);
  EXPORT Bus_Input_Sec_Range_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Sec_Range_Clean_);
  EXPORT Bus_Input_City_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_City_Clean_);
  EXPORT Bus_Input_State_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_State_Clean_);
  EXPORT Bus_Input_Zip5_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Zip5_Clean_);
  EXPORT Bus_Input_Zip4_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Zip4_Clean_);
  EXPORT Bus_Input_Latitude_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Latitude_Clean_);
  EXPORT Bus_Input_Longitude_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Longitude_Clean_);
  EXPORT Bus_Input_County_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_County_Clean_);
  EXPORT Bus_Input_Geoblock_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Geoblock_Clean_);
  EXPORT Bus_Input_Addr_Type_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Addr_Type_Clean_);
  EXPORT Bus_Input_Addr_Status_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Addr_Status_Clean_);
  EXPORT Bus_Input_Phone_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Phone_Clean_);
  EXPORT Bus_Input_Email_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Email_Clean_);
  EXPORT Bus_Input_T_I_N_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_T_I_N_Clean_);
  EXPORT Bus_Input_Archive_Date_Clean__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bus_Input_Archive_Date_Clean_);
  EXPORT Archive_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Archive_Date_);
  EXPORT Company__Orphan := JOIN(InData(__NN(Company_)),E_Business(__in,__cfg).__Result,__EEQP(LEFT.Company_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Company__Orphan),COUNT(Company__SingleValue_Invalid),COUNT(Bus_Input_U_I_D_Append__SingleValue_Invalid),COUNT(Input_Lex_I_D_Bus_Extended_Family_Echo__SingleValue_Invalid),COUNT(Input_Lex_I_D_Bus_Legal_Family_Echo__SingleValue_Invalid),COUNT(Input_Lex_I_D_Bus_Legal_Entity_Echo__SingleValue_Invalid),COUNT(Input_Lex_I_D_Bus_Place_Group_Echo__SingleValue_Invalid),COUNT(Input_Lex_I_D_Bus_Place_Echo__SingleValue_Invalid),COUNT(Bus_Input_Name_Echo__SingleValue_Invalid),COUNT(Bus_Input_Alternate_Name_Echo__SingleValue_Invalid),COUNT(Bus_Input_Street_Echo__SingleValue_Invalid),COUNT(Bus_Input_City_Echo__SingleValue_Invalid),COUNT(Bus_Input_State_Echo__SingleValue_Invalid),COUNT(Bus_Input_Zip_Echo__SingleValue_Invalid),COUNT(Bus_Input_Phone_Echo__SingleValue_Invalid),COUNT(Business_T_I_N__SingleValue_Invalid),COUNT(Bus_Input_I_P_Address_Echo__SingleValue_Invalid),COUNT(Bus_Input_U_R_L_Echo__SingleValue_Invalid),COUNT(Bus_Input_Email_Echo__SingleValue_Invalid),COUNT(Bus_Input_S_I_C_Code_Echo__SingleValue_Invalid),COUNT(Bus_Input_N_A_I_C_S_Code_Echo__SingleValue_Invalid),COUNT(Bus_Input_T_I_N_Echo__SingleValue_Invalid),COUNT(Bus_Input_Archive_Date_Echo__SingleValue_Invalid),COUNT(Bus_Input_Prim_Range_Clean__SingleValue_Invalid),COUNT(Bus_Input_Pre_Dir_Clean__SingleValue_Invalid),COUNT(Bus_Input_Prim_Name_Clean__SingleValue_Invalid),COUNT(Bus_Input_Addr_Suffix_Clean__SingleValue_Invalid),COUNT(Bus_Input_Post_Dir_Clean__SingleValue_Invalid),COUNT(Bus_Input_Unit_Desig_Clean__SingleValue_Invalid),COUNT(Bus_Input_Sec_Range_Clean__SingleValue_Invalid),COUNT(Bus_Input_City_Clean__SingleValue_Invalid),COUNT(Bus_Input_State_Clean__SingleValue_Invalid),COUNT(Bus_Input_Zip5_Clean__SingleValue_Invalid),COUNT(Bus_Input_Zip4_Clean__SingleValue_Invalid),COUNT(Bus_Input_Latitude_Clean__SingleValue_Invalid),COUNT(Bus_Input_Longitude_Clean__SingleValue_Invalid),COUNT(Bus_Input_County_Clean__SingleValue_Invalid),COUNT(Bus_Input_Geoblock_Clean__SingleValue_Invalid),COUNT(Bus_Input_Addr_Type_Clean__SingleValue_Invalid),COUNT(Bus_Input_Addr_Status_Clean__SingleValue_Invalid),COUNT(Bus_Input_Phone_Clean__SingleValue_Invalid),COUNT(Bus_Input_Email_Clean__SingleValue_Invalid),COUNT(Bus_Input_T_I_N_Clean__SingleValue_Invalid),COUNT(Bus_Input_Archive_Date_Clean__SingleValue_Invalid),COUNT(Archive_Date__SingleValue_Invalid)}],{KEL.typ.int Company__Orphan,KEL.typ.int Company__SingleValue_Invalid,KEL.typ.int Bus_Input_U_I_D_Append__SingleValue_Invalid,KEL.typ.int Input_Lex_I_D_Bus_Extended_Family_Echo__SingleValue_Invalid,KEL.typ.int Input_Lex_I_D_Bus_Legal_Family_Echo__SingleValue_Invalid,KEL.typ.int Input_Lex_I_D_Bus_Legal_Entity_Echo__SingleValue_Invalid,KEL.typ.int Input_Lex_I_D_Bus_Place_Group_Echo__SingleValue_Invalid,KEL.typ.int Input_Lex_I_D_Bus_Place_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Name_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Alternate_Name_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Street_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_City_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_State_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Zip_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Phone_Echo__SingleValue_Invalid,KEL.typ.int Business_T_I_N__SingleValue_Invalid,KEL.typ.int Bus_Input_I_P_Address_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_U_R_L_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Email_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_S_I_C_Code_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_N_A_I_C_S_Code_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_T_I_N_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Archive_Date_Echo__SingleValue_Invalid,KEL.typ.int Bus_Input_Prim_Range_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Pre_Dir_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Prim_Name_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Addr_Suffix_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Post_Dir_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Unit_Desig_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Sec_Range_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_City_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_State_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Zip5_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Zip4_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Latitude_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Longitude_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_County_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Geoblock_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Addr_Type_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Addr_Status_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Phone_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Email_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_T_I_N_Clean__SingleValue_Invalid,KEL.typ.int Bus_Input_Archive_Date_Clean__SingleValue_Invalid,KEL.typ.int Archive_Date__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
