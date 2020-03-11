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
		
		export DerivedName   	:= 0100000000000000b;		// Individual name Derived from dual name
		export DerivedName2  	:= 1000000000000000b;		// second Individual name Derived from dual name
		export MaleName  	 		:= 0000000001000000b;		// Likely Male Name
		export FemaleName 	 	:= 0000000010000000b;		// Likely Female Name
		export ParsedName 	 	:= 0000000100000000b;		// Originally Parsed Name

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
			
		export unsigned2 fn_setNameIndicator(string1 nametype, unsigned1 derivation, string1 gender='U', boolean IsParsedName = false) :=
			fn_nameTypeToIndicator(nametype) |
				IF(gender in ['M','N'],MaleName,0) |
				IF(gender in ['F','N'],FemaleName,0) |
				IF(IsParsedName,ParsedName,0) |
				case(derivation,
					1 => DerivedName,
					2 => DerivedName2,
					0);

		export unsigned2 fn_setNameIndicators(integer2 nametype, unsigned2 quality, string1 gender='U', unsigned1 derivation=0, boolean IsParsedName = false) :=
			nametype | (quality<<3) |
				IF(gender in ['M','N'],MaleName,0) |
				IF(gender in ['F','N'],FemaleName,0) |
				IF(IsParsedName,ParsedName,0) |
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
				'');			
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
			
		export fn_getFields(unsigned2	indicators) := FUNCTION

			return MODULE
				export unsigned2	nameind := indicators;
				export string3		nameType := GetTypeFromInd(indicators);
				export string3		quality := GetQualityFromInd(indicators);
				export string3		gender := fn_getGender(indicators);;
				export boolean		parsed := indicators & ParsedName;
				export unsigned2	derivation := MAP(
														(indicators & DerivedName) <> 0 => 1,
														(indicators & DerivedName2) <> 0 => 2,
														0);
			END;
		END;
		
	end;