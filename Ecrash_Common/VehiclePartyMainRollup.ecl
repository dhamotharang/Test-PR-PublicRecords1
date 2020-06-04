// Main file contains Vehicle information - Get only valid vins
	Main := DISTRIBUTE(Files.DS_BASE_VEHICLE_MAIN(LENGTH(TRIM(Vina_Vin,LEFT,RIGHT)) = Constants.VinaLength), 
																				HASH32(Vehicle_Key, Iteration_Key)); 

	//Party file contains vehicle owner registration details -  get only owner/registrants
	Party := DISTRIBUTE(Files.DS_BASE_VEHICLE_PARTY(Orig_Name_Type IN Constants.OrigNameType AND 
																																																Fname <> '' AND Lname <>'' AND (UNSIGNED) Append_Did <>0 ), 
																					HASH32(Vehicle_Key, Iteration_Key)); 

 tPartyWithVin := {Party,STRING25 Orig_Vin,STRING17 Vina_Vin,STRING Flag := 'T'}; 
   
 //Join main and party file
	jnPartyWithVin := JOIN(Party, Main,
													LEFT.Vehicle_Key = RIGHT.Vehicle_Key AND 
													LEFT.Iteration_Key = RIGHT.Iteration_Key, 
													TRANSFORM(tPartyWithVin, 
																		SELF.Orig_vin := RIGHT.Orig_Vin; 
																		SELF.Vina_Vin := TRIM(RIGHT.Vina_Vin,LEFT,RIGHT); 
																		SELF.Fname := TRIM(LEFT.Fname,LEFT,RIGHT);
																		SELF.Lname := TRIM(LEFT.Lname,LEFT,RIGHT);
																		SELF := LEFT;), LOCAL); 
   									
   	// keep latest name by date 
   	jnPartyWithVinLatest:= SORT(DISTRIBUTE(jnPartyWithVin, HASH32(Vina_Vin)),
   															Vina_Vin, Fname, Lname, Append_DID, -Registration_Expiration_Date, -Registration_Effective_Date, 
																-Title_Issue_Date, LOCAL); 
   
   	// Ignore records which has same name,  vin but diff did
   	jnPartyWithVin t_RollUpParty(jnPartyWithVinLatest L , jnPartyWithVinLatest R) := TRANSFORM 
   		SELF.Flag := IF(L.Append_DID <> R.Append_DID , 'F', 'T'); 
   		SELF := L; 
   	END; 
   	rPartyWithVinLatest := ROLLUP(jnPartyWithvinLatest, LEFT.Vina_Vin = RIGHT.Vina_Vin AND 
																												LEFT.Fname = RIGHT.Fname AND 
																												LEFT.Lname = RIGHT.Lname,
																												t_RollUpParty(LEFT,RIGHT), LOCAL);

EXPORT VehiclePartyMainRollup := rPartyWithVinLatest :PERSIST('~thor_data::ecrash::persist::vehicle_rollup'); 