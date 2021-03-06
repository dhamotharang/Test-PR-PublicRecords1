export getRCdesc(string4 rc) := CASE(rc,	

// GDC  **The preceeding "I" signifies the return code is from the International version of Instant ID to remove any confusion during support calls.
 'I01'	=> 'Important Application Data Missing',
 'I02' => 'The input is reported as deceased',
 'I04' => 'The input Last Name and NID are verified, but not with the input Address and Phone',
//'I06' => 'The input NID/SIN is not valid.',  **FUTURE
//'I08'	=> 'The input phone number is potentially invalid',  **FUTURE
//'I09'	=> 'The input phone number is a pager number',  **FUTURE
//'I10'	=> 'The input phone number is a mobile number',  **FUTURE
 'I12'	=> 'The input identity information did not meet any category of global KYC for EIDV',
 'I13'	=> 'The input US Visa is not valid according to the ICAO/ICO 9303 international standard',
 'I14'	=> 'The input US Visa is expired',
 'I15'	=> 'The input US Visa length not valid',
 'I16'	=> 'The input Passport is not valid according to the ICAO/ICO 9303 international standard',
 'I17'	=> 'The input Passport is expired',
 'I18'	=> 'The input Passport length not valid',
 'I19'	=> 'Unable to verify name, address, NID and phone',
 'I20'	=> 'Unable to verify applicant name, address and phone number',
 'I21'	=> 'Unable to verify applicant name and phone number',
 'I22'	=> 'Unable to verify applicant name and address',
 'I23'	=> 'Unable to verify applicant name and NID',
 'I24'	=> 'Unable to verify applicant address and NID',
 'I25'	=> 'Unable to verify address',
 'I26'	=> 'Unable to verify NID',
 'I27'	=> 'Unable to verify phone number',
 'I28'	=> 'Unable to verify date-of-birth',
 'I29'	=> 'Unable to verify passport number',
 'I32'	=> 'The input name matches the OFAC file',
 'I33'	=> 'Single Source Verification Only',
 'I37'	=> 'Unable to verify name',
 //'I41'	=> 'The input Driver\'s License is invalid for the input Country.', **FUTURE
 'I45'	=> 'The input NID and address are not associated with the input last name and phone',
 'I48'	=> 'Unable to verify first name',
 'I51'	=> 'The input last name is not associated with the input NID',
 'I52'	=> 'The input first name is not associated with input NID',
 'I64'	=> 'The input address associated with a different phone number',
 'I66'	=> 'The input NID is associated with a different last name, same first name',
 'I71'	=> 'The input NID is not found in a public record database',
 'I72'	=> 'The input NID is associated with a different name and address',
 'I73'	=> 'The input phone number is not found in the public record',
//'I75'	=> 'The input name and address are associated with an unlisted/non-published phone number',  **FUTURE
 'I77'	=> 'The input name was missing',
 'I78'	=> 'The input address was missing',
 'I79'	=> 'The input NID was missing or incomplete',
 'I80'	=> 'The input phone was missing or incomplete',
 'I81'	=> 'The input date-of-birth was missing or incomplete',
 'I82'	=> 'The input name and address return a different phone number',
//'I91'	=> 'Security Freeze (CRA corrections database)',
//'I92'	=> 'Security Alert (CRA corrections database)',
//'I93'	=> 'Identity Theft Alert (CRA corrections database)',
//'I94'	=> 'Dispute On File (CRA corrections database)',
//'I95'	=> 'Negative File Alert (CRA corrections database)',
//'I96'	=> 'Corrections Database Information Utilized (CRA corrections database)',
//'I9B'	=> 'Evidence of historical property ownership but no current record',
 'IDV'  => 'Unable to verify drivers license number',
 'IIA'	=> 'The input IP address is unknown',
//'IIB'	=> 'The input IP address is assigned to a different state/province than the bill-to state/province',
//'IIC'	=> 'The input IP address is assigned to a different postal code than the bill-to postal code',
//'IID'	=> 'The input IP address is assigned to a different area code than the Bill-to phone number',
 'IIE'	=> 'The input IP address second-level domain is unknown',
//'IIF'	=> 'The input IP address is not assigned to the United States',
 'IIG'	=> 'The input IP address is non-routable over the internet',
//'IIH'	=> 'The input IP address is not assigned to Canada',  **FUTURE
//'III'	=> 'The input IP address is assigned to a different state/province than the input state/province',
//'IIJ'	=> 'The input address is assigned to a different postal code than the input postal code',
//'IIK'	=> 'The input IP address is assigned to a different area code than the input phone number',
//'IPA'	=> 'Potential address discrepancy - the input address may be a previous address',  **FUTURE
 'IWL'	=> 'The input name matches one or more of the non-OFAC global watchlist(s)',
 'REASON CODE' + rc + ' IS INVALID');
