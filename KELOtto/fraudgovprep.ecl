IMPORT KELOtto;
IMPORT AppendBankDetails;
IMPORT FraudGovPlatform;

/*
  This is specifically for prepping transactions for KEL. 
  Anything that needs a non-data append should be done here.
*/

// Remove massively high frequency addresses.
// At some point we need to think through taking this out.

HighFreqAddrTable := TABLE(KELOtto.fraudgov, {clean_address.prim_range, clean_address.prim_name, clean_address.zip, clean_address.sec_range, recs := count(group)}, clean_address.prim_range, clean_address.prim_name, clean_address.zip, clean_address.sec_range, MERGE)(recs > 4000);
HighFreqAddr := JOIN(KELOtto.fraudgov, HighFreqAddrTable, LEFT.clean_address.prim_range = RIGHT.prim_range AND LEFT.clean_address.prim_name = RIGHT.prim_name AND LEFT.clean_address.zip = RIGHT.zip, LEFT ONLY, LOOKUP);

// Bank Append.

FraudGovWithBank1 := AppendBankDetails.macAppendBankDetails(HighFreqAddr, bank_routing_number_1, 'bank1');
FraudGovWithBank := AppendBankDetails.macAppendBankDetails(FraudGovWithBank1, bank_routing_number_2, 'bank2');

// Deceased.
FraudGovWithDeceased := JOIN(FraudGovWithBank, KELOtto.PersonDeceased, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// CIID
FraudGovWithCIID := JOIN(FraudGovWithDeceased, KELOtto.PersonCIID, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// FraudPoint
FraudGovWithFraudpoint := JOIN(FraudGovWithCIID, KELOtto.PersonFraudPoint, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// IP Metadata
FraudGovWithIPMetadata := JOIN(FraudGovWithFraudpoint, KELOtto.PersonIPMetadata, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// Crim
FraudGovWithCrim := JOIN(FraudGovWithIPMetadata, KELOtto.PersonCrim, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

EXPORT FraudGovPrep := PROJECT(FraudGovWithCrim, TRANSFORM({RECORDOF(LEFT) - UID}, SELF := LEFT));