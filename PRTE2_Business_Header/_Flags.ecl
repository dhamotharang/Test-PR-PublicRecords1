import tools;
export _Flags :=
module(
tools.Flags(
	 pExistCurrentSprayed			:= 			Exists(nothor(fileservices.superfilecontents(filenames().input.inBusHdr.using		)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.inBusCont.using	)))
																
	,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.search.qa		)))
	,pIsUpdateFullFile				:= true
	,pShouldFilter						:= true
	,pUseStandardizePersists 	:= not _Constants().IsTesting
))
	
	export KeepHistory := true;

end;
