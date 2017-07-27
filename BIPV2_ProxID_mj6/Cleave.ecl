// Begin code to generate cleave points
import SALT28,ut;
EXPORT Cleave(DATASET(layout_DOT_Base) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);
 
// Cleave points for active_domestic_corp_key
  bse := DISTRIBUTE(TABLE(h,{Proxid,active_domestic_corp_key}),HASH(Proxid));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_active_domestic_corp_key := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), Proxid,active_domestic_corp_key}, Proxid,active_domestic_corp_key,LOCAL);
EXPORT FullTallied_active_domestic_corp_key := Tallied_active_domestic_corp_key(active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key));// Only 'full' values for cleave-determination
 
  TYPEOF(FullTallied_active_domestic_corp_key) tally(FullTallied_active_domestic_corp_key le,FullTallied_active_domestic_corp_key ri) := TRANSFORM
    SELF.Position := IF ( le.Proxid = ri.Proxid, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_active_domestic_corp_key sorted by Proxid by previous TABLE statement
  enumerated := ITERATE(FullTallied_active_domestic_corp_key,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.active_domestic_corp_key) left_active_domestic_corp_key;
    TYPEOF(enumerated.active_domestic_corp_key) right_active_domestic_corp_key;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT28.UIDType Proxid;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_active_domestic_corp_key := le.active_domestic_corp_key;
    SELF.right_active_domestic_corp_key := ri.active_domestic_corp_key;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.Proxid := le.Proxid;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_active_domestic_corp_key_ni := JOIN( enumerated(cnt>=1), enumerated(cnt>=1), LEFT.Proxid = RIGHT.Proxid
       AND NOT LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_active_domestic_corp_key_ni := DEDUP( SORT( Possibles_active_domestic_corp_key_ni, Proxid, -cnt, LOCAL ), Proxid, LOCAL );
 
EXPORT Candidates_active_domestic_corp_keyKeyName := '~'+'key::BIPV2_ProxID_mj6::Proxid::Candidates_active_domestic_corp_key';
 
EXPORT Candidates_active_domestic_corp_key := INDEX(Candidates_active_domestic_corp_key_ni,{Proxid},{Candidates_active_domestic_corp_key_ni},Candidates_active_domestic_corp_keyKeyName);
 
EXPORT Possibles_active_domestic_corp_keyKeyName := '~'+'key::BIPV2_ProxID_mj6::Proxid::Possibles_active_domestic_corp_key';
 
EXPORT Possibles_active_domestic_corp_key := INDEX(Possibles_active_domestic_corp_key_ni,{Proxid},{Possibles_active_domestic_corp_key_ni},Possibles_active_domestic_corp_keyKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_active_domestic_corp_key(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := Candidates_active_domestic_corp_key;
  R := RECORD
    inp;
    SALT28.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_active_domestic_corp_key = le.active_domestic_corp_key AND le.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key);
    BOOLEAN right_match := ri.right_active_domestic_corp_key = le.active_domestic_corp_key AND le.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key);
    SELF.__Cluster := MAP ( ri.Proxid = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.Proxid;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.Proxid=RIGHT.Proxid,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.Proxid=RIGHT.Proxid,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.Proxid := MAP ( ri.__Cluster = -1 => ri.Proxid, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.rcid, // Starting to process a changed Proxid
                     le.__Cluster = ri.__Cluster => le.Proxid,
                     ri.rcid);
    SELF := ri;
  END;
  I := ITERATE( SORT( J, __shadow, -__Cluster, rcid, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
 
// Cleave points for cnp_number
  bse := DISTRIBUTE(TABLE(h,{Proxid,cnp_number}),HASH(Proxid));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_cnp_number := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), Proxid,cnp_number}, Proxid,cnp_number,LOCAL);
EXPORT FullTallied_cnp_number := Tallied_cnp_number(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number));// Only 'full' values for cleave-determination
 
  TYPEOF(FullTallied_cnp_number) tally(FullTallied_cnp_number le,FullTallied_cnp_number ri) := TRANSFORM
    SELF.Position := IF ( le.Proxid = ri.Proxid, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_cnp_number sorted by Proxid by previous TABLE statement
  enumerated := ITERATE(FullTallied_cnp_number,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.cnp_number) left_cnp_number;
    TYPEOF(enumerated.cnp_number) right_cnp_number;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT28.UIDType Proxid;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_cnp_number := le.cnp_number;
    SELF.right_cnp_number := ri.cnp_number;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.Proxid := le.Proxid;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_cnp_number_ni := JOIN( enumerated(cnt>=1), enumerated(cnt>=1), LEFT.Proxid = RIGHT.Proxid
       AND NOT LEFT.cnp_number = RIGHT.cnp_number,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_cnp_number_ni := DEDUP( SORT( Possibles_cnp_number_ni, Proxid, -cnt, LOCAL ), Proxid, LOCAL );
 
EXPORT Candidates_cnp_numberKeyName := '~'+'key::BIPV2_ProxID_mj6::Proxid::Candidates_cnp_number';
 
EXPORT Candidates_cnp_number := INDEX(Candidates_cnp_number_ni,{Proxid},{Candidates_cnp_number_ni},Candidates_cnp_numberKeyName);
 
EXPORT Possibles_cnp_numberKeyName := '~'+'key::BIPV2_ProxID_mj6::Proxid::Possibles_cnp_number';
 
EXPORT Possibles_cnp_number := INDEX(Possibles_cnp_number_ni,{Proxid},{Possibles_cnp_number_ni},Possibles_cnp_numberKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_cnp_number(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := Candidates_cnp_number;
  R := RECORD
    inp;
    SALT28.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_cnp_number = le.cnp_number AND le.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number);
    BOOLEAN right_match := ri.right_cnp_number = le.cnp_number AND le.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number);
    SELF.__Cluster := MAP ( ri.Proxid = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.Proxid;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.Proxid=RIGHT.Proxid,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.Proxid=RIGHT.Proxid,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.Proxid := MAP ( ri.__Cluster = -1 => ri.Proxid, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.rcid, // Starting to process a changed Proxid
                     le.__Cluster = ri.__Cluster => le.Proxid,
                     ri.rcid);
    SELF := ri;
  END;
  I := ITERATE( SORT( J, __shadow, -__Cluster, rcid, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
EXPORT PossiblesCounts := DATASET([{COUNT(Possibles_active_domestic_corp_key),COUNT(Possibles_cnp_number)}],{UNSIGNED count_Possibles_active_domestic_corp_key,UNSIGNED count_Possibles_cnp_number});
EXPORT CandidatesCounts := DATASET([{COUNT(Candidates_active_domestic_corp_key),COUNT(Candidates_cnp_number)}],{UNSIGNED count_Candidates_active_domestic_corp_key,UNSIGNED count_Candidates_cnp_number});
  converted0 := CleaveBy_active_domestic_corp_key(h);
  converted1 := CleaveBy_cnp_number(converted0);
EXPORT input_file := converted1;
// Now create a 'patch' file to be used elsewhere
// Find 'what changed' in the input file
EXPORT patch_file := JOIN( TABLE( input_file, { Proxid, rcid }),h, LEFT.Proxid=RIGHT.Proxid AND LEFT.rcid=RIGHT.rcid,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT patch_count := COUNT(DEDUP(patch_file,Proxid,ALL)); // Number of new Proxid created
EXPORT Stats := PARALLEL(OUTPUT(PossiblesCounts,NAMED('PossibleCleaves')),OUTPUT(CandidatesCounts,NAMED('CandidateCleaves')),OUTPUT(patch_count,NAMED('ProxidsCreatedByCleave')));
EXPORT BuildAll := SEQUENTIAL(PARALLEL(BUILDINDEX(Candidates_active_domestic_corp_key, OVERWRITE),BUILDINDEX(Possibles_active_domestic_corp_key, OVERWRITE),BUILDINDEX(Candidates_cnp_number, OVERWRITE),BUILDINDEX(Possibles_cnp_number, OVERWRITE)),Stats);
END;
