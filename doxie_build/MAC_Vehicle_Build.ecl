// import Vehlic, ut, didville, did_add, fair_isaac, VehicleCodes;

export MAC_Vehicle_Build (VehFileIn, VehFileOut, PerFileOut, didPersons = 'false', did_how = '\'remote\'') :=
MACRO

#uniquename(vs)
#uniquename(get_vehicle_id)
#uniquename(get_record_id)
#uniquename(Le)
#uniquename(compSeq)
#uniquename(get_node)

%get_node%(integer %Le%) := (%Le% % (4*thorlib.nodes())) DIV 4;

// we do * 4 so that when we normalize for persons, we can make each record unique
doxie_files.Layout_Vehicles %compSeq%(doxie_files.Layout_Vehicles L, doxie_files.Layout_Vehicles R, INTEGER C) := 
TRANSFORM
	SELF.seq_no :=  IF(L.seq_no + 4*thorlib.nodes() > 4000000000, 
					ERROR('Seq Num Too Big'), 
					IF(C = 1, (thorlib.node()) * 4, L.seq_no + 4*thorlib.nodes()));
	SELF.vid := TRIM(if(vehlic.ValidVin(R.orig_vin), 
				(qstring)R.orig_vin,
				(qstring)HASH64(R.orig_vin, R.LICENSE_PLATE_NUMBERxBG4, R.own_1_customer_name, 
							 R.reg_1_customer_name, R.orig_state, R.year_make, R.make_code, 
							 R.model_description)), LEFT);
	SELF := R;
END;

//****** Push infile through transform above
%vs% := iterate(VehFileIn, %compSeq%(LEFT, RIGHT, COUNTER), LOCAL);

// changing the values to be hashed if vin not valid
%get_vehicle_id%(%vs% %Le%) := IF(VehLic.ValidVin(%Le%.orig_vin), 
							   HASHMD5(%Le%.orig_vin), 
							   HASHMD5(%Le%.orig_vin, %Le%.LICENSE_PLATE_NUMBERxBG4, %Le%.own_1_customer_name, 
							   %Le%.orig_state, %Le%.year_make, %Le%.make_code, %Le%.model_description));

