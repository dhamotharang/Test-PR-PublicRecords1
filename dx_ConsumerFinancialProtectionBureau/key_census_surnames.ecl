IMPORT $, Data_Services, Doxie;

keyed_fields := $.layouts.census_surnames_keyed_fields;
payload := $.layouts.census_surnames_payload;
			   
EXPORT Key_census_surnames(boolean isFCRA = false, boolean pUseProd = false) := INDEX(keyed_fields
                                                        ,payload
                                                        ,$.Filenames(pUseProd, isFCRA).keycensus_surnames,opt);

