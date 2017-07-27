export Proc_Build_SuperFiles_Unlinked(
	string version) := function

	return parallel(
		Function_Update_SuperFiles(Filenames.Linking.Unlinked,version),
		Function_Update_SuperFiles(Filenames.URLs.Unlinked,version),
		Function_Update_SuperFiles(Filenames.TradeLines.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Contacts.Unlinked,version),		
		Function_Update_SuperFiles(Filenames.Finance.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Industry.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Incorporation.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Relationship.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Mark.Unlinked,version),
		Function_Update_SuperFiles(Filenames.UCC.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.UCC.Party,version),
		Function_Update_SuperFiles(Filenames.UCC.Collateral,version),
		Function_Update_SuperFiles(Filenames.Bankruptcy.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Bankruptcy.Party,version),
		Function_Update_SuperFiles(Filenames.Liens.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Liens.Party,version),
		Function_Update_SuperFiles(Filenames.Aircraft.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Aircraft.Party,version),
		Function_Update_SuperFiles(Filenames.MotorVehicle.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.MotorVehicle.Registration,version),
		Function_Update_SuperFiles(Filenames.MotorVehicle.Title,version),
		Function_Update_SuperFiles(Filenames.MotorVehicle.Party,version),
		Function_Update_SuperFiles(Filenames.Watercraft.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Watercraft.Party,version),
		Function_Update_SuperFiles(Filenames.Property.Main.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Property.Party.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Property.Assessment.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Property.Deed.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Property.Foreclosure.Unlinked,version),
		Function_Update_SuperFiles(Filenames.Abstract.Unlinked,version),
		Function_Update_SuperFiles(Filenames.License.Unlinked,version)
	  );

end;