// almost all fields
%get_record_id%(%vs% %Le%) := HASHMD5(%Le%.orig_state, %Le%.VEHICLE_NUMBERxBG1, %Le%.ORIG_VIN, %Le%.FIRST_REGISTRATION_DATE, %Le%.YEAR_MAKE, %Le%.MAKE_CODE,
				   %Le%.VEHICLE_TYPE, %Le%.BODY_CODE, %Le%.VEHICLE_USE, %Le%.MAJOR_COLOR_CODE, %Le%.MINOR_COLOR_CODE, %Le%.TRANSFER_TYPE,
				   %Le%.FUEL_TYPE, %Le%.ODOMETER_STATUS, %Le%.ODOMETER_DATE, %Le%.ODOMETER_MILEAGE, %Le%.NET_WEIGHT, %Le%.GROSS_WEIGHT,
				   %Le%.NUMBER_OF_AXLES, %Le%.HORSE_POWER, %Le%.CUBIC_CENTIMETERS, %Le%.LENGTH_FEET, %Le%.WIDTH_FEET, %Le%.MH_COUNTY_CODE,
				   %Le%.MH_CITY_CODE, %Le%.VESSEL_PROPULSION_TYPE, %Le%.HULL_MATERIAL_TYPE, %Le%.VESSEL_TYPE, %Le%.VESSEL_WATER_TYPE,
				   %Le%.OWNER_1_CUSTOMER_TYPExBG3, %Le%.OWN_1_FEID_SSN, %Le%.OWN_1_CUSTOMER_NAME, %Le%.OWN_1_DEALER_LICENSE_NUMBER,
				   %Le%.OWN_1_DRIVER_LICENSE_NUMBER, %Le%.OWN_1_DOB, %Le%.OWN_1_SEX, %Le%.OWN_1_SEXUAL_PREDATOR_FLAG, %Le%.OWN_1_MAIL_SUPPESSION_FLAG,
				   %Le%.OWN_1_ADDR_NON_DISCLOSURE_FLAG, %Le%.OWN_1_LAW_ENFORCEMENT_FLAG, %Le%.OWN_1_ADDRESS_NUMBER,
				   %Le%.OWN_1_FOREIGN_ADDRESS_FLAG, %Le%.OWN_1_STREET_ADDRESS, %Le%.OWN_1_APARTMENT_NUMBER, %Le%.OWN_1_CITY,
				   %Le%.OWN_1_STATE, %Le%.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL, %Le%.OWN_1_RESIDENCE_COUNTY, %Le%.OWNER_2_CUSTOMER_TYPE,
				   %Le%.OWN_2_FEID_SSN, %Le%.OWN_2_CUSTOMER_NAME, %Le%.OWN_2_DEALER_LICENSE_NUMBER, %Le%.OWN_2_DRIVER_LICENSE_NUMBER,
				   %Le%.OWN_2_DOB, %Le%.OWN_2_SEX, %Le%.OWN_2_SEXUAL_PREDATOR_FLAG, %Le%.OWN_2_MAIL_SUPPESSION_FLAG, %Le%.OWN_2_ADDR_NON_DISCLOSURE_FLAG,
				   %Le%.OWN_2_LAW_ENFORCEMENT_FLAG, %Le%.OWN_2_ADDRESS_NUMBER, %Le%.OWN_2_FOREIGN_ADDRESS_FLAG, %Le%.OWN_2_STREET_ADDRESS,
				   %Le%.OWN_2_APARTMENT_NUMBER, %Le%.OWN_2_CITY, %Le%.OWN_2_STATE, %Le%.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL, %Le%.OWN_2_RESIDENCE_COUNTY,
				   %Le%.JOINT_OWNERSHIP_CODExAND_OR, %Le%.LICENSE_PLATE_NUMBERxBG4, %Le%.REGISTRATION_NUMBER, %Le%.REGISTRATION_EFFECTIVE_DATE,
				   %Le%.REGISTRATION_EXPIRATION_DATE,%Le%.PLATE_ISSUE_DATE, %Le%.VEHICLE_CLASS_CODE, %Le%.ARF_CREDIT, %Le%.DECAL_NUMBER,
				   %Le%.DECAL_YEAR, %Le%.DECAL_TYPE, %Le%.REGISTRATION_STATUS_CODE, %Le%.REG_ONLY_REASON_CODE, %Le%.LICENSE_PLATE_CODE,
				   %Le%.REGISTRATION_USE, %Le%.TRUE_LICENSE_PLSTE_NUMBER, %Le%.VESSEL_RESIDENT_STATUS, %Le%.REGISTRANT_1_CUSTOMER_TYPExBG5,
				   %Le%.REG_1_FEID_SSN, %Le%.REG_1_CUSTOMER_NAME, %Le%.REG_1_DEALER_LICENSE_NUMBER, %Le%.REG_1_DRIVER_LICENSE_NUMBER,
				   %Le%.REG_1_DOB, %Le%.REG_1_SEX, %Le%.REG_1_SEXUAL_PREDATOR_FLAG, %Le%.REG_1_MAIL_SUPPESSION_FLAG, %Le%.REG_1_ADDR_NON_DISCLOSURE_FLAG,
				   %Le%.REG_1_LAW_ENFORCEMENT_FLAG, %Le%.REG_1_ADDRESS_NUMBER, %Le%.REG_1_FOREIGN_ADDRESS_FLAG, %Le%.REG_1_STREET_ADDRESS,
				   %Le%.REG_1_APARTMENT_NUMBER, %Le%.REG_1_CITY, %Le%.REG_1_STATE, %Le%.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL, %Le%.REG_1_RESIDENCE_COUNTY,
				   %Le%.REGISTRANT_2_CUSTOMER_TYPE, %Le%.REG_2_FEID_SSN, %Le%.REG_2_CUSTOMER_NAME, %Le%.REG_2_DEALER_LICENSE_NUMBER,
				   %Le%.REG_2_DRIVER_LICENSE_NUMBER, %Le%.REG_2_DOB, %Le%.REG_2_SEX, %Le%.REG_2_SEXUAL_PREDATOR_FLAG, %Le%.REG_2_MAIL_SUPPESSION_FLAG,
				   %Le%.REG_2_ADDR_NON_DISCLOSURE_FLAG, %Le%.REG_2_LAW_ENFORCEMENT_FLAG, %Le%.REG_2_ADDRESS_NUMBER, %Le%.REG_2_FOREIGN_ADDRESS_FLAG,
				   %Le%.REG_2_STREET_ADDRESS, %Le%.REG_2_APARTMENT_NUMBER, %Le%.REG_2_CITY, %Le%.REG_2_STATE, %Le%.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,
				   %Le%.REG_2_RESIDENCE_COUNTY, %Le%.ACTIVITY_DATExBG6, %Le%.TITLE_NUMBERxBG9, %Le%.TITLE_ISSUE_DATE, %Le%.PREVIOUS_TITLE_ISSUE_DATE,
				   %Le%.TITLE_STATUS_CODE, %Le%.TITLE_TYPE, %Le%.TITLE_PENDING_FLAG, %Le%.DUPLICATE_TITLE_FLAG, %Le%.LIEN_COUNTxBG10,
				   %Le%.LH_1_LIEN_DATE, %Le%.LEIN_HOLDER_1_CUSTOMER_TYPE, %Le%.LH_1_FEID_SSN, %Le%.LH_1_CUSTOMER_NAME, %Le%.LH_1_DEALER_LICENSE_NUMBER,
				   %Le%.LH_1_DRIVER_LICENSE_NUMBER, %Le%.LH_1_DOB, %Le%.LH_1_SEX, %Le%.LH_1_SEXUAL_PREDATOR_FLAG, %Le%.LH_1_MAIL_SUPPESSION_FLAG,
				   %Le%.LH_1_ADDR_NON_DISCLOSURE_FLAG, %Le%.LH_1_LAW_ENFORCEMENT_FLAG, %Le%.LH_1_ADDRESS_NUMBER, %Le%.LH_1_FOREIGN_ADDRESS_FLAG,
				   %Le%.LH_1_STREET_ADDRESS, %Le%.LH_1_APARTMENT_NUMBER, %Le%.LH_1_CITY, %Le%.LH_1_STATE, %Le%.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,
				   %Le%.LH_1_RESIDENCE_COUNTY);

