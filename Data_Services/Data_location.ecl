// to read the file from dataland sandbox export Person_header:= '~';   
// to read the file from prod sandbox  export Person_header:= ut.foreign_prod;
// by using a function then this attribute will only have to go to production once
// becasue the default will be ~ and that is what you want for all indexes in production
import _Control,ut;
export Data_location      := module 

SetDali := [
						 _Control.IPAddress.bair_prod_dali1
						,_Control.IPAddress.bair_DR_dali1
						,_Control.IPAddress.bair_dataland_dali
						,_Control.IPAddress.NewLogTHOR_dali
						,_Control.IPAddress.FCRALogTHOR_dali
						];

export Prefix(string serviceName='NoNameGiven') := function
	return	trim(case (trim(servicename),
	              'person_slimsorts' 	=> map(ThorLib.Group() = 'thor400_44' => '~thor400_44::'
															,ThorLib.Group() = 'thor400_66' => '~thor400_66::'
															,ThorLib.Group() = 'thor400_36' => '~thor400_36::'
																					, ''),	
								'person_xADL2'     	=> '',
								'IDL_Header'        => ut.foreign_aprod,
								'LAB_xLink' 				=> map(ThorLib.Group() = 'thor400_44' => '~thor400_44::'
                                          ,ThorLib.Group() = 'thor400_66' => '~thor400_66::'
																					,_Control.ThisEnvironment.ThisDaliIp in SetDali  => foreign_prod+'thor400_60::'
																					, ''),	
								'Vina'							=> map(_Control.ThisEnvironment.ThisDaliIp in SetDali  => foreign_prod
																					,Data_Services.Default_Data_Location),
								'TDS'								=> map(_Control.ThisEnvironment.ThisDaliIp in SetDali  => foreign_prod
																					,Data_Services.Default_Data_Location),
								'biz_linking'     	=> map(thorlib.group() = 'thor400_66' => '~thor400_66::'  //keep this here now for any builds that might still run on the 66 until it is retired
                                          ,thorlib.group() = 'thor400_36' => '~thor400_36::'
                                          ,thorlib.group() = 'thor400_44' => '~thor400_44::'
																					,'~thor_data400::'),
								'BogusPlaceHolder' => Data_Services.Default_Data_Location,	// Can add exceptions here
								Data_Services.Default_Data_Location));
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
export tucs_did             := Prefix('tucs_did');	
export transunion_did       := Prefix('transunion_did');	
export file_header_building	:= Prefix('file_header_building');	


// See Dataland version for more complete list of indexes utilizing this functionality
end; 