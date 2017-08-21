import ut, std;
rDOB := RECORD
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

rDob xForm(Layouts.rEntity infile, integer n) := TRANSFORM,
										SKIP((n=1 AND infile.dob='') OR (n=2 AND infile.dob2=''))
	bday := CHOOSE(n, infile.dob, infile.dob2, SKIP);
	self.Ent_id := infile.Ent_id;
	self.dob := bday;
	self.parsed := MAP(
				REGEXFIND('^[0-9]{4}$',bday) => bday+'/00/00',				// year
				ut.ConvertDate(bday,'%B %d, %Y') <> '' => ut.ConvertDate(bday,'%B %d, %Y',	'%Y/%m/%d'),	// MON dd, yyyy
				ut.ConvertDate(bday,'%B %Y') <> '' => ut.ConvertDate(bday,'%B %Y',	'%Y/%m/00'),	// MON yyyy
				ut.ConvertDate(bday,'%B, %Y') <> '' => ut.ConvertDate(bday,'%B, %Y',	'%Y/%m/00'),	// MON yyyy
				ut.ConvertDate(bday,'%d %B %Y') <> '' => ut.ConvertDate(bday,'%d %B %Y',	'%Y/%m/%d'),	// dd MON yyyy
				ut.ConvertDate(bday,'%d %B, %Y') <> '' => ut.ConvertDate(bday,'%d %B, %Y',	'%Y/%m/%d'),	// dd MON yyyy
				ut.ConvertDate(bday,'%Y.%m.%d') <> '' => ut.ConvertDate(bday,'%Y.%m.%d',	'%Y/%m/%d'),	// yyyy.mm.dd
				ut.ConvertDate(bday,'%m-%d-%Y') <> '' => ut.ConvertDate(bday,'%m-%d-%Y',	'%Y/%m/%d'),	// m-d-yyyy
				'');,
	self.Age := AgeAsOf(self.parsed, ut.ConvertDate(infile.touchdate,'%Y-%m-%d', '%Y%m%d'));
	self.asof := ut.ConvertDate(infile.touchdate,'%Y-%m-%d', '%Y/%m/%d');
	self := [];

END;

EXPORT GetDobs(dataset(Layouts.rEntity) infile) := FUNCTION

	return normalize(infile, 2, xForm(LEFT, COUNTER));

END;