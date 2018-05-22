import DOPSGrowthCheck;
export GenerateECLCommand(Dataset(DOPSGrowthCheck.layouts.Build_Data_Layout) BuildList) := function
    IdentifyAttributes:=project(BuildList,transform(DOPSGrowthCheck.layouts.Attribute_Layout_For_Command,
    //Self.hasProdRecord:=DOPSGrowthCheck.HasPrevious(Left.PackageName,Left.KeyFile,Left.ProdVersion);
    //Self.hasProdRecord:='true';
    Self.indexfields:=DOPSGrowthCheck.DopsLayoutFunctions.fgetkeyedcolumns(Left.KeyFile);
    Self:=Left;));

    CommandLayout:=RECORD
        string command;
        string FullCommand;
    END;
output('test1');
    

    GenerateIndividualCommands:=PROJECT(IdentifyAttributes, transform(CommandLayout,
            Self.command:='DOPSGrowthCheck.CalculateStats(\''+
                            Left.PackageName    +'\',\''+
                            Left.KeyAttribute   +'\',\''+
                            Left.KeyFile        +'\',\''+
                            Left.indexfields    +'\','+
                            //Left.hasProdRecord  +',\''+
                            Left.CertVersion    +'\',\''+
                            Left.ProdVersion    +'\')';
            Self.FullCommand:=Self.command;
            ));

    CommandLayout tCombineCommands(CommandLayout L, CommandLayout R ):=TRANSFORM
        SELF.FullCommand:=L.FullCommand + ',' + R.command;
        Self:=R;
    END;

    dCombineCommands:=rollup(GenerateIndividualCommands,true,tCombineCommands(left,right));
    return dCombineCommands;
end;