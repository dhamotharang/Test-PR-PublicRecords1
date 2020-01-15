IMPORT $, Data_Services;

rec := $.Layout_Keybase;

EXPORT Key_Did := INDEX({rec.did}, 
												rec - did,
	                      $.Names().did.qa);
												
