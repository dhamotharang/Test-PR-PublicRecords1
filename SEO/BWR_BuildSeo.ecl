#OPTION('MultiplePersistInstances', false);
version:=ut.GetDate : independent;
// Find CORE LexIds from consumers

ds := Pull(infutor.Key_Header_Infutor_Knowx)(Length(TRIM(fname))>1,Length(TRIM(lname))>1);
segs := DISTRIBUTE(watchdog.file_best(adl_ind='CORE'),did);

j := JOIN(DISTRIBUTE(ds,did),DISTRIBUTE(segs,did), left.did=right.did,
						TRANSFORM(Seo.Layout_Seo,
								self.LexId := left.did;
								self := left;), INNER, LOCAL);
d := DEDUP(SORT(DISTRIBUTE(j, LexId), LexId, fname, lname, LOCAL), LexId, fname, lname, LOCAL);

lfn := '~thor::seo::' + version;

writeit := OUTPUT(d,,lfn,COMPRESSED, CSV(
																SEPARATOR(',')
																, TERMINATOR('\r\n')
																, HEADING(1,SINGLE)
																,QUOTE('"')
																),
													OVERWRITE);
sfBase := '~thor::seo';
												
	set of string	SFList := [
							sfBase,
							sfBase+'::father',
							sfBase+'::delete'];

	PromoteFiles(string lfn) := NOTHOR(Std.File.PromoteSuperFileList(SFList, lfn, true));

SEQUENTIAL(
	writeit,
	SEO.DesprayFile(lfn, version),
	PromoteFiles(lfn)
);
