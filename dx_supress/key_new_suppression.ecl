IMPORT $, Data_Services, Doxie;

keyed_fields := $.layouts.keyed_fields;
payload := $.layouts.payload;
			   
EXPORT key_new_suppression(boolean isfcra = false) := INDEX(keyed_fields
                                                    ,payload
                                                    ,$.names(isfcra).key);

