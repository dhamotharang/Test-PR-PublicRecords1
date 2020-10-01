
IMPORT  doxie;

EXPORT keys := MODULE

 EXPORT key_charge := INDEX(FILES.key_file, {offensecharge}, 
 {files.key_file}, 
 Constants.KeyName_charge + doxie.Version_SuperKey + '::charge');
	 	
End;
	