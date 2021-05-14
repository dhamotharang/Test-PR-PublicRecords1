import tools;
export _Flags :=
module(
tools.Flags(
	 pExistCurrentSprayed			:= 			Exists(nothor(fileservices.superfilecontents(filenames().input.bugatti_hdr.using		)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.bugatti_stats.using	)))
	
	,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.header.qa				)))
	,pIsUpdateFullFile				:= true
	,pShouldFilter						:= true
	,pUseStandardizePersists 	:= not _Constants().IsTesting
))
	
	export KeepHistory := true;

end;
