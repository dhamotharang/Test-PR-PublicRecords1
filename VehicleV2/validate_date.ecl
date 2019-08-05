export validate_date := module

export string8 fEarliestNonZeroDate(string pDate1, string pDate2) := function 
 string8 earliestdate := if((unsigned8)pDate1 = 0, pDate2, if((unsigned8)pDate2 = 0, pDate1,	if(pDate1 < pDate2,	pDate1, pDate2)));

 return earliestdate;

end;


export string8	fLatestNonZeroDate(string pDate1, string pDate2) := function
  string8 latestdate := if((unsigned8)pDate1 = 0,	pDate2, if((unsigned8)pDate2 = 0,	pDate1,	if(pDate1 > pDate2, pDate1, pDate2)));

	return latestdate;

end;

end;