/* ************************ use a very slimmed to dedup and and make history *********** */

#uniquename(VerySlimmed_Layout)
#uniquename(vehicle_id)
#uniquename(record_id)
#uniquename(slimmit)
#uniquename(VerySlim)
#uniquename(removeDups)
#uniquename(SlimGroup)
#uniquename(makeHistory)
#uniquename(SlimIterate)
#uniquename(SlimUse)

// extract useful info
%VerySlimmed_Layout% :=
RECORD
		// identifiers
	%vs%.seq_no;
	%vs%.orig_vin;
	DATA16 %vehicle_id%;
	DATA16 %record_id%;
		// dates
	UNSIGNED4 dt_last_seen;// := %vs%.dt_last_seen;
	UNSIGNED4 dt_first_seen;// := %vs%.dt_first_seen;
	UNSIGNED4 REGISTRATION_EXPIRATION_DATE;// := %vs%.REGISTRATION_EXPIRATION_DATE;
	UNSIGNED4 title_issue_date;// := %vs%.title_issue_date;
		// will fill in
	%vs%.history;
		// need for vina join
	%vs%.Year_Make;
END;


%VerySlimmed_Layout% %slimmit%(%vs% L) :=
TRANSFORM
	SELF.history := MAP(l.history<>'' => l.history,
						l.registration_expiration_date[1..6] < ut.GetDate[1..6] => 'E',
						'');
	SELF.%vehicle_id% := %get_vehicle_id%(L);
	SELF.%record_id% := %get_record_id%(L);
	SELF.dt_last_seen := (INTEGER)L.dt_last_seen;
	SELF.dt_first_seen := (INTEGER)L.dt_first_seen;
	SELF.REGISTRATION_EXPIRATION_DATE := (INTEGER)L.REGISTRATION_EXPIRATION_DATE;
	SELF.title_issue_date := (INTEGER)L.title_issue_date;
	SELF := L;
