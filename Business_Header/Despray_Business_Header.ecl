despray(STRING file, string server, string destination) := IF(FileServices.FileExists(file),
		fileservices.despray(file,server,destination), 
		OUTPUT('File "' + file + '" does not exist, so no despray performed'));

f1  := despray(Bus_Thor + 'OUT::Business_Header', MOXIE_BH_DESPRAY_SERVER,MOXIE_BH_MOUNT + 'bus_hdr/bus_hdr.d00');
f2  := despray(Bus_Thor + 'OUT::Business_Relatives_Group', MOXIE_BH_DESPRAY_SERVER,MOXIE_BH_MOUNT + 'bus_relatives_group/bus_relatives_group.d00');
f3  := despray(Bus_Thor + 'OUT::Business_Header_Best', MOXIE_BH_DESPRAY_SERVER,MOXIE_BH_MOUNT + 'bus_hdr_best/bus_hdr_best.d00');
f4  := despray(Bus_Thor + 'OUT::Business_Header_Stat', MOXIE_BH_DESPRAY_SERVER,MOXIE_BH_MOUNT + 'bus_hdr_stat/bus_hdr_stat.d00');


export Despray_Business_Header := sequential(f2);