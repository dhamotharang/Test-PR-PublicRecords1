IMPORT _Control, Address, CanadianPhones, MDR, VersionControl, Std, ut;

EXPORT map_axciomCanBus(string8 abusFileDate) := FUNCTION

	new_update := CanadianPhones.file_axciomCanBus.v2;
	
	//remove all not printable characters
	ut.CleanFields(new_update,new_update_clean);

	dacb := DISTRIBUTE(new_update_clean);

	CanadianPhones_V2.layoutCanadianWhitepagesBase tacb(dacb input) := TRANSFORM

		SELF.Date_first_reported		:=abusFileDate;
		SELF.Date_last_reported			:=abusFileDate;
		//New for V2
		SELF.date_first_published		:=input.Pub_Date;
		SELF.date_last_published		:=input.Pub_Date;
		SELF.history_flag 					:= 'C';

		SELF.vendor									:='AX';
		SELF.Source_file						:='AXCIOM_CANADIAN_BUSINESS';
		SELF.company_name						:= ut.CleanSpacesAndUpper(input.business_name);
		SELF.housenumber						:= ut.CleanSpacesAndUpper(input.street_number);
		SELF.streetname							:= ut.CleanSpacesAndUpper(input.street_name);
		SELF.streetsuffix						:= '';
		SELF.suitenumber						:= ut.CleanSpacesAndUpper(input.Unit_Number+' '+input.Unit_designator);
		SELF.postalcity							:= ut.CleanSpacesAndUpper(input.city);
		SELF.province								:= ut.CleanSpacesAndUpper(input.province);
		SELF.postalcode							:= ut.CleanSpacesAndUpper(input.postal_code);
		SELF.phonenumber						:= input.area_code+input.phone_number;
		SELF.listing_type						:='B';

		CleanAddress								:= Address.CleanCanadaAddress109(
																				stringlib.stringcleanspaces(		input.street_number +	' '
																																			+	input.street_name
																																			+	if(trim(input.Unit_Number+input.Unit_designator)!='',
																																				' '	+ input.Unit_designator	+	' '	+	input.Unit_Number,
																																				'')
																																		),
																				stringlib.stringcleanspaces(		input.city
																																			+	' '
																																			+	input.province
																																			+	' '
																																			+	input.postal_code
																																		)
																																	);

		 
		SELF.prim_range 						:= CleanAddress[1..10]; 
		SELF.predir 								:= CleanAddress[11..12];					   
		SELF.prim_name 							:= CleanAddress[13..40];
		SELF.addr_suffix 						:= CleanAddress[41..44];
		SELF.unit_desig 						:= CleanAddress[45..54];
		SELF.sec_range 							:= CleanAddress[55..62];
		SELF.p_city_name 						:= CleanAddress[63..92];
		SELF.state									:= CleanAddress[93..94];
		SELF.zip										:= CleanAddress[95..100];
		SELF.rec_type   						:= CleanAddress[101..102];
		SELF.language 							:= CleanAddress[103];
		SELF.errstat 								:= CleanAddress[104..109];
		SELF												:= input; 
		SELF			   								 :=[];
		
	END;

	pacb := PROJECT(dacb,tacb(left));
	
	//Add Global_SID
	addGlobalSID	:= MDR.macGetGlobalSID(pacb, 'CanadianPhones', 'source_file', 'global_sid'); //DF-25404

	RETURN SEQUENTIAL(
						fileservices.removeOwnedSubFiles(CanadianPhones.thor_cluster + 'in::axciomBus_v2');
						OUTPUT(addGlobalSID,,CanadianPhones.thor_cluster + 'in::axciomBus::'+abusFileDate+ '::canada_clean_v2',overwrite);
						fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::axciomBus_v2',CanadianPhones.thor_cluster + 'in::axciomBus::'+abusFileDate+ '::canada_clean_v2')
						);

END;
