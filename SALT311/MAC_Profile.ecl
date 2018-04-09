EXPORT MAC_Profile(inFile,id_field='',src_field='',CorrelateSampleSize=100000000,out_prefix='',maxFieldCorr=50) := MACRO
	SALT311.MOD_Profile(inFile,id_field,src_field,CorrelateSampleSize,out_prefix,maxFieldCorr).out;
ENDMACRO;
