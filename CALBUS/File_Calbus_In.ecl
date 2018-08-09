export File_Calbus_In := module

	export File_raw(string8 filedate) := function
		return dataset(Constants.Cluster + 'in::Calbus::raw_'+filedate, Calbus.Layouts_Calbus.Layout_raw_crlf, thor);
	end;

	//Original SF without the NAICS_Code field
	export File_Cleaned_Super  := dataset(Constants.Cluster + 'in::Calbus::Superfile', Calbus.Layouts_Calbus.Layout_Common_old, thor);

	//SF with the NAICS_Code field
	export File_Cleaned_Super2 := dataset(Constants.Cluster + 'in::Calbus::Superfile2', Calbus.Layouts_Calbus.Layout_Common_old2, thor);

	//CleanedSuperFile with "Sub_Account_Number" ,"Account_Type" fields 
	export File_Cleaned_Super3 := dataset(Constants.Cluster + 'in::Calbus::Superfile3', Calbus.Layouts_Calbus.Layout_Common, thor);

end;
