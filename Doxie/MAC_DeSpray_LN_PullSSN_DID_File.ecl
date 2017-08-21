export MAC_DeSpray_LN_PullSSN_DID_File(logicalname, destinationIP, destinationdir, wuid) := macro

#workunit('name','Pull SSN DeSpray');

#uniquename(filename)
#uniquename(filedate)
#uniquename(file_exists)
#uniquename(destinationfile)
#uniquename(despray)

%filedate% := wuid[2..9];
%filename% := logicalname + '_' + wuid;

%file_exists% := FileServices.FileExists(%filename%);

%destinationfile% := destinationdir + 'lnoptout_DID.d00';

%despray% := FileServices.DeSpray(%filename%,
								destinationIP,
								%destinationfile%,
								 ,,,true);

sequential(%despray%);
// if (%file_exists%, %despray%, output('LN OPT OUT DID FILE DOES NOT EXIST'));

endmacro;