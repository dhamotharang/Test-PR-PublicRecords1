/*2012-07-16T12:29:11Z (Charles Salvo)

*/
import STD, _Control;

superfile := NID.Common.filename_NameRepository_Cache;
addressee := 'charles.salvo@lexisnexis.com';

tiebreaker := COUNT(NOTHOR(Std.System.Workunit.WorkunitFilesWritten(workunit))(Std.Str.FindCount(name,'thor::nid::cache') > 0));

lfn1(string lfn) := lfn + '_' + (string)tiebreaker;
lfn2(string lfn) := lfn + '_' + (string)(tiebreaker-1);
 
//export AddToCache(DATASET(NID.Layout_Repository) ds, string lfn) := 
export AddToCache(DATASET(NID.Layout_Repository) ds, string lfn, boolean useV2) := FUNCTION
	return 	MAP(
		COUNT(ds)=0 => OUTPUT('Name Repository Cache not updated: ' + lfn + ' has no records'),
//							SendMail(addressee, 'Name Repository Cache not updated', lfn + ' has no records'),
		Std.File.FindSuperFileSubName(superfile, lfn1(lfn)) > 0 => OUTPUT('Name Repository Cache update failed: ' + lfn + ' already exists'),
//							SendMail(addressee, 'Name Repository Cache update failed', lfn + ' already exists'),
		ORDERED(
			OUTPUT(ds,,lfn1(lfn), COMPRESSED,OVERWRITE),
			Std.File.SetFileDescription(lfn1(lfn), IF(useV2, 'V2', 'V1')),
 			FileServices.AddSuperFile(superfile, lfn1(lfn))
		)
	);
END;