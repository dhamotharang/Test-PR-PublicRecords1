//-- incoming vehicle and vin files
import VehLic, ut, drivers;

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
Veh_Fat_Unsequenced
 :=	FL_As_Vehicles(vehicle_type<>'VS')
 +	MS_as_Vehicles 
 +	TX_As_Vehicles
 +	WI_As_Vehicles
 +	OH_As_Vehicles
 +	MN_as_Vehicles
 +	MO_as_Vehicles
 +	NC_as_Vehicles
 +	ME_as_Vehicles
 +	NE_as_Vehicles
 +  ID_as_Vehicles
 +  NM_as_Vehicles
 +	ND_as_Vehicles
 +	MT_as_Vehicles
 +	WY_as_Vehicles
 +	NV_as_Vehicles
 +	KY_as_Vehicles
 ;
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
Veh_Fat_Unsequenced
 :=	PA_as_Vehicles
 ;
#end

drivers.MAC_Check_Expire(veh_fat_unsequenced, REGISTRATION_EXPIRATION_DATE, pre_vs)

post_vs
 :=	pre_vs
 +  Experian_Updating_as_Vehicles
 +  Experian_NonUpdating_as_Vehicles(orig_state<>'OR')
 ;

ut.Mac_Sequence_Records(post_vs,seq_no,vs)

//****** Check each rec to make sure it did not expire b4 that states initial load
//		 If it did, then zero out its dates


vin_val := IF(~vs.orig_vin IN ['','NONE'],vs.orig_vin,(string22)hash(vs.orig_vin,vs.LICENSE_PLATE_NUMBERxBG4,vs.own_1_customer_name,vs.reg_1_customer_name));

