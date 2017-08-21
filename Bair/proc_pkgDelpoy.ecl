EXPORT proc_pkgDelpoy(string clustername = '', string version, boolean pUseProd = false, boolean pDelta = false) := module
	
	shared isFullreplace 	:= not pDelta;
	shared isdeltareplace	:= if(pDelta, true, false);
	
	shared KeyDSmod := bair.DeploymentKeyDS(clustername, version, isFullreplace, isdeltareplace);
	
	CommonBooleanKeys	:= KeyDSmod.BairBooleanKeys + KeyDSmod.BairPayloadCommonKeys; 
	DeltaBooleanKeys 	:= KeyDSmod.BairPayloadDeltaKeys + CommonBooleanKeys;
	FullBooleanKeys  	:= CommonBooleanKeys	+ KeyDSmod.BairPayloadFullKeys;
	
	shared SetOfBooleanKeys			:= if(pDelta, DeltaBooleanKeys, FullBooleanKeys);
	shared SetOfNonBooleanKeys 	:= KeyDSmod.BairPublicSafetyKeys
																	+ 
																if(pDelta, KeyDSmod.BairCompositeDeltaKeys, KeyDSmod.BairCompositeFullKeys);
	
	EXPORT BooleanKeys 		:= bair.Build_RoxiePkg(clustername, if(pUseProd, 'prod', 'qa'), version, if(pDelta, 'NIGHTLY','WEEKLY'), SetOfBooleanKeys).pkg_all;
	EXPORT NonBooleanKeys := bair.Build_RoxiePkg(clustername, if(pUseProd, 'prod', 'qa'), version, if(pDelta, 'NIGHTLY','WEEKLY'), SetOfNonBooleanKeys).pkg_all;
	
End;