IMPORT FraudgovKEL;
IMPORT AppendBankDetails;
IMPORT FraudGovPlatform;
IMPORT AppendDisposableEmailDomainFlag;

/*
  This is specifically for prepping transactions for KEL. 
  Anything that needs a non-data append should be done here.
*/

// Remove massively high frequency addresses.
// At some point we need to think through taking this out.

HighFreqAddrTable := TABLE(FraudgovKEL.fraudgov(clean_address.prim_range != '' AND clean_address.prim_name != '' AND clean_address.zip != '' AND clean_address.sec_range != ''), {clean_address.prim_range, clean_address.prim_name, clean_address.zip, clean_address.sec_range, recs := count(group)}, clean_address.prim_range, clean_address.prim_name, clean_address.zip, clean_address.sec_range, MERGE)(recs > 4000);
HighFreqAddr := JOIN(FraudgovKEL.fraudgov, HighFreqAddrTable, LEFT.clean_address.prim_range = RIGHT.prim_range AND LEFT.clean_address.prim_name = RIGHT.prim_name AND LEFT.clean_address.zip = RIGHT.zip, LEFT ONLY, LOOKUP);

// Bank Append.

FraudGovWithBank1 := AppendBankDetails.macAppendBankDetails(HighFreqAddr, bank_routing_number_1, 'bank1');
FraudGovWithBank := AppendBankDetails.macAppendBankDetails(FraudGovWithBank1, bank_routing_number_2, 'bank2');

// Deceased.
FraudGovWithDeceased := JOIN(FraudGovWithBank, FraudgovKEL.PersonDeceased, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// CIID
//FraudGovWithCIID := JOIN(FraudGovWithDeceased, FraudgovKEL.PersonCIID, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// FraudPoint
//FraudGovWithFraudpoint := JOIN(FraudGovWithCIID, FraudgovKEL.PersonFraudPoint, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

FraudGovWithBocashell := JOIN(FraudGovWithDeceased, FraudgovKEL.PersonBocashell, LEFT.record_id = RIGHT.record_id, TRANSFORM({RECORDOF(LEFT),RECORDOF(RIGHT),boolean BocashellHit, unsigned bocashelldid}, SELf.BocashellHit := MAP(RIGHT.record_id>0 => 1, 0), SELF.bocashelldid := RIGHT.did, SELF := LEFT, SELF := RIGHT), LEFT OUTER, KEEP(1), HASH);

// IP Metadata
FraudGovWithIPMetadata := JOIN(FraudGovWithBocashell, FraudgovKEL.PersonIPMetadata, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// Crim
FraudGovWithCrim := JOIN(FraudGovWithIPMetadata, FraudgovKEL.PersonCrim, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// Advo
FraudGovWithAdvo := JOIN(FraudGovWithCrim, FraudgovKEL.PersonAdvo, LEFT.record_id = RIGHT.record_id, LEFT OUTER, KEEP(1), HASH);

// Dispoable emails

FraudGovWithDispoableEmailFlag := AppendDisposableEmailDomainFlag.macAppendDisposableEmailDomainFlag(FraudGovWithAdvo, email_address);

EXPORT FraudGovPrep := PROJECT(FraudGovWithDispoableEmailFlag, TRANSFORM({RECORDOF(LEFT) - UID}, SELF := LEFT));