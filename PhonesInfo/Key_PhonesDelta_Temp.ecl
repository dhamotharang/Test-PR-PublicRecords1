import doxie;

EXPORT Key_PhonesDelta_Temp := MODULE

	inFile	:= PhonesInfo.File_Metadata_Delta_Temp.PortedMetadata_DeltaMain;
	
	PhonesInfo.Layout_Common.portedMetadata_Main fixFormat(inFile l):= transform
		self := l;
	end;

	inFPDelta										:= project(inFile, fixFormat(left));
	
	export Ported_MetadataDelta := index(inFPDelta
																				,{phone}
																				,{inFPDelta}
																				,/*Data_Services.Data_location.Prefix('NONAMEGIVEN')+*/'~thor_data400::key::phones_ported_metadata_delta_'+doxie.Version_SuperKey);
END;