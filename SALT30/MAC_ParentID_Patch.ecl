EXPORT MAC_ParentID_Patch(infile0,parentid,id) := FUNCTIONMACRO
  // Split incoming file into those cases with and without a valid parent
	infilep := PROJECT(infile0(parentid=0),TRANSFORM(RECORDOF(infile0),SELF.parentid := LEFT.id, SELF := LEFT));
	infile := infile0(parentid<>0)+infilep;
  // First find any cases of a child ID spanning two or more parents
	TS := DISTRIBUTE( TABLE(infile,{parentid,id}), HASH(id) );
	SS := DEDUP( SORT( TS, id, parentid, LOCAL ), id, parentid, LOCAL);
	// This should be a very small file (at least usually)
	MapRec := RECORD
	  SALT30.UIDType id1;
	  SALT30.UIDType id2;
	  SALT30.UIDType id;
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
	  SALT30.UIDType id1;
	  SALT30.UIDType id2;
	  SALT30.UIDType id3;
		END;
	// Each notes the THREE ids involved in the clash (the central ID and the two suitors)
	Clash1 := JOIN(OkDupsOut,OkDupsOut,LEFT.id1 = RIGHT.id1 AND LEFT.id2<>RIGHT.id2,TRANSFORM(ClashRec,SELF.id1 := LEFT.id1,SELF.id2 := RIGHT.id2,SELF.id3 := LEFT.id2),LOCAL);
//	RETURN Clash1;
	Clash2 := JOIN(OkDupsOut,OkDupsOut,LEFT.id1 = RIGHT.id2,TRANSFORM(ClashRec,SELF.id1 := LEFT.id1,SELF.id2 := LEFT.id2,SELF.id3 := RIGHT.id1));
  IdRec := RECORD
	  SALT30.UIDType id;
	END;
	
	IdRec TakeId(ClashRec le,UNSIGNED i) := TRANSFORM
		SELF.id := CHOOSE(i,le.id1,le.id2,le.id3);
	END;
	// Pull out the (hopefully very small) set of clashing IDs and turn into a set of rapid processing
	BadParents := DEDUP( NORMALIZE( Clash1+Clash2, 3, TakeID(LEFT,COUNTER) ), ID, ALL);
	
	BPS := SET(BadParents,ID);
	// The parentID mappings that can legally be done
	GoodMaps := OkDupsOut(id1 NOT IN BPS,id2 NOT IN BPS);
	
	// For those BadIds that cannot be combined at the parent level - I need to pull the children out of the parent
	BadKids := DEDUP( TABLE( Maps(id1 IN BPS OR id2 IN BPS), {id} ), ID, ALL );
	
	O1 := JOIN(infile,BadKids,LEFT.id=RIGHT.id,TRANSFORM(RECORDOF(infile),
																											 SELF.parentid := IF(RIGHT.id<>0,LEFT.id,LEFT.parentid), 
																											 SELF := LEFT), LOOKUP, LEFT OUTER,FEW);
						
	// Now the bad parents need to have their children reset so that they can form properly
	O2 := JOIN(o1,BadParents,LEFT.parentid=RIGHT.ID,TRANSFORM(LEFT),LEFT ONLY,LOOKUP,FEW) +
	      JOIN(o1,BadParents,LEFT.parentid=RIGHT.id,TRANSFORM(RECORDOF(infile),
																																											SELF.parentid := LEFT.Id, 
																											                                SELF := LEFT),LOOKUP,FEW);
						
  // Apply those good mappings I can apply																											 
	O3 := JOIN(O2,GoodMaps,LEFT.parentid=RIGHT.id1,TRANSFORM(RECORDOF(infile),
																													 SELF.parentid := IF(RIGHT.id1=0,LEFT.parentid,RIGHT.id2),
																													 SELF := LEFT), LOOKUP, LEFT OUTER);
	
	RETURN O3;
	
	
  ENDMACRO;
/*
// Testing of MAC_ParentID_Patch
rset := RECORD
  SALT30.UIDType pa;
	SALT30.UIDType son;
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
							 
res := SALT30.mac_parentid_patch(d1,pa,son);
res;
*/
