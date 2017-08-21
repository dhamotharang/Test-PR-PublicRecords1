BaseTempLayout := RECORD
		Layouts.Base;
		UNSIGNED6 DID;
		UNSIGNED6 BDID;
		UNSIGNED6 ZERO;
END;
	
BaseTempLayout trfReformat(Layouts.Base L) := TRANSFORM
		SELF.DID  := 0;
		SELF.BDID := 0;
		SELF.ZERO := 0;
		SELF      := L;
END;	

export File_Base_Payload := PROJECT(Files().Base.qa,trfReformat(LEFT));