export map_axciomCanRes(string8 aresFileDate) := function

import CanadianPhones,Address,VersionControl;
dacr := distribute(CanadianPhones.file_axciomCanRes.v2,random());

layoutCanadianWhitepagesBaseWOCCPA := layoutCanadianWhitepagesBase -[global_sid,record_sid];

layoutCanadianWhitepagesBaseWOCCPA tacr(dacr input) := Transform

self.Date_first_reported	:=aresFileDate;
self.Date_last_reported		:=aresFileDate;

self.vendor			:='AX';
self.Source_file	:='AXCIOM_CANADIAN_RESIDENCE';
self.lastname		:= input.last_name;
self.firstname		:= input.first_name;
self.middlename		:= input.middle_initial;
self.generational	:= input.generational_suffix;
self.housenumber	:= input.street_number;
self.streetname		:= input.street_name;
self.streetsuffix	:= '';//input.street_directional;
self.suitenumber	:= input.Unit_Number+' '+input.Unit_designator;//input.room_number + ' '+ input.room_code;
self.suburbancity	:= input.vanity_city_name;
self.postalcity		:= input.city;
self.province		:= input.province;
self.postalcode		:= input.postal_code;
self.phonenumber	:= input.area_code+input.phone_number;

CleanName			:= Address.CleanPersonFML73(input.First_Name+' '+input.Middle_Initial+' '+input.Last_Name+' '+input.Generational_Suffix);
self.name_title		:= CleanName[1..5];
self.fname			:= CleanName[6..25];
self.mname			:= CleanName[26..45];
self.lname			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.name_score 	:= CleanName[71..73];

CleanAddress		:= Address.CleanCanadaAddress109(
											stringlib.stringcleanspaces(		input.street_number
																										+	' '
																										+	input.street_name
																										//+	' '
																										//+	input.street_directional
																										//+	' '
																										//+	if(input.room_code	!=	''	or	input.room_number	!=	'',', '	+	if(input.room_code	=	'','# '	+	input.room_number,input.room_code	+	' '	+	input.room_number),'')
																									  +	if(input.Unit_Number	!=	''	or	input.Unit_designator	!=	'',', '	+	if(input.Unit_designator	=	'','# '	+	input.Unit_Number,input.Unit_designator	+	' '	+	input.Unit_Number),'')
),
											stringlib.stringcleanspaces(		input.city
																										+	' '
																										+	input.province
																										+	' '
																										+	input.postal_code
																									)
																								);
self.prim_range 	:= CleanAddress[1..10]; 
self.predir 		:= CleanAddress[11..12];					   
self.prim_name 		:= CleanAddress[13..40];
self.addr_suffix 	:= CleanAddress[41..44];
self.unit_desig 	:= CleanAddress[45..54];
self.sec_range 		:= CleanAddress[55..62];
self.p_city_name 	:= CleanAddress[63..92];
self.state			:= CleanAddress[93..94];
self.zip			:= CleanAddress[95..100];
self.rec_type   	:= CleanAddress[101..102];
self.language 		:= CleanAddress[103];
self.errstat 		:= CleanAddress[104..109];
self.listing_type	:='R';

self				:= input; 
self 				:=[];
end;


pacr := project(dacr,tacr(left));

return 
sequential(
output(aresFileDate),
output(pacr,,CanadianPhones.thor_cluster + 'in::axciomRes::'+aresFileDate+ '::canada_clean',overwrite),
fileservices.addsuperfile(CanadianPhones.thor_cluster + 'base::axciomRes',CanadianPhones.thor_cluster + 'in::axciomRes::'+aresFileDate+ '::canada_clean'));
end;