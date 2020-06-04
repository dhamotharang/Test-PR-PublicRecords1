IMPORT Ecrash_Common, STD;

  Layouts_NAccidentsInquiry.VEHICLE tVehicle(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE L) := TRANSFORM

    STRING unParsedRec := REGEXREPLACE('"',REGEXREPLACE(',"',REGEXREPLACE('","',L.Line+'|','|'),'|'),'');							

    SELF.Vehicle_ID          := unParsedRec[1..(STD.Str.Find(unParsedRec,'|',1) - 1)];
    SELF.Vehicle_Incident_ID := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',1)+1..STD.Str.Find(unParsedRec,'|',2)-1], LEFT, RIGHT);
    SELF.Vehicle_Nbr         := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',2)+1..STD.Str.Find(unParsedRec,'|',3)-1], LEFT,RIGHT);
    SELF.Vehicle_Status      := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',3)+1..STD.Str.Find(unParsedRec,'|',4)-1], LEFT, RIGHT);
    SELF.VehVIN              := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',4)+1..STD.Str.Find(unParsedRec,'|',5)-1], LEFT, RIGHT);
    SELF.VehYEAR             := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',5)+1..STD.Str.Find(unParsedRec,'|',6)-1], LEFT, RIGHT);
    SELF.VehMAKE             := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',6)+1..STD.Str.Find(unParsedRec,'|',7)-1], LEFT, RIGHT);
    SELF.VehMODEL            := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',7)+1..STD.Str.Find(unParsedRec,'|',8)-1], LEFT, RIGHT);
    SELF.Odometer	           := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',8)+1..STD.Str.Find(unParsedRec,'|',9)-1], LEFT, RIGHT);
    SELF.TAG                 := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',9)+1..STD.Str.Find(unParsedRec,'|',10)-1], LEFT, RIGHT);
    SELF.TAG_State           := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',10)+1..STD.Str.Find(unParsedRec,'|',11)-1], LEFT, RIGHT);
    SELF.Color               := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',11)+1..STD.Str.Find(unParsedRec,'|',12)-1], LEFT, RIGHT);
    SELF.Impact_Location     := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',12)+1..STD.Str.Find(unParsedRec,'|',13)-1], LEFT, RIGHT);
    SELF.Policy_Nbr          := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',13)+1..STD.Str.Find(unParsedRec,'|',14)-1], LEFT, RIGHT);
    SELF.POLICY_EXP_DATE     := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',14)+1..STD.Str.Find(unParsedRec,'|',15)-1], LEFT, RIGHT);
    SELF.Carrier_ID	         := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',15)+1..STD.Str.Find(unParsedRec,'|',16)-1], LEFT, RIGHT);
    SELF.Other_Carrier       := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',16)+1..STD.Str.Find(unParsedRec,'|',17)-1], LEFT, RIGHT);
    SELF.Commercial_VIN      := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',17)+1..STD.Str.Find(unParsedRec,'|',18)-1], LEFT, RIGHT);
    SELF.Car_Fire            := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',18)+1..STD.Str.Find(unParsedRec,'|',19)-1], LEFT, RIGHT);
    SELF.Airbags_Deploy      := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',19)+1..STD.Str.Find(unParsedRec,'|',20)-1], LEFT, RIGHT);
    SELF.Car_Towed           := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',20)+1..STD.Str.Find(unParsedRec,'|',21)-1], LEFT, RIGHT);
    SELF.Car_Rollover        := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',21)+1..STD.Str.Find(unParsedRec,'|',22)-1], LEFT, RIGHT);
    SELF.Decoded_Info        := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',22)+1..STD.Str.Find(unParsedRec,'|',23)-1], LEFT, RIGHT);
    SELF.Last_Changed        := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',23)+1..STD.Str.Find(unParsedRec,'|',24)-1], LEFT, RIGHT);
    SELF.UserID              := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',24)+1..STD.Str.Find(unParsedRec,'|',25)-1], LEFT, RIGHT);
    SELF.Damage              := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',25)+1..STD.Str.Find(unParsedRec,'|',26)-1], LEFT, RIGHT);
    SELF.Polk_Validated_VIN  := TRIM(unParsedRec[STD.Str.Find(unParsedRec,'|',26)+1..STD.Str.Find(unParsedRec,'|',27)-1], LEFT, RIGHT);
    SELF                     := [];
  END;
  sUncleanVehicles := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_Vehicle(REGEXFIND('[0-9]',Line)), tVehicle(LEFT));
	
  rmvHeaderVehicles := sUncleanVehicles(Vehicle_ID NOT IN Constants_NtlAccidentsInquiry.HdrVehicles);
  rmvUnwantedRecords := rmvHeaderVehicles(((REGEXFIND('[0-9]', TRIM(Vehicle_Id, ALL)))));
	
  Ecrash_Common.mac_CleanFields(rmvUnwantedRecords,sCleanVehicles);
  Ecrash_Common.mac_ConvertToUpperCase(sCleanVehicles, sVehiclesUpper);

  VehiclesWithVin :=  DISTRIBUTE(sVehiclesUpper(VehVIN != ''), HASH32(VehVIN));
  VehiclesWithNoVin := sVehiclesUpper(VehVIN = '');

  //Read the vina file 
  VinaFile := DISTRIBUTE(Ecrash_Common.Files.DS_BASE_VINA, HASH32(Vin_Input));
  uVinaFile := DEDUP(SORT(VinaFile, Vin_Input, LOCAL), Vin_Input, LOCAL);

  // Vehicle Attributes appended using VINA File
  Layouts_NAccidentsInquiry.VEHICLE tAppendVin(uVinaFile L, VehiclesWithVin R) := TRANSFORM
	   isSameVehicleVin              := L.Vin_Input = R.VehVIN;
    SELF.Vehicle_Seg              := MAP(isSameVehicleVin => L.Variable_Segment, '');	
    SELF.Vehicle_Seg_Type         := MAP(isSameVehicleVin => L.Veh_Type, '');	
    SELF.Model_Year               := MAP(isSameVehicleVin => L.Model_Year, '');	
    SELF.Body_Style_Code          := MAP(isSameVehicleVin => L.Vina_Body_Style, '');	
    SELF.Engine_Size              := MAP(isSameVehicleVin => L.Engine_Size, '');	
    SELF.Fuel_Code                := MAP(isSameVehicleVin => L.Fuel_Code, '');	
    SELF.Number_Of_Driving_Wheels := MAP(isSameVehicleVin => L.vp_Tilt_Wheel, '');	
    SELF.Steering_Type            := MAP(isSameVehicleVin => L.vp_Power_Steering, '');		
    SELF.Vina_Series              := MAP(isSameVehicleVin => L.Vina_Series, '');	
    SELF.Vina_Model               := MAP(isSameVehicleVin => L.Vina_Model, '');	
    SELF.Vina_Make                := MAP(isSameVehicleVin => L.Make_Description, '');	
    SELF.Vina_Body_Style          := MAP(isSameVehicleVin => L.Vina_Body_Style, '');		
    SELF.Make_Description         := MAP(isSameVehicleVin => L.Make_Description, R.VehMake);			
    SELF.Model_Description        := MAP(isSameVehicleVin => L.Model_Description, R.VehModel);		
    SELF.Series_Description       := MAP(isSameVehicleVin => L.Series_Description, '');	
    SELF.Car_Cylinders            := MAP(isSameVehicleVin => L.Number_Of_Cylinders, '');			
		  SELF.Vehicle_Status				       := IF(L.Vin_Input != '', Constants_NtlAccidentsInquiry.VINA_Vehicle_Status, '');	
    SELF                          := R;
    SELF                          := [];
  END;
  pVehiclesWithVin := JOIN(uVinaFile, VehiclesWithVin, LEFT.Vin_Input = RIGHT.VehVIN, tAppendVin(LEFT,RIGHT), RIGHT OUTER, LOCAL);
																																													
  AllVehicles := pVehiclesWithVin + VehiclesWithNoVin;
  dAllVehicles := DISTRIBUTE(AllVehicles, HASH32(Vehicle_Incident_ID));	
	
EXPORT iVehicle := dAllVehicles : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_VEHICLE');