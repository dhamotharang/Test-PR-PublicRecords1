//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_First_Degree_Relative,B_Person_S_S_N,B_Second_Degree_Associations,B_Tradeline_10,B_Tradeline_11,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_Tradeline_Business,B_Tradeline_Business_1,B_Tradeline_Business_2,B_Tradeline_Business_3,CFG_Compile,E_Accident,E_Accident_Address,E_Accident_Drivers_License,E_Address,E_Address_Drivers_License,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Tax_I_D_Number,E_Business_Ult,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_Drivers_License_Inquiry,E_Education,E_Education_S_S_N,E_Education_Student_Address,E_Email,E_Employment,E_Employment_Business_Address,E_Employment_Person,E_Employment_S_S_N,E_First_Degree_Associations,E_First_Degree_Relative,E_Household,E_Household_Member,E_Inquiry,E_Offender_Address,E_Offender_S_S_N,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Inquiry,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_S_S_N,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Phone_S_S_N,E_Professional_License,E_Professional_License_Address,E_Professional_License_Person,E_Professional_License_Phone,E_Property,E_Prox_Address,E_Prox_Phone_Number,E_S_S_N_Address,E_S_S_N_Bankruptcy,E_S_S_N_Inquiry,E_S_S_N_Property,E_Second_Degree_Associations,E_Sele_Person,E_Sele_Tax_I_D,E_Social_Security_Number,E_Tradeline,E_Tradeline_Business,E_Utility,E_Utility_Address,E_Utility_Person,E_Utility_Phone,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Index_Build_Association(KEL.typ.kdate __PInputArchiveDateClean, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PInputArchiveDateClean;
  END;
  SHARED E_Accident_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Accident_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Accident_Drivers_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Accident_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Drivers_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Property_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Details_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Details(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Drivers_License_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Drivers_License_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_S_S_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Education_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_Student_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Education_Student_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Employment_Business_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment_Business_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Employment_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Employment_S_S_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Relative_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Relative(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Member_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household_Member(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Offender_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Offender_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Offender_S_S_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Offender_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Accident_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Accident(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Drivers_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Email_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offenses_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Property_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_S_S_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_S_S_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_S_S_N_Property_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_S_S_N_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Second_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Second_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Tax_I_D_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tax_I_D(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Tradeline_Business_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline_Business(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
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
  SHARED B_Tradeline_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_7(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local(__in,__cfg).__ENH_Tradeline_8;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Tradeline_Business_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_Business_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3) __ENH_Tradeline_Business_3 := B_Tradeline_Business_3_Local(__in,__cfg).__ENH_Tradeline_Business_3;
  END;
  SHARED B_Tradeline_Business_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2) __ENH_Tradeline_Business_2 := B_Tradeline_Business_2_Local(__in,__cfg).__ENH_Tradeline_Business_2;
  END;
  SHARED B_First_Degree_Relative_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_First_Degree_Relative(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_First_Degree_Relative(__in,__cfg).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_S_S_N_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_S_S_N(__in,__cfg))
    SHARED TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Second_Degree_Associations_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Second_Degree_Associations(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Second_Degree_Associations(__in,__cfg).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_Business_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_1(__in,__cfg).__ENH_Tradeline_Business_1) __ENH_Tradeline_Business_1 := B_Tradeline_Business_1_Local(__in,__cfg).__ENH_Tradeline_Business_1;
  END;
  SHARED TYPEOF(E_Accident_Address(__in,__cfg_Local).__Result) __E_Accident_Address := E_Accident_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Accident_Drivers_License(__in,__cfg_Local).__Result) __E_Accident_Drivers_License := E_Accident_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Drivers_License(__in,__cfg_Local).__Result) __E_Address_Drivers_License := E_Address_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Inquiry(__in,__cfg_Local).__Result) __E_Address_Inquiry := E_Address_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Phone(__in,__cfg_Local).__Result) __E_Address_Phone := E_Address_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address_Property(__in,__cfg_Local).__Result) __E_Address_Property := E_Address_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Details(__in,__cfg_Local).__Result) __E_Criminal_Details := E_Criminal_Details_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Drivers_License_Inquiry(__in,__cfg_Local).__Result) __E_Drivers_License_Inquiry := E_Drivers_License_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Education_S_S_N(__in,__cfg_Local).__Result) __E_Education_S_S_N := E_Education_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Education_Student_Address(__in,__cfg_Local).__Result) __E_Education_Student_Address := E_Education_Student_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment_Business_Address(__in,__cfg_Local).__Result) __E_Employment_Business_Address := E_Employment_Business_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment_Person(__in,__cfg_Local).__Result) __E_Employment_Person := E_Employment_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Employment_S_S_N(__in,__cfg_Local).__Result) __E_Employment_S_S_N := E_Employment_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_First_Degree_Relative(__in,__cfg_Local).__ENH_First_Degree_Relative) __ENH_First_Degree_Relative := B_First_Degree_Relative_Local(__in,__cfg_Local).__ENH_First_Degree_Relative;
  SHARED TYPEOF(E_First_Degree_Relative(__in,__cfg_Local).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Household_Member(__in,__cfg_Local).__Result) __E_Household_Member := E_Household_Member_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Offender_Address(__in,__cfg_Local).__Result) __E_Offender_Address := E_Offender_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Offender_S_S_N(__in,__cfg_Local).__Result) __E_Offender_S_S_N := E_Offender_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Accident(__in,__cfg_Local).__Result) __E_Person_Accident := E_Person_Accident_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Drivers_License(__in,__cfg_Local).__Result) __E_Person_Drivers_License := E_Person_Drivers_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Email(__in,__cfg_Local).__Result) __E_Person_Email := E_Person_Email_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Inquiry(__in,__cfg_Local).__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offender(__in,__cfg_Local).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Phone(__in,__cfg_Local).__Result) __E_Person_Phone := E_Person_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Property(__in,__cfg_Local).__Result) __E_Person_Property := E_Person_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Person_S_S_N(__in,__cfg_Local).__ENH_Person_S_S_N) __ENH_Person_S_S_N := B_Person_S_S_N_Local(__in,__cfg_Local).__ENH_Person_S_S_N;
  SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Phone_Inquiry(__in,__cfg_Local).__Result) __E_Phone_Inquiry := E_Phone_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Phone_S_S_N(__in,__cfg_Local).__Result) __E_Phone_S_S_N := E_Phone_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Professional_License_Address(__in,__cfg_Local).__Result) __E_Professional_License_Address := E_Professional_License_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Professional_License_Phone(__in,__cfg_Local).__Result) __E_Professional_License_Phone := E_Professional_License_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Address(__in,__cfg_Local).__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Bankruptcy(__in,__cfg_Local).__Result) __E_S_S_N_Bankruptcy := E_S_S_N_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Property(__in,__cfg_Local).__Result) __E_S_S_N_Property := E_S_S_N_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Second_Degree_Associations(__in,__cfg_Local).__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local(__in,__cfg_Local).__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations(__in,__cfg_Local).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Tax_I_D(__in,__cfg_Local).__Result) __E_Sele_Tax_I_D := E_Sele_Tax_I_D_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Tradeline_Business(__in,__cfg_Local).__ENH_Tradeline_Business) __ENH_Tradeline_Business := B_Tradeline_Business_Local(__in,__cfg_Local).__ENH_Tradeline_Business;
  SHARED TYPEOF(E_Tradeline_Business(__in,__cfg_Local).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Address(__in,__cfg_Local).__Result) __E_Utility_Address := E_Utility_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Phone(__in,__cfg_Local).__Result) __E_Utility_Phone := E_Utility_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__in,__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE821995 := __E_Accident_Address;
  SHARED __EE821997 := __EE821995;
  EXPORT Res0 := __UNWRAP(__EE821997);
  SHARED __EE821999 := __E_Accident_Drivers_License;
  SHARED __EE822001 := __EE821999;
  EXPORT Res1 := __UNWRAP(__EE822001);
  SHARED __EE822003 := __E_Address_Drivers_License;
  SHARED __EE822005 := __EE822003;
  EXPORT Res2 := __UNWRAP(__EE822005);
  SHARED __EE822007 := __E_Address_Inquiry;
  SHARED __EE822009 := __EE822007;
  EXPORT Res3 := __UNWRAP(__EE822009);
  SHARED __EE822011 := __E_Address_Phone;
  SHARED __EE822013 := __EE822011;
  EXPORT Res4 := __UNWRAP(__EE822013);
  SHARED __EE822015 := __E_Address_Property;
  SHARED __EE822017 := __EE822015;
  EXPORT Res5 := __UNWRAP(__EE822017);
  SHARED __EE822019 := __E_Aircraft_Owner;
  SHARED __EE822021 := __EE822019;
  EXPORT Res6 := __UNWRAP(__EE822021);
  SHARED __EE822023 := __E_Sele_Person;
  SHARED __EE822025 := __EE822023;
  EXPORT Res7 := __UNWRAP(__EE822025);
  SHARED __EE822027 := __E_Prox_Address;
  SHARED __EE822029 := __EE822027;
  EXPORT Res8 := __UNWRAP(__EE822029);
  SHARED __EE822031 := __E_Prox_Phone_Number;
  SHARED __EE822033 := __EE822031;
  EXPORT Res9 := __UNWRAP(__EE822033);
  SHARED __EE822035 := __E_Sele_Tax_I_D;
  SHARED __EE822037 := __EE822035;
  EXPORT Res10 := __UNWRAP(__EE822037);
  SHARED __EE822039 := __E_Criminal_Details;
  SHARED __EE822041 := __EE822039;
  EXPORT Res11 := __UNWRAP(__EE822041);
  SHARED __EE822043 := __E_Drivers_License_Inquiry;
  SHARED __EE822045 := __EE822043;
  EXPORT Res12 := __UNWRAP(__EE822045);
  SHARED __EE822047 := __E_Education_S_S_N;
  SHARED __EE822049 := __EE822047;
  EXPORT Res13 := __UNWRAP(__EE822049);
  SHARED __EE822051 := __E_Education_Student_Address;
  SHARED __EE822053 := __EE822051;
  EXPORT Res14 := __UNWRAP(__EE822053);
  SHARED __EE822055 := __E_Employment_Business_Address;
  SHARED __EE822057 := __EE822055;
  EXPORT Res15 := __UNWRAP(__EE822057);
  SHARED __EE822059 := __E_Employment_Person;
  SHARED __EE822061 := __EE822059;
  EXPORT Res16 := __UNWRAP(__EE822061);
  SHARED __EE822063 := __E_Employment_S_S_N;
  SHARED __EE822065 := __EE822063;
  EXPORT Res17 := __UNWRAP(__EE822065);
  SHARED __EE822067 := __E_First_Degree_Associations;
  SHARED __EE822069 := __EE822067;
  EXPORT Res18 := __UNWRAP(__EE822069);
  SHARED __EE822072 := __ENH_First_Degree_Relative;
  SHARED __EE822074 := __EE822072;
  EXPORT Res19 := __UNWRAP(__EE822074);
  SHARED __EE822093 := __E_Household_Member;
  SHARED __EE822095 := __EE822093;
  EXPORT Res20 := __UNWRAP(__EE822095);
  SHARED __EE822097 := __E_Offender_Address;
  SHARED __EE822099 := __EE822097;
  EXPORT Res21 := __UNWRAP(__EE822099);
  SHARED __EE822101 := __E_Offender_S_S_N;
  SHARED __EE822103 := __EE822101;
  EXPORT Res22 := __UNWRAP(__EE822103);
  SHARED __EE822105 := __E_Person_Accident;
  SHARED __EE822107 := __EE822105;
  EXPORT Res23 := __UNWRAP(__EE822107);
  SHARED __EE822109 := __E_Person_Address;
  SHARED __EE822111 := __EE822109;
  EXPORT Res24 := __UNWRAP(__EE822111);
  SHARED __EE822113 := __E_Person_Bankruptcy;
  SHARED __EE822115 := __EE822113;
  EXPORT Res25 := __UNWRAP(__EE822115);
  SHARED __EE822117 := __E_Person_Drivers_License;
  SHARED __EE822119 := __EE822117;
  EXPORT Res26 := __UNWRAP(__EE822119);
  SHARED __EE822121 := __E_Person_Education;
  SHARED __EE822123 := __EE822121;
  EXPORT Res27 := __UNWRAP(__EE822123);
  SHARED __EE822125 := __E_Person_Email;
  SHARED __EE822127 := __EE822125;
  EXPORT Res28 := __UNWRAP(__EE822127);
  SHARED __EE822129 := __E_Person_Inquiry;
  SHARED __EE822131 := __EE822129;
  EXPORT Res29 := __UNWRAP(__EE822131);
  SHARED __EE822133 := __E_Person_Offender;
  SHARED __EE822135 := __EE822133;
  EXPORT Res30 := __UNWRAP(__EE822135);
  SHARED __EE822137 := __E_Person_Offenses;
  SHARED __EE822139 := __EE822137;
  EXPORT Res31 := __UNWRAP(__EE822139);
  SHARED __EE822141 := __E_Person_Phone;
  SHARED __EE822143 := __EE822141;
  EXPORT Res32 := __UNWRAP(__EE822143);
  SHARED __EE822145 := __E_Person_Property;
  SHARED __EE822147 := __EE822145;
  EXPORT Res33 := __UNWRAP(__EE822147);
  SHARED __EE822150 := __ENH_Person_S_S_N;
  SHARED __EE822152 := __EE822150;
  EXPORT Res34 := __UNWRAP(__EE822152);
  SHARED __EE822162 := __E_Person_Vehicle;
  SHARED __EE822164 := __EE822162;
  EXPORT Res35 := __UNWRAP(__EE822164);
  SHARED __EE822166 := __E_Phone_Inquiry;
  SHARED __EE822168 := __EE822166;
  EXPORT Res36 := __UNWRAP(__EE822168);
  SHARED __EE822170 := __E_Phone_S_S_N;
  SHARED __EE822172 := __EE822170;
  EXPORT Res37 := __UNWRAP(__EE822172);
  SHARED __EE822174 := __E_Professional_License_Address;
  SHARED __EE822176 := __EE822174;
  EXPORT Res38 := __UNWRAP(__EE822176);
  SHARED __EE822178 := __E_Professional_License_Person;
  SHARED __EE822180 := __EE822178;
  EXPORT Res39 := __UNWRAP(__EE822180);
  SHARED __EE822182 := __E_Professional_License_Phone;
  SHARED __EE822184 := __EE822182;
  EXPORT Res40 := __UNWRAP(__EE822184);
  SHARED __EE822187 := __ENH_Second_Degree_Associations;
  SHARED __EE822189 := __EE822187;
  EXPORT Res41 := __UNWRAP(__EE822189);
  SHARED __EE822217 := __E_S_S_N_Address;
  SHARED __EE822219 := __EE822217;
  EXPORT Res42 := __UNWRAP(__EE822219);
  SHARED __EE822221 := __E_S_S_N_Bankruptcy;
  SHARED __EE822223 := __EE822221;
  EXPORT Res43 := __UNWRAP(__EE822223);
  SHARED __EE822225 := __E_S_S_N_Inquiry;
  SHARED __EE822227 := __EE822225;
  EXPORT Res44 := __UNWRAP(__EE822227);
  SHARED __EE822229 := __E_S_S_N_Property;
  SHARED __EE822231 := __EE822229;
  EXPORT Res45 := __UNWRAP(__EE822231);
  SHARED __EE822234 := __ENH_Tradeline_Business;
  SHARED __EE822236 := __EE822234;
  EXPORT Res46 := __UNWRAP(__EE822236);
  SHARED __EE822241 := __E_Utility_Address;
  SHARED __EE822243 := __EE822241;
  EXPORT Res47 := __UNWRAP(__EE822243);
  SHARED __EE822245 := __E_Utility_Person;
  SHARED __EE822247 := __EE822245;
  EXPORT Res48 := __UNWRAP(__EE822247);
  SHARED __EE822249 := __E_Utility_Phone;
  SHARED __EE822251 := __EE822249;
  EXPORT Res49 := __UNWRAP(__EE822251);
  SHARED __EE822253 := __E_Watercraft_Owner;
  SHARED __EE822255 := __EE822253;
  EXPORT Res50 := __UNWRAP(__EE822255);
  SHARED __EE822257 := __E_Zip_Code_Person;
  EXPORT Res51 := __UNWRAP(__EE822257);
END;
