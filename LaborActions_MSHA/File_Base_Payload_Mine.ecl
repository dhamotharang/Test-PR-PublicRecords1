BaseTempLayout_Mine := RECORD
		Layouts_Base_Mine.Base;
		UNSIGNED6 DID;
		UNSIGNED6 BDID;
		UNSIGNED6 ZERO;
end;	
	
BaseTempLayout_Mine trfReformat_Mine (Layouts_Base_Mine .Base L) := TRANSFORM
		SELF.DID  := 0;
		SELF.BDID := 0;
		SELF.ZERO := 0;
		SELF      := L;
end;

export File_Base_Payload_Mine 	:= PROJECT(Files().Base_Mine_Base.qa,trfReformat_Mine(LEFT));