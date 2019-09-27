export NameIndicators := module

export NameQuality := enum(UNSIGNED2, NotAName = 0, InvalidNameFormat = 1,
				StandaloneName = 2, 
				ProbableName = 3, PossibleName = 4, ImprobableName = 5,
				PossibleDualName = 6);
				
export NameTypes := enum(UNSIGNED2,
					Unknown = 0,		// not cleaned
					PersonType = 1,
					Dual = 2,
					Business = 3,
					Trust = 4,
					Invalid = 5,
					Blank = 6);
// name quality
		
		export DerivedName   := 000000001000b;		// Individual name Derived from dual name
		export DerivedName2  := 000000010000b;		// second Individual name Derived from dual name
		export MaleName  	 := 000000100000b;		// Male Name
		export FemaleName 	 := 000001000000b;		// Female Name

		shared NameTypeBits := 111b;		// nametype bit map
		shared NameQualityBits := 111000b;		// nametype bit map
		
		export unsigned2 fn_nameTypeToIndicator(string1 nametype) := CASE(nametype,
			'' => NameTypes.Blank,
			'P' => NameTypes.PersonType,
			'D' => NameTypes.Dual,
			'B' => NameTypes.Business,
			'I' => NameTypes.Invalid,
			'T' => NameTypes.Trust,
			'U' => NameTypes.Trust,
			'?' => NameTypes.Unknown,
			NameTypes.Unknown);
			
		export unsigned2 fn_setNameIndicator(string1 nametype, unsigned1 derivation, string1 gender='U', boolean FInitial = false) :=
			fn_nameTypeToIndicator(nametype) |
				IF(gender in ['M','N'],MaleName,0) |
				IF(gender in ['F','N'],FemaleName,0) |
				case(derivation,
					1 => DerivedName,
					2 => DerivedName2,
					0);

		export fn_getNameType(unsigned2 name_ind) := name_ind & NameTypeBits;
		
		export string1 GetTypeFromInd(unsigned2 name_ind) := CASE(
			fn_getNameType(name_ind),
			NameTypes.PersonType => 'P',
			NameTypes.Business => 'B',
			NameTypes.Dual => 'D',
			NameTypes.Invalid => 'I',
			NameTypes.Trust => 'T',
			NameTypes.Blank => '',
			'U');
			
		export fn_getNameQuality(unsigned2 name_ind) := (name_ind & NameQualityBits) >> 3;
		export string3 GetQualityFromInd(unsigned2 name_ind) := CASE(
			fn_getNameQuality(name_ind),
				NameQuality.NotAName => 'NAN',
				NameQuality.InvalidNameFormat => 'INV',
				NameQuality.StandaloneName => 'STA',
				NameQuality.ProbableName => 'YES',
				NameQuality.PossibleName => 'MAY',
				NameQuality.ImprobableName => 'NO',
				NameQuality.PossibleDualName => 'DUL',
				'?');			
		shared DerivedNameFlags := DerivedName | DerivedName2;
		export boolean fn_IsDerivedName(unsigned2 name_ind) := (name_ind & DerivedNameFlags) > 0;
		export boolean fn_IsMaleName(unsigned2 name_ind) := (name_ind & MaleName) > 0;
		export boolean fn_IsFemaleName(unsigned2 name_ind) := (name_ind & FemaleName) > 0;
		export string1 fn_getGender(unsigned2 name_ind) := MAP(
			fn_IsMaleName(name_ind) AND fn_IsFemaleName(name_ind) => 'N',
			fn_IsMaleName(name_ind) => 'M',
			fn_IsFemaleName(name_ind) => 'F',
			'U');
			
		export string1 fn_getDerivation(unsigned2 name_ind) := MAP(
			(name_ind & DerivedName) > 0 => '1',
			(name_ind & DerivedName2) > 0 => '2',
			'0');
		
	end;