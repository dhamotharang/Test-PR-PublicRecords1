import PhonesInfo,dx_PhonesInfo;
EXPORT Files := module

			EXPORT carrier_reference_base_in	:= dataset(Constants.in_carrier_reference, Layouts.layout_carrier_reference_base, flat);
			
			EXPORT carrier_reference_base 			 := dataset(Constants.base_carrier_reference, Layouts.layout_carrier_reference_base,flat);	
	    			
			EXPORT Lerg6Main 		:= dataset([],dx_PhonesInfo.Layouts.lerg6Main);	

END;