import bipv2;

EXPORT File_Base_Payload := function

	PayLoad_Temp_Layout := RECORD
		Layouts.Keybuild -BIPV2.IDlayouts.l_xlink_ids -source_rec_id;
		UNSIGNED6 DID;
		UNSIGNED6 ZERO;
	END;

	PayLoad_Temp_Layout trfBDIDReformat(Layouts.Keybuild L) := TRANSFORM
		SELF.DID  := 0;
		SELF.ZERO := 0;
		SELF      := L;
	END;	

	Payload:= PROJECT(Files().Keybuild.built,trfBDIDReformat(LEFT));
										
	return Payload;
	
END;