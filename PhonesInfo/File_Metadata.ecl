//Combines the Ported & LIDB Base Files Together to Create the Metadata Phone Base

EXPORT File_Metadata := module

	EXPORT PortedMetadata_Main		:= dataset('~thor_data400::base::phones::ported_metadata_main', PhonesInfo.Layout_Common.portedMetadata_Main, flat);	

end;