//////////////////////////////////////////////////////////////////////////////////////////////
// -- Table of current Experian Business Header segment codes
//////////////////////////////////////////////////////////////////////////////////////////////
Segment_Codes_temp := DATASET([
{'0010', '', sizeof(Layout_Header_In),sizeof(Layout_Header_Base)},
{'1000', '', sizeof(Layout_Executive_Summary_In), sizeof(Layout_Executive_Summary_Base)},
{'2000', ''},
{'2010', ''},
{'2015', ''},
{'2020', ''},
{'2025', ''},
{'4010', ''},
{'4020', ''},
{'4030', ''},
{'4035', ''},
{'4040', ''},
{'4500', ''},
{'4510', ''},
{'5000', ''},
{'5600', ''},
{'5610', ''},
{'6000', ''},
{'6500', ''},
{'6510', ''},
{'7000', ''},
{'7010', ''}
], Layout_Segment_Codes);

Layout_Segment_Codes getfilenames(Segment_Codes_temp l) := 
transform
	self.code 			:= l.code;
	self.description		:= decode_segments(l.code);
	self.filename_in 		:= GetSegmentFileName_In(l.code);
	self.filename_base 		:= getSegmentFileName_Base(l.code);
	self.keyname_bdid 		:= GetSegmentKeyName_BDID(l.code);
	self.keyname_file_number	:= GetSegmentKeyName_FILE_NUMBER(l.code);
	self := l;
end;

export Segment_Codes := project(Segment_Codes_temp, getfilenames(left));// : persist(EBR_Thor + 'TEMP::' + dataset_name + '_Segment_Codes');