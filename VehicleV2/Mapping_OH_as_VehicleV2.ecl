//---------------------------------------------------------------------------
//-------REFORMAT OH SOURCE TO VEHICLEV2 FORMAT AND APPEND AND VALIDATE VINA 
//---------------------------------------------------------------------------

import Ut, vehicleV2, vehlic, CODES;	
				// utilities library
/*
OH_Full 	       := Vehlic.File_OH_Full;
OH_Nonupdating     := VehLic.File_OH_NonUpdating;
*/
OH_Update 	       := VehicleV2.File_Vehicle_OH_Clean;

/*
RECORDOF(OH_Update) tformat(OH_Nonupdating L) := TRANSFORM

SELF.TITLE_TYPE_CODE := '';
SELF.filler_3 := '';
SELF := L;

end;

oh_old := PROJECT(OH_Full + OH_Nonupdating, tformat(LEFT));
*/

//---------------------------------------------------------------------------
//-------REFORMAT OH SOURCE TO VEHICLEV2 
//---------------------------------------------------------------------------
  
VehicleV2.Layout_OH_temp_module.Layout_OH_as_VehicleV2 OHToCommon(VehicleV2.Layout_OH_Clean.Layout_OH_Clean_Main pLEFT) := TRANSFORM
	SELF.state_origin										:='OH';
	SELF.dt_first_seen 									:= IF(pLEFT.RegistrationIssueDt <= pLEFT.ProcessDate AND TRIM(pLEFT.RegistrationIssueDt ) <> '',  pLEFT.RegistrationIssueDt, pLEFT.ProcessDate);
  SELF.dt_last_seen 									:= IF(pLEFT.RegistrationIssueDt <= pLEFT.ProcessDate AND TRIM(pLEFT.RegistrationIssueDt ) <> '',  pLEFT.RegistrationIssueDt, pLEFT.ProcessDate);
	SELF.dt_vendor_first_reported				:= pLEFT.ProcessDate;
	SELF.dt_vendor_last_reported				:= pLEFT.ProcessDate;
	SELF.ORIG_VIN 											:= pLEFT.VIN;
	SELF.YEAR_MAKE 											:= IF((UNSIGNED)pLEFT.ModelYr <> 0, pLEFT.ModelYr, ''); 
	SELF.MAKE_CODE 											:= pLEFT.VehicleMake;					//THOR cleanup, CODES_V3 lookup
	SELF.BODY_CODE 											:= pLEFT.VehicleType;				//CODES_V3 lookup
	SELF.LICENSE_PLATE_NUMBERxBG4 			:= pLEFT.PlateNum;
  SELF.REGISTRATION_Effective_DATE 		:= IF((UNSIGNED)pLEFT.RegistrationIssueDt <> 0, pLEFT.RegistrationIssueDt, '');
	SELF.REGISTRATION_EXPIRATION_DATE 	:= IF((UNSIGNED)pLEFT.VehicleExpDt <> 0, pLEFT.VehicleExpDt, ''); 
	SELF.REGISTRATION_STATUS_CODE 			:= '';
	SELF.TRUE_LICENSE_PLSTE_NUMBER 			:= pLEFT.PlateNum;
	SELF.history 												:= if( SELF.REGISTRATION_EXPIRATION_DATE < ut.GetDate[1..6] AND (UNSIGNED4)(SELF.REGISTRATION_EXPIRATION_DATE[1..6]) <> 0,'E', '');						 		 
	SELF.REGISTRANT_1_CUSTOMER_type 		:= MAP(TRIM(pLEFT.fname + pLEFT.lname ) <> '' => 'I',TRIM(pLEFT.company_name1) <> '' => 'B','');
	SELF.REG_1_CUSTOMER_NAME 						:= pLEFT.OwnerName;
	SELF.REG_1_STREET_ADDRESS 					:= pLEFT.OwnerStreetAddress;
	SELF.REG_1_CITY 										:= pLEFT.OwnerCity;
	SELF.REG_1_STATE 										:= pLEFT.OwnerState;
	SELF.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := IF(pLEFT.OwnerZip[6..9] = '0000',
																						pLEFT.OwnerZip[1..5],
																						pLEFT.OwnerZip[1..5] + '-' + pLEFT.OwnerZip[6..9]);
											  
	SELF.REG_2_CUSTOMER_NAME 						:= pLEFT.AdditionalOwnerName;
	SELF.REGISTRANT_2_CUSTOMER_TYPE 		:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																						MAP(TRIM(pLEFT.fname2 + pLEFT.lname2) <> '' => 'I',
																						TRIM(pLEFT.company_name2) <> '' => 'B','U'),
																						'');
	SELF.REG_2_STREET_ADDRESS 					:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																						pLEFT.OwnerStreetAddress,
																						'');
	SELF.REG_2_CITY 										:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.OwnerCity,
																						'');
	SELF.REG_2_STATE 										:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.OwnerState,
																						'');
	SELF.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL := IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																						IF(pLEFT.OwnerZip[6..9] = '0000',
																								pLEFT.OwnerZip[1..5],
																								pLEFT.OwnerZip[1..5] + '-' + pLEFT.OwnerZip[6..9]),
																								'');
	SELF.TITLE_NUMBERxBG9 							:= pLEFT.TitleNum;
	SELF.TITLE_ISSUE_DATE 							:=  IF((UNSIGNED)pLEFT.VehiclePurchaseDt <> 0, pLEFT.VehiclePurchaseDt, ''); 
	SELF.reg_1_title 										:= pLEFT.title;
	SELF.reg_1_fname 										:= pLEFT.fname;
	SELF.reg_1_mname 										:= pLEFT.mname;
	SELF.reg_1_lname 										:= pLEFT.lname;
	SELF.reg_1_name_suffix 							:= pLEFT.name_suffix;
	SELF.reg_1_company_name 						:= pLEFT.company_name1;
	SELF.reg_1_prim_range 							:= pLEFT.prim_range;		                             
	SELF.reg_1_predir 									:= pLEFT.predir;		                             
	SELF.reg_1_prim_name 								:= pLEFT.prim_name;		                             
	SELF.reg_1_suffix 									:= pLEFT.addr_suffix;		                             
	SELF.reg_1_postdir 									:= pLEFT.postdir;		                             
	SELF.reg_1_unit_desig 							:= pLEFT.unit_desig;		                             
	SELF.reg_1_sec_range 								:= pLEFT.sec_range;		                             
	SELF.reg_1_p_city_name 							:= pLEFT.p_city_name;		                             
	SELF.reg_1_v_city_name 							:= pLEFT.v_city_name;		                             
	SELF.reg_1_state_2 									:= pLEFT.st;		                             
	SELF.reg_1_zip5 										:= pLEFT.zip;
	SELF.reg_1_zip4 										:= pLEFT.zip4;		                             
	SELF.reg_1_county										:= pLEFT.county;
	SELF.reg_2_title 										:= pLEFT.title2;
	SELF.reg_2_fname 										:= pLEFT.fname2;
	SELF.reg_2_mname 										:= pLEFT.mname2;
	SELF.reg_2_lname 										:= pLEFT.lname2;
	SELF.reg_2_name_suffix 							:= pLEFT.name_suffix2;
	SELF.reg_2_company_name 						:= pLEFT.company_name2;
	
		
	SELF.reg_2_prim_range 							:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.prim_range,
																					'');
	SELF.reg_2_predir 									:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.predir,
																					'');
	SELF.reg_2_prim_name 								:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.prim_name,
																					'');
	SELF.reg_2_suffix 									:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.addr_suffix,
																						'' );
	SELF.reg_2_postdir 									:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.postdir,
																						'' );
	SELF.reg_2_unit_desig 							:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.unit_desig,
																					'');
	SELF.reg_2_sec_range 								:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.sec_range,
																					'');
	SELF.reg_2_p_city_name 							:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.p_city_name,
																					'');
	SELF.reg_2_v_city_name 							:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.v_city_name,
																					'');
	SELF.reg_2_state_2 									:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.st,
																					'');
	SELF.reg_2_zip5 										:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.zip,
																					'');
	SELF.reg_2_zip4 										:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.zip4,
																					'');
	SELF.reg_2_county										:= IF(TRIM(SELF.REG_2_CUSTOMER_NAME)<>'',
																					pLEFT.county,
																					'');
	SELF.source_code										:= 'DI';//change made to source code
	SELF.PreviousPlateNum 							:= pLEFT.PreviousPlateNum;
	SELF.VehiclePurchaseDt  						:= IF((UNSIGNED)pLEFT.VehiclePurchaseDt <> 0, pLEFT.VehiclePurchaseDt, ''); 
	SELF.VehicleTaxWeight								:= pLEFT.VehicleTaxWeight;
	SELF.VehicleTaxCode									:= pLEFT.VehicleTaxCode;
	SELF.GROSS_WEIGHT										:= pLEFT.GrossWeight;
	SELF.NET_WEIGHT											:= pLEFT.VehicleUnladdenWeight;
	SELF.CategoryCode										:= pLEFT.CategoryCode;
	SELF.Vehicle_Type										:= pLeft.CategoryCode;
	SELF.Vehicle_Use										:= TRIM(pLeft.OwnerCode,all);
	
end;

veh_OH := project(/*OH_old +*/ OH_Update, OHToCommon(LEFT));

//****** Join to VINA file and valid VIN
// change to join on vin_input in VINA file, since that is the value in the vehicle file that is searched in VINA app.

//---------------------------------------------------------------------------
//-------RAPPEND AND VALIDATE VINA 
//---------------------------------------------------------------------------

VehicleV2.Mac_validVIN(VehicleV2.Layout_OH_Temp_Module.Layout_OH_as_VehicleV2,veh_OH, validvin_out)

EXPORT Mapping_OH_as_vehicleV2 := validvin_out: persist('~thor_data400::persist::OH_as_vehiclev2');	 


