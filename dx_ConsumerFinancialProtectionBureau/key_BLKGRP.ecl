IMPORT $, Data_Services, Doxie;

keyed_fields := $.layouts.BLKGRP_keyed_fields;
payload := $.layouts.BLKGRP_payload;
			   
EXPORT Key_BLKGRP(boolean isFCRA = false) := INDEX(keyed_fields
                                                    ,payload
                                                    ,$.Filenames(isFCRA).keyBLKGRP);

