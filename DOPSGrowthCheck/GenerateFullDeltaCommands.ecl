import std;
Export GenerateFullDeltaCommands(Dataset(DOPSGrowthCheck.layouts.Build_Data_Layout) BuildList) := function

    IdentifyAttributes:=project(BuildList,transform(DOPSGrowthCheck.layouts.Delta_Attribute_Layout_For_Command,
    Self:=Left;));
		
    CommandLayout:=RECORD
        string command;
        string FullCommand;
    END;
    
		RemoveIncompleteFiles:=IdentifyAttributes(STD.File.FileExists(KeyFileNew)=true and STD.File.FileExists(KeyFileOld)=true);
		
    GenerateIndividualCommands:=PROJECT(RemoveIncompleteFiles, transform(CommandLayout,
            Self.command:='DOPSGrowthCheck.DeltaCommand(\''+
                            Left.KeyFileNew         +'\',\''+
                            Left.KeyFileold         +'\',\''+
                            Left.PackageName        +'\',\''+
                            Left.KeyNickName        +'\',\''+
                            Left.KeyAttribute       +'\',\''+
                            Left.PersistRecIDField  +'\',\''+
							Left.CertVersion        +'\',\''+
                            Left.ProdVersion        +'\',['+
                            Left.FieldsOfInterest   +'])';
            Self.FullCommand:=Self.command;
            ));						

    CommandLayout tCombineCommands(CommandLayout L, CommandLayout R ):=TRANSFORM
        SELF.FullCommand:=L.FullCommand + ',' + R.command;
        Self:=R;
    END;

    dCombineCommands:=rollup(GenerateIndividualCommands,true,tCombineCommands(left,right));
    return dCombineCommands;

end;