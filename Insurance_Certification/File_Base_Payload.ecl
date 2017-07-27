import bipv2;

EXPORT File_Base_Payload := function

export PayLoad_Temp_Layout := RECORD
		Layouts_Certification.Keybuild - BIPV2.IDlayouts.l_xlink_ids;
		UNSIGNED6 ZERO;
	END;
	
export PayLoad_Temp_Layout trfBDIDReformat(Layouts_Certification.Keybuild L) := TRANSFORM
		SELF.ZERO := 0;
		SELF      := L;
	END;	
	
export Payload:= PROJECT(Files().Keybuild_Cert.built,trfBDIDReformat(LEFT));
											
return Payload;
end;