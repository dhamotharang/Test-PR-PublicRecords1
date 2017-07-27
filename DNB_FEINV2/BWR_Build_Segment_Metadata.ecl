import DNB_FEINV2;
import text_search;

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'FEINV2', filedate);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;





segmentMetaData := DATASET([
		{'CompanyName',					textType,		[1]},
		{'FEIN',						textType,		[2]},
		{'source_duns_number',			textType,		[3]},
		{'duns_number',					textType,		[4]},
		{'Address_1',					textType,		[5]},
		{'Address_2',					textType,		[6]},
		{'city',						textType,		[7]},
		{'state',						textType,		[8]},
		{'zip5',						textType,		[9]},
		{'zip4',						textType,		[10]},
		{'address',						TextType,		[11]}

		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										);

return retval;

end;
