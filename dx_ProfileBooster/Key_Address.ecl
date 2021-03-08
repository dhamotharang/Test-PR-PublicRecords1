IMPORT $, Data_Services;

rec := $.Layouts.i_address;

// EXPORT Key_Address(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.rawaid},
                                                    // rec,
	                                                  // $.Names().i_address);
EXPORT Key_Address(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.zip5, rec.primaryrange, rec.primaryname, rec.suffix, rec.predirectional, rec.postdirectional, rec.secondaryrange},
                                                    rec,
	                                                  $.Names().i_address);