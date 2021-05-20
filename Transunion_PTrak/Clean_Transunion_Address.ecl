IMPORT  address, ut;

EXPORT Clean_Transunion_Address(STRING Full_filedate,STRING Update_filedate) := FUNCTION

norm_addresses := project(Transunion_PTrak.Normalize_Transunion_Update(Full_filedate,Update_filedate),transform(Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec, self.CleanAddress := '', self := left));

cash_address		:= Transunion_PTrak.File_Transunion_Cash_Address;

//-----------------------------------------------------------------
//DEDUP ADDRESSES
//-----------------------------------------------------------------
d_addresses:= DISTRIBUTE(norm_addresses,HASH(NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode)); 
dedup_addr := DEDUP(SORT(d_addresses,NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode,LOCAL),NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode, LOCAL) ; 

//-----------------------------------------------------------------
//CHECK CASH ADDRESS TO APPEND DATA THAT HAS ALREADY BEEN CLEANED
//-----------------------------------------------------------------
Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec t_GetCleanAddress (dedup_addr L, cash_address R) := TRANSFORM
	SELF.CleanAddress := R.CleanAddress;
	SELF := L;
END;
		//Join to Cash Address only if it has data
address_from_cash := JOIN(dedup_addr,DISTRIBUTE(cash_address,HASH(NormAddress.Address1, NormAddress.Address2, NormAddress.City, NormAddress.State, NormAddress.ZipCode)), 
																LEFT.NormAddress.Address1 = RIGHT.NormAddress.Address1 AND
																LEFT.NormAddress.Address2 = RIGHT.NormAddress.Address2 AND
																LEFT.NormAddress.City     = RIGHT.NormAddress.City     AND
																LEFT.NormAddress.State    = RIGHT.NormAddress.State    AND
																LEFT.NormAddress.ZipCode  = RIGHT.NormAddress.ZipCode,
																t_GetCleanAddress(LEFT,RIGHT), LEFT OUTER, LOCAL);
																
address_to_clean				:= address_from_cash (CleanAddress = '');
clean_address_from_cash	:= address_from_cash (CleanAddress <> '');


//-----------------------------------------------------------------
//STANDARDIZE ADDRESSES: clean address
//-----------------------------------------------------------------
Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec t_CleanAddress(address_to_clean L) := TRANSFORM
	SELF.CleanAddress := address.cleanaddress182(L.NormAddress.Address1 + ' ' + L.NormAddress.Address2, L.NormAddress.City + ' ' + L.NormAddress.State + ' ' + L.NormAddress.ZipCode);
	SELf.NormAddress.updateddate := ut.GetDate;
	SELF := L;
END;

addr_clean := PROJECT(address_to_clean, t_CleanAddress(LEFT)); 

//Add clean address to cash address superfile

for_cash_address		:= OUTPUT(addr_clean,,'~thor_data400::in::transunionptrak_cash_address_' + ut.GetDate ,overwrite,__compressed__);
address_clean_final	:= OUTPUT(IF(EXISTS(addr_clean) AND EXISTS(clean_address_from_cash), clean_address_from_cash + addr_clean,
							  	IF(EXISTS(addr_clean), addr_clean, clean_address_from_cash))
									,,'~thor_data400::in::transunionptrak_cleaned_'+ut.GetDate,overwrite,__compressed__);

BuildCashAddress:= SEQUENTIAL(for_cash_address,
															address_clean_final,
															FileServices.StartSuperFileTransaction(),
															FileServices.AddSuperFile('~thor_data400::in::transunionptrak_cash_address','~thor_data400::in::transunionptrak_cash_address_' + ut.GetDate ),
															FileServices.AddSuperFile('~thor_data400::in::transunionptrak_cleaned','~thor_data400::in::transunionptrak_cleaned_' + ut.GetDate ),
															FileServices.FinishSuperFileTransaction()
);

return BuildCashAddress;

END;


