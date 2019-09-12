IMPORT $;

EXPORT Build_Base := MODULE
#option('multiplePersistInstances',FALSE);

EXPORT AssignBase	:= FUNCTION
	//Build Assignment file
	AssignPrevBase		:= BKMortgage.Files().fAssign;
	AssignIngestPrep	:= Assign_prep_ingest_file;
	AssignIngest			:= Assign_Ingest(,,AssignPrevBase,AssignIngestPrep);
	AssignNewBase		 	:= AssignIngest.AllRecords;
	
	//Populate new_record based on whether or not record is in the new input file as only records not seen before will be passed to property
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	AssignPopNewRec	:= Project(AssignNewBase, TRANSFORM(layouts.AssignBase,
																										SELF.new_record := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); SELF := LEFT; SELF:= [];));
	
RETURN AssignPopNewRec;
END;

EXPORT ReleaseBase := FUNCTION
	//Build Release file
	PrevReleaseBase		:= BKMortgage.Files().fRelease;
	ReleaseIngestPrep	:= Release_prep_ingest_file;
	ReleaseIngest			:= Release_Ingest(,,PrevReleaseBase,ReleaseIngestPrep);
	ReleaseNewBase		:= ReleaseIngest.AllRecords;
	
	//Populate new_record based on whether or not record is in the new input file as only records not seen before will be passed to property
	//Unknown = 1 Ancient = 2 Old = 3 Unchanged = 4 Updated = 5 New = 6
	ReleasePopNewRec	:= Project(ReleaseNewBase, TRANSFORM(layouts.ReleaseBase,
																							SELF.new_record := IF(LEFT.__Tpe in [2,3],FALSE,TRUE); SELF := LEFT; SELF:= [];));
	
RETURN ReleasePopNewRec;
END;

END;