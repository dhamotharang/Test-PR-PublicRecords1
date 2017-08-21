EXPORT Constants := module
//person_type
EXPORT set_ptype          := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
EXPORT set_person_type		:= ['\\PASSENGER', '3PASSENGER','Ã¢?Â¢THEY ENTERED: PASSENGER','BICYCLE',
															'BICYCLIST', 'BYCICLIST', 'INJURED PASSENGER', 'OASSENGER', 'PAASENGER',
															'PAS', 'PASEENGER', 'PASENGER', 'PASS', 'PASSANGER',
															'PASSE', 'PASSEBGER', 'PASSEDNGER', 'PASSEENGER', 'PASSEGER',
															'PASSEGNER', 'PASSEMGER', 'PASSENDER', 'PASSENEGER', 'PASSENEGR',
															'PASSENER', 'PASSENGER', 'PASSENGER', 'PASSENGER1', 'PASSENGERA',
															'PASSENGERJENNIFER', 'PASSENGERS', 'PASSENGERT', 'PASSENGFER',
															'PASSENGR', 'PASSENJGER', 'PASSENNGER', 'PASSSENGER']; 

EXPORT in_prefix_name			:= '~prte::in::ecrashv2';
EXPORT base_prefix_name		:= '~prte::base::ecrashv2';
EXPORT base_prefix_ecrash	:= '~prte::base::ecrash';
EXPORT KeyName_ecrashv2 	:= '~prte::key::ecrashv2'; 
EXPORT KeyName_ecrash			:= '~prte::key::ecrash';


EXPORT SuperKeyname_ecrashV2	:= KeyName_ecrashv2+'::@version@::';
EXPORT SuperKeyname_ecrash		:= KeyName_ecrash+'::@version@::';

EXPORT ak_keyname 	:= KeyName_ecrashv2 +'::autokey::@version@::'; 
EXPORT ak_logical(string filedate) := KeyName_ecrashv2 + '::' + filedate + '::autokey::'; 
EXPORT ak_skip_set 	:= ['P','Q','S','F']; 
EXPORT ak_typestr 	:= '\'AK\''; 

END;