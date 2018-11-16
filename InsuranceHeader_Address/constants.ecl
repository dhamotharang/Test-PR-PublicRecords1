EXPORT Constants := MODULE
  // EXPORT SRGap        := 2;   //years between addresses to be considered possible outlier
	EXPORT MinPriorCnt  := 3;   //number of addresses to be considered prior cluster of address for outliers
	EXPORT NewWindow    := 730; //number of days that we will not look at same date same source for new address records;
	EXPORT CCGrace      := 30;  //number of days to consider CC policy still active
	EXPORT OutlierMinDt := 19970000; //Ignore outliers that precede this date if the zip4 is blank
	EXPORT AddrGap      := 1095; //number of days between addresses to consider splitting / also used for outliers
	EXPORT Year2000     := 20000101; //Do not do segmentation before this date
	// EXPORT AddrGap      := 9999999999; //number of years to consider split two addresses into individual segments
END;