//-----------------------------------------------------------------------------
// Determines the relatives for the input dataset, which is a list of DIDs and
// an integer indicating the degree of separation from the data in the original
// input files (came_from='1' is original, '2' is first-degree, etc.)
//-----------------------------------------------------------------------------
IMPORT header,ut,Relationship;

EXPORT mod_get_universe(DATASET(reunion.layouts.lIteration) dInfile,STRING1 sIteration, UNSIGNED1 mode):=MODULE

  SHARED dRelatives := Relationship.key_relatives_v3(
        not(confidence IN ['NOISE','LOW']) and did1 > 0 and isanylnamematch);

  SHARED dInDistributed:=DISTRIBUTE(dInfile,HASH(did));

  // dAllRelatives is a slim set of all the relative DID pairs from the header
	// relatives file.  Every pair has two rows, where one row is the swapped
	// version of the other.
  dRelatives01:= PROJECT(dRelatives,TRANSFORM(reunion.layouts.lRelativesSlim,SELF.person1:=LEFT.did1;SELF.person2:=LEFT.did2));
  dRelatives02:= PROJECT(dRelatives,TRANSFORM(reunion.layouts.lRelativesSlim,SELF.person1:=LEFT.did2;SELF.person2:=LEFT.did1;));
  dAllRelatives:=DEDUP(SORT(DISTRIBUTE(dRelatives01+dRelatives02,HASH(person1)),person1,person2,LOCAL),person1,person2,LOCAL):PERSIST('~thor::persist::mylife::relatives_slim::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));

  // An inner join of the relative pairs to the input dataset gives us all the
	// relatives for the people in the input dataset.
  EXPORT relative_pairs:=DEDUP(JOIN(dAllRelatives,dInDistributed,LEFT.person1=RIGHT.did,TRANSFORM(reunion.layouts.lRelativesSlim,SELF:=LEFT;),LOCAL),person1,person2,ALL,LOCAL);

  // The normalize below creates a one-column list of DIDs which is a combination
	// of the two columns of DIDs from the relative pairs dataset above.  The
	// following LEFT ONLY join drops any of those DIDs that are already in the
	// input dataset.
  dNormalized:=DEDUP(SORT(DISTRIBUTE(NORMALIZE(relative_pairs,2,TRANSFORM(reunion.layouts.lDID,SELF.did:=CHOOSE(COUNTER,LEFT.person1,LEFT.person2);)),HASH(did)),did,LOCAL),did,LOCAL);
  dRelativesOnly:=JOIN(dNormalized,dInDistributed,LEFT.did=RIGHT.did,TRANSFORM(reunion.layouts.lDID,SELF:=LEFT),LEFT ONLY,LOCAL):PERSIST('~thor::persist::mylife::relatives_append_'+sIteration + '::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));

  // Resulting dataset is the new data added to the input dataset.
  EXPORT universe:=PROJECT(dRelativesOnly,TRANSFORM(reunion.layouts.lIteration,SELF.came_from:=sIteration;SELF:=LEFT;))+dInfile;

END;