END;
%VerySlim% := PROJECT(%vs%, %Slimmit%(LEFT));

// use the very slim to dedup and find historical/expireds
%removeDups% := DEDUP(SORT(%VerySlim%, %record_id%), %record_id%);

%SlimGroup% := group(
			     sort(%removeDups%,
				      %vehicle_id%, -dt_last_seen, -dt_first_seen, -REGISTRATION_EXPIRATION_DATE,
					  -title_issue_date), %vehicle_id%);

%VerySlimmed_Layout% %makeHistory%(%VerySlimmed_Layout% L, %VerySlimmed_Layout% R) :=
TRANSFORM
	self.dt_last_seen := if(R.dt_last_seen > 0 and L.dt_first_seen > R.dt_last_seen,
							L.dt_first_seen, R.dt_last_seen);
	SELF.history := if (L.seq_no = 0,						// This is the non-historical record
							IF(R.history = 'E', 'E', ''),	// But still can be expired
							'H');							// Otherwise, its historical
	SELF := R;
END;
%SlimIterate% := GROUP(ITERATE(%SlimGroup%, %makeHistory%(LEFT, RIGHT)));

%SlimUse% := SORT(DISTRIBUTE(%SlimIterate%, %get_node%(seq_no)), seq_no, LOCAL);

/* **************************** Handle the vehicle side ************************************** */

#uniquename(toVehicleFields)
#uniquename(VehicleFields)
#uniquename(VinMatch)
#uniquename(vvin)
#uniquename(vina)
#uniquename(vin_slim)
#uniquename(addSeqToVina)
#uniquename(SequencedVina)
#uniquename(SortDistVina)
#uniquename(withHistory)

// project down from fat to just vehicle data
doxie_files.Layout_VehicleVehicles %toVehicleFields% (%vs% L) :=
TRANSFORM
	// make this identical to standard build for comparison to original Vehicle Process
	self.VEHICLE_NUMBERxBG1 := MAP (L.VEHICLE_NUMBERxBG1 ~IN ['', 'NONE'] => L.VEHICLE_NUMBERxBG1,
                                    vehlic.ValidVin(L.orig_vin) => L.orig_vin,
                                    (string20)HASH(L.orig_vin, L.LICENSE_PLATE_NUMBERxBG4, 
													L.own_1_customer_name, L.reg_1_customer_name));
	SELF := L;
END;
%VehicleFields% := PROJECT(%vs%, %toVehicleFields%(LEFT));

// get vinafile
%VinMatch%(string17 %vvin%) := %vvin%[1..10];
%vina% := doxie_files.File_SavedVina;

#uniquename(addFields)
doxie_files.Layout_slimvin %addFields%(%vina% L) :=
TRANSFORM
	SELF.seq_no := 0;
	// SELF.vrid := 0;
	SELF.history := '';
	SELF := L;
END;
%vin_slim% := PROJECT(%vina%, %addFields%(LEFT));

doxie_files.Layout_slimvin %addSeqToVina%(%SlimIterate% L, %vin_slim% R) :=
TRANSFORM
	SELF.seq_no := L.seq_no;
	SELF.history := L.history;
	// SELF.vrid := L.vrid;
	SELF := R;
END;
// bottleneck: LEFT dataset is wide
%SequencedVina% := JOIN(%SlimIterate%, %vin_slim%,
					    %VinMatch%(LEFT.orig_vin) = %VinMatch%(RIGHT.vin) AND (INTEGER)LEFT.Year_Make >= 1981,
					    %addSeqToVina%(LEFT, RIGHT), LEFT OUTER);

