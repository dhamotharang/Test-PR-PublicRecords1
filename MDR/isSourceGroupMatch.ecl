export isSourceGroupMatch(string2 le_src, string2 ri_src) :=  
     le_src = ri_src and 
     le_src not in mdr.Source_No_Mix and
	~mdr.Source_is_on_Probation(le_src) and
	~mdr.Source_is_on_Probation(ri_src);