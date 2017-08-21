// dInput 	= The V3 Dataset in which we want to remove the resurrections files.

IMPORT 	Death_Master, RoxieKeyBuild, Header;
EXPORT fn_clean_resurrections(DATASET(RECORDOF(Header.Layout_Did_Death_MasterV3)) dInput) := FUNCTION

	dDeletesDID				:=	Death_Master.Files.Deletes_DID;
								
		// Only working with valid DIDs
	dValidDeletesDID	:=	dDeletesDID((UNSIGNED)did<>0);
	dValidInputDID		:=	dInput((UNSIGNED)did<>0);

		// DEDUP Valid DIDs from Deletes keeping latest record
	dDedupValidDeletesDID	:=	DEDUP(SORT(DISTRIBUTE(dValidDeletesDID,HASH(did)),did,-filedate,LOCAL),did,LOCAL);

		// If the Delete DID is in Input as an SSA record, then we don't want that DID.  Keep the rest.
		// We assume that the SSA records in Input are valid.  Thus, if the record from the Delete file 
		// is not an SSA record in the Input file, then this is a valid resurrection record in Delete.
	dDeletesResurrectionSet	:= JOIN(
															dDedupValidDeletesDID,
															DISTRIBUTE(dValidInputDID(death_rec_src = 'SSA'),HASH(did)),
																LEFT.did	=	RIGHT.did,
															TRANSFORM(RECORDOF(LEFT),SELF:=LEFT),
															LEFT ONLY,
															LOCAL
														);

		// Resurrect the records with these DIDs (i.e. Remove these DIDs from the Input Dataset).
	dRemoveResurrections	:=	JOIN(
											DISTRIBUTE(dValidInputDID,HASH(did)),
											DISTRIBUTE(dDeletesResurrectionSet,HASH(did)),
												LEFT.did		=	RIGHT.did,
											TRANSFORM({RECORDOF(LEFT),STRING1 resurrect},SELF.resurrect:=IF(LEFT.did=RIGHT.did,'Y',''),SELF:=LEFT),
											LEFT OUTER,
											LOCAL
										);
										
		// Put back DID=0 records from Input Dataset
	dResult	:=	PROJECT(dRemoveResurrections(resurrect <> 'Y'),Death_Master.Layouts.DID_V3) + dInput((UNSIGNED)did=0);
	dResurrectionsTable	:=	TABLE(dRemoveResurrections(resurrect = 'Y'),{death_rec_src,COUNT(GROUP)},death_rec_src);
	
	OUTPUT('Number of records resurrected from V3 is '+(STRING)(COUNT(dInput)-COUNT(dResult)));
	OUTPUT(SORT(dResurrectionsTable,death_rec_src),NAMED('Resurrections_Table'));
		
		// Output a set of Resurrections samples.
  OUTPUT(dRemoveResurrections(resurrect = 'Y'),,'~thor_data400::base::resurrections_death_masterV3', __compressed__,OVERWRITE);
	
	RETURN	dResult;
	
END;