// bottleneck: RIGHT dataset is wide
%SortDistVina% := SORT(DISTRIBUTE(%SequencedVina%, %get_node%(seq_no)), seq_no, LOCAL);

// join back, which will remove dups and set history
// additionally, perform any conversions that need to be done
%withHistory% := JOIN(SORTED(%VehicleFields%, seq_no), %SortDistVina%, LEFT.seq_no = RIGHT.seq_no, 
														doxie_build.TRA_VinJoin(RIGHT, LEFT), NOSORT, LOCAL);

VehFileOut := %withHistory%;

/* **************************** Handle the Person side ************************************** */

#uniquename(i_blank)
#uniquename(Zip4ToInteger)
#uniquename(pZip4In)
#uniquename(pretty_zip)
#uniquename(propagateAddresses)
#uniquename(removePersons)
#uniquename(nonDups)
#uniquename(PropagatedAddresses)
#uniquename(blanknames)
#uniquename(PersonFields)
#uniquename(lef)
#uniquename(rig)
#uniquename(LienHolders)
#uniquename(inBatch)
#uniquename(inPersons)
#uniquename(outPersons)
#uniquename(idDid)
#uniquename(stripDIDs)
#uniquename(justidDid)
#uniquename(addDID)
#uniquename(personsDIDd)
#uniquename(orig_seq_no)
#uniquename(allContacts)
#uniquename(cleanPersonFields)
#uniquename(personsCleaned)
#uniquename(pZipIn)
#uniquename(best_ssn)
#uniquename(lefOut)
#uniquename(rigOut)
#uniquename(fNameTest)
#uniquename(lNameTest)
#uniquename(coNameTest)
#uniquename(skipDIDing)


// Here, we are propagating own_1 address for own_2, reg_1, reg_2 if its name !blank and address is blank
// somewhat "loose" in giving out addresses
%i_blank%(STRING %lefOut%, STRING %rigOut%, STRING %fNameTest%, STRING %lNameTest%, STRING %coNameTest%) :=
  if ((%fNameTest% = '' or %lNametest% = '') and %coNameTest% = '' or %rigOut% <> '', %rigOut%, %lefOut%);

integer2 %Zip4ToInteger%(string4 %pZip4In%) := (integer2)%pZip4In%;

string10 %pretty_zip%(string10 %pZipIn%) := 
 %pZipIn%[1..5] + 
	if(%pZipIn%[6]='-',
	   if(%zip4ToInteger%(%pZipIn%[7..10]) = 0,
		  '',
		  '-' + %pZipIn%[7..10]
		 ),
	   if(%Zip4ToInteger%(%pZipIn%[6..9]) = 0,
		  '',
		  '-' + %pZipIn%[6..9]
		 )
	  );

