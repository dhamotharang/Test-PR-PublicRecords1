EXPORT GenerateChangeByFieldCommands(Dataset(DOPSGrowthCheck.layouts.Build_Data_Layout) BuildList) := function
		CommandLayout:=RECORD
        string command;
        string FullCommand;
    END;
    IdentifyAttributes:=project(BuildList,transform(DOPSGrowthCheck.layouts.Change_Field_Layout_For_Command,
    Self:=Left;));
		
    
    
		// ChangesByField(in_base,in_father,PackageName,NickName,recref,rec_id,ignorefields='',VersionBase,VersionFather,publish=false,iskey=false) := functionmacro
		
    GenerateIndividualCommands:=PROJECT(IdentifyAttributes, transform(CommandLayout,
            Self.command:='DOPSGrowthCheck.ChangesByField(\''+
                            Left.KeyFileNew         +'\',\''+
                            Left.KeyFileold         +'\',\''+
                            Left.PackageName        +'\',\''+
                            Left.KeyNickName        +'\',\''+
                            Left.KeyAttribute       +'\',\''+
                            Left.PersistRecIDField  +'\',\''+
														Left.ignorefields				+'\',\''+
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