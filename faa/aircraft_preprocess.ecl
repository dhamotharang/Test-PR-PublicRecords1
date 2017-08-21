import lib_stringlib,ut,Address, mdr,std, Data_Services;

export aircraft_preprocess(string version) := function

//preprocess engine file
dInEngine := Aircraft_In_Allsrc.File_In_Engine  ;


layouts.aircraft_fixed.engine csv2fixedeng( dInEngine l) := transform
self.filedate := if(version <> '',version,(STRING8)Std.Date.Today());
self.engine_mfr_model_code := l.CODE;          
self.engine_mfr_name       := l.MFR;         
self.model_name            := l.MODEL;       
self.type_engine           := l.MTYPE;        
self.engine_hp_or_thrust   := l.HORSEPOWER;   
self.fuel_consumed         := l.FUEL_CONSUMED;
self := l;
end;

dInEngFix := project(dInEngine(StringLib.StringToUpperCase(trim(MFR)) <> 'MFR'),csv2fixedeng(LEFT));


dEngout := if(STD.File.SuperFileExists('~thor_data400::in::faa_aircraft_engine_ref_' + version),
																	output('FAA Aircraft Engine Ref file already built in previous run'),output(dInEngFix,,'~thor_data400::in::faa_aircraft_engine_ref_'+version,overwrite));

buildengine := sequential(dEngout,
													STD.File.StartSuperFileTransaction(),		
													STD.File.ClearSuperFile('~thor_data400::base::faa_engine_info_In'),
													STD.File.AddSuperFile('~thor_data400::base::faa_engine_info_in','~thor_data400::in::faa_aircraft_engine_ref_' + version),	
													STD.File.FinishSuperFileTransaction()
													);
		
		
//preprocess master file
dMasterIn := Aircraft_In_Allsrc.File_In_Master ;

//Adding function to trim entire file and remove unprintable characters
ut.CleanFields(dMasterIn, dMasterIn_cln);


layouts.aircraft_fixed.master csv2fixed ( dMasterIn_cln l) := transform
self.date_first_seen := if( version <> '',version,(STRING8)Std.Date.Today());
self.date_last_seen := if( version <> '',version,(STRING8)Std.Date.Today());
self.current_flag := 'A';
self.lf := '';
self := l;
end;


dMasterfx := project( dMasterIn_cln ( StringLib.StringToUpperCase(trim(SERIAL_NUMBER)) <> 'SERIAL_NUMBER'),csv2fixed(LEFT));

//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes name using the NID macro
	////////////////////////////////////////////////////////////////////////////////////// 


Layouts.aircraft_reg.temp  prepname( 	dMasterfx l ) := transform
	string50 temp_name := regexreplace('TRUSTEE',trim(l.NAME),'');
integer4 newindex := if (StringLib.StringFind(temp_name,'ATTN',1) = 0,length(temp_name),StringLib.StringFind(temp_name,'ATTN',1));
string1 type_registrant := l.TYPE_REGISTRANT[1..1];
prename := temp_name[1..newindex];
self.fullnm := prename;
self.orig_county            := l.COUNTY;
self := l;
self := [];
end;

dMasterprep := project( dMasterfx,prepname(left));

dMastername_cln := Standardize_Name.aircraft(dMasterprep).clname;

//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////  

combinedMain 		:= Standardize_Addr.aircraft(dMastername_cln).dbase : persist('~thor_data400::persist::faa_aircraft_cln');

set_cname :=  '(FLYING AS AERO CLUB|STEINER WARD R DBA TOUCH AND GO AVN|EAGLES WINGS FLIGHT TRAINING|WEST STAR FLYING CLUB|CHAPIN TERI INDEPENDENT EXECUTRIX|' +
																			'GRAND RIVER AIR|DOUG SLYS AERIAL SPRAYING|REGISTRATION|REPORTED )';