doxie_files.Layout_Vehicles %propagateAddresses%(doxie_files.Layout_Vehicles ri) :=
TRANSFORM
  SELF.own_2_prim_range := %i_blank%(ri.own_1_prim_range, 	ri.own_2_prim_range,	ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_predir 	:= %i_blank%(ri.own_1_predir, 		ri.own_2_predir, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_prim_name	:= %i_blank%(ri.own_1_prim_name, 	ri.own_2_prim_name,		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_suffix 	:= %i_blank%(ri.own_1_suffix, 		ri.own_2_suffix, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_postdir	:= %i_blank%(ri.own_1_postdir, 		ri.own_2_postdir, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_unit_desig	:= %i_blank%(ri.own_1_unit_desig, 	ri.own_2_unit_desig,	ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_p_city_name:= %i_blank%(ri.own_1_p_city_name,	ri.own_2_p_city_name, 	ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_v_city_name:= %i_blank%(ri.own_1_v_city_name,	ri.own_2_v_city_name, 	ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_state_2 	:= %i_blank%(ri.own_1_state_2, 		ri.own_2_state_2, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_zip5 		:= %i_blank%(ri.own_1_zip5, 		ri.own_2_zip5, 			ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_zip4 		:= %i_blank%(ri.own_1_zip4, 		ri.own_2_zip4, 			ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_county 	:= %i_blank%(ri.own_1_county, 		ri.own_2_county, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_geo_lat 	:= %i_blank%(ri.own_1_geo_lat, 		ri.own_2_geo_lat, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  SELF.own_2_geo_long 	:= %i_blank%(ri.own_1_geo_long, 	ri.own_2_geo_long, 		ri.own_2_fname, ri.own_2_lname, ri.own_2_company_name);
  
  SELF.reg_1_prim_range := %i_blank%(ri.own_1_prim_range, 	ri.reg_1_prim_range,	ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_predir 	:= %i_blank%(ri.own_1_predir, 		ri.reg_1_predir, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_prim_name	:= %i_blank%(ri.own_1_prim_name, 	ri.reg_1_prim_name,		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_suffix 	:= %i_blank%(ri.own_1_suffix, 		ri.reg_1_suffix, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_postdir	:= %i_blank%(ri.own_1_postdir, 		ri.reg_1_postdir, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_unit_desig	:= %i_blank%(ri.own_1_unit_desig, 	ri.reg_1_unit_desig,	ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_p_city_name:= %i_blank%(ri.own_1_p_city_name,	ri.reg_1_p_city_name, 	ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_v_city_name:= %i_blank%(ri.own_1_v_city_name,	ri.reg_1_v_city_name, 	ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_state_2 	:= %i_blank%(ri.own_1_state_2, 		ri.reg_1_state_2, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_zip5 		:= %i_blank%(ri.own_1_zip5, 		ri.reg_1_zip5, 			ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_zip4 		:= %i_blank%(ri.own_1_zip4, 		ri.reg_1_zip4, 			ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_county 	:= %i_blank%(ri.own_1_county, 		ri.reg_1_county, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_geo_lat 	:= %i_blank%(ri.own_1_geo_lat, 		ri.reg_1_geo_lat, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);
  SELF.reg_1_geo_long 	:= %i_blank%(ri.own_1_geo_long, 	ri.reg_1_geo_long, 		ri.reg_1_fname, ri.reg_1_lname, ri.reg_1_company_name);

  SELF.reg_2_prim_range := %i_blank%(ri.reg_1_prim_range, 	ri.reg_2_prim_range,	ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_predir 	:= %i_blank%(ri.reg_1_predir, 		ri.reg_2_predir, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_prim_name	:= %i_blank%(ri.reg_1_prim_name, 	ri.reg_2_prim_name,		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_suffix 	:= %i_blank%(ri.reg_1_suffix, 		ri.reg_2_suffix, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_postdir	:= %i_blank%(ri.reg_1_postdir, 		ri.reg_2_postdir, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_unit_desig	:= %i_blank%(ri.reg_1_unit_desig, 	ri.reg_2_unit_desig,	ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_p_city_name:= %i_blank%(ri.reg_1_p_city_name,	ri.reg_2_p_city_name, 	ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_v_city_name:= %i_blank%(ri.reg_1_v_city_name,	ri.reg_2_v_city_name, 	ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_state_2 	:= %i_blank%(ri.reg_1_state_2, 		ri.reg_2_state_2, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_zip5 		:= %i_blank%(ri.reg_1_zip5, 		ri.reg_2_zip5, 			ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_zip4 		:= %i_blank%(ri.reg_1_zip4, 		ri.reg_2_zip4, 			ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_county 	:= %i_blank%(ri.reg_1_county, 		ri.reg_2_county, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_geo_lat 	:= %i_blank%(ri.reg_1_geo_lat, 		ri.reg_2_geo_lat, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);
  SELF.reg_2_geo_long 	:= %i_blank%(ri.reg_1_geo_long, 	ri.reg_2_geo_long, 		ri.reg_2_fname, ri.reg_2_lname, ri.reg_2_company_name);

  self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL := %pretty_zip%(ri.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL := %pretty_zip%(ri.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL := %pretty_zip%(ri.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL);
  self.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL := %pretty_zip%(ri.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL);
  SELF := ri;
END;

// first, remove records that have been dedup'd above
doxie_files.Layout_Vehicles %removePersons%(doxie_files.Layout_Vehicles L, %VerySlimmed_Layout% R) :=
TRANSFORM
	SELF := L;
END;
%nonDups% := JOIN(SORTED(%vs%, seq_no), %SlimUse%, LEFT.seq_no = RIGHT.seq_no, 
												   %removePersons%(LEFT, RIGHT), NOSORT, LOCAL);

%PropagatedAddresses% := PROJECT(%nonDups%, %PropagateAddresses%(LEFT));

%blanknames% := ['NOT ON FILE', 'NOT AVAILABLE'];

// Pull out owners and registrants
%PersonFields% := NORMALIZE(%PropagatedAddresses%, 4, 
							doxie_build.TRA_NormContacts(LEFT, COUNTER))
							((lname != '' or company_name != '') AND orig_name ~IN %blanknames%);

// Pull out lien holders.  Different because these do not get cleaned/did'd
%LienHolders% := NORMALIZE(%nonDups%, 3, doxie_build.TRA_NormLiens(LEFT, COUNTER))
							(orig_name != '' AND orig_name ~IN %blanknames%);

// project into roxie format
didville.Layout_Did_InBatch %inBatch%(%PersonFields% L) :=
TRANSFORM
	SELF.seq := L.seq_no;
	SELF.suffix := L.name_suffix;
	SELF.p_city_name := L.p_city_name;
	SELF.z5 := L.zip5;
	SELF.phone10 := '';
	SELF := L;
END;
%inPersons% := PROJECT(%PersonFields%, %inBatch%(LEFT))(fname != '' OR lname != '');

#uniquename(matchset)
#uniquename(outpersons1)
#uniquename(outpersons2)
#uniquename(toOutBatch)
#uniquename(best_dob)
#uniquename(get_best_dob)
#uniquename(no_best_dob)

// strip down to roxie id, did, best ssn
%idDid% :=
RECORD
	%PersonFields%.seq_no;
	integer %orig_seq_no%;
	%PersonFields%.did;
	string9 %best_ssn%;
	string8 %best_dob%;
END;


#if(did_how = 'remote')
DID_Add.Mac_Match_Fast_Roxie(%inPersons%, %outPersons%, '', 'BEST_SSN,BEST_DOB',,'true')

%idDid% %stripDIDs% (didville.Layout_Did_OutBatch L) :=
TRANSFORM
	unsigned did_ok := L.did_score >= 75;
	SELF.did := IF(did_ok, L.did, 0);
	SELF.%best_ssn% := IF(did_ok, L.best_ssn, '');
	SELF.%orig_seq_no% := L.seq - (L.seq % 4);
	SELF.seq_no := L.seq;
	SELF.%best_dob% := IF(did_ok, L.best_dob, '');
END;
%justidDid% := PROJECT(%outPersons%, %stripDIDs%(LEFT));
#end

#if(did_how = 'hash')
did_add.mac_match_hash_roxie(%inPersons%, %outPersons%)

%idDid% %stripDIDs% (didville.layout_did_hash_out L) :=
TRANSFORM
	SELF.did := L.did;
	SELF.%best_ssn% := '';
	SELF.%orig_seq_no% := L.seq - (L.seq % 4);
	SELF.seq_no := L.seq;
	SELF.%best_dob% := '';
END;
%justidDid% := PROJECT(%outPersons%, %stripDIDs%(LEFT));
#end

#if(did_how = 'local')
%matchset% := ['A', 'D', 'S', 'P', '4', 'G', 'Z'];
DID_Add.MAC_Match_Fast(%inPersons%, %matchset%, %outPersons%, false, false)

%idDid% %get_best_dob%(watchdog.File_Best L, %outPersons% R) :=
TRANSFORM
	SELF.seq_no := R.seq;
	SELF.%orig_seq_no% := R.seq - (R.seq % 4);
	SELF.did := R.did;
	SELF.%best_ssn% := L.ssn;
	SELF.%best_dob% := (STRING)L.dob;
END;

%idDid% %no_best_dob%(%outPersons% R) :=
TRANSFORM
	SELF.seq_no := R.seq;
	SELF.%orig_seq_no% := R.seq - (R.seq % 4);
	SELF.did := 0;
	SELF.%best_ssn% := '';
	SELF.%best_dob% := '';
END;

#uniquename(outPersons1)
#uniquename(outPersons2)
#uniquename(outPersons3)

%outPersons1% := DISTRIBUTE(%outPersons%,HASH(did));
ut.mac_split_withdups_local(%outPersons1%,did,1000,%outPersons2%,%outPersons3%)

%justidDid% := JOIN(watchdog.File_Best, %outPersons2%(did != 0, did_score >= 75), 
				LEFT.did = RIGHT.did, %get_best_dob%(LEFT, RIGHT), LOCAL) +
			PROJECT(%outPersons2%(did = 0 OR did_score < 75)+%outPersons3%, %no_best_dob%(LEFT));
#end

// join back to full person dataset
doxie_files.Layout_VehicleContacts %addDID%(doxie_files.Layout_VehicleContacts L, %idDID% R) :=
TRANSFORM
	SElF.seq_no := R.%orig_seq_no%;
	SELF.did := R.did;
	SELF.ssn := R.%best_ssn%;
	SELF.best_dob := R.%best_dob%;
	SELF := L;
END;

#uniquename(sortedJustidDID)
%sortedJustidDID% := DISTRIBUTE(%justidDid%, %get_node%(%orig_seq_no%));

%personsDIDd% := JOIN(SORTED(%PersonFields%, seq_no), 
						%sortedJustidDID%, LEFT.seq_no = RIGHT.seq_no,
						%addDID%(LEFT, RIGHT), LOCAL);


#uniquename(personsNotDIDd)
#uniquename(fixSeqNo)
doxie_files.Layout_VehicleContacts %fixSeqNo%(doxie_files.Layout_VehicleContacts L) :=
TRANSFORM
	SELF.seq_no := L.seq_no - (L.seq_no % 4);
	SELF := L
END;
%personsNotDIDd% := PROJECT(%PersonFields%, %fixSeqNo%(LEFT));

%allContacts% := IF(didPersons, %personsDIDd%, %personsNotDIDd%) + %PersonFields%(fname = '' AND lname = '') + %LienHolders%;

// PROJECT here for some extra cleaning
doxie_files.Layout_VehicleContacts %cleanPersonFields%(doxie_files.Layout_VehicleContacts L) :=
TRANSFORM
    self.orig_addr_state := MAP( l.orig_street_address='' or l.orig_addr_state <> '' => l.orig_addr_state,
								 l.orig_state = l.st => l.st, 
								 '');
								 
    self.ZIP5_ZIP4_FOREIGN_POSTAL :=
      MAP( l.zip5_zip4_foreign_Postal <> '' or 
				 (l.orig_addr_city <> l.v_city_name and l.orig_addr_city <> l.p_city_name) or
				 (l.orig_street_address) = '' 	=> l.zip5_zip4_foreign_postal,
           l.zip4 <> '' 						=> l.zip5+'-'+l.zip4,
           l.zip5 );
        
    self.customer_type := IF(L.rec_source[1..4] = 'lien',
							 // lien holder
							 MAP (l.customer_type <> '' => l.customer_type,
							 l.orig_name <> '' 			=> 'U', 
							 '' ),
							 // owner/registrant
							 MAP(l.customer_type <> '' 	=> l.customer_type,
								 l.orig_name <> '' 		=> 'B',
								 l.lname <> '' 			=> 'I', 
								 '' ));
	SELF := L;
END;

%personsCleaned% := PROJECT(%allContacts%, %cleanPersonFields%(LEFT));

PerFileOut := %personsCleaned%;

ENDMACRO;