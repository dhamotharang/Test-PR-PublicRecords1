import ut,ln_propertyv2,ln_mortgage;

export Key_Src_Deed_prep(boolean pFastHeader = false) := function

dDE_as_Source := ln_propertyv2.ln_propertyv2_as_source(pFastHeader).ln_propertyv2_deed_as_source;

mac_key_src(dDE_as_Source,  ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base, 
			deeds_child, 
						ut.Data_Location.Person_header+'thor_data400::key::propdeed_src_index_'+SF_suffix(pFastHeader)+'_',id);
						
return id;
end;