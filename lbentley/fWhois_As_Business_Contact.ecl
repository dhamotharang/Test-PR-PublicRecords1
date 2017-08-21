IMPORT lbentley_trash;

export fWhois_As_Business_Contact(

	dataset(lbentley_trash.layout_bus	) pBH_File		= lbentley_trash.Files.business_headers

) :=
function

	return pBH_File;
	
end;