import STD;

//lfn := '~thor_data400::base::nid::repository::cachet';
x := STD.File.SuperFileContents(Nid.Common.filename_NameRepository_Cache);
//OUTPUT(x);

rx := record
	string			lfn;
	unsigned4		recnt;
	unsigned2		recsz;
	string			modified;
	string			owner;
	string			version;
	string			wuid;
END;

y := PROJECT(x, TRANSFORM(rx,
	self.lfn := LEFT.name;
	self.recnt := (unsigned4)STD.File.GetLogicalFileAttribute('~'+LEFT.name,'recordCount');
	self.recsz := (unsigned2)STD.File.GetLogicalFileAttribute('~'+LEFT.name,'recordSize');
	self.modified := (string)STD.File.GetLogicalFileAttribute('~'+LEFT.name,'modified');
	self.owner := (string)STD.File.GetLogicalFileAttribute('~'+LEFT.name,'owner');
	self.version := Std.File.GetFileDescription('~'+LEFT.name);
	self.wuid := (string)STD.File.GetLogicalFileAttribute('~'+LEFT.name,'workunit');
	));

OUTPUT(SORT(y,-modified), all, named('files'));
OUTPUT(SORT(y(version='V1'),-modified), all, named('files1'));
OUTPUT(SORT(y(version='V2'),-modified), all, named('files2'));
OUTPUT(y(recnt=0), all, named('empties'));
OUTPUT(SUM(y,recnt), named('total'));
OUTPUT(SUM(y(version='V2'),recnt), named('total2'));
OUTPUT(SORT(TABLE(y, {y.version, n := COUNT(GROUP)}, version, few), version));

