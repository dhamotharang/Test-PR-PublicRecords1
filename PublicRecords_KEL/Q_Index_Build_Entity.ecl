﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Aircraft,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Aircraft_Owner_4,B_Bankruptcy,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Business_Sele,B_Business_Sele_1,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Criminal_Offender,B_Criminal_Offense,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Punishment,B_Inquiry,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_Bankruptcy_1,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Person_Vehicle_4,B_Phone,B_Professional_License,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Property,B_Sele_Aircraft_1,B_Sele_Bankruptcy_1,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Sele_Vehicle_1,B_Sele_Vehicle_2,B_Sele_Vehicle_3,B_Sele_Vehicle_4,B_Sele_Watercraft_1,B_Tradeline,B_Tradeline_1,B_Tradeline_10,B_Tradeline_11,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_Vehicle,B_Watercraft,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,B_Watercraft_Owner_4,CFG_Compile,E_Accident,E_Address,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Business_Org,E_Business_Pow,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment,E_Drivers_License,E_Education,E_Email,E_Employment,E_Household,E_Inquiry,E_Lien_Judgment,E_Neighborhood,E_Person,E_Person_Bankruptcy,E_Person_Offenses,E_Person_Vehicle,E_Phone,E_Professional_License,E_Professional_License_Person,E_Property,E_Property_Event,E_Sele_Aircraft,E_Sele_Bankruptcy,E_Sele_Tradeline,E_Sele_Vehicle,E_Sele_Watercraft,E_Social_Security_Number,E_T_I_N,E_Tradeline,E_U_C_C,E_Utility,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Index_Build_Entity(KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Accident_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Accident(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Org_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Org(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Pow_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Pow(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Prox_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Sele_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Business_Ult_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Ult(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Punishment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Punishment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Drivers_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Drivers_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Email_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Email(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Employment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Employment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Household_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Household(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Inquiry_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Inquiry(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Lien_Judgment_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Lien_Judgment(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Neighborhood_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Neighborhood(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offenses_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Property_Event_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Property_Event(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Aircraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Aircraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Social_Security_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_U_C_C_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_U_C_C(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Utility_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Utility(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
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
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Business_Sele_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_5(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local(__in,__cfg).__ENH_Business_Sele_6;
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
  SHARED B_Business_Sele_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_4(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local(__in,__cfg).__ENH_Business_Sele_5;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
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
  SHARED B_Business_Sele_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local(__in,__cfg).__ENH_Business_Sele_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
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
  SHARED B_Business_Sele_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local(__in,__cfg).__ENH_Business_Sele_3;
    SHARED TYPEOF(E_Sele_Bankruptcy(__in,__cfg).__Result) __E_Sele_Bankruptcy := E_Sele_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3_Local(__in,__cfg).__ENH_Sele_Vehicle_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
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
  SHARED B_Inquiry_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Inquiry(__in,__cfg))
    SHARED TYPEOF(E_Inquiry(__in,__cfg).__Result) __E_Inquiry := E_Inquiry_Filtered(__in,__cfg).__Result;
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
  SHARED B_Tradeline_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
  END;
  SHARED B_Vehicle_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle(__in,__cfg))
    SHARED TYPEOF(E_Vehicle(__in,__cfg).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Watercraft_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft(__in,__cfg))
    SHARED TYPEOF(E_Watercraft(__in,__cfg).__Result) __E_Watercraft := E_Watercraft_Filtered(__in,__cfg).__Result;
  END;
  SHARED TYPEOF(E_Accident(__in,__cfg_Local).__Result) __E_Accident := E_Accident_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Aircraft(__in,__cfg_Local).__ENH_Aircraft) __ENH_Aircraft := B_Aircraft_Local(__in,__cfg_Local).__ENH_Aircraft;
  SHARED TYPEOF(E_Aircraft(__in,__cfg_Local).__Result) __E_Aircraft := E_Aircraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Bankruptcy(__in,__cfg_Local).__ENH_Bankruptcy) __ENH_Bankruptcy := B_Bankruptcy_Local(__in,__cfg_Local).__ENH_Bankruptcy;
  SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Business_Org(__in,__cfg_Local).__Result) __E_Business_Org := E_Business_Org_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Business_Pow(__in,__cfg_Local).__Result) __E_Business_Pow := E_Business_Pow_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local(__in,__cfg_Local).__ENH_Business_Sele;
  SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Business_Ult(__in,__cfg_Local).__Result) __E_Business_Ult := E_Business_Ult_Filtered(__in,__cfg_Local).__Result;
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
  SHARED TYPEOF(E_Household(__in,__cfg_Local).__Result) __E_Household := E_Household_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Inquiry(__in,__cfg_Local).__ENH_Inquiry) __ENH_Inquiry := B_Inquiry_Local(__in,__cfg_Local).__ENH_Inquiry;
  SHARED TYPEOF(E_Inquiry(__in,__cfg_Local).__Result) __E_Inquiry := E_Inquiry_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Neighborhood(__in,__cfg_Local).__Result) __E_Neighborhood := E_Neighborhood_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Phone(__in,__cfg_Local).__ENH_Phone) __ENH_Phone := B_Phone_Local(__in,__cfg_Local).__ENH_Phone;
  SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Professional_License(__in,__cfg_Local).__ENH_Professional_License) __ENH_Professional_License := B_Professional_License_Local(__in,__cfg_Local).__ENH_Professional_License;
  SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Property(__in,__cfg_Local).__ENH_Property) __ENH_Property := B_Property_Local(__in,__cfg_Local).__ENH_Property;
  SHARED TYPEOF(E_Property(__in,__cfg_Local).__Result) __E_Property := E_Property_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Property_Event(__in,__cfg_Local).__Result) __E_Property_Event := E_Property_Event_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_T_I_N(__in,__cfg_Local).__Result) __E_T_I_N := E_T_I_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Tradeline(__in,__cfg_Local).__ENH_Tradeline) __ENH_Tradeline := B_Tradeline_Local(__in,__cfg_Local).__ENH_Tradeline;
  SHARED TYPEOF(E_Tradeline(__in,__cfg_Local).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_U_C_C(__in,__cfg_Local).__Result) __E_U_C_C := E_U_C_C_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Utility(__in,__cfg_Local).__Result) __E_Utility := E_Utility_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Vehicle(__in,__cfg_Local).__ENH_Vehicle) __ENH_Vehicle := B_Vehicle_Local(__in,__cfg_Local).__ENH_Vehicle;
  SHARED TYPEOF(E_Vehicle(__in,__cfg_Local).__Result) __E_Vehicle := E_Vehicle_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(B_Watercraft(__in,__cfg_Local).__ENH_Watercraft) __ENH_Watercraft := B_Watercraft_Local(__in,__cfg_Local).__ENH_Watercraft;
  SHARED TYPEOF(E_Watercraft(__in,__cfg_Local).__Result) __E_Watercraft := E_Watercraft_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE1730102 := __E_Accident;
  SHARED __EE1730104 := __EE1730102;
  EXPORT Res0 := __UNWRAP(__EE1730104);
  SHARED __EE1730106 := __E_Address;
  SHARED __EE1730108 := __EE1730106;
  EXPORT Res1 := __UNWRAP(__EE1730108);
  SHARED __EE1730111 := __ENH_Aircraft;
  SHARED __EE1730113 := __EE1730111;
  EXPORT Res2 := __UNWRAP(__EE1730113);
  SHARED __EE1730116 := __ENH_Bankruptcy;
  SHARED __EE1730118 := __EE1730116;
  EXPORT Res3 := __UNWRAP(__EE1730118);
  SHARED __EE1730120 := __E_Business_Ult;
  SHARED __EE1730122 := __EE1730120;
  EXPORT Res4 := __UNWRAP(__EE1730122);
  SHARED __EE1730124 := __E_Business_Org;
  SHARED __EE1730126 := __EE1730124;
  EXPORT Res5 := __UNWRAP(__EE1730126);
  SHARED __EE1730129 := __ENH_Business_Sele;
  SHARED __EE1730131 := __EE1730129;
  EXPORT Res6 := __UNWRAP(__EE1730131);
  SHARED __EE1730691 := __E_Business_Prox;
  SHARED __EE1730693 := __EE1730691;
  EXPORT Res7 := __UNWRAP(__EE1730693);
  SHARED __EE1730695 := __E_Business_Pow;
  SHARED __EE1730697 := __EE1730695;
  EXPORT Res8 := __UNWRAP(__EE1730697);
  SHARED __EE1730700 := __ENH_Criminal_Offender;
  SHARED __EE1730702 := __EE1730700;
  EXPORT Res9 := __UNWRAP(__EE1730702);
  SHARED __EE1730705 := __ENH_Criminal_Offense;
  SHARED __EE1730707 := __EE1730705;
  EXPORT Res10 := __UNWRAP(__EE1730707);
  SHARED __EE1730710 := __ENH_Criminal_Punishment;
  SHARED __EE1730712 := __EE1730710;
  EXPORT Res11 := __UNWRAP(__EE1730712);
  SHARED __EE1730714 := __E_Drivers_License;
  SHARED __EE1730716 := __EE1730714;
  EXPORT Res12 := __UNWRAP(__EE1730716);
  SHARED __EE1730718 := __E_Education;
  SHARED __EE1730720 := __EE1730718;
  EXPORT Res13 := __UNWRAP(__EE1730720);
  SHARED __EE1730722 := __E_Email;
  SHARED __EE1730724 := __EE1730722;
  EXPORT Res14 := __UNWRAP(__EE1730724);
  SHARED __EE1730726 := __E_Employment;
  SHARED __EE1730728 := __EE1730726;
  EXPORT Res15 := __UNWRAP(__EE1730728);
  SHARED __EE1730730 := __E_Household;
  SHARED __EE1730732 := __EE1730730;
  EXPORT Res16 := __UNWRAP(__EE1730732);
  SHARED __EE1730735 := __ENH_Inquiry;
  SHARED __EE1730737 := __EE1730735;
  EXPORT Res17 := __UNWRAP(__EE1730737);
  SHARED __EE1730739 := __E_Lien_Judgment;
  SHARED __EE1730741 := __EE1730739;
  EXPORT Res18 := __UNWRAP(__EE1730741);
  SHARED __EE1730743 := __E_Neighborhood;
  SHARED __EE1730745 := __EE1730743;
  EXPORT Res19 := __UNWRAP(__EE1730745);
  SHARED __EE1730748 := __ENH_Person;
  SHARED __EE1730750 := __EE1730748;
  EXPORT Res20 := __UNWRAP(__EE1730750);
  SHARED __EE1730846 := __ENH_Phone;
  SHARED __EE1730848 := __EE1730846;
  EXPORT Res21 := __UNWRAP(__EE1730848);
  SHARED __EE1730851 := __ENH_Professional_License;
  SHARED __EE1730853 := __EE1730851;
  EXPORT Res22 := __UNWRAP(__EE1730853);
  SHARED __EE1730856 := __ENH_Property;
  SHARED __EE1730858 := __EE1730856;
  EXPORT Res23 := __UNWRAP(__EE1730858);
  SHARED __EE1730860 := __E_Property_Event;
  SHARED __EE1730862 := __EE1730860;
  EXPORT Res24 := __UNWRAP(__EE1730862);
  SHARED __EE1730864 := __E_Social_Security_Number;
  SHARED __EE1730866 := __EE1730864;
  EXPORT Res25 := __UNWRAP(__EE1730866);
  SHARED __EE1730868 := __E_T_I_N;
  SHARED __EE1730870 := __EE1730868;
  EXPORT Res26 := __UNWRAP(__EE1730870);
  SHARED __EE1730873 := __ENH_Tradeline;
  SHARED __EE1730875 := __EE1730873;
  EXPORT Res27 := __UNWRAP(__EE1730875);
  SHARED __EE1730877 := __E_U_C_C;
  SHARED __EE1730879 := __EE1730877;
  EXPORT Res28 := __UNWRAP(__EE1730879);
  SHARED __EE1730881 := __E_Utility;
  SHARED __EE1730883 := __EE1730881;
  EXPORT Res29 := __UNWRAP(__EE1730883);
  SHARED __EE1730886 := __ENH_Vehicle;
  SHARED __EE1730888 := __EE1730886;
  EXPORT Res30 := __UNWRAP(__EE1730888);
  SHARED __EE1730891 := __ENH_Watercraft;
  SHARED __EE1730893 := __EE1730891;
  EXPORT Res31 := __UNWRAP(__EE1730893);
  SHARED __EE1730895 := __E_Zip_Code;
  EXPORT Res32 := __UNWRAP(__EE1730895);
END;
