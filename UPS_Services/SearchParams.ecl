IMPORT iesp;

export SearchParams := INTERFACE
	export iesp.share.t_NameAndCompany nameQueryInputs;
	export iesp.share.t_Address        addrQueryInputs;
	export STRING10                    phoneQueryInput;
END;
