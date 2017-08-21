IMPORT AID;

EXPORT Layout_FCC_base_bip_AID := RECORD

	FCC.Layout_FCC_base_bip;

  STRING10                        clean_licensees_phone             :='';
  STRING10                        clean_contact_firms_phone_number  :='';
  STRING10                        clean_contact_firms_fax_number    :='';

  STRING100												prep_line1_licensees			 	      :='';
  STRING50												prep_line_last_licensees		      :='';
  STRING100												prep_line1_firm     			 	      :='';
  STRING50												prep_line_last_firm      		      :='';

	AID.Common.xAID	                RawAID_licensees                  := 0;
	AID.Common.xAID	                ACEAID_licensees		              := 0;
	AID.Common.xAID	                RawAID_firm                       := 0;
	AID.Common.xAID	                ACEAID_firm     		              := 0;

END;