vs_dist := distribute(vs,hash(vin_val));
vs_srtd := sort(vs_dist,
       orig_state, VEHICLE_NUMBERxBG1, ORIG_VIN, FIRST_REGISTRATION_DATE, YEAR_MAKE, MAKE_CODE,
       VEHICLE_TYPE, BODY_CODE, VEHICLE_USE, MAJOR_COLOR_CODE, MINOR_COLOR_CODE, TRANSFER_TYPE,
       FUEL_TYPE, ODOMETER_STATUS, ODOMETER_DATE, ODOMETER_MILEAGE, NET_WEIGHT, GROSS_WEIGHT,
       NUMBER_OF_AXLES, HORSE_POWER, CUBIC_CENTIMETERS, LENGTH_FEET, WIDTH_FEET, MH_COUNTY_CODE,
       MH_CITY_CODE, VESSEL_PROPULSION_TYPE, HULL_MATERIAL_TYPE, VESSEL_TYPE, VESSEL_WATER_TYPE,
       OWNER_1_CUSTOMER_TYPExBG3, OWN_1_FEID_SSN, OWN_1_CUSTOMER_NAME, OWN_1_DEALER_LICENSE_NUMBER,
       OWN_1_DRIVER_LICENSE_NUMBER, OWN_1_DOB, OWN_1_SEX, OWN_1_SEXUAL_PREDATOR_FLAG, OWN_1_MAIL_SUPPESSION_FLAG,
       OWN_1_ADDR_NON_DISCLOSURE_FLAG, OWN_1_LAW_ENFORCEMENT_FLAG, OWN_1_ADDRESS_NUMBER,
       OWN_1_FOREIGN_ADDRESS_FLAG, OWN_1_STREET_ADDRESS, OWN_1_APARTMENT_NUMBER, OWN_1_CITY,
       OWN_1_STATE, OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL, OWN_1_RESIDENCE_COUNTY, OWNER_2_CUSTOMER_TYPE,
       OWN_2_FEID_SSN, OWN_2_CUSTOMER_NAME, OWN_2_DEALER_LICENSE_NUMBER, OWN_2_DRIVER_LICENSE_NUMBER,
       OWN_2_DOB, OWN_2_SEX, OWN_2_SEXUAL_PREDATOR_FLAG, OWN_2_MAIL_SUPPESSION_FLAG, OWN_2_ADDR_NON_DISCLOSURE_FLAG,
       OWN_2_LAW_ENFORCEMENT_FLAG, OWN_2_ADDRESS_NUMBER, OWN_2_FOREIGN_ADDRESS_FLAG, OWN_2_STREET_ADDRESS,
       OWN_2_APARTMENT_NUMBER, OWN_2_CITY, OWN_2_STATE, OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL, OWN_2_RESIDENCE_COUNTY,
       JOINT_OWNERSHIP_CODExAND_OR, LICENSE_PLATE_NUMBERxBG4, REGISTRATION_NUMBER, REGISTRATION_EFFECTIVE_DATE,
       REGISTRATION_EXPIRATION_DATE,PLATE_ISSUE_DATE, VEHICLE_CLASS_CODE, ARF_CREDIT, DECAL_NUMBER,
       DECAL_YEAR, DECAL_TYPE, REGISTRATION_STATUS_CODE, REG_ONLY_REASON_CODE, LICENSE_PLATE_CODE,
       REGISTRATION_USE, TRUE_LICENSE_PLSTE_NUMBER, VESSEL_RESIDENT_STATUS, REGISTRANT_1_CUSTOMER_TYPExBG5,
       REG_1_FEID_SSN, REG_1_CUSTOMER_NAME, REG_1_DEALER_LICENSE_NUMBER, REG_1_DRIVER_LICENSE_NUMBER,
       REG_1_DOB, REG_1_SEX, REG_1_SEXUAL_PREDATOR_FLAG, REG_1_MAIL_SUPPESSION_FLAG, REG_1_ADDR_NON_DISCLOSURE_FLAG,
       REG_1_LAW_ENFORCEMENT_FLAG, REG_1_ADDRESS_NUMBER, REG_1_FOREIGN_ADDRESS_FLAG, REG_1_STREET_ADDRESS,
       REG_1_APARTMENT_NUMBER, REG_1_CITY, REG_1_STATE, REG_1_ZIP5_ZIP4_FOREIGN_POSTAL, REG_1_RESIDENCE_COUNTY,
       REGISTRANT_2_CUSTOMER_TYPE, REG_2_FEID_SSN, REG_2_CUSTOMER_NAME, REG_2_DEALER_LICENSE_NUMBER,
       REG_2_DRIVER_LICENSE_NUMBER, REG_2_DOB, REG_2_SEX, REG_2_SEXUAL_PREDATOR_FLAG, REG_2_MAIL_SUPPESSION_FLAG,
       REG_2_ADDR_NON_DISCLOSURE_FLAG, REG_2_LAW_ENFORCEMENT_FLAG, REG_2_ADDRESS_NUMBER, REG_2_FOREIGN_ADDRESS_FLAG,
       REG_2_STREET_ADDRESS, REG_2_APARTMENT_NUMBER, REG_2_CITY, REG_2_STATE, REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,
       REG_2_RESIDENCE_COUNTY, ACTIVITY_DATExBG6, TITLE_NUMBERxBG9, TITLE_ISSUE_DATE, PREVIOUS_TITLE_ISSUE_DATE,
       TITLE_STATUS_CODE, TITLE_TYPE, TITLE_PENDING_FLAG, DUPLICATE_TITLE_FLAG, LIEN_COUNTxBG10,
       LH_1_LIEN_DATE, LEIN_HOLDER_1_CUSTOMER_TYPE, LH_1_FEID_SSN, LH_1_CUSTOMER_NAME, LH_1_DEALER_LICENSE_NUMBER,
       LH_1_DRIVER_LICENSE_NUMBER, LH_1_DOB, LH_1_SEX, LH_1_SEXUAL_PREDATOR_FLAG, LH_1_MAIL_SUPPESSION_FLAG,
       LH_1_ADDR_NON_DISCLOSURE_FLAG, LH_1_LAW_ENFORCEMENT_FLAG, LH_1_ADDRESS_NUMBER, LH_1_FOREIGN_ADDRESS_FLAG,
       LH_1_STREET_ADDRESS, LH_1_APARTMENT_NUMBER, LH_1_CITY, LH_1_STATE, LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,
       LH_1_RESIDENCE_COUNTY,
	   //keep the earliest rec
	   dt_first_seen, REGISTRATION_EXPIRATION_DATE, local);
