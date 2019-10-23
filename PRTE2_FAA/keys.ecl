import doxie_files, doxie, ut, Data_Services, fcra, BIPV2,autokey,AutoKeyB2,AutoKeyI, PRTE2_FAA;

EXPORT keys := module

//Airmen Certification Key
// FCRA Consumer Data Field Depreciation
shared fAirmenCert 	:= project(files.base_airmen_certs, {files.base_airmen_certs} - [cust_name,bug_name]);
export key_Certifications(boolean IsFCRA = false) := function
dsAirmenCert := fAirmenCert;
ut.MAC_CLEAR_FIELDS(dsAirmenCert, dsAirmenCert_cleared, constants.key_airmen_cert_set);
keyfile := if(isFCRA,dsAirmenCert_cleared, dsAirmenCert);
return index(keyfile,{uid := keyfile.unique_id},{keyfile},
													Data_Services.Data_location.Prefix('FAA')+ if(isFCRA, Constants.KEY_PREFIX_FCRA, Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::airmen_certs');

end;

//Airmen Keys
// FCRA Consumer Data Field Depreciation
export key_airmen_did(boolean IsFCRA = false) := function

filter_ds := files.Airmen_key((integer)did_out != 0);
ut.MAC_CLEAR_FIELDS(filter_ds, filter_ds_cleared, constants.key_airmen_did_set);
keyfile := if(isFCRA, filter_ds_cleared, filter_ds);
return index(keyfile, {UNSIGNED8 did := (UNSIGNED8)did_out, airmen_id}, {keyfile}, 
													Data_Services.Data_location.Prefix('FAA')+ if(isFCRA, Constants.KEY_PREFIX_FCRA, Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::airmen_did');
end;																													

shared fAirmen_no_source			:= project(files.Airmen_key, {files.Airmen_key} - source);
export key_airmen_rid(boolean IsFCRA = false)	:= index(fAirmen_no_source, {airmen_id,unique_id}, {fAirmen_no_source}, Data_Services.Data_location.Prefix('FAA')+ if(isFCRA, Constants.KEY_PREFIX_FCRA, Constants.KEY_PREFIX) + doxie.Version_SuperKey  + '::airmen_rid'); 
export key_airmen_id  := index(fAirmen_no_source, {unique_id,airmen_id}, {fAirmen_no_source}, Data_Services.Data_location.Prefix('FAA')+ Constants.KEY_PREFIX + doxie.Version_SuperKey + '::airmen_id'); 


//Aircraft Keys
aircraft_layout := record
recordof(Files.Aircraft_Reg_Key) - [aircraft_id,persistent_record_id] - BIPV2.IDlayouts.l_xlink_ids;
unsigned8 __fpos { virtual (fileposition)};
end;

shared fAircraft_doxie := project(Files.base_aircraft_reg, transform(aircraft_layout, self := left; self := []));
export key_aircraft_did_FCRA := index(fAircraft_doxie((integer)did_out > 0),{unsigned6 did := (integer)did_out},{fAircraft_doxie},'~thor_data400::key::fcra::' + doxie.Version_SuperKey + 'aircraft_reg_did');


export key_aircraft_did(boolean IsFCRA = false)		:= index(Files.base_aircraft_reg((integer)did_out != 0), 
																													{UNSIGNED6 did := (integer)did_out}, 
																													{n_number, aircraft_id,persistent_record_id}, 
																													Data_Services.Data_location.Prefix('FAA')+ if(isFCRA, Constants.KEY_PREFIX_FCRA + doxie.Version_SuperKey + '::aircraftreg_did', Constants.KEY_PREFIX + doxie.Version_SuperKey + '::aircraft_reg_did'));

export Key_Aircraft_reg_bdid  := index(Files.base_aircraft_reg((integer)bdid_out != 0),{unsigned6 bd := (integer)bdid_out},
																			{n_number, aircraft_id}, 
																			Data_Services.Data_location.Prefix('FAA')+ Constants.KEY_PREFIX + doxie.Version_SuperKey + '::aircraft_reg_bdid');



fAircraftReg := project(Files.Aircraft_Reg_Key, {Files.Aircraft_Reg_Key} - lf - BIPV2.IDlayouts.l_xlink_ids);
export key_aircraft_reg_nnum	:= index(fAircraftReg(n_number != ''), {n_number,aircraft_id}, {fAircraftReg},Data_Services.Data_location.Prefix('FAA') + Constants.KEY_PREFIX + doxie.Version_SuperKey + '::aircraft_reg_nnum');

// FCRA Consumer Data Field Depreciation
export key_aircraft_id(boolean IsFCRA = false) := function

fAircraftReg_withPersist := project(Files.Aircraft_Reg_Key, {Files.Aircraft_Reg_Key} - lf);
ut.MAC_CLEAR_FIELDS(fAircraftReg_withPersist, fAircraftReg_cleared, constants.key_aircraft_id_set);
fAircraftReg_new := if(isFCRA, fAircraftReg_cleared, fAircraftReg_withPersist);
return index(fAircraftReg_new, {aircraft_id}, {fAircraftReg_new}, 
													Data_Services.Data_location.Prefix('FAA')+ if(isFCRA, Constants.KEY_PREFIX_FCRA, Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::aircraft_id');

end;																																

// DEFINE THE LINKIDS INDEX
EXPORT key_aircraft_linkids := MODULE 
key_layout := record
recordof(Files.Aircraft_Reg_Linkids);
unsigned8 __fpos { virtual (fileposition)};
end;

shared fAircraftReg_Linkids := project(Files.Aircraft_Reg_Linkids(compname<>''), transform(key_layout, self := left, self := []));
shared superfile_name	:= Data_Services.Data_location.Prefix('FAA')+ Constants.KEY_PREFIX + doxie.Version_SuperKey +'::aircraft_linkids';

BIPV2.IDmacros.mac_IndexWithXLinkIDs(fAircraftReg_Linkids, k, superfile_name)
export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	// The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																													// Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																													// Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0													// Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;


//CREATE AUTOKEYS
export autokeys(string filedate):= function
		AutoKeyB2.MAC_Build (Files.ds_Autokeys_Prep,fname,mname,lname,
												 best_ssn,
												 zero,     //dob
												 zero,     // individual phone
												 prim_name,prim_range,st,p_city_name,zip,sec_range,
												 zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,zero,zero,
												 zero,
												 did_out,
												 compname,
												 zero,    //fein
												 zero,    //business phone
												 prim_name,prim_range,st,p_city_name,zip,sec_range,
												 bdid_out,
											   Constants.ak_keyname,
												 Constants.ak_logical(filedate),
												 bld_auto_keys,false,
								         Constants.set_skip,true,Constants.type_str,
												 true,,,zero); 

		

	AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, mymove,,Constants.set_skip); 

	retval := sequential(bld_auto_keys, mymove);

	return retval; 				
end;



export autokeys_airmen(string filedate) := function
		AutoKeyB2.MAC_Build (Files.Airmen_Autokeys_Prep,fname,mname,lname,
								best_ssn,
								zero,
								zero,
								prim_name,
								prim_range,
								st,
								p_city_name,
								zip,
								sec_range,
								zero,
								zero,zero,zero,
								zero,zero,zero,
								zero,zero,zero,
								zero,
								did_out6,
								blank,
								zero,
								zero,
								blank,blank,blank,blank,blank,blank,
								zero,
								Constants.ak_keyname_airmen,
								Constants.ak_logical_airmen(filedate),
								bld_auto_keys,false,
								Constants.ak_skip_airmen,true,Constants.type_str,
								true,,,zero); 

		AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname_airmen, mymove,, Constants.ak_skip_airmen); 

		retval := sequential(bld_auto_keys, mymove);

		return retval; 				
				
end;


export auto_payload := RECORD
unsigned6 fakeid;
layouts.Common_Aircraft_Airmen;
END;


shared dsPayload := dataset([],auto_payload);
export key_autokey_payload := index(dsPayload,{fakeid}, {dsPayload},Data_Services.Data_location.Prefix('FAA')+ Constants.autokeyname + doxie.Version_SuperKey + '::payload');


export auto_payload_airmen := RECORD
unsigned6 fakeid;
layouts.autokey_airmen;
END;

shared dsPayload_Airmen := dataset([],auto_payload_airmen);
export key_autokey_payload_airmen := index(dsPayload_Airmen,{fakeid}, {dsPayload_Airmen},Data_Services.Data_location.Prefix('FAA')+ Constants.autokeyname_airmen + doxie.Version_SuperKey + '::payload');


end;
