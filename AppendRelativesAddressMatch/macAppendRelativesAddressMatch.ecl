EXPORT macAppendRelativesAddressMatch(dIn, inLexID, inPrimRange, inPrimName, InZip, appendPrefix = '\'\'',filterStatement = '\'\'', UseIndexThreshold=100000000) := FUNCTIONMACRO
	IMPORT hipie_ecl, Relationship, doxie;
	LOCAL dDistributed 	:= DISTRIBUTE(dIn((UNSIGNED)inLexID <> 0 #IF(filterStatement != '') AND #EXPAND(filterStatement) #END), HASH32(inLexID));
	LOCAL dDeduped 			:= SORT(DEDUP(dDistributed, inLexID, LOCAL), inLexID, LOCAL);

	LOCAL dRelatives 		:= hipie_ecl.macJoinKey(dDeduped , Relationship.key_relatives_v3,
		'KEYED((UNSIGNED)LEFT.' + #TEXT(inLexID) + ' = RIGHT.did1)',
		'(UNSIGNED)RIGHT.' + #TEXT(inLexID) + ' = LEFT.did1',
		UseIndexThreshold,
		AtmostOption := TRUE, AtmostValue := 500, HashOption := TRUE); 
		
	LOCAL PopulationRelatives := PROJECT(dRelatives,
		TRANSFORM({
			LEFT.inLexID, 
			LEFT.prim_range,
			LEFT.prim_name;
			LEFT.z5,
			LEFT.did2
		},
		SELF := LEFT));

	// Relatives address matching...
	LOCAL dRelativeMatch := hipie_ecl.macJoinKey(PopulationRelatives, doxie.key_header,
		'KEYED((UNSIGNED)LEFT.' + #TEXT(inLexID) + ' = (UNSIGNED)RIGHT.s_did) AND LEFT.' + #TEXT(inPrimRange) + ' = RIGHT.prim_range AND LEFT.' + #TEXT(inPrimName) + ' = RIGHT.prim_name AND LEFT.' + #TEXT(inZip) + ' = RIGHT.zip',
		'(UNSIGNED)RIGHT.' + #TEXT(inLexID) + ' = (UNSIGNED)LEFT.s_did AND RIGHT.' + #TEXT(inPrimRange) + ' = LEFT.prim_range AND RIGHT.' + #TEXT(inPrimName) + ' = LEFT.prim_name AND RIGHT.' + #TEXT(inZip) + ' = LEFT.zip',
		UseIndexThreshold,
		JoinType := 'INNER',
		KeepOption := false, KeepValue := 1, AtmostOption := TRUE, AtmostValue := 10000);
		
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER1 #EXPAND(appendPrefix + 'RelativeAddressMatch');
  END;
	LOCAL RelativeMatch := DEDUP(SORT(DISTRIBUTE(PROJECT(dRelativeMatch,
		TRANSFORM({RECORDOF(LEFT), INTEGER1 RelativeAddressMatch}, 
			SELF.#EXPAND(appendPrefix + 'RelativeAddressMatch') := 1, 
			SELF := LEFT,
			SELF := [])), HASH32(inLexID)), inLexID, -#EXPAND(appendPrefix + 'RelativeAddressMatch'), LOCAL), inLexID, LOCAL);
		
	LOCAL dOut := JOIN(dDistributed, RelativeMatch,
		(UNSIGNED)LEFT.inLexID = (UNSIGNED)RIGHT.inLexID,
		TRANSFORM(rOut,
			SELF.#EXPAND(appendPrefix + 'RelativeAddressMatch') := RIGHT.#EXPAND(appendPrefix + 'RelativeAddressMatch'),
			SELF := LEFT),
		LEFT OUTER, LOCAL) +
		PROJECT(dIn(NOT((UNSIGNED)inLexID <> 0 #IF(filterStatement != '') AND #EXPAND(filterStatement) #END)),
			TRANSFORM(rOut,
			SELF.#EXPAND(appendPrefix + 'RelativeAddressMatch') := 0,
			SELF := LEFT));
	RETURN dOut;
ENDMACRO;