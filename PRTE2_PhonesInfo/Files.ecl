import PhonesInfo;
EXPORT Files := module

			//infiles are the base files that are currently in production at the time of the build
			EXPORT phones_ported_metadata_base_in	:= dataset(Constants.in_phones_ported_metadata, Layouts.layout_phones_ported_metadata_base_in, flat);
			EXPORT phones_ported_metadata_base 			 := dataset(Constants.base_phones_ported_metadata, Layouts.layout_phones_ported_metadata_base_ext,flat);
	
			EXPORT carrier_reference_base_in	:= dataset(Constants.in_carrier_reference, Layouts.layout_carrier_reference_base, flat);
			EXPORT carrier_reference_base 			 := dataset(Constants.base_carrier_reference, Layouts.layout_carrier_reference_base,flat);	
	    			
			EXPORT Lerg6Main 		:= dataset([],Layouts.lerg6Main);	

END;