// Begin code to generate cleave points
IMPORT SALT30,ut,std;
EXPORT Cleave(DATASET(layout_HealthFacility) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
// Cleave points for NPI_NUMBER
  bse := DISTRIBUTE(TABLE(h,{LNPID,NPI_NUMBER}),HASH(LNPID));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_NPI_NUMBER := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), LNPID,NPI_NUMBER}, LNPID,NPI_NUMBER,LOCAL);
EXPORT FullTallied_NPI_NUMBER := Tallied_NPI_NUMBER(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER));// Only 'full' values for cleave-determination
  TYPEOF(FullTallied_NPI_NUMBER) tally(FullTallied_NPI_NUMBER le,FullTallied_NPI_NUMBER ri) := TRANSFORM
    SELF.Position := IF ( le.LNPID = ri.LNPID, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_NPI_NUMBER sorted by LNPID by previous TABLE statement
  enumerated := ITERATE(FullTallied_NPI_NUMBER,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.NPI_NUMBER) left_NPI_NUMBER;
    TYPEOF(enumerated.NPI_NUMBER) right_NPI_NUMBER;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT30.UIDType LNPID;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_NPI_NUMBER := le.NPI_NUMBER;
    SELF.right_NPI_NUMBER := ri.NPI_NUMBER;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.LNPID := le.LNPID;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_NPI_NUMBER_ni := JOIN( enumerated(cnt>=2), enumerated(cnt>=2), LEFT.LNPID = RIGHT.LNPID
       AND NOT LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_NPI_NUMBER_ni := DEDUP( SORT( Possibles_NPI_NUMBER_ni, LNPID, -cnt, LOCAL ), LNPID, LOCAL );
SHARED Candidates_NPI_NUMBER := Candidates_NPI_NUMBER_ni : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Cleave::Candidates_NPI_NUMBER',EXPIRE(Config.PersistExpire));
EXPORT Candidates_NPI_NUMBERKeyName := '~'+'key::HealthCareFacilityHeader_Best::LNPID::Candidates_NPI_NUMBER';
EXPORT Candidates_NPI_NUMBER_Idx := INDEX(Candidates_NPI_NUMBER,{LNPID},{Candidates_NPI_NUMBER},Candidates_NPI_NUMBERKeyName);
SHARED Possibles_NPI_NUMBER := Possibles_NPI_NUMBER_ni : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Cleave::Possibles_NPI_NUMBER',EXPIRE(Config.PersistExpire));
EXPORT Possibles_NPI_NUMBERKeyName := '~'+'key::HealthCareFacilityHeader_Best::LNPID::Possibles_NPI_NUMBER';
EXPORT Possibles_NPI_NUMBER_Idx := INDEX(Possibles_NPI_NUMBER,{LNPID},{Possibles_NPI_NUMBER},Possibles_NPI_NUMBERKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_NPI_NUMBER(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := IF(RoxieService, Candidates_NPI_NUMBER_ni, Candidates_NPI_NUMBER);
  R := RECORD
    inp;
    SALT30.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_NPI_NUMBER = le.NPI_NUMBER AND le.NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER);
    BOOLEAN right_match := ri.right_NPI_NUMBER = le.NPI_NUMBER AND le.NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER);
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
EXPORT PossiblesCounts := DATASET([{COUNT(Possibles_NPI_NUMBER)}],{UNSIGNED count_Possibles_NPI_NUMBER});
EXPORT CandidatesCounts := DATASET([{COUNT(Candidates_NPI_NUMBER)}],{UNSIGNED count_Candidates_NPI_NUMBER});
  converted0 := CleaveBy_NPI_NUMBER(h);
  converted1 := converted0;
SHARED input_file_np := IF(Config.ByPassCleave,h,converted1);
EXPORT input_file := input_file_np : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Cleave::input_file',EXPIRE(Config.PersistExpire));
// Now create a 'patch' file to be used elsewhere
// Find 'what changed' in the input file
EXPORT patch_file_np := JOIN( TABLE( input_file_np, { LNPID, RID }),h, LEFT.LNPID=RIGHT.LNPID AND LEFT.RID=RIGHT.RID,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT patch_file := patch_file_np : PERSIST('~temp::LNPID::HealthCareFacilityHeader_Best::Cleave::patch_file',EXPIRE(Config.PersistExpire));
EXPORT patch_count := COUNT(DEDUP(patch_file,LNPID,ALL)); // Number of new LNPID created
EXPORT Stats := PARALLEL(OUTPUT(PossiblesCounts,NAMED('PossibleCleaves')),OUTPUT(CandidatesCounts,NAMED('CandidateCleaves')),OUTPUT(patch_count,NAMED('LNPIDsCreatedByCleave')));
EXPORT BuildAll := SEQUENTIAL(PARALLEL(BUILDINDEX(Candidates_NPI_NUMBER_Idx, OVERWRITE),BUILDINDEX(Possibles_NPI_NUMBER_Idx, OVERWRITE)),Stats);
END;
