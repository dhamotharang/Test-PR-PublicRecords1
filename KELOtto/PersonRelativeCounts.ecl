IMPORT KELOtto;
IMPORT Ut;
IMPORT watchdog;
base_wdog_best := DATASET(ut.foreign_prod + 'thor_data400::BASE::Watchdog_best',watchdog.layout_key,FLAT);
wd := INDEX(base_wdog_best, watchdog.layout_key, ut.foreign_prod+'thor_data400::key::watchdog_best.did_qa'); 

DidsPrep := TABLE(KELOtto.fraudgovshared(did < 900000000000 and (integer)dob < 19960000), {AssociatedCustomerFileInfo, did}, AssociatedCustomerFileInfo, did, MERGE);
Dids := JOIN(DidsPrep, wd, LEFT.did=RIGHT.did, TRANSFORM({RECORDOF(LEFT), RIGHT.adl_ind}, SELF := LEFT, SELF := RIGHT), KEYED, LEFT OUTER);
RelativesPrep1 := JOIN(Dids, KELOtto.LexidAssociations/*(personal and confidence in ['HIGH','MEDIUM'])*/, LEFT.did = RIGHT.FromPerson, TRANSFORM({RECORDOF(LEFT), RIGHT.ToPerson}, SELF := LEFT, SELF := RIGHT), LEFT OUTER, HASH);
RelativesPrep2 := JOIN(RelativesPrep1, RelativesPrep1, LEFT.AssociatedCustomerFileInfo = RIGHT.AssociatedCustomerFileInfo AND LEFT.ToPerson = RIGHT.did AND LEFT.ToPerson != LEFT.did, KEEP(1), HASH);
RelativesAggregatePrep := TABLE(RelativesPrep2, {AssociatedCustomerFileInfo, did, RelativeCount := COUNT(GROUP, ToPerson > 0)}, AssociatedCustomerFileInfo, did, MERGE);

DidsWithLNRelativeCount := TABLE(RelativesPrep1, {did, adl_ind, AssociatedCustomerFileInfo, INTEGER1 OnBenefit := 1, LnRelativeCount := COUNT(GROUP, ToPerson > 0), NoLnRelativeCount := MAP(COUNT(GROUP, ToPerson > 0) < 1 => 1, 0)}, AssociatedCustomerFileInfo, did, MERGE);

RelativesAggregate := JOIN(DidsWithLNRelativeCount, RelativesAggregatePrep, LEFT.AssociatedCustomerFileInfo = RIGHT.AssociatedCustomerFileInfo AND LEFT.did=RIGHT.did, 
                            LEFT OUTER, HASH);

EXPORT PersonRelativeCounts := RelativesAggregate;

