import data_services, ut;

//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type

EXPORT File_Source_Reference := MODULE

		EXPORT Main 	:= dataset('~thor_data400::base::phones::source_reference_main', PhonesInfo.Layout_Common.sourceRefBase, flat);

END; 