IMPORT CMS_AddOn, STD;
// This utility is mainly brought to you by Danny Bello.  I renamed fields, did some cleanup,
//   but did have to redesign the last transform to take care of leading zero ranges, leading
//   character ranges, and trailing character ranges.
// This takes on how the customer sends the primary codes.  The function will not allow any header
//   lines or lines without any codes in them.  The primary code line can have any combination of
//   comma-delimited codes, ranges of codes, and unwanted text.  This function will pull the codes so
//   that each primary code found is a record matched with the add-on code, effective date, and
//   deletion/termination date.
EXPORT Get_Primary_Codes(DATASET(CMS_AddOn.Layouts.Input_Plus) inFile) := FUNCTION

	CMS_AddOn.Layouts.Input_Plus xform_seperator(CMS_AddOn.Layouts.Input_Plus L) := TRANSFORM
		SELF.AddOnCode   := StringLib.StringCleanSpaces(REGEXREPLACE(',|\n', L.AddOnCode, ' '));
		SELF.PrimaryCode := StringLib.StringCleanSpaces(REGEXREPLACE(',|\n', L.PrimaryCode, ' '));

		SELF := L;
	END;

	// Make a single space a separator within a field.
	dsSpaceDelimited := PROJECT(inFile, xform_seperator(LEFT)); 

	CharDigits       := '[A-Z]{1}[0-9]{3,}'; // Single cap char followed by at least three Digits
	Digits           := '[0-9]{3,}'; // At least three Digits
	DigitsChar       := '[0-9]{3,}[A-Z]{1}'; // At least three digit followed by single cap char
	ValidAddOnCode   := '(.*)(^' + CharDigits + '.|^' + Digits + '.|^' + DigitsChar + '.)(.*)';
	ValidPrimaryCode := '('
											+ '^' + CharDigits + '$'
											+ '|^' + CharDigits + '-' + CharDigits + '$'
											+ '|^' + Digits + '$'
											+ '|^' + Digits + '-' + Digits + '$'
											+ '|^' + DigitsChar + '$'
											+ '|^' + DigitsChar + '-' + DigitsChar + '$'
											+ ')';

	CMS_AddOn.Layouts.Input_Plus getPrimaryCodeParts(CMS_AddOn.Layouts.Input_Plus L, INTEGER c) := TRANSFORM
		SELF.AddOnCode   := REGEXREPLACE(ValidAddOnCode, L.AddOnCode, '$2'); // Keep only the first code and discard the rest - text
		idx              := StringLib.StringFind(L.PrimaryCode, ' ', c);
		start_           := StringLib.StringFind(L.PrimaryCode, ' ', c - 1);
		end_             := IF(idx = 0, LENGTH(TRIM(L.PrimaryCode)) + 1, idx);
		offset           := end_ - start_;
		poValidCodes     := end_ - offset;
		pos2             := end_;
		x1               := L.PrimaryCode[poValidCodes..pos2];
		x2               := TRIM(x1, LEFT, RIGHT);
		SELF.PrimaryCode := x2;

		SELF := L;
	END;

	// Place each code or word in a single row.
	dsRawPrimaryCode := NORMALIZE(dsSpaceDelimited,
																STD.Str.FindCount(LEFT.PrimaryCode, ' ') + 1,
																getPrimaryCodeParts(LEFT, COUNTER));

	InputPlusCounter := RECORD
		CMS_AddOn.Layouts.Input_Plus;
		INTEGER c;
	END;

	// AddOnCode and PrimaryCode must contain at least a single code
	InputPlusCounter DetermineCodeCount(CMS_AddOn.Layouts.Input_Plus L) := TRANSFORM,
		 SKIP(~REGEXFIND(ValidAddOnCode, L.AddOnCode) OR ~REGEXFIND(ValidPrimaryCode, L.PrimaryCode))
		idx    := StringLib.StringFind(L.PrimaryCode, '-', 1);
		hasStartChar := REGEXFIND('^[A-Z]{1}[0-9]{3,}$', L.PrimaryCode[1..idx - 1]);
		s1     := IF(hasStartChar,
								 (INTEGER)L.PrimaryCode[2..idx - 1],
								 (INTEGER)L.PrimaryCode[1..idx - 1]);
		s2     := IF(hasStartChar,
								 (INTEGER)REGEXFIND('[0-9]{3,}', L.PrimaryCode[idx + 1..], 0),
								 (INTEGER)L.PrimaryCode[idx + 1..]);
		SELF.c := IF(REGEXFIND('-', L.PrimaryCode), (s2 - s1) + 1, 1);

		SELF := L;
	END;

	// Determine how many codes to create.
	dsPrimaryWithCount := PROJECT(dsRawPrimaryCode, DetermineCodeCount(LEFT));

	CMS_AddOn.Layouts.Input_Plus getCode(InputPlusCounter L, INTEGER c) := TRANSFORM
		idx          := StringLib.StringFind(L.PrimaryCode, '-', 1);
		hasStartChar := REGEXFIND('^[A-Z]{1}[0-9]{3,}$', L.PrimaryCode[1..idx - 1]);
		hasEndChar   := REGEXFIND('^[0-9]{3,}[A-Z]$', L.PrimaryCode[1..idx - 1]);
		hasChar      := hasStartChar OR hasEndChar;
		StartChar    := IF(hasStartChar, L.PrimaryCode[1], '');
		EndChar      := IF(hasEndChar, L.PrimaryCode[idx - 1], '');
		s1           := IF(StartChar != '',
											 (INTEGER)L.PrimaryCode[2..idx - 1],
											 (INTEGER)L.PrimaryCode[1..idx - 1]);

		// The final code will be 5 chars long, always.
		PrimaryCodeNumber := INTFORMAT(s1 + (c - 1),
																	 IF(hasChar, 4, 5),
																	 1);
		SELF.PrimaryCode  := IF(idx > 0,
														IF(hasChar,
															 IF(StartChar != '',
																	StartChar + PrimaryCodeNumber,
																	PrimaryCodeNumber + EndChar),
															 PrimaryCodeNumber),
														L.PrimaryCode);

		SELF := L;
	END;

	// Create the new codes.
	dsPrimaryNorm := NORMALIZE(dsPrimaryWithCount, LEFT.c, getCode(LEFT, COUNTER));

	RETURN SORT(dsPrimaryNorm, AddOnCode, PrimaryCode, RECORD);

END;