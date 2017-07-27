

 
//corp2.Files('').Base.Corp.Built 
//corp2.Files('').Base.Cont.Built 
//corp2.Files('').Base.Events.Built 
//corp2.Files('').Base.Stock.Built 
//corp2.Files('').Base.AR.Built






// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import Corp2;
import text_search;

export BWR_Build_Corp_Metadata(string filename) := 

function

// May need to change high level
info := text_search.FileName_Info_Instance('~THOR_DATA400::BASE', 'CORP', filename);


						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;




segmentMetaData := DATASET([
		{'CORP-NUMBER',					textType,		[1]},
		{'COMPANY-NAME',				textType,		[2]},
		{'OWNER-TYPE',					textType,		[3]},
		{'NAME-COMMENT',				textType,		[4]},
		{'BUSINESS-ADDRESS',			textType,		[5]},
		{'CORP-PHONE',					textType,		[6]},
		{'CORP-FAX',					textType,		[7]},
		{'CORP-EMAIL',					textType,		[8]},
		{'URL',							textType,		[9]},
		{'FILING-DATE',				 	textType,		[10]},
		{'FILING-TYPE',					textType,		[11]},
		
		{'STATUS-DATE',					textType,		[13]},
		{'STANDING',					textType,		[14]},
		{'STATUS-COMMENT',				textType,		[15]},
		{'TICKER',						textType,		[16]},
		{'EXCHANGE',					textType,		[17]},
		{'INCORP-STATE',				textType,		[18]},
		{'INCORP-COUNTY',				textType,		[19]},
		{'DATE-INC-QUAL',				textType,		[20]},
		{'FEIN',		 				textType,		[21]},
		{'TAXPAYER-NUMBER',				textType,		[22]},		
		{'EXPIRATION-DATE',				textType,		[23]},
		{'DURATION',					textType,		[24]},


		{'FOREIGN-INC-DATE',			textType,		[25]},
		{'TYPE',						textType,		[26]},
		{'SIC',							textType,		[27]},
		{'NAIC',						textType,		[28]},
		{'BUSINESS-TYPE',		 		textType,		[29]},
		{'CERTIFICATE-NO',				textType,		[30]},
		{'INTERNAL-NO',					textType,		[31]},
		{'PREVIOUS-NO',					textType,		[32]},
		{'MICROFILM-NO',				textType,		[33]},
		{'AMENDMENTS-FILED',			textType,		[34]},
		{'ACTS',						textType,		[35]},
		{'ADDITIONAL-INFO',				textType,		[36]},
		{'TAXES',						textType,		[37]},
		{'FRANCHISE-TAXES',				textType,		[38]},
		{'TAX-PROGRAM',					textType,		[39]},
		{'REGIS-AGENT',					textType,		[40]},
		{'REGIS-FEIN',					textType,		[41]},
		{'REGIS-SSN',		 			textType,		[42]},
		{'REGIS-DOB',					textType,		[43]},
		{'REGIS-EFFECTIVE-DT',			textType,		[44]},
		{'RESIGN-DATE',					textType,		[45]},
		{'REGIS-OFFICE',				textType,		[46]},		
		{'REGIS-PHONE',					textType,		[47]},
		{'REGIS-FAX',					textType,		[48]},
		{'REGIS-EMAIL',					textType,		[49]},
		{'REGIS-URL',					textType,		[50]},
		
		
		
		{'CONTACT',						textType,		[51]},
		{'CONTACT-FEIN',				textType,		[52]},
		{'CONTACT-SSN',					textType,		[53]},
		{'CONTACT-DOB',					textType,		[54]},
		{'CONTACT-STATUS',		 		textType,		[55]},
		{'CONTACT-EFFECTIVE-DT',		textType,		[56]},
		{'CONTACT-ADDRESS',				textType,		[57]},
		{'CONTACT-PHONE',				textType,		[58]},
		{'CONTACT-FAX',					textType,		[59]},	
		{'CONTACT-EMAIL',				textType,		[60]},
		{'CONTACT-URL',					textType,		[61]},
		
		

		{'STOCK-TYPE',					textType,		[62]},
		{'STOCK-CLASS',					textType,		[63]},
		{'SHARES',						textType,		[64]},
		{'AUTHORIZED-NBR',				textType,		[65]},
		{'PAR-VAL',		 				textType,		[66]},
		{'PAR-SHARES',					textType,		[67]},
		{'CHANGE-DATE',					textType,		[68]},
		{'TAX-CAPITAL',					textType,		[69]},
		
		
		
		{'FILING-NUMBER',				textType,		[70]},	
		{'AMENDMENT-NBR',				textType,		[71]},
		{'###DATE',						textType,		[72]},

		{'MICROFILM-NBR',				textType,		[73]},
		{'DESCRIPTION',					textType,		[74]},
		
		
		
		{'ANNUAL-REPORT-YR',			textType,		[75]},
		{'AR-MAILED-DT',				textType,		[76]},
		{'AR-DUE-DT',					textType,		[77]},
		{'AR-FILE-DT',		 			textType,		[78]},
		{'AR-REPORT-NBR',				textType,		[79]},
		{'AR-COMMEMNT',					textType,		[80]},
		{'AR-TYPE',						textType,		[81]},
		
		
		{'NAME',						textType,		[82]},	
		{'ADDRESS',						textType,		[83]},
		{'TELEPHONE',					textType,		[84]},
		{'DATE',						textType,		[85]},
		{'STATUS',						textType,		[86]},
		{'NUMBER',						textType,		[87]}

		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										);

return retval;

end;