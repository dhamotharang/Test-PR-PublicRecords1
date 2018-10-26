import Std;

//	tiebreaker := '::' + (string)COUNT(NOTHOR(Std.System.Workunit.WorkunitFilesWritten(workunit))(Std.Str.FindCount(name,'::base::nid') > 0));

EXPORT CreateRepositoryFilename(string uniqueid) := common.filename_NameRepository_Add + '::' + uniqueid + '::' + workunit;
