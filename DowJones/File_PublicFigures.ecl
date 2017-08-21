lXMLTag	:=	'PFA/Associations/PublicFigure';

EXPORT File_PublicFigures	:=	//IF(CLUSTERSIZE=1,
														//dataset(File_DJ, Layouts.rPublicFigures, xml(lXMLTag));
									DISTRIBUTE(
												dataset(File_DJ, Layouts.rPublicFigure, xml(lXMLTag)),
												(integer)id) : PERSIST('~thor::dowjones::publicfigures');
