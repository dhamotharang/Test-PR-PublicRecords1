import vehiclev2,text_search;

export BWR_Build_Segment_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'VEHICLEV2', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

segmentMetaData := DATASET([
		{'jurisdiction',											textType,		[1]},
		{'vin',										textType,		[2]},
		{'model-year',								textType,		[3]},
		{'manufacturer',								textType,		[4]},
		{'veh-class-desc',												textType,		[5]},
		{'vehicle-series',												TextType,		[6]},
		{'model',						textType,		[7]},
		{'body-style',					textType,		[8]},
		{'color',									textType,		[9]},
		{'vehicle-weight',							numericType,		[10]},
		{'owner',										textType,		[11]},
		{'owner-dob',										DateType,		[12]},
		{'owner-address', 			textType,		[13]},
		{'plate-number',			textType,		[14]},
		{'plate-state',												textType,		[15]},
		{'plate-type',		textType,		[16]},
		{'prev-plate-number',		textType,		[17]},
		{'prev-plate-state',									textType,		[18]},
		{'regist-date-orig',			DateType,		[19]},
		{'registration-date', 									dateType,		[20]},
		{'expiration-date', 									dateType,		[21]},
		{'regist-decal-no',										textType,		[22]},
		{'status',										textType,		[23]},
		{'registrant',											textType,		[24]},
		{'registrant-dob',											DateType,		[25]},
		{'registrant-address',											textType,		[26]},
		{'title-number',											TextType,		[27]},
		{'title-date-orig',											DateType,		[28]},
		{'title-trans-date',											DateType,		[29]},
		{'lienholder',											TextType,		[30]},
		{'lh-mail-address',											TextType,		[31]},
		{'lessor',										textType,		[32]},
		{'lessor-dob',										DateType,		[33]},
		{'lessor-address', 			textType,		[34]},
		{'lessee',											textType,		[35]},
		{'lessee-dob',											DateType,		[36]},
		{'lessee-address',											textType,		[37]},
		{'name', 			ConcatSeg, [11,24,30,32,35]},
		{'address',		ConcatSeg, [13,26,31,34,37]},
		{'number', GroupType, [2,14,17,22,27]},
		{'date', GroupType, [12,19,20,21,25,28,29,33,36]},
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