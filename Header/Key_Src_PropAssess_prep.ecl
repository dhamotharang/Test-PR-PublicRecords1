import ut,ln_propertyv2;

export Key_Src_PropAssess_prep(boolean pFastHeader = false) := function

dAS_as_Source := ln_propertyv2.ln_propertyv2_as_source(pFastHeader).ln_propertyv2_tax_as_source;

mac_key_src(dAS_as_Source, LN_Property.Layout_Property_Common_Model_BASE, 
						asses_child, 
						ut.Data_Location.Person_header+'thor_data400::key::propasses_src_index_'+SF_suffix(pFastHeader)+'_',id);
						
return id;
end;