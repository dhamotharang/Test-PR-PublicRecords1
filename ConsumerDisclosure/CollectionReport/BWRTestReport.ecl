// -------------------------------------------------
// | BWR - Collection Report Validation
// | 
// | Note: For correct results, must run on Thor Prod or point data_services.default_data_location 
// |   to foreign prod).
// -------------------------------------------------
import ConsumerDisclosure;

// Input LexID
#STORED('LexID', 0);            						

// Any one of the collection names returned by the report service, e.g. PersonHeaderKeys; or blank for all.
#STORED('Collection', '');        
// #STORED('Collection', 'PersonHeaderKeys');        

// Request date - YYYYMMDD
#STORED('RequestDate', '');

// TRUE will only return records flagged as diff.
#STORED('ReturnDiffOnly', FALSE); 									

ConsumerDisclosure.CollectionReport.TestMod.runBWRValidation;
