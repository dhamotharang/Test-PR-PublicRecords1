import  transunion_ptrak ; 

export Fn_Remove_TUCS_deletes ( dataset(header.Layout_Header) h ) := FUNCTION

tucs_deletes := transunion_ptrak.File_Transunion_Delete  ; 

h_only_tucs := h(src='TS');
h_other := h(src <>'TS'); 

header_refreshed := join(h_only_tucs , tucs_deletes, left.vendor_id[3..14] = right.PARTYID,
                     	 transform({recordof(header.Layout_Header)},
				         self := left),left only,lookup) ;
						 

return 	h_other + header_refreshed ;  

end ; 				 