lXMLTag	:=	'PFA/Records/Entity';
EXPORT File_Entity := //IF(CLUSTERSIZE=1,
											//	dataset(File_DJ, DowJones.Layouts.rEntities, xml(lXMLTag)),
										DISTRIBUTE(												
												dataset(File_DJ, DowJones.Layouts.rEntities, xml(lXMLTag)),
										(integer)id) : PERSIST('~thor::dowjones::entities');