vs_ddpd := dedup(vs_srtd,
       orig_state, VEHICLE_NUMBERxBG1, ORIG_VIN, FIRST_REGISTRATION_DATE, YEAR_MAKE, MAKE_CODE,
       VEHICLE_TYPE, BODY_CODE, VEHICLE_USE, MAJOR_COLOR_CODE, MINOR_COLOR_CODE, TRANSFER_TYPE,
       FUEL_TYPE, ODOMETER_STATUS, ODOMETER_DATE, ODOMETER_MILEAGE, NET_WEIGHT, GROSS_WEIGHT,
       NUMBER_OF_AXLES, HORSE_POWER, CUBIC_CENTIMETERS, LENGTH_FEET, WIDTH_FEET, MH_COUNTY_CODE,
       MH_CITY_CODE, VESSEL_PROPULSION_TYPE, HULL_MATERIAL_TYPE, VESSEL_TYPE, VESSEL_WATER_TYPE,
       OWNER_1_CUSTOMER_TYPExBG3, OWN_1_FEID_SSN, OWN_1_CUSTOMER_NAME, OWN_1_DEALER_LICENSE_NUMBER,
       OWN_1_DRIVER_LICENSE_NUMBER, OWN_1_DOB, OWN_1_SEX, OWN_1_SEXUAL_PREDATOR_FLAG, OWN_1_MAIL_SUPPESSION_FLAG,
       OWN_1_ADDR_NON_DISCLOSURE_FLAG, OWN_1_LAW_ENFORCEMENT_FLAG, OWN_1_ADDRESS_NUMBER,
       OWN_1_FOREIGN_ADDRESS_FLAG, OWN_1_STREET_ADDRESS, OWN_1_APARTMENT_NUMBER, OWN_1_CITY,
       OWN_1_STATE, OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL, OWN_1_RESIDENCE_COUNTY, OWNER_2_CUSTOMER_TYPE,
       OWN_2_FEID_SSN, OWN_2_CUSTOMER_NAME, OWN_2_DEALER_LICENSE_NUMBER, OWN_2_DRIVER_LICENSE_NUMBER,
       OWN_2_DOB, OWN_2_SEX, OWN_2_SEXUAL_PREDATOR_FLAG, OWN_2_MAIL_SUPPESSION_FLAG, OWN_2_ADDR_NON_DISCLOSURE_FLAG,
       OWN_2_LAW_ENFORCEMENT_FLAG, OWN_2_ADDRESS_NUMBER, OWN_2_FOREIGN_ADDRESS_FLAG, OWN_2_STREET_ADDRESS,
       OWN_2_APARTMENT_NUMBER, OWN_2_CITY, OWN_2_STATE, OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL, OWN_2_RESIDENCE_COUNTY,
       JOINT_OWNERSHIP_CODExAND_OR, LICENSE_PLATE_NUMBERxBG4, REGISTRATION_NUMBER, REGISTRATION_EFFECTIVE_DATE,
       REGISTRATION_EXPIRATION_DATE,PLATE_ISSUE_DATE, VEHICLE_CLASS_CODE, ARF_CREDIT, DECAL_NUMBER,
       DECAL_YEAR, DECAL_TYPE, REGISTRATION_STATUS_CODE, REG_ONLY_REASON_CODE, LICENSE_PLATE_CODE,
       REGISTRATION_USE, TRUE_LICENSE_PLSTE_NUMBER, VESSEL_RESIDENT_STATUS, REGISTRANT_1_CUSTOMER_TYPExBG5,
       REG_1_FEID_SSN, REG_1_CUSTOMER_NAME, REG_1_DEALER_LICENSE_NUMBER, REG_1_DRIVER_LICENSE_NUMBER,
       REG_1_DOB, REG_1_SEX, REG_1_SEXUAL_PREDATOR_FLAG, REG_1_MAIL_SUPPESSION_FLAG, REG_1_ADDR_NON_DISCLOSURE_FLAG,
       REG_1_LAW_ENFORCEMENT_FLAG, REG_1_ADDRESS_NUMBER, REG_1_FOREIGN_ADDRESS_FLAG, REG_1_STREET_ADDRESS,
       REG_1_APARTMENT_NUMBER, REG_1_CITY, REG_1_STATE, REG_1_ZIP5_ZIP4_FOREIGN_POSTAL, REG_1_RESIDENCE_COUNTY,
       REGISTRANT_2_CUSTOMER_TYPE, REG_2_FEID_SSN, REG_2_CUSTOMER_NAME, REG_2_DEALER_LICENSE_NUMBER,
       REG_2_DRIVER_LICENSE_NUMBER, REG_2_DOB, REG_2_SEX, REG_2_SEXUAL_PREDATOR_FLAG, REG_2_MAIL_SUPPESSION_FLAG,
       REG_2_ADDR_NON_DISCLOSURE_FLAG, REG_2_LAW_ENFORCEMENT_FLAG, REG_2_ADDRESS_NUMBER, REG_2_FOREIGN_ADDRESS_FLAG,
       REG_2_STREET_ADDRESS, REG_2_APARTMENT_NUMBER, REG_2_CITY, REG_2_STATE, REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,
       REG_2_RESIDENCE_COUNTY, ACTIVITY_DATExBG6, TITLE_NUMBERxBG9, TITLE_ISSUE_DATE, PREVIOUS_TITLE_ISSUE_DATE,
       TITLE_STATUS_CODE, TITLE_TYPE, TITLE_PENDING_FLAG, DUPLICATE_TITLE_FLAG, LIEN_COUNTxBG10,
       LH_1_LIEN_DATE, LEIN_HOLDER_1_CUSTOMER_TYPE, LH_1_FEID_SSN, LH_1_CUSTOMER_NAME, LH_1_DEALER_LICENSE_NUMBER,
       LH_1_DRIVER_LICENSE_NUMBER, LH_1_DOB, LH_1_SEX, LH_1_SEXUAL_PREDATOR_FLAG, LH_1_MAIL_SUPPESSION_FLAG,
       LH_1_ADDR_NON_DISCLOSURE_FLAG, LH_1_LAW_ENFORCEMENT_FLAG, LH_1_ADDRESS_NUMBER, LH_1_FOREIGN_ADDRESS_FLAG,
       LH_1_STREET_ADDRESS, LH_1_APARTMENT_NUMBER, LH_1_CITY, LH_1_STATE, LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,
       LH_1_RESIDENCE_COUNTY, local);

