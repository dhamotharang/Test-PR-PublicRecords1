import business_header,doxie;


export get_BDIDs(boolean forceLocal = false,boolean nofail=false,boolean use_exec_search = true,boolean score_results=TRUE) := 
FUNCTION

bdids := business_header.doxie_get_bdids(forceLocal,nofail,use_exec_search,score_results);
Doxie.Layout_ref_bdid tra(bdids l) := transform
	self := l;
end;

ret := project(bdids, tra(left));
return ret;

END;