EXPORT macRemoveNulls(infile, outfile) := MACRO
IMPORT STD;
#UNIQUENAME(trecs)

  infile %trecs%(infile L) := TRANSFORM
    SELF.Commercial_Info_Source := IF(STD.Str.ToUpperCase(TRIM(L.Commercial_Info_Source)) = 'NOT APPLICABLE', '', L.Commercial_Info_Source);
    SELF.Motor_Carrier_ID_State := IF(STD.Str.ToUpperCase(TRIM(L.Motor_Carrier_ID_State, LEFT, RIGHT)) = 'NU', '', L.Motor_Carrier_ID_State);
    SELF.Number_of_Axles := IF(STD.Str.ToUpperCase(TRIM(L.Number_of_Axles, LEFT, RIGHT)) = 'N', '', L.Number_of_Axles);
    SELF.Number_of_Tires := IF(STD.Str.ToUpperCase(TRIM(L.Number_of_Tires, LEFT, RIGHT)) = 'NU', '', L.Number_of_Tires);
    SELF.Trailer1_Width_Feet := IF(STD.Str.ToUpperCase(TRIM(L.Trailer1_Width_Feet, LEFT, RIGHT)) = 'NU', '', L.Trailer1_Width_Feet);
    SELF.Trailer2_Width_Feet := IF(STD.Str.ToUpperCase(TRIM(L.Trailer2_Width_Feet, LEFT, RIGHT)) = 'NU', '', L.Trailer2_Width_Feet);
    SELF.Hazardous_Materials_Class_Number1 := IF(STD.Str.ToUpperCase(TRIM(L.Hazardous_Materials_Class_Number1, LEFT, RIGHT)) = 'N', '', L.Hazardous_Materials_Class_Number1);
    SELF.Hazardous_Materials_Class_Number2 := IF(STD.Str.ToUpperCase(TRIM(L.Hazardous_Materials_Class_Number2, LEFT, RIGHT)) = 'N', '', L.Hazardous_Materials_Class_Number2);
    SELF.DOT_State := IF(STD.Str.ToUpperCase(TRIM(L.DOT_State, LEFT, RIGHT)) = 'NU', '', L.DOT_State);
    SELF.CRU_Sequence_Nbr := IF(STD.Str.ToUpperCase(TRIM(L.CRU_Sequence_Nbr, LEFT, RIGHT)) = 'N', '', L.CRU_Sequence_Nbr);
    SELF.Loss_State_Abbr := IF(STD.Str.ToUpperCase(TRIM(L.Loss_State_Abbr, LEFT, RIGHT)) = 'NU', '', L.Loss_State_Abbr);
    SELF.Loss_Cross_Street_Speed_Limit := IF(STD.Str.ToUpperCase(TRIM(L.Loss_Cross_Street_Speed_Limit, LEFT, RIGHT)) = 'NU', '', L.Loss_Cross_Street_Speed_Limit);
    SELF.Loss_Cross_Street_Number_of_Lanes := IF(STD.Str.ToUpperCase(TRIM(L.Loss_Cross_Street_Number_of_Lanes, LEFT, RIGHT)) = 'NU', '', L.Loss_Cross_Street_Number_of_Lanes);
    SELF.Number_of_Lanes := IF(STD.Str.ToUpperCase(TRIM(L.Number_of_Lanes, LEFT, RIGHT)) = 'NU', '', L.Number_of_Lanes);
    SELF.Work_Zone_Speed_Limit := IF(STD.Str.ToUpperCase(TRIM(L.Work_Zone_Speed_Limit, LEFT, RIGHT)) = 'NU', '', L.Work_Zone_Speed_Limit);
    SELF.Number_of_Qualifying_Units := IF(STD.Str.ToUpperCase(TRIM(L.Number_of_Qualifying_Units, LEFT, RIGHT)) = 'NU','',L.Number_of_Qualifying_Units);
    SELF.Number_of_HazMat_Vehicles := IF(STD.Str.ToUpperCase(TRIM(L.Number_of_HazMat_Vehicles, LEFT, RIGHT)) = 'NU', '', L.Number_of_HazMat_Vehicles);
    SELF.Number_of_Buses_Involved := IF(STD.Str.ToUpperCase(TRIM(L.Number_of_Buses_Involved, LEFT, RIGHT)) = 'NU', '', L.Number_of_Buses_Involved);
    SELF.Number_Taken_to_Treatment := IF(STD.Str.ToUpperCase(TRIM(L.Number_Taken_to_Treatment, LEFT, RIGHT)) = 'NU','',L.Number_Taken_to_Treatment);
    SELF.Number_Vehicles_Towed := IF(STD.Str.ToUpperCase(TRIM(L.Number_Vehicles_Towed, LEFT, RIGHT)) = 'NU', '', L.Number_Vehicles_Towed);
    SELF.Vehicle_at_Fault_Unit_Number := IF(STD.Str.ToUpperCase(TRIM(L.Vehicle_at_Fault_Unit_Number, LEFT, RIGHT)) = 'NU', '', L.Vehicle_at_Fault_Unit_Number);
    SELF.State := IF(STD.Str.ToUpperCase(TRIM(L.State, LEFT, RIGHT)) = 'NU', '', L.State);
    SELF.Registration_State := IF(STD.Str.ToUpperCase(TRIM(L.Registration_State, LEFT, RIGHT)) = 'NU', '', L.Registration_State);
		SELF.Other_Unit_Vehicle_Damage_Amount:= IF(STD.Str.ToUpperCase(TRIM(L.Other_Unit_Vehicle_Damage_Amount, LEFT, RIGHT)) = '0', '', L.Other_Unit_Vehicle_Damage_Amount);
    SELF.Other_Unit_Registration_State := IF(STD.Str.ToUpperCase(TRIM(L.Other_Unit_Registration_State, LEFT, RIGHT)) = 'NU', '', L.Other_Unit_Registration_State);
    SELF.Number_Trailing_Units := IF(STD.Str.ToUpperCase(TRIM(L.Number_Trailing_Units, LEFT, RIGHT)) = 'NU', '', L.Number_Trailing_Units);
    SELF.Insurance_Policy_Holder := IF( STD.Str.ToUpperCase(TRIM(l.Insurance_Policy_Holder, LEFT, RIGHT)) = 'N', '', l.Insurance_Policy_Holder); 
    SELF  := L;
  END;
  outfile := PROJECT(infile, %trecs%(LEFT));
	
ENDMACRO;