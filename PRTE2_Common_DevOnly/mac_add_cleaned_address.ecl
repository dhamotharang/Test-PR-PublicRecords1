/* ***********************************************************************************************
PRTE2_Common_DevOnly.mac_add_cleaned_address
This "OR"s the Address.Layout_Clean182_fips to the layout sent in... so if your base file 
uses those field names, then the cleaned address will now be populatred in your base file.
If you do not use those field names it will append those fields (populated) to your base file and
you will need to project/transform to populate the field names you want populated.

Jun 2017 - added Clean Address error description to the end

*********************************************************************************************** */
EXPORT mac_add_cleaned_address(inDataset, fieldAddress, fieldCity, fieldSt, fieldZip5, fieldZip4 ='') := FUNCTIONMACRO

	IMPORT Address, PRTE2_Common_DevOnly, PRTE2_Common;

	// #UNIQUENAME(resCleanedAddrComp)					
	resCleanedAddrComp := PROJECT(inDataset, transform({RECORDOF(inDataset), Address.Layout_Clean182_fips},
																		SELF := PRTE2_Common.Clean_Address.FromLine(
																								LEFT.fieldAddress,
																								LEFT.fieldCity,
																								LEFT.fieldSt,
																								LEFT.fieldZip5,
																								
																								#IF( #TEXT(fieldZip4) <> '')
																									LEFT.fieldZip4
																								#ELSE
																									''
																								#END
																							);
																		SELF := LEFT
																		));

	// #UNIQUENAME(addHighRise)
	// addHighRise := PROJECT(resCleanedAddrComp, TRANSFORM( {RECORDOF(resCleanedAddrComp), STRING1 HighRiseIndicator},
															// SELF.HighRiseIndicator := IF(LEFT.err_stat[1] = 'S', 
																														// PRTE2_Common_DevOnly.ValidateAddress.isApt(LEFT.zip, LEFT.prim_range, LEFT.prim_name, LEFT.predir), 
																														// '');
															// SELF := LEFT)
													// );
	addHighRiseIndicator := PRTE2_Common_DevOnly.ValidateAddress.isAptBatch(resCleanedAddrComp);
	addBusinessIndicator := PRTE2_Common_DevOnly.ValidateAddress.isBusinessAddressBatch(addHighRiseIndicator);
	RETURN addBusinessIndicator;
	
	// see mac_add_cleaned_address_w_error to get this.
	// addErrorDescription  := PRTE2_Common_DevOnly.ValidateAddress.addErrorDescription(addBusinessIndicator);
	// RETURN addErrorDescription;   
	
ENDMACRO;