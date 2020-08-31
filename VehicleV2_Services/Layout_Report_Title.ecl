IMPORT VehicleV2;

EXPORT Layout_Report_Title := RECORD

  VehicleV2.Layout_Base_Party.Ttl_Number; // title number
  VehicleV2.Layout_Base_Party.Ttl_Earliest_Issue_Date; // title issue date
  VehicleV2.Layout_Base_Party.Ttl_Latest_Issue_Date; // title issue date
  VehicleV2.Layout_Base_Party.Ttl_Previous_Issue_Date; // previous title issue date
  VehicleV2.Layout_Base_Party.Ttl_Status_Code; // title status code
  VehicleV2.Layout_Base_Party.Ttl_Status_Desc; // title status description
  VehicleV2.Layout_Base_Party.Ttl_Odometer_Mileage; // (Vehicle Sec.) odometer mileage

END;
