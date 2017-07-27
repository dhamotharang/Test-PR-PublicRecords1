import ut;
export Bus_Thor(

	boolean pUseProd = false

) := 

	if(pUseProd 
		,business_header.foreign_prod + 'thor_data400::'
		,'~thor_data400::'
	);
