import $, tools;
export _Flags :=
module(
tools.Flags(
	 pExistCurrentSprayed			:= 			Exists(nothor(fileservices.superfilecontents($.Filenames().input.Adds.using		)))
																and Exists(nothor(fileservices.superfilecontents($.Filenames().input.Dels.using		)))
	
	,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents($.Filenames().base.Tradeline.qa				)))
	,pIsUpdateFullFile				:= true
	,pShouldFilter						:= true
	,pUseStandardizePersists 	:= not _Constants().IsTesting
))
	
	export KeepHistory := true;
	
	//	Build Types
	export BuildType := enum(unsigned1,
													 DeltaBuild,  // Delta build only processes the incremental updates.
													 FullBuild);	// FULLBUILD processes all(old and new) records.

end;
