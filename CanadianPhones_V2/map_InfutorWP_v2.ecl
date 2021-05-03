IMPORT _Control, Address, CanadianPhones, MDR, VersionControl, Std, ut, Data_services;

//Using mapping output for version 1 as it already includes history setting using Ingest
EXPORT map_InfutorWP_v2(string8 filedate) := FUNCTION


	ds := CanadianPhones.file_InfutorWP().Base;
		
	CanadianPhones_V2.layoutCanadianWhitepagesBase tInfWP(ds L) := TRANSFORM
		SELF.history_flag 	:= IF(L.CurrentRec = TRUE, 'C','H');
		SELF.vendor					:= 'I7';
		SELF.Source_file		:= 'INFUTOR_WHITEPAGES';
		SELF.record_id			:= (string)L.record_id;
		SELF 								:= L;
		SELF								:= [];
	END;
	
	pInfWP := PROJECT(ds,tInfWP(LEFT));
	
	//Add Global_SID
	addGlobalSID	:= MDR.macGetGlobalSID(pInfWP, 'CanadianPhones', 'source_file', 'global_sid'); //DF-25404
	
	RETURN SEQUENTIAL(
						fileservices.removeOwnedSubFiles(CanadianPhones.thor_cluster + 'in::InfutorWP_v2');
						OUTPUT(addGlobalSID,,CanadianPhones.thor_cluster + 'in::InfutorWP::'+filedate+ '::canada_clean_v2',compressed, overwrite);
						fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::InfutorWP_v2',CanadianPhones.thor_cluster + 'in::InfutorWP::'+filedate+ '::canada_clean_v2')
						);
END;