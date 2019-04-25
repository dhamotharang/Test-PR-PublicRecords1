// there are no fields which are not without permutations in Nameb2 auto key. 
//Phone2 and Phoneb2 do not have mapping for phone_number in parent
//There are usually 0 records in Phone2 and Phoneb2
EXPORT validateAutoKeysForBK( parentFile, buildVersion, autoKeyValidationSummary, 
																						addressAutoKey, addressb2AutoKey, cityStNameAutoKey,
																						cityStNameb2AutoKey, fein2AutoKey, nameAutoKey, nameWords2Autokey, 
																						phone2AutoKey, phoneb2AutoKey, ssn4nameAutokey, ssn2AutoKey, 
																						stNameAutoKey, stNameb2AutoKey, zipAutoKey, zipb2AutoKey, isDev=true) := macro

import KeyValidation;
import KeyValidation.BKMappings as BKMappings;

datasetName := 'Bankruptcy';
keyType := 'AutoKey';
//building the parent file - moving company_addr field into person_addr


																						
addressSummary := keyValidation.validateKeysMacrov2(datasetName, 'Address', keyType, 
																			BKMappings.AddressAKParentName, buildVersion, parentFile, addressAutoKey, 
																			BKMappings.AddressAKKey, BKMappings.AddressAKParent, 
																			BKMappings.AddressAKIgnoredFields, BKMappings.AddressAKUniqueField, isDev );


addressb2Summary := keyValidation.validateKeysMacrov2(datasetName, 'Addressb2', keyType, 
																					BKMappings.AddressAKParentName, buildVersion,  
																					 parentFile, addressb2AutoKey, 
																					 BKMappings.Addressb2AKKey, BKMappings.Addressb2AKParent, 
																					 BKMappings.Addressb2AKIgnoredFields,BKMappings.Addressb2AKUniqueField, isDev );
																					 
cityStNameSummary := keyValidation.validateKeysMacrov2(datasetName, 'CityStName', keyType, 
																					BKMappings.CityStNameAKParentName, buildVersion,  
																					 parentFile, cityStNameAutoKey, 
																					 BKMappings.CityStNameAKKey, BKMappings.CityStNameAKParent, 
																					 BKMappings.CityStNameAKIgnoredFields, BKMappings.CityStNameAKUniqueField, isDev);

cityStNameb2Summary := keyValidation.validateKeysMacrov2(datasetName, 'CityStNameb2', keyType, 
																					BKMappings.CityStNameb2AKParentName, buildVersion,  
																					 parentFile, cityStNameb2AutoKey, 
																					 BKMappings.CityStNameb2AKKey, 
																					 BKMappings.CityStNameb2AKParent, 
																					 BKMappings.CityStNameb2AKIgnoredFields,  
																					 BKMappings.CityStNameb2AKUniqueField, isDev );
																					 
fein2Summary := keyValidation.validateKeysMacrov2(datasetName, 'FEIN2', keyType, 
																					BKMappings.FEIN2AKParentName, buildVersion,  
																					 parentFile, fein2AutoKey, BKMappings.FEIN2AKKey, 
																					 BKMappings.FEIN2AKParent, BKMappings.FEIN2AKIgnoredFields, 
																					 BKMappings.FEIN2AKUniqueField, isDev );
																					 
nameSummary := keyValidation.validateKeysMacrov2(datasetName, 'Name', keyType, BKMappings.NameAKParentName, buildVersion,  
																					 parentFile, nameAutoKey, 
																					 BKMappings.NameAKKey, BKMappings.NameAKParent, 
																					 BKMappings.NameAKIgnoredFields, BKMappings.NameAKUniqueField, isDev );			
																						
nameWords2Summary := keyValidation.validateKeysMacrov2(datasetName, 'NameWords2', keyType, 
																					BKMappings.NameWords2AKParentName, buildVersion,  
																					 parentFile, nameWords2Autokey, 
																					 BKMappings.NameWords2AKKey, BKMappings.NameWords2AKParent,
																					 BKMappings.NameWords2AKIgnoredFields, BKMappings.NameWords2AKUniqueField, isDev );			
																						

ssn4NameSummary := keyValidation.validateKeysMacrov2(datasetName, 'SSN4Name', keyType, 
																					BKMappings.SSN4NameAKParentName, buildVersion,  
																					 parentFile, ssn4nameAutokey, 
																					 BKMappings.SSN4NameAKKey, 
																					 BKMappings.SSN4NameAKParent, 
																					 BKMappings.SSN4NameAKIgnoredFields,
																					 BKMappings.SSN4NameAKUniqueField, isDev );
																					 
ssn2Summary := keyValidation.validateKeysMacrov2(datasetName, 'SSN2', keyType, 
																					BKMappings.SSN2AKParentName, buildVersion,  
																					 parentFile, ssn2AutoKey, 
																					 BKMappings.SSN2AKKey, BKMappings.SSN2AKParent, 
																					 BKMappings.SSN2AKIgnoredFields, BKMappings.SSN2AKUniqueField, isDev );
																					 
stNameSummary := keyValidation.validateKeysMacrov2(datasetName, 'StName', keyType, 
																					BKMappings.StNameAKParentName, buildVersion,  
																					 parentFile, stNameAutoKey, 
																					 BKMappings.StNameAKKey, BKMappings.StNameAKParent, 
																					 BKMappings.StNameAKIgnoredFields, BKMappings.StNameAKUniqueField, isDev );		
																					 
stNameb2Summary := keyValidation.validateKeysMacrov2(datasetName, 'StNameb2', keyType, 
																					BKMappings.StNameb2AKParentName, buildVersion,  
																					 parentFile, stNameb2AutoKey, 
																					 BKMappings.StNameb2AKKey, 
																					 BKMappings.StNameb2AKParent, 
																					 BKMappings.StNameb2AKIgnoredFields, 
																					 BKMappings.StNameb2AKUniqueField, isDev );
																
zipSummary := keyValidation.validateKeysMacrov2(datasetName, 'Zip', keyType, 
																					BKMappings.ZipAKParentName, buildVersion,  
																					 parentFile, zipAutoKey, 
																					 BKMappings.ZipAKKey, BKMappings.ZipAKParent,
																					 BKMappings.ZipAKIgnoredFields, BKMappings.ZipAKUniqueField, isDev );	
																					 
zipb2Summary := keyValidation.validateKeysMacrov2(datasetName, 'Zipb2', keyType, 
																					BKMappings.Zipb2AKParentName, buildVersion,  
																					 parentFile, zipb2AutoKey, 
																					BKMappings.Zipb2AKKey, BKMappings.Zipb2AKParent,
																					BKMappings.Zipb2AKIgnoredFields, 
																					BKMappings.Zipb2AKUniqueField, isDev );
																					

autoKeyValidationSummary :=   addressSummary + addressb2Summary + cityStNameSummary +
																							 cityStNameb2Summary + fein2Summary  + nameSummary  + nameWords2Summary +
																							 ssn2Summary + ssn4NameSummary + 
																							 stNameSummary + stNameb2Summary + zipSummary + zipb2Summary;

 // autoKeyValidationSummary := fein2Summary;

endmacro;