export NameIndicators := module

		export Unknown  := 000b;			// Not Cleaned
		export Person_  := 001b;			// Person
		export Dual     := 010b;			// Dual Name
		export Business := 011b;			// Business or Organization
		export Unclassified  := 100b;		// Unclassified (trustees, estates, ie, neither person nor business)
		export Invalid  := 101b;			// Invalid Name (scatological, nonsense, etc)
		export Blank    := 110b;			// Name is blank or whitespaces
		export Unexpected  := 111b;			// unexpected cleaning error
				
		export DerivedName   := 000000001000b;		// Individual name Derived from dual name
		export DerivedName2  := 000000010000b;		// second Individual name Derived from dual name
		export MaleName  	 := 000000100000b;		// Male Name
		export FemaleName 	 := 000001000000b;		// Female Name
		export Alias 		 := 000010000000b;		// Name is an alias (AKA ...)
		export SingularName  := 000100000000b;		// Recognizable part of dual name. MR & MRS A JONES, A JONES ET UX
		export Standalone 	 := 001000000000b;		// Standalone last name (no first or middle)
		export PartialName 	 := 010000000000b;		// Partial name (no last name)
		export Trustee 		 := 100000000000b;		// Name is a trustee

		export EthinicityMask := 1110000000000000b;		// 
		export EthnicityTypes := enum(Undetermined=0,SpanishName=1,ArabicName=2,IndianName=3,
															HebrewName=4,AsianName=5);

		shared NameTypeBits := 111b;		// nametype bit map
		
		export unsigned2 fn_nameTypeToIndicator(string1 nametype) := CASE(nametype,
			'' => Blank,
			'P' => Person_,
			'D' => Dual,
			'B' => Business,
			'I' => Invalid,
			'U' => Unclassified,
			'?' => Unexpected,
			Unknown);
			
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
			Person_ => 'P',
			Business => 'B',
			Dual => 'D',
			Invalid => 'I',
			Unclassified => 'U',
			Blank => '',
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

		
	end;