IMPORT STD;

EXPORT BuildPayload(DATASET($.Layout_Base2) base = $.Files('').Base2, string8 version = (string8)Std.Date.Today()) := FUNCTION

		payload := Nac_V2.To_Payload(base);

		lfn := $.Superfile_List().sfPayload + '::' + version;
		build_payload := IF(NOT Std.File.FileExists(lfn),
			SEQUENTIAL(
				OUTPUT(payload,,lfn, compressed),
				$.Promote_Superfiles(nac_v2.Superfile_List('').sfPayload, lfn),
			));
			
		return build_payload;
END;