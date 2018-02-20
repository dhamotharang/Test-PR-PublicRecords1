IMPORT Anchor, PRTE2, ut, STD;
	
	Anchor.Layouts.Raw CleanFields(Anchor.Layouts.Raw pInput) := TRANSFORM
		// self.FirstName			:= Anchor.fCleanAscii(pInput.FirstName);
		// self.LastName				:= Anchor.fCleanAscii(pInput.LastName);
		self.Address_1			:= STD.Str.CleanSpaces(MAP(STD.Str.Find(pInput.Address_1,'&APOS;',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'&APOS;','\''),
																																														STD.Str.Find(pInput.Address_1,':',1) > 0 => STD.Str.FindReplace(pInput.Address_1,':',' '),
																																														STD.Str.Find(pInput.Address_1,';',1) > 0 => STD.Str.FindReplace(pInput.Address_1,';',' '),
																																														STD.Str.Find(pInput.Address_1,'!',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'!',' '),
																																														STD.Str.Find(pInput.Address_1,'`',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'`',''),
																																														STD.Str.Find(pInput.Address_1,'^',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'^',''),
																																														STD.Str.Find(pInput.Address_1,'|',1) > 0 => STD.Str.FindReplace(pInput.Address_1,'|',','),
																																														REGEXFIND('\\++',pInput.Address_1) => REGEXREPLACE('\\++',pInput.Address_1,' '),
																																														pInput.Address_1));
		self		:= pInput;
	END;

EXPORT In_Anchor := PROJECT(Anchor.Files.Raw_out, CleanFields(LEFT));