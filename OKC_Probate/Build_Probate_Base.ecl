IMPORT OKC_Probate,header, ut, PromoteSupers,Scrubs, address, STD;

EXPORT Build_Probate_Base(STRING	pVersion	=	(STRING)STD.Date.Today()) := FUNCTION

	//OKC_Probate input file 
	ds_probate_in := OKC_Probate.File_Probate_Clean_in(pVersion);

	//clean names
	ds_clnName := OKC_Probate.fClean_Name(ds_probate_in);
	//clean address
	ds_clnAddr := OKC_Probate.fClean_Address(ds_clnName);


	OKC_Probate.layout.base_raw cleanFields(ds_clnAddr l) := TRANSFORM
		SELF.name_score		:=	(STRING)0;
		SELF := L;
		SELF := [];
	END;

	dsClean				:=	project(ds_clnAddr,cleanFields(left));

	ds_Probate_base_in := OKC_Probate.Files().file_base;
	ds_Probate_base	   := ds_Probate_base_in + dsClean;

	RETURN ds_Probate_base;

END;