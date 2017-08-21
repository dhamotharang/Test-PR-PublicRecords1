//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Property_Transactions_DeedsMortgages.BWR_Delta - Finding the Delta of Two Files - SALT V3.4.1');
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages,SALT34;
d := InsuranceHeader_Property_Transactions_DeedsMortgages.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
