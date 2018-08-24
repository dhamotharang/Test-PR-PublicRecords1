﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Event_1,B_Internet_Protocol_1,E_Address,E_Customer,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1.__ENH_Event_1;
  SHARED VIRTUAL TYPEOF(B_Internet_Protocol_1.__ENH_Internet_Protocol_1) __ENH_Internet_Protocol_1 := B_Internet_Protocol_1.__ENH_Internet_Protocol_1;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE206706 := __ENH_Internet_Protocol_1;
  SHARED __EE211775 := __ENH_Event_1;
  SHARED __EE211727 := __E_Person_Event;
  SHARED __EE212751 := __EE211727;
  SHARED __EE212764 := __EE212751(__NN(__EE212751.Ip_) AND __NN(__EE212751.Transaction_));
  SHARED __ST209017_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.ndataset(E_Event.Hri_List_Layout) Hri_List_;
    KEL.typ.nint Age_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Identity_Flag_ := 0;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject__1_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC212770(B_Event_1.__ST7975_Layout __EE211775, E_Person_Event.Layout __EE212764) := __EEQP(__EE212764.Transaction_,__EE211775.UID);
  __ST209017_Layout __JT212770(B_Event_1.__ST7975_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE212771 := JOIN(__EE212764,__EE211775,__JC212770(RIGHT,LEFT),__JT212770(RIGHT,LEFT),INNER,HASH);
  SHARED __ST208576_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST208576_Layout __ND212818__Project(__ST209017_Layout __PP212772) := TRANSFORM
    SELF.UID := __PP212772.Ip_;
    SELF._r_Customer_ := __PP212772._r_Customer__1_;
    SELF.Subject_ := __PP212772.Subject__1_;
    SELF.Location_ := __PP212772.Location__1_;
    SELF.Event_Date_ := __PP212772.Event_Date__1_;
    SELF.U_I_D__1_ := __PP212772.UID;
    SELF := __PP212772;
  END;
  SHARED __EE212871 := PROJECT(__EE212771,__ND212818__Project(LEFT));
  SHARED __ST208631_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST208631_Layout __ND213522__Project(__ST208576_Layout __PP212872) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP212872.Age_,<,__CN(2));
    SELF.Exp2_ := __AND(__OP2(__PP212872.Age_,<,__CN(2)),__CN(__PP212872.In_Customer_Population_ = 1));
    SELF.Exp3_ := __OP2(__PP212872.Age_,<,__CN(366));
    SELF.Exp4_ := __AND(__OP2(__PP212872.Age_,<,__CN(366)),__CN(__PP212872.In_Customer_Population_ = 1));
    SELF := __PP212872;
  END;
  SHARED __EE213539 := PROJECT(__EE212871,__ND213522__Project(LEFT));
  SHARED __ST208661_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE213574 := PROJECT(__CLEANANDDO(__EE213539,TABLE(__EE213539,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE213539.Exp1_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE213539.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE213539.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE213539.Exp4_)),UID},UID,MERGE)),__ST208661_Layout);
  SHARED __ST209135_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC213580(B_Internet_Protocol_1.__ST8025_Layout __EE206706, __ST208661_Layout __EE213574) := __EEQP(__EE206706.UID,__EE213574.UID);
  __ST209135_Layout __JT213580(B_Internet_Protocol_1.__ST8025_Layout __l, __ST208661_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE213622 := JOIN(__EE206706,__EE213574,__JC213580(LEFT,RIGHT),__JT213580(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE211734 := __EE211727(__NN(__EE211727.Ip_));
  SHARED __EE212748 := __EE211734;
  SHARED __ST208128_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE213003 := DEDUP(PROJECT(__EE212748,TRANSFORM(__ST208128_Layout,SELF.UID := LEFT.Ip_,SELF := LEFT)),ALL);
  SHARED __ST208146_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE213016 := PROJECT(__CLEANANDDO(__EE213003,TABLE(__EE213003,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST208146_Layout);
  SHARED __ST209435_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC213628(__ST209135_Layout __EE213622, __ST208146_Layout __EE213016) := __EEQP(__EE213622.UID,__EE213016.UID);
  __ST209435_Layout __JT213628(__ST209135_Layout __l, __ST208146_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE213672 := JOIN(__EE213622,__EE213016,__JC213628(LEFT,RIGHT),__JT213628(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST207878_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE211748 := DEDUP(PROJECT(__EE211734,TRANSFORM(__ST207878_Layout,SELF.UID := LEFT.Ip_,SELF := LEFT)),ALL);
  SHARED __ST207896_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE211710 := PROJECT(__CLEANANDDO(__EE211748,TABLE(__EE211748,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST207896_Layout);
  SHARED __ST209734_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC213678(__ST209435_Layout __EE213672, __ST207896_Layout __EE211710) := __EEQP(__EE213672.UID,__EE211710.UID);
  __ST209734_Layout __JT213678(__ST209435_Layout __l, __ST207896_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Event__1_ := __r.C_O_U_N_T___Person_Event_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE213726 := JOIN(__EE213672,__EE211710,__JC213678(LEFT,RIGHT),__JT213678(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE206897 := __ENH_Customer_1;
  SHARED __EE212742 := __EE206897;
  SHARED __ST210034_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__3_;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC213732(__ST209734_Layout __EE213726, B_Customer_1.__ST7915_Layout __EE212742) := __EEQP(__EE213726._r_Customer_,__EE212742.UID);
  __ST210034_Layout __JT213732(__ST209734_Layout __l, B_Customer_1.__ST7915_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE213790 := JOIN(__EE213726,__EE212742,__JC213732(LEFT,RIGHT),__JT213732(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST210341_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__3_;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nuid U_I_D__5_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Address_Count__1_ := 0;
    KEL.typ.int All_Address_Count__1_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count__1_ := 0;
    KEL.typ.int All_Deceased_Person_Count__1_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int All_Person_Count__1_ := 0;
    KEL.typ.int Deceased_Person_Count__1_ := 0;
    KEL.typ.int High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int Person_Count__1_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC213796(__ST210034_Layout __EE213790, B_Customer_1.__ST7915_Layout __EE206897) := __EEQP(__EE213790._r_Customer_,__EE206897.UID);
  __ST210341_Layout __JT213796(__ST210034_Layout __l, B_Customer_1.__ST7915_Layout __r) := TRANSFORM
    SELF.U_I_D__5_ := __r.UID;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Address_Count__1_ := __r.Address_Count_;
    SELF.All_Address_Count__1_ := __r.All_Address_Count_;
    SELF.All_Deceased_Matched_Person_Count__1_ := __r.All_Deceased_Matched_Person_Count_;
    SELF.All_Deceased_Person_Count__1_ := __r.All_Deceased_Person_Count_;
    SELF.All_High_Frequency_Address_Count__1_ := __r.All_High_Frequency_Address_Count_;
    SELF.All_Person_Count__1_ := __r.All_Person_Count_;
    SELF.Deceased_Person_Count__1_ := __r.Deceased_Person_Count_;
    SELF.High_Frequency_Address_Count__1_ := __r.High_Frequency_Address_Count_;
    SELF.Person_Count__1_ := __r.Person_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE213888 := JOIN(__EE213790,__EE206897,__JC213796(LEFT,RIGHT),__JT213796(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST7354_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.int Vl_Event1_All_Count_ := 0;
    KEL.typ.int Vl_Event1_Count_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event365_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST7354_Layout __ND213893__Project(__ST210341_Layout __PP213889) := TRANSFORM
    SELF.Cl_Element_Count_ := 0;
    SELF.Cl_Impact_Weight_ := __OP2(__OP2(__OP2(__OP2(__PP213889.Cl_Identity_Count_Percentile_,*,__CN(0.3)),+,__OP2(__PP213889.Cl_Event_Count_Percentile_,*,__CN(0.3))),+,__OP2(__PP213889.Cl_Active30_Identity_Count_Percentile_,*,__CN(0.2))),+,__OP2(__PP213889.Cl_Active7_Identity_Count_Percentile_,*,__CN(0.2)));
    SELF.Cluster_Score_ := 0;
    SELF.Customer_Id_ := __PP213889.Customer_Id__1_;
    SELF.Entity_Context_Uid_ := __OP2(__CN('_18'),+,__PP213889.Otto_Ip_Address_Id_);
    SELF.Entity_Type_ := 18;
    SELF.Event_Count_ := __PP213889.C_O_U_N_T___Person_Event__1_;
    SELF.Identity_Count_ := __PP213889.C_O_U_N_T___Person_Event_;
    SELF.Label_ := __PP213889.Ip_Address_;
    SELF.Score_ := __OP2(__PP213889.UID,%,__CN(100));
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP213889.Source_Customers_);
    SELF.Vl_Event1_All_Count_ := __PP213889.C_O_U_N_T___Exp1_;
    SELF.Vl_Event1_Count_ := __PP213889.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event30_Active_Flag_ := MAP(__PP213889.Vl_Event30_Count_ > 0=>1,0);
    SELF.Vl_Event30_All_Active_Flag_ := MAP(__PP213889.Vl_Event30_All_Day_Count_ > 0=>1,0);
    SELF.Vl_Event365_All_Day_Count_ := __PP213889.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event365_Count_ := __PP213889.C_O_U_N_T___Exp1__3_;
    SELF.Vl_Event7_Active_Flag_ := MAP(__PP213889.Vl_Event7_Count_ > 0=>1,0);
    SELF.Vl_Event7_All_Active_Flag_ := MAP(__PP213889.Vl_Event7_All_Count_ > 0=>1,0);
    SELF := __PP213889;
  END;
  EXPORT __ENH_Internet_Protocol := PROJECT(__EE213888,__ND213893__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Internet_Protocol::Annotated',EXPIRE(30));
  SHARED __EE342600 := __ENH_Internet_Protocol;
  SHARED IDX_Internet_Protocol_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE342600._r_Customer_;
    __EE342600.Source_Customers_;
    __EE342600.Ip_Address_;
    __EE342600.Otto_Ip_Address_Id_;
    __EE342600._host_;
    __EE342600._alias_;
    __EE342600._location_;
    __EE342600._ip__address_;
    __EE342600._ip__address__date_;
    __EE342600._version_;
    __EE342600._class_;
    __EE342600._subnet__mask_;
    __EE342600._reserved_;
    __EE342600._isp_;
    __EE342600._v2__validationipproblems_;
    __EE342600._v2__ipstate_;
    __EE342600._v2__ipcountry_;
    __EE342600._v2__ipcontinent_;
    __EE342600.Customer_Id_;
    __EE342600.Industry_Type_;
    __EE342600.Source_Customer_Count_;
    __EE342600.Entity_Context_Uid_;
    __EE342600.Label_;
    __EE342600.Entity_Type_;
    __EE342600.Identity_Count_;
    __EE342600.Event_Count_;
    __EE342600.Vl_Event1_All_Count_;
    __EE342600.Vl_Event7_All_Count_;
    __EE342600.Vl_Event30_All_Day_Count_;
    __EE342600.Vl_Event365_All_Day_Count_;
    __EE342600.Vl_Event7_All_Active_Flag_;
    __EE342600.Vl_Event30_All_Active_Flag_;
    __EE342600.Vl_Event1_Count_;
    __EE342600.Vl_Event7_Count_;
    __EE342600.Vl_Event30_Count_;
    __EE342600.Vl_Event365_Count_;
    __EE342600.Vl_Event7_Active_Flag_;
    __EE342600.Vl_Event30_Active_Flag_;
    __EE342600.Cl_Active7_Identity_Count_;
    __EE342600.Cl_Active30_Identity_Count_;
    __EE342600.Cl_Event_Count_;
    __EE342600.Cl_Identity_Count_;
    __EE342600.Cl_Element_Count_;
    __EE342600.Cl_Identity_Count_Percentile_;
    __EE342600.Cl_Event_Count_Percentile_;
    __EE342600.Cl_Active30_Identity_Count_Percentile_;
    __EE342600.Cl_Active7_Identity_Count_Percentile_;
    __EE342600.Cl_Impact_Weight_;
    __EE342600.Score_;
    __EE342600.Cluster_Score_;
    __EE342600.Date_First_Seen_;
    __EE342600.Date_Last_Seen_;
    __EE342600.__RecordCount;
  END;
  SHARED IDX_Internet_Protocol_UID_Projected := PROJECT(__EE342600,TRANSFORM(IDX_Internet_Protocol_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Internet_Protocol_UID := INDEX(IDX_Internet_Protocol_UID_Projected,{UID},{IDX_Internet_Protocol_UID_Projected},'~key::KEL::KELOtto::Internet_Protocol::UID');
  EXPORT IDX_Internet_Protocol_UID_Build := BUILD(IDX_Internet_Protocol_UID,OVERWRITE);
  EXPORT __ST342602_Layout := RECORDOF(IDX_Internet_Protocol_UID);
  EXPORT IDX_Internet_Protocol_UID_Wrapped := PROJECT(IDX_Internet_Protocol_UID,TRANSFORM(__ST7354_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Internet_Protocol_UID_Build);
END;
