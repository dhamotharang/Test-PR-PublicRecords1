despray(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.despray(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no despray performed'));

f1  := despray(Bus_Thor + 'OUT::Business_Contacts', MOXIE_BH_DESPRAY_SERVER,MOXIE_BH_MOUNT + 'bus_cont/bus_cont.d00');

export Despray_Business_Contacts := f1;