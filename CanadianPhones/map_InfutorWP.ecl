IMPORT $, Address, PromoteSupers, NID, PRTE2, ut, STD;

EXPORT map_InfutorWP(string8 FileDate) := FUNCTION

	PrevBase		:= CanadianPhones.file_InfutorWP().Base;
	IngestPrep	:= CanadianPhones.InfutorWP_ingest_prep;
	InfutorIngest	:= Ingest(,,PrevBase,IngestPrep);
	NewBase		 	:= InfutorIngest.AllRecords;
	
	//Populate new_record based on whether or not record is in the new input file as only records not seen before will be passed to property
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	PopNewRec	:= Project(NewBase, TRANSFORM(CanadianPhones.Layout_InfutorWP.BaseOut,
																										SELF.CurrentRec := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); SELF := LEFT; SELF:= [];));
//Map to Base
CanadianPhones.Layout_InfutorWP.BaseOut xferFields(PopNewRec L) := TRANSFORM
	
	CleanAddress				:= Address.CleanCanadaAddress109(TRIM(L.housenumber)+ ' '+TRIM(L.directional)+' '+TRIM(L.streetname)+' '+TRIM(L.streetsuffix)+ ' '+TRIM(L.suitenumber),
																												TRIM(L.postalcity)+ ' ' +TRIM(L.province)+' '+TRIM(L.postalcode)
																												);
	SELF.prim_range 			:= CleanAddress[1..10]; 
	SELF.predir 					:= CleanAddress[11..12];					   
	SELF.prim_name 				:= CleanAddress[13..40];
	SELF.addr_suffix 			:= CleanAddress[41..44];
	SELF.unit_desig 			:= CleanAddress[45..54];
	SELF.sec_range 				:= CleanAddress[55..62];
	SELF.p_city_name 			:= CleanAddress[63..92];
	SELF.state						:= CleanAddress[93..94];
	SELF.zip							:= CleanAddress[95..100];
	SELF.rec_type   			:= CleanAddress[101..102];
	SELF.language 				:= CleanAddress[103];
	SELF.errstat 					:= CleanAddress[104..109];
	SELF.Record_ID				:= L.record_id;
	SELF									:= L;
END;

df_out	:= PROJECT(PopNewRec, xferFields(LEFT));

//Clean name
NID.Mac_CleanParsedNames(df_out, fClnName, 
													firstname:= firstname, lastname:= lastname, middlename := mname, namesuffix := generational
													,includeInRepository:= false, normalizeDualNames:= false, useV2 := true);

person_flags := ['P', 'D'];
business_flags := ['B'];

CanadianPhones.Layout_InfutorWP.BaseOut ClnInputName(fClnName L) := TRANSFORM
	SELF.name_title 			:= IF(L.nametype in person_flags, L.cln_title, '');
	SELF.fname 						:= IF(L.nametype in person_flags, L.cln_fname, '');
	SELF.mname 						:= IF(L.nametype in person_flags, L.cln_mname, '');
	SELF.lname 						:= IF(L.nametype in person_flags, L.cln_lname, '');
	SELF.name_suffix 			:= IF(L.nametype in person_flags, L.cln_suffix, '');
	SELF.name_score 			:= '';
	SELF 									:= L;
END;

map_ClnName := PROJECT(fClnName, ClnInputName(LEFT));

PromoteSupers.Mac_SF_BuildProcess(map_ClnName,CanadianPhones.thor_cluster + 'base::infutorwp',buildnewbasefile,3,,true);

RETURN buildnewbasefile;
END;
