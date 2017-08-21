


// address input file
ds_iMapData_address_input_file :=
  dataset([	
				 {'1',	'2600 Ernie Pyle Dr','',		'Ft. Meade',	'MD',	'20775'},
				 {'2',	'8825 Beulah St',	'',	'Ft. Belvoir'	,'VA'	,'22060'},
				 {'3',	'407 Holbrook Ave',	'',	'Fort Riley'	,'KS'	,'66442'}

		     ], SOFF_ReSOLT_Integration.Layout_iMapData_address_input_file);
				 
output(ds_iMapData_address_input_file);

// get distinct input zip codes.  
// Do not want to send same zip codes more than once to ziplib.ZipsWithinRadius function
get_distinct_input_zips := dedup(sort(
                             table(ds_iMapData_address_input_file,{input_zip_Code}),
																	input_zip_Code),
																	 input_zip_Code);
output(get_distinct_input_zips);		 

layout_zip_with_radius := record
string input_Zip_Code;
set of integer zip_radius_func_output;
string radius;
end;

layout_zip_with_radius tr_get_zips_within_radius(get_distinct_input_zips L) := TRANSFORM
self.input_Zip_Code := l.input_zip_code;
self.zip_radius_func_output :=  ziplib.ZipsWithinRadius(l.input_zip_Code, 50); //call function to get zips with radius
self.radius := '50';
end;

p := project(get_distinct_input_zips,tr_get_zips_within_radius(LEFT)); 
output(choosen(p,all));

r := normalize(p, count(left.zip_radius_func_output), transform({recordof(p), string zip_within_radius},
																			self.zip_within_radius := (string) left.zip_radius_func_output[counter];
																			self := left));																			
// output(choosen(r(input_Zip_Code = '20775'), all));
// output(choosen(r(input_Zip_Code = '22060'), all));
output(choosen(r(input_Zip_Code = '66442'), all));

// get distinct zip radius codes. Need distinct because over lapping zip_within_radius 
get_distinct_zip_radius_codes := dedup(sort(
                                    table(r,{zip_within_radius}),
																	    zip_within_radius),
																     	 zip_within_radius)
									: persist ('~thor_data400::persist::get_distinct_zip_radius_codes');										 
output(choosen(get_distinct_zip_radius_codes, all));																		 

// Get address extract 50_mile radius
join_soff_address_50_state_extract_with_distinct_zip_radius_codes := 
                       join(SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Addresses,get_distinct_zip_radius_codes,
                                       left.zip = right.zip_within_radius)
															: persist ('~thor_data400::persist::join_soff_address_50_state_extract_with_distinct_zip_radius_codes');  
output(join_soff_address_50_state_extract_with_distinct_zip_radius_codes);

SOFF_ReSOLT_Integration.Layout_SOR_Address_out  tr_get_address_extract_50_mile_radius
                         (join_soff_address_50_state_extract_with_distinct_zip_radius_codes L ) := TRANSFORM
SELF := L;
end;

SORAdd_extraxt_50_mile_radius := 
       PROJECT(join_soff_address_50_state_extract_with_distinct_zip_radius_codes,
			                  tr_get_address_extract_50_mile_radius(LEFT))
												: persist ('~thor_data400::persist::SORAdd_50_mile_radius_extract');
output(SORAdd_extraxt_50_mile_radius);																								 
																													 
// get distinct seisint_primary_key from SORAdd_extraxt_50_mile_radius. 
get_distinct_seisint_primary_key := dedup(sort(
                                      table(SORAdd_extraxt_50_mile_radius,{seisint_primary_key}),
													       				seisint_primary_key),
															        		 seisint_primary_key);
output(get_distinct_seisint_primary_key);

// Get main extract 50_mile radius
join_SORMain_50_state_extract_with_seisint_primary_key :=
                          join(SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Main,get_distinct_seisint_primary_key,
                               left.seisint_primary_key  = right.seisint_primary_key)
														 		: persist ('~thor_data400::persist::SORMain_50_mile_radius_extract');
output(join_SORMain_50_state_extract_with_seisint_primary_key);
 																							 

// Get vehicle extract 50_mile radius
join_SORVeh_50_state_extract_with_seisint_primary_key := 
                         join(SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Vehicles,get_distinct_seisint_primary_key,
                              left.seisint_primary_key  = right.seisint_primary_key)
													     : persist ('~thor_data400::persist::SORVeh_50_mile_radius_extract');
output(join_SORVeh_50_state_extract_with_seisint_primary_key);																								 
																								 
// get offense_extract 50_mile radius 
join_SORoff_50_state_extract_with__seisint_primary_key := 
                          join(SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Offense,get_distinct_seisint_primary_key,
                                left.seisint_primary_key  = right.seisint_primary_key)
															  : persist ('~thor_data400::persist::SORoff_50_mile_radius_extract');																								 
output(join_SORoff_50_state_extract_with__seisint_primary_key);	

// get images for main extract 50_mile radius
get_images_50MR_Offenders := dedup(sort(
							               		    	table(join_SORMain_50_state_extract_with_seisint_primary_key(image_link <>''),{image_link}),
																										image_link),
																											image_link)
																						: persist ('~thor_data400::persist::get_images_50MR_Offenders');
output(choosen(get_images_50MR_Offenders, all));



//**********************************************************
//**************generate csv file and despray.**************
//**********************************************************

p_filedate := '20130703';		

output(SORAdd_extraxt_50_mile_radius,,
	         '~thor_data400::persist::SORAdd_50_mile_radius_extract_delimited_'+ p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);

output(join_SORMain_50_state_extract_with_seisint_primary_key,,
	         '~thor_data400::persist::SORMain_50_mile_radius_extract_delimited_'+ p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);

output(join_SORVeh_50_state_extract_with_seisint_primary_key,,
	         '~thor_data400::persist::SORVeh_50_mile_radius_extract_delimited_'+ p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);

output(join_SORoff_50_state_extract_with__seisint_primary_key,,
	          '~thor_data400::persist::SORoff_50_mile_radius_extract_delimited_'+ p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);										
  

a := FileServices.DeSpray('~thor_data400::persist::SORAdd_50_mile_radius_extract_delimited_'+ p_filedate,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/iMAP/IMAP_ADDRESS_50MILE_EXTRACT_'+ p_filedate + '.csv',
										,
										,
										,
										TRUE);		

b := FileServices.DeSpray('~thor_data400::persist::SORMain_50_mile_radius_extract_delimited_'+ p_filedate,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/iMAP/IMAP_MAIN_50MILE_EXTRACT_'+ p_filedate + '.csv',
										,
										,
										,
										TRUE);	
										
c := FileServices.DeSpray('~thor_data400::persist::SORVeh_50_mile_radius_extract_delimited_'+ p_filedate,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/iMAP/IMAP_VEHICLE_50MILE_EXTRACT_'+ p_filedate + '.csv',
										,
										,
										,
										TRUE);	
										
d := FileServices.DeSpray('~thor_data400::persist::SORoff_50_mile_radius_extract_delimited_'+ p_filedate,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/iMAP/IMAP_OFFENSE_50MILE_EXTRACT_'+ p_filedate + '.csv',
										,
										,
										,
										TRUE);											

 sequential(a,b,c,d);

//


//Notes:		
//  SPK field length increase.	
//  check in attributes
// open .csv files in xls
