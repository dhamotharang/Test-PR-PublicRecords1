// Assumptions:
// - We were well-formed before linking on the id field
// - No SPLICEs or CLEAVEs
EXPORT MAC_MultiParent_Collapse(infile0,parentid,id) := FUNCTIONMACRO
	IMPORT SALT38;
	infilep := infile0(parentid=0);
	infile := infile0(parentid<>0);
	
  // First find any cases of a child ID spanning two or more parents
	TS := DISTRIBUTE( TABLE(infile,{parentid,id}), HASH(id) );
	SS := DEDUP( SORT( TS, id, parentid, LOCAL ), id, parentid, LOCAL);
	PatchRec := RECORD
	  SALT38.UIDType id1;
	  SALT38.UIDType id2;
	END;
	PatchRec NotePair(SS le, SS ri) := TRANSFORM
	  SELF.id1 := le.parentid;
		SELF.id2 := ri.parentid;
	END;
	Patches := JOIN(SS,SS,LEFT.id=RIGHT.id AND LEFT.parentid > RIGHT.parentid,NotePair(LEFT,RIGHT),LOCAL);
	
	// Toss the dups
	OkDupsOut := DEDUP( SORT( DISTRIBUTE( Patches,HASH(id1) ), id1, id2, LOCAL ), id1, id2, LOCAL );
	
	// Now we diverge from the behavior of SALT38.MAC_ParentId_Patch, and collapse all newly-related parents
	
	// Convert "A->B and B->C" to "A->C and B->C"
	GoodPatches := SALT38.PatchReduce.reduce(OkDupsOut);
	SALT38.utMAC_Patch_Id(infile,parentid,GoodPatches,id1,id2,result);
	
	// output(Patches, NAMED('Patches'));
	// output(OkDupsOut, NAMED('OkDupsOut'));
	// output(GoodPatches, NAMED('GoodPatches'));
	RETURN result + infilep;
ENDMACRO;
