IMPORT PRTE2,PRTE_CSV;
#WORKUNIT ('name', 'PRCT PII FILES');

PII_Scrambled    := '~prte::in::custtest::csv::scrambled::propertyinfo9';
testds := DATASET(/*ut.foreign_prod + */ PII_Scrambled,	PRTE2.layouts.batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
//*OUTPUT(testds,named('piiScramble'));


ds2  := PRTE_CSV.PropertyInformation.dthor_data400__key__propertyinfo__rid;
//*OUTPUT(choosen(ds2(property_rid = 331738772),1200),named('piRID'));

ds3  := PRTE_CSV.PropertyInformation.dthor_data400__key__propertyinfo__address;
OUTPUT(choosen(ds3,1200),named('piAddr'));