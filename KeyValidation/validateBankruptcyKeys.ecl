//************************************************************************************************************************************//
// Description: code to make calls to validation macro for the Bankruptcy keys
// This code contains the mapping data from the key file to the parent file i.e. key fields and the corresponding parent fields.
// While basic functions like stripOrdinal are also applied to the parent fields, this excludes the fields which may have 
// permutations like the lname, city_code fields.
// Bankruptcy keys: Total number of keys: 28, [Autokeys: 17, bankruptcyv3 search keys: 11], ignoring the BKv2 search keys
// Note 1: ignoring nameb2 as there are no fields without permutations in it
//						ignoring phone2 and phoneb2 as there are no direct mappings, and the count is always zero
//						search::tmsid is deprecated, validating search::tmsid_linkids instead
//						bid::search::tmsid is not being built
// Note 2: Payload Autokey is built from BKSearch with wa phone numbers suppressed. The attributes that the 'suppress'
//						macro refers to point to the Dataland versions of files. In order to fix this, this should be changed to point 
//						to Prod versions. Instead of copying the whole macro(which can be changed), the input files have to be updated
//						(Header.file_header_wa and BankrutpcyV2.file_bankruptcy_search) to point to prod and the sandboxed version 
//             is used in KeyValidation
// Author: Vikram Pareddy
//************************************************************************************************************************************//
export validateBankruptcyKeys(__buildVersion, __isDev=true) := functionmacro
	
	import KeyValidation;
	
	FCRAValidationSummary := KeyValidation.validateBKFCRA(__buildVersion, __isDev);
	NonFCRAValidationSummary := KeyValidation.validateBKNon_FCRA(__buildVersion, __isDev);
	bkKeysSummary := FCRAValidationSummary + NonFCRAValidationSummary;
	
  return bkKeysSummary;
endmacro;