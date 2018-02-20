Import RealSource, Anchor, PRTE2, ut, STD;
	
	RealSource.Layouts.Raw CleanFields(RealSource.Layouts.Raw pInput) := TRANSFORM
		self.FirstName			:= Anchor.fCleanAscii(pInput.FirstName);
		self.LastName				:= Anchor.fCleanAscii(pInput.LastName);
		self		:= pInput;
	END;
	

EXPORT In_RealSource := PROJECT(RealSource.Files.Raw_out, CleanFields(LEFT));