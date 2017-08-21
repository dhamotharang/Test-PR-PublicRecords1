SEQUENTIAL(
	FileServices.CreateSuperFile('Address_Superfile'),
	FileServices.StartSuperFileTransaction(),
	FileServices.AddSuperFile('Address_Superfile','~mist::smd_file_address1'),
	FileServices.AddSuperFile('Address_Superfile','~mist::smd_file_address2'),
	FileServices.AddSuperFile('Address_Superfile','~mist::smd_file_address3'),
	FileServices.FinishSuperFileTransaction()
);