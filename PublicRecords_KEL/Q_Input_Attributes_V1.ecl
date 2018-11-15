﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Input_P_I_I,B_Input_P_I_I_1,B_Input_P_I_I_2,CFG_Compile,E_Input_P_I_I,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Input_Attributes_V1(DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Attr_Layout)) __PInputPIIDataset, KEL.typ.str __PInputArchiveDateClean, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'inputuidappend(UID),appendedlexid(Subject_:0),inputaccountecho(Input_Account_Echo_:\'\'),inputlexidecho(Input_Lex_I_D_Echo_:0),inputfirstnameecho(Input_First_Name_Echo_:\'\'),inputmiddlenameecho(Input_Middle_Name_Echo_:\'\'),inputlastnameecho(Input_Last_Name_Echo_:\'\'),inputstreetecho(Input_Street_Echo_:\'\'),inputcityecho(Input_City_Echo_:\'\'),inputstateecho(Input_State_Echo_:\'\'),inputzipecho(Input_Zip_Echo_:\'\'),inputhomephoneecho(Input_Home_Phone_Echo_:\'\'),inputssnecho(Input_S_S_N_Echo_:\'\'),inputdobecho(Input_D_O_B_Echo_:\'\'),inputworkphoneecho(Input_Work_Phone_Echo_:\'\'),inputincomeecho(Input_Income_Echo_:\'\'),inputdlnumberecho(Input_D_L_Number_Echo_:\'\'),inputdlstateecho(Input_D_L_State_Echo_:\'\'),inputbalanceecho(Input_Balance_Echo_:\'\'),inputchargeoffdecho(Input_Charge_Offd_Echo_:\'\'),inputformernameecho(Input_Former_Name_Echo_:\'\'),inputemailecho(Input_Email_Echo_:\'\'),inputemploymentecho(Input_Employment_Echo_:\'\'),inputarchivedateecho(Input_Archive_Date_Echo_:\'\'),inputaccountechopop(Input_Account_Echo_Pop_:\'\'),inputlexidechopop(Input_Lex_I_D_Echo_Pop_:\'\'),inputfirstnameechopop(Input_First_Name_Echo_Pop_:\'\'),inputstreetechopop(Input_Street_Echo_Pop_:\'\'),inputcityechopop(Input_City_Echo_Pop_:\'\'),inputstateechopop(Input_State_Echo_Pop_:\'\'),inputzipechopop(Input_Zip_Echo_Pop_:\'\'),inputhomephoneechopop(Input_Home_Phone_Echo_Pop_:\'\'),inputworkphoneechopop(Input_Work_Phone_Echo_Pop_:\'\'),inputemailechopop(Input_Email_Echo_Pop_:\'\'),inputarchivedateechopop(Input_Archive_Date_Echo_Pop_:\'\'),lexidappend(Lex_I_D_Append_:0),lexidscoreappend(Lex_I_D_Score_Append_:0),inputprefixclean(Input_Prefix_Clean_:\'\'),inputfirstnameclean(Input_First_Name_Clean_:\'\'),inputmiddlenameclean(Input_Middle_Name_Clean_:\'\'),inputlastnameclean(Input_Last_Name_Clean_:\'\'),inputsuffixclean(Input_Suffix_Clean_:\'\'),inputprimaryrangeclean(Input_Primary_Range_Clean_:\'\'),inputpredirectionclean(Input_Pre_Direction_Clean_:\'\'),inputprimarynameclean(Input_Primary_Name_Clean_:\'\'),inputaddresssuffixclean(Input_Address_Suffix_Clean_:\'\'),inputpostdirectionclean(Input_Post_Direction_Clean_:\'\'),inputunitdesigclean(Input_Unit_Desig_Clean_:\'\'),inputsecondaryrangeclean(Input_Secondary_Range_Clean_:\'\'),inputcityclean(Input_City_Clean_:\'\'),inputstateclean(Input_State_Clean_:\'\'),inputzip5clean(Input_Zip5_Clean_:\'\'),inputzip4clean(Input_Zip4_Clean_:\'\'),inputlatitudeclean(Input_Latitude_Clean_:\'\'),inputlongitudeclean(Input_Longitude_Clean_:\'\'),inputcountyclean(Input_County_Clean_:\'\'),inputgeoblockclean(Input_Geoblock_Clean_:\'\'),inputaddresstypeclean(Input_Address_Type_Clean_:\'\'),inputaddressstatusclean(Input_Address_Status_Clean_:\'\'),inputemailclean(Input_Email_Clean_:\'\'),inputhomephoneclean(Input_Home_Phone_Clean_:\'\'),inputworkphoneclean(Input_Work_Phone_Clean_:\'\'),inputdlnumberclean(Input_D_L_Number_Clean_:\'\'),inputdlstateclean(Input_D_L_State_Clean_:\'\'),inputdobclean(Input_D_O_B_Clean_:DATE),inputssnclean(Input_S_S_N_Clean_:\'\'),inputarchivedateclean(Input_Archive_Date_Clean_:\'\'),inputprefixcleanpop(Input_Prefix_Clean_Pop_:\'\'),inputfirstnamecleanpop(Input_First_Name_Clean_Pop_:\'\'),inputsuffixcleanpop(Input_Suffix_Clean_Pop_:\'\'),inputprimaryrangecleanpop(Input_Primary_Range_Clean_Pop_:\'\'),inputpredirectioncleanpop(Input_Pre_Direction_Clean_Pop_:\'\'),inputprimarynamecleanpop(Input_Primary_Name_Clean_Pop_:\'\'),inputaddresssuffixcleanpop(Input_Address_Suffix_Clean_Pop_:\'\'),inputpostdirectioncleanpop(Input_Post_Direction_Clean_Pop_:\'\'),inputunitdesigcleanpop(Input_Unit_Desig_Clean_Pop_:\'\'),inputsecondaryrangecleanpop(Input_Secondary_Range_Clean_Pop_:\'\'),inputcitycleanpop(Input_City_Clean_Pop_:\'\'),inputstatecleanpop(Input_State_Clean_Pop_:\'\'),inputzip5cleanpop(Input_Zip5_Clean_Pop_:\'\'),inputzip4cleanpop(Input_Zip4_Clean_Pop_:\'\'),inputlatitudecleanpop(Input_Latitude_Clean_Pop_:\'\'),inputlongitudecleanpop(Input_Longitude_Clean_Pop_:\'\'),inputcountycleanpop(Input_County_Clean_Pop_:\'\'),inputgeoblockcleanpop(Input_Geoblock_Clean_Pop_:\'\'),inputaddresstypecleanpop(Input_Address_Type_Clean_Pop_:\'\'),inputaddressstatuscleanpop(Input_Address_Status_Clean_Pop_:\'\'),inputemailcleanpop(Input_Email_Clean_Pop_:\'\'),inputhomephonecleanpop(Input_Home_Phone_Clean_Pop_:\'\'),inputworkphonecleanpop(Input_Work_Phone_Clean_Pop_:\'\'),inputarchivedatecleanpop(Input_Archive_Date_Clean_Pop_:\'\'),repnumber(Rep_Number_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
    SHARED __d0_Prefiltered := __PInputPIIDataset((KEL.typ.uid)InputUIDAppend <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED B_Input_P_I_I_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Input_P_I_I_2(__in,__cfg))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg).__Result) __E_Input_P_I_I := E_Input_P_I_I_Params(__in,__cfg).__Result;
  END;
  SHARED B_Input_P_I_I_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Input_P_I_I_1(__in,__cfg))
    SHARED TYPEOF(B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2_Local(__in,__cfg).__ENH_Input_P_I_I_2;
  END;
  SHARED B_Input_P_I_I_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Input_P_I_I(__in,__cfg))
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local(__in,__cfg).__ENH_Input_P_I_I_1;
  END;
  SHARED TYPEOF(B_Input_P_I_I(__in).__ENH_Input_P_I_I) __ENH_Input_P_I_I := B_Input_P_I_I_Local(__in).__ENH_Input_P_I_I;
  SHARED __EE113191 := __ENH_Input_P_I_I;
  SHARED __ST6640_Layout := RECORD
    KEL.typ.nuid Input_U_I_D_Append_;
    KEL.typ.nstr Input_Account_Echo_;
    KEL.typ.nint Input_Lex_I_D_Echo_;
    KEL.typ.nstr Input_First_Name_Echo_;
    KEL.typ.nstr Input_Street_Echo_;
    KEL.typ.nstr Input_City_Echo_;
    KEL.typ.nstr Input_State_Echo_;
    KEL.typ.nstr Input_Zip_Echo_;
    KEL.typ.nstr Input_Home_Phone_Echo_;
    KEL.typ.nstr Input_Work_Phone_Echo_;
    KEL.typ.nstr Input_Email_Echo_;
    KEL.typ.nstr Input_Archive_Date_Echo_;
    KEL.typ.str Input_Account_Echo_Pop_ := '';
    KEL.typ.str Input_Lex_I_D_Echo_Pop_ := '';
    KEL.typ.str Input_First_Name_Echo_Pop_ := '';
    KEL.typ.str Input_Street_Echo_Pop_ := '';
    KEL.typ.str Input_City_Echo_Pop_ := '';
    KEL.typ.str Input_State_Echo_Pop_ := '';
    KEL.typ.str Input_Zip_Echo_Pop_ := '';
    KEL.typ.str Input_Home_Phone_Echo_Pop_ := '';
    KEL.typ.str Input_Work_Phone_Echo_Pop_ := '';
    KEL.typ.str Input_Email_Echo_Pop_ := '';
    KEL.typ.str Input_Archive_Date_Echo_Pop_ := '';
    KEL.typ.nint Lex_I_D_Append_;
    KEL.typ.nint Lex_I_D_Score_Append_;
    KEL.typ.nstr Input_Prefix_Clean_;
    KEL.typ.nstr Input_First_Name_Clean_;
    KEL.typ.nstr Input_Suffix_Clean_;
    KEL.typ.nstr Input_Primary_Range_Clean_;
    KEL.typ.nstr Input_Pre_Direction_Clean_;
    KEL.typ.nstr Input_Primary_Name_Clean_;
    KEL.typ.nstr Input_Address_Suffix_Clean_;
    KEL.typ.nstr Input_Post_Direction_Clean_;
    KEL.typ.nstr Input_Unit_Desig_Clean_;
    KEL.typ.nstr Input_Secondary_Range_Clean_;
    KEL.typ.nstr Input_City_Clean_;
    KEL.typ.nstr Input_State_Clean_;
    KEL.typ.nstr Input_Zip5_Clean_;
    KEL.typ.nstr Input_Zip4_Clean_;
    KEL.typ.nstr Input_Latitude_Clean_;
    KEL.typ.nstr Input_Longitude_Clean_;
    KEL.typ.nstr Input_County_Clean_;
    KEL.typ.nstr Input_Geoblock_Clean_;
    KEL.typ.nstr Input_Address_Type_Clean_;
    KEL.typ.nstr Input_Address_Status_Clean_;
    KEL.typ.nstr Input_Email_Clean_;
    KEL.typ.nstr Input_Home_Phone_Clean_;
    KEL.typ.nstr Input_Work_Phone_Clean_;
    KEL.typ.nstr Input_Archive_Date_Clean_;
    KEL.typ.nstr Input_Prefix_Clean_Pop_;
    KEL.typ.nstr Input_First_Name_Clean_Pop_;
    KEL.typ.nstr Input_Suffix_Clean_Pop_;
    KEL.typ.nstr Input_Primary_Range_Clean_Pop_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Pop_;
    KEL.typ.nstr Input_Primary_Name_Clean_Pop_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Pop_;
    KEL.typ.nstr Input_Post_Direction_Clean_Pop_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Pop_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Pop_;
    KEL.typ.nstr Input_City_Clean_Pop_;
    KEL.typ.nstr Input_State_Clean_Pop_;
    KEL.typ.nstr Input_Zip5_Clean_Pop_;
    KEL.typ.nstr Input_Zip4_Clean_Pop_;
    KEL.typ.nstr Input_Latitude_Clean_Pop_;
    KEL.typ.nstr Input_Longitude_Clean_Pop_;
    KEL.typ.nstr Input_County_Clean_Pop_;
    KEL.typ.nstr Input_Geoblock_Clean_Pop_;
    KEL.typ.nstr Input_Address_Type_Clean_Pop_;
    KEL.typ.nstr Input_Address_Status_Clean_Pop_;
    KEL.typ.nstr Input_Email_Clean_Pop_;
    KEL.typ.nstr Input_Home_Phone_Clean_Pop_;
    KEL.typ.nstr Input_Work_Phone_Clean_Pop_;
    KEL.typ.nstr Input_Archive_Date_Clean_Pop_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST6640_Layout __ND112893__Project(B_Input_P_I_I(__in).__ST12741_Layout __PP112814) := TRANSFORM
    SELF.Input_U_I_D_Append_ := __PP112814.UID;
    SELF.Input_Account_Echo_ := __PP112814.Input_Account_Value_;
    SELF.Input_Lex_I_D_Echo_ := __PP112814.Input_Lex_I_D_Value_;
    SELF.Input_First_Name_Echo_ := __PP112814.Input_First_Name_Value_;
    SELF.Input_Street_Echo_ := __PP112814.Input_Street_Value_;
    SELF.Input_City_Echo_ := __PP112814.Input_City_Value_;
    SELF.Input_State_Echo_ := __PP112814.Input_State_Value_;
    SELF.Input_Zip_Echo_ := __PP112814.Input_Zip_Value_;
    SELF.Input_Home_Phone_Echo_ := __PP112814.Input_Home_Phone_Value_;
    SELF.Input_Work_Phone_Echo_ := __PP112814.Input_Work_Phone_Value_;
    SELF.Input_Email_Echo_ := __PP112814.Input_Email_Value_;
    SELF.Input_Archive_Date_Echo_ := __PP112814.Input_Archive_Date_Value_;
    SELF.Input_Account_Echo_Pop_ := __PP112814.Input_Account_Echo_Pop_Value_;
    SELF.Input_Lex_I_D_Echo_Pop_ := __PP112814.Input_Lex_I_D_Echo_Pop_Value_;
    SELF.Input_First_Name_Echo_Pop_ := __PP112814.Input_First_Name_Echo_Pop_Value_;
    SELF.Input_Street_Echo_Pop_ := __PP112814.Input_Street_Echo_Pop_Value_;
    SELF.Input_City_Echo_Pop_ := __PP112814.Input_City_Echo_Pop_Value_;
    SELF.Input_State_Echo_Pop_ := __PP112814.Input_State_Echo_Pop_Value_;
    SELF.Input_Zip_Echo_Pop_ := __PP112814.Input_Zip_Echo_Pop_Value_;
    SELF.Input_Home_Phone_Echo_Pop_ := __PP112814.Input_Home_Phone_Echo_Pop_Value_;
    SELF.Input_Work_Phone_Echo_Pop_ := __PP112814.Input_Work_Phone_Echo_Pop_Value_;
    SELF.Input_Email_Echo_Pop_ := __PP112814.Input_Email_Echo_Pop_Value_;
    SELF.Input_Archive_Date_Echo_Pop_ := __PP112814.Input_Archive_Date_Echo_Pop_Value_;
    SELF.Input_Prefix_Clean_ := __PP112814.Input_Prefix_Clean_Value_;
    SELF.Input_First_Name_Clean_ := __PP112814.Input_First_Name_Clean_Value_;
    SELF.Input_Suffix_Clean_ := __PP112814.Input_Suffix_Clean_Value_;
    SELF.Input_Primary_Range_Clean_ := __PP112814.Input_Primary_Range_Clean_Value_;
    SELF.Input_Pre_Direction_Clean_ := __PP112814.Input_Pre_Direction_Clean_Value_;
    SELF.Input_Primary_Name_Clean_ := __PP112814.Input_Primary_Name_Clean_Value_;
    SELF.Input_Address_Suffix_Clean_ := __PP112814.Input_Address_Suffix_Clean_Value_;
    SELF.Input_Post_Direction_Clean_ := __PP112814.Input_Post_Direction_Clean_Value_;
    SELF.Input_Unit_Desig_Clean_ := __PP112814.Input_Unit_Desig_Clean_Value_;
    SELF.Input_Secondary_Range_Clean_ := __PP112814.Input_Secondary_Range_Clean_Value_;
    SELF.Input_City_Clean_ := __PP112814.Input_City_Clean_Value_;
    SELF.Input_State_Clean_ := __PP112814.Input_State_Clean_Value_;
    SELF.Input_Zip5_Clean_ := __PP112814.Input_Zip5_Clean_Value_;
    SELF.Input_Zip4_Clean_ := __PP112814.Input_Zip4_Clean_Value_;
    SELF.Input_Latitude_Clean_ := __PP112814.Input_Latitude_Clean_Value_;
    SELF.Input_Longitude_Clean_ := __PP112814.Input_Longitude_Clean_Value_;
    SELF.Input_County_Clean_ := __PP112814.Input_County_Clean_Value_;
    SELF.Input_Geoblock_Clean_ := __PP112814.Input_Geoblock_Clean_Value_;
    SELF.Input_Address_Type_Clean_ := __PP112814.Input_Address_Type_Clean_Value_;
    SELF.Input_Address_Status_Clean_ := __PP112814.Input_Address_Status_Clean_Value_;
    SELF.Input_Email_Clean_ := __PP112814.Input_Email_Clean_Value_;
    SELF.Input_Home_Phone_Clean_ := __PP112814.Input_Home_Phone_Clean_Value_;
    SELF.Input_Work_Phone_Clean_ := __PP112814.Input_Work_Phone_Clean_Value_;
    SELF.Input_Archive_Date_Clean_ := __PP112814.Input_Archive_Date_Value_;
    SELF.Input_Prefix_Clean_Pop_ := __PP112814.Input_Prefix_Clean_Pop_Value_;
    SELF.Input_First_Name_Clean_Pop_ := __PP112814.Input_First_Name_Clean_Pop_Value_;
    SELF.Input_Suffix_Clean_Pop_ := __PP112814.Input_Suffix_Clean_Pop_Value_;
    SELF.Input_Primary_Range_Clean_Pop_ := __PP112814.Input_Primary_Range_Clean_Pop_Value_;
    SELF.Input_Pre_Direction_Clean_Pop_ := __PP112814.Input_Pre_Direction_Clean_Pop_Value_;
    SELF.Input_Primary_Name_Clean_Pop_ := __PP112814.Input_Primary_Name_Clean_Pop_Value_;
    SELF.Input_Address_Suffix_Clean_Pop_ := __PP112814.Input_Address_Suffix_Clean_Pop_Value_;
    SELF.Input_Post_Direction_Clean_Pop_ := __PP112814.Input_Post_Direction_Clean_Pop_Value_;
    SELF.Input_Unit_Desig_Clean_Pop_ := __PP112814.Input_Unit_Desig_Clean_Pop_Value_;
    SELF.Input_Secondary_Range_Clean_Pop_ := __PP112814.Input_Secondary_Range_Clean_Pop_Value_;
    SELF.Input_City_Clean_Pop_ := __PP112814.Input_City_Clean_Pop_Value_;
    SELF.Input_State_Clean_Pop_ := __PP112814.Input_State_Clean_Pop_Value_;
    SELF.Input_Zip5_Clean_Pop_ := __PP112814.Input_Zip5_Clean_Pop_Value_;
    SELF.Input_Zip4_Clean_Pop_ := __PP112814.Input_Zip4_Clean_Pop_Value_;
    SELF.Input_Latitude_Clean_Pop_ := __PP112814.Input_Latitude_Clean_Pop_Value_;
    SELF.Input_Longitude_Clean_Pop_ := __PP112814.Input_Longitude_Clean_Pop_Value_;
    SELF.Input_County_Clean_Pop_ := __PP112814.Input_County_Clean_Pop_Value_;
    SELF.Input_Geoblock_Clean_Pop_ := __PP112814.Input_Geoblock_Clean_Pop_Value_;
    SELF.Input_Address_Type_Clean_Pop_ := __PP112814.Input_Address_Type_Clean_Pop_Value_;
    SELF.Input_Address_Status_Clean_Pop_ := __PP112814.Input_Address_Status_Clean_Pop_Value_;
    SELF.Input_Email_Clean_Pop_ := __PP112814.Input_Email_Clean_Pop_Value_;
    SELF.Input_Home_Phone_Clean_Pop_ := __PP112814.Input_Home_Phone_Clean_Pop_Value_;
    SELF.Input_Work_Phone_Clean_Pop_ := __PP112814.Input_Work_Phone_Clean_Pop_Value_;
    SELF.Input_Archive_Date_Clean_Pop_ := __PP112814.Input_Archive_Date_Clean_Pop_Value_;
    SELF.Rep_Number_ := __PP112814.I_Rep_Number_Value_;
    SELF := __PP112814;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE113191,__ND112893__Project(LEFT)));
END;
