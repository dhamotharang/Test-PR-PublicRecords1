import DriversV2,text_search;

export BWR_Build_Segment_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'DLV2', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;
ssnType := Text_search.Types.SegmentType.SSN;

segmentMetaData := DATASET([
		{'name',											textType,		[1]},
		{'address',										textType,		[2]},
		//{'city-address',								textType,		[3]},
		//{'state-address',								textType,		[4]},
		//{'zip-address',												textType,		[5]},
		{'country',												TextType,		[6]},
		{'province',						textType,		[7]},
		//{'postal-code',					textType,		[8]},
		{'dob',									DateType,		[9]},
		//{'dod',							DateType,		[10]},
		{'ssn',										ssnType,		[11]},
		//{'age',										textType,		[12]},
		{'height', 			textType,		[13]},
		{'hair-color',			textType,		[14]},
		{'eye-color',												textType,		[15]},
		{'weight',		textType,		[16]},
		{'gender',		textType,		[17]},
		{'license-state',									textType,		[18]},
		{'license-class',			textType,		[19]},
		{'license-type', 									textType,		[20]},
		{'restrictions',										textType,		[21]},
		{'expire-date',										DateType,		[22]},
		{'issue-date',											DateType,		[23]},
		//{'active-date',											DateType,		[24]},
		//{'inactive-date',											DateType,		[25]},
		{'endorsement',											TextType,		[26]},
		{'dl-number',											textType,		[27]},
		{'previous-dl-number',											TextType,		[28]},
		{'previous-st',											TextType,		[29]},
		//{'issuance',											TextType,		[30]},
		//{'old-dl-number',											TextType,		[31]},
		{'status',											TextType,		[32]},
		//{'date', 			GroupType, [9,10,22,23,24,25]},
		{'date', 			GroupType, [9,22,23]},
		{'number',		GroupType, [11,27,28]},
		{'EXTERNALKEY',       keyType, [250]}	
		
		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := if (fileservices.fileexists(lfilename),
								output('Metadata file '+lfilename+' already exists'),
								sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										)
							);
										
return retval;

end;