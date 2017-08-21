// Begin code to generate cleave points
IMPORT SALT30,ut,std;
EXPORT Cleave(DATASET(layout_HealthFacility) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
// Cleave points for TAXONOMY_CODE
  bse := DISTRIBUTE(TABLE(h,{LNPID,TAXONOMY_CODE}),HASH(LNPID));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_TAXONOMY_CODE := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), LNPID,TAXONOMY_CODE}, LNPID,TAXONOMY_CODE,LOCAL);
EXPORT FullTallied_TAXONOMY_CODE := Tallied_TAXONOMY_CODE(TAXONOMY_CODE NOT IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE));// Only 'full' values for cleave-determination
  TYPEOF(FullTallied_TAXONOMY_CODE) tally(FullTallied_TAXONOMY_CODE le,FullTallied_TAXONOMY_CODE ri) := TRANSFORM
    SELF.Position := IF ( le.LNPID = ri.LNPID, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_TAXONOMY_CODE sorted by LNPID by previous TABLE statement
  enumerated := ITERATE(FullTallied_TAXONOMY_CODE,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.TAXONOMY_CODE) left_TAXONOMY_CODE;
    TYPEOF(enumerated.TAXONOMY_CODE) right_TAXONOMY_CODE;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT30.UIDType LNPID;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_TAXONOMY_CODE := le.TAXONOMY_CODE;
    SELF.right_TAXONOMY_CODE := ri.TAXONOMY_CODE;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.LNPID := le.LNPID;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_TAXONOMY_CODE_ni := JOIN( enumerated(cnt>=2), enumerated(cnt>=2), LEFT.LNPID = RIGHT.LNPID
       AND NOT LEFT.TAXONOMY_CODE = RIGHT.TAXONOMY_CODE,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_TAXONOMY_CODE_ni := DEDUP( SORT( Possibles_TAXONOMY_CODE_ni, LNPID, -cnt, LOCAL ), LNPID, LOCAL );
SHARED Candidates_TAXONOMY_CODE := Candidates_TAXONOMY_CODE_ni : PERSIST('~temp::LNPID::HealthCareFacilityHeader::Cleave::Candidates_TAXONOMY_CODE',EXPIRE(Config.PersistExpire));
EXPORT Candidates_TAXONOMY_CODEKeyName := '~'+'key::HealthCareFacilityHeader::LNPID::Candidates_TAXONOMY_CODE';
EXPORT Candidates_TAXONOMY_CODE_Idx := INDEX(Candidates_TAXONOMY_CODE,{LNPID},{Candidates_TAXONOMY_CODE},Candidates_TAXONOMY_CODEKeyName);
SHARED Possibles_TAXONOMY_CODE := Possibles_TAXONOMY_CODE_ni : PERSIST('~temp::LNPID::HealthCareFacilityHeader::Cleave::Possibles_TAXONOMY_CODE',EXPIRE(Config.PersistExpire));
EXPORT Possibles_TAXONOMY_CODEKeyName := '~'+'key::HealthCareFacilityHeader::LNPID::Possibles_TAXONOMY_CODE';
EXPORT Possibles_TAXONOMY_CODE_Idx := INDEX(Possibles_TAXONOMY_CODE,{LNPID},{Possibles_TAXONOMY_CODE},Possibles_TAXONOMY_CODEKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_TAXONOMY_CODE(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := IF(RoxieService, Candidates_TAXONOMY_CODE_ni, Candidates_TAXONOMY_CODE);
  R := RECORD
    inp;
    SALT30.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_TAXONOMY_CODE = le.TAXONOMY_CODE AND le.TAXONOMY_CODE NOT IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE);
    BOOLEAN right_match := ri.right_TAXONOMY_CODE = le.TAXONOMY_CODE AND le.TAXONOMY_CODE NOT IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE);
    SELF.__Cluster := MAP ( ri.LNPID = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.LNPID;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.LNPID=RIGHT.LNPID,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.LNPID=RIGHT.LNPID,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J2 := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.LNPID := MAP ( ri.__Cluster = -1 => ri.LNPID, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.RID, // Starting to process a changed LNPID
                     ri.__Cluster = 0 => ri.RID, // exploding
                     le.__Cluster = ri.__Cluster => le.LNPID,
                     ri.RID);
    SELF := ri;
  END;
  I := ITERATE( SORT( J2, __shadow, -__Cluster, RID, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
EXPORT PossiblesCounts := DATASET([{COUNT(Possibles_TAXONOMY_CODE)}],{UNSIGNED count_Possibles_TAXONOMY_CODE});
EXPORT CandidatesCounts := DATASET([{COUNT(Candidates_TAXONOMY_CODE)}],{UNSIGNED count_Candidates_TAXONOMY_CODE});
  converted0 := CleaveBy_TAXONOMY_CODE(h);
  converted1 := converted0;
SHARED input_file_np := IF(Config.ByPassCleave,h,converted1);
EXPORT input_file := input_file_np : PERSIST('~temp::LNPID::HealthCareFacilityHeader::Cleave::input_file',EXPIRE(Config.PersistExpire));
// Now create a 'patch' file to be used elsewhere
// Find 'what changed' in the input file
EXPORT patch_file_np := JOIN( TABLE( input_file_np, { LNPID, RID }),h, LEFT.LNPID=RIGHT.LNPID AND LEFT.RID=RIGHT.RID,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT patch_file := patch_file_np : PERSIST('~temp::LNPID::HealthCareFacilityHeader::Cleave::patch_file',EXPIRE(Config.PersistExpire));
EXPORT patch_count := COUNT(DEDUP(patch_file,LNPID,ALL)); // Number of new LNPID created
EXPORT Stats := PARALLEL(OUTPUT(PossiblesCounts,NAMED('PossibleCleaves')),OUTPUT(CandidatesCounts,NAMED('CandidateCleaves')),OUTPUT(patch_count,NAMED('LNPIDsCreatedByCleave')));
EXPORT BuildAll := SEQUENTIAL(PARALLEL(BUILDINDEX(Candidates_TAXONOMY_CODE_Idx, OVERWRITE),BUILDINDEX(Possibles_TAXONOMY_CODE_Idx, OVERWRITE)),Stats);
END;
