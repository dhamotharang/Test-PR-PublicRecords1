#constant('Platform','FraudGov');
import Fraudshared;

OttoRulesPrep := Fraudshared.Files('').input.mbsfdnmasteridindtypeinclusion.sprayed(inclusion_type = 'GCID' AND status = 1);

// Map the fdn id to customer id
FdnToCustomerID := TABLE(KELOtto.fraudgov, {classification_permissible_use_access.fdn_file_info_id, Customer_Id, classification_Permissible_use_access.Ind_type}, classification_permissible_use_access.fdn_file_info_id, Customer_Id, classification_Permissible_use_access.Ind_type, FEW);

OttoRules := JOIN(OttoRulesPrep, FdnToCustomerID, (INTEGER)LEFT.ind_type = (INTEGER)RIGHT.ind_type AND (INTEGER)LEFT.inclusion_id = (INTEGER)RIGHT.customer_id, 
                TRANSFORM(RECORDOF(LEFT), SELF.fdn_ind_type_gc_id_inclusion := RIGHT.fdn_file_info_id, SELF := LEFT));
    
// These are here to unit test sharing etc..

TempSharingRulesPrep := DATASET([
    {272, 990}, {272, 991}, 
    {990, 272},  
    {991, 272}],
    {unsigned6 fdn_ind_type_gc_id_inclusion, unsigned6 fdn_file_info_id});
    
TempSharingRules := PROJECT(TempSharingRulesPrep, TRANSFORM(RECORDOF(OttoRules), SELF := LEFT, SELF := []));

// NB: At some point need to make sure sure to add any fdn file infos that are only shared from others with but are not contributing data or sharing data.
// If they setup the sharing rules correctly this *should* just happen.

SelfSharing := PROJECT(TABLE(OttoRules/* + TempSharingRules*/, {fdn_ind_type_gc_id_inclusion, unsigned6 fdn_file_info_id := fdn_ind_type_gc_id_inclusion, ind_type}, fdn_ind_type_gc_id_inclusion, FEW), 
                   TRANSFORM(RECORDOF(OttoRules), 
                     SELF := LEFT, SELF := []));
OttoSharingFinal := OttoRules + SelfSharing;

// Only sharing rules for customers that actually have data?
//OttoSharingFinalWithCustomerID := DEDUP(SORT(JOIN(OttoSharingFinal, FdnToCustomerID, LEFT.fdn_ind_type_gc_id_inclusion=RIGHT.fdn_file_info_id, LOOKUP, MANY, LEFT OUTER), fdn_ind_type_gc_id_inclusion, fdn_file_info_id),fdn_ind_type_gc_id_inclusion, fdn_file_info_id);

// For customers that aren't sharing fill in their GCID from the inclusion_id;

// Add source gcid-hash

OttoSharingUsingInclusionId1 := PROJECT(OttoSharingFinal(inclusion_id > 0), 
                                TRANSFORM({RECORDOF(LEFT), INTEGER TargetCustomerHash}, 
                                  SELF.TargetCustomerHash := HASH32(LEFT.inclusion_id + '|' + LEFT.ind_type), SELF := LEFT));

OttoSharingUsingInclusionId2 := JOIN(OttoSharingUsingInclusionId1, OttoSharingUsingInclusionId1, 
                                LEFT.fdn_file_info_id=RIGHT.fdn_ind_type_gc_id_inclusion,
                                TRANSFORM({RECORDOF(LEFT), INTEGER SourceCustomerHash}, 
                                  SELF.SourceCustomerHash := RIGHT.TargetCustomerHash, SELF := LEFT), KEEP(1));

EXPORT SharingRules := DEDUP(SORT(OttoSharingUsingInclusionId2, SourceCustomerHash, TargetCustomerHash), SourceCustomerHash, TargetCustomerHash); //OttoSharingFinalWithCustomerID(fdn_ind_type_gc_id_inclusion in [372,342,332,312,861,382,322] and customer_id != ''); 

