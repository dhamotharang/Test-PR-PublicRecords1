lXMLTag	:=	'PFA/Records/Person';
EXPORT File_Person := //IF(CLUSTERSIZE=1,
											//			dataset(File_DJ, Layouts.rPersons, xml(lXMLTag)),
										DISTRIBUTE(												
														dataset(File_DJ, Layouts.rPersons, xml(lXMLTag)),
										(integer)id) : PERSIST('~thor::dowjones::persons');
