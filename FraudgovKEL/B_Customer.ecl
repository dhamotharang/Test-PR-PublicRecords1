﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Customer_5,B_Person_1,E_Address,E_Customer,E_Customer_Person,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(E_Customer_Person.__Result) __E_Customer_Person := E_Customer_Person.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_1.__ENH_Person_1) __ENH_Person_1 := B_Person_1.__ENH_Person_1;
  SHARED __EE2751825 := __ENH_Customer_1;
  SHARED __EE2752421 := __ENH_Person_1;
  SHARED __EE2752419 := __E_Customer_Person;
  SHARED __EE2761722 := __EE2752419(__NN(__EE2752419._r_Customer_) AND __NN(__EE2752419.Subject_));
  SHARED __ST2756486_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
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
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
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
    B_Person_1.__NS2416622_Layout Best_Full_Name_;
    B_Person_1.__NS2416644_Layout Best_Reported_Address_;
    B_Person_1.__NS2416664_Layout Best_Reported_Email_;
    B_Person_1.__NS2416672_Layout Best_Reported_Ssn_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
    B_Person_1.__NS2416681_Layout Src_Type11_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2761746(B_Person_1.__ST82132_Layout __EE2752421, E_Customer_Person.Layout __EE2761722) := __EEQP(__EE2761722.Subject_,__EE2752421.UID);
  __ST2756486_Layout __JT2761746(B_Person_1.__ST82132_Layout __l, E_Customer_Person.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2761747 := JOIN(__EE2761722,__EE2752421,__JC2761746(RIGHT,LEFT),__JT2761746(RIGHT,LEFT),INNER,HASH);
  SHARED __ST2753133_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nuid U_I_D__1_;
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
    KEL.typ.int Address_Is_Out_Of_State30_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
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
    B_Person_1.__NS2416622_Layout Best_Full_Name_;
    B_Person_1.__NS2416644_Layout Best_Reported_Address_;
    B_Person_1.__NS2416664_Layout Best_Reported_Email_;
    B_Person_1.__NS2416672_Layout Best_Reported_Ssn_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nkdate Id_Activity_Dt_Last_Seen_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.nkdate Safe_Flag_Last_Date_;
    KEL.typ.int Safe_Flag_Transaction_Count_ := 0;
    B_Person_1.__NS2416681_Layout Src_Type11_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST2753133_Layout __ND2761919__Project(__ST2756486_Layout __PP2761748) := TRANSFORM
    SELF.UID := __PP2761748._r_Customer__1_;
    SELF._r_Customer_ := __PP2761748._r_Customer__1_;
    SELF.U_I_D__1_ := __PP2761748.UID;
    SELF._r_Customer__1_ := __PP2761748._r_Customer_;
    SELF := __PP2761748;
  END;
  SHARED __EE2762458 := PROJECT(__EE2761747,__ND2761919__Project(LEFT));
  SHARED __ST2753490_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST2753490_Layout __ND2762463__Project(__ST2753133_Layout __PP2762459) := TRANSFORM
    SELF.Exp1_ := __CN(__PP2762459.Address_Count_);
    SELF.Exp2_ := __CN(__PP2762459.Event_Count_);
    SELF := __PP2762459;
  END;
  SHARED __EE2762478 := PROJECT(__EE2762458,__ND2762463__Project(LEFT));
  SHARED __EE2762694 := __EE2762478;
  SHARED __ST2755748_Layout := RECORD
    KEL.typ.nint M_E_D_I_A_N___Address_Count_;
    KEL.typ.nint M_E_D_I_A_N___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  __ST2755748_WeightLayout := {KEL.typ.int M_E_D_I_A_N___Address_Count_,KEL.typ.int M_E_D_I_A_N___Event_Count_};
  __ST2755748_WeightLayout __ST2755748_WeightCalc(KEL.Aggregates.RankedFieldN __r) := TRANSFORM
    SELF.M_E_D_I_A_N___Address_Count_ := IF(__r.number = 1,KEL.Aggregates.NTileWeight(2,1,__r.size,__r.pos),0);
    SELF.M_E_D_I_A_N___Event_Count_ := IF(__r.number = 2,KEL.Aggregates.NTileWeight(2,1,__r.size,__r.pos),0);
  END;
  __ST2755748_Layout __ST2755748_Normalize(__ST2755748_Layout __r) := TRANSFORM
    SELF.M_E_D_I_A_N___Address_Count_ := __OP2(__r.M_E_D_I_A_N___Address_Count_,/,__CN(2));
    SELF.M_E_D_I_A_N___Event_Count_ := __OP2(__r.M_E_D_I_A_N___Event_Count_,/,__CN(2));
    SELF := __r;
  END;
  __RK2762702 := KEL.Aggregates.RankingGroupedSmall2(__EE2762694,'Exp1_,Exp2_','UID',__ST2755748_WeightLayout,__ST2755748_Layout,__ST2755748_WeightCalc,__ST2755748_Normalize,TRUE,FALSE,TRUE);
  SHARED __EE2762717 := __RK2762702;
  SHARED __ST2757953_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS141131_Layout Jurisdiction_State_Top_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_E_D_I_A_N___Address_Count_;
    KEL.typ.nint M_E_D_I_A_N___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2762723(B_Customer_1.__ST71756_Layout __EE2751825, __ST2755748_Layout __EE2762717) := __EEQP(__EE2751825.UID,__EE2762717.UID);
  __ST2757953_Layout __JT2762723(B_Customer_1.__ST71756_Layout __l, __ST2755748_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2762724 := JOIN(__EE2751825,__EE2762717,__JC2762723(LEFT,RIGHT),__JT2762723(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST2753510_Layout := RECORD
    KEL.typ.nfloat A_V_E___Address_Count_;
    KEL.typ.nfloat A_V_E___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE2762499 := PROJECT(__CLEANANDDO(__EE2762478,TABLE(__EE2762478,{KEL.Aggregates.AveNG(__EE2762478.Exp1_) A_V_E___Address_Count_,KEL.Aggregates.AveNG(__EE2762478.Exp2_) A_V_E___Event_Count_,UID},UID,MERGE)),__ST2753510_Layout);
  SHARED __ST2758136_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS141131_Layout Jurisdiction_State_Top_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_E_D_I_A_N___Address_Count_;
    KEL.typ.nint M_E_D_I_A_N___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.nfloat A_V_E___Address_Count_;
    KEL.typ.nfloat A_V_E___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2762759(__ST2757953_Layout __EE2762724, __ST2753510_Layout __EE2762499) := __EEQP(__EE2762724.UID,__EE2762499.UID);
  __ST2758136_Layout __JT2762759(__ST2757953_Layout __l, __ST2753510_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2762760 := JOIN(__EE2762724,__EE2762499,__JC2762759(LEFT,RIGHT),__JT2762759(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST47856_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.float All_Deceased_Matched_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.float All_High_Frequency_Address_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.float High_Frequency_Address_Percent_ := 0.0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS141131_Layout Jurisdiction_State_Top_;
    KEL.typ.nfloat Person_Address_Count_Average_;
    KEL.typ.nint Person_Address_Count_Median_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nfloat Person_Event_Count_Average_;
    KEL.typ.nint Person_Event_Count_Median_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST47856_Layout __ND2762797__Project(__ST2758136_Layout __PP2762761) := TRANSFORM
    SELF.All_Deceased_Matched_Percent_ := __PP2762761.All_Deceased_Matched_Person_Count_ / __PP2762761.All_Person_Count_;
    SELF.All_Deceased_Person_Percent_ := __PP2762761.All_Deceased_Person_Count_ / __PP2762761.All_Person_Count_;
    SELF.All_High_Frequency_Address_Percent_ := __PP2762761.All_High_Frequency_Address_Count_ / __PP2762761.All_Address_Count_;
    SELF.Deceased_Person_Percent_ := __PP2762761.Deceased_Person_Count_ / __PP2762761.Person_Count_;
    SELF.High_Frequency_Address_Percent_ := __PP2762761.High_Frequency_Address_Count_ / __PP2762761.Address_Count_;
    SELF.Person_Address_Count_Average_ := __PP2762761.A_V_E___Address_Count_;
    SELF.Person_Address_Count_Median_ := __PP2762761.M_E_D_I_A_N___Address_Count_;
    SELF.Person_Event_Count_Average_ := __PP2762761.A_V_E___Event_Count_;
    SELF.Person_Event_Count_Median_ := __PP2762761.M_E_D_I_A_N___Event_Count_;
    SELF := __PP2762761;
  END;
  EXPORT __ENH_Customer := PROJECT(__EE2762760,__ND2762797__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated',EXPIRE(7));
  SHARED __EE4712315 := __ENH_Customer;
  SHARED IDX_Customer_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE4712315.Customer_Id_;
    __EE4712315.Industry_Type_;
    __EE4712315._ind__type__description_;
    __EE4712315.States_;
    __EE4712315.Person_Count_;
    __EE4712315.All_Person_Count_;
    __EE4712315.Deceased_Person_Count_;
    __EE4712315.Deceased_Person_Percent_;
    __EE4712315.All_Deceased_Person_Count_;
    __EE4712315.All_Deceased_Person_Percent_;
    __EE4712315.All_Deceased_Matched_Person_Count_;
    __EE4712315.All_Deceased_Matched_Percent_;
    __EE4712315.Address_Count_;
    __EE4712315.All_Address_Count_;
    __EE4712315.High_Frequency_Address_Count_;
    __EE4712315.All_High_Frequency_Address_Count_;
    __EE4712315.High_Frequency_Address_Percent_;
    __EE4712315.All_High_Frequency_Address_Percent_;
    __EE4712315.Person_Event_Count_Average_;
    __EE4712315.Person_Event_Count_Median_;
    __EE4712315.Person_Address_Count_Average_;
    __EE4712315.Person_Address_Count_Median_;
    __EE4712315.Jurisdiction_State_Top_;
    __EE4712315.Jurisdiction_State_;
    __EE4712315.Event_Date_Max_;
    __EE4712315.Date_First_Seen_;
    __EE4712315.Date_Last_Seen_;
    __EE4712315.__RecordCount;
  END;
  SHARED IDX_Customer_UID_Projected := PROJECT(__EE4712315,TRANSFORM(IDX_Customer_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Customer_UID_Name := '~key::KEL::FraudgovKEL::Customer::UID';
  EXPORT IDX_Customer_UID := INDEX(IDX_Customer_UID_Projected,{UID},{IDX_Customer_UID_Projected},IDX_Customer_UID_Name);
  EXPORT IDX_Customer_UID_Build := BUILD(IDX_Customer_UID,OVERWRITE);
  EXPORT __ST4712317_Layout := RECORDOF(IDX_Customer_UID);
  EXPORT IDX_Customer_UID_Wrapped := PROJECT(IDX_Customer_UID,TRANSFORM(__ST47856_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Customer_UID_Build);
END;
