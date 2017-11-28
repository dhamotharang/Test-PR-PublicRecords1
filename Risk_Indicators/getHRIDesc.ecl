﻿/*2016-05-21T00:27:51Z (Kevin Huls)
Automated reinstate from 2016-05-19T17:47:55Z
*/
export getHRIDesc(string5 rc) := CASE(TRIM(rc),	
'01' => 'Important application data missing',
'02' => 'The input SSN is reported as deceased',
'03' => 'The input SSN was issued prior to the input date-of-birth',
'04' => 'The input last name and SSN are verified, but not with the input address and phone',
'05' => 'The input bill-to and ship-to addresses are geographically distant (>50 miles)',
'06' => 'The input SSN is invalid',
'07' => 'The input phone number may be disconnected',
'08' => 'The input phone number is potentially invalid',
'09' => 'The input phone number is a pager number',
'10' => 'The input phone number is a mobile number',
'11' => 'The input address may be invalid according to postal specifications',
'12' => 'The input zip code belongs to a post office box',
'13' => 'The input address has an invalid apartment designation',
'14' => 'The input address is a transient commercial or institutional address',
'15' => 'The input phone number matches a transient commercial or institutional address',
'16' => 'The input phone number and input zip code combination is invalid',
'17' => 'The input bill-to and ship-to phone numbers are geographically distant (>50 miles)',

'19' => 'Unable to verify name, address, SSN/TIN and phone',
'20' => 'Unable to verify applicant name, address and phone number',
'21' => 'Unable to verify applicant name and phone number',
'22' => 'Unable to verify applicant name and address',
'23' => 'Unable to verify applicant name and SSN',
'24' => 'Unable to verify applicant address and SSN',
'25' => 'Unable to verify address',
'26' => 'Unable to verify SSN/TIN',
'27' => 'Unable to verify phone number',
'28' => 'Unable to verify date-of-birth',
'29' => 'The input SSN/TIN may have been miskeyed',
'30' => 'The input address may have been miskeyed',
'31' => 'The input phone number may have been miskeyed',
'32' => 'The input name matches the OFAC file',
'33' => 'The input address is not associated with the input business name or phone',
'34' => 'Incomplete verification',
'35' => 'Insufficient verification to return a score under CA law',
'36' => 'Identity elements not fully verified on all available sources',
'37' => 'Unable to verify name',
'38' => 'The input SSN is associated with multiple last names',
'39' => 'The input SSN is recently issued',
'40' => 'The input zip code is a corporate-only, military zip code',
'41' => 'The input driver\'s license number is invalid for the input DL State',
'42' => 'The input SSN matches the bankruptcy file',
'43' => 'The input name and address match the bankruptcy file',
'44' => 'The input phone area code is changing',
'45' => 'The input SSN and address are not associated with the input last name and phone',
'46' => 'The input work phone is a pager number',
'47' => 'The input phone is associated with a different business name or address',
'48' => 'Unable to verify first name',
'49' => 'The input phone and address are geographically distant (>10 miles)',
'50' => 'The input address matches a prison address',
'51' => 'The input last name is not associated with the input SSN',
'52' => 'The input first name is not associated with input SSN',
'53' => 'The input home phone and work phone are geographically distant (>100 miles)',
'54' => 'The input business name and address match a different TIN, not the input TIN',
'55' => 'The input work phone is potentially invalid',
'56' => 'The input work phone is potentially disconnected',
'57' => 'The input work phone is a mobile number',
'58' => 'The input business TIN was missing or incomplete',
'59' => 'The input business name was missing',
'60' => 'Unable to verify business name, address and phone number',
'61' => 'Unable to verify business name and phone number',
'62' => 'Unable to verify business name and address',
'63' => 'The input business name may have been miskeyed',
'64' => 'The input address returns a different phone number',
'65' => 'Unable to verify Business Address',
'66' => 'The input SSN is associated with a different last name, same first name',
'67' => 'Unable to verify business telephone number',
'68' => 'Unable to verify business facsimile number',
'69' => 'The input business phone number is associated with a residential listing',
'70' => 'The input business address may be a residential address (single family dwelling)',
'71' => 'The input SSN is not found in the public record',
'72' => 'The input SSN is associated with a different name and address',
'73' => 'The input phone number is not found in the public record',
'74' => 'The input phone number is associated with a different name and address',
'75' => 'The input name and address are associated with an unlisted/non-published phone number',
'76' => 'The input name may have been miskeyed',
'77' => 'The input name was missing',
'78' => 'The input address was missing',
'79' => 'The input SSN/TIN was missing or incomplete',
'80' => 'The input phone was missing or incomplete',
'81' => 'The input date-of-birth was missing or incomplete',
'82' => 'The input name and address return a different phone number',
'83' => 'The input date-of-birth may have been miskeyed',
'84' => 'The input business name, address and phone are not found together',
'85' => 'The input SSN was issued to a non-US citizen',
'86' => 'The input business name is not found; alternate business name found',
'87' => 'The input business name and address return a different phone number',
'88' => 'DBA name matched public records',
'89' => 'The input SSN was issued within the last three years',
'90' => 'The input SSN was issued after age five (post-1990)',
'91' => 'Security Freeze (CRA corrections database)',
'92' => 'Security Alert (CRA corrections database)',
'93' => 'Identity Theft Alert (CRA corrections database)',
'94' => 'Dispute On File (CRA corrections database)',
'95' => 'Subject has opted out of prescreen offers',
'96' => 'Corrections Database Information Utilized (CRA corrections database)',
'97' => 'Criminal record found',
'98' => 'Lien/Judgement record found',
'99' => 'The input address is verified but may not be primary residence',
'9A' => 'No evidence of property ownership',
'9B' => 'Evidence of historical property ownership but no current record',
'9C' => 'Length of residence',
'9D' => 'Change of address frequency',
'9E' => 'Number of sources confirming identity and current address',
'9F' => 'Date of confirming source update',
'9G' => 'Insufficient Age',
'9H' => 'Evidence of sub-prime credit services solicited',
'9I' => 'No evidence of post-secondary education',
'9J' => 'Age of Oldest Public Record on file',

'9K' => 'Address dwelling type',
'9L' => 'Distance between the current and previous address',
'9M' => 'Insufficient evidence of wealth',
'9N' => 'Correctional institution in address history',
'9O' => 'No evidence of phone service at address',
'9P' => 'Number of consumer finance inquiries',
'9Q' => 'Number of inquiries in the last 12 months',
'9R' => 'Length of time on sources confirming identity',
'9S' => 'Type of mortgage',
'9T' => 'Input phone is invalid, non-residential, or disconnected',
'9U' => 'Input address is invalid, non-residential, or undeliverable',
'9V' => 'Input SSN is invalid, recently issued, or inconsistent with date of birth',
'9W' => 'Bankruptcy record on file',
'9X' => 'Insufficient information on file',
'9Y' => 'Insufficient purchase activity reported',

'EA' => 'Unable to verify email address',

'A0' => 'The input TIN is associated with a different business name and address',
'A1' => 'Unable to find current public records related to the subject business',
'A2' => 'A bankruptcy, judgement and/or lien was found related to the subject business',
'A3' => 'Unable to find a current phone listing for the subject business',
'A4' => 'The input business is not in good standing per the Secretary of State',
'A5' => 'A judgement and/or lien filing was found related to the subject business',
'A6' => 'The input business is inactive per the Secretary of State',
'A7' => 'No updates to business record in the past three years',
'A8' => 'Authorized Agent is not linked to the business in public record sources',
'A9' => 'Age of oldest public record less than 2 years',
'AS' => 'No evidence of association between the billing and shipping identities',

'IA' => 'The input IP address is unknown',
'IB' => 'The input IP address is assigned to a different State/Province than the bill-to State/Province',
'IC' => 'The input IP address is assigned to a different postal code than the bill-to postal code',
'ID' => 'The input IP address is assigned to a different area code than the Bill-to phone number',
'IE' => 'The input IP address second-level domain is unknown',
'IF' => 'The input IP address is not assigned to the United States',
'IG' => 'The input IP address is non-routable over the internet',
'IH' => 'The input IP address is not assigned to Canada',

'II' => 'The input IP address is assigned to a different State/Province than the input State/Province',
'IJ' => 'The input IP address is assigned to a different postal code than the input postal code',
'IK' => 'The input IP address is assigned to a different area code than the input phone number',

'U1' => 'Insufficient income',
'U2' => 'Length of employment',

'WL' => 'The input name matches one or more of the non-OFAC global watchlist(s)',
'PO' => 'The primary input address is a PO Box',
'PA' => 'Potential address discrepancy - the Input address may be previous address',
'IT' => 'The input SSN is an ITIN',
'MI' => 'Multiple identities associated with the input SSN',

'CR' => 'Evidence of association with convicted criminals',
'MS' => 'Multiple SSNs reported with applicant',
'MN' => 'The input SSN was issued within the last seventeen years',
'PV' => 'Insufficient property value',
'EV' => 'Eviction record found',
'SR' => 'Address mismatch on secondary address range',
'B0' => 'Subject business verified but not on all available sources',
'BO' => 'Identity sourced only by national credit bureaus',

'CO' => 'The input zip code is a corporate only zip code',
'MO' => 'The input zip code is a military only zip code',
'ZI' => 'Unable to verify zip code',
'CZ' => 'Address mismatch between city/state and zip code',
'DV' => 'Unable to verify driver\'s license number',
'DF' => 'The input driver\'s license number is not found in the public record',
'DFN' => 'The input driver\'s license number is valid and is not found in the public record',	// modified so I could call the New description
'DM' => 'The input driver\'s license number may have been miskeyed',
'DD' => 'A different driver\'s license number has been found for the input applicant',
'RS' => 'The input SSN was possibly randomly issued by the SSA',
'IS' => 'Input SSN possibly randomly issued by SSA, but invalid when first associated with the input identity',
'CL' => 'The input SSN is not the primary SSN for the input identity',

'FM' => 'Subject is listed on the Direct Marketing Association \'Do Not Mail\' list',
'FB' => 'No record on file sourced by a national credit bureau',
'FQ' => 'High velocity of identity events',
'5Q' => '5 or more inquiries in the past 12 months',
'FR' => 'High risk activity associated with first degree relatives or close associates',
'FV' => 'Address reported vacant',
'NB' => 'No date-of-birth reported for the input identity',
'CA' => 'The primary input address is a Commercial Mail Receiving Agency',
'VA' => 'The input address is a vacant address',
'SD' => 'The input address State is different than the LN best address State for the input identity',
'DI' => 'The input identity is reported as deceased',
'NF' => 'The input first name and last name may have been flipped',
'EI' => 'The input data is associated with an emerging identity that is not fully established',

//New reason codes for FraudPoint 3
'AR' => 'Identity associated with high-risk identities',
'CB' => 'Too few sources corroborating SSN, address, and phone',
'CC' => 'Invalid or high risk SSN, address, or phone',
'DR' => 'Multiple identities associated with identity components',
'F0' => 'Phone observed in a high risk event',
'F1' => 'Phone provided in a probable fraud event',
'F2' => 'SSN observed in a high risk event, SSN possibly compromised',
'F3' => 'SSN provided in a probable fraud event, SSN possibly compromised',
'F4' => 'Address observed in a high risk event',
'F5' => 'Address provided in a probable fraud event',
'F6' => 'Identity observed in a high risk event, identity possibly compromised',
'F7' => 'Identity provided in a probable fraud event, identity possibly compromised',
'HA' => 'Identity first reported in last six months',
'IR' => 'Identity associated with suspicious activity',
'PH' => 'Name, address and phone not linked in reporting sources',
'PN' => 'Unable to verify phone number with identity',
'QA' => 'High velocity of recent search activity with SSN',
'QB' => 'Recent search activity with multiple identities for SSN',
'QC' => 'Recent search activity with multiple last names for SSN',
'QD' => 'Recent search activity with multiple addresses for SSN',
'QE' => 'Recent search activity with multiple birthdates for SSN',
'QF' => 'High velocity of recent search activity with address',
'QG' => 'Recent search activity with multiple identities at address',
'QH' => 'Recent search activity with multiple last names at address',
'QI' => 'Recent search activity with multiple SSNs at address',
'QJ' => 'High velocity of recent search activity with phone number',
'QK' => 'Recent search activity with multiple identities for phone number',
'QL' => 'Recent search activity with multiple emails for identity',
'QM' => 'Recent search activity with multiple identities for email',
'RC' => 'Identity not verified by a sufficient number of sources',
'RF' => 'Identity associated with suspicious identities',
'SA' => 'SSN not reported at address',
'SC' => 'High velocity of recent search activity for identity components',
'SN' => 'Mismatch of first and last names reported with SSN',
'S1' => 'Potential stolen or manipulated identity',
'S2' => 'Potential synthetic identity',
'S3' => 'Evidence of suspicious identity activity',
'S4' => 'High velocity of recent search activity for identity',
'S5' => 'Potential vulnerable victim or friendly fraud victim',
'VE' => 'High velocity of recent search activity for identity',
'VL' => 'Invalid or high risk SSN, address, or phone',
'VR' => 'Unable to verify key identity components',
'VV' => 'Minor or elderly identity',
'VX' => 'Multiple variations of identity components recently reported',

// Avenger Reason Codes
'DC' => 'Identity reported as deceased',
'AI' => 'Multiple invalid or insufficiently reported addresses on record for the identity',
'MD' => 'Multiple invalid SSNs reported for the identity',
'QO' => 'High velocity of recent search activity with addresses not on record for the identity',
'BT' => 'Identity not reported by the national credit bureaus for a sufficient amount of time',
'QN' => 'Recent search activity with multiple addresses for the identity',
'QP' => 'Recent search activity with phone numbers not on record for the identity',
'QR' => 'Recent search activity with multiple dates of birth for the identity',

// Insurance reason codes:
'A001' => 'Credit bureau header count',
'A02A' => 'Length of residence is undetermined',
'A02B' => 'Length of residence',
'A03A' => 'Time since SSN issued is undetermined',
'A03B' => 'Time since SSN issued',
'A009' => 'Unable to verify applicant',
'A021' => 'Multiple SSNs associated with address',
'A05A' => 'Time since sale of property at input address is undetermined',
'A05B' => 'Time since sale of property at input address',
'A050' => 'Change of address frequency',
'0001' => 'Credit bureau header count',
'0002' => 'Insufficient property value/No evidence',
'0003' => 'Multiple addresses associated with applicant',
'004A' => 'Length of residence is undetermined',
'004B' => 'Length of residence',
'0050' => 'Change of address frequency',
'006A' => 'Time since SSN issued is undetermined',
'006B' => 'Time since SSN issued',
'0009' => 'Unable to verify applicant',
'011A' => 'Residence Stability is undetermined',
'011B' => 'Time since prior address was updated in public record sources',
'0013' => 'Bankruptcy record found',
'0021' => 'Multiple SSNs associated with address',
'049A' => 'Length of residence at input address is undetermined',
'049B' => 'Length of residence at input address',
'0049' => 'Length of residence',
'050A' => 'Distance between addresses associated with applicant is undetermined',
'050B' => 'Distance between addresses associated with applicant',
'0055' => 'Multiple SSNs associated with applicant',
'E002' => 'The input SSN is reported as deceased',
'E019' => 'Unable to verify name, address, SSN and phone',
'E091' => 'Security Freeze',
'E092' => 'Security Alert',
'E093' => 'Identity Theft',
'E094' => 'Dispute on File',

// Post Beneficiary Fraud Codes:
'000' => 'No derogatory information found.',
'010' => 'UCC filing found.',
'020' => 'Bankruptcy records found.',
'030' => 'Liens and judgments records found.',
'040' => 'Business registration/affiliation found.',
'050' => 'Professional license found associated with subject.',
'060' => 'Possible incarceration or sex offender registry (SOFR) for subject.',
'070' => 'Indicates subject is associated with a business or organization.',
'080' => 'Current or best address is high risk (for example address is vacant, a business, or a prison).',
'090' => 'Has other assets - either watercraft or aircraft.',
'100' => 'Value of motor vehicle exceeds value threshold or is commercial vehicle.',
'110' => 'Found more motor vehicles than reported by subject.',
'120' => 'Subject associated with multiple real properties.',
'130' => 'More real property than reported by subject.',
'140' => 'More adults listed in household than provided on input.',
'150' => 'Possible incarceration or current/best address is a prison or correctional facility.',
'160' => 'Invalid Identity - SSN not valid, or name and SSN not verified.',
'170' => 'Drivers license is registered outside the input state.',
'180' => 'Current or best address is outside the input state.',
'190' => 'Duplicate Entry - subject\'s Link ID is associated with multiple records from the input file.',
'200' => 'Deceased record found matching input SSN and address, or SSN only.',
'210' => 'Deceased record found matching input name and address only.',
'220' => 'Deceased record found matching input SSN and name, or SSN, name, and address.',

// Healthcare Provider Codes:
'1100' => 'No Derogatory Information found matching input',
'C100' => 'Criminal record found matching input',
'C200' => 'Multiple criminal records found matching input',
'C300' => 'Misdemeanor record found matching input',
'C400' => 'Multiple misdemeanor records found matching input',
'C500' => 'Felony record found matching input',
'C600' => 'Multple felony records found matching input',
'C700' => 'Incarceration or Current /Best Address is a Prison or Correctional Facility found matching input',
'C800' => 'Sex offense record found matching input',
'C900' => 'Multiple sex offense records found matching input',
'D100' => 'Deceased record found matching input SSN & Name or SSN, Name & Address',
'D200' => 'Deceased record found matching input Name & Address only',
'D300' => 'Deceased record found matching input SSN & Address or SSN only',
'F100' => 'Bankruptcy record found matching input',
'F200' => 'Multiple Bankruptcy records found matching input',
'F300' => 'UCC Filing found matching input',
'F400' => 'Multiple UCC filings found matching input',
'F500' => 'Lien & Judgment record found matching input',
'F600' => 'Multiple lien & judgment records found matching input',
'ID10' => 'Invalid Identity - (SSN not Valid or Name and SSN not Verified)',
'ID20' => 'Public record history less than 3 years',
'L100' => 'Active professional license outside of practice state',
'L200' => 'No professional license information',
'L300' => 'No active professional license, located license is expired',
'S100' => 'Disciplinary Sanction record found matching input',
'S200' => 'Multiple Disciplinary Sanction records found matching input',
'S300' => 'LEIE Sanction record (debarred/excluded) found matching input',
'S400' => 'Currently excluded GSA record found matching input',
'S500' => 'Previously excluded GSA record found matching input',
'A100' => 'Association to a debarred/excluded business',
'A200' => 'Association to a debarred/excluded individual',
'A300' => 'Association to a GSA excluded business',
'A400' => 'Association to a GSA excluded individual',
'A500' => 'Association to an individual with a felony record',
'A600' => 'Association to an individual with multiple felony records',
'A700' => 'Association to an individual with a misdemeanor record',
'A800' => 'Association to an individual with multiple misdemeanor records',
'A900' => 'Association to an individual with severe criminal records',
'A450' => 'Association to an individual associated to a GSA excluded business',
'V100' => 'Number of sources confirming identity and current address',
'V200' => 'No Recent Updates',
'V300' => 'Age of oldest public record on file',

// RiskView Alert Flags
'100A' => 'Security Freeze On File',
'100B' => 'Security Fraud Alert On File',
'100C' => 'Consumer Statement On File',
'100D' => 'Insufficient Verification to Return a Consumer Report Under State or Federal Law',
'100E' => 'Consumer is Under the Age of 21',
'100F' => 'Consumer Has Opted Out of Prescreened Offers of Credit',
'200A' => 'Subject reported as deceased',
'222A' => 'Unable to return results as identity not found',
'300A' => 'Chapter 7 Bankruptcy On File',
'300B' => 'Chapter 9 Bankruptcy On File',
'300C' => 'Chapter 11 Bankruptcy On File',
'300D' => 'Chapter 12 Bankruptcy On File',
'300E' => 'Chapter 13 Bankruptcy On File',
'300F' => 'Chapter 15 Bankruptcy On File',
'400A' => 'Subject is a Covered Borrower Under the Military Lending Act',
'400B' => 'Subject is Not a Covered Borrower Under the Military Lending Act',
'400C' => 'Unable to Return Military Lending Act Information Due to Insufficient Input Elements',

// RiskView V5 Reason Codes
'F00' => 'Certain input identity elements inconsistent with information on file',
'F01' => 'Input address inconsistent with address on file',
'F02' => 'Identity not found',
'F03' => 'Input address is not the most recently reported address on file',
'F04' => 'Unable to confirm primary residence',
'C10' => 'Length of time on file is too short',
'C11' => 'Subject reported as deceased',
'C12' => 'Insufficient non-derogatory reporting history on file',
'C13' => 'Time at residence is too short',
'C14' => 'Too many address changes on file',
'C15' => 'Multiple Social Security Numbers on file',
'C16' => 'Invalid Social Security Number on file',
'C17' => 'Invalid phone number on file',
'C18' => 'Invalid address on file',
'C19' => 'Correctional institution address on file',
'C20' => 'Time reported by a credit bureau is too short',
'C21' => 'Too many short-term loan offer requests on file',
'C22' => 'Too few sources confirming input address as the primary residence',
//'C23' => 'Too few sources confirming input address as the primary residence',
'C23' => 'Too many identity variations associated with online activity',
'C24' => 'Time at previous residence was too short',
'C25' => 'Age at time first reported by a credit bureau',
'C26' => 'Too few sources confirming identity elements',
'C27' => 'Age at time of application',
'C28' => 'Age at time first reported by LexisNexis',
'D30' => 'Derogatory public record on file',
'D31' => 'Bankruptcy record on file',
'D32' => 'Criminal record on file',
'D33' => 'Eviction record on file',
'D34' => 'Lien or judgment record on file',
'A40' => 'No record of asset ownership',
'A41' => 'No record of property ownership',
'A42' => 'No record of current property ownership',
'A43' => 'No record of personal property ownership',
'A44' => 'No record of ownership of current address',
'A45' => 'Too few assets owned on file',
'A46' => 'Value of properties associated with subject is too low or not on file',
'A47' => 'Property value of current address is too low or not on file',
'A48' => 'Property financing is not a conventional mortgage',
'A49' => 'Property value has decreased',
'A50' => 'Too little retail purchase activity on file',
'A51' => 'Too few property characteristics on file',
'E55' => 'No record of college attendance on file',
'E56' => 'Academic ranking for the college attended',
'E57' => 'Insufficient occupational characteristics on file',
'E58' => 'Associated with too many inactive businesses',
'I60' => 'Too many inquiries in the last 12 months',
'I61' => 'Too many collection inquiries in the last 12 months',
'I62' => 'Too many identity variations associated with subject credit inquiries',
'S65' => 'Social Security Number is invalid, reported on a death record, or inconsistent with date of birth',
'S66' => 'Too many identities associated with Social Security Number',
'L70' => 'Address is invalid or undeliverable',
'L71' => 'Address is non-residential or associated with an institution',
'L72' => 'Address is reported as vacant',
'L73' => 'Address is associated with a correctional institution',
'L74' => 'Mail sent to address forwarded to a PO Box',
'L75' => 'Address is a delivery point for bundles of advertising material',
'L76' => 'Address is a seasonal address',
'L77' => 'Address is not a single family residence',
'L78' => 'Address has no phone listing',
'L79' => 'Address has too many associated identities on file',
'L80' => 'Property value for input address is too low or not on file',
'L81' => 'Mailing address on the property record does not match the property address',
'P85' => 'Phone is invalid, high risk commercial, or disconnected',
'P86' => 'Phone service type is pay phone, fax or pager',
'P87' => 'Phone listed to a correctional institution',
'P88' => 'Distance from address to phone listing address is too far',
'P89' => 'Too many identities associated with phone number',
'P90' => 'Input phone is not a residential land-line',

// custom reason codes for GreenDot
'D1' => 'Distance from Input Address to Retail Address over 100 Miles',
'D2' => 'Distance from Input Address to Retail Address over 200 Miles',
'D3' => 'Distance from Input Address to Retail Address over 400 Miles',
'D30' => 'Derogatory public record on file',
'D31' => 'Bankruptcy record on file',
'D32' => 'Criminal record on file',
'D33' => 'Eviction record on file',
'D34' => 'Lien or judgment record on file',

// Reason Code and Descriptions for SBOM_0_0 (Business Only) and SBBM_0_0 (Blended)
'B017' => 'Too few business associates on record with business',
'B026' => 'One or more business associates has a derogatory record on record',
'B031' => 'Certain business input identity elements inconsistent with information on record',
'B034' => 'Insufficient non-derogatory sources on record for the business',
'B035' => 'Insufficient business characteristics on record',
'B036' => 'Business length of time on record is too short',
'B037' => 'Business length of time on specific sources is too short',
'B038' => 'Time since source update is too long',
'B040' => 'Too many inquiries on record for the business',
'B052' => 'No record of business property ownership',
'B053' => 'Value of properties associated with business is too low or not on record',
'B055' => 'Too few S.O.S. filings on record',
'B056' => 'Business has a S.O.S. filing with an agent change on record',
'B057' => 'Business length of time on S.O.S. sources too short',
'B059' => 'Business reported as defunct on S.O.S. sources',
'B063' => 'Business has one or more derogatory records on record',
'B066' => 'Insufficient UCC activity on record for the business',
'B067' => 'Business data not available for the input business',
'B068' => 'Insufficient data on record to generate a score',
'B069' => 'Tax assessed value of the input business address is too low',
'B070' => 'Time at input business address is too short',
'B074' => 'Business associates have multiple derogatory record types on record',
'B075' => 'Business reported as inactive on S.O.S. sources',
'B076' => 'Time since non-derogatory source update is too long',
'B078' => 'One or more recent derogatory filings on record for the business',
'B079' => 'Lien or judgment amount is too high',
'BF106' => 'Business length of time on record is too short',
'BF107' => 'Time since source update is too long',
'BF108' => 'No trades on record for the business',
'BF110' => 'Too few of open trades on record for business',
'BF113' => 'Too many confirmed closed trades on record for business',
'BF117' => 'Time since first trade opened is too short',
'BF120' => 'Too many involuntarily closed accounts on record for the business',
'BF125' => 'No trades recently reported',
'BF126' => 'No loans recently reported',
'BF127' => 'No lines of credit recently reported',
'BF128' => 'No credit cards recently reported',
'BF129' => 'No leases recently reported',
'BF133' => 'Average utilization is too high',
'BF134' => 'Average utilization is too low',
'BF135' => 'Current utilization is too high',
'BF136' => 'Current utilization is too low',
'BF141' => 'One or more trades on record are not paid as agreed',
'BF142' => 'One or more trades with severe delinquency (91+)',
'BF143' => 'One or more chargeoffs on record for the business',

'P501' => 'No record of asset ownership',
'P502' => 'No record of property ownership',
'P505' => 'No record of ownership of current property',
'P506' => 'Insufficient property ownership history on record',
'P509' => 'Property value of current address is too low or not on record',
'P510' => 'Property financing is not a conventional mortgage',
'P511' => 'Property value has decreased',
'P512' => 'Too little retail purchase activity on record',
'P513' => 'Too few property characteristics on record',
'P515' => 'Insufficient non-derogatory reporting history on record',
'P516' => 'Time at residence is too short',
'P517' => 'Too many address changes on record',
'P521' => 'Invalid address on record',
'P523' => 'Time reported by a credit bureau is too short',
'P524' => 'Too many short-term loan offer requests on record',
'P526' => 'Derogatory public record on record',
'P531' => 'Accident on record',
'P532' => 'No record of college attendance on record',
'P534' => 'Insufficient occupational characteristics on record',
'P535' => 'Certain input identity elements inconsistent with information on record',
'P538' => 'Unable to confirm primary residence',
'P539' => 'Too many inquiries',
'P540' => 'Too many collection inquiries',
'P549' => 'Address has no phone listing',
'P550' => 'Address has too many associated identities on record',
'P562' => 'Identity has new elements on record',
'P565' => 'Insufficient business association characteristics on record',
'P566' => 'Too many recent identity element changes on record',
'P567' => 'Inadequate address history on record',

//Order Score new reason codes (Order score return these and the standard CBD reason codes)
'O1' => 'Unable to locate a retail transaction history between the Bill-To and Ship-To identities',
'O2' => 'The Bill-To and/or Ship-To identities have been seen multiple times in the previous 24 hours',
'O3' => 'The Bill-To and/or Ship-To identities have been seen multiple times in the previous week',
'O4' => 'The Bill-to and/or Ship-To have recent data suggesting a downward economic trajectory',
'O5' => 'Unable to locate both Bill-To and Ship-To identities',
'O6' => 'Unable to locate Ship-To identity',
'O7' => 'Unable to locate Bill-To identity',

'00' => '',
'REASON CODE' + rc + ' IS INVALID');
