// Begin code to generate cleave points
import SALT29,ut;
EXPORT Cleave(DATASET(layout_HealthProvider) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
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
    SALT29.UIDType LNPID;
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
SHARED Candidates_NPI_NUMBER := Candidates_NPI_NUMBER_ni : PERSIST('~temp::LNPID::HealthCareProviderHeader::Cleave::Candidates_NPI_NUMBER',EXPIRE(30));
SHARED Possibles_NPI_NUMBER := Possibles_NPI_NUMBER_ni : PERSIST('~temp::LNPID::HealthCareProviderHeader::Cleave::Possibles_NPI_NUMBER',EXPIRE(30));
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_NPI_NUMBER(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := Candidates_NPI_NUMBER_ni;
  R := RECORD
    inp;
    SALT29.UIDType __Shadow; // Track old during processing
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
  J := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.LNPID := MAP ( ri.__Cluster = -1 => ri.LNPID, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.RID, // Starting to process a changed LNPID
                     ri.__Cluster = 0 => ri.RID, // exploding
                     le.__Cluster = ri.__Cluster => le.LNPID,
                     ri.RID);
    SELF := ri;
  END;
  I := ITERATE( SORT( J, __shadow, -__Cluster, RID, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
// Cleave points for UPIN
  bse := DISTRIBUTE(TABLE(h,{LNPID,UPIN}),HASH(LNPID));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_UPIN := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), LNPID,UPIN}, LNPID,UPIN,LOCAL);
EXPORT FullTallied_UPIN := Tallied_UPIN(UPIN NOT IN SET(s.nulls_UPIN,UPIN));// Only 'full' values for cleave-determination
  TYPEOF(FullTallied_UPIN) tally(FullTallied_UPIN le,FullTallied_UPIN ri) := TRANSFORM
    SELF.Position := IF ( le.LNPID = ri.LNPID, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_UPIN sorted by LNPID by previous TABLE statement
  enumerated := ITERATE(FullTallied_UPIN,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.UPIN) left_UPIN;
    TYPEOF(enumerated.UPIN) right_UPIN;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT29.UIDType LNPID;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_UPIN := le.UPIN;
    SELF.right_UPIN := ri.UPIN;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.LNPID := le.LNPID;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_UPIN_ni := JOIN( enumerated(cnt>=2), enumerated(cnt>=2), LEFT.LNPID = RIGHT.LNPID
       AND NOT LEFT.UPIN = RIGHT.UPIN,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_UPIN_ni := DEDUP( SORT( Possibles_UPIN_ni, LNPID, -cnt, LOCAL ), LNPID, LOCAL );
SHARED Candidates_UPIN := Candidates_UPIN_ni : PERSIST('~temp::LNPID::HealthCareProviderHeader::Cleave::Candidates_UPIN',EXPIRE(30));
SHARED Possibles_UPIN := Possibles_UPIN_ni : PERSIST('~temp::LNPID::HealthCareProviderHeader::Cleave::Possibles_UPIN',EXPIRE(30));
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_UPIN(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := Candidates_UPIN_ni;
  R := RECORD
    inp;
    SALT29.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_UPIN = le.UPIN AND le.UPIN NOT IN SET(s.nulls_UPIN,UPIN);
    BOOLEAN right_match := ri.right_UPIN = le.UPIN AND le.UPIN NOT IN SET(s.nulls_UPIN,UPIN);
    SELF.__Cluster := MAP ( ri.LNPID = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.LNPID;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.LNPID=RIGHT.LNPID,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.LNPID=RIGHT.LNPID,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.LNPID := MAP ( ri.__Cluster = -1 => ri.LNPID, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.RID, // Starting to process a changed LNPID
                     ri.__Cluster = 0 => ri.RID, // exploding
                     le.__Cluster = ri.__Cluster => le.LNPID,
                     ri.RID);
    SELF := ri;
  END;
  I := ITERATE( SORT( J, __shadow, -__Cluster, RID, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
EXPORT PossiblesCounts := DATASET([{COUNT(Possibles_NPI_NUMBER),COUNT(Possibles_UPIN)}],{UNSIGNED count_Possibles_NPI_NUMBER,UNSIGNED count_Possibles_UPIN});
EXPORT CandidatesCounts := DATASET([{COUNT(Candidates_NPI_NUMBER),COUNT(Candidates_UPIN)}],{UNSIGNED count_Candidates_NPI_NUMBER,UNSIGNED count_Candidates_UPIN});
  converted0 := CleaveBy_NPI_NUMBER(h);
  converted1 := CleaveBy_UPIN(converted0);
EXPORT input_file := converted1;
// Now create a 'patch' file to be used elsewhere
// Find 'what changed' in the input file
EXPORT patch_file := JOIN( TABLE( input_file, { LNPID, RID }),h, LEFT.LNPID=RIGHT.LNPID AND LEFT.RID=RIGHT.RID,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT patch_count := COUNT(DEDUP(patch_file,LNPID,ALL)); // Number of new LNPID created
EXPORT Stats := PARALLEL(OUTPUT(PossiblesCounts,NAMED('PossibleCleaves')),OUTPUT(CandidatesCounts,NAMED('CandidateCleaves')),OUTPUT(patch_count,NAMED('LNPIDsCreatedByCleave')));
EXPORT BuildAll := SEQUENTIAL(Stats);
END;
