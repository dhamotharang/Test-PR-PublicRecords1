import VotersV2;
import text_search;

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'VOTERSV2', filedate);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;
ssnType := Text_search.Types.SegmentType.SSN;



segmentMetaData := DATASET([
		{'last_name',				textType,		[1]},
		{'first_name',				textType,		[2]},
		{'middle_name',				textType,		[3]},
		{'maiden_prior',			textType,		[4]},
		{'name',					textType,		[5]},
		
		


		{'dob',						DateType,		[6]},
		{'ageCat',					textType,		[7]},



		{'place_of_birth',			textType,		[8]},
		{'occupation',				textType,		[9]},
		{'maiden_name',				textType,		[10]},





		{'regDate',					DateType,		[11]},

		{'gender',					textType,		[12]},
		{'political_party',			textType,		[13]},


		{'phone', 					textType,		[14]},
		{'work_phone',				textType,		[15]},
		{'other_phone',				textType,		[16]},
		//{'telephone',				textType,		[17]},



		{'status',					textType,		[18]},


		//{'res_Addr',				textType,		[19]},
		//{'mail_Addr',				textType,		[20]},	
		{'address',					textType,		[21]},
		//{'city',	 				textType,		[22]},
		//{'state',					textType,		[23]},
		//{'zip',						textType,		[24]},
		{'county',					textType,		[25]},



		{'spec_dist1',				textType,		[26]},
		{'spec_dist2',				textType,		[27]},
		{'district',				textType,		[28]},
		
		{'precinct1',				textType,		[29]},
		{'precinct2',				textType,		[30]},
		{'precinct3',				textType,		[31]},
		{'precinct',				textType,		[32]},

		{'ward',					textType,		[33]},
		{'voter-history',			textType,		[34]},
		/*
		{'General2000',				textType,		[34]},
		{'PresPrimary2000',			textType,		[35]},
		{'Primary2000',				textType,		[36]},
		{'voter-history2000',		textType,		[37]},

		{'Primary2001',				textType,		[38]},
		{'General2001',				textType,		[39]},
		{'Special12001',			textType,		[40]},
		{'Other2001',				textType,		[41]},
		{'Special22001',			textType,		[42]},
		{'voter-history2001',		textType,		[43]},		

		{'Primary2002',				textType,		[44]},
		{'Special12002',			textType,		[45]},
		{'Other2002',				textType,		[46]},
		{'Special22002',			textType,		[47]},
		{'General2002',				textType,		[48]},
		{'voter-history2002',		textType,		[49]},		
		

		{'Primary2003',				textType,		[50]},
		{'Special12003',			textType,		[51]},
		{'Other2003',				textType,		[52]},
		{'Special22003',			textType,		[53]},
		{'General2003',				textType,		[54]},
		{'voter-history2003',		textType,		[55]},				

		{'Primary2004',				textType,		[56]},
		{'Special12004',			textType,		[57]},
		{'Other2004',				textType,		[58]},
		{'Special22004',			textType,		[59]},
		{'General2004',				textType,		[60]},
		{'PresPrimary2004',			textType,		[61]},
		{'voter-history2004',		textType,		[62]},		


		{'Primary2005',				textType,		[63]},
		{'Special12005',			textType,		[64]},
		{'Other2005',				textType,		[65]},
		{'Special22005',			textType,		[66]},
		{'General2005',				textType,		[67]},
		{'voter-history2005',		textType,		[68]},		


		{'Primary2006',				textType,		[69]},
		{'Special12006',			textType,		[70]},
		{'Other2006',				textType,		[71]},
		{'Special22006',			textType,		[72]},
		{'General2006',				textType,		[73]},
		{'voter-history2006',		textType,		[74]},

		{'Primary2007',				textType,		[75]},
		{'Special12007',			textType,		[76]},
		{'Other2007',				textType,		[77]},
		{'Special22007',			textType,		[78]},
		{'General2007',				textType,		[79]},
		{'voter-history2007',		textType,		[80]},


		{'PresPrimary2008',			textType,		[81]},


*/


		{'LastDateVote',			DateType,		[35]},
		{'ssn',	ssnType, [36]},
		{'telephone', ConcatSeg, [14,15,16]},
		{'EXTERNALKEY',       keyType, [250]}	


		], Text_Search.Layout_Segment_Definition);


fileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										);

return retval;

end;