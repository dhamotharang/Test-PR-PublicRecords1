﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Accident,E_Person,E_Person_Accident FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Accident_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Accident(__in,__cfg).__Result) __E_Accident := E_Accident(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Accident(__in,__cfg).__Result) __E_Person_Accident := E_Person_Accident(__in,__cfg).__Result;
  SHARED __EE444490 := __E_Person_Accident;
  SHARED __ST444815_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.nstr Point_Of_Impact_;
    KEL.typ.nstr Driver_B_A_C_Test_Type_;
    KEL.typ.nint Driver_B_A_C_Test_Results_;
    KEL.typ.nint Driver_Alcohol_Drug_Code_;
    KEL.typ.nint Driver_Physical_Defects_;
    KEL.typ.nint Driver_Residence_;
    KEL.typ.nint Driver_Injury_Severity_;
    KEL.typ.nint First_Driver_Safety_;
    KEL.typ.nint Second_Driver_Safety_;
    KEL.typ.nint Driver_Eject_Code_;
    KEL.typ.nint Recommend_Reexam_;
    KEL.typ.nint First_Contributing_Cause_;
    KEL.typ.nint Second_Contributing_Cause_;
    KEL.typ.nint Third_Contributing_Cause_;
    KEL.typ.nstr Vehicle_Incident_I_D_;
    KEL.typ.nstr Vehicle_Status_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Airbags_Deploy_;
    KEL.typ.nint Towed_;
    KEL.typ.nstr Impact_Location_;
    KEL.typ.nint Vehicle_Owner_Driver_Code_;
    KEL.typ.nint Vehicle_Driver_Action_;
    KEL.typ.nstr Vehicle_Travel_On_;
    KEL.typ.nstr Direction_Of_Travel_;
    KEL.typ.nint Estimated_Vehicle_Speed_;
    KEL.typ.nint Posted_Speed_;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nint Damage_Type_;
    KEL.typ.nstr Vehicle_Removed_By_;
    KEL.typ.nint How_Removed_Code_;
    KEL.typ.nint Vehicle_Movement_;
    KEL.typ.nint Vehicle_Function_;
    KEL.typ.nint Vehicle_First_Defect_;
    KEL.typ.nint Vehicle_Second_Defect_;
    KEL.typ.nint Vehicle_Roadway_Location_;
    KEL.typ.nint Hazardous_Material_Transport_;
    KEL.typ.nint Total_Occupancy_Vehicle_;
    KEL.typ.nint Total_Occupancy_Safety_Equipment_;
    KEL.typ.nint Moving_Violation_;
    KEL.typ.nint Vehicle_Fault_Code_;
    KEL.typ.nstr Vehicle_Insured_Code_;
    KEL.typ.ndataset(E_Person_Accident(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Acc__1_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE444404 := __E_Accident;
  SHARED __EE444416 := __EE444404.Report_Codes_;
  SHARED __CC13998 := ['FA','A','IA','EA','TF'];
  __JC6150794(E_Accident(__in,__cfg).Report_Codes_Layout __EE444416) := __T(__OP2(__EE444416.Report_Code_,IN,__CN(__CC13998)));
  SHARED __EE6150795 := __EE444404(EXISTS(__CHILDJOINFILTER(__EE444416,__JC6150794)));
  __JC6150828(E_Person_Accident(__in,__cfg).Layout __EE444490, E_Accident(__in,__cfg).Layout __EE6150795) := __EEQP(__EE444490.Acc_,__EE6150795.UID);
  __JF6150828(E_Accident(__in,__cfg).Layout __EE6150795) := __NN(__EE6150795.UID);
  SHARED __EE6150877 := JOIN(__EE444490,__EE6150795,__JC6150828(LEFT,RIGHT),TRANSFORM(__ST444815_Layout,SELF:=LEFT,SELF.Acc__1_:=__JF6150828(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST285174_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.nstr Point_Of_Impact_;
    KEL.typ.nstr Driver_B_A_C_Test_Type_;
    KEL.typ.nint Driver_B_A_C_Test_Results_;
    KEL.typ.nint Driver_Alcohol_Drug_Code_;
    KEL.typ.nint Driver_Physical_Defects_;
    KEL.typ.nint Driver_Residence_;
    KEL.typ.nint Driver_Injury_Severity_;
    KEL.typ.nint First_Driver_Safety_;
    KEL.typ.nint Second_Driver_Safety_;
    KEL.typ.nint Driver_Eject_Code_;
    KEL.typ.nint Recommend_Reexam_;
    KEL.typ.nint First_Contributing_Cause_;
    KEL.typ.nint Second_Contributing_Cause_;
    KEL.typ.nint Third_Contributing_Cause_;
    KEL.typ.nstr Vehicle_Incident_I_D_;
    KEL.typ.nstr Vehicle_Status_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Airbags_Deploy_;
    KEL.typ.nint Towed_;
    KEL.typ.nstr Impact_Location_;
    KEL.typ.nint Vehicle_Owner_Driver_Code_;
    KEL.typ.nint Vehicle_Driver_Action_;
    KEL.typ.nstr Vehicle_Travel_On_;
    KEL.typ.nstr Direction_Of_Travel_;
    KEL.typ.nint Estimated_Vehicle_Speed_;
    KEL.typ.nint Posted_Speed_;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nint Damage_Type_;
    KEL.typ.nstr Vehicle_Removed_By_;
    KEL.typ.nint How_Removed_Code_;
    KEL.typ.nint Vehicle_Movement_;
    KEL.typ.nint Vehicle_Function_;
    KEL.typ.nint Vehicle_First_Defect_;
    KEL.typ.nint Vehicle_Second_Defect_;
    KEL.typ.nint Vehicle_Roadway_Location_;
    KEL.typ.nint Hazardous_Material_Transport_;
    KEL.typ.nint Total_Occupancy_Vehicle_;
    KEL.typ.nint Total_Occupancy_Safety_Equipment_;
    KEL.typ.nint Moving_Violation_;
    KEL.typ.nint Vehicle_Fault_Code_;
    KEL.typ.nstr Vehicle_Insured_Code_;
    KEL.typ.ndataset(E_Person_Accident(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Is_Accident_Record_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Person_Accident_8 := PROJECT(__EE6150877,TRANSFORM(__ST285174_Layout,SELF.Is_Accident_Record_ := LEFT.Acc__1_,SELF := LEFT));
END;
