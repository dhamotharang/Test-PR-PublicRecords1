import tools;
export _Flags :=
module(
tools.Flags(
	 pExistCurrentSprayed			:= 			Exists(nothor(fileservices.superfilecontents(filenames().input.int.using		)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.prv.using		)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.pub.using		)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.privco.using	)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.affpeople.using	)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.affboards.using	)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.affPositions.using	)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.killReport.using	)))
																and Exists(nothor(fileservices.superfilecontents(filenames().input.MergerAcquis.using	)))
	,pExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.companies.qa				)))
	,pIsUpdateFullFile				:= true
	,pShouldFilter						:= true
	,pUseStandardizePersists 	:= not _Constants().IsTesting
))
	
	export KeepHistory := true;

end;
