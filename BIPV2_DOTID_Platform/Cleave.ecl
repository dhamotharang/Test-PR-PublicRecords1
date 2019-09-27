// Begin code to generate cleave points
IMPORT SALT32,ut,std;
EXPORT Cleave(DATASET(layout_DOT) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := BasicMatch(ih).input_file;
SHARED h0 := IF(RoxieService,Specificities(ih).input_file_np,h00);
SHARED h := PROJECT(h0,TRANSFORM({h0,SALT32.UIDType copy_DOTid},SELF.copy_DOTid:=LEFT.DOTid, SELF:=LEFT));
 
// Cleave points for cnp_number
  bse := DISTRIBUTE(TABLE(h,{DOTid,cnp_number}),HASH(DOTid));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_cnp_number := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), DOTid,cnp_number}, DOTid,cnp_number,LOCAL);
EXPORT FullTallied_cnp_number := Tallied_cnp_number(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) AND cnp_number <> (TYPEOF(cnp_number))'');// Only 'full' values for cleave-determination
 
  TYPEOF(FullTallied_cnp_number) tally(FullTallied_cnp_number le,FullTallied_cnp_number ri) := TRANSFORM
    SELF.Position := IF ( le.DOTid = ri.DOTid, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_cnp_number sorted by DOTid by previous TABLE statement
  enumerated := ITERATE(FullTallied_cnp_number,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.cnp_number) left_cnp_number;
    TYPEOF(enumerated.cnp_number) right_cnp_number;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT32.UIDType DOTid;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_cnp_number := le.cnp_number;
    SELF.right_cnp_number := ri.cnp_number;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.DOTid := le.DOTid;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_cnp_number_ni := JOIN( enumerated(cnt>=1), enumerated(cnt>=1), LEFT.DOTid = RIGHT.DOTid
       AND NOT LEFT.cnp_number = RIGHT.cnp_number,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_cnp_number_ni := DEDUP( SORT( Possibles_cnp_number_ni, DOTid, -cnt, LOCAL ), DOTid, LOCAL );
SHARED Candidates_cnp_number := Candidates_cnp_number_ni : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::Candidates_cnp_number',EXPIRE(Config.PersistExpire));
 
EXPORT Candidates_cnp_numberKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Candidates_cnp_number';
 
EXPORT Candidates_cnp_number_Idx := INDEX(Candidates_cnp_number,{DOTid},{Candidates_cnp_number},Candidates_cnp_numberKeyName);
SHARED Possibles_cnp_number := Possibles_cnp_number_ni : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::Possibles_cnp_number',EXPIRE(Config.PersistExpire));
 
EXPORT Possibles_cnp_numberKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Possibles_cnp_number';
 
EXPORT Possibles_cnp_number_Idx := INDEX(Possibles_cnp_number,{DOTid},{Possibles_cnp_number},Possibles_cnp_numberKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_cnp_number(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := IF(RoxieService, Candidates_cnp_number_ni, Candidates_cnp_number);
  R := RECORD
    inp;
    SALT32.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_cnp_number = le.cnp_number AND le.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) AND le.cnp_number <> (TYPEOF(le.cnp_number))'';
    BOOLEAN right_match := ri.right_cnp_number = le.cnp_number AND le.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) AND le.cnp_number <> (TYPEOF(le.cnp_number))'';
    SELF.__Cluster := MAP ( ri.DOTid = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.DOTid;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.copy_DOTid=RIGHT.DOTid,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.copy_DOTid=RIGHT.DOTid,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J2 := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.DOTid := MAP ( ri.__Cluster = -1 => ri.DOTid, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.rcid, // Starting to process a changed DOTid
                     le.__Cluster = ri.__Cluster => le.DOTid,
                     ri.rcid);
    SELF := ri;
  END;
  I := ITERATE( SORT( J2, __shadow, -__Cluster, rcid, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
 
// Cleave points for active_enterprise_number
  bse := DISTRIBUTE(TABLE(h,{DOTid,active_enterprise_number}),HASH(DOTid));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_active_enterprise_number := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), DOTid,active_enterprise_number}, DOTid,active_enterprise_number,LOCAL);
EXPORT FullTallied_active_enterprise_number := Tallied_active_enterprise_number(active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) AND active_enterprise_number <> (TYPEOF(active_enterprise_number))'');// Only 'full' values for cleave-determination
 
  TYPEOF(FullTallied_active_enterprise_number) tally(FullTallied_active_enterprise_number le,FullTallied_active_enterprise_number ri) := TRANSFORM
    SELF.Position := IF ( le.DOTid = ri.DOTid, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_active_enterprise_number sorted by DOTid by previous TABLE statement
  enumerated := ITERATE(FullTallied_active_enterprise_number,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.active_enterprise_number) left_active_enterprise_number;
    TYPEOF(enumerated.active_enterprise_number) right_active_enterprise_number;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT32.UIDType DOTid;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_active_enterprise_number := le.active_enterprise_number;
    SELF.right_active_enterprise_number := ri.active_enterprise_number;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.DOTid := le.DOTid;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_active_enterprise_number_ni := JOIN( enumerated(cnt>=1), enumerated(cnt>=1), LEFT.DOTid = RIGHT.DOTid
       AND NOT LEFT.active_enterprise_number = RIGHT.active_enterprise_number,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_active_enterprise_number_ni := DEDUP( SORT( Possibles_active_enterprise_number_ni, DOTid, -cnt, LOCAL ), DOTid, LOCAL );
SHARED Candidates_active_enterprise_number := Candidates_active_enterprise_number_ni : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::Candidates_active_enterprise_number',EXPIRE(Config.PersistExpire));
 
EXPORT Candidates_active_enterprise_numberKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Candidates_active_enterprise_number';
 
EXPORT Candidates_active_enterprise_number_Idx := INDEX(Candidates_active_enterprise_number,{DOTid},{Candidates_active_enterprise_number},Candidates_active_enterprise_numberKeyName);
SHARED Possibles_active_enterprise_number := Possibles_active_enterprise_number_ni : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::Possibles_active_enterprise_number',EXPIRE(Config.PersistExpire));
 
EXPORT Possibles_active_enterprise_numberKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Possibles_active_enterprise_number';
 
EXPORT Possibles_active_enterprise_number_Idx := INDEX(Possibles_active_enterprise_number,{DOTid},{Possibles_active_enterprise_number},Possibles_active_enterprise_numberKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_active_enterprise_number(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := IF(RoxieService, Candidates_active_enterprise_number_ni, Candidates_active_enterprise_number);
  R := RECORD
    inp;
    SALT32.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_active_enterprise_number = le.active_enterprise_number AND le.active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) AND le.active_enterprise_number <> (TYPEOF(le.active_enterprise_number))'';
    BOOLEAN right_match := ri.right_active_enterprise_number = le.active_enterprise_number AND le.active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) AND le.active_enterprise_number <> (TYPEOF(le.active_enterprise_number))'';
    SELF.__Cluster := MAP ( ri.DOTid = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.DOTid;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.copy_DOTid=RIGHT.DOTid,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.copy_DOTid=RIGHT.DOTid,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J2 := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.DOTid := MAP ( ri.__Cluster = -1 => ri.DOTid, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.rcid, // Starting to process a changed DOTid
                     le.__Cluster = ri.__Cluster => le.DOTid,
                     ri.rcid);
    SELF := ri;
  END;
  I := ITERATE( SORT( J2, __shadow, -__Cluster, rcid, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
 
// Cleave points for active_domestic_corp_key
  bse := DISTRIBUTE(TABLE(h,{DOTid,active_domestic_corp_key}),HASH(DOTid));
// Simple counts of all the unique combinations of the basis
EXPORT  Tallied_active_domestic_corp_key := TABLE(bse,{ UNSIGNED2 Position := 0, UNSIGNED Cnt := COUNT(GROUP), DOTid,active_domestic_corp_key}, DOTid,active_domestic_corp_key,LOCAL);
EXPORT FullTallied_active_domestic_corp_key := Tallied_active_domestic_corp_key(active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) AND active_domestic_corp_key <> (TYPEOF(active_domestic_corp_key))'');// Only 'full' values for cleave-determination
 
  TYPEOF(FullTallied_active_domestic_corp_key) tally(FullTallied_active_domestic_corp_key le,FullTallied_active_domestic_corp_key ri) := TRANSFORM
    SELF.Position := IF ( le.DOTid = ri.DOTid, le.Position+1, 1 );
    SELF := ri;
  END;
// FullTallied_active_domestic_corp_key sorted by DOTid by previous TABLE statement
  enumerated := ITERATE(FullTallied_active_domestic_corp_key,tally(LEFT,RIGHT),LOCAL);
  cleavecandidate := RECORD
    TYPEOF(enumerated.active_domestic_corp_key) left_active_domestic_corp_key;
    TYPEOF(enumerated.active_domestic_corp_key) right_active_domestic_corp_key;
    UNSIGNED2 left_pos;
    UNSIGNED2 right_pos;
    UNSIGNED Cnt;
    SALT32.UIDType DOTid;
  END;
  cleavecandidate make_cand(enumerated le,enumerated ri) := TRANSFORM
    SELF.left_active_domestic_corp_key := le.active_domestic_corp_key;
    SELF.right_active_domestic_corp_key := ri.active_domestic_corp_key;
    SELF.left_pos := le.position;
    SELF.right_pos := ri.position;
    SELF.Cnt := le.cnt+ri.cnt;
    SELF.DOTid := le.DOTid;
  END;
// Find those sets of values that completely disagree
 // All the pairs of values that completely dis-agree - they could be cleave points IF nothiing joins them
EXPORT Possibles_active_domestic_corp_key_ni := JOIN( enumerated(cnt>=1), enumerated(cnt>=1), LEFT.DOTid = RIGHT.DOTid
       AND NOT LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key,make_cand(LEFT,RIGHT),LOCAL);
EXPORT Candidates_active_domestic_corp_key_ni := DEDUP( SORT( Possibles_active_domestic_corp_key_ni, DOTid, -cnt, LOCAL ), DOTid, LOCAL );
SHARED Candidates_active_domestic_corp_key := Candidates_active_domestic_corp_key_ni : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::Candidates_active_domestic_corp_key',EXPIRE(Config.PersistExpire));
 
EXPORT Candidates_active_domestic_corp_keyKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Candidates_active_domestic_corp_key';
 
EXPORT Candidates_active_domestic_corp_key_Idx := INDEX(Candidates_active_domestic_corp_key,{DOTid},{Candidates_active_domestic_corp_key},Candidates_active_domestic_corp_keyKeyName);
SHARED Possibles_active_domestic_corp_key := Possibles_active_domestic_corp_key_ni : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::Possibles_active_domestic_corp_key',EXPIRE(Config.PersistExpire));
 
EXPORT Possibles_active_domestic_corp_keyKeyName := '~'+'key::BIPV2_DOTID_PLATFORM::DOTid::Possibles_active_domestic_corp_key';
 
EXPORT Possibles_active_domestic_corp_key_Idx := INDEX(Possibles_active_domestic_corp_key,{DOTid},{Possibles_active_domestic_corp_key},Possibles_active_domestic_corp_keyKeyName);
// Now construct a function that will perform the cleaves
EXPORT CleaveBy_active_domestic_corp_key(DATASET(RECORDOF(h)) inp) := FUNCTION
  K := IF(RoxieService, Candidates_active_domestic_corp_key_ni, Candidates_active_domestic_corp_key);
  R := RECORD
    inp;
    SALT32.UIDType __Shadow; // Track old during processing
    INTEGER1 __Cluster := -1; // -1<no-cleave>, 0 <none>, 1<left>, 2<right>
  END;
  R TakeCleave(inp le,k ri) := TRANSFORM
    BOOLEAN left_match := ri.left_active_domestic_corp_key = le.active_domestic_corp_key AND le.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) AND le.active_domestic_corp_key <> (TYPEOF(le.active_domestic_corp_key))'';
    BOOLEAN right_match := ri.right_active_domestic_corp_key = le.active_domestic_corp_key AND le.active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) AND le.active_domestic_corp_key <> (TYPEOF(le.active_domestic_corp_key))'';
    SELF.__Cluster := MAP ( ri.DOTid = 0 => -1, left_match => 1, right_match => 2, 0 );
    SELF.__Shadow := le.DOTid;
    SELF := le;
  END;
  J0 := JOIN(inp,k,LEFT.copy_DOTid=RIGHT.DOTid,TakeCleave(LEFT,RIGHT),LOOKUP,LEFT OUTER);
  J1 := JOIN(inp,k,LEFT.copy_DOTid=RIGHT.DOTid,TakeCleave(LEFT,RIGHT),LEFT OUTER); // Debug/roxie version
  J2 := IF ( COUNT(inp) < 100, J1, J0 );
  R ResetDids(R le, R ri) := TRANSFORM
    SELF.DOTid := MAP ( ri.__Cluster = -1 => ri.DOTid, // untouched cluster
                     le.__shadow <> ri.__shadow => ri.rcid, // Starting to process a changed DOTid
                     le.__Cluster = ri.__Cluster => le.DOTid,
                     ri.rcid);
    SELF := ri;
  END;
  I := ITERATE( SORT( J2, __shadow, -__Cluster, rcid, LOCAL), ResetDids(LEFT,RIGHT),LOCAL);
  RETURN PROJECT(I,TRANSFORM(RECORDOF(inp), SELF := LEFT));
END;
EXPORT PossiblesCounts := DATASET([{COUNT(Possibles_cnp_number),COUNT(Possibles_active_enterprise_number),COUNT(Possibles_active_domestic_corp_key)}],{UNSIGNED count_Possibles_cnp_number,UNSIGNED count_Possibles_active_enterprise_number,UNSIGNED count_Possibles_active_domestic_corp_key});
EXPORT CandidatesCounts := DATASET([{COUNT(Candidates_cnp_number),COUNT(Candidates_active_enterprise_number),COUNT(Candidates_active_domestic_corp_key)}],{UNSIGNED count_Candidates_cnp_number,UNSIGNED count_Candidates_active_enterprise_number,UNSIGNED count_Candidates_active_domestic_corp_key});
  cands_thin0 := TABLE(IF(RoxieService, PROJECT(Candidates_cnp_number_ni, RECORDOF(Candidates_cnp_number)), Candidates_cnp_number), {DOTid}, DOTid, LOCAL);
  cands_thin1 := TABLE(IF(RoxieService, PROJECT(Candidates_active_enterprise_number_ni, RECORDOF(Candidates_active_enterprise_number)), Candidates_active_enterprise_number), {DOTid}, DOTid, LOCAL);
  cands_thin2 := TABLE(IF(RoxieService, PROJECT(Candidates_active_domestic_corp_key_ni, RECORDOF(Candidates_active_domestic_corp_key)), Candidates_active_domestic_corp_key), {DOTid}, DOTid, LOCAL);
  cands_thin := TABLE(cands_thin0+cands_thin1+cands_thin2, {DOTid}, DOTid);
  h_cands := JOIN(h, cands_thin, LEFT.DOTid=RIGHT.DOTid, TRANSFORM(LEFT), HASH);
  h_nocands := JOIN(h, cands_thin, LEFT.DOTid=RIGHT.DOTid, TRANSFORM(LEFT), LEFT ONLY, HASH);
  converted0 := CleaveBy_cnp_number(h_cands);
  converted1 := CleaveBy_active_enterprise_number(converted0);
  converted2 := CleaveBy_active_domestic_corp_key(converted1);
SHARED input_file_np := IF(Config.ByPassCleave,h0,PROJECT(converted2+h_nocands,TRANSFORM(RECORDOF(h0),SELF:=LEFT)));
EXPORT input_file := input_file_np : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::input_file',EXPIRE(Config.PersistExpire));
// Now create a 'patch' file to be used elsewhere
// Find 'what changed' in the input file
EXPORT patch_file_np := JOIN( TABLE( input_file_np, { DOTid, rcid }),h, LEFT.DOTid=RIGHT.DOTid AND LEFT.rcid=RIGHT.rcid,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT patch_file := patch_file_np : PERSIST('~temp::DOTid::BIPV2_DOTID_PLATFORM::Cleave::patch_file',EXPIRE(Config.PersistExpire));
EXPORT patch_count := COUNT(DEDUP(patch_file,DOTid,ALL)); // Number of new DOTid created
EXPORT Stats := PARALLEL(OUTPUT(PossiblesCounts,NAMED('PossibleCleaves')),OUTPUT(CandidatesCounts,NAMED('CandidateCleaves')),OUTPUT(patch_count,NAMED('DOTidsCreatedByCleave')));
EXPORT BuildAll := SEQUENTIAL(PARALLEL(BUILDINDEX(Candidates_cnp_number_Idx, OVERWRITE),BUILDINDEX(Possibles_cnp_number_Idx, OVERWRITE),BUILDINDEX(Candidates_active_enterprise_number_Idx, OVERWRITE),BUILDINDEX(Possibles_active_enterprise_number_Idx, OVERWRITE),BUILDINDEX(Candidates_active_domestic_corp_key_Idx, OVERWRITE),BUILDINDEX(Possibles_active_domestic_corp_key_Idx, OVERWRITE)),Stats);
END;
