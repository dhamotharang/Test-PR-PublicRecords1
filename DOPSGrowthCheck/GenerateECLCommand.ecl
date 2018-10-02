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
            Self.command:='DOPSGrowthCheck.CalculateStats(\''+
                            Left.PackageName        +'\',\''+
                            Left.KeyAttribute       +'\',\''+
                            Left.KeyNickName        +'\',\''+
                            Left.KeyFileNew         +'\',\''+
                            Left.indexfields        +'\',\''+
							Left.PersistRecIDField  +'\',\''+
							Left.EmailField         +'\',\''+
							Left.PhoneField         +'\',\''+
							Left.SSNField           +'\',\''+
							Left.FeinField          +'\',\''+
                            Left.CertVersion        +'\',\''+
                            Left.ProdVersion        +'\')';
            Self.FullCommand:=Self.command;
            ));

    CommandLayout tCombineCommands(CommandLayout L, CommandLayout R ):=TRANSFORM
        SELF.FullCommand:=L.FullCommand + ',' + R.command;
        Self:=R;
    END;

    dCombineCommands:=rollup(GenerateIndividualCommands,true,tCombineCommands(left,right));
    return dCombineCommands;
end;