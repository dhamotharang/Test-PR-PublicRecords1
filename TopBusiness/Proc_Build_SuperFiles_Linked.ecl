export Proc_Build_SuperFiles_Linked(
	string version) := function

	return parallel(
		Function_Update_SuperFiles(Filenames.LLID.Linked,version),
		Function_Update_SuperFiles(Filenames.URLs.Linked,version),
		Function_Update_SuperFiles(Filenames.TradeLines.Linked,version),
		Function_Update_SuperFiles(Filenames.Contacts.Linked,version),
		Function_Update_SuperFiles(Filenames.Finance.Linked,version),
		Function_Update_SuperFiles(Filenames.Industry.Linked,version),
		Function_Update_SuperFiles(Filenames.Incorporation.Linked,version),
		Function_Update_SuperFiles(Filenames.Relationship.Linked,version),
		Function_Update_SuperFiles(Filenames.UCC.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.Bankruptcy.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.Liens.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.Mark.Linked,version),
		Function_Update_SuperFiles(Filenames.Aircraft.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.MotorVehicle.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.Watercraft.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.Property.Main.Linked,version),
		Function_Update_SuperFiles(Filenames.Property.Party.Linked,version),
		Function_Update_SuperFiles(Filenames.Property.Assessment.Linked,version),
		Function_Update_SuperFiles(Filenames.Property.Deed.Linked,version),
		Function_Update_SuperFiles(Filenames.Property.Foreclosure.Linked,version),
		Function_Update_SuperFiles(Filenames.Abstract.Linked,version),
		Function_Update_SuperFiles(Filenames.License.Linked,version)
		);

end;
