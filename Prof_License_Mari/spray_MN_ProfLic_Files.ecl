export spray_MN_ProfLic_Files := MODULE


// spray Minnesota Prof files for MARTI 

import _control;
import lib_stringlib;
import lib_fileservices;
import lib_date;
import Prof_License_Mari.Common_Prof_Lic_Mari;

//Files for MN are Located  //

shared filepath		    :=	'/data_build_5_2/PLOTN/MNROS0196/';	
shared sourcepath		:=	'/data_build_5_2/PLOTN/';
shared maxRecordSize	:=	8192;
shared group_name	:=	'thor400_88';

shared filedate	:= StringLib.GetDateYYYYMMDD();

shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'mn::' + filedate + '::';


shared SprayFile(string filename, string newname, string delim) := FUNCTION

    	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
				filepath + filename, 
				maxRecordSize,
				If(delim = 'tab','\\t','\\,'),
				'\\r\\n',
				'',
				group_name, 
				destination + StringLib.StringToLowerCase(newname),
				-1,
				Common_Prof_Lic_Mari.espserverIPport,
				1,
				true,
				true,
				false); 				
END;

/* Spray only the Triger file */

export SprayTFile := SprayFile('MN_TRIGER.TXT','MN_TRIGER_'+filedate+'.txt', 'comma');

Layout_Triger_File := Record
       string8 data_date;
	   string1  lf;
end;

Filename_Triger_file := Common_Prof_Lic_Mari.SourcesFolder + 'mn::' + filedate + '::MN_TRIGER_'+ filedate + '.txt';

MN_Triger_file:= dataset(Filename_Triger_file, Layout_Triger_File, FLAT);

export datadate := MN_Triger_file;

xx := 	max(datadate,datadate.data_date);
output(datadate);

//  Spray All Files

export MN_SprayFiles := 
	PARALLEL(
		SprayFile('PHYS.TXT','PHYS_'+xx+ '_raw.txt', 'tab'), 
		SprayFile('RN.TXT','RN_'+xx+ '_raw.txt', 'comma'), 
		SprayFile('LPN.TXT','LPN_'+xx+ '_raw.txt', 'comma'),
        SprayFile('PA.TXT','PA_'+xx+ '_raw.txt', 'comma'), 
        SprayFile('PHY.TXT','PHY_'+xx+ '_raw.txt', 'comma'));
END;