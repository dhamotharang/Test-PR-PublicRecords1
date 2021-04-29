import FraudGovPlatform;
import FraudgovKEL;

//OttoRules := FraudGovPlatform.Files('').input.mbsfdnmasteridindtypeinclusion.sprayed(inclusion_type = 'GCID' AND status = 1);

// Prod Reference for testing in dataland.
OttoRules := Dataset('~foreign::10.173.44.105::fraudgov::in::sprayed::mbsfdnmasteridindtypeinclusion',FraudGovPlatform.Layouts.input.mbsfdnmasteridindtypeinclusion,csv(SEPARATOR('|\t|'),QUOTE(''),TERMINATOR('|\n')));

// Customer_id / ind_type for fdn_file_info_id from base data (it doesn't exist in the sharing rules).
CustomerIds := TABLE(FraudgovKEL.fraudgov, {classification_Permissible_use_access.fdn_file_info_id, inclusion_id := (INTEGER)customer_id, classification_Permissible_use_access.ind_type, ind_type_description := classification_permissible_use_access.ind_type_description, SourceCustomerHash := HASH32(TRIM(customer_id) + '|' + TRIM((STRING)classification_Permissible_use_access.ind_type))}, classification_Permissible_use_access.fdn_file_info_id, customer_id, classification_Permissible_use_access.ind_type, FEW);

CustomerIdStatePrep := TABLE(FraudgovKEL.fraudgov(clean_address.st != ''), 
{SourceCustomerHash := HASH32(TRIM(customer_id) + '|' + TRIM((STRING)classification_Permissible_use_access.ind_type)), 
STRING State := clean_address.st, StateCount := COUNT(GROUP)}, classification_Permissible_use_access.fdn_file_info_id, customer_id, classification_Permissible_use_access.ind_type, clean_address.st, MERGE);

CustomerIdState := DEDUP(SORT(CustomerIdStatePrep, SourceCustomerHash, -StateCount), SourceCustomerHash);

OttoSharingFinal := OttoRules;

OttoSharingUsingInclusionId1 := PROJECT(OttoSharingFinal(inclusion_id > 0), 
                                TRANSFORM({RECORDOF(LEFT), INTEGER TargetCustomerHash}, 
                                  SELF.TargetCustomerHash := HASH32(TRIM((STRING)LEFT.inclusion_id) + '|' + TRIM((STRING)LEFT.ind_type)), SELF := LEFT));

OttoSharingUsingInclusionId2 := JOIN(OttoSharingUsingInclusionId1, CustomerIds, 
                                LEFT.fdn_file_info_id=RIGHT.fdn_file_info_id,
                                TRANSFORM({RECORDOF(LEFT), RIGHT.ind_type_description, INTEGER SourceCustomerHash}, 
                                  SELF.ind_type_description := RIGHT.ind_type_description,
                                  SELF.SourceCustomerHash := RIGHT.SourceCustomerHash, SELF := LEFT), KEEP(1));
																	
// Putting this in specifically to implement customer state\jurisdiction, which should be replaced by customer state from MBS.

OttoSharingUsingInclusionIdWithState := JOIN(OttoSharingUsingInclusionId2, CustomerIdState, 
                                LEFT.SourceCustomerHash=RIGHT.SourceCustomerHash, LEFT OUTER, LOOKUP);

tempSharing := DATASET('~foreign::10.173.14.201::temp::sharingrules', RECORDOF(OttoSharingUsingInclusionIdWithState), THOR);
EXPORT SharingRules := OttoSharingUsingInclusionIdWithState;//OttoSharingUsingInclusionIdWithState;//OttoSharingUsingInclusionIdWithState;//tempSharing; 

// state and best lexid st 

