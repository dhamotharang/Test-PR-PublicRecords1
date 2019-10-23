EXPORT MAC_ParentID_Patch(infile0,parentid,id) := FUNCTIONMACRO
  // Split incoming file into those cases with and without a valid parent
	// The latter will be passed through untouched, allowing the parent module
	// to initialize them later (more efficient and better results).
	infilep := infile0(parentid=0);
	infile := infile0(parentid<>0);
	
  // First find any cases of a child ID spanning two or more parents
	TS := DISTRIBUTE( TABLE(infile,{parentid,id}), HASH(id) );
	SS := DEDUP( SORT( TS, id, parentid, LOCAL ), id, parentid, LOCAL);
	// This should be a very small file (at least usually)
	MapRec := RECORD
	  SALT311.UIDType id1;
	  SALT311.UIDType id2;
	  SALT311.UIDType id;
	END;
	MapRec NotePair(SS le, SS ri) := TRANSFORM
	  SELF.id1 := le.parentid;
		SELF.id2 := ri.parentid;
		SELF.id := le.id;
	END;
	Maps := JOIN(SS,SS,LEFT.id=RIGHT.id AND LEFT.parentid > RIGHT.parentid,NotePair(LEFT,RIGHT),LOCAL);
	
	// If two children would join together the SAME parents then that is ok
	OkDupsOut := DEDUP( SORT( DISTRIBUTE( Maps,HASH(id1) ), id1, id2, id, LOCAL ), id1, id2, LOCAL );
	
	// Now we have to find those parentIDs that would be combined by two (or more) ids
	ClashRec := RECORD
	  SALT311.UIDType id1;
	  SALT311.UIDType id2;
	  SALT311.UIDType id3;
		END;
	// Each notes the THREE ids involved in the clash (the central ID and the two suitors)
	Clash1 := JOIN(OkDupsOut,OkDupsOut,LEFT.id1 = RIGHT.id1 AND LEFT.id2<>RIGHT.id2,TRANSFORM(ClashRec,SELF.id1 := LEFT.id1,SELF.id2 := RIGHT.id2,SELF.id3 := LEFT.id2),LOCAL);
	Clash2 := JOIN(OkDupsOut,OkDupsOut,LEFT.id1 = RIGHT.id2,TRANSFORM(ClashRec,SELF.id1 := LEFT.id1,SELF.id2 := LEFT.id2,SELF.id3 := RIGHT.id1));
  IdRec := RECORD
	  SALT311.UIDType id;
	END;
	
	IdRec TakeId(ClashRec le,UNSIGNED i) := TRANSFORM
		SELF.id := CHOOSE(i,le.id1,le.id2,le.id3);
	END;
	// Pull out the (hopefully very small) set of clashing IDs and turn into a set of rapid processing
	BadParents := DEDUP( NORMALIZE( Clash1+Clash2, 3, TakeID(LEFT,COUNTER) ), ID, ALL);
	
	// The parentID mappings that can legally be done
	GoodMaps := JOIN(JOIN(OkDupsOut, BadParents, LEFT.id1=RIGHT.ID, TRANSFORM(LEFT), LEFT ONLY, SMART), BadParents, LEFT.id2=RIGHT.ID, TRANSFORM(LEFT), LEFT ONLY, SMART);
	
	// For those BadIds that cannot be combined at the parent level - I need to pull the children out of the parent
	Maps_filt := JOIN(Maps, BadParents, LEFT.id1=RIGHT.ID, TRANSFORM(LEFT), KEEP(1), SMART) + JOIN(Maps, BadParents, LEFT.id2=RIGHT.ID, TRANSFORM(LEFT), KEEP(1), SMART);
	BadKids := TABLE(Maps_filt, {ID}, ID, MERGE);
	
	O1 := JOIN(infile,BadKids,LEFT.id=RIGHT.id,TRANSFORM(RECORDOF(infile),
																											 SELF.parentid := IF(RIGHT.id<>0,LEFT.id,LEFT.parentid), 
																											 SELF := LEFT), SMART, LEFT OUTER);
	// Some parents may not be bad themselves, but are affected by O1 extracting a bad kid
	IdRec TakeId2(Maps_filt le,UNSIGNED i) := TRANSFORM
		SELF.id := CHOOSE(i,le.id1,le.id2);
	END;
	AffectedParents := DEDUP( NORMALIZE( Maps_filt, 2, TakeID2(LEFT,COUNTER) ), ID, ALL);
	
	// Now the bad/affected parents need to have their children reset so that they can form properly
	O2 := JOIN(o1,AffectedParents,LEFT.parentid=RIGHT.ID,TRANSFORM(LEFT),LEFT ONLY,SMART) +
	      JOIN(o1,AffectedParents,LEFT.parentid=RIGHT.id,TRANSFORM(RECORDOF(infile),
																																											SELF.parentid := LEFT.Id, 
																											                                SELF := LEFT),SMART);
						
  // Apply those good mappings I can apply																											 
	O3 := JOIN(O2,GoodMaps,LEFT.parentid=RIGHT.id1,TRANSFORM(RECORDOF(infile),
																													 SELF.parentid := IF(RIGHT.id1=0,LEFT.parentid,RIGHT.id2),
																													 SELF := LEFT), SMART, LEFT OUTER);
	
	// OUTPUT(Maps,NAMED('Maps')); // DEBUG
	// OUTPUT(COUNT(Maps),NAMED('cnt_Maps')); // DEBUG
	// OUTPUT(OkDupsOut,NAMED('OkDupsOut')); // DEBUG
	// OUTPUT(COUNT(OkDupsOut),NAMED('cnt_OkDupsOut')); // DEBUG
	// OUTPUT(Clash1,NAMED('Clash1')); // DEBUG
	// OUTPUT(Clash2,NAMED('Clash2')); // DEBUG
	// OUTPUT(BadParents,NAMED('BadParents')); // DEBUG
	// OUTPUT(GoodMaps,NAMED('GoodMaps')); // DEBUG
	// OUTPUT(Maps_filt,NAMED('Maps_filt')); // DEBUG
	// OUTPUT(BadKids,NAMED('BadKids')); // DEBUG
	// OUTPUT(AffectedParents,NAMED('AffectedParents')); // DEBUG
	RETURN O3+infilep;
	
	
  ENDMACRO;
