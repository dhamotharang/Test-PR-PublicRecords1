//////////////////////////////////////////////////////////////////////////////////////////////
// -- Local value types for input files
//////////////////////////////////////////////////////////////////////////////////////////////
header_in 	:= File_Header_In;
header_base 	:= File_Header_Base;
es_in 		:= File_Executive_Summary_In;
es_base 		:= File_Executive_Summary_Base;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Header Segment Counts
//////////////////////////////////////////////////////////////////////////////////////////////
header_in_records 	:= output('Total EBR Header In Records: ' 			+ count(header_in));
header_base_records := output('Total EBR Header Base Records: ' 			+ count(header_base));
header_base_bdids 	:= output('Total EBR Header Base Records w/BDID: ' 	+ count(header_base(bdid != 0)));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Executive Summary Segment Counts
//////////////////////////////////////////////////////////////////////////////////////////////
executive_summary_in_records 	 := output('Total EBR Executive Summary In Records: ' 		   + count(es_in));
executive_summary_base_records := output('Total EBR Executive Summary Base Records: ' 	   + count(es_base));
executive_summary_base_bdids 	 := output('Total EBR Executive Summary Base Records w/BDID: ' + count(es_base(bdid != 0)));

export Query_BDID_Stats := parallel(
	 header_in_records
	,header_base_records
	,header_base_bdids
	,executive_summary_in_records
	,executive_summary_base_records
	,executive_summary_base_bdids
);