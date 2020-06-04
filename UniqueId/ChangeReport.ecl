IMPORT Std;
modified := dataset('~thor::uniqueid::likelymatches.csv', uniqueId.rReport, csv(HEADING(SINGLE)));
added := dataset('~thor::uniqueid::newrecords.csv', uniqueId.rReport, csv(HEADING(SINGLE)));
removed := dataset('~thor::uniqueid::deletedrecords.csv', uniqueId.rReport, csv(HEADING(SINGLE)));


//List Name 	Name of Entity 	Individual or Business 	Updated Record 	Additional Record 	Removed Record

r1 := RECORD
  string WatchListName;
	string	processedDate := (string)Std.Date.Today();
  unicode full_name;
  string type;
	string3	updated;
	string3	added;
	string3	removed;
END;
 fmtDate(unsigned4 dt) := Std.Date.ConvertDateFormat((string8)dt, '%Y%m%d', '%m/%d/%Y');

 fmtName(unicode nm1, unicode nm2, unicode nm3, unicode sfx, unicode fname) :=
						IF(nm3='', fname,
						 Std.Uni.CleanSpaces(nm1 + ' ' + nm2 + ' '+ nm3 + ' '+ sfx));

d1 := PROJECT(modified, TRANSFORM(r1,
				self.ProcessedDate := fmtDate(Std.Date.Today());
				self.updated := 'YES';
				self.added := '';
				self.removed := '';
				self.full_name :=  if(left.type='Individual',fmtName(left.first_name, left.middle_name, left.last_name, left.generation, left.full_name), left.full_name);
				self := left;
				));
d2 := PROJECT(added, TRANSFORM(r1,
				self.ProcessedDate := fmtDate(Std.Date.Today());
				self.updated := '';
				self.added := 'YES';
				self.removed := '';
				self.full_name :=  if(left.type='Individual',fmtName(left.first_name, left.middle_name, left.last_name, left.generation, left.full_name), left.full_name);
				self := left;
				));
d3 := PROJECT(removed, TRANSFORM(r1,
				self.ProcessedDate := fmtDate(Std.Date.Today());
				self.updated := '';
				self.added := '';
				self.removed := 'YES';
				self.full_name :=  if(left.type='Individual',fmtName(left.first_name, left.middle_name, left.last_name, left.generation, left.full_name), left.full_name);
				self := left;
				));
				
d := SORT(d1+d2+d3, WatchListName, full_name);


hdrtext := 'List Name,Processed Date,Name of Entity,Individual or Business,Updated Record,Additional Record,Removed Record';
EXPORT ChangeReport := 
					OUTPUT(SORT(d,watchlistname,full_name),,'~thor::uniqueid::changes.csv', CSV(HEADING(hdrtext,SINGLE),
															QUOTE('"'),TERMINATOR('\r\n'),SEPARATOR(',')),OVERWRITE);
