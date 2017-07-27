export str_bid_Autokey := module
export Name :='~thor_data400::key::'+ liensv2.str_SegmentName +'::autokey::bid::';
export LogicalName(string filedate) := '~thor_data400::key::'+ liensv2.str_SegmentName +'::'+filedate+'::autokey::bid::';
									
end;