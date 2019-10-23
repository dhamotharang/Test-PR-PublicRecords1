import data_services;
export File_Calbus_In := module

	export File_raw(string8 filedate) := function
		return dataset(Constants.Cluster + 'in::Calbus::raw_'+filedate, Calbus.Layouts_Calbus.Layout_raw_crlf, thor);
	end;

	//CleanedSuperFile with "Sub_Account_Number" ,"Account_Type" fields 
	export File_Cleaned_Super := dataset(Constants.Cluster + 'in::calbus::Clean_updates::Superfile', Calbus.Layouts_Calbus.Layout_Common, thor);

end;
