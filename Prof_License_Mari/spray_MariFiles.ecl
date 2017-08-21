export spray_MariFiles := MODULE


// spray Prof files for MARTI 

import _control;
import lib_stringlib;
import lib_fileservices;
import lib_date;
import Prof_License_Mari.Common_Prof_Lic_Mari;

//Files are Located  //

shared filepath		    :=	'/data/data_build_5_2/MARI/in/';	
shared sourcepath		:=	'/data/data_build_5_2/MARI/';
shared maxRecordSize	:=	8192;
shared group_name	:=	'thor40_241';

shared filedate	:= StringLib.GetDateYYYYMMDD();


/* Funtion to Spray only the Trigger file */


export SprayTriggerFile(string filename, string source) := FUNCTION

       destination := Common_Prof_Lic_Mari.SourcesFolder + source + '::' + filedate + '::';

       RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
				filepath + source + '/'+ filename + '.txt',
				maxRecordSize,
				'\\,',
				'\\r\\n',
				'',
				group_name, 
				destination + StringLib.StringToLowerCase('TRIGGER_' + filedate + '.txt'),
				,
				,
				,
				true,
				,
				false); 			
END;

// Funtion to Spray All Files

export SprayFile(string filename, string source, string newname, 
                 string delim, string filetype, integer reczise):= FUNCTION

       destination := Common_Prof_Lic_Mari.SourcesFolder + source + '::' + filedate + '::';
    

       Layout_Triger_File := Record
              string8 data_date;
	          string1  lf;
       end;

       Filename_Triger_file := 
	   Common_Prof_Lic_Mari.SourcesFolder + source + '::' + filedate + '::trigger_'+ filedate + '.txt';

       Triger_file:= dataset(Filename_Triger_file, Layout_Triger_File, FLAT);

       datadate := Triger_file;

       xx := 	max(datadate,datadate.data_date);

       //output(datadate);
       myreturn := Case(filetype,
		        'csv' => FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
						 filepath + source + '/' + filename, 
						 maxRecordSize,
						 If(delim = 'tab','\\t','\\,'),
						 '\\r\\n',
						 '',
						 group_name, 
						 destination + StringLib.StringToLowerCase(newname + '_' + xx + '_raw.txt'),
							,
							,
							,
							true,
							,
							false),
		               
		    	'fix' => FileServices.SprayFixed(Common_Prof_Lic_Mari.sourceIP, 
						 filepath + source + '/' + filename, 
						 reczise,
						 group_name, 
						 destination + StringLib.StringToLowerCase(newname + '_' + xx + '_raw.txt'),
							,
							,
							,
							true,
							,
							false),
							FAIL('Failed for unknown FileType'));
				
				RETURN myreturn;
END;

END;