myvin := if(vehlic.ValidVin(vs_ddpd.orig_vin), 
	        vs_ddpd.orig_vin, 
			(qstring25)(hash(vs_ddpd.orig_vin,vs_ddpd.LICENSE_PLATE_NUMBERxBG4,vs_ddpd.own_1_customer_name,vs_ddpd.reg_1_customer_name)));

vs_grpd := group(
			     sort(vs_ddpd(history <> 'E'),
				      myvin,-dt_last_seen,-dt_first_seen,-REGISTRATION_EXPIRATION_DATE,
					  -title_issue_date,local),
				 myvin,local);

i_blank(lef,rig) := macro
  self.rig := if ( 
  ( ri.own_2_fname='' or ri.own_2_lname='' ) and ri.own_2_company_name='' 
    or ri.rig<>'', ri.rig, ri.lef );
  endmacro;

i_blank_r(lef,rig) := macro
  self.rig := if ( 
  ( ri.reg_1_fname='' or ri.reg_1_lname='' ) and ri.reg_1_company_name='' 
    or ri.rig<>'', ri.rig, ri.lef );
  endmacro;

i_blank_r2(lef,rig) := macro
  self.rig := if ( 
  ( ri.reg_2_fname='' or ri.reg_2_lname='' ) and ri.reg_2_company_name='' 
    or ri.rig<>'', ri.rig, ri.lef );
  endmacro;

integer2 Zip4ToInteger(string4 pZip4In) := (integer2)pZip4In;

string10 pretty_zip(string10 pZipIn)
 := pZipIn[1..5] + 
	if(pZipIn[6]='-',
	   if(zip4ToInteger(pZipIn[7..10]) = 0,
		  '',
		  '-' + pZipIn[7..10]
		 ),
	   if(Zip4ToInteger(pZipIn[6..9]) = 0,
		  '',
		  '-' + pZipIn[6..9]
		 )
	  );

