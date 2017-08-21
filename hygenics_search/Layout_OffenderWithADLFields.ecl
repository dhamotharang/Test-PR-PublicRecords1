import corrections;

EXPORT Layout_OffenderWithADLFields := 	record
		corrections.layout_offender;
		unsigned6	temp_did;
		UNSIGNED4   xadl2_keys_used   := 0 ; //VC 20130204
    INTEGER2    xadl2_weight      := 0 ;
    UNSIGNED2   xadl2_Score       := 0 ;
    UNSIGNED2   xadl2_distance    := 0 ;
    String22    xadl2_matches     := '';// VC end
	end;