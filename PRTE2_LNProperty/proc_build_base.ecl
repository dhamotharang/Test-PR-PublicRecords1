IMPORT PRTE2_LNProperty;

EXPORT Proc_Build_Base(string filedate) := FUNCTION

	Build_Deed_Tax_Base1	:=	PRTE2_LNProperty.Build_Deed_Tax_Base(filedate);
	
	Build_Search1	:=	PRTE2_LNProperty.Build_Search(filedate);

	return_val := 	sequential(Build_Deed_Tax_Base1, Build_Search1);
	
	return return_val;

END;