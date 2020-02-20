//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Aircraft,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Aircraft_Owner_4,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Prox_4,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Criminal_Offender,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Punishment,B_First_Degree_Relative,B_Inquiry,B_Lien_Judgment,B_Lien_Judgment_1,B_Lien_Judgment_2,B_Lien_Judgment_3,B_Lien_Judgment_4,B_Lien_Judgment_5,B_Lien_Judgment_6,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_Bankruptcy_1,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Person_Vehicle_4,B_Phone,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property,B_Second_Degree_Associations,B_Sele_Aircraft_1,B_Sele_Bankruptcy_1,B_Sele_Lien_Judgment_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Sele_Vehicle_4,B_Sele_Watercraft_1,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_11,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C,B_Vehicle,B_Watercraft,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,B_Watercraft_Owner_4,CFG_Compile,E_Accident,E_Address,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Address_Property_Event,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_Education,E_Email,E_Employment,E_Employment_Person,E_First_Degree_Associations,E_First_Degree_Relative,E_House_Hold_Phone,E_Household,E_Household_Member,E_Inquiry,E_Lien_Judgment,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Email_Phone_Address,E_Person_Inquiry,E_Person_Lien_Judgment,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_Property_Event,E_Person_S_S_N,E_Person_U_C_C,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Prox_Address,E_Prox_Email,E_Prox_Person,E_Prox_Phone_Number,E_Prox_T_I_N,E_Prox_Utility,E_S_S_N_Address,E_S_S_N_Inquiry,E_Second_Degree_Associations,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_Email,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_Property,E_Sele_Property_Event,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Utility,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_T_I_N,E_T_I_N_Address,E_T_I_N_Phone_Number,E_Tradeline,E_U_C_C,E_Utility,E_Utility_Address,E_Utility_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Index_Build_Association(KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Address_Filtered_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Business_Prox_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Business_Sele_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Phone_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Address_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Social_Security_Number_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Zip_Code_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Criminal_Offender_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Household_Member_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household_Member(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Phone_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SimpleFilter(DATASET(InLayout) __ds) := __ds(__T(__OP2(__ds.UID,=,__CN(1))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __SimpleFilter(__UsingFitler(__AsofFitler(__ds)));
  END;
  SHARED E_Zip_Code_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Zip_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Property_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Property_Event_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Aircraft_Owner_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Details_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Details(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Offender_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Offender_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Employment_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := JOIN(__UsingFitler(__AsofFitler(__ds)),E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,KEEP(1));
  END;
  SHARED E_House_Hold_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_House_Hold_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Household_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Household_Member_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household_Member(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Household_,RIGHT.Household_) AND __EEQP(LEFT.Version_,RIGHT.Version_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Accident_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Accident(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Drivers_License_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Education_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Email_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Lien_Judgment_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offender_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Property_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Property_Event_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Social_,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_U_C_C_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Phone_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Email_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Contact_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Contact_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Utility_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_S_S_N_Inquiry_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.S_S_N_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Aircraft_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Email_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
      KEL.typ.bool __Link8 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__NNEQ(LEFT.Sele_,RIGHT.Legal_) AND __T(__OP2(LEFT.Sele_,=,RIGHT.Legal_)),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__NNEQ(LEFT.T_M_S_I_D_,RIGHT.Legal_) AND __T(__OP2(LEFT.T_M_S_I_D_,=,__CAST(KEL.typ.str,RIGHT.Legal_))),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Lien_Judgment_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Sele_) AND __EEQP(LEFT.T_M_S_I_D_,RIGHT.T_M_S_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__NNEQ(LEFT.T_M_S_I_D_,RIGHT.UID) AND __T(__OP2(LEFT.T_M_S_I_D_,=,__CAST(KEL.typ.str,RIGHT.UID))),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__NNEQ(LEFT.Sele_,RIGHT.UID) AND __T(__OP2(LEFT.Sele_,=,RIGHT.UID)),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__NNEQ(LEFT.Sele_,RIGHT.Legal_) AND __T(__OP2(LEFT.Sele_,=,RIGHT.Legal_)),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__NNEQ(LEFT.T_M_S_I_D_,RIGHT.Legal_) AND __T(__OP2(LEFT.T_M_S_I_D_,=,__CAST(KEL.typ.str,RIGHT.Legal_))),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart8(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Lien_Judgment_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.Sele_) AND __EEQP(LEFT.Lien_,RIGHT.Lien_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.T_M_S_I_D_,RIGHT.T_M_S_I_D_) AND __EEQP(LEFT.R_M_S_I_D_,RIGHT.R_M_S_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link8:=__NN(RIGHT.Sele_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7)) OR EXISTS(__g(__g.__Link8));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart8(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Property_Event_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Tradeline_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_U_C_C_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Utility_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Vehicle_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_2(__in,__cfg).InData,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_T_I_N_Phone_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_T_I_N_Filtered_2(__in,__cfg).InData,__EEQP(LEFT.Tax_I_D_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Utility_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Zip_Code_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Zip_,RIGHT.Zip_) AND __EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Accident_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Accident(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Accident_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Acc_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Address_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Plane_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Aircraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Aircraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Owner_,RIGHT.Owner_) AND __EEQP(LEFT.Registrant_Type_,RIGHT.Registrant_Type_) AND __EEQP(LEFT.Certificate_Issue_Date_,RIGHT.Certificate_Issue_Date_) AND __EEQP(LEFT.Certification_,RIGHT.Certification_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Plane_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Prox_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Business_Sele_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offender_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Offense_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Offense_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Punishment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Punishment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Criminal_Details_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Punishment_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Drivers_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Drivers_License_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.License_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Education_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Edu_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Email_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT._r_Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT._r_Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Email_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT._r_Email_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT._r_Email_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Employment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Employment_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Emp_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_First_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(DATASET(InLayout) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1(__in,__cfg).InData,__EEQP(LEFT.Subject_,RIGHT.First_Degree_Association_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.First_Degree_Association_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_First_Degree_Associations_Filtered_1(__in,__cfg).InData,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.First_Degree_Association_,RIGHT.First_Degree_Association_) AND __EEQP(LEFT.Title_,RIGHT.Title_) AND __EEQP(LEFT.Relationship_Type_,RIGHT.Relationship_Type_) AND __EEQP(LEFT.Relationship_Confidence_,RIGHT.Relationship_Confidence_) AND __EEQP(LEFT.Relationship_Score_,RIGHT.Relationship_Score_) AND __EEQP(LEFT.Generation_,RIGHT.Generation_) AND __EEQP(LEFT.Relationship_Date_First_Seen_,RIGHT.Relationship_Date_First_Seen_) AND __EEQP(LEFT.Relationship_Date_Last_Seen_,RIGHT.Relationship_Date_Last_Seen_) AND __EEQP(LEFT.Source_,RIGHT.Source_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,KEEP(1),LEFT OUTER);
    SHARED __SimpleFilter(DATASET(__InLayoutExtended) __ds) := __ds(__ds.__Link0 OR __ds.__Link1);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := PROJECT(__SimpleFilter(__FilterPart1(__FilterPart0(__UsingFitler(__AsofFitler(__ds))))),InLayout);
  END;
  SHARED E_Household_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Household_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Household_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Phone_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_S_S_N_Inquiry_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Inquiry_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Inquiry_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Lien_Judgment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Lien_Judgment_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Lien_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Lien_Judgment_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Lien_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Bankrupt_,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Bankrupt_,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Person_Email_Phone_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email_Phone_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Automobile_,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_House_Hold_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Professional_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Professional_License_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Property_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prop_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Prop_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Property_Event_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Property_Event_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Event_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Event_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Prox_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Prox_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Prox_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.Business_Location_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Business_Location_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Aircraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Plane_,RIGHT.Plane_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.N_Number_,RIGHT.N_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Bankrupt_,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Bankrupt_,RIGHT.Bankrupt_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Sele_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.Legal_) AND __EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Ult_I_D_,RIGHT.Ult_I_D_) AND __EEQP(LEFT.Org_I_D_,RIGHT.Org_I_D_) AND __EEQP(LEFT.Sele_I_D_,RIGHT.Sele_I_D_) AND __EEQP(LEFT.Watercraft_Key_,RIGHT.Watercraft_Key_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Legal_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart2(__FilterPart1(__FilterPart0(__ds))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Social_Security_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Social_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Social_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Address_Filtered_4(__in,__cfg).__PostFilter,__EEQP(LEFT.Location_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_) AND __EEQP(LEFT.Location_,RIGHT.Location_) AND __EEQP(LEFT.Primary_Range_,RIGHT.Primary_Range_) AND __EEQP(LEFT.Predirectional_,RIGHT.Predirectional_) AND __EEQP(LEFT.Primary_Name_,RIGHT.Primary_Name_) AND __EEQP(LEFT.Suffix_,RIGHT.Suffix_) AND __EEQP(LEFT.Postdirectional_,RIGHT.Postdirectional_) AND __EEQP(LEFT.Z_I_P5_,RIGHT.Z_I_P5_) AND __EEQP(LEFT.Secondary_Range_,RIGHT.Secondary_Range_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Tax_I_D_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_T_I_N_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Phone_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.UID),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.UID),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_T_I_N_Phone_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Phone_Number_,RIGHT.Phone_Number_) AND __EEQP(LEFT.Tax_I_D_,RIGHT.Tax_I_D_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Phone_Number_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Tradeline_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_U_C_C_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_U_C_C_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Filing_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_U_C_C_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Filing_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Utility_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Utility_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Utility_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Utility_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Utility_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Util_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Util_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Automobile_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Automobile_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Watercraft_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.W_Craft_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Watercraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.W_Craft_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
      KEL.typ.bool __Link2 := FALSE;
      KEL.typ.bool __Link3 := FALSE;
      KEL.typ.bool __Link4 := FALSE;
      KEL.typ.bool __Link5 := FALSE;
      KEL.typ.bool __Link6 := FALSE;
      KEL.typ.bool __Link7 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Prox_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart2(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(__InLayoutExtended,SELF.__Link2:=__NN(RIGHT.Contact_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart3(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Household_Member_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link3:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart4(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link4:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart5(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link5:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart6(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Subject_),TRANSFORM(__InLayoutExtended,SELF.__Link6:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart7(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Watercraft_Owner_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.W_Craft_,RIGHT.W_Craft_) AND __EEQP(LEFT.Owner_,RIGHT.Owner_),TRANSFORM(__InLayoutExtended,SELF.__Link7:=__NN(RIGHT.W_Craft_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1)) OR EXISTS(__g(__g.__Link2)) OR EXISTS(__g(__g.__Link3)) OR EXISTS(__g(__g.__Link4)) OR EXISTS(__g(__g.__Link5)) OR EXISTS(__g(__g.__Link6)) OR EXISTS(__g(__g.__Link7));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart7(__FilterPart6(__FilterPart5(__FilterPart4(__FilterPart3(__FilterPart2(__FilterPart1(__FilterPart0(__ds)))))))),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Zip_Code_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Zip_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Zip_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__T(__OP2(__g.UID,=,__CN(1)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart0(__ds),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Address_Inquiry_Filtered := E_Address_Inquiry_Filtered_1;
  SHARED E_Address_Phone_Filtered := E_Address_Phone_Filtered_1;
  SHARED E_Address_Property_Filtered := E_Address_Property_Filtered_1;
  SHARED E_Address_Property_Event_Filtered := E_Address_Property_Event_Filtered_1;
  SHARED E_Criminal_Details_Filtered := E_Criminal_Details_Filtered_1;
  SHARED E_Employment_Person_Filtered := E_Employment_Person_Filtered_1;
  SHARED E_First_Degree_Relative_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Relative(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_House_Hold_Phone_Filtered := E_House_Hold_Phone_Filtered_1;
  SHARED E_Household_Member_Filtered := E_Household_Member_Filtered_1;
  SHARED E_Person_Accident_Filtered := E_Person_Accident_Filtered_1;
  SHARED E_Person_Address_Filtered := E_Person_Address_Filtered_1;
  SHARED E_Person_Drivers_License_Filtered := E_Person_Drivers_License_Filtered_1;
  SHARED E_Person_Education_Filtered := E_Person_Education_Filtered_1;
  SHARED E_Person_Email_Filtered := E_Person_Email_Filtered_1;
  SHARED E_Person_Inquiry_Filtered := E_Person_Inquiry_Filtered_1;
  SHARED E_Person_Lien_Judgment_Filtered := E_Person_Lien_Judgment_Filtered_1;
  SHARED E_Person_Offender_Filtered := E_Person_Offender_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Person_Phone_Filtered := E_Person_Phone_Filtered_1;
  SHARED E_Person_Property_Filtered := E_Person_Property_Filtered_1;
  SHARED E_Person_Property_Event_Filtered := E_Person_Property_Event_Filtered_1;
  SHARED E_Person_S_S_N_Filtered := E_Person_S_S_N_Filtered_1;
  SHARED E_Person_U_C_C_Filtered := E_Person_U_C_C_Filtered_1;
  SHARED E_Phone_Inquiry_Filtered := E_Phone_Inquiry_Filtered_1;
  SHARED E_Professional_License_Person_Filtered := E_Professional_License_Person_Filtered_1;
  SHARED E_Prox_Email_Filtered := E_Prox_Email_Filtered_1;
  SHARED E_Prox_Person_Filtered := E_Prox_Person_Filtered_1;
  SHARED E_Prox_Utility_Filtered := E_Prox_Utility_Filtered_1;
  SHARED E_S_S_N_Address_Filtered := E_S_S_N_Address_Filtered_1;
  SHARED E_S_S_N_Inquiry_Filtered := E_S_S_N_Inquiry_Filtered_1;
  SHARED E_Second_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Second_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Email_Filtered := E_Sele_Email_Filtered_1;
  SHARED E_Sele_Lien_Judgment_Filtered := E_Sele_Lien_Judgment_Filtered_1;
  SHARED E_Sele_Person_Filtered := E_Sele_Person_Filtered_2;
  SHARED E_Sele_Property_Filtered := E_Sele_Property_Filtered_1;
  SHARED E_Sele_Property_Event_Filtered := E_Sele_Property_Event_Filtered_1;
  SHARED E_Sele_Tradeline_Filtered := E_Sele_Tradeline_Filtered_1;
  SHARED E_Sele_U_C_C_Filtered := E_Sele_U_C_C_Filtered_1;
  SHARED E_Sele_Utility_Filtered := E_Sele_Utility_Filtered_1;
  SHARED E_Sele_Vehicle_Filtered := E_Sele_Vehicle_Filtered_1;
  SHARED E_T_I_N_Filtered := E_T_I_N_Filtered_2;
  SHARED E_Utility_Address_Filtered := E_Utility_Address_Filtered_1;
  SHARED E_Utility_Person_Filtered := E_Utility_Person_Filtered_1;
  SHARED E_Zip_Code_Person_Filtered := E_Zip_Code_Person_Filtered_1;
  SHARED B_Tradeline_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_11(__in,__cfg))
    SHARED TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_10(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_11(__in,__cfg).__ENH_Tradeline_11) __ENH_Tradeline_11 := B_Tradeline_11_Local(__in,__cfg).__ENH_Tradeline_11;
  END;
  SHARED B_Tradeline_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_9(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local(__in,__cfg).__ENH_Tradeline_10;
  END;
  SHARED B_Tradeline_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_8(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local(__in,__cfg).__ENH_Tradeline_9;
  END;
  SHARED B_Bankruptcy_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_7(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_7(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local(__in,__cfg).__ENH_Tradeline_8;
  END;
  SHARED B_Bankruptcy_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_6(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local(__in,__cfg).__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_6(__in,__cfg))
    SHARED TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Lien_Judgment_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_6(__in,__cfg))
    SHARED TYPEOF(E_Lien_Judgment(__in,__cfg).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Lien_Judgment_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Lien_Judgment_6(__in,__cfg))
    SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_5(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local(__in,__cfg).__ENH_Business_Sele_6;
    SHARED TYPEOF(B_Lien_Judgment_6(__in,__cfg).__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6_Local(__in,__cfg).__ENH_Lien_Judgment_6;
    SHARED TYPEOF(B_Sele_Lien_Judgment_6(__in,__cfg).__ENH_Sele_Lien_Judgment_6) __ENH_Sele_Lien_Judgment_6 := B_Sele_Lien_Judgment_6_Local(__in,__cfg).__ENH_Sele_Lien_Judgment_6;
  END;
  SHARED B_Lien_Judgment_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_5(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_6(__in,__cfg).__ENH_Lien_Judgment_6) __ENH_Lien_Judgment_6 := B_Lien_Judgment_6_Local(__in,__cfg).__ENH_Lien_Judgment_6;
  END;
  SHARED B_Professional_License_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_5(__in,__cfg))
    SHARED TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_Aircraft_Owner_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_4(__in,__cfg))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Prox_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_4(__in,__cfg))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_4(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local(__in,__cfg).__ENH_Business_Sele_5;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Lien_Judgment_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_4(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_5(__in,__cfg).__ENH_Lien_Judgment_5) __ENH_Lien_Judgment_5 := B_Lien_Judgment_5_Local(__in,__cfg).__ENH_Lien_Judgment_5;
  END;
  SHARED B_Person_Vehicle_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_4(__in,__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Professional_License_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_4(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local(__in,__cfg).__ENH_Professional_License_5;
  END;
  SHARED B_Sele_Vehicle_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_4(__in,__cfg))
    SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Watercraft_Owner_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_4(__in,__cfg))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Aircraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_4(__in,__cfg).__ENH_Aircraft_Owner_4) __ENH_Aircraft_Owner_4 := B_Aircraft_Owner_4_Local(__in,__cfg).__ENH_Aircraft_Owner_4;
  END;
  SHARED B_Bankruptcy_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_4(__in,__cfg).__ENH_Business_Prox_4) __ENH_Business_Prox_4 := B_Business_Prox_4_Local(__in,__cfg).__ENH_Business_Prox_4;
  END;
  SHARED B_Business_Sele_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local(__in,__cfg).__ENH_Business_Sele_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
  END;
  SHARED B_Lien_Judgment_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_3(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_4(__in,__cfg).__ENH_Lien_Judgment_4) __ENH_Lien_Judgment_4 := B_Lien_Judgment_4_Local(__in,__cfg).__ENH_Lien_Judgment_4;
  END;
  SHARED B_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_4(__in,__cfg).__ENH_Person_Vehicle_4) __ENH_Person_Vehicle_4 := B_Person_Vehicle_4_Local(__in,__cfg).__ENH_Person_Vehicle_4;
  END;
  SHARED B_Professional_License_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_3(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
  END;
  SHARED B_Sele_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Sele_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_4(__in,__cfg).__ENH_Sele_Vehicle_4) __ENH_Sele_Vehicle_4 := B_Sele_Vehicle_4_Local(__in,__cfg).__ENH_Sele_Vehicle_4;
  END;
  SHARED B_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Watercraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_4(__in,__cfg).__ENH_Watercraft_Owner_4) __ENH_Watercraft_Owner_4 := B_Watercraft_Owner_4_Local(__in,__cfg).__ENH_Watercraft_Owner_4;
  END;
  SHARED B_Aircraft_Owner_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
  END;
  SHARED B_Business_Prox_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_2(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local(__in,__cfg).__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local(__in,__cfg).__ENH_Business_Sele_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
  END;
  SHARED B_Lien_Judgment_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_2(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_3(__in,__cfg).__ENH_Lien_Judgment_3) __ENH_Lien_Judgment_3 := B_Lien_Judgment_3_Local(__in,__cfg).__ENH_Lien_Judgment_3;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local(__in,__cfg).__ENH_Person_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Vehicle_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_2(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_2(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
  END;
  SHARED B_Sele_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_Vehicle_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Watercraft_Owner_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_2(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Aircraft_Owner_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_1(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local(__in,__cfg).__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Prox_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_1(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local(__in,__cfg).__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Sele_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local(__in,__cfg).__ENH_Business_Sele_2;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local(__in,__cfg).__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Criminal_Offense_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
  END;
  SHARED B_Lien_Judgment_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_1(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_2(__in,__cfg).__ENH_Lien_Judgment_2) __ENH_Lien_Judgment_2 := B_Lien_Judgment_2_Local(__in,__cfg).__ENH_Lien_Judgment_2;
  END;
  SHARED B_Person_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local(__in,__cfg).__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__in,__cfg).__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local(__in,__cfg).__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local(__in,__cfg).__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_1(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__in,__cfg).__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_1(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local(__in,__cfg).__ENH_Professional_License_2;
  END;
  SHARED B_Sele_Aircraft_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Aircraft_1(__in,__cfg))
    SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local(__in,__cfg).__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Sele_Watercraft_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Watercraft_1(__in,__cfg))
    SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Watercraft_Owner_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_1(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local(__in,__cfg).__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Aircraft_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft(__in,__cfg))
    SHARED TYPEOF(E_Aircraft(__in,__cfg).__Result) __E_Aircraft := E_Aircraft_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
  END;
  SHARED B_Business_Prox_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_1(__in,__cfg).__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local(__in,__cfg).__ENH_Business_Prox_1;
  END;
  SHARED B_Business_Sele_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1(__in,__cfg).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local(__in,__cfg).__ENH_Business_Sele_1;
    SHARED TYPEOF(B_Sele_Aircraft_1(__in,__cfg).__ENH_Sele_Aircraft_1) __ENH_Sele_Aircraft_1 := B_Sele_Aircraft_1_Local(__in,__cfg).__ENH_Sele_Aircraft_1;
    SHARED TYPEOF(B_Sele_Bankruptcy_1(__in,__cfg).__ENH_Sele_Bankruptcy_1) __ENH_Sele_Bankruptcy_1 := B_Sele_Bankruptcy_1_Local(__in,__cfg).__ENH_Sele_Bankruptcy_1;
    SHARED TYPEOF(B_Sele_Tradeline_1(__in,__cfg).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local(__in,__cfg).__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1(__in,__cfg).__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local(__in,__cfg).__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(B_Sele_Watercraft_1(__in,__cfg).__ENH_Sele_Watercraft_1) __ENH_Sele_Watercraft_1 := B_Sele_Watercraft_1_Local(__in,__cfg).__ENH_Sele_Watercraft_1;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle(__in,__cfg).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Criminal_Offender_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offender(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offender(__in,__cfg).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Criminal_Offense_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
  END;
  SHARED B_Criminal_Punishment_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Punishment(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Punishment(__in,__cfg).__Result) __E_Criminal_Punishment := E_Criminal_Punishment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_First_Degree_Relative_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_First_Degree_Relative(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Inquiry_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Inquiry(__in,__cfg))
    SHARED TYPEOF(E_Inquiry(__in,__cfg).__Result) __E_Inquiry := E_Inquiry_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Lien_Judgment_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment(__in,__cfg))
    SHARED TYPEOF(B_Lien_Judgment_1(__in,__cfg).__ENH_Lien_Judgment_1) __ENH_Lien_Judgment_1 := B_Lien_Judgment_1_Local(__in,__cfg).__ENH_Lien_Judgment_1;
  END;
  SHARED B_Person_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_1(__in,__cfg).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local(__in,__cfg).__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__in,__cfg).__ENH_Person_1;
    SHARED TYPEOF(B_Person_Bankruptcy_1(__in,__cfg).__ENH_Person_Bankruptcy_1) __ENH_Person_Bankruptcy_1 := B_Person_Bankruptcy_1_Local(__in,__cfg).__ENH_Person_Bankruptcy_1;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local(__in,__cfg).__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local(__in,__cfg).__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local(__in,__cfg).__ENH_Watercraft_Owner_1;
  END;
  SHARED B_Phone_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Phone(__in,__cfg))
    SHARED TYPEOF(E_Phone(__in,__cfg).__Result) __E_Phone := E_Phone_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Professional_License_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local(__in,__cfg).__ENH_Professional_License_1;
  END;
  SHARED B_Property_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Property(__in,__cfg))
    SHARED TYPEOF(E_Property(__in,__cfg).__Result) __E_Property := E_Property_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Second_Degree_Associations_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Second_Degree_Associations(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
  END;
  SHARED B_U_C_C_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C(__in,__cfg))
    SHARED TYPEOF(E_U_C_C(__in,__cfg).__Result) __E_U_C_C := E_U_C_C_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Vehicle_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle(__in,__cfg))
    SHARED TYPEOF(E_Vehicle(__in,__cfg).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Watercraft_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft(__in,__cfg))
    SHARED TYPEOF(E_Watercraft(__in,__cfg).__Result) __E_Watercraft := E_Watercraft_Filtered(__in,__cfg).__Result;
  END;
  SHARED TYPEOF(E_Accident(__in,__cfg_Local).__Result) __E_Accident := E_Accident_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Phone(__in,__cfg_Local).__Result) __E_Address_Phone := E_Address_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Property_Event(__in,__cfg_Local).__Result) __E_Address_Property_Event := E_Address_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Aircraft(__in,__cfg_Local).__ENH_Aircraft) __ENH_Aircraft := B_Aircraft_Local(__in,__cfg_Local).__ENH_Aircraft;
  SHARED TYPEOF(E_Aircraft(__in,__cfg_Local).__Result) __E_Aircraft := E_Aircraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Bankruptcy(__in,__cfg_Local).__ENH_Bankruptcy) __ENH_Bankruptcy := B_Bankruptcy_Local(__in,__cfg_Local).__ENH_Bankruptcy;
  SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Business_Prox(__in,__cfg_Local).__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local(__in,__cfg_Local).__ENH_Business_Prox;
  SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local(__in,__cfg_Local).__ENH_Business_Sele;
  SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Details(__in,__cfg_Local).__Result) __E_Criminal_Details := E_Criminal_Details_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Criminal_Offender(__in,__cfg_Local).__ENH_Criminal_Offender) __ENH_Criminal_Offender := B_Criminal_Offender_Local(__in,__cfg_Local).__ENH_Criminal_Offender;
  SHARED TYPEOF(E_Criminal_Offender(__in,__cfg_Local).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Criminal_Offense(__in,__cfg_Local).__ENH_Criminal_Offense) __ENH_Criminal_Offense := B_Criminal_Offense_Local(__in,__cfg_Local).__ENH_Criminal_Offense;
  SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Criminal_Punishment(__in,__cfg_Local).__ENH_Criminal_Punishment) __ENH_Criminal_Punishment := B_Criminal_Punishment_Local(__in,__cfg_Local).__ENH_Criminal_Punishment;
  SHARED TYPEOF(E_Criminal_Punishment(__in,__cfg_Local).__Result) __E_Criminal_Punishment := E_Criminal_Punishment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Drivers_License(__in,__cfg_Local).__Result) __E_Drivers_License := E_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Email(__in,__cfg_Local).__Result) __E_Email := E_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment(__in,__cfg_Local).__Result) __E_Employment := E_Employment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment_Person(__in,__cfg_Local).__Result) __E_Employment_Person := E_Employment_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_First_Degree_Relative(__in,__cfg_Local).__ENH_First_Degree_Relative) __ENH_First_Degree_Relative := B_First_Degree_Relative_Local(__in,__cfg_Local).__ENH_First_Degree_Relative;
  SHARED TYPEOF(E_First_Degree_Relative(__in,__cfg_Local).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_House_Hold_Phone(__in,__cfg_Local).__Result) __E_House_Hold_Phone := E_House_Hold_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Household(__in,__cfg_Local).__Result) __E_Household := E_Household_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Household_Member(__in,__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Inquiry(__in,__cfg_Local).__ENH_Inquiry) __ENH_Inquiry := B_Inquiry_Local(__in,__cfg_Local).__ENH_Inquiry;
  SHARED TYPEOF(B_Lien_Judgment(__in,__cfg_Local).__ENH_Lien_Judgment) __ENH_Lien_Judgment := B_Lien_Judgment_Local(__in,__cfg_Local).__ENH_Lien_Judgment;
  SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Accident(__in,__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Drivers_License(__in,__cfg_Local).__Result) __E_Person_Drivers_License := E_Person_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Email_Phone_Address(__in,__cfg_Local).__Result) __E_Person_Email_Phone_Address := E_Person_Email_Phone_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Inquiry(__in,__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offender(__in,__cfg_Local).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Phone(__in,__cfg_Local).__Result) __E_Person_Phone := E_Person_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Property(__in,__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Property_Event(__in,__cfg_Local).__Result) __E_Person_Property_Event := E_Person_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_U_C_C(__in,__cfg_Local).__Result) __E_Person_U_C_C := E_Person_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Phone(__in,__cfg_Local).__ENH_Phone) __ENH_Phone := B_Phone_Local(__in,__cfg_Local).__ENH_Phone;
  SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Phone_Inquiry(__in,__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Professional_License(__in,__cfg_Local).__ENH_Professional_License) __ENH_Professional_License := B_Professional_License_Local(__in,__cfg_Local).__ENH_Professional_License;
  SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Property(__in,__cfg_Local).__ENH_Property) __ENH_Property := B_Property_Local(__in,__cfg_Local).__ENH_Property;
  SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Email(__in,__cfg_Local).__Result) __E_Prox_Email := E_Prox_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Person(__in,__cfg_Local).__Result) __E_Prox_Person := E_Prox_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Utility(__in,__cfg_Local).__Result) __E_Prox_Utility := E_Prox_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Address(__in,__cfg_Local).__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Second_Degree_Associations(__in,__cfg_Local).__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local(__in,__cfg_Local).__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations(__in,__cfg_Local).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Address(__in,__cfg_Local).__Result) __E_Sele_Address := E_Sele_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg_Local).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg_Local).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Email(__in,__cfg_Local).__Result) __E_Sele_Email := E_Sele_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg_Local).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg_Local).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Property(__in,__cfg_Local).__Result) __E_Sele_Property := E_Sele_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Property_Event(__in,__cfg_Local).__Result) __E_Sele_Property_Event := E_Sele_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg_Local).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg_Local).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg_Local).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Utility(__in,__cfg_Local).__Result) __E_Sele_Utility := E_Sele_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg_Local).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N(__in,__cfg_Local).__Result) __E_T_I_N := E_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N_Address(__in,__cfg_Local).__Result) __E_T_I_N_Address := E_T_I_N_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N_Phone_Number(__in,__cfg_Local).__Result) __E_T_I_N_Phone_Number := E_T_I_N_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Tradeline(__in,__cfg_Local).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline_Local(__in,__cfg_Local).__ENH_Tradeline;
  SHARED TYPEOF(E_Tradeline(__in,__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_U_C_C(__in,__cfg_Local).__ENH_U_C_C) __ENH_U_C_C := B_U_C_C_Local(__in,__cfg_Local).__ENH_U_C_C;
  SHARED TYPEOF(E_U_C_C(__in,__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility(__in,__cfg_Local).__Result) __E_Utility := E_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Address(__in,__cfg_Local).__Result) __E_Utility_Address := E_Utility_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Vehicle(__in,__cfg_Local).__ENH_Vehicle) __ENH_Vehicle := B_Vehicle_Local(__in,__cfg_Local).__ENH_Vehicle;
  SHARED TYPEOF(E_Vehicle(__in,__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Watercraft(__in,__cfg_Local).__ENH_Watercraft) __ENH_Watercraft := B_Watercraft_Local(__in,__cfg_Local).__ENH_Watercraft;
  SHARED TYPEOF(E_Watercraft(__in,__cfg_Local).__Result) __E_Watercraft := E_Watercraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__in,__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE1970593 := __ENH_Inquiry;
  SHARED __EE1970582 := __E_Address_Inquiry;
  SHARED __EE1970770 := __EE1970582(__NN(__EE1970582.Location_) AND __NN(__EE1970582.Inquiry_));
  SHARED __EE1970576 := __E_Address;
  SHARED __EE1970836 := __EE1970576(__T(__OP2(__EE1970576.UID,=,__CN(1))));
  __JC1970842(E_Address_Inquiry(__in,__cfg_Local).Layout __EE1970770, E_Address(__in,__cfg_Local).Layout __EE1970836) := __EEQP(__EE1970836.UID,__EE1970770.Location_);
  SHARED __EE1970856 := JOIN(__EE1970770,__EE1970836,__JC1970842(LEFT,RIGHT),TRANSFORM(E_Address_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1970862(B_Inquiry(__in,__cfg_Local).__ST71132_Layout __EE1970593, E_Address_Inquiry(__in,__cfg_Local).Layout __EE1970856) := __EEQP(__EE1970856.Inquiry_,__EE1970593.UID);
  SHARED __EE1970884 := JOIN(__EE1970593,__EE1970856,__JC1970862(LEFT,RIGHT),TRANSFORM(B_Inquiry(__in,__cfg_Local).__ST71132_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1970886 := __EE1970884;
  EXPORT Res0 := __UNWRAP(__EE1970886);
  SHARED __EE1971033 := __ENH_Phone;
  SHARED __EE1971022 := __E_Address_Phone;
  SHARED __EE1971311 := __EE1971022(__NN(__EE1971022.Location_) AND __NN(__EE1971022.Phone_Number_));
  SHARED __EE1971016 := __E_Address;
  SHARED __EE1971423 := __EE1971016(__T(__OP2(__EE1971016.UID,=,__CN(1))));
  __JC1971429(E_Address_Phone(__in,__cfg_Local).Layout __EE1971311, E_Address(__in,__cfg_Local).Layout __EE1971423) := __EEQP(__EE1971423.UID,__EE1971311.Location_);
  SHARED __EE1971457 := JOIN(__EE1971311,__EE1971423,__JC1971429(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1971463(B_Phone(__in,__cfg_Local).__ST75420_Layout __EE1971033, E_Address_Phone(__in,__cfg_Local).Layout __EE1971457) := __EEQP(__EE1971457.Phone_Number_,__EE1971033.UID);
  SHARED __EE1971517 := JOIN(__EE1971033,__EE1971457,__JC1971463(LEFT,RIGHT),TRANSFORM(B_Phone(__in,__cfg_Local).__ST75420_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1971519 := __EE1971517;
  EXPORT Res1 := __UNWRAP(__EE1971519);
  SHARED __EE1971767 := __ENH_Property;
  SHARED __EE1971756 := __E_Address_Property;
  SHARED __EE1971978 := __EE1971756(__NN(__EE1971756.Location_) AND __NN(__EE1971756.Prop_));
  SHARED __EE1971750 := __E_Address;
  SHARED __EE1972060 := __EE1971750(__T(__OP2(__EE1971750.UID,=,__CN(1))));
  __JC1972066(E_Address_Property(__in,__cfg_Local).Layout __EE1971978, E_Address(__in,__cfg_Local).Layout __EE1972060) := __EEQP(__EE1972060.UID,__EE1971978.Location_);
  SHARED __EE1972084 := JOIN(__EE1971978,__EE1972060,__JC1972066(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1972090(B_Property(__in,__cfg_Local).__ST75600_Layout __EE1971767, E_Address_Property(__in,__cfg_Local).Layout __EE1972084) := __EEQP(__EE1972084.Prop_,__EE1971767.UID);
  SHARED __EE1972124 := JOIN(__EE1971767,__EE1972084,__JC1972090(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST75600_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1972126 := __EE1972124;
  EXPORT Res2 := __UNWRAP(__EE1972126);
  SHARED __EE1972306 := __E_Property_Event;
  SHARED __EE1972296 := __E_Address_Property_Event;
  SHARED __EE1973119 := __EE1972296(__NN(__EE1972296.Location_) AND __NN(__EE1972296.Event_));
  SHARED __EE1972290 := __E_Address;
  SHARED __EE1973502 := __EE1972290(__T(__OP2(__EE1972290.UID,=,__CN(1))));
  __JC1973508(E_Address_Property_Event(__in,__cfg_Local).Layout __EE1973119, E_Address(__in,__cfg_Local).Layout __EE1973502) := __EEQP(__EE1973502.UID,__EE1973119.Location_);
  SHARED __EE1973533 := JOIN(__EE1973119,__EE1973502,__JC1973508(LEFT,RIGHT),TRANSFORM(E_Address_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1973539(E_Property_Event(__in,__cfg_Local).Layout __EE1972306, E_Address_Property_Event(__in,__cfg_Local).Layout __EE1973533) := __EEQP(__EE1973533.Event_,__EE1972306.UID);
  SHARED __EE1973867 := JOIN(__EE1972306,__EE1973533,__JC1973539(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1973869 := __EE1973867;
  EXPORT Res3 := __UNWRAP(__EE1973869);
  SHARED __EE1974657 := __ENH_Person;
  SHARED __EE1974646 := __E_Person_Address;
  SHARED __EE1975807 := __EE1974646(__NN(__EE1974646.Location_) AND __NN(__EE1974646.Subject_));
  SHARED __EE1974640 := __E_Address;
  SHARED __EE1976337 := __EE1974640(__T(__OP2(__EE1974640.UID,=,__CN(1))));
  __JC1976343(E_Person_Address(__in,__cfg_Local).Layout __EE1975807, E_Address(__in,__cfg_Local).Layout __EE1976337) := __EEQP(__EE1976337.UID,__EE1975807.Location_);
  SHARED __EE1976368 := JOIN(__EE1975807,__EE1976337,__JC1976343(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1976374(B_Person(__in,__cfg_Local).__ST75136_Layout __EE1974657, E_Person_Address(__in,__cfg_Local).Layout __EE1976368) := __EEQP(__EE1976368.Subject_,__EE1974657.UID);
  SHARED __EE1976849 := JOIN(__EE1974657,__EE1976368,__JC1976374(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1976851 := __EE1976849;
  EXPORT Res4 := __UNWRAP(__EE1976851);
  SHARED __EE1978167 := __ENH_Business_Prox;
  SHARED __EE1978156 := __E_Prox_Address;
  SHARED __EE1978929 := __EE1978156(__NN(__EE1978156.Location_) AND __NN(__EE1978156.Business_Location_));
  SHARED __EE1978150 := __E_Address;
  SHARED __EE1979272 := __EE1978150(__T(__OP2(__EE1978150.UID,=,__CN(1))));
  __JC1979278(E_Prox_Address(__in,__cfg_Local).Layout __EE1978929, E_Address(__in,__cfg_Local).Layout __EE1979272) := __EEQP(__EE1979272.UID,__EE1978929.Location_);
  SHARED __EE1979333 := JOIN(__EE1978929,__EE1979272,__JC1979278(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1979339(B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1978167, E_Prox_Address(__in,__cfg_Local).Layout __EE1979333) := __EEQP(__EE1979333.Business_Location_,__EE1978167.UID);
  SHARED __EE1979597 := JOIN(__EE1978167,__EE1979333,__JC1979339(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST57542_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1979599 := __EE1979597;
  EXPORT Res5 := __UNWRAP(__EE1979599);
  SHARED __EE1980295 := __ENH_Business_Sele;
  SHARED __EE1980284 := __E_Sele_Address;
  SHARED __EE1982060 := __EE1980284(__NN(__EE1980284.Location_) AND __NN(__EE1980284.Legal_));
  SHARED __EE1980278 := __E_Address;
  SHARED __EE1982885 := __EE1980278(__T(__OP2(__EE1980278.UID,=,__CN(1))));
  __JC1982891(E_Sele_Address(__in,__cfg_Local).Layout __EE1982060, E_Address(__in,__cfg_Local).Layout __EE1982885) := __EEQP(__EE1982885.UID,__EE1982060.Location_);
  SHARED __EE1982946 := JOIN(__EE1982060,__EE1982885,__JC1982891(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1982952(B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE1980295, E_Sele_Address(__in,__cfg_Local).Layout __EE1982946) := __EEQP(__EE1982946.Legal_,__EE1980295.UID);
  SHARED __EE1983692 := JOIN(__EE1980295,__EE1982946,__JC1982952(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST65544_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1983694 := __EE1983692;
  EXPORT Res6 := __UNWRAP(__EE1983694);
  SHARED __EE1987658 := __E_T_I_N_Address;
  SHARED __EE1987819 := __EE1987658(__NN(__EE1987658.Tax_I_D_) AND __NN(__EE1987658.Location_));
  SHARED __EE1987652 := __E_Address;
  SHARED __EE1987865 := __EE1987652(__T(__OP2(__EE1987652.UID,=,__CN(1))));
  __JC1987871(E_T_I_N_Address(__in,__cfg_Local).Layout __EE1987819, E_Address(__in,__cfg_Local).Layout __EE1987865) := __EEQP(__EE1987865.UID,__EE1987819.Location_);
  SHARED __EE1987885 := JOIN(__EE1987819,__EE1987865,__JC1987871(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1987895 := PROJECT(TABLE(PROJECT(__EE1987885,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res7 := __UNWRAP(__EE1987895);
  SHARED __EE1987979 := __E_Utility;
  SHARED __EE1987969 := __E_Utility_Address;
  SHARED __EE1988134 := __EE1987969(__NN(__EE1987969.Location_) AND __NN(__EE1987969.Util_));
  SHARED __EE1987963 := __E_Address;
  SHARED __EE1988189 := __EE1987963(__T(__OP2(__EE1987963.UID,=,__CN(1))));
  __JC1988195(E_Utility_Address(__in,__cfg_Local).Layout __EE1988134, E_Address(__in,__cfg_Local).Layout __EE1988189) := __EEQP(__EE1988189.UID,__EE1988134.Location_);
  SHARED __EE1988209 := JOIN(__EE1988134,__EE1988189,__JC1988195(LEFT,RIGHT),TRANSFORM(E_Utility_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1988215(E_Utility(__in,__cfg_Local).Layout __EE1987979, E_Utility_Address(__in,__cfg_Local).Layout __EE1988209) := __EEQP(__EE1988209.Util_,__EE1987979.UID);
  SHARED __EE1988226 := JOIN(__EE1987979,__EE1988209,__JC1988215(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1988228 := __EE1988226;
  EXPORT Res8 := __UNWRAP(__EE1988228);
  SHARED __EE1988353 := __E_Address;
  SHARED __EE1988343 := __E_Prox_Address;
  SHARED __EE1988832 := __EE1988343(__NN(__EE1988343.Business_Location_) AND __NN(__EE1988343.Location_));
  SHARED __EE1988337 := __ENH_Business_Prox;
  SHARED __EE1989035 := __EE1988337(__T(__OP2(__EE1988337.UID,=,__CN(1))));
  __JC1989041(E_Prox_Address(__in,__cfg_Local).Layout __EE1988832, B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1989035) := __EEQP(__EE1989035.UID,__EE1988832.Business_Location_);
  SHARED __EE1989096 := JOIN(__EE1988832,__EE1989035,__JC1989041(LEFT,RIGHT),TRANSFORM(E_Prox_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1989102(E_Address(__in,__cfg_Local).Layout __EE1988353, E_Prox_Address(__in,__cfg_Local).Layout __EE1989096) := __EEQP(__EE1989096.Location_,__EE1988353.UID);
  SHARED __EE1989220 := JOIN(__EE1988353,__EE1989096,__JC1989102(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1989222 := __EE1989220;
  EXPORT Res9 := __UNWRAP(__EE1989222);
  SHARED __EE1989675 := __ENH_Person;
  SHARED __EE1989664 := __E_Prox_Person;
  SHARED __EE1990829 := __EE1989664(__NN(__EE1989664.Business_Location_) AND __NN(__EE1989664.Contact_));
  SHARED __EE1989658 := __ENH_Business_Prox;
  SHARED __EE1991361 := __EE1989658(__T(__OP2(__EE1989658.UID,=,__CN(1))));
  __JC1991367(E_Prox_Person(__in,__cfg_Local).Layout __EE1990829, B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1991361) := __EEQP(__EE1991361.UID,__EE1990829.Business_Location_);
  SHARED __EE1991394 := JOIN(__EE1990829,__EE1991361,__JC1991367(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1991400(B_Person(__in,__cfg_Local).__ST75136_Layout __EE1989675, E_Prox_Person(__in,__cfg_Local).Layout __EE1991394) := __EEQP(__EE1991394.Contact_,__EE1989675.UID);
  SHARED __EE1991875 := JOIN(__EE1989675,__EE1991394,__JC1991400(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1991877 := __EE1991875;
  EXPORT Res10 := __UNWRAP(__EE1991877);
  SHARED __EE1993241 := __ENH_Phone;
  SHARED __EE1993230 := __E_Prox_Phone_Number;
  SHARED __EE1993538 := __EE1993230(__NN(__EE1993230.Business_Location_) AND __NN(__EE1993230.Phone_Number_));
  SHARED __EE1993224 := __ENH_Business_Prox;
  SHARED __EE1993658 := __EE1993224(__T(__OP2(__EE1993224.UID,=,__CN(1))));
  __JC1993664(E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE1993538, B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1993658) := __EEQP(__EE1993658.UID,__EE1993538.Business_Location_);
  SHARED __EE1993700 := JOIN(__EE1993538,__EE1993658,__JC1993664(LEFT,RIGHT),TRANSFORM(E_Prox_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1993706(B_Phone(__in,__cfg_Local).__ST75420_Layout __EE1993241, E_Prox_Phone_Number(__in,__cfg_Local).Layout __EE1993700) := __EEQP(__EE1993700.Phone_Number_,__EE1993241.UID);
  SHARED __EE1993760 := JOIN(__EE1993241,__EE1993700,__JC1993706(LEFT,RIGHT),TRANSFORM(B_Phone(__in,__cfg_Local).__ST75420_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1993762 := __EE1993760;
  EXPORT Res11 := __UNWRAP(__EE1993762);
  SHARED __EE1994038 := __E_Prox_T_I_N;
  SHARED __EE1994197 := __EE1994038(__NN(__EE1994038.Tax_I_D_) AND __NN(__EE1994038.Business_Location_));
  SHARED __EE1994032 := __ENH_Business_Prox;
  SHARED __EE1994242 := __EE1994032(__T(__OP2(__EE1994032.UID,=,__CN(1))));
  __JC1994248(E_Prox_T_I_N(__in,__cfg_Local).Layout __EE1994197, B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1994242) := __EEQP(__EE1994242.UID,__EE1994197.Business_Location_);
  SHARED __EE1994261 := JOIN(__EE1994197,__EE1994242,__JC1994248(LEFT,RIGHT),TRANSFORM(E_Prox_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1994271 := PROJECT(TABLE(PROJECT(__EE1994261,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res12 := __UNWRAP(__EE1994271);
  SHARED __EE1994366 := __E_Utility;
  SHARED __EE1994356 := __E_Prox_Utility;
  SHARED __EE1994516 := __EE1994356(__NN(__EE1994356.Business_Location_) AND __NN(__EE1994356.Util_));
  SHARED __EE1994350 := __ENH_Business_Prox;
  SHARED __EE1994568 := __EE1994350(__T(__OP2(__EE1994350.UID,=,__CN(1))));
  __JC1994574(E_Prox_Utility(__in,__cfg_Local).Layout __EE1994516, B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1994568) := __EEQP(__EE1994568.UID,__EE1994516.Business_Location_);
  SHARED __EE1994585 := JOIN(__EE1994516,__EE1994568,__JC1994574(LEFT,RIGHT),TRANSFORM(E_Prox_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1994591(E_Utility(__in,__cfg_Local).Layout __EE1994366, E_Prox_Utility(__in,__cfg_Local).Layout __EE1994585) := __EEQP(__EE1994585.Util_,__EE1994366.UID);
  SHARED __EE1994602 := JOIN(__EE1994366,__EE1994585,__JC1994591(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1994604 := __EE1994602;
  EXPORT Res13 := __UNWRAP(__EE1994604);
  SHARED __EE1994761 := __E_Email;
  SHARED __EE1994751 := __E_Prox_Email;
  SHARED __EE1994980 := __EE1994751(__NN(__EE1994751.Business_Location_) AND __NN(__EE1994751._r_Email_));
  SHARED __EE1994745 := __ENH_Business_Prox;
  SHARED __EE1995064 := __EE1994745(__T(__OP2(__EE1994745.UID,=,__CN(1))));
  __JC1995070(E_Prox_Email(__in,__cfg_Local).Layout __EE1994980, B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE1995064) := __EEQP(__EE1995064.UID,__EE1994980.Business_Location_);
  SHARED __EE1995089 := JOIN(__EE1994980,__EE1995064,__JC1995070(LEFT,RIGHT),TRANSFORM(E_Prox_Email(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1995095(E_Email(__in,__cfg_Local).Layout __EE1994761, E_Prox_Email(__in,__cfg_Local).Layout __EE1995089) := __EEQP(__EE1995089._r_Email_,__EE1994761.UID);
  SHARED __EE1995130 := JOIN(__EE1994761,__EE1995089,__JC1995095(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1995132 := __EE1995130;
  EXPORT Res14 := __UNWRAP(__EE1995132);
  SHARED __EE1995359 := __E_Email;
  SHARED __EE1995349 := __E_Sele_Email;
  SHARED __EE1995576 := __EE1995349(__NN(__EE1995349.Legal_) AND __NN(__EE1995349._r_Email_));
  SHARED __EE1995343 := __ENH_Business_Sele;
  SHARED __EE1995659 := __EE1995343(__T(__OP2(__EE1995343.UID,=,__CN(1))));
  __JC1995665(E_Sele_Email(__in,__cfg_Local).Layout __EE1995576, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE1995659) := __EEQP(__EE1995659.UID,__EE1995576.Legal_);
  SHARED __EE1995683 := JOIN(__EE1995576,__EE1995659,__JC1995665(LEFT,RIGHT),TRANSFORM(E_Sele_Email(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC1995689(E_Email(__in,__cfg_Local).Layout __EE1995359, E_Sele_Email(__in,__cfg_Local).Layout __EE1995683) := __EEQP(__EE1995683._r_Email_,__EE1995359.UID);
  SHARED __EE1995724 := JOIN(__EE1995359,__EE1995683,__JC1995689(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE1995726 := __EE1995724;
  EXPORT Res15 := __UNWRAP(__EE1995726);
  SHARED __EE2003795 := __E_Address;
  SHARED __EE2003785 := __E_Sele_Address;
  SHARED __EE2004274 := __EE2003785(__NN(__EE2003785.Legal_) AND __NN(__EE2003785.Location_));
  SHARED __EE2003779 := __ENH_Business_Sele;
  SHARED __EE2004477 := __EE2003779(__T(__OP2(__EE2003779.UID,=,__CN(1))));
  __JC2004483(E_Sele_Address(__in,__cfg_Local).Layout __EE2004274, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2004477) := __EEQP(__EE2004477.UID,__EE2004274.Legal_);
  SHARED __EE2004538 := JOIN(__EE2004274,__EE2004477,__JC2004483(LEFT,RIGHT),TRANSFORM(E_Sele_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2004544(E_Address(__in,__cfg_Local).Layout __EE2003795, E_Sele_Address(__in,__cfg_Local).Layout __EE2004538) := __EEQP(__EE2004538.Location_,__EE2003795.UID);
  SHARED __EE2004662 := JOIN(__EE2003795,__EE2004538,__JC2004544(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2004664 := __EE2004662;
  EXPORT Res16 := __UNWRAP(__EE2004664);
  SHARED __EE2013043 := __ENH_Aircraft;
  SHARED __EE2013032 := __E_Sele_Aircraft;
  SHARED __EE2013233 := __EE2013032(__NN(__EE2013032.Legal_) AND __NN(__EE2013032.Plane_));
  SHARED __EE2013026 := __ENH_Business_Sele;
  SHARED __EE2013304 := __EE2013026(__T(__OP2(__EE2013026.UID,=,__CN(1))));
  __JC2013310(E_Sele_Aircraft(__in,__cfg_Local).Layout __EE2013233, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2013304) := __EEQP(__EE2013304.UID,__EE2013233.Legal_);
  SHARED __EE2013327 := JOIN(__EE2013233,__EE2013304,__JC2013310(LEFT,RIGHT),TRANSFORM(E_Sele_Aircraft(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2013333(B_Aircraft(__in,__cfg_Local).__ST56729_Layout __EE2013043, E_Sele_Aircraft(__in,__cfg_Local).Layout __EE2013327) := __EEQP(__EE2013327.Plane_,__EE2013043.UID);
  SHARED __EE2013357 := JOIN(__EE2013043,__EE2013327,__JC2013333(LEFT,RIGHT),TRANSFORM(B_Aircraft(__in,__cfg_Local).__ST56729_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2013359 := __EE2013357;
  EXPORT Res17 := __UNWRAP(__EE2013359);
  SHARED __EE2021481 := __ENH_Bankruptcy;
  SHARED __EE2021470 := __E_Sele_Bankruptcy;
  SHARED __EE2021783 := __EE2021470(__NN(__EE2021470.Legal_) AND __NN(__EE2021470.Bankrupt_));
  SHARED __EE2021464 := __ENH_Business_Sele;
  SHARED __EE2021910 := __EE2021464(__T(__OP2(__EE2021464.UID,=,__CN(1))));
  __JC2021916(E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE2021783, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2021910) := __EEQP(__EE2021910.UID,__EE2021783.Legal_);
  SHARED __EE2021926 := JOIN(__EE2021783,__EE2021910,__JC2021916(LEFT,RIGHT),TRANSFORM(E_Sele_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2021932(B_Bankruptcy(__in,__cfg_Local).__ST57038_Layout __EE2021481, E_Sele_Bankruptcy(__in,__cfg_Local).Layout __EE2021926) := __EEQP(__EE2021926.Bankrupt_,__EE2021481.UID);
  SHARED __EE2022019 := JOIN(__EE2021481,__EE2021926,__JC2021932(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST57038_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2022021 := __EE2022019;
  EXPORT Res18 := __UNWRAP(__EE2022021);
  SHARED __EE2030287 := __ENH_Lien_Judgment;
  SHARED __EE2030276 := __E_Sele_Lien_Judgment;
  SHARED __EE2030507 := __EE2030276(__NN(__EE2030276.Sele_) AND __NN(__EE2030276.Lien_));
  SHARED __EE2030270 := __ENH_Business_Sele;
  SHARED __EE2030593 := __EE2030270(__T(__OP2(__EE2030270.UID,=,__CN(1))));
  __JC2030599(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE2030507, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2030593) := __EEQP(__EE2030593.UID,__EE2030507.Sele_);
  SHARED __EE2030615 := JOIN(__EE2030507,__EE2030593,__JC2030599(LEFT,RIGHT),TRANSFORM(E_Sele_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2030621(B_Lien_Judgment(__in,__cfg_Local).__ST71193_Layout __EE2030287, E_Sele_Lien_Judgment(__in,__cfg_Local).Layout __EE2030615) := __EEQP(__EE2030615.Lien_,__EE2030287.UID);
  SHARED __EE2030661 := JOIN(__EE2030287,__EE2030615,__JC2030621(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment(__in,__cfg_Local).__ST71193_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2030663 := __EE2030661;
  EXPORT Res19 := __UNWRAP(__EE2030663);
  SHARED __EE2038971 := __ENH_Person;
  SHARED __EE2038960 := __E_Sele_Person;
  SHARED __EE2040125 := __EE2038960(__NN(__EE2038960.Legal_) AND __NN(__EE2038960.Contact_));
  SHARED __EE2038954 := __ENH_Business_Sele;
  SHARED __EE2040657 := __EE2038954(__T(__OP2(__EE2038954.UID,=,__CN(1))));
  __JC2040663(E_Sele_Person(__in,__cfg_Local).Layout __EE2040125, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2040657) := __EEQP(__EE2040657.UID,__EE2040125.Legal_);
  SHARED __EE2040690 := JOIN(__EE2040125,__EE2040657,__JC2040663(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2040696(B_Person(__in,__cfg_Local).__ST75136_Layout __EE2038971, E_Sele_Person(__in,__cfg_Local).Layout __EE2040690) := __EEQP(__EE2040690.Contact_,__EE2038971.UID);
  SHARED __EE2041171 := JOIN(__EE2038971,__EE2040690,__JC2040696(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2041173 := __EE2041171;
  EXPORT Res20 := __UNWRAP(__EE2041173);
  SHARED __EE2050526 := __ENH_Phone;
  SHARED __EE2050515 := __E_Sele_Phone_Number;
  SHARED __EE2050823 := __EE2050515(__NN(__EE2050515.Legal_) AND __NN(__EE2050515.Phone_Number_));
  SHARED __EE2050509 := __ENH_Business_Sele;
  SHARED __EE2050943 := __EE2050509(__T(__OP2(__EE2050509.UID,=,__CN(1))));
  __JC2050949(E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE2050823, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2050943) := __EEQP(__EE2050943.UID,__EE2050823.Legal_);
  SHARED __EE2050985 := JOIN(__EE2050823,__EE2050943,__JC2050949(LEFT,RIGHT),TRANSFORM(E_Sele_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2050991(B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2050526, E_Sele_Phone_Number(__in,__cfg_Local).Layout __EE2050985) := __EEQP(__EE2050985.Phone_Number_,__EE2050526.UID);
  SHARED __EE2051045 := JOIN(__EE2050526,__EE2050985,__JC2050991(LEFT,RIGHT),TRANSFORM(B_Phone(__in,__cfg_Local).__ST75420_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2051047 := __EE2051045;
  EXPORT Res21 := __UNWRAP(__EE2051047);
  SHARED __EE2059349 := __ENH_Property;
  SHARED __EE2059338 := __E_Sele_Property;
  SHARED __EE2059566 := __EE2059338(__NN(__EE2059338.Legal_) AND __NN(__EE2059338.Prop_));
  SHARED __EE2059332 := __ENH_Business_Sele;
  SHARED __EE2059651 := __EE2059332(__T(__OP2(__EE2059332.UID,=,__CN(1))));
  __JC2059657(E_Sele_Property(__in,__cfg_Local).Layout __EE2059566, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2059651) := __EEQP(__EE2059651.UID,__EE2059566.Legal_);
  SHARED __EE2059678 := JOIN(__EE2059566,__EE2059651,__JC2059657(LEFT,RIGHT),TRANSFORM(E_Sele_Property(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2059684(B_Property(__in,__cfg_Local).__ST75600_Layout __EE2059349, E_Sele_Property(__in,__cfg_Local).Layout __EE2059678) := __EEQP(__EE2059678.Prop_,__EE2059349.UID);
  SHARED __EE2059718 := JOIN(__EE2059349,__EE2059678,__JC2059684(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST75600_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2059720 := __EE2059718;
  EXPORT Res22 := __UNWRAP(__EE2059720);
  SHARED __EE2067824 := __E_Property_Event;
  SHARED __EE2067814 := __E_Sele_Property_Event;
  SHARED __EE2068633 := __EE2067814(__NN(__EE2067814.Legal_) AND __NN(__EE2067814.Event_));
  SHARED __EE2067808 := __ENH_Business_Sele;
  SHARED __EE2069014 := __EE2067808(__T(__OP2(__EE2067808.UID,=,__CN(1))));
  __JC2069020(E_Sele_Property_Event(__in,__cfg_Local).Layout __EE2068633, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2069014) := __EEQP(__EE2069014.UID,__EE2068633.Legal_);
  SHARED __EE2069043 := JOIN(__EE2068633,__EE2069014,__JC2069020(LEFT,RIGHT),TRANSFORM(E_Sele_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2069049(E_Property_Event(__in,__cfg_Local).Layout __EE2067824, E_Sele_Property_Event(__in,__cfg_Local).Layout __EE2069043) := __EEQP(__EE2069043.Event_,__EE2067824.UID);
  SHARED __EE2069377 := JOIN(__EE2067824,__EE2069043,__JC2069049(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2069379 := __EE2069377;
  EXPORT Res23 := __UNWRAP(__EE2069379);
  SHARED __EE2078163 := __E_Sele_T_I_N;
  SHARED __EE2078320 := __EE2078163(__NN(__EE2078163.Tax_I_D_) AND __NN(__EE2078163.Legal_));
  SHARED __EE2078157 := __ENH_Business_Sele;
  SHARED __EE2078364 := __EE2078157(__T(__OP2(__EE2078157.UID,=,__CN(1))));
  __JC2078370(E_Sele_T_I_N(__in,__cfg_Local).Layout __EE2078320, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2078364) := __EEQP(__EE2078364.UID,__EE2078320.Legal_);
  SHARED __EE2078382 := JOIN(__EE2078320,__EE2078364,__JC2078370(LEFT,RIGHT),TRANSFORM(E_Sele_T_I_N(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2078392 := PROJECT(TABLE(PROJECT(__EE2078382,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res24 := __UNWRAP(__EE2078392);
  SHARED __EE2083511 := __ENH_Tradeline;
  SHARED __EE2083500 := __E_Sele_Tradeline;
  SHARED __EE2083776 := __EE2083500(__NN(__EE2083500.Legal_) AND __NN(__EE2083500.Account_));
  SHARED __EE2083494 := __ENH_Business_Sele;
  SHARED __EE2083885 := __EE2083494(__T(__OP2(__EE2083494.UID,=,__CN(1))));
  __JC2083891(E_Sele_Tradeline(__in,__cfg_Local).Layout __EE2083776, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2083885) := __EEQP(__EE2083885.UID,__EE2083776.Legal_);
  SHARED __EE2083898 := JOIN(__EE2083776,__EE2083885,__JC2083891(LEFT,RIGHT),TRANSFORM(E_Sele_Tradeline(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2083904(B_Tradeline(__in,__cfg_Local).__ST75957_Layout __EE2083511, E_Sele_Tradeline(__in,__cfg_Local).Layout __EE2083898) := __EEQP(__EE2083898.Account_,__EE2083511.UID);
  SHARED __EE2083976 := JOIN(__EE2083511,__EE2083898,__JC2083904(LEFT,RIGHT),TRANSFORM(B_Tradeline(__in,__cfg_Local).__ST75957_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2083978 := __EE2083976;
  EXPORT Res25 := __UNWRAP(__EE2083978);
  SHARED __EE2092170 := __ENH_U_C_C;
  SHARED __EE2092159 := __E_Sele_U_C_C;
  SHARED __EE2092370 := __EE2092159(__NN(__EE2092159.Legal_) AND __NN(__EE2092159.Filing_));
  SHARED __EE2092153 := __ENH_Business_Sele;
  SHARED __EE2092446 := __EE2092153(__T(__OP2(__EE2092153.UID,=,__CN(1))));
  __JC2092452(E_Sele_U_C_C(__in,__cfg_Local).Layout __EE2092370, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2092446) := __EEQP(__EE2092446.UID,__EE2092370.Legal_);
  SHARED __EE2092467 := JOIN(__EE2092370,__EE2092446,__JC2092452(LEFT,RIGHT),TRANSFORM(E_Sele_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2092473(B_U_C_C(__in,__cfg_Local).__ST76043_Layout __EE2092170, E_Sele_U_C_C(__in,__cfg_Local).Layout __EE2092467) := __EEQP(__EE2092467.Filing_,__EE2092170.UID);
  SHARED __EE2092504 := JOIN(__EE2092170,__EE2092467,__JC2092473(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST76043_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2092506 := __EE2092504;
  EXPORT Res26 := __UNWRAP(__EE2092506);
  SHARED __EE2100587 := __E_Utility;
  SHARED __EE2100577 := __E_Sele_Utility;
  SHARED __EE2100737 := __EE2100577(__NN(__EE2100577.Legal_) AND __NN(__EE2100577.Util_));
  SHARED __EE2100571 := __ENH_Business_Sele;
  SHARED __EE2100789 := __EE2100571(__T(__OP2(__EE2100571.UID,=,__CN(1))));
  __JC2100795(E_Sele_Utility(__in,__cfg_Local).Layout __EE2100737, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2100789) := __EEQP(__EE2100789.UID,__EE2100737.Legal_);
  SHARED __EE2100806 := JOIN(__EE2100737,__EE2100789,__JC2100795(LEFT,RIGHT),TRANSFORM(E_Sele_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2100812(E_Utility(__in,__cfg_Local).Layout __EE2100587, E_Sele_Utility(__in,__cfg_Local).Layout __EE2100806) := __EEQP(__EE2100806.Util_,__EE2100587.UID);
  SHARED __EE2100823 := JOIN(__EE2100587,__EE2100806,__JC2100812(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2100825 := __EE2100823;
  EXPORT Res27 := __UNWRAP(__EE2100825);
  SHARED __EE2108957 := __ENH_Vehicle;
  SHARED __EE2108946 := __E_Sele_Vehicle;
  SHARED __EE2109390 := __EE2108946(__NN(__EE2108946.Legal_) AND __NN(__EE2108946.Automobile_));
  SHARED __EE2108940 := __ENH_Business_Sele;
  SHARED __EE2109582 := __EE2108940(__T(__OP2(__EE2108940.UID,=,__CN(1))));
  __JC2109588(E_Sele_Vehicle(__in,__cfg_Local).Layout __EE2109390, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2109582) := __EEQP(__EE2109582.UID,__EE2109390.Legal_);
  SHARED __EE2109638 := JOIN(__EE2109390,__EE2109582,__JC2109588(LEFT,RIGHT),TRANSFORM(E_Sele_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2109644(B_Vehicle(__in,__cfg_Local).__ST76190_Layout __EE2108957, E_Sele_Vehicle(__in,__cfg_Local).Layout __EE2109638) := __EEQP(__EE2109638.Automobile_,__EE2108957.UID);
  SHARED __EE2109756 := JOIN(__EE2108957,__EE2109638,__JC2109644(LEFT,RIGHT),TRANSFORM(B_Vehicle(__in,__cfg_Local).__ST76190_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2109758 := __EE2109756;
  EXPORT Res28 := __UNWRAP(__EE2109758);
  SHARED __EE2118155 := __ENH_Watercraft;
  SHARED __EE2118144 := __E_Sele_Watercraft;
  SHARED __EE2118307 := __EE2118144(__NN(__EE2118144.Legal_) AND __NN(__EE2118144.W_Craft_));
  SHARED __EE2118138 := __ENH_Business_Sele;
  SHARED __EE2118360 := __EE2118138(__T(__OP2(__EE2118138.UID,=,__CN(1))));
  __JC2118366(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE2118307, B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2118360) := __EEQP(__EE2118360.UID,__EE2118307.Legal_);
  SHARED __EE2118377 := JOIN(__EE2118307,__EE2118360,__JC2118366(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2118383(B_Watercraft(__in,__cfg_Local).__ST76314_Layout __EE2118155, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE2118377) := __EEQP(__EE2118377.W_Craft_,__EE2118155.UID);
  SHARED __EE2118395 := JOIN(__EE2118155,__EE2118377,__JC2118383(LEFT,RIGHT),TRANSFORM(B_Watercraft(__in,__cfg_Local).__ST76314_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2118397 := __EE2118395;
  EXPORT Res29 := __UNWRAP(__EE2118397);
  SHARED __EE2126517 := __ENH_Criminal_Offense;
  SHARED __EE2126506 := __E_Criminal_Details;
  SHARED __EE2126811 := __EE2126506(__NN(__EE2126506.Offender_) AND __NN(__EE2126506.Offense_));
  SHARED __EE2126500 := __E_Criminal_Offender;
  SHARED __EE2126933 := __EE2126500(__T(__OP2(__EE2126500.UID,=,__CN(1))));
  __JC2126939(E_Criminal_Details(__in,__cfg_Local).Layout __EE2126811, E_Criminal_Offender(__in,__cfg_Local).Layout __EE2126933) := __EEQP(__EE2126933.UID,__EE2126811.Offender_);
  SHARED __EE2126947 := JOIN(__EE2126811,__EE2126933,__JC2126939(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2126953(B_Criminal_Offense(__in,__cfg_Local).__ST66406_Layout __EE2126517, E_Criminal_Details(__in,__cfg_Local).Layout __EE2126947) := __EEQP(__EE2126947.Offense_,__EE2126517.UID);
  SHARED __EE2127037 := JOIN(__EE2126517,__EE2126947,__JC2126953(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST66406_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2127039 := __EE2127037;
  EXPORT Res30 := __UNWRAP(__EE2127039);
  SHARED __EE2127291 := __ENH_Criminal_Punishment;
  SHARED __EE2127280 := __E_Criminal_Details;
  SHARED __EE2127525 := __EE2127280(__NN(__EE2127280.Offender_) AND __NN(__EE2127280.Punishment_));
  SHARED __EE2127274 := __E_Criminal_Offender;
  SHARED __EE2127618 := __EE2127274(__T(__OP2(__EE2127274.UID,=,__CN(1))));
  __JC2127624(E_Criminal_Details(__in,__cfg_Local).Layout __EE2127525, E_Criminal_Offender(__in,__cfg_Local).Layout __EE2127618) := __EEQP(__EE2127618.UID,__EE2127525.Offender_);
  SHARED __EE2127632 := JOIN(__EE2127525,__EE2127618,__JC2127624(LEFT,RIGHT),TRANSFORM(E_Criminal_Details(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2127638(B_Criminal_Punishment(__in,__cfg_Local).__ST66520_Layout __EE2127291, E_Criminal_Details(__in,__cfg_Local).Layout __EE2127632) := __EEQP(__EE2127632.Punishment_,__EE2127291.UID);
  SHARED __EE2127693 := JOIN(__EE2127291,__EE2127632,__JC2127638(LEFT,RIGHT),TRANSFORM(B_Criminal_Punishment(__in,__cfg_Local).__ST66520_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2127695 := __EE2127693;
  EXPORT Res31 := __UNWRAP(__EE2127695);
  SHARED __EE2127874 := __E_First_Degree_Associations;
  SHARED __EE2127950 := __EE2127874(__NN(__EE2127874.Subject_));
  SHARED __EE2127868 := __ENH_Person;
  SHARED __EE2127955 := __EE2127868(__T(__OP2(__EE2127868.UID,=,__CN(1))));
  __JC2127961(E_First_Degree_Associations(__in,__cfg_Local).Layout __EE2127950, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2127955) := __EEQP(__EE2127955.UID,__EE2127950.Subject_);
  SHARED __EE2127973 := JOIN(__EE2127950,__EE2127955,__JC2127961(LEFT,RIGHT),TRANSFORM(E_First_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2127975 := __EE2127973;
  EXPORT Res32 := __UNWRAP(__EE2127975);
  SHARED __EE2129281 := __ENH_First_Degree_Relative;
  SHARED __EE2129357 := __EE2129281(__NN(__EE2129281.Subject_));
  SHARED __EE2129274 := __ENH_Person;
  SHARED __EE2129362 := __EE2129274(__T(__OP2(__EE2129274.UID,=,__CN(1))));
  __JC2129368(E_First_Degree_Relative(__in,__cfg_Local).Layout __EE2129357, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2129362) := __EEQP(__EE2129362.UID,__EE2129357.Subject_);
  SHARED __EE2129380 := JOIN(__EE2129357,__EE2129362,__JC2129368(LEFT,RIGHT),TRANSFORM(E_First_Degree_Relative(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2129382 := __EE2129380;
  EXPORT Res33 := __UNWRAP(__EE2129382);
  SHARED __EE2130689 := __ENH_Phone;
  SHARED __EE2130678 := __E_House_Hold_Phone;
  SHARED __EE2130962 := __EE2130678(__NN(__EE2130678.Household_) AND __NN(__EE2130678.Phone_Number_));
  SHARED __EE2130672 := __E_Household;
  SHARED __EE2131072 := __EE2130672(__T(__OP2(__EE2130672.UID,=,__CN(1))));
  __JC2131078(E_House_Hold_Phone(__in,__cfg_Local).Layout __EE2130962, E_Household(__in,__cfg_Local).Layout __EE2131072) := __EEQP(__EE2131072.UID,__EE2130962.Household_);
  SHARED __EE2131104 := JOIN(__EE2130962,__EE2131072,__JC2131078(LEFT,RIGHT),TRANSFORM(E_House_Hold_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2131110(B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2130689, E_House_Hold_Phone(__in,__cfg_Local).Layout __EE2131104) := __EEQP(__EE2131104.Phone_Number_,__EE2130689.UID);
  SHARED __EE2131164 := JOIN(__EE2130689,__EE2131104,__JC2131110(LEFT,RIGHT),TRANSFORM(B_Phone(__in,__cfg_Local).__ST75420_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2131166 := __EE2131164;
  EXPORT Res34 := __UNWRAP(__EE2131166);
  SHARED __EE2131410 := __ENH_Person;
  SHARED __EE2131399 := __E_Household_Member;
  SHARED __EE2132525 := __EE2131399(__NN(__EE2131399.Household_) AND __NN(__EE2131399.Subject_));
  SHARED __EE2131393 := __E_Household;
  SHARED __EE2133038 := __EE2131393(__T(__OP2(__EE2131393.UID,=,__CN(1))));
  __JC2133044(E_Household_Member(__in,__cfg_Local).Layout __EE2132525, E_Household(__in,__cfg_Local).Layout __EE2133038) := __EEQP(__EE2133038.UID,__EE2132525.Household_);
  SHARED __EE2133052 := JOIN(__EE2132525,__EE2133038,__JC2133044(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2133058(B_Person(__in,__cfg_Local).__ST75136_Layout __EE2131410, E_Household_Member(__in,__cfg_Local).Layout __EE2133052) := __EEQP(__EE2133052.Subject_,__EE2131410.UID);
  SHARED __EE2133533 := JOIN(__EE2131410,__EE2133052,__JC2133058(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2133535 := __EE2133533;
  EXPORT Res35 := __UNWRAP(__EE2133535);
  SHARED __EE2134803 := __ENH_Aircraft;
  SHARED __EE2134792 := __E_Aircraft_Owner;
  SHARED __EE2134978 := __EE2134792(__NN(__EE2134792.Owner_) AND __NN(__EE2134792.Plane_));
  SHARED __EE2134786 := __ENH_Person;
  SHARED __EE2135042 := __EE2134786(__T(__OP2(__EE2134786.UID,=,__CN(1))));
  __JC2135048(E_Aircraft_Owner(__in,__cfg_Local).Layout __EE2134978, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2135042) := __EEQP(__EE2135042.UID,__EE2134978.Owner_);
  SHARED __EE2135058 := JOIN(__EE2134978,__EE2135042,__JC2135048(LEFT,RIGHT),TRANSFORM(E_Aircraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2135064(B_Aircraft(__in,__cfg_Local).__ST56729_Layout __EE2134803, E_Aircraft_Owner(__in,__cfg_Local).Layout __EE2135058) := __EEQP(__EE2135058.Plane_,__EE2134803.UID);
  SHARED __EE2135088 := JOIN(__EE2134803,__EE2135058,__JC2135064(LEFT,RIGHT),TRANSFORM(B_Aircraft(__in,__cfg_Local).__ST56729_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2135090 := __EE2135088;
  EXPORT Res36 := __UNWRAP(__EE2135090);
  SHARED __EE2137461 := __E_Employment;
  SHARED __EE2137451 := __E_Employment_Person;
  SHARED __EE2137602 := __EE2137451(__NN(__EE2137451.Subject_) AND __NN(__EE2137451.Emp_));
  SHARED __EE2137445 := __ENH_Person;
  SHARED __EE2137650 := __EE2137445(__T(__OP2(__EE2137445.UID,=,__CN(1))));
  __JC2137656(E_Employment_Person(__in,__cfg_Local).Layout __EE2137602, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2137650) := __EEQP(__EE2137650.UID,__EE2137602.Subject_);
  SHARED __EE2137663 := JOIN(__EE2137602,__EE2137650,__JC2137656(LEFT,RIGHT),TRANSFORM(E_Employment_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2137669(E_Employment(__in,__cfg_Local).Layout __EE2137461, E_Employment_Person(__in,__cfg_Local).Layout __EE2137663) := __EEQP(__EE2137663.Emp_,__EE2137461.UID);
  SHARED __EE2137680 := JOIN(__EE2137461,__EE2137663,__JC2137669(LEFT,RIGHT),TRANSFORM(E_Employment(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2137682 := __EE2137680;
  EXPORT Res37 := __UNWRAP(__EE2137682);
  SHARED __EE2140026 := __E_Household;
  SHARED __EE2140016 := __E_Household_Member;
  SHARED __EE2140159 := __EE2140016(__NN(__EE2140016.Subject_) AND __NN(__EE2140016.Household_));
  SHARED __EE2140010 := __ENH_Person;
  SHARED __EE2140203 := __EE2140010(__T(__OP2(__EE2140010.UID,=,__CN(1))));
  __JC2140209(E_Household_Member(__in,__cfg_Local).Layout __EE2140159, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2140203) := __EEQP(__EE2140203.UID,__EE2140159.Subject_);
  SHARED __EE2140217 := JOIN(__EE2140159,__EE2140203,__JC2140209(LEFT,RIGHT),TRANSFORM(E_Household_Member(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2140223(E_Household(__in,__cfg_Local).Layout __EE2140026, E_Household_Member(__in,__cfg_Local).Layout __EE2140217) := __EEQP(__EE2140217.Household_,__EE2140026.UID);
  SHARED __EE2140229 := JOIN(__EE2140026,__EE2140217,__JC2140223(LEFT,RIGHT),TRANSFORM(E_Household(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2140231 := __EE2140229;
  EXPORT Res38 := __UNWRAP(__EE2140231);
  SHARED __EE2142562 := __E_Accident;
  SHARED __EE2142552 := __E_Person_Accident;
  SHARED __EE2142816 := __EE2142552(__NN(__EE2142552.Subject_) AND __NN(__EE2142552.Acc_));
  SHARED __EE2142546 := __ENH_Person;
  SHARED __EE2142920 := __EE2142546(__T(__OP2(__EE2142546.UID,=,__CN(1))));
  __JC2142926(E_Person_Accident(__in,__cfg_Local).Layout __EE2142816, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2142920) := __EEQP(__EE2142920.UID,__EE2142816.Subject_);
  SHARED __EE2142974 := JOIN(__EE2142816,__EE2142920,__JC2142926(LEFT,RIGHT),TRANSFORM(E_Person_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2142980(E_Accident(__in,__cfg_Local).Layout __EE2142562, E_Person_Accident(__in,__cfg_Local).Layout __EE2142974) := __EEQP(__EE2142974.Acc_,__EE2142562.UID);
  SHARED __EE2143006 := JOIN(__EE2142562,__EE2142974,__JC2142980(LEFT,RIGHT),TRANSFORM(E_Accident(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2143008 := __EE2143006;
  EXPORT Res39 := __UNWRAP(__EE2143008);
  SHARED __EE2145505 := __E_Address;
  SHARED __EE2145495 := __E_Person_Address;
  SHARED __EE2145919 := __EE2145495(__NN(__EE2145495.Subject_) AND __NN(__EE2145495.Location_));
  SHARED __EE2145489 := __ENH_Person;
  SHARED __EE2146092 := __EE2145489(__T(__OP2(__EE2145489.UID,=,__CN(1))));
  __JC2146098(E_Person_Address(__in,__cfg_Local).Layout __EE2145919, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2146092) := __EEQP(__EE2146092.UID,__EE2145919.Subject_);
  SHARED __EE2146123 := JOIN(__EE2145919,__EE2146092,__JC2146098(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2146129(E_Address(__in,__cfg_Local).Layout __EE2145505, E_Person_Address(__in,__cfg_Local).Layout __EE2146123) := __EEQP(__EE2146123.Location_,__EE2145505.UID);
  SHARED __EE2146247 := JOIN(__EE2145505,__EE2146123,__JC2146129(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2146249 := __EE2146247;
  EXPORT Res40 := __UNWRAP(__EE2146249);
  SHARED __EE2148839 := __ENH_Bankruptcy;
  SHARED __EE2148828 := __E_Person_Bankruptcy;
  SHARED __EE2149135 := __EE2148828(__NN(__EE2148828.Subject_) AND __NN(__EE2148828.Bankrupt_));
  SHARED __EE2148822 := __ENH_Person;
  SHARED __EE2149259 := __EE2148822(__T(__OP2(__EE2148822.UID,=,__CN(1))));
  __JC2149265(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE2149135, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2149259) := __EEQP(__EE2149259.UID,__EE2149135.Subject_);
  SHARED __EE2149272 := JOIN(__EE2149135,__EE2149259,__JC2149265(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2149278(B_Bankruptcy(__in,__cfg_Local).__ST57038_Layout __EE2148839, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE2149272) := __EEQP(__EE2149272.Bankrupt_,__EE2148839.UID);
  SHARED __EE2149365 := JOIN(__EE2148839,__EE2149272,__JC2149278(LEFT,RIGHT),TRANSFORM(B_Bankruptcy(__in,__cfg_Local).__ST57038_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2149367 := __EE2149365;
  EXPORT Res41 := __UNWRAP(__EE2149367);
  SHARED __EE2151858 := __E_Drivers_License;
  SHARED __EE2151848 := __E_Person_Drivers_License;
  SHARED __EE2152094 := __EE2151848(__NN(__EE2151848.Subject_) AND __NN(__EE2151848.License_));
  SHARED __EE2151842 := __ENH_Person;
  SHARED __EE2152188 := __EE2151842(__T(__OP2(__EE2151842.UID,=,__CN(1))));
  __JC2152194(E_Person_Drivers_License(__in,__cfg_Local).Layout __EE2152094, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2152188) := __EEQP(__EE2152188.UID,__EE2152094.Subject_);
  SHARED __EE2152201 := JOIN(__EE2152094,__EE2152188,__JC2152194(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2152207(E_Drivers_License(__in,__cfg_Local).Layout __EE2151858, E_Person_Drivers_License(__in,__cfg_Local).Layout __EE2152201) := __EEQP(__EE2152201.License_,__EE2151858.UID);
  SHARED __EE2152264 := JOIN(__EE2151858,__EE2152201,__JC2152207(LEFT,RIGHT),TRANSFORM(E_Drivers_License(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2152266 := __EE2152264;
  EXPORT Res42 := __UNWRAP(__EE2152266);
  SHARED __EE2154702 := __E_Education;
  SHARED __EE2154692 := __E_Person_Education;
  SHARED __EE2154886 := __EE2154692(__NN(__EE2154692.Subject_) AND __NN(__EE2154692.Edu_));
  SHARED __EE2154686 := __ENH_Person;
  SHARED __EE2154955 := __EE2154686(__T(__OP2(__EE2154686.UID,=,__CN(1))));
  __JC2154961(E_Person_Education(__in,__cfg_Local).Layout __EE2154886, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2154955) := __EEQP(__EE2154955.UID,__EE2154886.Subject_);
  SHARED __EE2154979 := JOIN(__EE2154886,__EE2154955,__JC2154961(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2154985(E_Education(__in,__cfg_Local).Layout __EE2154702, E_Person_Education(__in,__cfg_Local).Layout __EE2154979) := __EEQP(__EE2154979.Edu_,__EE2154702.UID);
  SHARED __EE2155006 := JOIN(__EE2154702,__EE2154979,__JC2154985(LEFT,RIGHT),TRANSFORM(E_Education(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2155008 := __EE2155006;
  EXPORT Res43 := __UNWRAP(__EE2155008);
  SHARED __EE2157405 := __E_Email;
  SHARED __EE2157395 := __E_Person_Email;
  SHARED __EE2157599 := __EE2157395(__NN(__EE2157395.Subject_) AND __NN(__EE2157395._r_Email_));
  SHARED __EE2157389 := __ENH_Person;
  SHARED __EE2157671 := __EE2157389(__T(__OP2(__EE2157389.UID,=,__CN(1))));
  __JC2157677(E_Person_Email(__in,__cfg_Local).Layout __EE2157599, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2157671) := __EEQP(__EE2157671.UID,__EE2157599.Subject_);
  SHARED __EE2157684 := JOIN(__EE2157599,__EE2157671,__JC2157677(LEFT,RIGHT),TRANSFORM(E_Person_Email(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2157690(E_Email(__in,__cfg_Local).Layout __EE2157405, E_Person_Email(__in,__cfg_Local).Layout __EE2157684) := __EEQP(__EE2157684._r_Email_,__EE2157405.UID);
  SHARED __EE2157725 := JOIN(__EE2157405,__EE2157684,__JC2157690(LEFT,RIGHT),TRANSFORM(E_Email(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2157727 := __EE2157725;
  EXPORT Res44 := __UNWRAP(__EE2157727);
  SHARED __EE2160120 := __ENH_Inquiry;
  SHARED __EE2160109 := __E_Person_Inquiry;
  SHARED __EE2160283 := __EE2160109(__NN(__EE2160109.Subject_) AND __NN(__EE2160109.Inquiry_));
  SHARED __EE2160103 := __ENH_Person;
  SHARED __EE2160342 := __EE2160103(__T(__OP2(__EE2160103.UID,=,__CN(1))));
  __JC2160348(E_Person_Inquiry(__in,__cfg_Local).Layout __EE2160283, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2160342) := __EEQP(__EE2160342.UID,__EE2160283.Subject_);
  SHARED __EE2160355 := JOIN(__EE2160283,__EE2160342,__JC2160348(LEFT,RIGHT),TRANSFORM(E_Person_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2160361(B_Inquiry(__in,__cfg_Local).__ST71132_Layout __EE2160120, E_Person_Inquiry(__in,__cfg_Local).Layout __EE2160355) := __EEQP(__EE2160355.Inquiry_,__EE2160120.UID);
  SHARED __EE2160383 := JOIN(__EE2160120,__EE2160355,__JC2160361(LEFT,RIGHT),TRANSFORM(B_Inquiry(__in,__cfg_Local).__ST71132_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2160385 := __EE2160383;
  EXPORT Res45 := __UNWRAP(__EE2160385);
  SHARED __EE2162752 := __ENH_Lien_Judgment;
  SHARED __EE2162741 := __E_Person_Lien_Judgment;
  SHARED __EE2162966 := __EE2162741(__NN(__EE2162741.Subject_) AND __NN(__EE2162741.Lien_));
  SHARED __EE2162735 := __ENH_Person;
  SHARED __EE2163049 := __EE2162735(__T(__OP2(__EE2162735.UID,=,__CN(1))));
  __JC2163055(E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE2162966, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2163049) := __EEQP(__EE2163049.UID,__EE2162966.Subject_);
  SHARED __EE2163068 := JOIN(__EE2162966,__EE2163049,__JC2163055(LEFT,RIGHT),TRANSFORM(E_Person_Lien_Judgment(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2163074(B_Lien_Judgment(__in,__cfg_Local).__ST71193_Layout __EE2162752, E_Person_Lien_Judgment(__in,__cfg_Local).Layout __EE2163068) := __EEQP(__EE2163068.Lien_,__EE2162752.UID);
  SHARED __EE2163114 := JOIN(__EE2162752,__EE2163068,__JC2163074(LEFT,RIGHT),TRANSFORM(B_Lien_Judgment(__in,__cfg_Local).__ST71193_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2163116 := __EE2163114;
  EXPORT Res46 := __UNWRAP(__EE2163116);
  SHARED __EE2165535 := __ENH_Criminal_Offender;
  SHARED __EE2165524 := __E_Person_Offender;
  SHARED __EE2165715 := __EE2165524(__NN(__EE2165524.Subject_) AND __NN(__EE2165524.Offender_));
  SHARED __EE2165518 := __ENH_Person;
  SHARED __EE2165781 := __EE2165518(__T(__OP2(__EE2165518.UID,=,__CN(1))));
  __JC2165787(E_Person_Offender(__in,__cfg_Local).Layout __EE2165715, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2165781) := __EEQP(__EE2165781.UID,__EE2165715.Subject_);
  SHARED __EE2165794 := JOIN(__EE2165715,__EE2165781,__JC2165787(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2165800(B_Criminal_Offender(__in,__cfg_Local).__ST66256_Layout __EE2165535, E_Person_Offender(__in,__cfg_Local).Layout __EE2165794) := __EEQP(__EE2165794.Offender_,__EE2165535.UID);
  SHARED __EE2165829 := JOIN(__EE2165535,__EE2165794,__JC2165800(LEFT,RIGHT),TRANSFORM(B_Criminal_Offender(__in,__cfg_Local).__ST66256_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2165831 := __EE2165829;
  EXPORT Res47 := __UNWRAP(__EE2165831);
  SHARED __EE2168212 := __ENH_Criminal_Offense;
  SHARED __EE2168201 := __E_Person_Offenses;
  SHARED __EE2168504 := __EE2168201(__NN(__EE2168201.Subject_) AND __NN(__EE2168201.Offense_));
  SHARED __EE2168195 := __ENH_Person;
  SHARED __EE2168625 := __EE2168195(__T(__OP2(__EE2168195.UID,=,__CN(1))));
  __JC2168631(E_Person_Offenses(__in,__cfg_Local).Layout __EE2168504, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2168625) := __EEQP(__EE2168625.UID,__EE2168504.Subject_);
  SHARED __EE2168638 := JOIN(__EE2168504,__EE2168625,__JC2168631(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2168644(B_Criminal_Offense(__in,__cfg_Local).__ST66406_Layout __EE2168212, E_Person_Offenses(__in,__cfg_Local).Layout __EE2168638) := __EEQP(__EE2168638.Offense_,__EE2168212.UID);
  SHARED __EE2168728 := JOIN(__EE2168212,__EE2168638,__JC2168644(LEFT,RIGHT),TRANSFORM(B_Criminal_Offense(__in,__cfg_Local).__ST66406_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2168730 := __EE2168728;
  EXPORT Res48 := __UNWRAP(__EE2168730);
  SHARED __EE2171216 := __ENH_Phone;
  SHARED __EE2171205 := __E_Person_Phone;
  SHARED __EE2171507 := __EE2171205(__NN(__EE2171205.Subject_) AND __NN(__EE2171205.Phone_Number_));
  SHARED __EE2171199 := __ENH_Person;
  SHARED __EE2171625 := __EE2171199(__T(__OP2(__EE2171199.UID,=,__CN(1))));
  __JC2171631(E_Person_Phone(__in,__cfg_Local).Layout __EE2171507, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2171625) := __EEQP(__EE2171625.UID,__EE2171507.Subject_);
  SHARED __EE2171665 := JOIN(__EE2171507,__EE2171625,__JC2171631(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2171671(B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2171216, E_Person_Phone(__in,__cfg_Local).Layout __EE2171665) := __EEQP(__EE2171665.Phone_Number_,__EE2171216.UID);
  SHARED __EE2171725 := JOIN(__EE2171216,__EE2171665,__JC2171671(LEFT,RIGHT),TRANSFORM(B_Phone(__in,__cfg_Local).__ST75420_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2171727 := __EE2171725;
  EXPORT Res49 := __UNWRAP(__EE2171727);
  SHARED __EE2174232 := __ENH_Property;
  SHARED __EE2174221 := __E_Person_Property;
  SHARED __EE2174443 := __EE2174221(__NN(__EE2174221.Subject_) AND __NN(__EE2174221.Prop_));
  SHARED __EE2174215 := __ENH_Person;
  SHARED __EE2174525 := __EE2174215(__T(__OP2(__EE2174215.UID,=,__CN(1))));
  __JC2174531(E_Person_Property(__in,__cfg_Local).Layout __EE2174443, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2174525) := __EEQP(__EE2174525.UID,__EE2174443.Subject_);
  SHARED __EE2174549 := JOIN(__EE2174443,__EE2174525,__JC2174531(LEFT,RIGHT),TRANSFORM(E_Person_Property(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2174555(B_Property(__in,__cfg_Local).__ST75600_Layout __EE2174232, E_Person_Property(__in,__cfg_Local).Layout __EE2174549) := __EEQP(__EE2174549.Prop_,__EE2174232.UID);
  SHARED __EE2174589 := JOIN(__EE2174232,__EE2174549,__JC2174555(LEFT,RIGHT),TRANSFORM(B_Property(__in,__cfg_Local).__ST75600_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2174591 := __EE2174589;
  EXPORT Res50 := __UNWRAP(__EE2174591);
  SHARED __EE2177012 := __E_Property_Event;
  SHARED __EE2177002 := __E_Person_Property_Event;
  SHARED __EE2177815 := __EE2177002(__NN(__EE2177002.Subject_) AND __NN(__EE2177002.Event_));
  SHARED __EE2176996 := __ENH_Person;
  SHARED __EE2178193 := __EE2176996(__T(__OP2(__EE2176996.UID,=,__CN(1))));
  __JC2178199(E_Person_Property_Event(__in,__cfg_Local).Layout __EE2177815, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2178193) := __EEQP(__EE2178193.UID,__EE2177815.Subject_);
  SHARED __EE2178219 := JOIN(__EE2177815,__EE2178193,__JC2178199(LEFT,RIGHT),TRANSFORM(E_Person_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2178225(E_Property_Event(__in,__cfg_Local).Layout __EE2177012, E_Person_Property_Event(__in,__cfg_Local).Layout __EE2178219) := __EEQP(__EE2178219.Event_,__EE2177012.UID);
  SHARED __EE2178553 := JOIN(__EE2177012,__EE2178219,__JC2178225(LEFT,RIGHT),TRANSFORM(E_Property_Event(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2178555 := __EE2178553;
  EXPORT Res51 := __UNWRAP(__EE2178555);
  SHARED __EE2181568 := __E_Social_Security_Number;
  SHARED __EE2181558 := __E_Person_S_S_N;
  SHARED __EE2181718 := __EE2181558(__NN(__EE2181558.Subject_) AND __NN(__EE2181558.Social_));
  SHARED __EE2181552 := __ENH_Person;
  SHARED __EE2181770 := __EE2181552(__T(__OP2(__EE2181552.UID,=,__CN(1))));
  __JC2181776(E_Person_S_S_N(__in,__cfg_Local).Layout __EE2181718, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2181770) := __EEQP(__EE2181770.UID,__EE2181718.Subject_);
  SHARED __EE2181784 := JOIN(__EE2181718,__EE2181770,__JC2181776(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2181790(E_Social_Security_Number(__in,__cfg_Local).Layout __EE2181568, E_Person_S_S_N(__in,__cfg_Local).Layout __EE2181784) := __EEQP(__EE2181784.Social_,__EE2181568.UID);
  SHARED __EE2181804 := JOIN(__EE2181568,__EE2181784,__JC2181790(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2181806 := __EE2181804;
  EXPORT Res52 := __UNWRAP(__EE2181806);
  SHARED __EE2184160 := __ENH_U_C_C;
  SHARED __EE2184149 := __E_Person_U_C_C;
  SHARED __EE2184354 := __EE2184149(__NN(__EE2184149.Subject_) AND __NN(__EE2184149.Filing_));
  SHARED __EE2184143 := __ENH_Person;
  SHARED __EE2184427 := __EE2184143(__T(__OP2(__EE2184143.UID,=,__CN(1))));
  __JC2184433(E_Person_U_C_C(__in,__cfg_Local).Layout __EE2184354, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2184427) := __EEQP(__EE2184427.UID,__EE2184354.Subject_);
  SHARED __EE2184445 := JOIN(__EE2184354,__EE2184427,__JC2184433(LEFT,RIGHT),TRANSFORM(E_Person_U_C_C(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2184451(B_U_C_C(__in,__cfg_Local).__ST76043_Layout __EE2184160, E_Person_U_C_C(__in,__cfg_Local).Layout __EE2184445) := __EEQP(__EE2184445.Filing_,__EE2184160.UID);
  SHARED __EE2184482 := JOIN(__EE2184160,__EE2184445,__JC2184451(LEFT,RIGHT),TRANSFORM(B_U_C_C(__in,__cfg_Local).__ST76043_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2184484 := __EE2184482;
  EXPORT Res53 := __UNWRAP(__EE2184484);
  SHARED __EE2186882 := __ENH_Vehicle;
  SHARED __EE2186871 := __E_Person_Vehicle;
  SHARED __EE2187300 := __EE2186871(__NN(__EE2186871.Subject_) AND __NN(__EE2186871.Automobile_));
  SHARED __EE2186865 := __ENH_Person;
  SHARED __EE2187485 := __EE2186865(__T(__OP2(__EE2186865.UID,=,__CN(1))));
  __JC2187491(E_Person_Vehicle(__in,__cfg_Local).Layout __EE2187300, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2187485) := __EEQP(__EE2187485.UID,__EE2187300.Subject_);
  SHARED __EE2187534 := JOIN(__EE2187300,__EE2187485,__JC2187491(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2187540(B_Vehicle(__in,__cfg_Local).__ST76190_Layout __EE2186882, E_Person_Vehicle(__in,__cfg_Local).Layout __EE2187534) := __EEQP(__EE2187534.Automobile_,__EE2186882.UID);
  SHARED __EE2187652 := JOIN(__EE2186882,__EE2187534,__JC2187540(LEFT,RIGHT),TRANSFORM(B_Vehicle(__in,__cfg_Local).__ST76190_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2187654 := __EE2187652;
  EXPORT Res54 := __UNWRAP(__EE2187654);
  SHARED __EE2190268 := __ENH_Professional_License;
  SHARED __EE2190257 := __E_Professional_License_Person;
  SHARED __EE2190483 := __EE2190257(__NN(__EE2190257.Subject_) AND __NN(__EE2190257.Prof_Lic_));
  SHARED __EE2190251 := __ENH_Person;
  SHARED __EE2190566 := __EE2190251(__T(__OP2(__EE2190251.UID,=,__CN(1))));
  __JC2190572(E_Professional_License_Person(__in,__cfg_Local).Layout __EE2190483, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2190566) := __EEQP(__EE2190566.UID,__EE2190483.Subject_);
  SHARED __EE2190579 := JOIN(__EE2190483,__EE2190566,__JC2190572(LEFT,RIGHT),TRANSFORM(E_Professional_License_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2190585(B_Professional_License_4(__in,__cfg_Local).__ST106103_Layout __EE2190268, E_Professional_License_Person(__in,__cfg_Local).Layout __EE2190579) := __EEQP(__EE2190579.Prof_Lic_,__EE2190268.UID);
  SHARED __EE2190631 := JOIN(__EE2190268,__EE2190579,__JC2190585(LEFT,RIGHT),TRANSFORM(B_Professional_License_4(__in,__cfg_Local).__ST106103_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2190633 := __EE2190631;
  EXPORT Res55 := __UNWRAP(__EE2190633);
  SHARED __EE2193043 := __ENH_Business_Prox;
  SHARED __EE2193032 := __E_Prox_Person;
  SHARED __EE2193744 := __EE2193032(__NN(__EE2193032.Contact_) AND __NN(__EE2193032.Business_Location_));
  SHARED __EE2193026 := __ENH_Person;
  SHARED __EE2194059 := __EE2193026(__T(__OP2(__EE2193026.UID,=,__CN(1))));
  __JC2194065(E_Prox_Person(__in,__cfg_Local).Layout __EE2193744, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2194059) := __EEQP(__EE2194059.UID,__EE2193744.Contact_);
  SHARED __EE2194092 := JOIN(__EE2193744,__EE2194059,__JC2194065(LEFT,RIGHT),TRANSFORM(E_Prox_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2194098(B_Business_Prox(__in,__cfg_Local).__ST57542_Layout __EE2193043, E_Prox_Person(__in,__cfg_Local).Layout __EE2194092) := __EEQP(__EE2194092.Business_Location_,__EE2193043.UID);
  SHARED __EE2194356 := JOIN(__EE2193043,__EE2194092,__JC2194098(LEFT,RIGHT),TRANSFORM(B_Business_Prox(__in,__cfg_Local).__ST57542_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2194358 := __EE2194356;
  EXPORT Res56 := __UNWRAP(__EE2194358);
  SHARED __EE2197239 := __ENH_Business_Sele;
  SHARED __EE2197228 := __E_Sele_Person;
  SHARED __EE2198943 := __EE2197228(__NN(__EE2197228.Contact_) AND __NN(__EE2197228.Legal_));
  SHARED __EE2197222 := __ENH_Person;
  SHARED __EE2199740 := __EE2197222(__T(__OP2(__EE2197222.UID,=,__CN(1))));
  __JC2199746(E_Sele_Person(__in,__cfg_Local).Layout __EE2198943, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2199740) := __EEQP(__EE2199740.UID,__EE2198943.Contact_);
  SHARED __EE2199773 := JOIN(__EE2198943,__EE2199740,__JC2199746(LEFT,RIGHT),TRANSFORM(E_Sele_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2199779(B_Business_Sele(__in,__cfg_Local).__ST65544_Layout __EE2197239, E_Sele_Person(__in,__cfg_Local).Layout __EE2199773) := __EEQP(__EE2199773.Legal_,__EE2197239.UID);
  SHARED __EE2200519 := JOIN(__EE2197239,__EE2199773,__JC2199779(LEFT,RIGHT),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST65544_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2200521 := __EE2200519;
  EXPORT Res57 := __UNWRAP(__EE2200521);
  SHARED __EE2206780 := __E_Utility;
  SHARED __EE2206770 := __E_Utility_Person;
  SHARED __EE2206921 := __EE2206770(__NN(__EE2206770.Subject_) AND __NN(__EE2206770.Util_));
  SHARED __EE2206764 := __ENH_Person;
  SHARED __EE2206969 := __EE2206764(__T(__OP2(__EE2206764.UID,=,__CN(1))));
  __JC2206975(E_Utility_Person(__in,__cfg_Local).Layout __EE2206921, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2206969) := __EEQP(__EE2206969.UID,__EE2206921.Subject_);
  SHARED __EE2206982 := JOIN(__EE2206921,__EE2206969,__JC2206975(LEFT,RIGHT),TRANSFORM(E_Utility_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2206988(E_Utility(__in,__cfg_Local).Layout __EE2206780, E_Utility_Person(__in,__cfg_Local).Layout __EE2206982) := __EEQP(__EE2206982.Util_,__EE2206780.UID);
  SHARED __EE2206999 := JOIN(__EE2206780,__EE2206982,__JC2206988(LEFT,RIGHT),TRANSFORM(E_Utility(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2207001 := __EE2206999;
  EXPORT Res58 := __UNWRAP(__EE2207001);
  SHARED __EE2209346 := __ENH_Watercraft;
  SHARED __EE2209335 := __E_Watercraft_Owner;
  SHARED __EE2209490 := __EE2209335(__NN(__EE2209335.Owner_) AND __NN(__EE2209335.W_Craft_));
  SHARED __EE2209329 := __ENH_Person;
  SHARED __EE2209539 := __EE2209329(__T(__OP2(__EE2209329.UID,=,__CN(1))));
  __JC2209545(E_Watercraft_Owner(__in,__cfg_Local).Layout __EE2209490, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2209539) := __EEQP(__EE2209539.UID,__EE2209490.Owner_);
  SHARED __EE2209552 := JOIN(__EE2209490,__EE2209539,__JC2209545(LEFT,RIGHT),TRANSFORM(E_Watercraft_Owner(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2209558(B_Watercraft(__in,__cfg_Local).__ST76314_Layout __EE2209346, E_Watercraft_Owner(__in,__cfg_Local).Layout __EE2209552) := __EEQP(__EE2209552.W_Craft_,__EE2209346.UID);
  SHARED __EE2209570 := JOIN(__EE2209346,__EE2209552,__JC2209558(LEFT,RIGHT),TRANSFORM(B_Watercraft(__in,__cfg_Local).__ST76314_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2209572 := __EE2209570;
  EXPORT Res59 := __UNWRAP(__EE2209572);
  SHARED __EE2211913 := __E_Zip_Code;
  SHARED __EE2211903 := __E_Zip_Code_Person;
  SHARED __EE2212056 := __EE2211903(__NN(__EE2211903.Subject_) AND __NN(__EE2211903.Zip_));
  SHARED __EE2211897 := __ENH_Person;
  SHARED __EE2212105 := __EE2211897(__T(__OP2(__EE2211897.UID,=,__CN(1))));
  __JC2212111(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE2212056, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2212105) := __EEQP(__EE2212105.UID,__EE2212056.Subject_);
  SHARED __EE2212119 := JOIN(__EE2212056,__EE2212105,__JC2212111(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2212125(E_Zip_Code(__in,__cfg_Local).Layout __EE2211913, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE2212119) := __EEQP(__EE2212119.Zip_,__EE2211913.UID);
  SHARED __EE2212136 := JOIN(__EE2211913,__EE2212119,__JC2212125(LEFT,RIGHT),TRANSFORM(E_Zip_Code(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2212138 := __EE2212136;
  EXPORT Res60 := __UNWRAP(__EE2212138);
  SHARED __EE2214475 := __E_Person_Email_Phone_Address;
  SHARED __EE2214560 := __EE2214475(__NN(__EE2214475.Subject_));
  SHARED __EE2214469 := __ENH_Person;
  SHARED __EE2214565 := __EE2214469(__T(__OP2(__EE2214469.UID,=,__CN(1))));
  __JC2214571(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout __EE2214560, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2214565) := __EEQP(__EE2214565.UID,__EE2214560.Subject_);
  SHARED __EE2214587 := JOIN(__EE2214560,__EE2214565,__JC2214571(LEFT,RIGHT),TRANSFORM(E_Person_Email_Phone_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2214589 := __EE2214587;
  EXPORT Res61 := __UNWRAP(__EE2214589);
  SHARED __EE2215914 := __E_Address;
  SHARED __EE2215904 := __E_Address_Phone;
  SHARED __EE2216335 := __EE2215904(__NN(__EE2215904.Phone_Number_) AND __NN(__EE2215904.Location_));
  SHARED __EE2215898 := __ENH_Phone;
  SHARED __EE2216511 := __EE2215898(__T(__OP2(__EE2215898.UID,=,__CN(1))));
  __JC2216517(E_Address_Phone(__in,__cfg_Local).Layout __EE2216335, B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2216511) := __EEQP(__EE2216511.UID,__EE2216335.Phone_Number_);
  SHARED __EE2216545 := JOIN(__EE2216335,__EE2216511,__JC2216517(LEFT,RIGHT),TRANSFORM(E_Address_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2216551(E_Address(__in,__cfg_Local).Layout __EE2215914, E_Address_Phone(__in,__cfg_Local).Layout __EE2216545) := __EEQP(__EE2216545.Location_,__EE2215914.UID);
  SHARED __EE2216669 := JOIN(__EE2215914,__EE2216545,__JC2216551(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2216671 := __EE2216669;
  EXPORT Res62 := __UNWRAP(__EE2216671);
  SHARED __EE2217027 := __ENH_Person;
  SHARED __EE2217016 := __E_Person_Phone;
  SHARED __EE2218197 := __EE2217016(__NN(__EE2217016.Phone_Number_) AND __NN(__EE2217016.Subject_));
  SHARED __EE2217010 := __ENH_Phone;
  SHARED __EE2218736 := __EE2217010(__T(__OP2(__EE2217010.UID,=,__CN(1))));
  __JC2218742(E_Person_Phone(__in,__cfg_Local).Layout __EE2218197, B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2218736) := __EEQP(__EE2218736.UID,__EE2218197.Phone_Number_);
  SHARED __EE2218776 := JOIN(__EE2218197,__EE2218736,__JC2218742(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2218782(B_Person(__in,__cfg_Local).__ST75136_Layout __EE2217027, E_Person_Phone(__in,__cfg_Local).Layout __EE2218776) := __EEQP(__EE2218776.Subject_,__EE2217027.UID);
  SHARED __EE2219257 := JOIN(__EE2217027,__EE2218776,__JC2218782(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2219259 := __EE2219257;
  EXPORT Res63 := __UNWRAP(__EE2219259);
  SHARED __EE2220573 := __ENH_Inquiry;
  SHARED __EE2220562 := __E_Phone_Inquiry;
  SHARED __EE2220736 := __EE2220562(__NN(__EE2220562.Phone_Number_) AND __NN(__EE2220562.Inquiry_));
  SHARED __EE2220556 := __ENH_Phone;
  SHARED __EE2220795 := __EE2220556(__T(__OP2(__EE2220556.UID,=,__CN(1))));
  __JC2220801(E_Phone_Inquiry(__in,__cfg_Local).Layout __EE2220736, B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2220795) := __EEQP(__EE2220795.UID,__EE2220736.Phone_Number_);
  SHARED __EE2220808 := JOIN(__EE2220736,__EE2220795,__JC2220801(LEFT,RIGHT),TRANSFORM(E_Phone_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2220814(B_Inquiry(__in,__cfg_Local).__ST71132_Layout __EE2220573, E_Phone_Inquiry(__in,__cfg_Local).Layout __EE2220808) := __EEQP(__EE2220808.Inquiry_,__EE2220573.UID);
  SHARED __EE2220836 := JOIN(__EE2220573,__EE2220808,__JC2220814(LEFT,RIGHT),TRANSFORM(B_Inquiry(__in,__cfg_Local).__ST71132_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2220838 := __EE2220836;
  EXPORT Res64 := __UNWRAP(__EE2220838);
  SHARED __EE2220954 := __E_T_I_N_Phone_Number;
  SHARED __EE2221108 := __EE2220954(__NN(__EE2220954.Tax_I_D_) AND __NN(__EE2220954.Phone_Number_));
  SHARED __EE2220948 := __ENH_Phone;
  SHARED __EE2221150 := __EE2220948(__T(__OP2(__EE2220948.UID,=,__CN(1))));
  __JC2221156(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE2221108, B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2221150) := __EEQP(__EE2221150.UID,__EE2221108.Phone_Number_);
  SHARED __EE2221166 := JOIN(__EE2221108,__EE2221150,__JC2221156(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2221176 := PROJECT(TABLE(PROJECT(__EE2221166,TRANSFORM(E_T_I_N(__in,__cfg_Local).Layout,SELF.UID := LEFT.Tax_I_D_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),UID},UID,MERGE),E_T_I_N(__in,__cfg_Local).Layout);
  EXPORT Res65 := __UNWRAP(__EE2221176);
  SHARED __EE2221238 := __ENH_Second_Degree_Associations;
  SHARED __EE2221314 := __EE2221238(__NN(__EE2221238.First_Degree_Association_));
  SHARED __EE2221231 := __ENH_Person;
  SHARED __EE2221319 := __EE2221231(__T(__OP2(__EE2221231.UID,=,__CN(1))));
  __JC2221325(E_Second_Degree_Associations(__in,__cfg_Local).Layout __EE2221314, B_Person(__in,__cfg_Local).__ST75136_Layout __EE2221319) := __EEQP(__EE2221319.UID,__EE2221314.First_Degree_Association_);
  SHARED __EE2221337 := JOIN(__EE2221314,__EE2221319,__JC2221325(LEFT,RIGHT),TRANSFORM(E_Second_Degree_Associations(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2221339 := __EE2221337;
  EXPORT Res66 := __UNWRAP(__EE2221339);
  SHARED __EE2222675 := __ENH_Person;
  SHARED __EE2222664 := __E_Person_S_S_N;
  SHARED __EE2223790 := __EE2222664(__NN(__EE2222664.Social_) AND __NN(__EE2222664.Subject_));
  SHARED __EE2222658 := __E_Social_Security_Number;
  SHARED __EE2224303 := __EE2222658(__T(__OP2(__EE2222658.UID,=,__CN(1))));
  __JC2224309(E_Person_S_S_N(__in,__cfg_Local).Layout __EE2223790, E_Social_Security_Number(__in,__cfg_Local).Layout __EE2224303) := __EEQP(__EE2224303.UID,__EE2223790.Social_);
  SHARED __EE2224317 := JOIN(__EE2223790,__EE2224303,__JC2224309(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2224323(B_Person(__in,__cfg_Local).__ST75136_Layout __EE2222675, E_Person_S_S_N(__in,__cfg_Local).Layout __EE2224317) := __EEQP(__EE2224317.Subject_,__EE2222675.UID);
  SHARED __EE2224798 := JOIN(__EE2222675,__EE2224317,__JC2224323(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2224800 := __EE2224798;
  EXPORT Res67 := __UNWRAP(__EE2224800);
  SHARED __EE2226060 := __E_Address;
  SHARED __EE2226050 := __E_S_S_N_Address;
  SHARED __EE2226453 := __EE2226050(__NN(__EE2226050.Social_) AND __NN(__EE2226050.Location_));
  SHARED __EE2226044 := __E_Social_Security_Number;
  SHARED __EE2226616 := __EE2226044(__T(__OP2(__EE2226044.UID,=,__CN(1))));
  __JC2226622(E_S_S_N_Address(__in,__cfg_Local).Layout __EE2226453, E_Social_Security_Number(__in,__cfg_Local).Layout __EE2226616) := __EEQP(__EE2226616.UID,__EE2226453.Social_);
  SHARED __EE2226637 := JOIN(__EE2226453,__EE2226616,__JC2226622(LEFT,RIGHT),TRANSFORM(E_S_S_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2226643(E_Address(__in,__cfg_Local).Layout __EE2226060, E_S_S_N_Address(__in,__cfg_Local).Layout __EE2226637) := __EEQP(__EE2226637.Location_,__EE2226060.UID);
  SHARED __EE2226761 := JOIN(__EE2226060,__EE2226637,__JC2226643(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2226763 := __EE2226761;
  EXPORT Res68 := __UNWRAP(__EE2226763);
  SHARED __EE2227105 := __ENH_Inquiry;
  SHARED __EE2227094 := __E_S_S_N_Inquiry;
  SHARED __EE2227268 := __EE2227094(__NN(__EE2227094.S_S_N_) AND __NN(__EE2227094.Inquiry_));
  SHARED __EE2227088 := __E_Social_Security_Number;
  SHARED __EE2227327 := __EE2227088(__T(__OP2(__EE2227088.UID,=,__CN(1))));
  __JC2227333(E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE2227268, E_Social_Security_Number(__in,__cfg_Local).Layout __EE2227327) := __EEQP(__EE2227327.UID,__EE2227268.S_S_N_);
  SHARED __EE2227340 := JOIN(__EE2227268,__EE2227327,__JC2227333(LEFT,RIGHT),TRANSFORM(E_S_S_N_Inquiry(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2227346(B_Inquiry(__in,__cfg_Local).__ST71132_Layout __EE2227105, E_S_S_N_Inquiry(__in,__cfg_Local).Layout __EE2227340) := __EEQP(__EE2227340.Inquiry_,__EE2227105.UID);
  SHARED __EE2227368 := JOIN(__EE2227105,__EE2227340,__JC2227346(LEFT,RIGHT),TRANSFORM(B_Inquiry(__in,__cfg_Local).__ST71132_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2227370 := __EE2227368;
  EXPORT Res69 := __UNWRAP(__EE2227370);
  SHARED __EE2227495 := __E_Address;
  SHARED __EE2227485 := __E_T_I_N_Address;
  SHARED __EE2227886 := __EE2227485(__NN(__EE2227485.Tax_I_D_) AND __NN(__EE2227485.Location_));
  SHARED __EE2227479 := __E_T_I_N;
  SHARED __EE2228048 := __EE2227479(__T(__OP2(__EE2227479.UID,=,__CN(1))));
  __JC2228054(E_T_I_N_Address(__in,__cfg_Local).Layout __EE2227886, E_T_I_N(__in,__cfg_Local).Layout __EE2228048) := __EEQP(__EE2228048.UID,__EE2227886.Tax_I_D_);
  SHARED __EE2228068 := JOIN(__EE2227886,__EE2228048,__JC2228054(LEFT,RIGHT),TRANSFORM(E_T_I_N_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2228074(E_Address(__in,__cfg_Local).Layout __EE2227495, E_T_I_N_Address(__in,__cfg_Local).Layout __EE2228068) := __EEQP(__EE2228068.Location_,__EE2227495.UID);
  SHARED __EE2228192 := JOIN(__EE2227495,__EE2228068,__JC2228074(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2228194 := __EE2228192;
  EXPORT Res70 := __UNWRAP(__EE2228194);
  SHARED __EE2228521 := __ENH_Phone;
  SHARED __EE2228510 := __E_T_I_N_Phone_Number;
  SHARED __EE2228762 := __EE2228510(__NN(__EE2228510.Tax_I_D_) AND __NN(__EE2228510.Phone_Number_));
  SHARED __EE2228504 := __E_T_I_N;
  SHARED __EE2228856 := __EE2228504(__T(__OP2(__EE2228504.UID,=,__CN(1))));
  __JC2228862(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE2228762, E_T_I_N(__in,__cfg_Local).Layout __EE2228856) := __EEQP(__EE2228856.UID,__EE2228762.Tax_I_D_);
  SHARED __EE2228872 := JOIN(__EE2228762,__EE2228856,__JC2228862(LEFT,RIGHT),TRANSFORM(E_T_I_N_Phone_Number(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2228878(B_Phone(__in,__cfg_Local).__ST75420_Layout __EE2228521, E_T_I_N_Phone_Number(__in,__cfg_Local).Layout __EE2228872) := __EEQP(__EE2228872.Phone_Number_,__EE2228521.UID);
  SHARED __EE2228932 := JOIN(__EE2228521,__EE2228872,__JC2228878(LEFT,RIGHT),TRANSFORM(B_Phone(__in,__cfg_Local).__ST75420_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __EE2228934 := __EE2228932;
  EXPORT Res71 := __UNWRAP(__EE2228934);
  SHARED __EE2229125 := __ENH_Person;
  SHARED __EE2229114 := __E_Zip_Code_Person;
  SHARED __EE2230240 := __EE2229114(__NN(__EE2229114.Zip_) AND __NN(__EE2229114.Subject_));
  SHARED __EE2229108 := __E_Zip_Code;
  SHARED __EE2230753 := __EE2229108(__T(__OP2(__EE2229108.UID,=,__CN(1))));
  __JC2230759(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE2230240, E_Zip_Code(__in,__cfg_Local).Layout __EE2230753) := __EEQP(__EE2230753.UID,__EE2230240.Zip_);
  SHARED __EE2230767 := JOIN(__EE2230240,__EE2230753,__JC2230759(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  __JC2230773(B_Person(__in,__cfg_Local).__ST75136_Layout __EE2229125, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE2230767) := __EEQP(__EE2230767.Subject_,__EE2229125.UID);
  SHARED __EE2231248 := JOIN(__EE2229125,__EE2230767,__JC2230773(LEFT,RIGHT),TRANSFORM(B_Person(__in,__cfg_Local).__ST75136_Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  EXPORT Res72 := __UNWRAP(__EE2231248);
END;
