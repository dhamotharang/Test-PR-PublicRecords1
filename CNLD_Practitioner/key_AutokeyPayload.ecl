IMPORT AutokeyB2;

TempLayout := RECORD
	Layouts.KeyBuild;
	UNSIGNED6 BDID;
	UNSIGNED6 ZERO;
END;
	
TempLayout trfReformat(Layouts.KeyBuild L) := TRANSFORM
		SELF.BDID := 0;
		SELF.ZERO := 0;
		SELF      := L;
END;	

fakepf	:=	PROJECT(CNLD_Practitioner.Files().Keybuild.built,trfReformat(LEFT));

ak_qa_keyname := CNLD_Practitioner.Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                          did, 0, ak_qa_keyname + 'Payload', plk, '');

EXPORT  key_AutokeyPayload	:= plk;