import doxie,MXD_MXDocket,MXD_Professions;

export Raw := module

	export getDocketsByIds(dataset(Layouts.MXEntityIds) ids) := function	
	
		k_party 	:= MXD_MXDocket.Key_DocketParty;
		k_docket 	:= MXD_MXDocket.Key_Docket;
			
		parties := join(ids, k_party, 
										keyed(left.entity_id=right.entity_id and (left.rec_id=0 or left.rec_id=right.rec_id)),
										 transform(MX_Services.Layouts.MXDocketsPrepOut,
												self.rec_id 		:= right.rec_id,											
												self.firstname 	:= right.firstname,
												self.middlename := right.middlename1,
												self.lastname 	:= right.lastname,
												self.matronymic := right.matronymic,
												self.fullname 	:= right.partyoriginal,											
												self.gender 		:= right.gender,											
												self.entity_id	:= left.entity_id,
												self := []
												),
										// For regular searches (entity_id+rec_id), this is a one to one join. 
										// The limit here is purely a safeguard against too many records in the case of search by entity id.
										limit(MX_Services.Constants.Limits.MAX_FETCH, fail(203, doxie.ErrorCodes(203)))); 
	
		dockets := join(parties, k_docket, 
									 keyed(left.rec_id=right.rec_id), 
										transform(MX_Services.Layouts.MXDocketsPrepOut,
												self.rec_id 			:= left.rec_id,		
												self.entity_id		:= left.entity_id,
												self.firstname 		:= left.firstname,
												self.middlename 	:= left.middlename,
												self.lastname 		:= left.lastname,
												self.matronymic 	:= left.matronymic,
												self.fullname 		:= left.fullname,											
												self.gender 			:= left.gender,											
												self.state	 			:= right.state,												
												self.geography 		:= right.geography,
												self.date_pub 		:= right.date_pub,
												self.court 				:= right.court,
												self.court_local 	:= right.court_local,
												self.docket 			:= right.docket,
												self.docket_num 	:= right.docket_num,
												self.docket_year 	:= right.docket_year,
												self.caption 			:= right.caption,
												self.nature 			:= right.nature,
												self.nature_type 	:= right.nature_type,
												self.penalty			:= 0
											),
									 keep(1), limit(0));
	
		return dockets;
	end;

	export getProfessionByIds(dataset(Layouts.MXEntityIds) ids) := function	
	
		k_prof := MXD_Professions.Key_Profession;
			
		profs := join(ids, k_prof, 
										keyed(left.entity_id=right.entity_id and (left.rec_id=0 or left.rec_id=right.rec_id)),
										 transform(MX_Services.Layouts.MXProfessionPrepOut,
												self.entity_id	:= left.entity_id,
												self.rec_id 		:= right.rec_id,											
												self.firstname 	:= right.firstname,
												self.middlename := right.middlename1,
												self.lastname 	:= right.lastname,
												self.matronymic := right.matronymic,
												self.fullname 	:= right.full_name,											
												self.gender 		:= right.gender,											
												self.prof_cat		:= right.prof_cat,
												self.profno			:= right.profno,
												self.profession	:= right.profession,
												self.education_level := right.education_level,
												self.penalty		:= 0),
										limit(MX_Services.Constants.Limits.MAX_FETCH, fail(203, doxie.ErrorCodes(203)))); 
		
		return profs;
	end;

	
end;