import autokeyb2,doxie,bipv2;

BaseTempLayout := RECORD
		Layouts_certification.Keybuild - BIPV2.IDlayouts.l_xlink_ids;
		UNSIGNED6 ZERO;
	END;
	
	BaseTempLayout trfReformat(Layouts_certification.Keybuild L) := TRANSFORM
		SELF.DID  := 0;
		SELF.ZERO := 0;
		SELF      := L;
	END;	

fakepf := PROJECT(Files().Keybuild_Cert.built,trfReformat(LEFT));

ak_qa_keyname := Insurance_Certification.Constants().ak_qa_keyname;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,ak_qa_keyname+'Payload',plk,'');

export key_AutokeyPayload := plk;

