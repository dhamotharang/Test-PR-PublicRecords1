//This is the code to execute in a builder window
//Copy the #workunit statement from the SALT-generated BWR_Delta
#workunit('name','MyModule.BWR_Delta - Finding the Delta of Two Files');
IMPORT MyModule,SALTnn,SALT_Examples;
d := MyModule.Delta(MyModule.In_Sample,SALT_Examples.File_Delta_Sample); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
