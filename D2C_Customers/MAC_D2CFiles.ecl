EXPORT MAC_D2CFiles(mode, record_type, rec_layout) := FUNCTIONMACRO
   
   	sMode := D2C_Customers.Constants.sMode(mode);
	sFile := D2C_Customers.Constants.sFile(record_type);
	sFileName := '~thor_data400::output::d2c::' + sMode + '::' + sFile;


	out := distribute(dataset(sFileName,
 		           #EXPAND(rec_layout),
 		           CSV(SEPARATOR('|'),
				   TERMINATOR('\n'))
 		          ),
#if(record_type <> 4)				   
	hash(lexid));
#else
	hash(lexid1));
#end

	return out;
ENDMACRO;