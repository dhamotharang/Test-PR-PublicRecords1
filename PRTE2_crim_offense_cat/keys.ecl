
IMPORT  doxie;

EXPORT keys := MODULE

EXPORT key_charge := INDEX(FILES.charge_file, {offensecharge}, 
	 {files.charge_file}, 
	Constants.KeyName_charge + doxie.Version_SuperKey + '::charge');

End;
	