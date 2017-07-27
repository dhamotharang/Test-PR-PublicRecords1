import statistics;

export Stats(string pversion) :=
module
	
	shared dName := _Dataset().Name;

	export fAffiliated_Individuals(
	
		dataset(layouts.base.affiliated_individuals)	pBase = files().base.affiliated_individuals.built
	
	) := 
	function
		
		basename := 'Affiliated_Individuals';
	
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,bdid												,'bdid'											,'integer',bdid_one_field_stats											);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,bdid_score									,'bdid_score'								,'integer',bdid_score_one_field_stats								);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,did													,'did'											,'integer',did_one_field_stats											);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,did_score										,'did_score'								,'integer',did_score_one_field_stats								);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_first_seen								,'dt_first_seen'						,'integer',dt_first_seen_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_last_seen								,'dt_last_seen'							,'integer',dt_last_seen_one_field_stats							);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_vendor_first_reported		,'dt_vendor_first_reported'	,'integer',dt_vendor_first_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_vendor_last_reported			,'dt_vendor_last_reported'	,'integer',dt_vendor_last_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_mailing							,'RawAid_mailing'						,'integer',RawAid_mailing_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_Location							,'RawAid_Location'					,'integer',RawAid_Location_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,record_type									,'record_type'							,'string'	,record_type_one_field_stats							,pFieldFew := true);

		return 
				bdid_one_field_stats											
			+ bdid_score_one_field_stats								
			+ did_one_field_stats											
			+ did_score_one_field_stats								
			+ dt_first_seen_one_field_stats						
			+ dt_last_seen_one_field_stats							
			+ dt_vendor_first_reported_one_field_stats	
			+ dt_vendor_last_reported_one_field_stats	
			+ RawAid_mailing_one_field_stats		
			+ RawAid_Location_one_field_stats	
			+ record_type_one_field_stats			
			;
	
	end;

	export fUnaffiliated_Individuals(
	
		dataset(layouts.base.unaffiliated_individuals)	pBase = files().base.unaffiliated_individuals.built
	
	) := 
	function
		
		basename := 'Unaffiliated_Individuals';
	
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,did													,'did'											,'integer',did_one_field_stats											);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,did_score										,'did_score'								,'integer',did_score_one_field_stats								);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_first_seen								,'dt_first_seen'						,'integer',dt_first_seen_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_last_seen								,'dt_last_seen'							,'integer',dt_last_seen_one_field_stats							);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_vendor_first_reported		,'dt_vendor_first_reported'	,'integer',dt_vendor_first_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_vendor_last_reported			,'dt_vendor_last_reported'	,'integer',dt_vendor_last_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_mailing							,'RawAid_mailing'						,'integer',RawAid_mailing_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_Location							,'RawAid_Location'					,'integer',RawAid_Location_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,record_type									,'record_type'							,'string'	,record_type_one_field_stats							,pFieldFew := true);

		return 
				did_one_field_stats											
			+ did_score_one_field_stats								
			+ dt_first_seen_one_field_stats						
			+ dt_last_seen_one_field_stats							
			+ dt_vendor_first_reported_one_field_stats	
			+ dt_vendor_last_reported_one_field_stats	
			+ RawAid_mailing_one_field_stats		
			+ RawAid_Location_one_field_stats	
			+ record_type_one_field_stats			
			;
	
	end;

	export fOrganizations(
	
		dataset(layouts.base.Organizations)	pBase = files().base.Organizations.built
	
	) := 
	function
		
		basename := 'Organizations';
	
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,bdid												,'bdid'											,'integer',bdid_one_field_stats											);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,bdid_score									,'bdid_score'								,'integer',bdid_score_one_field_stats								);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_first_seen								,'dt_first_seen'						,'integer',dt_first_seen_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_last_seen								,'dt_last_seen'							,'integer',dt_last_seen_one_field_stats							);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_vendor_first_reported		,'dt_vendor_first_reported'	,'integer',dt_vendor_first_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,dt_vendor_last_reported			,'dt_vendor_last_reported'	,'integer',dt_vendor_last_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_mailing							,'RawAid_mailing'						,'integer',RawAid_mailing_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_Location							,'RawAid_Location'					,'integer',RawAid_Location_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_contact_mailing			,'RawAid_contact_mailing'		,'integer',RawAid_contact_mailing_one_field_stats		);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,RawAid_contact_Location			,'RawAid_contact_Location'	,'integer',RawAid_contact_Location_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBase, dName,basename,pversion,record_type									,'record_type'							,'string'	,record_type_one_field_stats							,pFieldFew := true);

		return 
				bdid_one_field_stats											
			+ bdid_score_one_field_stats								
			+ dt_first_seen_one_field_stats						
			+ dt_last_seen_one_field_stats							
			+ dt_vendor_first_reported_one_field_stats	
			+ dt_vendor_last_reported_one_field_stats	
			+ RawAid_mailing_one_field_stats		
			+ RawAid_Location_one_field_stats	
			+ RawAid_contact_mailing_one_field_stats		
			+ RawAid_contact_Location_one_field_stats	
			+ record_type_one_field_stats			
			;
	
	end;


end;