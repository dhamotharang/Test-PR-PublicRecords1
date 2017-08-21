export Mac_Despray_File(logicalfile, destinationIP, destination_path, allow_overwrite) := 
macro

#workunit('name',logicalfile + ' despray')

#uniquename(despray_file)

%despray_file% := FileServices.Despray(logicalfile, destinationIP, destination_path, , , , allow_overwrite);

sequential(%despray_file%);

endmacro;