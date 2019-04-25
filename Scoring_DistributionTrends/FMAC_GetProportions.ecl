﻿EXPORT FMAC_GetProportions(totalCnt) := FUNCTIONMACRO
	L.bins_layout intoBins(L.min_Scores_layout le) := TRANSFORM
	self.Total := totalCnt;
	self.Bins := map((integer)le.score = 0 =>'0' , 
									 (integer)le.score = 1 =>'1' , 
									 (integer)le.score = 2 =>'2' , 
									 (integer)le.score = 3 =>'3' , 
									 (integer)le.score = 4 =>'4' , 
									 (integer)le.score = 5 =>'5' , 
									 (integer)le.score = 6 =>'6' , 
									 (integer)le.score = 7 =>'7' , 
									 (integer)le.score = 8 =>'8' , 
									 (integer)le.score = 9 =>'9' , 
									 (integer)le.score = 10 =>'10' , 
									 (integer)le.score = 11 =>'11' , 
									 (integer)le.score = 12 =>'12' , 
									 (integer)le.score = 200 =>'200' , 
									 (integer)le.score = 210 =>'210' , 
									 (integer)le.score = 222 =>'222' , 
									 (integer)le.score = 300 =>'300' , 
									 (integer)le.score BETWEEN 301 AND 350 =>'301-350', 
									 (integer)le.score BETWEEN 351 AND 400 =>'351-400', 
									 (integer)le.score BETWEEN 401 AND 450 =>'401-450', 
									 (integer)le.score BETWEEN 451 AND 500 =>'451-500', 
									 (integer)le.score BETWEEN 501 AND 550 =>'501-550', 
									 (integer)le.score BETWEEN 551 AND 600 =>'551-600', 
									 (integer)le.score BETWEEN 601 AND 650 =>'601-650', 
									 (integer)le.score BETWEEN 651 AND 700 =>'651-700', 
									 (integer)le.score BETWEEN 701 AND 750 =>'701-750', 
									 (integer)le.score BETWEEN 751 AND 800 =>'751-800', 
									 (integer)le.score BETWEEN 801 AND 850 =>'801-850', 
									 (integer)le.score BETWEEN 851 AND 900 =>'851-900', 
									 (integer)le.score BETWEEN 901 AND 950 =>'901-950', 
									 (integer)le.score BETWEEN 951 AND 999 =>'951-999', 
								'UNDEFINED');
		self := le; 	
		self := [];
	END;
	ds50Bins_1 := SORT(PROJECT(ds,intoBins(left)),Date,Bins);

	bins_freq_layout := RECORD
		ds50Bins_1.Date;
		ds50Bins_1.Bins;
		Frequency := COUNT(GROUP);
		Proportion := COUNT(GROUP)/ds50Bins_1.Total; 
	END;
	ds50Bins := TABLE(ds50Bins_1,bins_freq_layout,date,bins);
	
	RETURN ds50Bins;

ENDMACRO;