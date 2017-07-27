//-----------------------------------------------------------------
//NORMALIZE ADDRESSES
//-----------------------------------------------------------------
     //Table to obtain the previous address count per row
PrevAddTbl := TABLE(Transunion_PTrak.File_Transunion_Full_In,{UNSIGNED4 PrevAddrCount := COUNT(PreviousAddress),Transunion_PTrak.File_Transunion_Full_In}, MANY);

	//normalize previous addresses
Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec t_norm_addr (PrevAddTbl L, INTEGER C) := TRANSFORM
	SELF.FileType := 'F';
	SELF.AddressSeq := C + 1	;	
	SELF.VendorDocumentIdentifier := L.VendorDocumentIdentifier ;
	SELF.NormAddress:= L.PreviousAddress[C];
	SELF := L;

END;

norm_prev_addr := NORMALIZE(PrevAddTbl,LEFT.PrevAddrCount,t_norm_addr(LEFT,COUNTER));

	//Add current Address
Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec get_curr_addr (Transunion_PTrak.Layout_Transunion_Full_In.LayoutTransunionXMLMainIn L):= TRANSFORM
	SELF.FileType := 'F';
	SELF.AddressSeq := 1;	
	SELF.NormAddress:= L.CurrentAddress;
	SELF := L;
END;

CurrAddr := PROJECT(Transunion_PTrak.File_Transunion_Full_In, get_curr_addr(LEFT));
	
	//append current and previous addresses
	
norm_addresses := CurrAddr + norm_prev_addr;

EXPORT Normalize_Transunion_Address_Full := norm_addresses:persist('~thor_data400::persist::transunionptrak_normalized_address');