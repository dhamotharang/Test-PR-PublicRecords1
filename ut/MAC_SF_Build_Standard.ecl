export MAC_SF_Build_standard(pDataset
							,pBasename
							,pSeq_name
							,pVersion		= '\'\''
							,pCompress	= 'true'
							,pCsvout 		= 'false'
							,pNumGen		= '1'
							) := 
macro
	import tools;
  
  pSeq_name := tools.MAC_SF_Build_standard(pDataset,pBasename,pVersion,pCompress,pCsvout,pNumGen)  : DEPRECATED('Use tools.MAC_SF_Build_standard instead');

endmacro;