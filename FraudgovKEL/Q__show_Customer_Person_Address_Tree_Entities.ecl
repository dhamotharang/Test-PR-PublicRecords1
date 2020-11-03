﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Person,B_Person_1,E_Address,E_Customer,E_Person,E_Person_Address FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Person_Address_Tree_Entities := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Person.__ENH_Person) __ENH_Person := B_Person.__ENH_Person;
  SHARED TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE4362328 := __E_Person_Address;
  SHARED __EE4362311 := __ENH_Person;
  SHARED __ST4362346_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Person_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Flag_ := 0;
    KEL.typ.int Address_Is_Of_State30_Flag_ := 0;
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.nint Age_At_Last_Event_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Aot_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_App_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_App_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Nac_Coll_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Src1_Act_Cnt_Ev_ := 0;
    KEL.typ.bool Aot_Src1_Act_Only_Flag_ := FALSE;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    KEL.typ.nstr Best_City_;
    KEL.typ.nstr Best_Email_;
    KEL.typ.nstr Best_First_Name_;
    B_Person_1.__NS2226837_Layout Best_Full_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Middle_Name_;
    KEL.typ.nstr Best_Name_Suffix_;
    B_Person_1.__NS2226859_Layout Best_Reported_Address_;
    B_Person_1.__NS2226879_Layout Best_Reported_Email_;
    B_Person_1.__NS2226887_Layout Best_Reported_Ssn_;
    KEL.typ.nstr Best_Ssn_;
    KEL.typ.nstr Best_State_;
    KEL.typ.nstr Best_Street_Address_;
    KEL.typ.nstr Best_Zip_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Date_Of_Death_;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.ndataset(B_Person.__ST43145_Layout) Dt_Of_Death_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nkdate Id_Activity_Dt_First_Seen_;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen_;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Is_Minor_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nint Kr_Has_Known_Risk_Element_Flag_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.nkdate Kr_Last_Element_Event_Date_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
    KEL.typ.nint Source_Customer_Count_;
    B_Person_1.__NS2226896_Layout Src_Type11_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4362343(E_Person_Address.Layout __EE4362328, B_Person.__ST69802_Layout __EE4362311) := __EEQP(__EE4362328.Subject_,__EE4362311.UID);
  __ST4362346_Layout __JT4362343(E_Person_Address.Layout __l, B_Person.__ST69802_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4362344 := JOIN(__EE4362328,__EE4362311,__JC4362343(LEFT,RIGHT),__JT4362343(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE4362299 := __ENH_Address;
  SHARED __ST4362621_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Person_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Flag_ := 0;
    KEL.typ.int Address_Is_Of_State30_Flag_ := 0;
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.nint Age_At_Last_Event_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Aot_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_App_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_App_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Nac_Coll_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Src1_Act_Cnt_Ev_ := 0;
    KEL.typ.bool Aot_Src1_Act_Only_Flag_ := FALSE;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    KEL.typ.nstr Best_City_;
    KEL.typ.nstr Best_Email_;
    KEL.typ.nstr Best_First_Name_;
    B_Person_1.__NS2226837_Layout Best_Full_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Middle_Name_;
    KEL.typ.nstr Best_Name_Suffix_;
    B_Person_1.__NS2226859_Layout Best_Reported_Address_;
    B_Person_1.__NS2226879_Layout Best_Reported_Email_;
    B_Person_1.__NS2226887_Layout Best_Reported_Ssn_;
    KEL.typ.nstr Best_Ssn_;
    KEL.typ.nstr Best_State_;
    KEL.typ.nstr Best_Street_Address_;
    KEL.typ.nstr Best_Zip_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Date_Of_Death_;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.ndataset(B_Person.__ST43145_Layout) Dt_Of_Death_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nkdate Id_Activity_Dt_First_Seen_;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen_;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Is_Minor_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nint Kr_Has_Known_Risk_Element_Flag_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.nkdate Kr_Last_Element_Event_Date_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
    KEL.typ.nint Source_Customer_Count_;
    B_Person_1.__NS2226896_Layout Src_Type11_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.nint Address_Is_Cmra_;
    KEL.typ.nint Address_Is_Po_Box_;
    KEL.typ.nint Address_Is_Vacant_;
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Ao_T_Add_Act_Cnt30_D_ := 0;
    KEL.typ.int Ao_T_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Act_Cnt_Ev__1_ := 0;
    KEL.typ.int Aot_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Addr_Kr_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Addr_Kr_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Addr_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Addr_Kr_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Addr_Kr_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Addr_New_Kr_Aft_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Addr_New_Kr_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Addr_New_Kr_Aft_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Addr_Safe_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Addr_Safe_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Addr_Safe_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Act_Cnt30_D__1_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt_Ev__1_ := 0;
    KEL.typ.int Aot_Id_Curr_Prof_Usng_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Hist_Prof_Usng_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Usng_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt30_D__1_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt_Ev__1_ := 0;
    KEL.typ.int Aot_Src1_Act_Cnt_Ev__1_ := 0;
    KEL.typ.bool Aot_Src1_Act_Only_Flag__1_ := FALSE;
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.float Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nkdate Dt_First_Seen__1_;
    KEL.typ.nkdate Dt_Last_Seen__1_;
    KEL.typ.nstr Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.nkdate Id_Activity_Dt_First_Seen__1_;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen__1_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Invalid_Address_ := 0;
    KEL.typ.int Kr_Addr300_Flag_ := 0;
    KEL.typ.int Kr_Addr301_Flag_ := 0;
    KEL.typ.int Kr_Addr302_Flag_ := 0;
    KEL.typ.int Kr_Addr303_Flag_ := 0;
    KEL.typ.int Kr_Addr390_Flag_ := 0;
    KEL.typ.int Kr_Addr391_Flag_ := 0;
    KEL.typ.int Kr_Addr392_Flag_ := 0;
    KEL.typ.int Kr_Addr393_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count__1_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Flag__1_ := 0;
    KEL.typ.int Kr_High_Risk_Flag__1_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date__1_;
    KEL.typ.int Kr_Low_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag__1_ := 0;
    KEL.typ.nkdate Last_Event_Date__1_;
    KEL.typ.nint Last_Record_Id__1_;
    KEL.typ.int Not_In_Jurisdiction_State_ := 0;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.nstr Street_Address_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4363474(__ST4362346_Layout __EE4362344, B_Address.__ST47626_Layout __EE4362299) := __EEQP(__EE4362344.Location_,__EE4362299.UID);
  __ST4362621_Layout __JT4363474(__ST4362346_Layout __l, B_Address.__ST47626_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__2_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF.Aot_Act_Cnt_Ev__1_ := __r.Aot_Act_Cnt_Ev_;
    SELF.Aot_Id_Act_Cnt30_D__1_ := __r.Aot_Id_Act_Cnt30_D_;
    SELF.Aot_Id_Act_Cnt_Ev__1_ := __r.Aot_Id_Act_Cnt_Ev_;
    SELF.Aot_Non_St_Act_Cnt30_D__1_ := __r.Aot_Non_St_Act_Cnt30_D_;
    SELF.Aot_Non_St_Act_Cnt_Ev__1_ := __r.Aot_Non_St_Act_Cnt_Ev_;
    SELF.Aot_Src1_Act_Cnt_Ev__1_ := __r.Aot_Src1_Act_Cnt_Ev_;
    SELF.Aot_Src1_Act_Only_Flag__1_ := __r.Aot_Src1_Act_Only_Flag_;
    SELF.Contributor_Safe_Flag__1_ := __r.Contributor_Safe_Flag_;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Dt_First_Seen__1_ := __r.Dt_First_Seen_;
    SELF.Dt_Last_Seen__1_ := __r.Dt_Last_Seen_;
    SELF.Entity_Context_Uid__1_ := __r.Entity_Context_Uid_;
    SELF.Entity_Type__1_ := __r.Entity_Type_;
    SELF.Event_Count__1_ := __r.Event_Count_;
    SELF.Id_Activity_Dt_First_Seen__1_ := __r.Id_Activity_Dt_First_Seen_;
    SELF.Id_Activity_Dt_Last_Seen__1_ := __r.Id_Activity_Dt_Last_Seen_;
    SELF.In_Customer_Population__1_ := __r.In_Customer_Population_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Kr_Event_After_Last_Known_Risk_Count__1_ := __r.Kr_Event_After_Last_Known_Risk_Count_;
    SELF.Kr_Event_After_Last_Known_Risk_Flag__1_ := __r.Kr_Event_After_Last_Known_Risk_Flag_;
    SELF.Kr_Flag__1_ := __r.Kr_Flag_;
    SELF.Kr_High_Risk_Flag__1_ := __r.Kr_High_Risk_Flag_;
    SELF.Kr_Last_Event_Date__1_ := __r.Kr_Last_Event_Date_;
    SELF.Kr_Low_Risk_Flag__1_ := __r.Kr_Low_Risk_Flag_;
    SELF.Kr_Medium_Risk_Flag__1_ := __r.Kr_Medium_Risk_Flag_;
    SELF.Last_Event_Date__1_ := __r.Last_Event_Date_;
    SELF.Last_Record_Id__1_ := __r.Last_Record_Id_;
    SELF.Safe_Flag__1_ := __r.Safe_Flag_;
    SELF.Source_Customer_Count__1_ := __r.Source_Customer_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4363475 := JOIN(__EE4362344,__EE4362299,__JC4363474(LEFT,RIGHT),__JT4363474(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE4362284 := __E_Customer;
  SHARED __ST4363070_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Person_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Count_ := 0;
    KEL.typ.int Address_Is_Cmra30_Flag_ := 0;
    KEL.typ.int Address_Is_Of_State30_Flag_ := 0;
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.nint Age_At_Last_Event_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Aot_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_App_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_App_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_App_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Gen_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Oth_Frd_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Id_Kr_Stol_Id_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Nac_Coll_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_New_Kr_Aft_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt30_D_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Src1_Act_Cnt_Ev_ := 0;
    KEL.typ.bool Aot_Src1_Act_Only_Flag_ := FALSE;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    KEL.typ.nstr Best_City_;
    KEL.typ.nstr Best_Email_;
    KEL.typ.nstr Best_First_Name_;
    B_Person_1.__NS2226837_Layout Best_Full_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Middle_Name_;
    KEL.typ.nstr Best_Name_Suffix_;
    B_Person_1.__NS2226859_Layout Best_Reported_Address_;
    B_Person_1.__NS2226879_Layout Best_Reported_Email_;
    B_Person_1.__NS2226887_Layout Best_Reported_Ssn_;
    KEL.typ.nstr Best_Ssn_;
    KEL.typ.nstr Best_State_;
    KEL.typ.nstr Best_Street_Address_;
    KEL.typ.nstr Best_Zip_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Date_Of_Death_;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.ndataset(B_Person.__ST43145_Layout) Dt_Of_Death_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nkdate Id_Activity_Dt_First_Seen_;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen_;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Is_Minor_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nint Kr_Has_Known_Risk_Element_Flag_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.nkdate Kr_Last_Element_Event_Date_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nkdate Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
    KEL.typ.nint Source_Customer_Count_;
    B_Person_1.__NS2226896_Layout Src_Type11_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.nint Address_Is_Cmra_;
    KEL.typ.nint Address_Is_Po_Box_;
    KEL.typ.nint Address_Is_Vacant_;
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Ao_T_Add_Act_Cnt30_D_ := 0;
    KEL.typ.int Ao_T_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Act_Cnt_Ev__1_ := 0;
    KEL.typ.int Aot_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Addr_Kr_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Addr_Kr_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Addr_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Addr_Kr_Act_Shrd_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Addr_Kr_Act_Shrd_Old_Dt_Ev_;
    KEL.typ.int Aot_Addr_New_Kr_Aft_Add_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Addr_New_Kr_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Addr_New_Kr_Aft_Non_St_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Addr_Safe_Act_Cnt_Ev_ := 0;
    KEL.typ.nkdate Aot_Addr_Safe_Act_New_Dt_Ev_;
    KEL.typ.nkdate Aot_Addr_Safe_Act_Old_Dt_Ev_;
    KEL.typ.int Aot_Id_Act_Cnt30_D__1_ := 0;
    KEL.typ.int Aot_Id_Act_Cnt_Ev__1_ := 0;
    KEL.typ.int Aot_Id_Curr_Prof_Usng_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Hist_Prof_Usng_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Usng_Addr_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt30_D__1_ := 0;
    KEL.typ.int Aot_Non_St_Act_Cnt_Ev__1_ := 0;
    KEL.typ.int Aot_Src1_Act_Cnt_Ev__1_ := 0;
    KEL.typ.bool Aot_Src1_Act_Only_Flag__1_ := FALSE;
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.float Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nkdate Dt_First_Seen__1_;
    KEL.typ.nkdate Dt_Last_Seen__1_;
    KEL.typ.nstr Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.nkdate Id_Activity_Dt_First_Seen__1_;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen__1_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Invalid_Address_ := 0;
    KEL.typ.int Kr_Addr300_Flag_ := 0;
    KEL.typ.int Kr_Addr301_Flag_ := 0;
    KEL.typ.int Kr_Addr302_Flag_ := 0;
    KEL.typ.int Kr_Addr303_Flag_ := 0;
    KEL.typ.int Kr_Addr390_Flag_ := 0;
    KEL.typ.int Kr_Addr391_Flag_ := 0;
    KEL.typ.int Kr_Addr392_Flag_ := 0;
    KEL.typ.int Kr_Addr393_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count__1_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Flag__1_ := 0;
    KEL.typ.int Kr_High_Risk_Flag__1_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date__1_;
    KEL.typ.int Kr_Low_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag__1_ := 0;
    KEL.typ.nkdate Last_Event_Date__1_;
    KEL.typ.nint Last_Record_Id__1_;
    KEL.typ.int Not_In_Jurisdiction_State_ := 0;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.nstr Street_Address_;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.nint Customer_Id__2_;
    KEL.typ.nint Industry_Type__2_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4363476(__ST4362621_Layout __EE4363475, E_Customer.Layout __EE4362284) := __EEQP(__EE4363475._r_Customer_,__EE4362284.UID);
  __ST4363070_Layout __JT4363476(__ST4362621_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF.Customer_Id__2_ := __r.Customer_Id_;
    SELF.Industry_Type__2_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4363477 := JOIN(__EE4363475,__EE4362284,__JC4363476(LEFT,RIGHT),__JT4363476(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST46616_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Tree_Uid_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST46616_Layout __ND4363466__Project(__ST4363070_Layout __PP4363465) := TRANSFORM
    SELF.Source_Customer_ := __PP4363465._r_Customer_;
    SELF.Customer_Id_ := __PP4363465.Customer_Id__2_;
    SELF.Industry_Type_ := __PP4363465.Industry_Type__2_;
    SELF.Tree_Uid_ := __PP4363465.Entity_Context_Uid__1_;
    SELF := __PP4363465;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE4363477,__ND4363466__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_},Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_,MERGE),__ST46616_Layout));
END;
