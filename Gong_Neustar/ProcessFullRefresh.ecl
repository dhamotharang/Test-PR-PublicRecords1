import	ut;

EXPORT ProcessFullRefresh(dataset(layout_Neustar) fullRefresh,string rundate = ut.Now()) := function


	pre := PreprocessFullRefresh(fullRefresh, rundate);
	
	mstr := ProcessAdds(pre, rundate);
	
	return mstr;

end;