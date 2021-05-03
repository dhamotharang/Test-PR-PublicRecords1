IMPORT Scrubs;
	
EXPORT Functions := MODULE

  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers and length in [0,4,9]
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr) := FUNCTION
	 integer size  :=length(trim(nmbr,all));
					 vsize :=if(size in [0,4,9],true,false);
    RETURN if(vsize ,Scrubs.Functions.fn_numeric(nmbr, size),0);
  END;
	
END;