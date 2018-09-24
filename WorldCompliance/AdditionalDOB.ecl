import ut, std;
aDOB := RECORD
	unsigned8		Ent_id;
	string			dob;
	string			parsed;
	string			asof;
	integer			age;
END;


//integer daynum(string dt) := ut.DayOfYear((integer4)dt[1..4],(integer1)dt[5..6],(integer1)dt[7..8]);
integer daynum(string dt) := 100*(integer1)dt[5..6]+(integer1)dt[7..8];

		
integer AgeAsOf(string birthday, string asof) := FUNCTION
	dob := Std.Str.FilterOut(birthday,'/');	// yyyymmddd
//	rightnow := Ut.GetDate;
	yrs := (integer4)(asof[1..4]) - (integer4)(dob[1..4]);
	daysapart := IF(daynum(asof) >= daynum(dob),1,-1);
	return MAP(
		dob = '' => 0,
		daysapart < 0 => yrs - 1,
		yrs
	);
END;

aDOB xFormAdd(Layouts.rSanctionsDOB infile) := TRANSFORM
	self.Ent_id := infile.Ent_ID;
	self.dob := infile.dob;
	self.parsed := MAP(
				REGEXFIND('^[0-9]{4}$',infile.DOB) => infile.DOB+'/00/00',				// year
				std.date.ConvertDateFormat(infile.DOB,'%B %d, %Y') <> '' => ut.ConvertDate(infile.DOB,'%B %d, %Y',	'%Y/%m/%d'),	// MON dd, yyyy
				std.date.ConvertDateFormat(infile.DOB,'%B %Y') <> '' => ut.ConvertDate(infile.DOB,'%B %Y',	'%Y/%m/00'),	// MON yyyy
				std.date.ConvertDateFormat(infile.DOB,'%B, %Y') <> '' => ut.ConvertDate(infile.DOB,'%B, %Y',	'%Y/%m/00'),	// MON yyyy
				std.date.ConvertDateFormat(infile.DOB,'%d %B %Y') <> '' => ut.ConvertDate(infile.DOB,'%d %B %Y',	'%Y/%m/%d'),	// dd MON yyyy
				std.date.ConvertDateFormat(infile.DOB,'%d %B, %Y') <> '' => ut.ConvertDate(infile.DOB,'%d %B, %Y',	'%Y/%m/%d'),	// dd MON yyyy
				std.date.ConvertDateFormat(infile.DOB,'%Y.%m.%d') <> '' => ut.ConvertDate(infile.DOB,'%Y.%m.%d',	'%Y/%m/%d'),	// yyyy.mm.dd
				std.date.ConvertDateFormat(infile.DOB,'%m-%d-%Y') <> '' => ut.ConvertDate(infile.DOB,'%m-%d-%Y',	'%Y/%m/%d'),	// m-d-yyyy
				'');,
				self := [];

END;

EXPORT additionalDOB(dataset(Layouts.rSanctionsDOB) infile) := FUNCTION

	d1 := DISTRIBUTE(Project(infile, xFormAdd(LEFT)), ent_id);

	g := DISTRIBUTE(WorldCompliance.Files.dsEntities, ent_id);

	j := JOIN(d1, g, left.ent_id=right.ent_id, TRANSFORM(aDOB,
					self.ent_id := right.MasterId;
					self := left;), INNER, LOCAL);

	j2 := DEDUP(j, RECORD, all);

	return j2;
END;