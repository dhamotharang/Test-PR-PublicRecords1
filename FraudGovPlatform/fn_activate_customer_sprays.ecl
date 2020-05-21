import FraudGovPlatform,PromoteSupers;
EXPORT fn_Activate_Customer_Sprays (
	string20 Customer_ID,
	string20 File_Type
) := FUNCTION 

	d:=dataset([{
				Customer_ID,
				File_Type
				}],
			FraudGovPlatform.Layouts.Flags.CustomerActiveSprays);

	fn := fraudgovplatform.filenames().Flags.CustomerActiveSprays;

	CustomerActiveSprays := if(count(nothor(FileServices.SuperFileContents(Filenames().Flags.CustomerActiveSprays))) > 0,
		FraudGovPlatform.Files().Flags.CustomerActiveSprays,
		DATASET([], FraudGovPlatform.Layouts.Flags.CustomerActiveSprays ));

	AppendandDedup := dedup( CustomerActiveSprays + d, all);
	

	PromoteSupers.MAC_SF_BuildProcess(AppendandDedup,fn,WriteFile,2,,true);

	return WriteFile;
end;
