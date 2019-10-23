export Copy_Keys() := functionmacro
	go := parallel(
	   output('Test Call from Alpha');
	);
	
	return go;
endmacro;