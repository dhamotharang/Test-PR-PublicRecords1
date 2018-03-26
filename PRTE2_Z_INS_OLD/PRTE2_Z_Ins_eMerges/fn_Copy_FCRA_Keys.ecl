// 12/11 - checking the Boca PRTE FCRA DOPS page, FCRA_Emerges_Keys has only 3 keys related to CCW
// ~thor_data400::key::ccw_doxie_did_fcra_qa     		~prte::key::emerges::20121112c::ccw_doxie_did_fcra
// ~thor_data400::key::ccw::fcra::qa::did   ~prte::key::ccw::fcra::20121112c::did
// ~thor_data400::key::ccw::fcra::qa::rid   ~prte::key::ccw::fcra::20121112c::rid 


import RoxieKeybuild, eMerges, PRTE_CSV, PRTE2_Common;
export fn_Copy_FCRA_Keys(string pIndexVersion, DATASET(eMerges.layout_ccw_out) inFile ) := FUNCTION

	// Copy the keys that can be copied -----------------------------------------------------------------------------
	PRTEPrefix := '~prte';
	KeyPrefix := PRTEPrefix+'::key::ccw::'; //ccw
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
	
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::ccw','did');
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::ccw','rid');
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::ccw::fcra','did');
	PRTE2_Common.SuperFiles.create(PRTEPrefix+'::key::ccw::fcra','rid');
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(nfDidV,nfDid,mv8,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(nfRidV,nfRid,mv9,2);
	SK1Steps	:= PARALLEL( mv8,mv9 );

	RoxieKeyBuild.Mac_SK_Move_V2(nfDidV,'Q',toq8,3);
	RoxieKeyBuild.Mac_SK_Move_V2(nfRidV,'Q',toq9,3);
	SK2Steps	:= PARALLEL( toq8,toq9 );
	
	// Build the one key that can not be copied ---------------------------------------------------------------------
  EmergesKeyPrefix := PRTEPrefix+'::key::Emerges';	
	EmergesPrefix := EmergesKeyPrefix+'::ccw_doxie_did';
	EmergesPrefixF := EmergesKeyPrefix+'::ccw_doxie_did_fcra';
	EmergesKeyVersion  := EmergesKeyPrefix+'::'+pIndexVersion+'::ccw_doxie_did';
	EmergesKeyVersionF  := EmergesKeyPrefix+'::'+pIndexVersion+'::ccw_doxie_did_fcra';
	EmergesAbsKeyName := EmergesKeyPrefix+'::@version@::ccw_doxie_did';
	EmergesAbsKeyNameF := EmergesKeyPrefix+'::@version@::ccw_doxie_did_fcra';
	
	rKeyEmerges__ccw_doxie_did		:= PRTE_CSV.Emerges.rthor_data400__key__emerges__ccw_doxie_did;
	rKeyEmerges__ccw_doxie_did xFORM( inFile L ) := TRANSFORM
			SELF.DID := (unsigned8)L.did_out;
			SELF := L;
			SELF := [];
	END;
	
	PRTE2_Common.SuperFiles.create(EmergesKeyPrefix,'ccw_doxie_did');
	PRTE2_Common.SuperFiles.create(EmergesKeyPrefix,'ccw_doxie_did_fcra');
	
	dKeyEmerges__ccw_doxie_did		:=	project(inFile, xFORM(LEFT) );
	kKeyEmerges__ccw_doxie_did		:=	index(dKeyEmerges__ccw_doxie_did, {did}, {dKeyEmerges__ccw_doxie_did}, EmergesPrefix);
	kKeyEmerges__ccw_doxie_did_fcra		:=	index(dKeyEmerges__ccw_doxie_did, {did}, {dKeyEmerges__ccw_doxie_did}, EmergesPrefixF);
	DoxieKeySteps1 := PRTE2_Common.IndexBuildTriplet(kKeyEmerges__ccw_doxie_did, EmergesPrefix, EmergesKeyVersion, EmergesAbsKeyName);
	DoxieKeySteps2 := PRTE2_Common.IndexBuildTriplet(kKeyEmerges__ccw_doxie_did_fcra, EmergesPrefixF, EmergesKeyVersionF, EmergesAbsKeyNameF );
	DoxieKeySteps := PARALLEL( DoxieKeySteps1, DoxieKeySteps2 );
	
	// --------------------------------------------------------------------------------------------------------------
	AllSteps := SEQUENTIAL( copySteps, SK1Steps, SK2Steps, DoxieKeySteps );
	RETURN AllSteps;
	// --------------------------------------------------------------------------------------------------------------
		
END;
