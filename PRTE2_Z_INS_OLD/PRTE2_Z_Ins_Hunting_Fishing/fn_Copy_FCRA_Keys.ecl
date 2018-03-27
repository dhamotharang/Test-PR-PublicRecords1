// 12/11 - checking the Boca PRTE FCRA DOPS page, FCRA_Emerges_Keys has only 3 keys related to HuntingFishing
// ~thor_data400::key::hunters_doxie_did_fcra_qa     		~prte::key::emerges::20121112c::hunters_doxie_did_fcra
// ~thor_data400::key::hunting_fishing::fcra::qa::did   ~prte::key::hunting_fishing::fcra::20121112c::did
// ~thor_data400::key::hunting_fishing::fcra::qa::rid   ~prte::key::hunting_fishing::fcra::20121112c::rid 


import RoxieKeybuild, eMerges, PRTE_CSV, PRTE2_Common;
export fn_Copy_FCRA_Keys(string pIndexVersion, DATASET(eMerges.layout_hunters_out) inFile ) := FUNCTION

	// Copy the keys that can be copied -----------------------------------------------------------------------------
	PRTEPrefix := '~prte';
	KeyPrefix := PRTEPrefix+'::key::hunting_fishing::';
	SuperKeyName := KeyPrefix+'fcra::';
	BaseKeyName  := SuperKeyName+pIndexVersion;
	ThorName := ThorLib.Cluster();
	copyFile(STRING N1, STRING N2) := fileservices.copy(N1,ThorName,N2,,,,,true,true);
	
	ndid := KeyPrefix + pIndexVersion + '::did';
	nrid := KeyPrefix + pIndexVersion + '::rid';
		
	//fcra final key names
	nfDid := SuperKeyName + pIndexVersion + '::did';
	nfRid := SuperKeyName + pIndexVersion + '::rid';
	nfDidV := SuperKeyName+'@version@::did';
	nfRidV := SuperKeyName+'@version@::rid';
	
	cp8	:= 	copyFile(ndid,nfdid);
	cp9	:= 	copyFile(nrid,nfrid);
	copySteps	:= PARALLEL( cp8,cp9 );
	
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::hunting_fishing','did');
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::hunting_fishing','rid');
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::hunting_fishing::fcra','did');
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::hunting_fishing::fcra','rid');
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(nfDidV,nfDid,mv8,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(nfRidV,nfRid,mv9,2);
	SK1Steps	:= PARALLEL( mv8,mv9 );

	RoxieKeyBuild.Mac_SK_Move_V2(nfDidV,'Q',toq8,3);
	RoxieKeyBuild.Mac_SK_Move_V2(nfRidV,'Q',toq9,3);
	SK2Steps	:= PARALLEL( toq8,toq9 );
	
	// Build the one key that can not be copied ---------------------------------------------------------------------
	EmergesKeyPrefix := PRTEPrefix+'::key::Emerges';
	EmergesPrefix := EmergesKeyPrefix+'::hunters_doxie_did';
	EmergesPrefixF := EmergesKeyPrefix+'::hunters_doxie_did_fcra';
	EmergesKeyVersion  := EmergesKeyPrefix+'::'+pIndexVersion+'::hunters_doxie_did';
	EmergesKeyVersionF  := EmergesKeyPrefix+'::'+pIndexVersion+'::hunters_doxie_did_fcra';
	EmergesAbsKeyName := EmergesKeyPrefix+'::@version@::hunters_doxie_did';
	EmergesAbsKeyNameF := EmergesKeyPrefix+'::@version@::hunters_doxie_did_fcra';
	
	rKeyEmerges__hunters_doxie_did		:= PRTE_CSV.Emerges.rthor_data400__key__Emerges__hunters_doxie_did;
	rKeyEmerges__hunters_doxie_did xFORM( inFile L ) := TRANSFORM
			SELF.DID := (unsigned8)L.did_out;
			SELF := L;
			SELF := [];
	END;
	PRTE2_Common.SuperFiles.create(EmergesKeyPrefix,'hunters_doxie_did');
	PRTE2_Common.SuperFiles.create(EmergesKeyPrefix,'hunters_doxie_did_fcra');
	dKeyEmerges__hunters_doxie_did		:=	project(inFile, xFORM(LEFT) );
	kKeyEmerges__hunters_doxie_did		:=	index(dKeyEmerges__hunters_doxie_did, {did}, {dKeyEmerges__hunters_doxie_did}, EmergesPrefix);
	kKeyEmerges__hunters_doxie_did_fcra		:=	index(dKeyEmerges__hunters_doxie_did, {did}, {dKeyEmerges__hunters_doxie_did}, EmergesPrefixF);
	DoxieKeySteps1 := PRTE2_Common.IndexBuildTriplet(kKeyEmerges__hunters_doxie_did, EmergesPrefix, EmergesKeyVersion, EmergesAbsKeyName);
	DoxieKeySteps2 := PRTE2_Common.IndexBuildTriplet(kKeyEmerges__hunters_doxie_did_fcra, EmergesPrefixF, EmergesKeyVersionF, EmergesAbsKeyNameF );
	DoxieKeySteps := PARALLEL( DoxieKeySteps1, DoxieKeySteps2 );
	
	// --------------------------------------------------------------------------------------------------------------
	AllSteps := SEQUENTIAL( copySteps, SK1Steps, SK2Steps, DoxieKeySteps );
	RETURN AllSteps;
	// --------------------------------------------------------------------------------------------------------------
		
END;
