IMPORT Doxie, Data_Services;

EXPORT Key_Source_Reference := MODULE

	srM 	:= $.Layouts.sourceRefBase;

	EXPORT ocn_name := INDEX({srM.ocn, srM.name} 
														,srM 
														,Data_Services.Data_location.Prefix('tools') + 'thor_data400::key::phonesmetadata::carrier_reference_' + doxie.Version_SuperKey);

END;