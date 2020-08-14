IMPORT VehicleV2;

// DEPRECATED

EXPORT Layout_Report_Registration := RECORD
  VehicleV2.Layout_Base_Party.Reg_First_Date; // first registration date
  VehicleV2.Layout_Base_Party.Reg_Earliest_Effective_Date; // registration effective date
  VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date; // registration effective date
  VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date; // registration expiration date
  VehicleV2.Layout_Base_Party.Reg_Decal_Number; // decal number
END;
