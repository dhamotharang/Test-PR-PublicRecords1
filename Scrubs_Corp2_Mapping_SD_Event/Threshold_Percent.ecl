export Threshold_Percent := module

		//The max THRESHOLD percent that the input data is validated against.
		//When this percentage is exceeded, the input data will not be processed
		//because the mapper will NOT move the input data into the sprayed 
		//superfile.

		export corp_key										 					:= 0;
		export corp_sos_charter_nbr 	 							:= 0;
		export event_filing_cd 						 					:= 90;

end;