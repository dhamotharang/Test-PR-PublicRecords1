//code to make calls to validation macro for the FDN keys
//This code contains the mapping data from the key file to the parent file i.e. key fields and the corresponding parent fields.
// While basic functions like stripOrdinal are also applied to the parent fields, this excludes the fields which may have permutations like the 
//lname, city_code fields.
//Author: Vikram Pareddy
export validateFDNKeys(buildVersion, isDev=true) := functionmacro
		IMPORT keyvalidation, fraudDefenseNetwork, Autokey, Autokeyb2, fdn_qa, ut;
		
		dsName := 'FDN';

		didKeySummary := KeyValidation.validateKeysMacrov2(dsName, 
																																													KeyValidation.FDNMappings.DIDKeyName, 
																																													KeyValidation.FDNMappings.DIDKeyType, 
																																													KeyValidation.FDNMappings.DIDParentName, buildVersion, 
																																													KeyValidation.FDNParentFiles.FlattenedFDNDS, 
																																													KeyValidation.FDNKeyFiles.DIDKey, 
																																													KeyValidation.FDNMappings.DIDKeySet,
																																													KeyValidation.FDNMappings.DIDParentSet, 
																																													KeyValidation.FDNMappings.DIDIgnoredFields, 
																																													KeyValidation.FDNMappings.DIDUniqueField, isDev);
																																													
		emailKeySummary := KeyValidation.validateKeysMacrov2(dsName,
																																													KeyValidation.FDNMappings.EmailKeyName, 
																																													KeyValidation.FDNMappings.EmailKeyType, 
																																													KeyValidation.FDNMappings.EmailParentName, buildVersion, 
																																													KeyValidation.FDNParentFiles.FlattenedFDNDS, 
																																													KeyValidation.FDNKeyFiles.EmailKey, 
																																													KeyValidation.FDNMappings.EmailKeySet,
																																													KeyValidation.FDNMappings.EmailParentSet, 
																																													KeyValidation.FDNMappings.EmailIgnoredFields, 
																																													KeyValidation.FDNMappings.EmailUniqueField, isDev);
																																													

																																													
		ipKeySummary := KeyValidation.validateKeysMacrov2(dsName, 
																																													KeyValidation.FDNMappings.IPKeyName, 
																																													KeyValidation.FDNMappings.IPKeyType, 
																																													KeyValidation.FDNMappings.IPParentName, buildVersion, 
																																													KeyValidation.FDNParentFiles.FlattenedFDNDS, 
																																													KeyValidation.FDNKeyFiles.IPKey, 
																																													KeyValidation.FDNMappings.IPKeySet,
																																													KeyValidation.FDNMappings.IPParentSet, 
																																													KeyValidation.FDNMappings.IPIgnoredFields, 
																																													KeyValidation.FDNMappings.IPUniqueField, isDev);


		idKeySummary := KeyValidation.validateKeysMacrov2(dsName,
																																											KeyValidation.FDNMappings.IDKeyName, 
																																											KeyValidation.FDNMappings.IDKeyType, 
																																											KeyValidation.FDNMappings.IDParentName, buildVersion, 
																																											KeyValidation.FDNParentFiles.FlattenedFDNDS, 
																																											KeyValidation.FDNKeyFiles.FlattenedIDKey, 
																																											KeyValidation.FDNMappings.IDKeySet,
																																											KeyValidation.FDNMappings.IDParentSet, 
																																											KeyValidation.FDNMappings.IDIgnoredFields, 
																																											KeyValidation.FDNMappings.IDUniqueField, isDev);
																											
																										
		payloadAutoKeySummary := KeyValidation.validateKeysMacrov2(dsName,
																																																KeyValidation.FDNMappings.PayloadAKKeyName, 
																																																KeyValidation.FDNMappings.PayloadAKKeyType, 
																																																KeyValidation.FDNMappings.PayloadAKParentName, buildVersion, 
																																																KeyValidation.FDNParentFiles.FlattenedFDNDS, 
																																																KeyValidation.FDNKeyFiles.FlattenedPayloadAutoKey, 
																																																KeyValidation.FDNMappings.PayloadAKKeySet,
																																																KeyValidation.FDNMappings.PayloadAKParentSet, 
																																																KeyValidation.FDNMappings.PayloadAKIgnoredFields, 
																																																KeyValidation.FDNMappings.PayloadAKUniqueField, isDev);
																																		

		//Key validation for autokeys is addressed in a different macro - this is to enable reusability - if there are datasets 
		//with similar structure/mapping as FDN we can use this macro to validate their autokeys as well
		//autokeyValidationSummary has the summary records of all the autokeys passed.
		KeyValidation.validateAutoKeys(dsName, KeyValidation.FDNKeyFiles.PayloadAutoKey, buildVersion, 
																								autokeyValidationSummary, 
																								KeyValidation.FDNKeyFiles.addressAutoKey, 
																								KeyValidation.FDNKeyFiles.addressb2AutoKey, 
																								KeyValidation.FDNKeyFiles.cityStNameAutoKey,
																								KeyValidation.FDNKeyFiles.cityStNameb2AutoKey, 
																								KeyValidation.FDNKeyFiles.nameAutoKey, 
																								KeyValidation.FDNKeyFiles.phone2AutoKey, 
																								KeyValidation.FDNKeyFiles.phoneb2AutoKey,
																								KeyValidation.FDNKeyFiles.ssn2AutoKey, 
																								KeyValidation.FDNKeyFiles.stNameAutoKey, 
																								KeyValidation.FDNKeyFiles.stNameb2AutoKey, 
																								KeyValidation.FDNKeyFiles.zipAutoKey, 
																								KeyValidation.FDNKeyFiles.zipb2AutoKey, isDev);

		validationSummary := didKeySummary  + emailKeySummary  + ipKeySummary
																			  + idKeySummary + payloadAutoKeySummary 
																				+ autokeyValidationSummary;
		
																									
		 return validationSummary;
 
 endmacro;