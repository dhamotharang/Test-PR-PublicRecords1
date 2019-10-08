lXMLTag	:=	'PFA/Records/Entity';
EXPORT File_Entity := DISTRIBUTE(												
							dataset(File_DJ, DowJones.Layouts.rEntities, xml(lXMLTag)),
							(integer)id) : PERSIST('~thor::dowjones::entities');