/*
// Testing of MAC_ParentID_Patch
rset := RECORD
  SALT311.UIDType pa;
	SALT311.UIDType son;
	END;
Good :=
  dataset([
    {2, 2}, 
    {2, 2}, 
    {2, 1}, 
    {2, 4}, 
    {2, 5}, 
    {2, 6}, 
    {7, 7}, 
    {7, 8}, 
    {7, 8}, 
    {7, 9}, 
    {16, 16}, 
    {16, 16}, 
    {16, 16}, 
    {21, 21}, 
    {21, 21}, 
    {21, 23}, 
    {21, 23}, 
    {10, 10}, 
    {10, 10}, 
    {10, 10}, 
    {13, 13}, 
    {14, 14}, 
    {15, 15}, 
    {19, 19}, 
    {20, 20}], rset);
	
d1 := DATASET([{2,2},{3,2},{2,1},{2,4},{3,5},{3,6}, // Two clusters now joined by record 2 - IDs 1-6 should end up in cluster 2
							 {7,7},{7,8},{9,8},{9,9}, // Joined by son 8 - IDS 7-8 should end up in cluster 7
							 // Test that one child is not joining multiple parents
							 {10,10},{11,10},{12,10},{11,13},{12,14}, // ID 10 ends up in 10, IDs 11 & 12 need to be reset -so 13 & 14 should be single
							 {15,15},{15,16},{17,16},{18,16},{17,19},{18,20}, // 15 stays put, 16-17 move into their own id
							 // Test that two children CAN join to the same parent
							 {21,21},{22,21},{23,23},{21,23} // All end up in 21 
							 ], 
							 rset);
							 
res := SALT311.mac_parentid_patch(d1,pa,son);
res;
*/
