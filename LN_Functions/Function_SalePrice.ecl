export Function_SalePrice(string pStringIn, integer pLength) :=
     if(stringlib.stringfind(pStringIn,'(',1)!=0,
      LN_Functions.Function_ReformatCurrency(trim(pStringIn[1..stringlib.stringfind(pStringIn,'(',1)-1],left,right),10),
	 LN_Functions.Function_ReformatCurrency(trim(pStringIn,left,right),10));