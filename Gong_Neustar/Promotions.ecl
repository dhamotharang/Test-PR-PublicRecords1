import	STD;
EXPORT Promotions := MODULE

	set of string	GetSFList(string sfBase) := [
							sfBase,
							sfBase+'::father',
							sfBase+'::grandfather',
							sfBase+'::greatgrandfather',
							sfBase+'::delete'];
	
	shared PromoteFiles(string sfBase, string lfn) := NOTHOR(Std.File.PromoteSuperFileList(GetSFList(sfBase), lfn, true));

	export Master(string lfn) := PromoteFiles(Constants.sfMaster, lfn);
	export History(string lfn) := PromoteFiles(Constants.sfHistory, lfn);
	export Base(string lfn) := PromoteFiles(Constants.sfBase, lfn);

	set of string	DemotionList(string sfBase) := [
							sfBase+'::delete',
							sfBase+'::greatgrandfather',
							sfBase+'::grandfather',
							sfBase+'::father',
							sfBase
							];

	shared DemoteFiles(string sfBase) := NOTHOR(Std.File.PromoteSuperFileList(DemotionList(sfBase), deltail := true));

	export DemoteMaster := DemoteFiles(Constants.sfMaster);
	export DemoteHistory := DemoteFiles(Constants.sfHistory);
	export DemoteBase := DemoteFiles(Constants.sfBase);

END;