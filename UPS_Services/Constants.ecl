import mdr;

export Constants := MODULE
		// range of scores... 0 (worst) .. DEFAULT_RANGE (best)
		export UNSIGNED2 DEFAULT_RANGE := 100;

		export unsigned2 SCORE_THRESHOLD := 30;			// score threshold passed into header search modules (through GlobalModule)
		export UNSIGNED2 RESPONSE_THRESHOLD := 40;	// responses scoring below this value are not returned

		export unsigned2 SCORE_THRESHOLD_WATERFALL_PHONES := 74; // 75 and above are good
		
		// tag values for EntityType
		export type_EntityType := STRING15;
		export type_EntityType  TAG_ENTITY_IND := 'Individual';
		export type_EntityType  TAG_ENTITY_BIZ := 'Business';
		export type_EntityType  TAG_ENTITY_UNK := 'Unknown';

		// tag values used in commonLayout.rollup_key_type.  Records the origin
		// of the rollup id column so we can drop RIDs later.
		export STRING7   TAG_ROLLUP_KEY_DID  := 'did';
		export STRING7   TAG_ROLLUP_KEY_LINKID := 'PowID';
		export STRING7   TAG_ROLLUP_KEY_RID  := 'rid';
		export STRING7   TAG_ROLLUP_KEY_FDID := 'fdid';
		export STRING7   TAG_ROLLUP_KEY_FAKEID := 'fakeid';
		// note that MAX_RETURNED_ADDRS is not a hard limit.  This is the limit 
		// for "normal" circumstances, when the matched address is within this
		// limit.  One additional record may be added if the best matching 
		// address does not appear within the top MAX_RETURNED_ADDRS results.
		export UNSIGNED2 DEF_RETURNED_ADDRS := 4;
		export UNSIGNED2 MAX_RETURNED_ADDRS := DEF_RETURNED_ADDRS + 1;
		export UNSIGNED2 MAX_RETURNED_NAMES := 5;

		export TranslationLayout := RECORD
			STRING120 inputRegex;
			STRING120 preferredValue;
		END;

		export BusinessTranslations := DATASET( [ {'\\bWAL{1,3}(\\s*|-)?MA?RT\\b', 'WAL-MART'},
																							{'\\bTA?RG[IY]?T\\b', 'TARGET'},
																							{'\\bHO?ME?(\\s*|-)?DEP(T|O|OT)\\b', 'HOME DEPOT'},
																							{'\\bAC{1,2}(TOI|RITO)N\\b', 'ACTION'},
																							{'\\bT[IR]?[IR]?ADO\\b', 'TIRADO'}],  TranslationLayout );

		// this set of vendors each has nation-wide coverage and provides good
		// household coverage.  They are used to help restrict some searches in
		// mod_partialmatch which might otherwise return too many (dupe) records.
		export TOP_VENDORS := mdr.sourceTools.set_Util_noWorkPH +  // utilities + utilities type Z
													[ 'EQ',    // Equifax header
														'EN',    // Experian header
														'FP' ];  // FARES - Deeds	
		
		//not really a constant, but close enough.  this is just insurance in case we want to use the package file to turn off Second Search
		envVarDefault := 'ON';
		envVarName := 'RightAddressSecondSearch';
		export DO_SECOND_SEARCH := thorlib.getenv(envVarName,envVarDefault) <> 'OFF';//DO_SECOND_SEARCH will be TRUE unless this env Var is set to 'OFF'												
END;