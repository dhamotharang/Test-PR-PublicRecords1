import STD;

punctAtEnd := '[ .,+;?_*:#%"/\\x00-]$';		// random punctuation at end

string TrimRightPunct(string s) := REGEXREPLACE('(.+)([ ."\\x00]+)$',s,'$1');
string TrimLeftPunct(string s) := REGEXREPLACE('^([ "-]+)',s,'');
string TrimPunctBoth(string s) := TrimLeftPunct(TrimRightPunct(Trim(s)));


rgxGong := '\\b(\\(?(NON PUB|NONPUB|NON-PUB|UNPUB|NPN|PRVT|PRV|PRIV|PUB|SPVT|FAX LINE|DATA LINE|TEEN LINE|TEEN LIN,COMPUTER)\\)?)\\b';	// special processing for gong
string ReconstructLName(string name) := MAP(
		length(name) <= 1 => name,
		REGEXFIND('^[A-Z]{2,}/(JR|SR)$',name) => REGEXREPLACE('^([A-Z]{2,})/(JR|SR)$',name, '$1'),
		REGEXFIND('^[A-Z]{2,}/[A-Z ]{2,}$',name) => Std.Str.FindReplace(name, '/', '-'),
		REGEXFIND('^[A-Z]{2,}-[A-Z]{2,}/[A-Z]$',name) => Std.Str.FindReplace(name, '/', ' '),
		REGEXFIND('^[A-Z]/[A-Z]+$',name) => REGEXREPLACE('^[A-Z]/([A-Z]+)$',name, '$1'),
		REGEXFIND('^[A-Z]+/[A-Z]$',name) => REGEXREPLACE('^([A-Z]+)/[A-Z]$',name, '$1'),
		REGEXFIND('^([A-Z]+-)([A-Z]+)/\\2$',name) => REGEXREPLACE('^([A-Z]+-)([A-Z]+)/\\2$',name, '$1$2'),
		REGEXFIND('^([A-Z]+) +-([A-Z]+)$',name) => REGEXREPLACE('^([A-Z]+) +-([A-Z]+)$',name, '$1-$2'),
		REGEXFIND('^([A-Z]+)- +([A-Z]+)$',name) => REGEXREPLACE('^([A-Z]+)- +([A-Z]+)$',name, '$1-$2'),
		REGEXFIND(punctAtEnd, name) => REGEXREPLACE('[ .,+;?_*:#%"/\\x00-]+$',name,''),
		name[1..3] = 'MC ' => 'MC' + name[4..],
		REGEXFIND(rgxGong, name) => REGEXREPLACE('([() ]+)$',TRIM(REGEXREPLACE(rgxGong, name, '')),''),
		TRIM(name) in ['FF','NONE'] => '',
		name[1] = '-' => REGEXREPLACE('^([ -]+)', name, ''),
		name
	);
	
string ReconstructFName(string name) := MAP(
		name = '(' => '',
		TRIM(name) in ['NONE','UNKNOWN','NFN','NO FIRST NAME'] => '',
		REGEXFIND(rgxGong, name) => REGEXREPLACE(rgxGong, name, ''),
		name
	);

string ReconstructMName(string name) := MAP(
					name = '(' => '',
					name = '\'' => '',
					name = '0' => 'O',
					TRIM(name) in ['NMN','NMI', 'TR', 'RD'] => '',
					Std.Str.FindCount(name, '/') > 0 =>
						Std.Str.FindReplace(name, '/', ' '),
					name
	);

export string ReconstructName(string fname, string mname, string lname, string suffix = '') := FUNCTION
		//fnam := TrimPunctBoth(IF(TRIM(Std.Str.ToUpperCase(fname)) in ['NONE','UNKNOWN','NFN'],'',fname));
		fnam := ReconstructFName(Std.Str.ToUpperCase(TrimPunctBoth(fname)));
		lnam := TrimPunctBoth(ReconstructLName(Std.Str.ToUpperCase(TrimPunctBoth(lname))));
		mnam := ReconstructMName(Std.Str.ToUpperCase(TrimPunctBoth(mname)));
		sfx := Std.Str.FilterOut(Std.Str.ToUpperCase(TrimPunctBoth(suffix)),'.,()"');
		gen := CASE(sfx,
			//'1' => 'SR',
			//'2' => 'JR',
			//'3' => 'III',
			//'4' => 'IV',
			//'5' => 'V',
			//'6' => '',
			//'7' => '',
			//'8' => '',
			//'9' => '',
			'JR' => suffix,
			'JR JR' => 'JR',
			'JR II' => 'JR',
			'JR,' => suffix[1..2],
			'JNR' => 'JR',
			'SR' => suffix,
			'SR SR' => 'SR',
			'I' => 'I',
			'II' => 'II',
			'II,' => 'II',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			'1ST' => 'I',
			'2N' => 'II',
			'2ND' => 'II',
			'ND' => 'II',
			'3D' => 'III',
			'3RD' => 'III',
			'RD' => 'III',
			'3 D' => 'III',
			'3 I' => '',
			'4TH' => 'IV',
			'000' => '',
			'03' => '',
			'MD' => '',
			'DDS' => '',
			'PH D' => '',
			'PHD' => '',
			'DMD' => '',
			'D M D' => '',
			'DR' => '',
			sfx);
			
			return Std.Str.ToUpperCase(Std.Str.CleanSpaces(fnam + ' ' + mnam + ' ' + lnam + ' ' + gen));
END;