layout_aircraft_registration_in conv2orig( combinedMain l ) := transform
self.prim_range         :=  l.clean_address.prim_range  ;  
self.predir             :=  l.clean_address.predir      ;  
self.prim_name          :=  l.clean_address.prim_name   ;   
self.addr_suffix        :=  l.clean_address.addr_suffix ;  
self.postdir            :=  l.clean_address.postdir     ;  
self.unit_desig         :=  l.clean_address.unit_desig  ;   
self.sec_range          :=  l.clean_address.sec_range   ;  
self.p_city_name        :=  l.clean_address.p_city_name ;   
self.v_city_name        :=  l.clean_address.v_city_name ;   
self.st                 :=  l.clean_address.st          ;  
self.zip                :=  l.clean_address.zip         ;  
self.z4                 :=  l.clean_address.zip4          ;  
self.cart               :=  l.clean_address.cart        ;  
self.cr_sort_sz         :=  l.clean_address.cr_sort_sz  ;  
self.lot                :=  l.clean_address.lot         ;  
self.lot_order          :=  l.clean_address.lot_order   ;  
self.dpbc               :=  l.clean_address.dbpc        ;  
self.chk_digit          :=  l.clean_address.chk_digit   ;  
self.rec_type           :=  l.clean_address.rec_type    ;  
self.ace_fips_st        :=  l.clean_address.fips_state ;  
self.county             :=  l.clean_address.fips_county      ;  
self.geo_lat            :=  l.clean_address.geo_lat     ;   
self.geo_long           :=  l.clean_address.geo_long    ;   
self.msa                :=  l.clean_address.msa         ;  
self.geo_blk            :=  l.clean_address.geo_blk     ;  
self.geo_match          :=  l.clean_address.geo_match   ;  
self.err_stat           :=  l.clean_address.err_stat    ;  
self.title              :=  if ( regexfind(set_cname, trim(l.name)), '' ,l.clean_name.title )     ;  
self.fname              :=  if ( regexfind(set_cname, trim(l.name)), '' , l.clean_name.fname )    ;   
self.mname              :=  if ( regexfind(set_cname, trim(l.name)), '', l.clean_name.mname )    ;   
self.lname              :=  if ( regexfind(set_cname, trim(l.name)), '', l.clean_name.lname )    ;   
self.name_suffix        :=  if ( regexfind(set_cname, trim(l.name)), '',l.clean_name.name_suffix )    ;  
self := l;
end;

dMainstd := project( combinedMain , conv2orig( left ));

// Add name_type 

//Master previous Input file

Sequential ( STD.File.StartSuperFileTransaction(),
						 STD.File.ClearSuperFile('~thor_data400::in::faa_aircraft_father'),
			       STD.File.AddSuperFile('~thor_data400::in::faa_aircraft_father','~thor_data400::in::faa_aircraft_in',,true),
						 STD.File.FinishSuperFileTransaction()

						);

File_In_Previous_master := dataset('~thor_data400::in::faa_aircraft_father',layout_aircraft_registration_in ,flat);

//Adding function to trim entire file and remove unprintable characters
ut.CleanFields(File_In_Previous_master, File_In_Previous_master_cln);

addcurrent_flag := project(File_In_Previous_master_cln,transform(layout_aircraft_registration_in,self.current_flag := if ( left.current_flag = 'A' or  left.current_flag = 'I','I',left.current_flag),self := LEFT));

dmasteraddflag := sort(distribute((dMainstd + addcurrent_flag),hash(N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, 
																																		REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER)), 
																															N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, 
																															REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER,current_flag, -date_last_seen,local);
			

