IMPORT $, Data_Services, Doxie;

keyed_fields := $.layouts.BLKGRP_attr_over18_keyed_fields;
payload := $.layouts.BLKGRP_attr_over18_payload;
			   
EXPORT Key_BLKGRP_attr_over18(boolean isFCRA = false, boolean pUseProd = false) := INDEX(keyed_fields
																	,payload
																	,$.Filenames(pUseProd, isFCRA).keyBLKGRP_attr_over18,opt);

