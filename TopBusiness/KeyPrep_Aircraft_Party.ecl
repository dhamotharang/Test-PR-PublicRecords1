import tools;
export KeyPrep_Aircraft_Party(
	dataset(Layout_Aircraft.Party) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(serial_number != '' and registration_date != '');
	
	projected := project(base,KeyLayouts.Aircraft.Party);
	
	deduped := dedup(sort(projected,serial_number,aircraft_number,registration_date,company_name,name_first,name_middle,name_last,name_suffix,name_title,if(current_prior_flag = 'A',0,1),-date_last_seen,record),serial_number,aircraft_number,registration_date,company_name,name_first,name_middle,name_last,name_suffix,name_title);
	
	tools.mac_FilesIndex('deduped,{serial_number,aircraft_number,registration_date,current_prior_flag},{projected}',keynames(version,pUseOtherEnvironment).Aircraft.Party,idx);
	
	return idx;

end;
