IMPORT BIPV2;

EXPORT layout_OSHAIR_inspection_clean_BIP := RECORD
  unsigned4 dt_first_seen						 := 0;
	unsigned4 dt_last_seen						 := 0;
	unsigned4 dt_vendor_first_reported := 0;
	unsigned4 dt_vendor_last_reported	 := 0;
  bipv2.IDlayouts.l_xlink_ids				 ;	      //Added for BIP project  
	UNSIGNED8 source_rec_id 					 := 0;   //Added for BIP project 
	layout_OSHAIR_inspection_clean		 ;
	unsigned8	raw_aid									 := 0;  //Added for AID
	unsigned8	ace_aid									 := 0; //Added for AID
END;