//-----------------------------------------------------------------------------
// Determines the relatives for the input dataset, which is a list of DIDs and
// an integer indicating the degree of separation from the data in the original
// input files (came_from='1' is original, '2' is first-degree, etc.)
//-----------------------------------------------------------------------------
IMPORT header,ut,Relationship;

EXPORT mod_get_universe(DATASET(D2C_Customers.layouts.lIteration) dInfile,STRING1 sIteration):=MODULE

  SHARED dRelatives := Relationship.key_relatives_v3(
        not(confidence IN ['NOISE','LOW']) and did1 > 0);
    
  RelCnt := sort(table(dRelatives, {did1, cnt := count(group)}, did1, few, merge), -cnt);

  //Join to drop dids having > 350 relatives
//   SHARED dInDistributed:=DISTRIBUTE(dInfile,HASH(did));
  SHARED dInDistributed:=distribute(join(distribute(dInfile, hash(did)), distribute(RelCnt(cnt > 350), hash(did1)), left.did = right.did1, left only, local), hash(did));

  // dAllRelatives is a slim set of all the relative DID pairs from the header
  // relatives file.  Every pair has two rows, where one row is the swapped
  // version of the other.
  dRelatives01:= PROJECT(dRelatives,TRANSFORM(D2C_Customers.layouts.lRelativesSlim,SELF.lexid1:=LEFT.did1; SELF.lexid2:=LEFT.did2; self := left;));
  dRelatives02:= PROJECT(dRelatives,TRANSFORM(D2C_Customers.layouts.lRelativesSlim,SELF.lexid1:=LEFT.did2;SELF.lexid2:=LEFT.did1; self := left;));
  dAllRelatives:=DEDUP(SORT(DISTRIBUTE(dRelatives01+dRelatives02,HASH(lexid1)),lexid1,lexid2,LOCAL),lexid1,lexid2,LOCAL);

  // An inner join of the relative pairs to the input dataset gives us all the
  // relatives for the people in the input dataset.
  EXPORT relative_pairs:=DEDUP(
            JOIN(dAllRelatives, dInDistributed, LEFT.lexid1=RIGHT.did,
				 TRANSFORM(D2C_Customers.layouts.rRelatives,
                           self.type := (unsigned1)right.came_from;
                           self.Association := if(left.isanylnamematch, 'R', 'A');
                           SELF:=LEFT;),
				LOCAL),
				lexid1,lexid2,ALL,LOCAL);

  // The normalize below creates a one-column list of DIDs which is a combination
  // of the two columns of DIDs from the relative pairs dataset above.  The
  // following LEFT ONLY join drops any of those DIDs that are already in the
  // input dataset.
  dNormalized:=DEDUP(SORT(DISTRIBUTE(
	  			        NORMALIZE(relative_pairs,2,TRANSFORM({unsigned6 did},SELF.did:=CHOOSE(COUNTER,LEFT.lexid1,LEFT.lexid2);)),
					 HASH(did)),did,LOCAL),
			   did,LOCAL);
  dRelativesOnly:=JOIN(dNormalized,dInDistributed,LEFT.did=RIGHT.did,TRANSFORM({unsigned6 did},SELF:=LEFT),LEFT ONLY,LOCAL);

  // Resulting dataset is the new data added to the input dataset.
  EXPORT universe:=PROJECT(dRelativesOnly,TRANSFORM(D2C_Customers.layouts.lIteration,SELF.came_from:=sIteration;SELF:=LEFT;))+dInfile;

END;