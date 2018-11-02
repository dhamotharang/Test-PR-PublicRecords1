﻿//HPCC Systems KEL Compiler Version 0.11.4
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Input_B_I_I,B_Input_B_I_I_1,B_Input_P_I_I_1,CFG_Compile,E_Business,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Input_Bus_Attributes_V1(DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.InputEcho_Layout)) __PInputPIIDataset, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.AttrBusWithUID_Layout)) __PInputBIIDataset, KEL.typ.str __PBusInputArchiveDateEcho, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED E_Input_B_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_B_I_I(__in,__cfg))
    SHARED __Mapping0 := 'businputuidappend(UID|Bus_Input_U_I_D_Append_:0),company(Company_:0),inputlexidbusextendedfamilyecho(Input_Lex_I_D_Bus_Extended_Family_Echo_:0),inputlexidbuslegalfamilyecho(Input_Lex_I_D_Bus_Legal_Family_Echo_:0),inputlexidbuslegalentityecho(Input_Lex_I_D_Bus_Legal_Entity_Echo_:0),inputlexidbusplacegroupecho(Input_Lex_I_D_Bus_Place_Group_Echo_:0),inputlexidbusplaceecho(Input_Lex_I_D_Bus_Place_Echo_:0),businputnameecho(Bus_Input_Name_Echo_:\'\'),businputalternatenameecho(Bus_Input_Alternate_Name_Echo_:\'\'),businputstreetecho(Bus_Input_Street_Echo_:\'\'),businputcityecho(Bus_Input_City_Echo_:\'\'),businputstateecho(Bus_Input_State_Echo_:\'\'),businputzipecho(Bus_Input_Zip_Echo_:\'\'),businputphoneecho(Bus_Input_Phone_Echo_:\'\'),businesstin(Business_T_I_N_:\'\'),businputipaddressecho(Bus_Input_I_P_Address_Echo_:\'\'),businputurlecho(Bus_Input_U_R_L_Echo_:\'\'),businputemailecho(Bus_Input_Email_Echo_:\'\'),businputsiccodeecho(Bus_Input_S_I_C_Code_Echo_:\'\'),businputnaicscodeecho(Bus_Input_N_A_I_C_S_Code_Echo_:\'\'),businputarchivedateecho(Bus_Input_Archive_Date_Echo_:\'\'),archivedate(Archive_Date_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
    SHARED __d0_Prefiltered := __PInputBIIDataset((KEL.typ.uid)BusInputUIDAppend <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Input_B_I_I_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_B_I_I_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'inputuidappend(P_I_I_:0),businputuidappend(B_I_I_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
    SHARED __d0_Prefiltered := __PInputPIIDataset;
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED E_Input_P_I_I_Params(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Input_P_I_I(__in,__cfg))
    SHARED __Mapping0 := 'inputuidappend(UID),subject(Subject_:0),inputaccountecho(Input_Account_Echo_:\'\'),inputlexidecho(Input_Lex_I_D_Echo_:0),inputfirstnameecho(Input_First_Name_Echo_:\'\'),inputmiddlenameecho(Input_Middle_Name_Echo_:\'\'),inputlastnameecho(Input_Last_Name_Echo_:\'\'),inputaddressecho(Input_Address_Echo_:\'\'),inputcityecho(Input_City_Echo_:\'\'),inputstateecho(Input_State_Echo_:\'\'),inputzipecho(Input_Zip_Echo_:\'\'),inputhomephoneecho(Input_Home_Phone_Echo_:\'\'),inputssnecho(Input_S_S_N_Echo_:\'\'),inputdobecho(Input_D_O_B_Echo_:\'\'),inputworkphoneecho(Input_Work_Phone_Echo_:\'\'),inputincomeecho(Input_Income_Echo_:\'\'),inputdlnumberecho(Input_D_L_Number_Echo_:\'\'),inputdlstateecho(Input_D_L_State_Echo_:\'\'),inputbalanceecho(Input_Balance_Echo_:\'\'),inputchargeoffdecho(Input_Charge_Offd_Echo_:\'\'),inputformernameecho(Input_Former_Name_Echo_:\'\'),inputemailecho(Input_Email_Echo_:\'\'),inputemploymentecho(Input_Employment_Echo_:\'\'),inputarchivedateecho(Input_Archive_Date_Echo_:\'\'),appendedlexid(Appended_Lex_I_D_:0),appendedlexidscore(Appended_Lex_I_D_Score_:0),inputprefixclean(Input_Prefix_Clean_:\'\'),inputfirstnameclean(Input_First_Name_Clean_:\'\'),inputmiddlenameclean(Input_Middle_Name_Clean_:\'\'),inputlastnameclean(Input_Last_Name_Clean_:\'\'),inputsuffixclean(Input_Suffix_Clean_:\'\'),inputprimaryrangeclean(Input_Primary_Range_Clean_:\'\'),inputpredirectionclean(Input_Pre_Direction_Clean_:\'\'),inputprimarynameclean(Input_Primary_Name_Clean_:\'\'),inputaddresssuffixclean(Input_Address_Suffix_Clean_:\'\'),inputpostdirectionclean(Input_Post_Direction_Clean_:\'\'),inputunitdesigclean(Input_Unit_Desig_Clean_:\'\'),inputsecondaryrangeclean(Input_Secondary_Range_Clean_:\'\'),inputcitynameclean(Input_City_Name_Clean_:\'\'),inputstateclean(Input_State_Clean_:\'\'),inputzip5clean(Input_Zip5_Clean_:\'\'),inputzip4clean(Input_Zip4_Clean_:\'\'),inputlatitudeclean(Input_Latitude_Clean_:\'\'),inputlongitudeclean(Input_Longitude_Clean_:\'\'),inputcountyclean(Input_County_Clean_:\'\'),inputgeoblockclean(Input_Geoblock_Clean_:\'\'),inputaddresstypeclean(Input_Address_Type_Clean_:\'\'),inputaddressstatusclean(Input_Address_Status_Clean_:\'\'),inputemailclean(Input_E_Mail_Clean_:\'\'),inputhomephoneclean(Input_Home_Phone_Clean_:\'\'),inputworkphoneclean(Input_Work_Phone_Clean_:\'\'),inputdlnumberclean(Input_D_L_Number_Clean_:\'\'),inputdlstateclean(Input_D_L_State_Clean_:\'\'),inputdobclean(Input_D_O_B_Clean_:DATE),inputssnclean(Input_S_S_N_Clean_:\'\'),inputarchivedateclean(Input_Archive_Date_Clean_:\'\'),repnumber(Rep_Number_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
    SHARED __d0_Prefiltered := __PInputPIIDataset((KEL.typ.uid)InputUIDAppend <> 0);
    SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
    EXPORT VIRTUAL DATASET(InLayout) InData := __d0;
  END;
  SHARED B_Input_B_I_I_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Input_B_I_I_1(__in,__cfg))
    SHARED TYPEOF(E_Input_B_I_I(__in,__cfg).__Result) __E_Input_B_I_I := E_Input_B_I_I_Params(__in,__cfg).__Result;
    SHARED TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I_Params(__in,__cfg).__Result;
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg).__Result) __E_Input_P_I_I := E_Input_P_I_I_Params(__in,__cfg).__Result;
  END;
  SHARED B_Input_P_I_I_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Input_P_I_I_1(__in,__cfg))
    SHARED TYPEOF(E_Input_P_I_I(__in,__cfg).__Result) __E_Input_P_I_I := E_Input_P_I_I_Params(__in,__cfg).__Result;
  END;
  SHARED B_Input_B_I_I_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Input_B_I_I(__in,__cfg))
    SHARED TYPEOF(B_Input_B_I_I_1(__in,__cfg).__ENH_Input_B_I_I_1) __ENH_Input_B_I_I_1 := B_Input_B_I_I_1_Local(__in,__cfg).__ENH_Input_B_I_I_1;
    SHARED TYPEOF(B_Input_P_I_I_1(__in,__cfg).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1_Local(__in,__cfg).__ENH_Input_P_I_I_1;
  END;
  SHARED TYPEOF(B_Input_B_I_I(__in).__ENH_Input_B_I_I) __ENH_Input_B_I_I := B_Input_B_I_I_Local(__in).__ENH_Input_B_I_I;
  SHARED __EE115126 := __ENH_Input_B_I_I;
  SHARED __ST8285_Layout := RECORD
    KEL.typ.nuid Bus_Input_U_I_D_Append_;
    KEL.typ.nstr Bus_Input_Account_Echo_;
    KEL.typ.nint Bus_Input_U_I_D_Append__1_;
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
    KEL.typ.nstr Bus_Input_I_P_Address_Echo_;
    KEL.typ.nstr Bus_Input_U_R_L_Echo_;
    KEL.typ.nstr Bus_Input_Email_Echo_;
    KEL.typ.nstr Bus_Input_S_I_C_Code_Echo_;
    KEL.typ.nstr Bus_Input_N_A_I_C_S_Code_Echo_;
    KEL.typ.nstr Bus_Input_Archive_Date_Echo_;
    KEL.typ.nint Bus_Input_Rep1_Lex_I_D_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_First_Name_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_Street_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_City_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_State_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_Phone_Echo_;
    KEL.typ.nstr Bus_Input_Rep1_Email_Echo_;
    KEL.typ.nint Bus_Input_Rep2_Lex_I_D_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_First_Name_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_Street_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_City_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_State_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_Phone_Echo_;
    KEL.typ.nstr Bus_Input_Rep2_Email_Echo_;
    KEL.typ.nint Bus_Input_Rep3_Lex_I_D_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_First_Name_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_Street_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_City_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_State_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_Phone_Echo_;
    KEL.typ.nstr Bus_Input_Rep3_Email_Echo_;
    KEL.typ.nint Bus_Input_Rep4_Lex_I_D_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_First_Name_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_Street_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_City_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_State_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_Phone_Echo_;
    KEL.typ.nstr Bus_Input_Rep4_Email_Echo_;
    KEL.typ.nint Bus_Input_Rep5_Lex_I_D_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_First_Name_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_Street_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_City_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_State_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_Phone_Echo_;
    KEL.typ.nstr Bus_Input_Rep5_Email_Echo_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST8285_Layout __ND114876__Project(B_Input_B_I_I(__in).__ST12100_Layout __PP114809) := TRANSFORM
    SELF.Bus_Input_U_I_D_Append_ := __PP114809.UID;
    SELF.Bus_Input_Account_Echo_ := __PP114809.Bus_Input_Account_Echo_Value_;
    SELF.Bus_Input_U_I_D_Append__1_ := __PP114809.Bus_Input_U_I_D_Append_;
    SELF.Input_Lex_I_D_Bus_Extended_Family_Echo_ := __PP114809.Input_Lex_I_D_Bus_Extended_Family_Echo_Value_;
    SELF.Input_Lex_I_D_Bus_Legal_Family_Echo_ := __PP114809.Input_Lex_I_D_Bus_Legal_Family_Echo_Value_;
    SELF.Input_Lex_I_D_Bus_Legal_Entity_Echo_ := __PP114809.Input_Lex_I_D_Bus_Legal_Entity_Echo_Value_;
    SELF.Input_Lex_I_D_Bus_Place_Group_Echo_ := __PP114809.Input_Lex_I_D_Bus_Place_Group_Echo_Value_;
    SELF.Input_Lex_I_D_Bus_Place_Echo_ := __PP114809.Input_Lex_I_D_Bus_Place_Echo_Value_;
    SELF.Bus_Input_Name_Echo_ := __PP114809.Bus_Input_Name_Echo_Value_;
    SELF.Bus_Input_Alternate_Name_Echo_ := __PP114809.Bus_Input_Alternate_Name_Echo_Value_;
    SELF.Bus_Input_Street_Echo_ := __PP114809.Bus_Input_Street_Echo_Value_;
    SELF.Bus_Input_City_Echo_ := __PP114809.Bus_Input_City_Echo_Value_;
    SELF.Bus_Input_State_Echo_ := __PP114809.Bus_Input_State_Echo_Value_;
    SELF.Bus_Input_Zip_Echo_ := __PP114809.Bus_Input_Zip_Echo_Value_;
    SELF.Bus_Input_Phone_Echo_ := __PP114809.Bus_Input_Phone_Echo_Value_;
    SELF.Bus_Input_I_P_Address_Echo_ := __PP114809.Bus_Input_I_P_Address_Echo_Value_;
    SELF.Bus_Input_U_R_L_Echo_ := __PP114809.Bus_Input_U_R_L_Echo_Value_;
    SELF.Bus_Input_Email_Echo_ := __PP114809.Bus_Input_Email_Echo_Value_;
    SELF.Bus_Input_S_I_C_Code_Echo_ := __PP114809.Bus_Input_S_I_C_Code_Echo_Value_;
    SELF.Bus_Input_N_A_I_C_S_Code_Echo_ := __PP114809.Bus_Input_N_A_I_C_S_Code_Echo_Value_;
    SELF.Bus_Input_Archive_Date_Echo_ := __PP114809.Bus_Input_Archive_Date_Echo_Value_;
    SELF.Bus_Input_Rep1_Lex_I_D_Echo_ := __PP114809.Bus_Input_Rep1_Lex_I_D_Echo_Value_;
    SELF.Bus_Input_Rep1_First_Name_Echo_ := __PP114809.Bus_Input_Rep1_First_Name_Echo_Value_;
    SELF.Bus_Input_Rep1_Street_Echo_ := __PP114809.Bus_Input_Rep1_Street_Echo_Value_;
    SELF.Bus_Input_Rep1_City_Echo_ := __PP114809.Bus_Input_Rep1_City_Echo_Value_;
    SELF.Bus_Input_Rep1_State_Echo_ := __PP114809.Bus_Input_Rep1_State_Echo_Value_;
    SELF.Bus_Input_Rep1_Zip_Echo_ := __PP114809.Bus_Input_Rep1_Zip_Echo_Value_;
    SELF.Bus_Input_Rep1_Phone_Echo_ := __PP114809.Bus_Input_Rep1_Phone_Echo_Value_;
    SELF.Bus_Input_Rep1_Email_Echo_ := __PP114809.Bus_Input_Rep1_Email_Echo_Value_;
    SELF.Bus_Input_Rep2_Lex_I_D_Echo_ := __PP114809.Bus_Input_Rep2_Lex_I_D_Echo_Value_;
    SELF.Bus_Input_Rep2_First_Name_Echo_ := __PP114809.Bus_Input_Rep2_First_Name_Echo_Value_;
    SELF.Bus_Input_Rep2_Street_Echo_ := __PP114809.Bus_Input_Rep2_Street_Echo_Value_;
    SELF.Bus_Input_Rep2_City_Echo_ := __PP114809.Bus_Input_Rep2_City_Echo_Value_;
    SELF.Bus_Input_Rep2_State_Echo_ := __PP114809.Bus_Input_Rep2_State_Echo_Value_;
    SELF.Bus_Input_Rep2_Zip_Echo_ := __PP114809.Bus_Input_Rep2_Zip_Echo_Value_;
    SELF.Bus_Input_Rep2_Phone_Echo_ := __PP114809.Bus_Input_Rep2_Phone_Echo_Value_;
    SELF.Bus_Input_Rep2_Email_Echo_ := __PP114809.Bus_Input_Rep2_Email_Echo_Value_;
    SELF.Bus_Input_Rep3_Lex_I_D_Echo_ := __PP114809.Bus_Input_Rep3_Lex_I_D_Echo_Value_;
    SELF.Bus_Input_Rep3_First_Name_Echo_ := __PP114809.Bus_Input_Rep3_First_Name_Echo_Value_;
    SELF.Bus_Input_Rep3_Street_Echo_ := __PP114809.Bus_Input_Rep3_Street_Echo_Value_;
    SELF.Bus_Input_Rep3_City_Echo_ := __PP114809.Bus_Input_Rep3_City_Echo_Value_;
    SELF.Bus_Input_Rep3_State_Echo_ := __PP114809.Bus_Input_Rep3_State_Echo_Value_;
    SELF.Bus_Input_Rep3_Zip_Echo_ := __PP114809.Bus_Input_Rep3_Zip_Echo_Value_;
    SELF.Bus_Input_Rep3_Phone_Echo_ := __PP114809.Bus_Input_Rep3_Phone_Echo_Value_;
    SELF.Bus_Input_Rep3_Email_Echo_ := __PP114809.Bus_Input_Rep3_Email_Echo_Value_;
    SELF.Bus_Input_Rep4_Lex_I_D_Echo_ := __PP114809.Bus_Input_Rep4_Lex_I_D_Echo_Value_;
    SELF.Bus_Input_Rep4_First_Name_Echo_ := __PP114809.Bus_Input_Rep4_First_Name_Echo_Value_;
    SELF.Bus_Input_Rep4_Street_Echo_ := __PP114809.Bus_Input_Rep4_Street_Echo_Value_;
    SELF.Bus_Input_Rep4_City_Echo_ := __PP114809.Bus_Input_Rep4_City_Echo_Value_;
    SELF.Bus_Input_Rep4_State_Echo_ := __PP114809.Bus_Input_Rep4_State_Echo_Value_;
    SELF.Bus_Input_Rep4_Zip_Echo_ := __PP114809.Bus_Input_Rep4_Zip_Echo_Value_;
    SELF.Bus_Input_Rep4_Phone_Echo_ := __PP114809.Bus_Input_Rep4_Phone_Echo_Value_;
    SELF.Bus_Input_Rep4_Email_Echo_ := __PP114809.Bus_Input_Rep4_Email_Echo_Value_;
    SELF.Bus_Input_Rep5_Lex_I_D_Echo_ := __PP114809.Bus_Input_Rep5_Lex_I_D_Echo_Value_;
    SELF.Bus_Input_Rep5_First_Name_Echo_ := __PP114809.Bus_Input_Rep5_First_Name_Echo_Value_;
    SELF.Bus_Input_Rep5_Street_Echo_ := __PP114809.Bus_Input_Rep5_Street_Echo_Value_;
    SELF.Bus_Input_Rep5_City_Echo_ := __PP114809.Bus_Input_Rep5_City_Echo_Value_;
    SELF.Bus_Input_Rep5_State_Echo_ := __PP114809.Bus_Input_Rep5_State_Echo_Value_;
    SELF.Bus_Input_Rep5_Zip_Echo_ := __PP114809.Bus_Input_Rep5_Zip_Echo_Value_;
    SELF.Bus_Input_Rep5_Phone_Echo_ := __PP114809.Bus_Input_Rep5_Phone_Echo_Value_;
    SELF.Bus_Input_Rep5_Email_Echo_ := __PP114809.Bus_Input_Rep5_Email_Echo_Value_;
    SELF := __PP114809;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE115126,__ND114876__Project(LEFT)));
END;
