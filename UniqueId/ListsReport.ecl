IMPORT Std, ut;
alldata := UniqueId.Files.processed;
//OUTPUT(alldata);

//t := TABLE(alldata, {alldata.WatchListName, nrecs := COUNT(GROUP)}, WatchListName, few);
new := UniqueId.Files.new;
cnt := UniqueId.Files.country;
//OUTPUT(new);
//OUTPUT(cnt);
u := TABLE(new, {new.WatchListName, nrecs := COUNT(GROUP)}, WatchListName, few);

v := TABLE(cnt, {cnt.WatchListName, nrecs := COUNT(GROUP)}, WatchListName, few);


t := u + v;

//OUTPUT(t);
modified := dataset('~thor::uniqueid::likelymatches.csv', uniqueId.rReport, csv(HEADING(SINGLE)));
added := dataset('~thor::uniqueid::newrecords.csv', uniqueId.rReport, csv(HEADING(SINGLE)));
removed := dataset('~thor::uniqueid::deletedrecords.csv', uniqueId.rReport, csv(HEADING(SINGLE)));
tmodified := TABLE(modified, {modified.WatchListName, nrecs := COUNT(GROUP)}, WatchListName, few);
tadded := TABLE(added, {added.WatchListName, nrecs := COUNT(GROUP)}, WatchListName, few);
tremoved := TABLE(removed, {removed.WatchListName, nrecs := COUNT(GROUP)}, WatchListName, few);

fmtDate(unsigned4 dt) := Std.Date.ConvertDateFormat((string8)dt, '%Y%m%d', '%m/%d/%Y');

ListCreatedDates := DATASET('~thor::uniqueid::ListCreatedDates.csv', {string WatchListName, string dt}, csv(heading(1)));

rListsReport := record
	string 			WatchListName;
	unsigned		nrecs;
	string			creationDate := (string)Std.Date.Today();
	string			updateDate := (string)Std.Date.Today();
	string			processedDate := (string)Std.Date.Today();
	unsigned		nUpdated := 0;
	unsigned		nAdditional := 0;
	unsigned		nRemoved := 0;
END;

j0 := PROJECT(t, TRANSFORM(rListsReport,
						self.creationDate := fmtDate(Std.Date.Today());
						self.processedDate := fmtDate(Std.Date.Today());
						dt := $.GetPublicationDate(left.WatchListName)[1..10];
						self.updateDate := Std.Date.ConvertDateFormat(dt, '%Y-%m-%d', '%m/%d/%Y');
						self := left;));

j1 := JOIN(j0, ListCreatedDates, left.WatchListName=right.WatchListName, TRANSFORM(rListsReport,
					self.creationDate := Std.Date.ConvertDateFormat(Std.Str.SplitWords(right.dt,' ')[1],
														'%m/%d/%Y', '%m/%d/%Y');
					self := left;
					));

j2 := JOIN(j1, tmodified, left.WatchListName=right.WatchListName, TRANSFORM(rListsReport,
								self.nUpdated := right.nrecs;
								self := left;), LEFT OUTER);

j3 := JOIN(j2, tadded, left.WatchListName=right.WatchListName, TRANSFORM(rListsReport,
								self.nAdditional := right.nrecs;
								self := left;), LEFT OUTER);
								
j4 := JOIN(j3, tremoved, left.WatchListName=right.WatchListName, TRANSFORM(rListsReport,
								self.nRemoved := right.nrecs;
								self := left;), LEFT OUTER);
hdrtext := 'List Name,Number of Records,Bridger Creation Date,Last Updated Date,Processed Date,Number of updated Records from Prior Day,'+
												'Number of Additional Records from Prior Day,Number of Removed Records from Prior Day';

EXPORT ListsReport := 
								OUTPUT(SORT(j4,WatchListname),,'~thor::uniqueid::listsreport.csv', CSV(HEADING(hdrtext,SINGLE),
															QUOTE('"'),TERMINATOR('\r\n'),SEPARATOR(',')),OVERWRITE);
