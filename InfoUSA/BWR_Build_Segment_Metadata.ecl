import InfoUSA;
import text_search;

export bwr_build_segment_metadata(string filedate) := function
// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'ABIUS', filedate);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
keyType := Text_search.Types.SegmentType.ExternalKey;



segmentMetaData := DATASET([
		{'contact-name',					textType,		[1]},
		{'company-name',					textType,		[2]},
		{'name',							textType,		[3]},
		//{'city',							textType,		[4]},
		//{'state',							textType,		[5]},
		//{'zip5',							textType,		[6]},
		//{'zip4',							textType,		[7]},
		{'address',							textType,		[8]},
		//{'zip',								textType,		[9]},
		{'carrier-code',				 	textType,		[10]},
		{'state-code',						textType,		[11]},
		
		{'county',							textType,		[12]},
		{'sic',								textType,		[13]},
		{'franchise',						textType,		[14]},
		{'ad-size',							textType,		[15]},
		{'population',						textType,		[16]},
		{'year-started',					textType,		[17]},
		{'contact-name',					textType,		[18]},
		{'contact-title',					textType,		[19]},
		{'gender',		 					textType,		[20]},
		{'employees',						textType,		[21]},		
		
		
		{'sales',							textType,		[22]},
		{'industry',						textType,		[23]},
		{'status',							textType,		[24]},
		{'fax',								textType,		[25]},
		{'office-size',						textType,		[26]},
		{'production-date',					DateType,		[27]},
		{'abi-no',							textType,		[28]},
		{'subsidiary-no',					textType,		[29]},
		{'ultimate-no',		 				textType,		[30]},
		//{'pri-sic',							textType,		[31]},
		
		//{'2nd-sic',							textType,		[32]},
		{'total-sales',						textType,		[33]},
		{'business-type',					textType,		[34]},
		{'exchange',						textType,		[35]},
		{'credit',							textType,		[36]},
		{'telephone',							textType,		[37]},
		{'EXTERNALKEY',       keyType, [250]}	

		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										);

return retval;


end;