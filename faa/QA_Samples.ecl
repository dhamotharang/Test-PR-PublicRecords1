import data_services;

EXPORT QA_Samples := function

//airmen samples
dAmen_new := sort(distribute(faa.file_airmen_data_out, hash(unique_id, orig_rec_type, orig_fname, orig_lname, street1, street2, city, state, zip_code, country, region, med_class, med_date, med_exp_date)),
															unique_id, orig_rec_type, orig_fname, orig_lname, street1, street2, city, state, zip_code, country, region, med_class, med_date, med_exp_date, current_flag, -date_last_seen,local); 
dAmen_old := dataset(data_services.foreign_prod + 'thor_data400::base::faa_airmen_father',faa.layout_airmen_data_out,flat);
dAmen_old_srt := sort(distribute(dAmen_old, hash(unique_id, orig_rec_type, orig_fname, orig_lname, street1, street2, city, state, zip_code, country, region, med_class, med_date, med_exp_date)),
															unique_id, orig_rec_type, orig_fname, orig_lname, street1, street2, city, state, zip_code, country, region, med_class, med_date, med_exp_date, current_flag, -date_last_seen,local);
										
Amen_updates := join ( dAmen_new, dAmen_old_srt,
											left.unique_id			= right.unique_id and
											left.orig_rec_type	= right.orig_rec_type and 
											left.orig_fname			= right.orig_fname and
											left.orig_lname			= right.orig_lname and
											left.street1				= right.street1		and
											left.street2				= right.street2		and
											left.city						= right.city 	and
											left.state					= right.state and
											left.zip_code				= right.zip_code 	and	
											left.country				= right.country	and
											left.region					= right.region 	and
											left.med_class			= right.med_class	 and
											left.med_date				= right.med_date 	and
											left.med_exp_date		= right.med_exp_date,
											transform(recordof(dAmen_new),self := left),
												left only,local);
						 
Airmen_QA := output(choosen(Amen_updates,500),named('Airmen_Samples'));


//aircraft samples
dAircraft_new := dedup(sort(distribute(faa.file_aircraft_registration_out, hash(N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER)), 
											      N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER,current_flag, -date_last_seen,local),
																record, all,local);
dAircraft_new_sample := SAMPLE(dAircraft_new,10,1);

dAircraft_old := dataset(data_services.foreign_prod+'thor_data400::base::faa_aircraft_reg_father',faa.layout_aircraft_registration_out, flat);
dAircratf_dist :=  dedup(sort(distribute(dAircraft_old, hash(N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER)), 
											            N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER,current_flag, -date_last_seen,local),
																		record, all,local);
								

Aircraft_updates := join (dAircraft_new_sample, dAircratf_dist,
												  LEFT.N_NUMBER 				= RIGHT.N_NUMBER and 
													LEFT.SERIAL_NUMBER 		= RIGHT.SERIAL_NUMBER and  
													LEFT.MFR_MDL_CODE			= RIGHT.MFR_MDL_CODE and
													LEFT.ENG_MFR_MDL 			= RIGHT.ENG_MFR_MDL and 
													LEFT.YEAR_MFR 				= RIGHT.YEAR_MFR and 
													LEFT.TYPE_REGISTRANT 	=	RIGHT.TYPE_REGISTRANT and 
													LEFT.NAME							= RIGHT.NAME and
													LEFT.STREET 					= RIGHT.STREET and 
													LEFT.STREET2 					= RIGHT.STREET2 and 
													LEFT.CITY 						= RIGHT.CITY  and 
													LEFT.STATE 						= RIGHT.STATE and 
													LEFT.ZIP_CODE 				= RIGHT.ZIP_CODE and  
													LEFT.REGION 					= RIGHT.REGION and 
													LEFT.ORIG_COUNTY 			= RIGHT.ORIG_COUNTY and  
													LEFT.COUNTRY 					= RIGHT.COUNTRY and 
													LEFT.LAST_ACTION_DATE = RIGHT.LAST_ACTION_DATE and 
													LEFT.CERT_ISSUE_DATE	= RIGHT.CERT_ISSUE_DATE and 
													LEFT.CERTIFICATION    = RIGHT.CERTIFICATION and 
													LEFT.TYPE_AIRCRAFT 		= RIGHT.TYPE_AIRCRAFT and 
													LEFT.TYPE_ENGINE 			= RIGHT.TYPE_ENGINE and 
													LEFT.STATUS_CODE 			= RIGHT.STATUS_CODE and 
													LEFT.MODE_S_CODE      = RIGHT.MODE_S_CODE and 
													LEFT.FRACT_OWNER 			= RIGHT.FRACT_OWNER,
															transform(recordof(dAircraft_new_sample),self := left),
															left only,local);
						 
Aircraft_QA := output(choosen(Aircraft_updates,500),named('Aircraft_Samples'));

return parallel( Airmen_QA, Aircraft_QA );
end;
