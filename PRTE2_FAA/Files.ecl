import STD, Data_Services, ut, FAA, mdr;

EXPORT Files := MODULE

	EXPORT raw_aircraft_reg		:= DATASET(Constants.in_prefix_name+ 'aircraft_reg', Layouts.aircraft_registration, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
  EXPORT raw_airmen					:= DATASET(Constants.in_prefix_name+ 'airmen', Layouts.airmen, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT raw_airmen_certs		:= DATASET(Constants.in_prefix_name+ 'airmen_certs', Layouts.airmen_certificate, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	
	EXPORT base_aircraft_reg  := DATASET(Constants.base_prefix_name + 'aircraft_reg', Layouts.Search_Aircraft, THOR);
	EXPORT base_airmen  			:= DATASET(Constants.base_prefix_name + 'airmen', Layouts.Search_Airmen, THOR);
	EXPORT base_airmen_certs  := DATASET(Constants.base_prefix_name + 'airmen_certs', Layouts.base_airmen_cert, THOR);
	
//------------------------------------------------------------------------------------------------------

	EXPORT Autokey_Aircraft_Reg_Prep := project(base_aircraft_reg,transform(layouts.Common_Aircraft_Airmen,
																																			self.source_type	:= mdr.sourceTools.src_Aircrafts;
																																			self.did_out			:= (unsigned8)left.did_out;
																																			self.bdid_out			:= (unsigned8)left.bdid_out;
																																			self.street1			:= left.street;
																																			self.suffix				:= left.addr_suffix;
																																			self.aircraft_id	:= left.aircraft_id;																																	
																																			self 							:= left;
																																			self 							:= [];
																																			));

	EXPORT Autokey_Airmen_Prep 	 := project(base_airmen,transform(layouts.Common_Aircraft_Airmen,
																																			self.source_type	:= mdr.sourceTools.src_Airmen;
																																			self.did_out			:= (unsigned8)left.did_out;
																																			self.aircraft_id	:= 0;																																	
																																			self 							:= left;
																																			self 							:= [];																																	
																																		));
																																	
	EXPORT ds_Autokeys_Prep 		 := Autokey_Aircraft_Reg_Prep + Autokey_Airmen_Prep;		
	

	EXPORT Airmen_Autokeys_Prep	 := project(base_airmen,transform(layouts.autokey_airmen,
																																self.did_out6			:= (unsigned6)left.did_out;
																																self.airmen_id 		:= (unsigned6)left.airmen_id;
																																self 							:= left;
																																));				
	
		
	EXPORT header_aircraft_plus := project(base_aircraft_reg, transform(layouts.header_aircraft_plus, self := left, self := []));
	
	EXPORT header_aircraft 			:= project(header_aircraft_plus, {header_aircraft_plus} - [__fpos]);
	
	EXPORT header_airmen_plus 	:= project(base_airmen, layouts.header_airmen);
	
	EXPORT Airmen_key						:= project(base_airmen, layouts.Search_Airmen_slim);
	
	EXPORT Aircraft_Reg_Key			:= project(base_aircraft_reg, layouts.Search_Aircraft_slim);
	
	EXPORT Aircraft_Reg_Linkids	:= project(base_aircraft_reg, layouts.Search_Aircraft_linkids);
END;