layout_vehicles make_hist(layout_vehicles le,layout_vehicles ri) := transform
  self.history := if (le.orig_state='','','H');
  /*self.dt_last_seen := if(ri.dt_last_seen > 0 and le.dt_first_seen > ri.dt_last_seen,
						  le.dt_first_seen, ri.dt_last_seen);*/
  i_blank(own_1_prim_range,own_2_prim_range)
  i_blank(own_1_predir,own_2_predir)
  i_blank(own_1_prim_name,own_2_prim_name)
  i_blank(own_1_suffix,own_2_suffix)
  i_blank(own_1_postdir,own_2_postdir)
  i_blank(own_1_unit_desig,own_2_unit_desig)
  i_blank(own_1_p_city_name,own_2_p_city_name)
  i_blank(own_1_v_city_name,own_2_v_city_name)
  i_blank(own_1_state_2,own_2_state_2)
  i_blank(own_1_zip5,own_2_zip5)
  i_blank(own_1_zip4,own_2_zip4)
  i_blank(own_1_county,own_2_county)
  i_blank(own_1_geo_lat,own_2_geo_lat)
  i_blank(own_1_geo_long,own_2_geo_long)
  i_blank_r(own_1_prim_range,reg_1_prim_range)
  i_blank_r(own_1_predir,reg_1_predir)
  i_blank_r(own_1_prim_name,reg_1_prim_name)
  i_blank_r(own_1_suffix,reg_1_suffix)
  i_blank_r(own_1_postdir,reg_1_postdir)
  i_blank_r(own_1_unit_desig,reg_1_unit_desig)
  i_blank_r(own_1_p_city_name,reg_1_p_city_name)
  i_blank_r(own_1_v_city_name,reg_1_v_city_name)
  i_blank_r(own_1_state_2,reg_1_state_2)
  i_blank_r(own_1_zip5,reg_1_zip5)
  i_blank_r(own_1_zip4,reg_1_zip4)
  i_blank_r(own_1_county,reg_1_county)
  i_blank_r(own_1_geo_lat,reg_1_geo_lat)
  i_blank_r(own_1_geo_long,reg_1_geo_long)
  i_blank_r2(reg_1_prim_range,reg_2_prim_range)
  i_blank_r2(reg_1_predir,reg_2_predir)
  i_blank_r2(reg_1_prim_name,reg_2_prim_name)
  i_blank_r2(reg_1_suffix,reg_2_suffix)
  i_blank_r2(reg_1_postdir,reg_2_postdir)
  i_blank_r2(reg_1_unit_desig,reg_2_unit_desig)
  i_blank_r2(reg_1_p_city_name,reg_2_p_city_name)
  i_blank_r2(reg_1_v_city_name,reg_2_v_city_name)
  i_blank_r2(reg_1_state_2,reg_2_state_2)
  i_blank_r2(reg_1_zip5,reg_2_zip5)
  i_blank_r2(reg_1_zip4,reg_2_zip4)
  i_blank_r2(reg_1_county,reg_2_county)
  i_blank_r2(reg_1_geo_lat,reg_2_geo_lat)
  i_blank_r2(reg_1_geo_long,reg_2_geo_long)
  self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL := pretty_zip(ri.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL := pretty_zip(ri.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL := pretty_zip(ri.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL := pretty_zip(ri.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.VEHICLE_NUMBERxBG1 := MAP ( ri.VEHICLE_NUMBERxBG1[1..2]<>'NO' and ri.VEHICLE_NUMBERxBG1<>'' => ri.VEHICLE_NUMBERxBG1,
                                   validvin(ri.orig_vin) => ri.orig_vin,
                                   (string20)hash(ri.orig_vin,ri.LICENSE_PLATE_NUMBERxBG4,ri.own_1_customer_name, ri.reg_1_customer_name) );
  self.source_code := if(ri.source_code = '', 'DI', ri.source_code);
  self := ri;
  end;

res := iterate(vs_grpd,make_hist(left,right)) + vs_ddpd(history = 'E');

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
export vehicles_joined := group(res): persist('Persist::VehReg_Vehicles_Joined');
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
export vehicles_joined := group(res): persist('Persist::Matrix_VehReg_Vehicles_Joined');
#end