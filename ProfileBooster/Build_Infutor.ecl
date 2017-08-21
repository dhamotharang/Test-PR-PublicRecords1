import MarketingAttributes, Infutor_NARC, RiskWise, Risk_Indicators, Watchdog;

export Build_Infutor := function

	distInfutorDID := distribute(Infutor_NARC.File_Infutor_Narc_DID(DID<>0), did);

	wInfutor := project(distInfutorDID, 
											transform(ProfileBooster.Layouts.Layout_Infutor,
																self.DID 						:= left.DID,
																self.marital_status := stringlib.stringtouppercase(left.orig_married),
																self.gender 				:= stringlib.stringtouppercase(left.orig_gender), 
																self.dob						:= left.clean_DOB),
											local);
											
	return dedup(wInfutor,record,all);

end;