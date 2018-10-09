import DOPSGrowthCheck;
export GenerateECLCommand:= function
    // IdentifyAttributes:=project(BuildList,transform(DOPSGrowthCheck.layouts.Attribute_Layout_For_Command,
    //Self.hasProdRecord:=DOPSGrowthCheck.HasPrevious(Left.PackageName,Left.KeyFile,Left.ProdVersion);
    //Self.hasProdRecord:='true';
    // Self.indexfields:=DOPSGrowthCheck.DopsLayoutFunctions.fgetkeyedcolumns(Left.KeyFileNew);
    // Self:=Left;));
		IdentifyAttributes:=DOPSGrowthCheck.IdentifyChangedDatasets;

    CommandLayout:=RECORD
        string command;
        string FullCommand;
    END;
    
		GenerateIndividualCommands:=PROJECT(IdentifyAttributes, transform(CommandLayout,
            Self.command:='DOPSGrowthCheck.fnAlertTests(\''+
                            Left.PackageName        				+'\',\''+
                            Left.KeyNickName        				+'\',\''+
                            Left.version	          				+'\','+
                            Left.NumRecsThresholdMin        +','+
														Left.NumRecsThresholdMax  			+','+
														Left.UniqueThresholdMin         +','+
														Left.UniqueThresholdMax         +','+
														Left.PIDThresholdMax           	+','+
														Left.AddedThresholdMin          +','+
                            Left.AddedThresholdMax        	+','+
														Left.ModifiedThresholdMin       +','+
														Left.ModifiedThresholdMax       +','+
														Left.RemovedThresholdMin        +','+
														Left.RemovedThresholdMax        +','+
														Left.PersistThresholdMax        +',\''+
                            Left.emailList        					+'\')';
            Self.FullCommand:=Self.command;
            ));

    CommandLayout tCombineCommands(CommandLayout L, CommandLayout R ):=TRANSFORM
        SELF.FullCommand:=L.FullCommand + ',' + R.command;
        Self:=R;
    END;

    dCombineCommands:=rollup(GenerateIndividualCommands,true,tCombineCommands(left,right));
		finalcommand:=dCombineCommands[1].FullCommand;
    return finalcommand;
end;