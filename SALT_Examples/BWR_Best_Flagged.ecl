IMPORT MyModule,SALTnn;
OUTPUT (MyModule.best(MyModule.In_Sample_Best_Flag).In_Flagged_Summary,named('In_Flagged_Summary'));
OUTPUT (MyModule.best(MyModule.In_Sample_Best_Flag).In_Flagged_Summary_BySrc,named('In_Flagged_Summary_BySrc'));
OUTPUT (MyModule.best(MyModule.In_Sample_Best_Flag).Input_Flagged,named('Input_Flagged'));
