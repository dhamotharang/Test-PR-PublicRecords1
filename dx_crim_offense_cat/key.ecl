IMPORT $, Data_Services, Doxie;

keyed_fields := $.layouts.keyed_fields;
payload := $.layouts.payload;
			   
EXPORT Key(boolean pUseProd = false) := INDEX(keyed_fields
                                                    ,payload
                                                    ,$.names(pUseProd).key);

