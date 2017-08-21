/*
|| Please change the values of _ftbUnix_Src
|| and _Header_Base attributes to reflect
|| upon the file you would like to process
*/


import _control;

_ftbUnix_Src := '/load01/temp/EXPERIAN/FILETOBIN.txt';

_Header_Base := EBR.File_0010_Header_Base;

_FileToBIN := '~thor_data400::sprayed::experian::filetobin';

_SprayFileToBIN := FileServices.SprayFixed(_control.IPAddress.edata14
                                           ,_ftbUnix_Src
						                   ,19
						                   ,'thor_dell400'
						                   ,_FileToBIN
						                   ,-1,,,true,true,true);


lTmp := RECORD,MAXSIZE(10)
 STRING10    File_Number;
 STRING10    BIN;
 string40    COMPANY_NAME;
 string30    STREET_ADDRESS;
 string28    CITY;
 string2     STATE_CODE;
 string20    STATE_NAME;
 string5     orig_ZIP;
 string4     orig_ZIP_4;
end;


lTmp1 := RECORD,MAXSIZE(19)
 STRING9 Old_File_Number;
 STRING10 New_File_Number;
end;


hb := PROJECT (_Header_Base,TRANSFORM(lTmp,SELF := LEFT;SELF := [];));


ftb := DATASET(_FileToBIN,lTmp1,THOR);

c := join(hb,ftb,
          trim(left.File_Number) = right.Old_File_Number,
		  transform(lTmp, 
		            self.BIN := RIGHT.New_File_Number;
					self := LEFT;),
					FULL OUTER) : persist ('~thor_data400::persist::experian::0010_Analyze');
					
_uniq_old_file_nums_not_in_cr_file := DEDUP(SORT(c(file_number <> '',bin = ''),file_number),file_number);                              
					
_out := output(_uniq_old_file_nums_not_in_cr_file,,'~thor_data400::persist::experian::LexNex_Only',__compressed__,overwrite);

SEQUENTIAL(_SprayFileToBIN,_out);
            