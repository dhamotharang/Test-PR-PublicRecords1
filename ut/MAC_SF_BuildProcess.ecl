export	MAC_SF_BuildProcess(	thedataset,
															basename,
															seq_name,
															numgenerations = '3',
															csvout = 'false',
															pCompress = 'false',
															pVersion	=	'\'\'',
															pSeparator	=	'\',\''
														)	:=
macro
import PromoteSupers;
PromoteSupers.Mac_SF_BuildProcess(	thedataset,
															basename,
															seq_name,
															numgenerations,
															csvout,
															pCompress,
															pVersion,
															pSeparator	
														) ;
endmacro  : DEPRECATED('use PromoteSupers.MAC_SF_BuildProcess instead');