layout_aircraft_registration_in trollup( dmasteraddflag le, dmasteraddflag ri) := transform
self.date_first_seen := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
 self.date_last_seen :=  (string8)max((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
 self.current_flag := if ( le.current_flag <> '', le.current_flag , ri.current_flag );
self := le;
end;

File_rollup := sort(rollup(dmasteraddflag,
                          LEFT.N_NUMBER = RIGHT.N_NUMBER and 
													LEFT.SERIAL_NUMBER = RIGHT.SERIAL_NUMBER and  
													LEFT.MFR_MDL_CODE = RIGHT.MFR_MDL_CODE and
													LEFT.ENG_MFR_MDL = RIGHT.ENG_MFR_MDL and 
													LEFT.YEAR_MFR = RIGHT.YEAR_MFR and 
													LEFT.TYPE_REGISTRANT = RIGHT.TYPE_REGISTRANT and 
													LEFT.NAME = RIGHT.NAME and
													LEFT.STREET = RIGHT.STREET and 
													LEFT.STREET2 = RIGHT.STREET2 and 
													LEFT.CITY = RIGHT.CITY  and 
													LEFT.STATE = RIGHT.STATE and 
													LEFT.ZIP_CODE = RIGHT.ZIP_CODE and  
													LEFT.REGION = RIGHT.REGION and 
													LEFT.ORIG_COUNTY = RIGHT.ORIG_COUNTY and  
													LEFT.COUNTRY = RIGHT.COUNTRY and 
													LEFT.LAST_ACTION_DATE =RIGHT.LAST_ACTION_DATE and 
													LEFT.CERT_ISSUE_DATE =RIGHT.CERT_ISSUE_DATE and 
													LEFT.CERTIFICATION = RIGHT.CERTIFICATION and 
													LEFT.TYPE_AIRCRAFT = RIGHT.TYPE_AIRCRAFT and 
													LEFT.TYPE_ENGINE =RIGHT.TYPE_ENGINE and 
													LEFT.STATUS_CODE = RIGHT.STATUS_CODE and 
													LEFT.MODE_S_CODE =RIGHT.MODE_S_CODE and 
													LEFT.FRACT_OWNER = RIGHT.FRACT_OWNER,trollup(left,right), local),N_NUMBER,current_flag,-date_last_seen,local);      



//********VARIABLES*****************//
string8 previous_unique_id := '';
string8 current_unique_id := '';
//*********************************//
layout_aircraft_registration_in taddcodes(File_rollup l) := transform
previous_unique_id := current_unique_id;
current_unique_id := l.N_NUMBER;

self.current_flag := if(previous_unique_id = current_unique_id ,'H',l.current_flag);
self.MFR_MDL_CODE := l.MFR_MDL_CODE[1..7];
self := l;
end;

dMasterfinal := project(File_rollup,taddcodes(LEFT),local);

//Process Acftref file
File_raw_actref := Aircraft_In_Allsrc.File_In_actref ;


faa.layout_aircraft_info csv2fixedact( File_raw_actref l) := transform
self.filedate :=                  if(version <> '',version,(STRING8)Std.Date.Today());
self.aircraft_mfr_model_code     :=    l.mfr_mdl_code;
self.aircraft_mfr_name           :=    l.mfr_name;    
self.model_name                  :=    l.model;        
self.type_aircraft               :=    l.type_acft;    
self.type_engine                 :=    l.type_eng;     
self.aircraft_category_code      :=    l.ac_cat;       
self.amateur_certification_code  :=    l.amat_ind;   
self.number_of_engines           :=    l.no_eng;     
self.number_of_seats             :=    l.no_seats;   
self.aircraft_weight             :=    l.ac_weight;  
self.aircraft_cruising_speed     :=    l.speed; 
self.lf := '';     
self := l;
end;

dActreffx := project(File_raw_actref( StringLib.StringToUpperCase(trim(MFR_NAME)) <> 'MFR'),csv2fixedact(LEFT));

dActreffxout := if(STD.File.FileExists('~thor_data400::in::faa_aircraft_ref_' + version),
											output('FAA Aircraft  Ref file already built in previous run'),
														output(dActreffx,,'~thor_data400::in::faa_aircraft_ref_' + version,overwrite));

dActrefsort := sort(dActreffx,aircraft_mfr_model_code);
dMastersort := sort(dMasterfinal,mfr_mdl_code);


layout_aircraft_registration_in tjoin(dMastersort l,dActrefsort r) := transform
self.aircraft_mfr_name 	:= r.aircraft_mfr_name;
self.model_name 				:= r.model_name;
self := l;
end;

dmasterjoin := Join(dMastersort,dActrefsort,LEFT.mfr_mdl_code=RIGHT.aircraft_mfr_model_code,
                        tjoin(LEFT,RIGHT),LEFT OUTER);
												
												
dmasteractfinal :=  if(STD.File.FileExists('~thor_data400::in::faa_aircraft_reg_' + version),
												 output('FAA Aircraft  Reg file already built in previous run'),
															output(dmasterjoin,,'~thor_data400::in::faa_aircraft_reg_'+version,overwrite));

super_all := sequential(
												STD.File.StartSuperFileTransaction(),
												STD.File.ClearSuperFile('~thor_data400::in::faa_aircraft_IN'),
												STD.File.AddSuperFile('~thor_Data400::in::Faa_aircraft_IN','~thor_data400::in::faa_aircraft_reg_'+ version),
												STD.File.ClearSuperFile('~thor_data400::base::faa_engine_info_In'),
												STD.File.AddSuperFile('~thor_data400::base::faa_engine_info_in','~thor_data400::in::faa_aircraft_engine_ref_' + version),
												STD.File.ClearSuperFile('~thor_Data400::base::faa_aircraft_info_in'),
												STD.File.AddSuperFile('~thor_data400::base::faa_aircraft_info_in','~thor_data400::in::faa_aircraft_ref_' + version),
												STD.File.FinishSuperFileTransaction()
												);

return  sequential(buildengine,dActreffxout,dmasteractfinal,super_all);

end;
			
			