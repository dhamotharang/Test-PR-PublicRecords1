import fieldstats,fair_isaac, codes, did_add, didville, VehLic, ut, VehicleCodes, header_slimsort, watchdog, vehicle_wildcard, doxie_files;

//Use development version.
f := dataset('~thor_data400::base::Vehicles_' + Vehlic.Version_Development,vehlic.layout_vehicles,flat,unsorted,__compressed__);;

doxie_files.Layout_VehicleVehicles justVeh(f le) :=
TRANSFORM
	SELF.vid := TRIM(if(vehlic.ValidVin(le.orig_vin), 
				(qstring)le.orig_vin,
				(qstring)HASH64(le.orig_vin, le.LICENSE_PLATE_NUMBERxBG4, le.own_1_customer_name, 
							 le.reg_1_customer_name, le.orig_state, le.year_make, le.make_code, 
							 le.model_description)), LEFT);
	SELF := le;
	SELF.record_type := '';
END;
vehout := PROJECT(f,justVeh(LEFT));

doxie_files.Layout_Vehicles tostd(f le) :=
TRANSFORM
	SELF.own_1_bdid := (INTEGER)le.own_1_bdid;
	SELF.own_2_bdid := (INTEGER)le.own_2_bdid;
	SELF.reg_1_bdid := (INTEGER)le.reg_1_bdid;
	SELF.reg_2_bdid := (INTEGER)le.reg_2_bdid;
	SELF := le;
END;

// normalize separately: contacts will get "best" info later
norm_contacts := NORMALIZE(PROJECT(f,tostd(LEFT)),4,tra_normcontacts(LEFT, COUNTER))
										((lname != '' or company_name != '') AND orig_name ~IN ['NOT ON FILE', 'NOT AVAILABLE']);

norm_liens    := NORMALIZE(PROJECT(f,tostd(LEFT)), 3, TRA_NormLiens(LEFT, COUNTER))
										(orig_name != '' AND orig_name ~IN ['NOT ON FILE', 'NOT AVAILABLE']);

// Append "best" information (so far just DOB). Only for "contacts"
// Using best non-glb to be on a safe side.
Layout_VehicleContacts := doxie_files.Layout_VehicleContacts;

Layout_VehicleContacts GetBest (Layout_VehicleContacts L, watchdog.Key_watchdog_nonglb R) := TRANSFORM
  SELF.best_dob := (string8) R.dob;
  SELF := L;
END;

contacts_add := JOIN (norm_contacts, watchdog.Key_watchdog_nonglb,
                      (Left.did != 0 AND Left.dob = '') AND
                       keyed (Left.did = Right.did),
                       GetBest (Left, Right), LEFT OUTER, KEEP (1));

perout := contacts_add + norm_liens;

ut.MAC_SF_BuildProcess(perout,'~thor_data400::base::perout'+doxie_build.buildstate,out1,,,true)
ut.MAC_SF_BuildProcess(VehOut,'~thor_data400::base::vehout'+doxie_build.buildstate,out2,,,true)

email := fileservices.sendemail('asiddique@seisint.com;djustin@seisint.com','Vehicle Stats Done',
				'Vehicle build and stats done on ' + ut.GetDate + '\r\n' + 
				'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

export Proc_Build_Vehicle_Search_Base := sequential(/*stats,*/out1,out2/*,email*/);