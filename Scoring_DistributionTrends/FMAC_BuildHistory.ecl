EXPORT FMAC_BuildHistory(filename_in , layout, mname_in ,date_f) := FUNCTIONMACRO
IMPORT Scoring_DistributionTrends.Constants as C;
		filename3 := filename_in + date_f + C.FileTag;

getData(string date1) := function   //Change the score field name in transform and FCRA/NonFCRA	
		filename := filename_in + date1 + C.FileTag;
		ds := dataset(filename,layout,thor);
		dsAddDate := PROJECT(ds,transform(L.min_Scores_layout,self.date:=date1;self.score:= left.#expand(mname_in);;self:=left;self:=[];));
		return dsAddDate;
End;	 

test := if(STD.File.FileExists(filename3),getData(date_f));


return test;
ENDMACRO;



