import CanadianPhones,Address,VersionControl;

dcwp := distribute(CanadianPhones.file_CanadianWhitePagesIn,random());

CanadianPhones.layoutCanadianWhitepagesBase tcwp(dcwp input) := Transform

iresFileDate:= VersionControl.fGetFilenameVersion('~thor_data400::in::canadianwp') : stored('iresFileDate');
self.Date_first_reported:=(string8)iresFileDate;
self.Date_last_reported:=(string8)iresFileDate;

self.vendor:='IU';
self.Source_file:='INFOUSA_WHITEPAGES';

CleanName			:= Address.CleanPersonFML73(input.FIRSTNAME+' '+input.MIDDLENAME+' '+input.LASTNAME+' '+input.GENERATIONAL);
self.name_title		:= CleanName[1..5];
self.fname			:= CleanName[6..25];
self.mname			:= CleanName[26..45];
self.lname			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.name_score 	:= CleanName[71..73];


CleanAddress		:= Address.CleanCanadaAddress109(input.housenumber + ' ' + input.directional + ' ' + input.streetname + ' ' + 
													  input.streetsuffix + ' ' + input.suitenumber,				  
													  input.postalcity + ' ' + input.province+' '+ input.postalcode
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
self.listing_type := 'R';

self				:= input; 
self 				:=[];
end;


pcwp := project(dcwp,tcwp(left));

export map_CanadianWhitepages :=output(pcwp,,CanadianPhones.thor_cluster + 'in::canadian_wp::'+CanadianPhones.version+ '::canada_clean',overwrite);