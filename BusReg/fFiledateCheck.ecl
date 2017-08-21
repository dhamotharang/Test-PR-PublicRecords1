export fFiledateCheck(

	 dataset(Layouts.Base.AID)	pDataset
	,real												pThreshold = 90.0

) :=
function

	countAll := count(pDataset);
	
	countGoodFiledates := count(pDataset(clean_dates.file_date != 0));
	
	percentgoodfiledates := (real)countGoodFiledates / (real)countAll * 100;
	
	returnresult := if(percentgoodfiledates > pThreshold, true, false);

	return returnresult;
	
end;