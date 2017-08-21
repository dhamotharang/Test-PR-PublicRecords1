import Address,lib_stringlib,FLAccidents ;
flc2v_v4_in := dataset('~thor_data400::sprayed::flcrash2v'
							,FLAccidents.Layout_FLCrash2v_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
							
BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash2v_v4;
end;

clean_addr trcleanaddr(flc2v_v4_in le) := transform
//self.clean_address := if(le.vehicle_owner_address <> '',Address.CleanAddress182(lib_stringlib.StringLib.StringCleanSpaces(le.vehicle_owner_address),lib_stringlib.StringLib.StringCleanSpaces(le.vehicle_owner_city+ ', '+le.vehicle_owner_st + '  '+ le.vehicle_owner_zip)),'');
tmpfirstname		:= REGEXREPLACE(BadNameFilter,le.vehicle_owner_firstname,'');
tmplastname		:= REGEXREPLACE(BadNameFilter,le.vehicle_owner_lastname,'');
tmpmiddlename	:= REGEXREPLACE(BadNameFilter,le.vehicle_owner_middlename,'');
self.clean_name := if(StringLib.StringCleanSpaces(tmpfirstname + tmplastname) != '',Address.CleanPersonFML73(StringLib.StringCleanSpaces(StringLib.StringFindReplace((tmpfirstname+' '+ tmpmiddlename+' '+tmplastname),'.',' '))),'');
self := le;
end;

File_clean_addr := project(flc2v_v4_in,trcleanaddr(LEFT));							
							
flc2v_v2_rec := FLAccidents.Layout_FLCrash2v_v2;

flc2v_v2_rec flc2v_convert_to_old(File_clean_addr l) := transform
mth_conv(string pinput) := map ( pInput = 'JAN' => '01',
                                 pInput = 'FEB' => '02',
								 pInput = 'MAR' => '03',
								 pInput = 'APR' => '04',
								 pInput = 'MAY' => '05',
								 pInput = 'JUN' => '06',
								 pInput = 'JUL' => '07',
								 pInput = 'AUG' => '08',
								 pInput = 'SEP' => '09',
								 pInput = 'OCT' => '10',
								 pInput = 'NOV' => '11',
								 pInput = 'DEC' => '12',' ');
								 

//self.vehicle_owner_dob := if( l.vehicle_owner_dob <> '',mth_conv(l.vehicle_owner_dob[4..6]) + l.vehicle_owner_dob[1..2]+'19' + l.vehicle_owner_dob[8..9] ,'');
	self. rec_type_2   :=  '2';
	self.section_nbr	:= Intformat((integer)l.section_nbr,2,1);
	self.vehicle_driver_action	:= IF(trim(l.hit_and_run,left,right) != '2','',trim(l.hit_and_run,left,right));
	self.vehicle_owner_name		:=	IF(trim(l.vehicle_owner_business) = '',
																		StringLib.StringCleanSpaces(l.vehicle_owner_firstname+' '+ l.vehicle_owner_middlename+' '+l.vehicle_owner_lastname),
																		trim(l.vehicle_owner_business,left,right));
	self.vehicle_owner_address	:= StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter, l.vehicle_owner_address, ''));
	self.vehicle_owner_st_city	:=	StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.vehicle_owner_city, ''));
	self.vehicle_owner_st				:= StringLib.StringCleanSpaces(l.vehicle_owner_st);
	self.vehicle_owner_zip			:= map(trim(l.vehicle_owner_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.vehicle_owner_zip,left,right)) = true => l.vehicle_owner_zip[1..5],
                                     regexfind('[1-9]',trim(l.vehicle_owner_zip,left,right)) = false => '',l.vehicle_owner_zip); 
	self.est_vehicle_speed		:=	if(l.est_vehicle_speed!='999',l.est_vehicle_speed,'');


	self.model_year	:=	if(l.vehicle_year!='0000' and l.vehicle_year>='1970'
								,l.vehicle_year
								,''
								);
							

	self.make_description	:=	map(l.vehicle_make='ACUR' => 'Acura',
									l.vehicle_make='ALFA' => 'Alfa Romeo',
									l.vehicle_make='AMC ' => 'AMC',
									l.vehicle_make='AUDI' => 'Audi',
									l.vehicle_make='BIKE' => 'Bike',
									l.vehicle_make='BMW ' => 'BMW',
									l.vehicle_make='BUIC' => 'Buick',
									l.vehicle_make='CADI' => 'Cadillac',
									l.vehicle_make='CHEV' => 'Chevrolet',
									l.vehicle_make='CHRY' => 'Chrysler',
									l.vehicle_make='DAEW' => 'Daewoo',
									l.vehicle_make='DODG' => 'Dodge',
									l.vehicle_make='FIAT' => 'Fiat',
									l.vehicle_make='FORD' => 'Ford',
									l.vehicle_make='GEO ' => 'GEO',
									l.vehicle_make='GM  ' => 'GM',
									l.vehicle_make='GMC ' => 'GMC',
									l.vehicle_make='HOND' => 'Honda',
									l.vehicle_make='HYUN' => 'Hyundai',
									l.vehicle_make='INFI' => 'Infiniti',
									l.vehicle_make='ISU ' => 'Isuzu',
									l.vehicle_make='ISUZ' => 'Isuzu',
									l.vehicle_make='JAG ' => 'Jaguar',
									l.vehicle_make='JAGU' => 'Jaguar',
									l.vehicle_make='JEEP' => 'Jeep',
									l.vehicle_make='KAWA' => 'Kawasaki',
									l.vehicle_make='KIA ' => 'Kia',
									l.vehicle_make='LEXU' => 'Lexus',
									l.vehicle_make='LINC' => 'Lincoln',
									l.vehicle_make='MACK' => 'Mack',
									l.vehicle_make='MAZD' => 'Mazda',
									l.vehicle_make='MERC' => 'Mercury',
									l.vehicle_make='NISS' => 'Nissan',
									l.vehicle_make='OLDS' => 'Oldsmobile',
									l.vehicle_make='PLYM' => 'Plymouth',
									l.vehicle_make='PONT' => 'Pontiac',
									l.vehicle_make='SATU' => 'Saturn',
									l.vehicle_make='SUBA' => 'Subaru',
									l.vehicle_make='TOYT' => 'Toyota',
									l.vehicle_make='TOYT' => 'Toyota',
									l.vehicle_make='VOLK' => 'Volkswagen',
									l.vehicle_make='VOLV' => 'Volvo',
									l.vehicle_make='VW  ' => 'Volkswagen',
									l.vehicle_make='YAMA' => 'Yamaha',
									l.vehicle_make='YUGO' => 'Yugo',
									l.vehicle_make
									);
