import ut,Address,lib_stringlib;
flc2v_v2_in := dataset(ut.foreign_prod + '~thor_data400::sprayed::flcrash2v'
							,FLAccidents.Layout_FLCrash2v_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));

clean_addr := record
string73  clean_name;
FLAccidents.Layout_FLCrash2v_v3;
end;

clean_addr trcleanaddr(flc2v_v2_in le) := transform
self.clean_name := if(lib_stringlib.StringLib.StringCleanSpaces(le.vehicle_owner_suffix) <> 'C',Address.CleanPersonFML73( lib_stringlib.StringLib.StringCleanSpaces(StringLib.StringFindReplace((le.vehicle_owner_firstname+' '+ le.vehicle_owner_middlename+' '+le.vehicle_owner_lastname),'.',' '))),'');
self := le;
end;

File_clean_addr := project(flc2v_v2_in,trcleanaddr(LEFT));							
							
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
								 

self.vehicle_owner_dob := if( l.vehicle_owner_dob <> '',mth_conv(l.vehicle_owner_dob[4..6]) + l.vehicle_owner_dob[1..2]+'19' + l.vehicle_owner_dob[8..9] ,'');
self. rec_type_2   :=  '2';
self.vehicle_owner_name		:=	lib_stringlib.StringLib.StringCleanSpaces(trim(l.vehicle_owner_firstname,left,right)+' '+trim(l.vehicle_owner_middlename,left,right)+' '+trim(l.vehicle_owner_lastname,left,right));
	self.vehicle_owner_address	:=	trim(l.vehicle_owner_address,left,right);
	self.vehicle_owner_st_city := trim(l.vehicle_owner_city,left,right);
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
									''
									);                             

self.title			               := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				           := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				           := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				           := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	                       := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score                         := if(l.clean_name <> '',l.clean_name[71..73],'');
self.cname                         := if(lib_stringlib.StringLib.StringCleanSpaces(l.vehicle_owner_suffix) = 'C',lib_stringlib.StringLib.StringCleanSpaces(l.vehicle_owner_lastname),'');
self := l;
self := [];

end;

export InFile_FLCrash2v_v3 := project(File_clean_addr,flc2v_convert_to_old(LEFT));

