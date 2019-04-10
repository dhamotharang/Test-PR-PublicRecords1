#constant('Platform','FraudGov');
import Fraudshared;

OttoRules := Fraudshared.Files('').input.mbsfdnmasteridindtypeinclusion.sprayed(inclusion_type = 'GCID' AND status = 1);

// Prod Reference for testing in dataland.
//OttoRules := Dataset('~foreign::10.173.44.105::fraudgov::in::sprayed::mbsfdnmasteridindtypeinclusion',Fraudshared.Layouts.input.mbsfdnmasteridindtypeinclusion,csv(SEPARATOR('|\t|'),QUOTE(''),TERMINATOR('|\n')));

// Customer_id / ind_type for fdn_file_info_id from base data (it doesn't exist in the sharing rules).
CustomerIds := TABLE(KELOtto.fraudgov, {classification_Permissible_use_access.fdn_file_info_id, inclusion_id := (INTEGER)customer_id, classification_Permissible_use_access.ind_type, SourceCustomerHash := HASH32(TRIM(customer_id) + '|' + TRIM((STRING)classification_Permissible_use_access.ind_type))}, classification_Permissible_use_access.fdn_file_info_id, customer_id, classification_Permissible_use_access.ind_type, FEW);

OttoSharingFinal := OttoRules;

OttoSharingUsingInclusionId1 := PROJECT(OttoSharingFinal(inclusion_id > 0), 
                                TRANSFORM({RECORDOF(LEFT), INTEGER TargetCustomerHash}, 
                                  SELF.TargetCustomerHash := HASH32(TRIM((STRING)LEFT.inclusion_id) + '|' + TRIM((STRING)LEFT.ind_type)), SELF := LEFT));

OttoSharingUsingInclusionId2 := JOIN(OttoSharingUsingInclusionId1, CustomerIds, 
                                LEFT.fdn_file_info_id=RIGHT.fdn_file_info_id,
                                TRANSFORM({RECORDOF(LEFT), INTEGER SourceCustomerHash}, 
                                  SELF.SourceCustomerHash := RIGHT.SourceCustomerHash, SELF := LEFT), KEEP(1));

EXPORT SharingRules := DEDUP(SORT(OttoSharingUsingInclusionId2, fdn_file_info_id, SourceCustomerHash, TargetCustomerHash), fdn_file_info_id, SourceCustomerHash, TargetCustomerHash); 


