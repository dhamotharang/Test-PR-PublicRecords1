EXPORT AllFiles := Module
	
	Export dsmetadata := dataset('~thor::base::emailage::metadata', $.Layouts.rMetadata, thor);
	Export dsnames := dataset('~thor::base::emailage::names', $.Layouts.rNames, thor);
	Export dsaddress := dataset('~thor::base::emailage::address', $.Layouts.rAddress, thor);
	Export dsemails := dataset('~thor::base::emailage::emails', $.Layouts.rEmail, thor);
	Export dsphones := dataset('~thor::base::emailage::phones', $.Layouts.rPhone, thor);
	Export dsrelatives := dataset('~thor::base::emailage::relatives', $.Layouts.rRelative, thor);
	Export dsfraudflags := dataset('~thor::base::emailage::fraudflags', $.Layouts.rFraudFlags, thor);

END;
