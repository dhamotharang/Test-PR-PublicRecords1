import autokeyb2,doxie;

BaseTempLayout := RECORD
		Layouts.Base-ISMSScope;
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

fakepf := PROJECT(Files().Base.qa,trfReformat(LEFT));

ak_qa_keyname := SiteSec_ISMS.Constants().ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,ak_qa_keyname+'Payload',plk,'');

export key_AutokeyPayload := plk;

