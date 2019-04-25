EXPORT FMAC_GetProportions_10(ds1_history) := FUNCTIONMACRO
// IMPORT Scoring_DistributionTrends.Constants as C;

		// filename := filename_in + date1 + C.FileTag;
		// ds := dataset(filename,layout,thor);
		// dsAddDate := PROJECT(ds,transform(L.min_Scores_layout,self.date:=date_f;self.score:= left.#expand(mname_in);;self:=left;self:=[];));

	L.bins_layout intoBins(L.min_Scores_layout le) := TRANSFORM
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
									 (integer)le.score = 20 =>'20' , 
									 (integer)le.score = 30 =>'30' , 
									 (integer)le.score = 40 =>'40' , 
									 (integer)le.score = 50 =>'50' , 
									 (integer)le.score = 200 =>'200' , 
									 (integer)le.score = 210 =>'210' , 
									 (integer)le.score = 222 =>'222' , 
									 (integer)le.score = 300 =>'300' , 
								   (integer)le.score BETWEEN 301 AND 310 =>'301-310', 
									 (integer)le.score BETWEEN 311 AND 320 =>'311-320', 
									 (integer)le.score BETWEEN 321 AND 330 =>'321-330', 
									 (integer)le.score BETWEEN 331 AND 340 =>'331-340', 
									 (integer)le.score BETWEEN 341 AND 350 =>'341-350', 
									 (integer)le.score BETWEEN 351 AND 360 =>'351-360', 
									 (integer)le.score BETWEEN 361 AND 370 =>'361-370', 
									 (integer)le.score BETWEEN 371 AND 380 =>'371-380', 
									 (integer)le.score BETWEEN 381 AND 390 =>'381-390', 
									 (integer)le.score BETWEEN 391 AND 400 =>'391-400', 
									 (integer)le.score BETWEEN 401 AND 410 =>'401-410', 
									 (integer)le.score BETWEEN 411 AND 420 =>'411-420', 
									 (integer)le.score BETWEEN 421 AND 430 =>'421-430', 
									 (integer)le.score BETWEEN 431 AND 440 =>'431-440', 
									 (integer)le.score BETWEEN 441 AND 450 =>'441-450', 
									 (integer)le.score BETWEEN 451 AND 460 =>'451-460', 
									 (integer)le.score BETWEEN 461 AND 470 =>'461-470', 
									 (integer)le.score BETWEEN 471 AND 480 =>'471-480', 
									 (integer)le.score BETWEEN 481 AND 490 =>'481-490', 
									 (integer)le.score BETWEEN 491 AND 500 =>'491-500', 
									 (integer)le.score BETWEEN 501 AND 510 =>'501-510', 
									 (integer)le.score BETWEEN 511 AND 520 =>'511-520', 
									 (integer)le.score BETWEEN 521 AND 530 =>'521-530', 
									 (integer)le.score BETWEEN 531 AND 540 =>'531-540', 
									 (integer)le.score BETWEEN 541 AND 550 =>'541-550', 
									 (integer)le.score BETWEEN 551 AND 560 =>'551-560', 
									 (integer)le.score BETWEEN 561 AND 570 =>'561-570', 
									 (integer)le.score BETWEEN 571 AND 580 =>'571-580', 
									 (integer)le.score BETWEEN 581 AND 590 =>'581-590', 
									 (integer)le.score BETWEEN 591 AND 600 =>'591-600', 
									 (integer)le.score BETWEEN 601 AND 610 =>'601-610', 
									 (integer)le.score BETWEEN 611 AND 620 =>'611-620', 
									 (integer)le.score BETWEEN 621 AND 630 =>'621-630', 
									 (integer)le.score BETWEEN 631 AND 640 =>'631-640', 
									 (integer)le.score BETWEEN 641 AND 650 =>'641-650', 
									 (integer)le.score BETWEEN 651 AND 660 =>'651-660', 
									 (integer)le.score BETWEEN 661 AND 670 =>'661-670', 
									 (integer)le.score BETWEEN 671 AND 680 =>'671-680', 
									 (integer)le.score BETWEEN 681 AND 690 =>'681-690', 
									 (integer)le.score BETWEEN 691 AND 700 =>'691-700', 
									 (integer)le.score BETWEEN 701 AND 710 =>'701-710', 
									 (integer)le.score BETWEEN 711 AND 720 =>'711-720', 
									 (integer)le.score BETWEEN 721 AND 730 =>'721-730', 
									 (integer)le.score BETWEEN 731 AND 740 =>'731-740', 
									 (integer)le.score BETWEEN 741 AND 750 =>'741-750', 
									 (integer)le.score BETWEEN 751 AND 760 =>'751-760', 
									 (integer)le.score BETWEEN 761 AND 770 =>'761-770', 
									 (integer)le.score BETWEEN 771 AND 780 =>'771-780', 
									 (integer)le.score BETWEEN 781 AND 790 =>'781-790', 
									 (integer)le.score BETWEEN 791 AND 800 =>'791-800', 
									 (integer)le.score BETWEEN 801 AND 810 =>'801-810', 
									 (integer)le.score BETWEEN 811 AND 820 =>'811-820', 
									 (integer)le.score BETWEEN 821 AND 830 =>'821-830', 
									 (integer)le.score BETWEEN 831 AND 840 =>'831-840', 
									 (integer)le.score BETWEEN 841 AND 850 =>'841-850', 
									 (integer)le.score BETWEEN 851 AND 860 =>'851-860', 
									 (integer)le.score BETWEEN 861 AND 870 =>'861-870', 
									 (integer)le.score BETWEEN 871 AND 880 =>'871-880', 
									 (integer)le.score BETWEEN 881 AND 890 =>'881-890', 
									 (integer)le.score BETWEEN 891 AND 900 =>'891-900', 
									 (integer)le.score BETWEEN 901 AND 910 =>'901-910', 
									 (integer)le.score BETWEEN 911 AND 920 =>'911-920', 
									 (integer)le.score BETWEEN 921 AND 930 =>'921-930', 
									 (integer)le.score BETWEEN 931 AND 940 =>'931-940', 
									 (integer)le.score BETWEEN 941 AND 950 =>'941-950', 
									 (integer)le.score BETWEEN 951 AND 960 =>'951-960', 
									 (integer)le.score BETWEEN 961 AND 970 =>'961-970', 
									 (integer)le.score BETWEEN 971 AND 980 =>'971-980', 
									 (integer)le.score BETWEEN 981 AND 990 =>'981-990', 
									 (integer)le.score BETWEEN 991 AND 999 =>'991-999', 
								'UNDEFINED');
		self := le; 	
		self := [];
	END;
	dsBins_1 := SORT(PROJECT(ds1_history,intoBins(left)),Date,Bins);
	
	//Calculate Bins Frequency
	bins_freq_layout := RECORD
		dsBins_1.Date;
		dsBins_1.Bins;
		Frequency := COUNT(GROUP);
		Proportion := 0; 
	END;
	dsBins := TABLE(dsBins_1,bins_freq_layout,date,bins);
	
	//Calculate TotalCnt of samples for each day
	totalCnt_layout := RECORD
		dsBins_1.Date;
		TotalCnt := COUNT(GROUP)
	END;
	dsTotalCnt := TABLE(dsBins_1,totalCnt_layout,date);
	
	//Join to get Proportions
	dsJoin := JOIN(dsBins,dsTotalCnt,left.Date=right.Date,TRANSFORM(L.bins_freq_layout,self.Date:=left.Date,self.Bins:=left.Bins,self.Frequency:=left.Frequency,self.Proportion:=(left.Frequency)/(right.TotalCnt)));
	
	RETURN dsJoin;

ENDMACRO;