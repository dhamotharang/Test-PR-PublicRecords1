lXMLTag	:=	'PFA/Associations/SpecialEntity';

EXPORT File_SpecialEntity	:=	//IF(CLUSTERSIZE=1,
														//dataset(File_DJ, Layouts.rPublicFigure, xml(lXMLTag)),
									DISTRIBUTE(
												dataset(File_DJ, Layouts.rPublicFigure, xml(lXMLTag)),
												(integer)id) : PERSIST('~thor::dowjones::specialentities');
