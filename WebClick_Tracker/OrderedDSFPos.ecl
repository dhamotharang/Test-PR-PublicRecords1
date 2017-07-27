
/*
export OrderedDSFPos:=dataset('~thor_data50::temp::webclick:OrderedDS_test',
		{recordof(OrderedDS),UNSIGNED8 __fpos {virtual(fileposition)}},flat);
		// :persist('~thor_data50::persist::orudenko::OrderedDSFPos_test');
*/


// export OrderedDSFPos:=dataset('~thor_data400::base::webclick::qa::access_log',
		// Layout_OrderDSFpos,thor);

export OrderedDSFPos_full:=dataset('~thor_data400::base::webclick::qa::access_log',
		Layout_OrderDSFpos,thor);
		
dist_OrderedDSFPos_full :=distribute(OrderedDSFPos_full,hash32(date_accessed));
srt_OrderedDSFPos_full := sort(OrderedDSFPos_full,date_accessed,local);
date_max := (unsigned6) max(srt_OrderedDSFPos_full,date_accessed);

integer4 y := (unsigned6) date_max/10000;
integer2 m := (unsigned6) (date_max/100)%100;
integer2 d := (unsigned6) (date_max)%100;

integer ddiff := if(d<=15,6,5);  //6 months worth of data for building keys
date_6m:=(integer8)(if (m-ddiff <1,((string)(y-1) + (string) intformat((m-ddiff+12),2,1) + '01'),(string)y + (string)intformat((m-ddiff),2,1) + '01'));

// export OrderedDSFPos:=OrderedDSFPos_full(date_accessed>=date_6m and date_accessed <=date_max);		
export OrderedDSFPos:=srt_OrderedDSFPos_full(date_accessed>=date_6m): PERSIST('persist::webclick_Tracker_6MonthData');		