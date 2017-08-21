import InfoUSA;
import text_search;

export BWR_Build_DEDCO_Metadata(string filedate) := 

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'DEADCO', filedate);


						
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
		{'telephone',						textType,		[13]},
		{'sic',								textType,		[14]},
		{'franchise',						textType,		[15]},
		{'ad-size',							textType,		[16]},
		{'population',						textType,		[17]},
		{'year-started',					textType,		[18]},
		{'contact-name',					textType,		[19]},
		{'contact-title',					textType,		[20]},
		{'gender',		 					textType,		[21]},
		{'employees',						textType,		[22]},		
		
		
		{'sales',							textType,		[23]},
		{'industry',						textType,		[24]},
		{'status',							textType,		[25]},
		{'fax',								textType,		[26]},
		{'office-size',						textType,		[27]},
		{'production-date',					DateType,		[28]},
		{'abi-no',							textType,		[29]},
		{'subsidiary-no',					textType,		[30]},
		{'ultimate-no',		 				textType,		[31]},
		{'pri-sic',							textType,		[32]},
		
		{'2nd-sic',							textType,		[33]},
		{'total-sales',						textType,		[34]},
		{'business-type',					textType,		[35]},
		{'exchange',						textType,		[36]},
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