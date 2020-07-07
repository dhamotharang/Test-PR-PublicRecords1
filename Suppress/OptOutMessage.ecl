EXPORT OptOutMessage(datatype) := FUNCTIONMACRO
	RETURN MAP(datatype = 'STRING' => '',
												datatype = 'INTEGER' => '0',
												datatype = 'BOOLEAN' => '',
												'');
ENDMACRO;