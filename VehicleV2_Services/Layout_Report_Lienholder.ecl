IMPORT VehicleV2;

EXPORT Layout_Report_Lienholder := RECORD
  VehicleV2.Layout_Base_Party.Orig_Lien_Date; // lien date
  Layout_Report_Party;
END;
