//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Aircraft_Owner_3,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Business_Prox_2,B_Business_Prox_3,B_Business_Prox_4,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_10,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Business_Sele_7,B_Business_Sele_8,B_Business_Sele_9,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Lien_Judgment_11,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_Vehicle_3,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Sele_Lien_Judgment_11,B_Sele_Person_2,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_U_C_C_2,B_Sele_U_C_C_3,B_Sele_U_C_C_4,B_Sele_U_C_C_5,B_Sele_U_C_C_6,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Tradeline_1,B_Tradeline_10,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_U_C_C_2,B_U_C_C_3,B_U_C_C_4,B_U_C_C_5,B_U_C_C_6,B_U_C_C_7,B_Watercraft_Owner_3,CFG_Compile,E_Address,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Offense,E_Geo_Link,E_Lien_Judgment,E_Person,E_Person_Address,E_Person_Bankruptcy,E_Person_Education,E_Person_Email,E_Person_Offenses,E_Person_Vehicle,E_Phone,E_Professional_License,E_Professional_License_Person,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_Sele_Address,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_Lien_Judgment,E_Sele_Person,E_Sele_Phone_Number,E_Sele_T_I_N,E_Sele_Tradeline,E_Sele_U_C_C,E_Sele_Vehicle,E_Sele_Watercraft,E_T_I_N,E_Tradeline,E_U_C_C,E_Vehicle,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)) __PInputBIIDataset, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Business_Sele_Filtered_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Prox_Sele_,RIGHT.UID),TRANSFORM({KEL.typ.nuid UID},SELF:=LEFT,SELF:=RIGHT),HASH,KEEP(1)),__EEQP(LEFT.UID,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Lien_Judgment_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Sele_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Tradeline_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_U_C_C_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Vehicle_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Aircraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Lien_Judgment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Lien_Judgment_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Lien_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Email_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.License_Number_,<>,__CN('')))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(HAVING(__ds,__GroupTest(ROWS(LEFT))),E_Professional_License_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Sele_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_3(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Tradeline_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_U_C_C_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_U_C_C_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Filing_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Vina_Price_,>,__CN(0)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(HAVING(__ds,__GroupTest(ROWS(LEFT))),E_Sele_Vehicle_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Automobile_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.Contact_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered := E_Business_Prox_Filtered_1;
  SHARED E_Business_Sele_Filtered := E_Business_Sele_Filtered_3;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Professional_License_Person_Filtered := E_Professional_License_Person_Filtered_1;
  SHARED E_Sele_Bankruptcy_Filtered := E_Sele_Bankruptcy_Filtered_1;
  SHARED E_Sele_Lien_Judgment_Filtered := E_Sele_Lien_Judgment_Filtered_1;
  SHARED E_Sele_Person_Filtered := E_Sele_Person_Filtered_2;
  SHARED E_Sele_Tradeline_Filtered := E_Sele_Tradeline_Filtered_1;
  SHARED E_Sele_U_C_C_Filtered := E_Sele_U_C_C_Filtered_1;
  SHARED E_Sele_Vehicle_Filtered := E_Sele_Vehicle_Filtered_1;
  SHARED B_Lien_Judgment_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Lien_Judgment_11(__in,__cfg))
    SHARED TYPEOF(E_Lien_Judgment(__in,__cfg).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Lien_Judgment_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Lien_Judgment_11(__in,__cfg))
    SHARED TYPEOF(E_Sele_Lien_Judgment(__in,__cfg).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_10(__in,__cfg))
    SHARED TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Lien_Judgment_11(__in,__cfg).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local(__in,__cfg).__ENH_Lien_Judgment_11;
    SHARED TYPEOF(B_Sele_Lien_Judgment_11(__in,__cfg).__ENH_Sele_Lien_Judgment_11) __ENH_Sele_Lien_Judgment_11 := B_Sele_Lien_Judgment_11_Local(__in,__cfg).__ENH_Sele_Lien_Judgment_11;
  END;
  SHARED B_Tradeline_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_10(__in,__cfg))
    SHARED TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_9(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_10(__in,__cfg).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10_Local(__in,__cfg).__ENH_Business_Sele_10;
  END;
  SHARED B_Tradeline_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_9(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local(__in,__cfg).__ENH_Tradeline_10;
  END;
  SHARED B_Bankruptcy_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_8(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_8(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9_Local(__in,__cfg).__ENH_Business_Sele_9;
  END;
  SHARED B_Tradeline_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_8(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local(__in,__cfg).__ENH_Tradeline_9;
  END;
  SHARED B_Bankruptcy_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_7(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local(__in,__cfg).__ENH_Bankruptcy_8;
  END;
  SHARED B_Business_Sele_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_7(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_8(__in,__cfg).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8_Local(__in,__cfg).__ENH_Business_Sele_8;
  END;
  SHARED B_Person_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_7(__in,__cfg))
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_7(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local(__in,__cfg).__ENH_Tradeline_8;
  END;
  SHARED B_U_C_C_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_7(__in,__cfg))
    SHARED TYPEOF(E_U_C_C(__in,__cfg).__Result) __E_U_C_C := E_U_C_C_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_6(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local(__in,__cfg).__ENH_Bankruptcy_7;
  END;
  SHARED B_Business_Sele_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_6(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7_Local(__in,__cfg).__ENH_Business_Sele_7;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Person_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_6(__in,__cfg))
    SHARED TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local(__in,__cfg).__ENH_Person_7;
  END;
  SHARED B_Sele_Person_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_6(__in,__cfg))
    SHARED TYPEOF(E_Sele_Person(__in,__cfg).__Result) __E_Sele_Person := E_Sele_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_U_C_C_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_6(__in,__cfg))
    SHARED TYPEOF(E_Sele_U_C_C(__in,__cfg).__Result) __E_Sele_U_C_C := E_Sele_U_C_C_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_U_C_C_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_6(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_7(__in,__cfg).__ENH_U_C_C_7) __ENH_U_C_C_7 := B_U_C_C_7_Local(__in,__cfg).__ENH_U_C_C_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_5(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local(__in,__cfg).__ENH_Business_Sele_6;
  END;
  SHARED B_Person_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_5(__in,__cfg))
    SHARED TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local(__in,__cfg).__ENH_Person_6;
  END;
  SHARED B_Professional_License_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_5(__in,__cfg))
    SHARED TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Sele_Person_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_5(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_6(__in,__cfg).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local(__in,__cfg).__ENH_Sele_Person_6;
  END;
  SHARED B_Sele_U_C_C_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_5(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_6(__in,__cfg).__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6_Local(__in,__cfg).__ENH_Sele_U_C_C_6;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_U_C_C_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_5(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_6(__in,__cfg).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6_Local(__in,__cfg).__ENH_U_C_C_6;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Business_Prox_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_4(__in,__cfg))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Sele_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local(__in,__cfg).__ENH_Business_Sele_5;
    SHARED TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local(__in,__cfg).__ENH_Sele_U_C_C_5;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local(__in,__cfg).__ENH_U_C_C_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_4(__in,__cfg))
    SHARED TYPEOF(B_Person_5(__in,__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local(__in,__cfg).__ENH_Person_5;
  END;
  SHARED B_Professional_License_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_4(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local(__in,__cfg).__ENH_Professional_License_5;
  END;
  SHARED B_Sele_Person_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_4(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local(__in,__cfg).__ENH_Sele_Person_5;
  END;
  SHARED B_Sele_U_C_C_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_4(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_5(__in,__cfg).__ENH_Sele_U_C_C_5) __ENH_Sele_U_C_C_5 := B_Sele_U_C_C_5_Local(__in,__cfg).__ENH_Sele_U_C_C_5;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_U_C_C_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_4(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_5(__in,__cfg).__ENH_U_C_C_5) __ENH_U_C_C_5 := B_U_C_C_5_Local(__in,__cfg).__ENH_U_C_C_5;
  END;
  SHARED B_Aircraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
  END;
  SHARED B_Business_Prox_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_4(__in,__cfg).__ENH_Business_Prox_4) __ENH_Business_Prox_4 := B_Business_Prox_4_Local(__in,__cfg).__ENH_Business_Prox_4;
  END;
  SHARED B_Business_Sele_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local(__in,__cfg).__ENH_Business_Sele_4;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local(__in,__cfg).__ENH_Sele_Person_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local(__in,__cfg).__ENH_Sele_U_C_C_4;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local(__in,__cfg).__ENH_U_C_C_4;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
  END;
  SHARED B_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local(__in,__cfg).__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Professional_License_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_3(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
  END;
  SHARED B_Sele_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local(__in,__cfg).__ENH_Sele_Person_4;
  END;
  SHARED B_Sele_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Sele_U_C_C_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_3(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_4(__in,__cfg).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4_Local(__in,__cfg).__ENH_Sele_U_C_C_4;
  END;
  SHARED B_Sele_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(E_Sele_Vehicle(__in,__cfg).__Result) __E_Sele_Vehicle := E_Sele_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_U_C_C_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_3(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_4(__in,__cfg).__ENH_U_C_C_4) __ENH_U_C_C_4 := B_U_C_C_4_Local(__in,__cfg).__ENH_U_C_C_4;
  END;
  SHARED B_Watercraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg).__Result;
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
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local(__in,__cfg).__ENH_Business_Prox_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local(__in,__cfg).__ENH_Business_Sele_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local(__in,__cfg).__ENH_Sele_Person_3;
    SHARED TYPEOF(E_Sele_Phone_Number(__in,__cfg).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_T_I_N(__in,__cfg).__Result) __E_Sele_T_I_N := E_Sele_T_I_N_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local(__in,__cfg).__ENH_Person_3;
    SHARED TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Sele_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local(__in,__cfg).__ENH_Sele_Person_3;
  END;
  SHARED B_Sele_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Sele_U_C_C_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_U_C_C_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_U_C_C_3(__in,__cfg).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3_Local(__in,__cfg).__ENH_Sele_U_C_C_3;
  END;
  SHARED B_Sele_Vehicle_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
  END;
  SHARED B_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_U_C_C_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_U_C_C_2(__in,__cfg))
    SHARED TYPEOF(B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3_Local(__in,__cfg).__ENH_U_C_C_3;
  END;
  SHARED B_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
  END;
  SHARED B_Business_Sele_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local(__in,__cfg).__ENH_Business_Prox_2;
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local(__in,__cfg).__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Education(__in,__cfg).__Result) __E_Person_Education := E_Person_Education_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Email(__in,__cfg).__Result) __E_Person_Email := E_Person_Email_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Person_2(__in,__cfg).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2_Local(__in,__cfg).__ENH_Sele_Person_2;
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Sele_U_C_C_2(__in,__cfg).__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2_Local(__in,__cfg).__ENH_Sele_U_C_C_2;
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local(__in,__cfg).__ENH_Sele_Vehicle_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
    SHARED TYPEOF(B_U_C_C_2(__in,__cfg).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2_Local(__in,__cfg).__ENH_U_C_C_2;
  END;
  SHARED B_Sele_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Sele_Vehicle_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Vehicle_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Vehicle_2(__in,__cfg).__ENH_Sele_Vehicle_2) __ENH_Sele_Vehicle_2 := B_Sele_Vehicle_2_Local(__in,__cfg).__ENH_Sele_Vehicle_2;
  END;
  SHARED B_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Business_Sele_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Business_Sele_1(__in,__cfg).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local(__in,__cfg).__ENH_Business_Sele_1;
    SHARED TYPEOF(E_Sele_Aircraft(__in,__cfg).__Result) __E_Sele_Aircraft := E_Sele_Aircraft_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_1(__in,__cfg).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local(__in,__cfg).__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Sele_Vehicle_1(__in,__cfg).__ENH_Sele_Vehicle_1) __ENH_Sele_Vehicle_1 := B_Sele_Vehicle_1_Local(__in,__cfg).__ENH_Sele_Vehicle_1;
    SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
    SHARED TYPEOF(E_Vehicle(__in,__cfg).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local(__in,__cfg_Local).__ENH_Business_Sele;
  SHARED __EE2706803 := __ENH_Business_Sele;
  SHARED __EE2712282 := __EE2706803(__T(__AND(__OP2(__EE2706803.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE2706803.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE2706803.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST69867_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.str B___Lex_I_D_Legal_Seen_Flag_ := '';
    KEL.typ.nstr B_E___Ver_Src_List_Ev_;
    KEL.typ.nint B_E___Ver_Src_Cnt_Ev_;
    KEL.typ.nstr B_E___Ver_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr B_E___Ver_Src_Old_Dt_Ev_;
    KEL.typ.nstr B_E___Ver_Src_New_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Src_Old_Msnc_Ev_;
    KEL.typ.nint B_E___Ver_Src_New_Msnc_Ev_;
    KEL.typ.str B_E___Ver_Src_Rpt_New_Bus_Flag_ := '';
    KEL.typ.nint B_E___Ver_Src_Cred_Cnt_Ev_;
    KEL.typ.str B_E___Ver_Src_Bureau_Flag_ := '';
    KEL.typ.nstr B_E___Ver_Src_Bureau_Old_Dt_Ev_;
    KEL.typ.nint B_E___Ver_Src_Bureau_Old_Msnc_Ev_;
    KEL.typ.nint B_E___B2_B_Cnt_Ev_;
    KEL.typ.int B_E___B2_B_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt2_Y_ := 0;
    KEL.typ.float B_E___B2_B_Carr_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Flt_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Mat_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Ops_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Oth_Pct2_Y_ := 0.0;
    KEL.typ.nstr B_E___B2_B_Old_Dt_Ev_;
    KEL.typ.nint B_E___B2_B_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___B2_B_Old_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_New_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Old_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_New_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Actv_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Pct_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_;
    KEL.typ.int B_E___B2_B_Actv_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Bal_Max_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max_Msnc2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Seg_Type2_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Worst_Perf_Indx_;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.str B_E___B2_B_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Carr_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Flt_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Mat_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Ops_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Oth_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.nstr B_E___B2_B_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Worst_Perf_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_ := 0;
    KEL.typ.str B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.nint B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Carr_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Flt_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Mat_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Ops_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Oth_Bal_Vol24_Mc_;
    KEL.typ.int B_E___Ast_Veh_Air_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Ast_Veh_Wtr_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Pers_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Comm_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Other_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Ast_Veh_Auto_Val_Tot2_Y_ := 0;
    KEL.typ.nint B_E___Ast_Veh_Auto_Emrg_New_Msnc_Ev_;
    KEL.typ.nstr B_E___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.int B_E___Drg_Bk_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Bk_Old_Dt10_Y_;
    KEL.typ.nint B_E___Drg_Bk_Old_Msnc10_Y_;
    KEL.typ.nstr B_E___Drg_Bk_New_Dt10_Y_;
    KEL.typ.nint B_E___Drg_Bk_New_Msnc10_Y_;
    KEL.typ.nstr B_E___Drg_Bk_Updt_New_Dt10_Y_;
    KEL.typ.nstr B_E___Drg_Bk_Updt_New_Msnc10_Y_;
    KEL.typ.int B_E___Drg_Bk_Disp_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Dsch_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Dsms_Cnt10_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Bk_New_Disp_Type10_Y_;
    KEL.typ.int B_E___Drg_Bk_Ch7_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Ch11_Cnt10_Y_ := 0;
    KEL.typ.int B_E___Drg_Bk_Ch13_Cnt10_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Bk_New_Ch_Type10_Y_;
    KEL.typ.int B_E___S_O_S_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___S_O_S_New_Dt_Ev_;
    KEL.typ.nstr B_E___S_O_S_Old_Dt_Ev_;
    KEL.typ.nint B_E___S_O_S_New_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_Old_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_State_Cnt_Ev_;
    KEL.typ.int B_E___S_O_S_Dom_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___S_O_S_Dom_New_Dt_Ev_;
    KEL.typ.nstr B_E___S_O_S_Dom_Old_Dt_Ev_;
    KEL.typ.nint B_E___S_O_S_Dom_New_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_Dom_Old_Msnc_Ev_;
    KEL.typ.int B_E___S_O_S_Frgn_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___S_O_S_Frgn_New_Dt_Ev_;
    KEL.typ.nstr B_E___S_O_S_Frgn_Old_Dt_Ev_;
    KEL.typ.nint B_E___S_O_S_Frgn_New_Msnc_Ev_;
    KEL.typ.nint B_E___S_O_S_Frgn_Old_Msnc_Ev_;
    KEL.typ.int B_E___S_O_S_Dom_Status_Indx_Ev_ := 0;
    KEL.typ.nstr B_E___Best_Name_;
    KEL.typ.nint B_E___Best_Addr_Loc_I_D_;
    KEL.typ.nstr B_E___Best_Addr_St_;
    KEL.typ.nstr B_E___Best_Addr_City_;
    KEL.typ.nstr B_E___Best_Addr_City_Post_;
    KEL.typ.nstr B_E___Best_Addr_State_;
    KEL.typ.nstr B_E___Best_Addr_Zip_;
    KEL.typ.nstr B_E___Best_T_I_N_;
    KEL.typ.nstr B_E___Best_Phone_;
    KEL.typ.nstr B_E___Drg_Gov_Debarred_Flag_Ev_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code1_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code1_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code1_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_S_I_C_Code2_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code2_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code2_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_S_I_C_Code3_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code3_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code3_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_S_I_C_Code4_;
    KEL.typ.nstr B_E___Bus_S_I_C_Code4_Desc_;
    KEL.typ.str B_E___Bus_S_I_C_Code4_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code1_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code1_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code1_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code2_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code2_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code2_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code3_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code3_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code3_Group_Desc_ := '';
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code4_;
    KEL.typ.nstr B_E___Bus_N_A_I_C_S_Code4_Desc_;
    KEL.typ.str B_E___Bus_N_A_I_C_S_Code4_Group_Desc_ := '';
    KEL.typ.nint B_E___Bus_Empl_Count_Curr_;
    KEL.typ.int B_E___Bus_Empl_Count_Curr_Rnge_ := 0;
    KEL.typ.nint B_E___Bus_Annual_Sales_Curr_;
    KEL.typ.str B_E___Bus_Annual_Sales_Curr_Rnge_ := '';
    KEL.typ.str B_E___Bus_Is_Non_Profit_Flag_ := '';
    KEL.typ.str B_E___Bus_Is_Franchise_Flag_ := '';
    KEL.typ.str B_E___Bus_Offers401k_Flag_ := '';
    KEL.typ.str B_E___Bus_Has_New_Location_Flag1_Y_ := '';
    KEL.typ.int B_E___Bus_Loc_Actv_Cnt_ := 0;
    KEL.typ.str B_E___Bus_Is_S_B_E_Flag_ := '';
    KEL.typ.int B_E___Drg_L_T_D_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_L_T_D_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_L_T_D_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_L_T_D_New_Dt7_Y_;
    KEL.typ.nstr B_E___Drg_L_T_D_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_L_T_D_New_Msnc7_Y_;
    KEL.typ.nint B_E___Drg_L_T_D_Old_Msnc7_Y_;
    KEL.typ.int B_E___U_C_C_Cnt_Ev_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___U_C_C_Debtor_Old_Dt_Ev_;
    KEL.typ.nint B_E___U_C_C_Debtor_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___U_C_C_Debtor_New_Dt_Ev_;
    KEL.typ.nint B_E___U_C_C_Debtor_New_Msnc_Ev_;
    KEL.typ.int B_E___U_C_C_Actv_Cnt_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Actv_Cnt_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Term_Cnt_Ev_ := 0;
    KEL.typ.int B_E___U_C_C_Debtor_Other_Cnt_Ev_ := 0;
    KEL.typ.float B_E___U_C_C_Debtor_Actv_Pct_ := 0.0;
    KEL.typ.float B_E___U_C_C_Debtor_Term_Pct_Ev_ := 0.0;
    KEL.typ.float B_E___U_C_C_Debtor_Other_Pct_Ev_ := 0.0;
    KEL.typ.nstr B_E___U_C_C_Debtor_Term_New_Dt_Ev_;
    KEL.typ.nint B_E___U_C_C_Debtor_Term_New_Msnc_Ev_;
    KEL.typ.int B_E___U_C_C_Creditor_Cnt_Ev_ := 0;
    KEL.typ.nstr B_E___U_C_C_Role_Indx_Ev_;
    KEL.typ.nstr B_E___U_C_C_Actv_Role_Indx_;
    KEL.typ.int B_E___Drg_Lien_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_Lien_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_Lien_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_Fed_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_Fed_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Fed_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Fed_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Fed_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Fed_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_State_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_State_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_State_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_State_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_State_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_State_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Tax_Other_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Tax_Other_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Other_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Other_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Tax_Other_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Tax_Other_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Lien_Other_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Lien_Other_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Lien_Other_New_Dt7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_Other_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Other_New_Msnc7_Y_;
    KEL.typ.nint B_E___Drg_Lien_Other_Old_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_Judg_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_Judg_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Civ_Crt_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Civ_Crt_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Judg_Civ_Crt_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Civ_Crt_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_Civ_Crt_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Civ_Crt_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Sm_Claim_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Sm_Claim_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Judg_Sm_Claim_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Sm_Claim_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_Sm_Claim_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Sm_Claim_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Judg_Frcl_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Judg_Frcl_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Judg_Frcl_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Frcl_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_Frcl_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Judg_Frcl_New_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Ln_J_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Ln_J_Amt_Tot7_Y_ := 0;
    KEL.typ.float B_E___Drg_Ln_J_Amt_Avg7_Y_ := 0.0;
    KEL.typ.nstr B_E___Drg_Ln_J_New_Dt7_Y_;
    KEL.typ.nstr B_E___Drg_Ln_J_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Ln_J_New_Msnc7_Y_;
    KEL.typ.nint B_E___Drg_Ln_J_Old_Msnc7_Y_;
    KEL.typ.int B_E___Drg_Suit_Cnt7_Y_ := 0;
    KEL.typ.int B_E___Drg_Suit_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Suit_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Suit_Old_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Suit_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Suit_New_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Judg_New_Type7_Y_;
    KEL.typ.nstr B_E___Drg_Lien_New_Type7_Y_;
    KEL.typ.int B_E___Drg_Cnt1_Y_ := 0;
    KEL.typ.int B_E___Drg_Cnt7_Y_ := 0;
    KEL.typ.nstr B_E___Drg_Flag7_Y_;
    KEL.typ.nstr B_E___Drg_New_Dt7_Y_;
    KEL.typ.nint B_E___Drg_New_Msnc7_Y_;
    KEL.typ.nstr B_E___Drg_Old_Dt7_Y_;
    KEL.typ.nint B_E___Drg_Old_Msnc7_Y_;
    KEL.typ.int B_E___Assoc_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Assoc_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Pct2_Y_ := 0.0;
    KEL.typ.int B_E___Assoc_Exec_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Assoc_Exec_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Exec_Pct2_Y_ := 0.0;
    KEL.typ.int B_E___Assoc_Nexec_Cnt_Ev_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_Cnt2_Y_ := 0;
    KEL.typ.float B_E___Assoc_Nexec_Pct2_Y_ := 0.0;
    KEL.typ.str B_E___Assoc_Email_Flag2_Y_ := '';
    KEL.typ.str B_E___Assoc_Exec_Email_Flag2_Y_ := '';
    KEL.typ.str B_E___Assoc_Nexec_Email_Flag2_Y_ := '';
    KEL.typ.nint B_E___Assoc_Age_Avg2_Y_;
    KEL.typ.nint B_E___Assoc_Exec_Age_Avg2_Y_;
    KEL.typ.nint B_E___Assoc_Nexec_Age_Avg2_Y_;
    KEL.typ.int B_E___Assoc_W_Edu_Coll_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Edu_Coll_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Edu_Coll_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Crim_Fel_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Crim_Fel_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Crim_Fel_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Crim_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Crim_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Crim_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_W_Drg_Bk_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Exec_W_Drg_Bk_Cnt2_Y_ := 0;
    KEL.typ.int B_E___Assoc_Nexec_W_Drg_Bk_Cnt2_Y_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST69867_Layout __ND2712287__Project(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __PP2712283) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP2712283.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP2712283.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP2712283.Sele_I_D_;
    SELF := __PP2712283;
  END;
  SHARED __EE2713960 := PROJECT(TABLE(PROJECT(__EE2712282,__ND2712287__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Seen_Flag_,B_E___Ver_Src_List_Ev_,B_E___Ver_Src_Cnt_Ev_,B_E___Ver_Src_Emrg_Dt_List_Ev_,B_E___Ver_Src_Last_Dt_List_Ev_,B_E___Ver_Src_Old_Dt_Ev_,B_E___Ver_Src_New_Dt_Ev_,B_E___Ver_Src_Old_Msnc_Ev_,B_E___Ver_Src_New_Msnc_Ev_,B_E___Ver_Src_Rpt_New_Bus_Flag_,B_E___Ver_Src_Cred_Cnt_Ev_,B_E___Ver_Src_Bureau_Flag_,B_E___Ver_Src_Bureau_Old_Dt_Ev_,B_E___Ver_Src_Bureau_Old_Msnc_Ev_,B_E___B2_B_Cnt_Ev_,B_E___B2_B_Cnt2_Y_,B_E___B2_B_Carr_Cnt2_Y_,B_E___B2_B_Flt_Cnt2_Y_,B_E___B2_B_Mat_Cnt2_Y_,B_E___B2_B_Ops_Cnt2_Y_,B_E___B2_B_Oth_Cnt2_Y_,B_E___B2_B_Carr_Pct2_Y_,B_E___B2_B_Flt_Pct2_Y_,B_E___B2_B_Mat_Pct2_Y_,B_E___B2_B_Ops_Pct2_Y_,B_E___B2_B_Oth_Pct2_Y_,B_E___B2_B_Old_Dt_Ev_,B_E___B2_B_Old_Msnc_Ev_,B_E___B2_B_Old_Dt2_Y_,B_E___B2_B_New_Dt2_Y_,B_E___B2_B_Old_Msnc2_Y_,B_E___B2_B_New_Msnc2_Y_,B_E___B2_B_Actv_Cnt_,B_E___B2_B_Actv_Carr_Cnt_,B_E___B2_B_Actv_Flt_Cnt_,B_E___B2_B_Actv_Mat_Cnt_,B_E___B2_B_Actv_Ops_Cnt_,B_E___B2_B_Actv_Oth_Cnt_,B_E___B2_B_Actv_Carr_Pct_,B_E___B2_B_Actv_Flt_Pct_,B_E___B2_B_Actv_Mat_Pct_,B_E___B2_B_Actv_Ops_Pct_,B_E___B2_B_Actv_Oth_Pct_,B_E___B2_B_Actv_Cnt_A1_Y_,B_E___B2_B_Actv_Carr_Cnt_A1_Y_,B_E___B2_B_Actv_Flt_Cnt_A1_Y_,B_E___B2_B_Actv_Mat_Cnt_A1_Y_,B_E___B2_B_Actv_Ops_Cnt_A1_Y_,B_E___B2_B_Actv_Oth_Cnt_A1_Y_,B_E___B2_B_Actv_Cnt_Grow1_Y_,B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_,B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_,B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_,B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_,B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_,B_E___B2_B_Actv_Flt_Bal_Tot_,B_E___B2_B_Actv_Mat_Bal_Tot_,B_E___B2_B_Actv_Ops_Bal_Tot_,B_E___B2_B_Actv_Oth_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_Pct_,B_E___B2_B_Actv_Flt_Bal_Pct_,B_E___B2_B_Actv_Mat_Bal_Pct_,B_E___B2_B_Actv_Ops_Bal_Pct_,B_E___B2_B_Actv_Oth_Bal_Pct_,B_E___B2_B_Actv_Bal_Tot_Rnge_,B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_,B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_,B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_,B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_,B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_,B_E___B2_B_Actv_Bal_Avg_,B_E___B2_B_Actv_Carr_Bal_Avg_,B_E___B2_B_Actv_Flt_Bal_Avg_,B_E___B2_B_Actv_Mat_Bal_Avg_,B_E___B2_B_Actv_Ops_Bal_Avg_,B_E___B2_B_Actv_Oth_Bal_Avg_,B_E___B2_B_Actv_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Bal_Max2_Y_,B_E___B2_B_Carr_Bal_Max2_Y_,B_E___B2_B_Flt_Bal_Max2_Y_,B_E___B2_B_Mat_Bal_Max2_Y_,B_E___B2_B_Ops_Bal_Max2_Y_,B_E___B2_B_Oth_Bal_Max2_Y_,B_E___B2_B_Bal_Max_Dt2_Y_,B_E___B2_B_Carr_Bal_Max_Dt2_Y_,B_E___B2_B_Flt_Bal_Max_Dt2_Y_,B_E___B2_B_Mat_Bal_Max_Dt2_Y_,B_E___B2_B_Ops_Bal_Max_Dt2_Y_,B_E___B2_B_Oth_Bal_Max_Dt2_Y_,B_E___B2_B_Bal_Max_Msnc2_Y_,B_E___B2_B_Carr_Bal_Max_Msnc2_Y_,B_E___B2_B_Flt_Bal_Max_Msnc2_Y_,B_E___B2_B_Mat_Bal_Max_Msnc2_Y_,B_E___B2_B_Ops_Bal_Max_Msnc2_Y_,B_E___B2_B_Oth_Bal_Max_Msnc2_Y_,B_E___B2_B_Bal_Max_Seg_Type2_Y_,B_E___B2_B_Actv_Worst_Perf_Indx_,B_E___B2_B_Actv_Carr_Worst_Perf_Indx_,B_E___B2_B_Actv_Flt_Worst_Perf_Indx_,B_E___B2_B_Actv_Mat_Worst_Perf_Indx_,B_E___B2_B_Actv_Ops_Worst_Perf_Indx_,B_E___B2_B_Actv_Oth_Worst_Perf_Indx_,B_E___B2_B_Actv1p_Dpd_Cnt_,B_E___B2_B_Actv31p_Dpd_Cnt_,B_E___B2_B_Actv61p_Dpd_Cnt_,B_E___B2_B_Actv91p_Dpd_Cnt_,B_E___B2_B_Actv1p_Dpd_Pct_,B_E___B2_B_Actv31p_Dpd_Pct_,B_E___B2_B_Actv61p_Dpd_Pct_,B_E___B2_B_Actv91p_Dpd_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Worst_Perf_Indx2_Y_,B_E___B2_B_Carr_Worst_Perf_Indx2_Y_,B_E___B2_B_Flt_Worst_Perf_Indx2_Y_,B_E___B2_B_Mat_Worst_Perf_Indx2_Y_,B_E___B2_B_Ops_Worst_Perf_Indx2_Y_,B_E___B2_B_Oth_Worst_Perf_Indx2_Y_,B_E___B2_B_Worst_Perf_Dt2_Y_,B_E___B2_B_Carr_Worst_Perf_Dt2_Y_,B_E___B2_B_Flt_Worst_Perf_Dt2_Y_,B_E___B2_B_Mat_Worst_Perf_Dt2_Y_,B_E___B2_B_Ops_Worst_Perf_Dt2_Y_,B_E___B2_B_Oth_Worst_Perf_Dt2_Y_,B_E___B2_B_Worst_Perf_Msnc2_Y_,B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_,B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_,B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_,B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_,B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_,B_E___B2_B_Cnt24_Mc_,B_E___B2_B_Carr_Cnt24_Mc_,B_E___B2_B_Flt_Cnt24_Mc_,B_E___B2_B_Mat_Cnt24_Mc_,B_E___B2_B_Ops_Cnt24_Mc_,B_E___B2_B_Oth_Cnt24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Bal_Vol24_Mc_,B_E___B2_B_Carr_Bal_Vol24_Mc_,B_E___B2_B_Flt_Bal_Vol24_Mc_,B_E___B2_B_Mat_Bal_Vol24_Mc_,B_E___B2_B_Ops_Bal_Vol24_Mc_,B_E___B2_B_Oth_Bal_Vol24_Mc_,B_E___Ast_Veh_Air_Cnt_Ev_,B_E___Ast_Veh_Wtr_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt2_Y_,B_E___Ast_Veh_Auto_Pers_Cnt2_Y_,B_E___Ast_Veh_Auto_Comm_Cnt2_Y_,B_E___Ast_Veh_Auto_Other_Cnt2_Y_,B_E___Ast_Veh_Auto_Val_Tot2_Y_,B_E___Ast_Veh_Auto_Emrg_New_Msnc_Ev_,B_E___Ast_Veh_Auto_Emrg_New_Dt_Ev_,B_E___Drg_Bk_Cnt1_Y_,B_E___Drg_Bk_Cnt7_Y_,B_E___Drg_Bk_Cnt10_Y_,B_E___Drg_Bk_Old_Dt10_Y_,B_E___Drg_Bk_Old_Msnc10_Y_,B_E___Drg_Bk_New_Dt10_Y_,B_E___Drg_Bk_New_Msnc10_Y_,B_E___Drg_Bk_Updt_New_Dt10_Y_,B_E___Drg_Bk_Updt_New_Msnc10_Y_,B_E___Drg_Bk_Disp_Cnt10_Y_,B_E___Drg_Bk_Dsch_Cnt10_Y_,B_E___Drg_Bk_Dsms_Cnt10_Y_,B_E___Drg_Bk_New_Disp_Type10_Y_,B_E___Drg_Bk_Ch7_Cnt10_Y_,B_E___Drg_Bk_Ch11_Cnt10_Y_,B_E___Drg_Bk_Ch13_Cnt10_Y_,B_E___Drg_Bk_New_Ch_Type10_Y_,B_E___S_O_S_Cnt_Ev_,B_E___S_O_S_New_Dt_Ev_,B_E___S_O_S_Old_Dt_Ev_,B_E___S_O_S_New_Msnc_Ev_,B_E___S_O_S_Old_Msnc_Ev_,B_E___S_O_S_State_Cnt_Ev_,B_E___S_O_S_Dom_Cnt_Ev_,B_E___S_O_S_Dom_New_Dt_Ev_,B_E___S_O_S_Dom_Old_Dt_Ev_,B_E___S_O_S_Dom_New_Msnc_Ev_,B_E___S_O_S_Dom_Old_Msnc_Ev_,B_E___S_O_S_Frgn_Cnt_Ev_,B_E___S_O_S_Frgn_New_Dt_Ev_,B_E___S_O_S_Frgn_Old_Dt_Ev_,B_E___S_O_S_Frgn_New_Msnc_Ev_,B_E___S_O_S_Frgn_Old_Msnc_Ev_,B_E___S_O_S_Dom_Status_Indx_Ev_,B_E___Best_Name_,B_E___Best_Addr_Loc_I_D_,B_E___Best_Addr_St_,B_E___Best_Addr_City_,B_E___Best_Addr_City_Post_,B_E___Best_Addr_State_,B_E___Best_Addr_Zip_,B_E___Best_T_I_N_,B_E___Best_Phone_,B_E___Drg_Gov_Debarred_Flag_Ev_,B_E___Bus_S_I_C_Code1_,B_E___Bus_S_I_C_Code1_Desc_,B_E___Bus_S_I_C_Code1_Group_Desc_,B_E___Bus_S_I_C_Code2_,B_E___Bus_S_I_C_Code2_Desc_,B_E___Bus_S_I_C_Code2_Group_Desc_,B_E___Bus_S_I_C_Code3_,B_E___Bus_S_I_C_Code3_Desc_,B_E___Bus_S_I_C_Code3_Group_Desc_,B_E___Bus_S_I_C_Code4_,B_E___Bus_S_I_C_Code4_Desc_,B_E___Bus_S_I_C_Code4_Group_Desc_,B_E___Bus_N_A_I_C_S_Code1_,B_E___Bus_N_A_I_C_S_Code1_Desc_,B_E___Bus_N_A_I_C_S_Code1_Group_Desc_,B_E___Bus_N_A_I_C_S_Code2_,B_E___Bus_N_A_I_C_S_Code2_Desc_,B_E___Bus_N_A_I_C_S_Code2_Group_Desc_,B_E___Bus_N_A_I_C_S_Code3_,B_E___Bus_N_A_I_C_S_Code3_Desc_,B_E___Bus_N_A_I_C_S_Code3_Group_Desc_,B_E___Bus_N_A_I_C_S_Code4_,B_E___Bus_N_A_I_C_S_Code4_Desc_,B_E___Bus_N_A_I_C_S_Code4_Group_Desc_,B_E___Bus_Empl_Count_Curr_,B_E___Bus_Empl_Count_Curr_Rnge_,B_E___Bus_Annual_Sales_Curr_,B_E___Bus_Annual_Sales_Curr_Rnge_,B_E___Bus_Is_Non_Profit_Flag_,B_E___Bus_Is_Franchise_Flag_,B_E___Bus_Offers401k_Flag_,B_E___Bus_Has_New_Location_Flag1_Y_,B_E___Bus_Loc_Actv_Cnt_,B_E___Bus_Is_S_B_E_Flag_,B_E___Drg_L_T_D_Cnt1_Y_,B_E___Drg_L_T_D_Cnt7_Y_,B_E___Drg_L_T_D_Amt_Tot7_Y_,B_E___Drg_L_T_D_Amt_Avg7_Y_,B_E___Drg_L_T_D_New_Dt7_Y_,B_E___Drg_L_T_D_Old_Dt7_Y_,B_E___Drg_L_T_D_New_Msnc7_Y_,B_E___Drg_L_T_D_Old_Msnc7_Y_,B_E___U_C_C_Cnt_Ev_,B_E___U_C_C_Debtor_Cnt_Ev_,B_E___U_C_C_Debtor_Old_Dt_Ev_,B_E___U_C_C_Debtor_Old_Msnc_Ev_,B_E___U_C_C_Debtor_New_Dt_Ev_,B_E___U_C_C_Debtor_New_Msnc_Ev_,B_E___U_C_C_Actv_Cnt_,B_E___U_C_C_Debtor_Actv_Cnt_,B_E___U_C_C_Debtor_Term_Cnt_Ev_,B_E___U_C_C_Debtor_Other_Cnt_Ev_,B_E___U_C_C_Debtor_Actv_Pct_,B_E___U_C_C_Debtor_Term_Pct_Ev_,B_E___U_C_C_Debtor_Other_Pct_Ev_,B_E___U_C_C_Debtor_Term_New_Dt_Ev_,B_E___U_C_C_Debtor_Term_New_Msnc_Ev_,B_E___U_C_C_Creditor_Cnt_Ev_,B_E___U_C_C_Role_Indx_Ev_,B_E___U_C_C_Actv_Role_Indx_,B_E___Drg_Lien_Cnt1_Y_,B_E___Drg_Lien_Cnt7_Y_,B_E___Drg_Lien_Amt_Tot7_Y_,B_E___Drg_Lien_Amt_Avg7_Y_,B_E___Drg_Lien_Old_Dt7_Y_,B_E___Drg_Lien_Old_Msnc7_Y_,B_E___Drg_Lien_New_Dt7_Y_,B_E___Drg_Lien_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Cnt7_Y_,B_E___Drg_Lien_Tax_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_New_Dt7_Y_,B_E___Drg_Lien_Tax_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_Cnt7_Y_,B_E___Drg_Lien_Tax_Fed_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_New_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_New_Msnc7_Y_,B_E___Drg_Lien_Tax_State_Cnt7_Y_,B_E___Drg_Lien_Tax_State_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_State_Old_Dt7_Y_,B_E___Drg_Lien_Tax_State_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_State_New_Dt7_Y_,B_E___Drg_Lien_Tax_State_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_Cnt7_Y_,B_E___Drg_Lien_Tax_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Other_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Other_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_New_Dt7_Y_,B_E___Drg_Lien_Tax_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Cnt7_Y_,B_E___Drg_Lien_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Other_New_Dt7_Y_,B_E___Drg_Lien_Other_Old_Dt7_Y_,B_E___Drg_Lien_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Old_Msnc7_Y_,B_E___Drg_Judg_Cnt1_Y_,B_E___Drg_Judg_Cnt7_Y_,B_E___Drg_Judg_Amt_Tot7_Y_,B_E___Drg_Judg_Amt_Avg7_Y_,B_E___Drg_Judg_Old_Dt7_Y_,B_E___Drg_Judg_Old_Msnc7_Y_,B_E___Drg_Judg_New_Dt7_Y_,B_E___Drg_Judg_New_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_Cnt7_Y_,B_E___Drg_Judg_Civ_Crt_Amt_Tot7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_New_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_New_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_Cnt7_Y_,B_E___Drg_Judg_Sm_Claim_Amt_Tot7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_New_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_New_Msnc7_Y_,B_E___Drg_Judg_Frcl_Cnt7_Y_,B_E___Drg_Judg_Frcl_Amt_Tot7_Y_,B_E___Drg_Judg_Frcl_Old_Dt7_Y_,B_E___Drg_Judg_Frcl_Old_Msnc7_Y_,B_E___Drg_Judg_Frcl_New_Dt7_Y_,B_E___Drg_Judg_Frcl_New_Msnc7_Y_,B_E___Drg_Ln_J_Cnt1_Y_,B_E___Drg_Ln_J_Cnt7_Y_,B_E___Drg_Ln_J_Amt_Tot7_Y_,B_E___Drg_Ln_J_Amt_Avg7_Y_,B_E___Drg_Ln_J_New_Dt7_Y_,B_E___Drg_Ln_J_Old_Dt7_Y_,B_E___Drg_Ln_J_New_Msnc7_Y_,B_E___Drg_Ln_J_Old_Msnc7_Y_,B_E___Drg_Suit_Cnt7_Y_,B_E___Drg_Suit_Amt_Tot7_Y_,B_E___Drg_Suit_Old_Dt7_Y_,B_E___Drg_Suit_Old_Msnc7_Y_,B_E___Drg_Suit_New_Dt7_Y_,B_E___Drg_Suit_New_Msnc7_Y_,B_E___Drg_Judg_New_Type7_Y_,B_E___Drg_Lien_New_Type7_Y_,B_E___Drg_Cnt1_Y_,B_E___Drg_Cnt7_Y_,B_E___Drg_Flag7_Y_,B_E___Drg_New_Dt7_Y_,B_E___Drg_New_Msnc7_Y_,B_E___Drg_Old_Dt7_Y_,B_E___Drg_Old_Msnc7_Y_,B_E___Assoc_Cnt_Ev_,B_E___Assoc_Cnt2_Y_,B_E___Assoc_Pct2_Y_,B_E___Assoc_Exec_Cnt_Ev_,B_E___Assoc_Exec_Cnt2_Y_,B_E___Assoc_Exec_Pct2_Y_,B_E___Assoc_Nexec_Cnt_Ev_,B_E___Assoc_Nexec_Cnt2_Y_,B_E___Assoc_Nexec_Pct2_Y_,B_E___Assoc_Email_Flag2_Y_,B_E___Assoc_Exec_Email_Flag2_Y_,B_E___Assoc_Nexec_Email_Flag2_Y_,B_E___Assoc_Age_Avg2_Y_,B_E___Assoc_Exec_Age_Avg2_Y_,B_E___Assoc_Nexec_Age_Avg2_Y_,B_E___Assoc_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Exec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Nexec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Bk_Cnt2_Y_},B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Seen_Flag_,B_E___Ver_Src_List_Ev_,B_E___Ver_Src_Cnt_Ev_,B_E___Ver_Src_Emrg_Dt_List_Ev_,B_E___Ver_Src_Last_Dt_List_Ev_,B_E___Ver_Src_Old_Dt_Ev_,B_E___Ver_Src_New_Dt_Ev_,B_E___Ver_Src_Old_Msnc_Ev_,B_E___Ver_Src_New_Msnc_Ev_,B_E___Ver_Src_Rpt_New_Bus_Flag_,B_E___Ver_Src_Cred_Cnt_Ev_,B_E___Ver_Src_Bureau_Flag_,B_E___Ver_Src_Bureau_Old_Dt_Ev_,B_E___Ver_Src_Bureau_Old_Msnc_Ev_,B_E___B2_B_Cnt_Ev_,B_E___B2_B_Cnt2_Y_,B_E___B2_B_Carr_Cnt2_Y_,B_E___B2_B_Flt_Cnt2_Y_,B_E___B2_B_Mat_Cnt2_Y_,B_E___B2_B_Ops_Cnt2_Y_,B_E___B2_B_Oth_Cnt2_Y_,B_E___B2_B_Carr_Pct2_Y_,B_E___B2_B_Flt_Pct2_Y_,B_E___B2_B_Mat_Pct2_Y_,B_E___B2_B_Ops_Pct2_Y_,B_E___B2_B_Oth_Pct2_Y_,B_E___B2_B_Old_Dt_Ev_,B_E___B2_B_Old_Msnc_Ev_,B_E___B2_B_Old_Dt2_Y_,B_E___B2_B_New_Dt2_Y_,B_E___B2_B_Old_Msnc2_Y_,B_E___B2_B_New_Msnc2_Y_,B_E___B2_B_Actv_Cnt_,B_E___B2_B_Actv_Carr_Cnt_,B_E___B2_B_Actv_Flt_Cnt_,B_E___B2_B_Actv_Mat_Cnt_,B_E___B2_B_Actv_Ops_Cnt_,B_E___B2_B_Actv_Oth_Cnt_,B_E___B2_B_Actv_Carr_Pct_,B_E___B2_B_Actv_Flt_Pct_,B_E___B2_B_Actv_Mat_Pct_,B_E___B2_B_Actv_Ops_Pct_,B_E___B2_B_Actv_Oth_Pct_,B_E___B2_B_Actv_Cnt_A1_Y_,B_E___B2_B_Actv_Carr_Cnt_A1_Y_,B_E___B2_B_Actv_Flt_Cnt_A1_Y_,B_E___B2_B_Actv_Mat_Cnt_A1_Y_,B_E___B2_B_Actv_Ops_Cnt_A1_Y_,B_E___B2_B_Actv_Oth_Cnt_A1_Y_,B_E___B2_B_Actv_Cnt_Grow1_Y_,B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_,B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_,B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_,B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_,B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_,B_E___B2_B_Actv_Flt_Bal_Tot_,B_E___B2_B_Actv_Mat_Bal_Tot_,B_E___B2_B_Actv_Ops_Bal_Tot_,B_E___B2_B_Actv_Oth_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_Pct_,B_E___B2_B_Actv_Flt_Bal_Pct_,B_E___B2_B_Actv_Mat_Bal_Pct_,B_E___B2_B_Actv_Ops_Bal_Pct_,B_E___B2_B_Actv_Oth_Bal_Pct_,B_E___B2_B_Actv_Bal_Tot_Rnge_,B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_,B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_,B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_,B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_,B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_,B_E___B2_B_Actv_Bal_Avg_,B_E___B2_B_Actv_Carr_Bal_Avg_,B_E___B2_B_Actv_Flt_Bal_Avg_,B_E___B2_B_Actv_Mat_Bal_Avg_,B_E___B2_B_Actv_Ops_Bal_Avg_,B_E___B2_B_Actv_Oth_Bal_Avg_,B_E___B2_B_Actv_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Bal_Max2_Y_,B_E___B2_B_Carr_Bal_Max2_Y_,B_E___B2_B_Flt_Bal_Max2_Y_,B_E___B2_B_Mat_Bal_Max2_Y_,B_E___B2_B_Ops_Bal_Max2_Y_,B_E___B2_B_Oth_Bal_Max2_Y_,B_E___B2_B_Bal_Max_Dt2_Y_,B_E___B2_B_Carr_Bal_Max_Dt2_Y_,B_E___B2_B_Flt_Bal_Max_Dt2_Y_,B_E___B2_B_Mat_Bal_Max_Dt2_Y_,B_E___B2_B_Ops_Bal_Max_Dt2_Y_,B_E___B2_B_Oth_Bal_Max_Dt2_Y_,B_E___B2_B_Bal_Max_Msnc2_Y_,B_E___B2_B_Carr_Bal_Max_Msnc2_Y_,B_E___B2_B_Flt_Bal_Max_Msnc2_Y_,B_E___B2_B_Mat_Bal_Max_Msnc2_Y_,B_E___B2_B_Ops_Bal_Max_Msnc2_Y_,B_E___B2_B_Oth_Bal_Max_Msnc2_Y_,B_E___B2_B_Bal_Max_Seg_Type2_Y_,B_E___B2_B_Actv_Worst_Perf_Indx_,B_E___B2_B_Actv_Carr_Worst_Perf_Indx_,B_E___B2_B_Actv_Flt_Worst_Perf_Indx_,B_E___B2_B_Actv_Mat_Worst_Perf_Indx_,B_E___B2_B_Actv_Ops_Worst_Perf_Indx_,B_E___B2_B_Actv_Oth_Worst_Perf_Indx_,B_E___B2_B_Actv1p_Dpd_Cnt_,B_E___B2_B_Actv31p_Dpd_Cnt_,B_E___B2_B_Actv61p_Dpd_Cnt_,B_E___B2_B_Actv91p_Dpd_Cnt_,B_E___B2_B_Actv1p_Dpd_Pct_,B_E___B2_B_Actv31p_Dpd_Pct_,B_E___B2_B_Actv61p_Dpd_Pct_,B_E___B2_B_Actv91p_Dpd_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Worst_Perf_Indx2_Y_,B_E___B2_B_Carr_Worst_Perf_Indx2_Y_,B_E___B2_B_Flt_Worst_Perf_Indx2_Y_,B_E___B2_B_Mat_Worst_Perf_Indx2_Y_,B_E___B2_B_Ops_Worst_Perf_Indx2_Y_,B_E___B2_B_Oth_Worst_Perf_Indx2_Y_,B_E___B2_B_Worst_Perf_Dt2_Y_,B_E___B2_B_Carr_Worst_Perf_Dt2_Y_,B_E___B2_B_Flt_Worst_Perf_Dt2_Y_,B_E___B2_B_Mat_Worst_Perf_Dt2_Y_,B_E___B2_B_Ops_Worst_Perf_Dt2_Y_,B_E___B2_B_Oth_Worst_Perf_Dt2_Y_,B_E___B2_B_Worst_Perf_Msnc2_Y_,B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_,B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_,B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_,B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_,B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_,B_E___B2_B_Cnt24_Mc_,B_E___B2_B_Carr_Cnt24_Mc_,B_E___B2_B_Flt_Cnt24_Mc_,B_E___B2_B_Mat_Cnt24_Mc_,B_E___B2_B_Ops_Cnt24_Mc_,B_E___B2_B_Oth_Cnt24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Bal_Vol24_Mc_,B_E___B2_B_Carr_Bal_Vol24_Mc_,B_E___B2_B_Flt_Bal_Vol24_Mc_,B_E___B2_B_Mat_Bal_Vol24_Mc_,B_E___B2_B_Ops_Bal_Vol24_Mc_,B_E___B2_B_Oth_Bal_Vol24_Mc_,B_E___Ast_Veh_Air_Cnt_Ev_,B_E___Ast_Veh_Wtr_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt_Ev_,B_E___Ast_Veh_Auto_Cnt2_Y_,B_E___Ast_Veh_Auto_Pers_Cnt2_Y_,B_E___Ast_Veh_Auto_Comm_Cnt2_Y_,B_E___Ast_Veh_Auto_Other_Cnt2_Y_,B_E___Ast_Veh_Auto_Val_Tot2_Y_,B_E___Ast_Veh_Auto_Emrg_New_Msnc_Ev_,B_E___Ast_Veh_Auto_Emrg_New_Dt_Ev_,B_E___Drg_Bk_Cnt1_Y_,B_E___Drg_Bk_Cnt7_Y_,B_E___Drg_Bk_Cnt10_Y_,B_E___Drg_Bk_Old_Dt10_Y_,B_E___Drg_Bk_Old_Msnc10_Y_,B_E___Drg_Bk_New_Dt10_Y_,B_E___Drg_Bk_New_Msnc10_Y_,B_E___Drg_Bk_Updt_New_Dt10_Y_,B_E___Drg_Bk_Updt_New_Msnc10_Y_,B_E___Drg_Bk_Disp_Cnt10_Y_,B_E___Drg_Bk_Dsch_Cnt10_Y_,B_E___Drg_Bk_Dsms_Cnt10_Y_,B_E___Drg_Bk_New_Disp_Type10_Y_,B_E___Drg_Bk_Ch7_Cnt10_Y_,B_E___Drg_Bk_Ch11_Cnt10_Y_,B_E___Drg_Bk_Ch13_Cnt10_Y_,B_E___Drg_Bk_New_Ch_Type10_Y_,B_E___S_O_S_Cnt_Ev_,B_E___S_O_S_New_Dt_Ev_,B_E___S_O_S_Old_Dt_Ev_,B_E___S_O_S_New_Msnc_Ev_,B_E___S_O_S_Old_Msnc_Ev_,B_E___S_O_S_State_Cnt_Ev_,B_E___S_O_S_Dom_Cnt_Ev_,B_E___S_O_S_Dom_New_Dt_Ev_,B_E___S_O_S_Dom_Old_Dt_Ev_,B_E___S_O_S_Dom_New_Msnc_Ev_,B_E___S_O_S_Dom_Old_Msnc_Ev_,B_E___S_O_S_Frgn_Cnt_Ev_,B_E___S_O_S_Frgn_New_Dt_Ev_,B_E___S_O_S_Frgn_Old_Dt_Ev_,B_E___S_O_S_Frgn_New_Msnc_Ev_,B_E___S_O_S_Frgn_Old_Msnc_Ev_,B_E___S_O_S_Dom_Status_Indx_Ev_,B_E___Best_Name_,B_E___Best_Addr_Loc_I_D_,B_E___Best_Addr_St_,B_E___Best_Addr_City_,B_E___Best_Addr_City_Post_,B_E___Best_Addr_State_,B_E___Best_Addr_Zip_,B_E___Best_T_I_N_,B_E___Best_Phone_,B_E___Drg_Gov_Debarred_Flag_Ev_,B_E___Bus_S_I_C_Code1_,B_E___Bus_S_I_C_Code1_Desc_,B_E___Bus_S_I_C_Code1_Group_Desc_,B_E___Bus_S_I_C_Code2_,B_E___Bus_S_I_C_Code2_Desc_,B_E___Bus_S_I_C_Code2_Group_Desc_,B_E___Bus_S_I_C_Code3_,B_E___Bus_S_I_C_Code3_Desc_,B_E___Bus_S_I_C_Code3_Group_Desc_,B_E___Bus_S_I_C_Code4_,B_E___Bus_S_I_C_Code4_Desc_,B_E___Bus_S_I_C_Code4_Group_Desc_,B_E___Bus_N_A_I_C_S_Code1_,B_E___Bus_N_A_I_C_S_Code1_Desc_,B_E___Bus_N_A_I_C_S_Code1_Group_Desc_,B_E___Bus_N_A_I_C_S_Code2_,B_E___Bus_N_A_I_C_S_Code2_Desc_,B_E___Bus_N_A_I_C_S_Code2_Group_Desc_,B_E___Bus_N_A_I_C_S_Code3_,B_E___Bus_N_A_I_C_S_Code3_Desc_,B_E___Bus_N_A_I_C_S_Code3_Group_Desc_,B_E___Bus_N_A_I_C_S_Code4_,B_E___Bus_N_A_I_C_S_Code4_Desc_,B_E___Bus_N_A_I_C_S_Code4_Group_Desc_,B_E___Bus_Empl_Count_Curr_,B_E___Bus_Empl_Count_Curr_Rnge_,B_E___Bus_Annual_Sales_Curr_,B_E___Bus_Annual_Sales_Curr_Rnge_,B_E___Bus_Is_Non_Profit_Flag_,B_E___Bus_Is_Franchise_Flag_,B_E___Bus_Offers401k_Flag_,B_E___Bus_Has_New_Location_Flag1_Y_,B_E___Bus_Loc_Actv_Cnt_,B_E___Bus_Is_S_B_E_Flag_,B_E___Drg_L_T_D_Cnt1_Y_,B_E___Drg_L_T_D_Cnt7_Y_,B_E___Drg_L_T_D_Amt_Tot7_Y_,B_E___Drg_L_T_D_Amt_Avg7_Y_,B_E___Drg_L_T_D_New_Dt7_Y_,B_E___Drg_L_T_D_Old_Dt7_Y_,B_E___Drg_L_T_D_New_Msnc7_Y_,B_E___Drg_L_T_D_Old_Msnc7_Y_,B_E___U_C_C_Cnt_Ev_,B_E___U_C_C_Debtor_Cnt_Ev_,B_E___U_C_C_Debtor_Old_Dt_Ev_,B_E___U_C_C_Debtor_Old_Msnc_Ev_,B_E___U_C_C_Debtor_New_Dt_Ev_,B_E___U_C_C_Debtor_New_Msnc_Ev_,B_E___U_C_C_Actv_Cnt_,B_E___U_C_C_Debtor_Actv_Cnt_,B_E___U_C_C_Debtor_Term_Cnt_Ev_,B_E___U_C_C_Debtor_Other_Cnt_Ev_,B_E___U_C_C_Debtor_Actv_Pct_,B_E___U_C_C_Debtor_Term_Pct_Ev_,B_E___U_C_C_Debtor_Other_Pct_Ev_,B_E___U_C_C_Debtor_Term_New_Dt_Ev_,B_E___U_C_C_Debtor_Term_New_Msnc_Ev_,B_E___U_C_C_Creditor_Cnt_Ev_,B_E___U_C_C_Role_Indx_Ev_,B_E___U_C_C_Actv_Role_Indx_,B_E___Drg_Lien_Cnt1_Y_,B_E___Drg_Lien_Cnt7_Y_,B_E___Drg_Lien_Amt_Tot7_Y_,B_E___Drg_Lien_Amt_Avg7_Y_,B_E___Drg_Lien_Old_Dt7_Y_,B_E___Drg_Lien_Old_Msnc7_Y_,B_E___Drg_Lien_New_Dt7_Y_,B_E___Drg_Lien_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Cnt7_Y_,B_E___Drg_Lien_Tax_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_New_Dt7_Y_,B_E___Drg_Lien_Tax_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_Cnt7_Y_,B_E___Drg_Lien_Tax_Fed_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Fed_New_Dt7_Y_,B_E___Drg_Lien_Tax_Fed_New_Msnc7_Y_,B_E___Drg_Lien_Tax_State_Cnt7_Y_,B_E___Drg_Lien_Tax_State_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_State_Old_Dt7_Y_,B_E___Drg_Lien_Tax_State_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_State_New_Dt7_Y_,B_E___Drg_Lien_Tax_State_New_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_Cnt7_Y_,B_E___Drg_Lien_Tax_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Tax_Other_Old_Dt7_Y_,B_E___Drg_Lien_Tax_Other_Old_Msnc7_Y_,B_E___Drg_Lien_Tax_Other_New_Dt7_Y_,B_E___Drg_Lien_Tax_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Cnt7_Y_,B_E___Drg_Lien_Other_Amt_Tot7_Y_,B_E___Drg_Lien_Other_New_Dt7_Y_,B_E___Drg_Lien_Other_Old_Dt7_Y_,B_E___Drg_Lien_Other_New_Msnc7_Y_,B_E___Drg_Lien_Other_Old_Msnc7_Y_,B_E___Drg_Judg_Cnt1_Y_,B_E___Drg_Judg_Cnt7_Y_,B_E___Drg_Judg_Amt_Tot7_Y_,B_E___Drg_Judg_Amt_Avg7_Y_,B_E___Drg_Judg_Old_Dt7_Y_,B_E___Drg_Judg_Old_Msnc7_Y_,B_E___Drg_Judg_New_Dt7_Y_,B_E___Drg_Judg_New_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_Cnt7_Y_,B_E___Drg_Judg_Civ_Crt_Amt_Tot7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_Old_Msnc7_Y_,B_E___Drg_Judg_Civ_Crt_New_Dt7_Y_,B_E___Drg_Judg_Civ_Crt_New_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_Cnt7_Y_,B_E___Drg_Judg_Sm_Claim_Amt_Tot7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_Old_Msnc7_Y_,B_E___Drg_Judg_Sm_Claim_New_Dt7_Y_,B_E___Drg_Judg_Sm_Claim_New_Msnc7_Y_,B_E___Drg_Judg_Frcl_Cnt7_Y_,B_E___Drg_Judg_Frcl_Amt_Tot7_Y_,B_E___Drg_Judg_Frcl_Old_Dt7_Y_,B_E___Drg_Judg_Frcl_Old_Msnc7_Y_,B_E___Drg_Judg_Frcl_New_Dt7_Y_,B_E___Drg_Judg_Frcl_New_Msnc7_Y_,B_E___Drg_Ln_J_Cnt1_Y_,B_E___Drg_Ln_J_Cnt7_Y_,B_E___Drg_Ln_J_Amt_Tot7_Y_,B_E___Drg_Ln_J_Amt_Avg7_Y_,B_E___Drg_Ln_J_New_Dt7_Y_,B_E___Drg_Ln_J_Old_Dt7_Y_,B_E___Drg_Ln_J_New_Msnc7_Y_,B_E___Drg_Ln_J_Old_Msnc7_Y_,B_E___Drg_Suit_Cnt7_Y_,B_E___Drg_Suit_Amt_Tot7_Y_,B_E___Drg_Suit_Old_Dt7_Y_,B_E___Drg_Suit_Old_Msnc7_Y_,B_E___Drg_Suit_New_Dt7_Y_,B_E___Drg_Suit_New_Msnc7_Y_,B_E___Drg_Judg_New_Type7_Y_,B_E___Drg_Lien_New_Type7_Y_,B_E___Drg_Cnt1_Y_,B_E___Drg_Cnt7_Y_,B_E___Drg_Flag7_Y_,B_E___Drg_New_Dt7_Y_,B_E___Drg_New_Msnc7_Y_,B_E___Drg_Old_Dt7_Y_,B_E___Drg_Old_Msnc7_Y_,B_E___Assoc_Cnt_Ev_,B_E___Assoc_Cnt2_Y_,B_E___Assoc_Pct2_Y_,B_E___Assoc_Exec_Cnt_Ev_,B_E___Assoc_Exec_Cnt2_Y_,B_E___Assoc_Exec_Pct2_Y_,B_E___Assoc_Nexec_Cnt_Ev_,B_E___Assoc_Nexec_Cnt2_Y_,B_E___Assoc_Nexec_Pct2_Y_,B_E___Assoc_Email_Flag2_Y_,B_E___Assoc_Exec_Email_Flag2_Y_,B_E___Assoc_Nexec_Email_Flag2_Y_,B_E___Assoc_Age_Avg2_Y_,B_E___Assoc_Exec_Age_Avg2_Y_,B_E___Assoc_Nexec_Age_Avg2_Y_,B_E___Assoc_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Exec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_Nexec_W_Edu_Coll_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Fel_Cnt2_Y_,B_E___Assoc_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Crim_Cnt2_Y_,B_E___Assoc_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Exec_W_Drg_Bk_Cnt2_Y_,B_E___Assoc_Nexec_W_Drg_Bk_Cnt2_Y_,MERGE),__ST69867_Layout);
  EXPORT Res0 := __UNWRAP(__EE2713960);
  SHARED __EE2741764 := __ENH_Business_Sele;
  SHARED __EE2741861 := __EE2741764(__T(__AND(__OP2(__EE2741764.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE2741764.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE2741764.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST70306_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.str B___Lex_I_D_Legal_Rstd_Only_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST70306_Layout __ND2741866__Project(B_Business_Sele(__in,__cfg_Local).__ST89332_Layout __PP2741862) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP2741862.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP2741862.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP2741862.Sele_I_D_;
    SELF := __PP2741862;
  END;
  EXPORT Res1 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE2741861,__ND2741866__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Rstd_Only_Flag_},B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Rstd_Only_Flag_,MERGE),__ST70306_Layout));
END;
