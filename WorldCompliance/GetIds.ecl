import ut, std;

//	string			PassportId {maxlength(20)};
//	string			NationalId {maxlength(20)};
//	string			OtherId {maxlength(20)};
//  entity id

{unsigned8 Ent_ID, Layout_XG.layout_sp} 
	xformWithVessel(Layouts.rEntity infile, integer n) := TRANSFORM
		self.Ent_ID := infile.Ent_id;
		self.type := TRIM(CHOOSE(n,'Passport','National','Other','ProprietaryUID','IMO', SKIP));
		self.number := TRIM(CHOOSE(n,infile.PassportId,infile.NationalId,infile.OtherId,(string)infile.Ent_id,infile.NationalId,SKIP));
		self := [];
END;

{unsigned8 Ent_ID, Layout_XG.layout_sp} 
	xformWithoutVessel(Layouts.rEntity infile, integer n) := TRANSFORM
		self.Ent_ID := infile.Ent_id;
		self.type := TRIM(CHOOSE(n,'Passport','National','Other','ProprietaryUID', SKIP));
		self.number := TRIM(CHOOSE(n,infile.PassportId,infile.NationalId,infile.OtherId,(string)infile.Ent_id,SKIP));
		self := [];
END;

{unsigned8 Ent_ID, Layout_XG.layout_sp} 
	xformWithOrganization(Layouts.rEntity infile, integer n) := TRANSFORM
		self.Ent_ID := infile.Ent_id;
		self.type := TRIM(CHOOSE(n,'SwiftBIC','National','Other','ProprietaryUID', SKIP));
		self.number := TRIM(CHOOSE(n,infile.PassportId,infile.NationalId,infile.OtherId,(string)infile.Ent_id,SKIP));
		self := [];
END;

EXPORT GetIds(dataset(Layouts.rEntity) infile) := FUNCTION
	dsWithVessel 		:= Normalize(infile(EntryType = 'Vessel'), 5, xformWithVessel(LEFT, COUNTER));
	dsWithoutVessel := Normalize(infile(EntryType <> 'Vessel' and EntryType <> 'Organization'), 4, xformWithoutVessel(LEFT, COUNTER));
	dsWithOrganization := Normalize(infile(EntryType = 'Organization'), 5, xformWithOrganization(LEFT, COUNTER));

	return DEDUP(SORT(Distribute((dsWithVessel&dsWithoutVessel&dsWithOrganization)(number<>''), Ent_id), Ent_id, type, number, LOCAL), Ent_id, type, number, LOCAL);
END;