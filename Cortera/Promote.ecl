import std;

EXPORT Promote := MODULE


	set of string	GetSFList(string sfBase) := [
							sfBase,
							sfBase+'::father',
							sfBase+'::grandfather',
							sfBase+'::delete'];
	
	shared PromoteFiles(string sfBase, string lfn) := NOTHOR(Std.File.PromoteSuperFileList(GetSFList(sfBase), lfn, true));

	export CorteraHeader(string lfn) := PromoteFiles(Constants.sfCorteraHdr, lfn);
	export Attributes(string lfn) := PromoteFiles(Constants.sfAttributes, lfn);
	export Executives(string lfn) := PromoteFiles(Constants.sfExecutives, lfn);
	export CorteraAsLinking(string lfn) := PromoteFiles(Constants.sfLinking, lfn);
	export Industry(string lfn) := PromoteFiles(Constants.sfIndustry, lfn);

END;
