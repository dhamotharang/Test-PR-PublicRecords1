import autokeyb2,doxie,bipv2;

BaseTempLayout := RECORD
    Layouts.Keybuild - BIPV2.IDlayouts.l_xlink_ids - source_rec_id;
		UNSIGNED6 DID;
		UNSIGNED6 ZERO;
	END;
	
	BaseTempLayout trfReformat(Layouts.Keybuild L) := TRANSFORM
		SELF.DID  := 0;
		SELF.ZERO := 0;
		SELF      := L;
	END;	

fakepf := PROJECT(Files().Keybuild.qa,trfReformat(LEFT));

ak_qa_keyname := Workers_Compensation.Constants().ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,ak_qa_keyname+'Payload',plk,'');

export key_AutokeyPayload := plk;
