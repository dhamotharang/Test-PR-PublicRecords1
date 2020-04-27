﻿Import Data_Services, doxie_files, doxie,data_services;

dPhoneMart_base := PhoneMart.Prep_Build.applyRegulatoryPhoneMart(PhoneMart.Files.base);
//remore scrub data
layout_key_base := record
	PhoneMart.Layouts.base - [ScrubsBits1, ScrubsBits2];
end;	
dPhoneMart_base_slim := PROJECT(dPhoneMart_base,layout_key_base);

EXPORT key_phonemart_did := index(dPhoneMart_base_slim(did<>0),
                                {unsigned6 l_did := did},{dPhoneMart_base_slim},
																'~thor_data400::key::phonemart::did_'+doxie.Version_SuperKey);
	
