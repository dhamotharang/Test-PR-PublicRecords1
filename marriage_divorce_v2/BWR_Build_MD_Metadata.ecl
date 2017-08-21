









// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import marriage_divorce_v2;
import text_search;

export BWR_Build_MD_Metadata(string filename) := 

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400', 'MD', filename);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
keyType := Text_search.Types.SegmentType.ExternalKey;
groupType := Text_Search.Types.SegmentType.GroupSeg;

// add stuff


segmentMetaData := DATASET([
		{'TYPE',					textType,		[1]},
		{'GROOM-NAME',				textType,		[2]},
		{'HUSBAND-NAME',			textType,		[3]},
		{'GROOM-DT-BIRTH',			dateType,		[4]},
		{'HUSBAND-DT-BIRTH',		dateType,		[5]},
		{'GROOM-ST-BIRTH',			textType,		[6]},
		{'HUSBAND-ST-BIRTH',		textType,		[7]},
		{'GROOM-AGE',				textType,		[8]},
		{'HUSBAND-AGE',				textType,		[9]},
		{'GROOM-ADDRESS',			textType,		[10]},
		{'HUSBAND-ADDRESS',			textType,		[11]},
		
		{'GROOM-MAR-STATUS',		textType,		[12]},
		{'GROOM-MAR-HIST',			textType,		[13]},
		{'BRIDE-NAME',				textType,		[14]},
		{'WIFE-NAME',				textType,		[15]},
		{'BRIDE-MAIDEN',			textType,		[16]},
		{'WIFE-MAIDEN',				textType,		[17]},		
		{'BRIDE-DT-BIRTH',			dateType,		[18]},
		{'WIFE-DT-BIRTH',			dateType,		[19]},
		{'BRIDE-ST-BIRTH',			textType,		[20]},
		{'WIFE-ST-BIRTH',			textType,		[21]},
		{'BRIDE-AGE',				textType,		[22]},
		{'WIFE-AGE',				textType,		[23]},
		{'BRIDE-ADDRESS',			textType,		[24]},
		{'WIFE-RESIDES',		 	textType,		[25]},
		{'BRIDE-MAR-STATUS',		textType,		[26]},		
		{'WIFE-MAR-STATUS',			textType,		[27]},
		
		{'BRIDE-MAR-HIST',			textType,		[28]},
		{'WIFE-MAR-HIST',			textType,		[29]},
		{'REASON',					textType,		[30]},
		{'MARRIAGE-DATE',			dateType,		[31]},
		{'ISSUING-COUNTY',			textType,		[32]},
		{'ISSUING-CITY',			textType,		[33]},
		{'MARRIAGE-STATE',			textType,		[34]},
		{'TYPE-CEREMONY',			textType,		[35]},
		{'CERT-NUMBER',				textType,		[36]},
		{'FINAL-DATE',		 		dateType,		[37]},
		{'NBR-OF-MINORS',			textType,		[38]},
		// Additional 4 segments
		{'PLAINTIFF', texttype, [39]},
		{'DEFENDANT', texttype, [40]},
		{'PETITIONER', texttype, [41]},
		{'RESPONDENT', texttype, [42]},
		////////
		{'NAME',					textType,		[43]},
		{'ADDRESS',					textType,		[45]},
		{'COUNTY',					textType,		[46]},
		{'NUMBER',					TextType,		[47]},
		//////// Cheri's request
		{'Jurisdiction', Texttype, [48]},
		{'DOB', Grouptype, [4,5,18,19]},
		{'FILING-DATE', Grouptype, [31,37]},
		{'DATE', GroupType,		[4,5,18,19,31,37]},
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