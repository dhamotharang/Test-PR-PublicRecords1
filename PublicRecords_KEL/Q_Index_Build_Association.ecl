//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_First_Degree_Relative,B_Person_S_S_N,B_Second_Degree_Associations,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_Business,B_Tradeline_Business_1,B_Tradeline_Business_2,B_Tradeline_Business_3,CFG_Compile,E_Accident,E_Accident_Address,E_Accident_Drivers_License,E_Address,E_Address_Drivers_License,E_Address_Inquiry,E_Address_Phone,E_Address_Property,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business,E_Criminal_Details,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_Drivers_License_Inquiry,E_Education,E_Education_S_S_N,E_Education_Student_Address,E_Email,E_Employment,E_Employment_Business_Address,E_Employment_Person,E_Employment_S_S_N,E_First_Degree_Associations,E_First_Degree_Relative,E_Household,E_Household_Member,E_Inquiry,E_Offender_Address,E_Offender_S_S_N,E_Person,E_Person_Accident,E_Person_Address,E_Person_Bankruptcy,E_Person_Drivers_License,E_Person_Education,E_Person_Email,E_Person_Inquiry,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_Property,E_Person_S_S_N,E_Person_Vehicle,E_Phone,E_Phone_Inquiry,E_Phone_S_S_N,E_Professional_License,E_Professional_License_Address,E_Professional_License_Person,E_Professional_License_Phone,E_Property,E_S_S_N_Address,E_S_S_N_Bankruptcy,E_S_S_N_Inquiry,E_S_S_N_Property,E_Second_Degree_Associations,E_Social_Security_Number,E_Tradeline,E_Tradeline_Business,E_Utility,E_Utility_Address,E_Utility_Person,E_Utility_Phone,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
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
  SHARED B_Tradeline_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_8(__in,__cfg))
    SHARED TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg).__Result;
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
  SHARED TYPEOF(E_S_S_N_Address(__in,__cfg_Local).__Result) __E_S_S_N_Address := E_S_S_N_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Bankruptcy(__in,__cfg_Local).__Result) __E_S_S_N_Bankruptcy := E_S_S_N_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Inquiry(__in,__cfg_Local).__Result) __E_S_S_N_Inquiry := E_S_S_N_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_S_S_N_Property(__in,__cfg_Local).__Result) __E_S_S_N_Property := E_S_S_N_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Second_Degree_Associations(__in,__cfg_Local).__ENH_Second_Degree_Associations) __ENH_Second_Degree_Associations := B_Second_Degree_Associations_Local(__in,__cfg_Local).__ENH_Second_Degree_Associations;
  SHARED TYPEOF(E_Second_Degree_Associations(__in,__cfg_Local).__Result) __E_Second_Degree_Associations := E_Second_Degree_Associations_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Tradeline_Business(__in,__cfg_Local).__ENH_Tradeline_Business) __ENH_Tradeline_Business := B_Tradeline_Business_Local(__in,__cfg_Local).__ENH_Tradeline_Business;
  SHARED TYPEOF(E_Tradeline_Business(__in,__cfg_Local).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Address(__in,__cfg_Local).__Result) __E_Utility_Address := E_Utility_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Person(__in,__cfg_Local).__Result) __E_Utility_Person := E_Utility_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility_Phone(__in,__cfg_Local).__Result) __E_Utility_Phone := E_Utility_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__in,__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE511829 := __E_Accident_Address;
  SHARED __EE511831 := __EE511829;
  EXPORT Res0 := __UNWRAP(__EE511831);
  SHARED __EE511833 := __E_Accident_Drivers_License;
  SHARED __EE511835 := __EE511833;
  EXPORT Res1 := __UNWRAP(__EE511835);
  SHARED __EE511837 := __E_Address_Drivers_License;
  SHARED __EE511839 := __EE511837;
  EXPORT Res2 := __UNWRAP(__EE511839);
  SHARED __EE511841 := __E_Address_Inquiry;
  SHARED __EE511843 := __EE511841;
  EXPORT Res3 := __UNWRAP(__EE511843);
  SHARED __EE511845 := __E_Address_Phone;
  SHARED __EE511847 := __EE511845;
  EXPORT Res4 := __UNWRAP(__EE511847);
  SHARED __EE511849 := __E_Address_Property;
  SHARED __EE511851 := __EE511849;
  EXPORT Res5 := __UNWRAP(__EE511851);
  SHARED __EE511853 := __E_Aircraft_Owner;
  SHARED __EE511855 := __EE511853;
  EXPORT Res6 := __UNWRAP(__EE511855);
  SHARED __EE511857 := __E_Criminal_Details;
  SHARED __EE511859 := __EE511857;
  EXPORT Res7 := __UNWRAP(__EE511859);
  SHARED __EE511861 := __E_Drivers_License_Inquiry;
  SHARED __EE511863 := __EE511861;
  EXPORT Res8 := __UNWRAP(__EE511863);
  SHARED __EE511865 := __E_Education_S_S_N;
  SHARED __EE511867 := __EE511865;
  EXPORT Res9 := __UNWRAP(__EE511867);
  SHARED __EE511869 := __E_Education_Student_Address;
  SHARED __EE511871 := __EE511869;
  EXPORT Res10 := __UNWRAP(__EE511871);
  SHARED __EE511873 := __E_Employment_Business_Address;
  SHARED __EE511875 := __EE511873;
  EXPORT Res11 := __UNWRAP(__EE511875);
  SHARED __EE511877 := __E_Employment_Person;
  SHARED __EE511879 := __EE511877;
  EXPORT Res12 := __UNWRAP(__EE511879);
  SHARED __EE511881 := __E_Employment_S_S_N;
  SHARED __EE511883 := __EE511881;
  EXPORT Res13 := __UNWRAP(__EE511883);
  SHARED __EE511885 := __E_First_Degree_Associations;
  SHARED __EE511887 := __EE511885;
  EXPORT Res14 := __UNWRAP(__EE511887);
  SHARED __EE511890 := __ENH_First_Degree_Relative;
  SHARED __EE511892 := __EE511890;
  EXPORT Res15 := __UNWRAP(__EE511892);
  SHARED __EE511911 := __E_Household_Member;
  SHARED __EE511913 := __EE511911;
  EXPORT Res16 := __UNWRAP(__EE511913);
  SHARED __EE511915 := __E_Offender_Address;
  SHARED __EE511917 := __EE511915;
  EXPORT Res17 := __UNWRAP(__EE511917);
  SHARED __EE511919 := __E_Offender_S_S_N;
  SHARED __EE511921 := __EE511919;
  EXPORT Res18 := __UNWRAP(__EE511921);
  SHARED __EE511923 := __E_Person_Accident;
  SHARED __EE511925 := __EE511923;
  EXPORT Res19 := __UNWRAP(__EE511925);
  SHARED __EE511927 := __E_Person_Address;
  SHARED __EE511929 := __EE511927;
  EXPORT Res20 := __UNWRAP(__EE511929);
  SHARED __EE511931 := __E_Person_Bankruptcy;
  SHARED __EE511933 := __EE511931;
  EXPORT Res21 := __UNWRAP(__EE511933);
  SHARED __EE511935 := __E_Person_Drivers_License;
  SHARED __EE511937 := __EE511935;
  EXPORT Res22 := __UNWRAP(__EE511937);
  SHARED __EE511939 := __E_Person_Education;
  SHARED __EE511941 := __EE511939;
  EXPORT Res23 := __UNWRAP(__EE511941);
  SHARED __EE511943 := __E_Person_Email;
  SHARED __EE511945 := __EE511943;
  EXPORT Res24 := __UNWRAP(__EE511945);
  SHARED __EE511947 := __E_Person_Inquiry;
  SHARED __EE511949 := __EE511947;
  EXPORT Res25 := __UNWRAP(__EE511949);
  SHARED __EE511951 := __E_Person_Offender;
  SHARED __EE511953 := __EE511951;
  EXPORT Res26 := __UNWRAP(__EE511953);
  SHARED __EE511955 := __E_Person_Offenses;
  SHARED __EE511957 := __EE511955;
  EXPORT Res27 := __UNWRAP(__EE511957);
  SHARED __EE511959 := __E_Person_Phone;
  SHARED __EE511961 := __EE511959;
  EXPORT Res28 := __UNWRAP(__EE511961);
  SHARED __EE511963 := __E_Person_Property;
  SHARED __EE511965 := __EE511963;
  EXPORT Res29 := __UNWRAP(__EE511965);
  SHARED __EE511968 := __ENH_Person_S_S_N;
  SHARED __EE511970 := __EE511968;
  EXPORT Res30 := __UNWRAP(__EE511970);
  SHARED __EE511980 := __E_Person_Vehicle;
  SHARED __EE511982 := __EE511980;
  EXPORT Res31 := __UNWRAP(__EE511982);
  SHARED __EE511984 := __E_Phone_Inquiry;
  SHARED __EE511986 := __EE511984;
  EXPORT Res32 := __UNWRAP(__EE511986);
  SHARED __EE511988 := __E_Phone_S_S_N;
  SHARED __EE511990 := __EE511988;
  EXPORT Res33 := __UNWRAP(__EE511990);
  SHARED __EE511992 := __E_Professional_License_Address;
  SHARED __EE511994 := __EE511992;
  EXPORT Res34 := __UNWRAP(__EE511994);
  SHARED __EE511996 := __E_Professional_License_Person;
  SHARED __EE511998 := __EE511996;
  EXPORT Res35 := __UNWRAP(__EE511998);
  SHARED __EE512000 := __E_Professional_License_Phone;
  SHARED __EE512002 := __EE512000;
  EXPORT Res36 := __UNWRAP(__EE512002);
  SHARED __EE512005 := __ENH_Second_Degree_Associations;
  SHARED __EE512007 := __EE512005;
  EXPORT Res37 := __UNWRAP(__EE512007);
  SHARED __EE512035 := __E_S_S_N_Address;
  SHARED __EE512037 := __EE512035;
  EXPORT Res38 := __UNWRAP(__EE512037);
  SHARED __EE512039 := __E_S_S_N_Bankruptcy;
  SHARED __EE512041 := __EE512039;
  EXPORT Res39 := __UNWRAP(__EE512041);
  SHARED __EE512043 := __E_S_S_N_Inquiry;
  SHARED __EE512045 := __EE512043;
  EXPORT Res40 := __UNWRAP(__EE512045);
  SHARED __EE512047 := __E_S_S_N_Property;
  SHARED __EE512049 := __EE512047;
  EXPORT Res41 := __UNWRAP(__EE512049);
  SHARED __EE512052 := __ENH_Tradeline_Business;
  SHARED __EE512054 := __EE512052;
  EXPORT Res42 := __UNWRAP(__EE512054);
  SHARED __EE512056 := __E_Utility_Address;
  SHARED __EE512058 := __EE512056;
  EXPORT Res43 := __UNWRAP(__EE512058);
  SHARED __EE512060 := __E_Utility_Person;
  SHARED __EE512062 := __EE512060;
  EXPORT Res44 := __UNWRAP(__EE512062);
  SHARED __EE512064 := __E_Utility_Phone;
  SHARED __EE512066 := __EE512064;
  EXPORT Res45 := __UNWRAP(__EE512066);
  SHARED __EE512068 := __E_Watercraft_Owner;
  SHARED __EE512070 := __EE512068;
  EXPORT Res46 := __UNWRAP(__EE512070);
  SHARED __EE512072 := __E_Zip_Code_Person;
  EXPORT Res47 := __UNWRAP(__EE512072);
END;