self.vehicle_type := Intformat((integer)l.vehicle_type,2,1);
									
self.vehicle_movement				:= map(trim(l.vehicle_movement,left,right) = '13' => '02',
																		trim(l.vehicle_movement,left,right) = '14' => '02',
																		trim(l.vehicle_movement,left,right) = '15' => '77',
																		trim(l.vehicle_movement,left,right) = '16' => '77',
																		trim(l.vehicle_movement,left,right) = '17' => '77',
																		Intformat((integer)l.vehicle_movement,2,1));
self.vehicle_function				:= IF(trim(l.vehicle_function) = '88','00',Intformat((integer)l.vehicle_function,2,1));
self.vehs_first_defect			:= IF(trim(l.vehs_first_defect) = '88','00',Intformat((integer)l.vehs_first_defect,2,1));
self.vehs_second_defect			:= IF(trim(l.vehs_second_defect) = '88','00',Intformat((integer)l.vehs_second_defect,2,1));
self.vehicle_roadway_loc	:= '88';
self.point_of_impact 		:= Intformat((integer)l.point_of_impact,2,1);
self.vehicle_use	:= '00';
// self.prim_range			            := l.clean_address[1..10];
// self.predir				            := l.clean_address[11..12];
// self.prim_name				        := l.clean_address[13..40];
// self.addr_suffix			        := l.clean_address[41..44];
// self.postdir				        := l.clean_address[45..46];
// self.unit_desig			            := l.clean_address[47..56];
// self.sec_range				        := l.clean_address[57..64];
// self.p_city_name			        := l.clean_address[65..89];
// self.v_city_name			        := l.clean_address[90..114];
// self.st					            := l.clean_address[115..116];
// self.zip					        := l.clean_address[117..121];
// self.zip4					        := l.clean_address[122..125];
// self.cart					        := l.clean_address[126..129];
// self.cr_sort_sz			            := l.clean_address[130];
// self.lot					        := l.clean_address[131..134];
// self.lot_order		 := l.clean_address[135];
// self.dpbc          := l.clean_address[136..137];
// self.chk_digit		 := l.clean_address[138];
// self.rec_type			 := l.clean_address[139..140];
// self.ace_fips_st	 := l.clean_address[141..142];
// self.county        := l.clean_address[143..145];
// self.geo_lat			 := l.clean_address[146..155];
// self.geo_long			 := l.clean_address[156..166];
// self.msa					 := l.clean_address[167..170];
// self.geo_blk			 := l.clean_address[171..177];
// self.geo_match		 := l.clean_address[178];
// self.err_stat			 := l.clean_address[179..182];
self.title			   := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				 := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				 := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				 := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	       := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score         := if(l.clean_name <> '',l.clean_name[71..73],'');
self.cname         := if(StringLib.StringCleanSpaces(l.vehicle_owner_lastname) != '','',StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.vehicle_owner_business,'')));
self := l;
self := [];

end;

export InFile_FLCrash2v_v4 := project(File_clean_addr,flc2v_convert_to_old(LEFT));