// to read the file from dataland sandbox export Person_header:= '~';   
// to read the file from prod sandbox  export Person_header:= ut.foreign_prod;
// by using a function then this attribute will only have to go to production once
// becasue the default will be ~ and that is what you want for all indexes in production
IMPORT Data_Services;
export Data_location      := module 
export Prefix(string serviceName = 'NoNameGiven') := function
	return	trim(case (servicename,
								'BogusPlaceHolder' => Data_Services.Default_Data_Location,	// Can add exceptions here
								'LAB_xLink' 			 => '~thor_data400::',
								'biz_linking'      => '~thor_data400::',
								Data_Services.Default_Data_Location),left,right);
end;

export person_header      := Prefix('person_header');
export Header_Quick       := Prefix('Header_Quick');  
export person_slimsorts   := Prefix('person_slimsorts'); 
export Relatives          := Prefix('Relatives');
export sourcekey          := Prefix('sourcekey');
export Watchdog_Best      := Prefix('Watchdog_Best'); 
export IDL_header         := Prefix('IDL_header'); 
export SexOffender		  	:= Prefix('SexOffender');
export BankruptcyV2       := Prefix('BankruptcyV2'); 
export BankruptcyV3       := Prefix('BankruptcyV3');
export SANCTN			  			:= Prefix('SANCTN');	
export ProfileBooster			:= Prefix('ProfileBooster');


// See Dataland version for more complete list of indexes utilizing this functionality
end; 