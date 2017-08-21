













// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import FBNV2;
import text_search;

export BWR_Build_FBN_Metadata(string filename) := 

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'FBN', filename);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
keyType := Text_search.Types.SegmentType.ExternalKey;

// add stuff


segmentMetaData := DATASET([
		{'JURISDICTION',					textType,		[1]},
		{'FILING-NUMBER',					textType,		[2]},
		{'FILING-DATE',						dateType,		[3]},
		{'FILING-TYPE',						textType,		[4]},
		{'EXPIRATION-DATE',					dateType,		[5]},
		{'CANCEL-DATE',						dateType,		[6]},
		
		{'DBA-NAME',						textType,		[7]},
		{'COMMENCE-DATE',					dateType,		[8]},
		{'BUSINESS-STATUS',					textType,		[9]},
		{'FEIN',							textType,		[10]},
		{'BUSINESS-PHONE',					textType,		[11]},
		{'SIC',								textType,		[12]},
		{'BUS-TYPE',						textType,		[13]},
		
		{'BUSINESS-ADDRESS',				textType,		[14]},
	//	{'CITY',							textType,		[15]},
	//	{'COUNTY',							textType,		[16]},
	//	{'STATE',							textType,		[17]},		
	//	{'ZIP',								textType,		[18]},
		{'COUNTRY',							textType,		[19]},
		{'MAILING-ADDRESS',					textType,		[20]},
		
		{'OWNER',							textType,		[21]},
		{'OWNER-STATUS',					textType,		[22]},
		{'CONTACT-PHONE',					textType,		[23]},
		{'OWNER-ADDRESS',					textType,		[24]},
		{'CHARTER-NUMBER',				 	textType,		[25]},
		{'WITHDRAWL-DATE',					dateType,		[26]},		
		
		{'NUMBER',							textType,		[27]},
		{'DATE',							dateType,		[28]},
		{'TYPE',							textType,		[29]},
		{'NAME',							textType,		[30]},
		{'STATUS',							textType,		[31]},
		{'TELEPHONE',						textType,		[32]},
		{'ADDRESS',							textType,		[33]},
		{'EXTERNALKEY',       keyType, [250]}			

		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);


stuff := if (fileservices.fileexists(lfilename),
								output('Metadata file '+lfilename+' already exists'),
								sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										)
							);

return stuff;

end;