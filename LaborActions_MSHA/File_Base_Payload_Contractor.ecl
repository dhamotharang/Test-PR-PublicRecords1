BaseTempLayout_Contractor := RECORD
		Layouts_Base_Contractor.Base;
		UNSIGNED6 DID;
		UNSIGNED6 BDID;
		UNSIGNED6 ZERO;
end;
	
BaseTempLayout_Contractor trfReformat_Contractor(Layouts_Base_Contractor.Base L) := TRANSFORM
		SELF.DID  := 0;
		SELF.BDID := 0;
		SELF.ZERO := 0;
		SELF      := L;
end;

export File_Base_Payload_Contractor := PROJECT(Files().Base_Contractor_Base.qa,trfReformat_Contractor(LEFT));