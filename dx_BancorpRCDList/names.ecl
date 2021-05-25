IMPORT data_services, doxie, STD;

STRING prefix := data_services.data_location.Prefix('BancorpRCDList') + 'thor_data400::key::BancorpRCDList::';

EXPORT names(STRING file_version = doxie.Version_SuperKey) := MODULE

		EXPORT i_ssn := prefix+file_version + '::ssn';

END;