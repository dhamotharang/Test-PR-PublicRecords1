export Common := MODULE

	import _Control, lib_stringlib, ut, Address, STD, Data_Services;

	//**************************************************************************************
		export		xNID					:=	unsigned8;	//string18;
		export		xNameType				:=	string1;
		export		xNameString				:=  string80;
		export		xDateNumeric			:=	integer3;
		export		xDateString				:=	string8;
		export		xVersion				:=	unsigned1;
		export		xWUID					:=	string20;	// w20090102-123456-123 possible

	//**************************************************************************************
	export integer4 CurrentDate	:=	(integer4)stringlib.getDateYYYYMMDD() : global;	// just to prevent the transforms from calling the function for every record in any transforms below
	
	export string CombineName(string fname, string mname, string lname, string suffix) := 
		 TRIM( 
				TRIM(fname) +
					IF(mname='','',' ' + TRIM(mname)) +
					' ' + lname + 
					IF(suffix='','',' ' + TRIM(suffix))
				, LEFT, RIGHT);	
	
	export	xNID	fGetNID(string name, integer derivation=0)	:=
						if(derivation=0,HASH64(TRIM(name[1..150],LEFT,RIGHT)),
										HASH64(TRIM(name,LEFT,RIGHT),derivation));
	string TrimName(string name) := FUNCTION
		t := TRIM(name);
		return IF(t='', '|', t+'|');
	END;
	export	xNid	fGetNIDParsed(string fname, string mname, string lname, string suffix='', integer derivation=0) :=
						if(derivation=0,HASH64(TrimName(fname), TrimName(mname), TrimName(lname), TrimName(suffix)),
									HASH64(TrimName(fname), TrimName(mname), TrimName(lname), TrimName(suffix),derivation));
	export	xNid	BlankNid := fGetNID('') : global;	

/*
IP Address for LogsThor mapping

*/
	shared set of string LogsThor := ['10.241.50.42:8010','10.173.231.12:7070', '10.173.11.12:7070',
																	'10.241.21.34:7070','10.241.50.45:7070','10.173.52.3:7070', '10.173.52.1:7070'];
    shared nidCluster1 :=  MAP(
         Thorlib.Daliservers() in LogsThor => Data_Services.foreign_prod + 'thor::',
 				_Control.ThisEnvironment.name='Dataland' => '~thor::',          //'~thor400_88::',
        '~thor::'); 
  shared nidCluster :=  MAP(
         Thorlib.Daliservers() in LogsThor => Data_Services.foreign_prod + 'thor::',
 				_Control.ThisEnvironment.name='Dataland' => '~thor::',          //'~thor400_88::',
        '~thor::'); 
							
	export filename_NameRepository	  := nidCluster + 'base::nid::repository::current';
	export filename_NameRepository_Legacy	  := nidCluster1 + 'base::nid::repository::v1';
	export filename_NameRepository_Base	  := nidCluster + 'base::nid::repository';
	export filename_NameRepository_Cache  := '~thor::base::nid::repository::cache';
	export filename_NameRepository_Delete  := filename_NameRepository_Base + '::delete';
	export filename_NameRepository_Version  := filename_NameRepository_Base + '::@version@';
	export filename_NameRepository_Add	  := '~thor::nid::cache';
	export filename_NameRepository_Key	  := nidCluster + 'key::nid';
	export filename_NameRepository_Name_Key := nidCluster + 'key::nid::fullname';
	export filename_NameRepository_ParsedName_Key := nidCluster + 'key::nid::parsedname';
	export filename_NameRepository_CleanName_Key := nidCluster + 'key::nid::cleanname';
	export filename_NameRepository_BizName_Key := nidCluster + 'key::nid::bizname';
	export filename_NameRepository_FirstName_Key := nidCluster + 'key::nid::firstname';
	
	//export GetFilename := filename_NameRepository_Add + '::' + workunit + '::' + GetTime();
	
//	tiebreaker := '::' + (string)COUNT(NOTHOR(Std.System.Workunit.WorkunitFilesWritten(workunit))(Std.Str.FindCount(name,'::base::nid') > 0));
	
	
	
	export GetFilename2(string uniqueid) := filename_NameRepository_Add + '::' + workunit + '::' + uniqueid;	// + tiebreaker;
	//export GetFilenameEx(string id) := filename_NameRepository_Add + '::' + workunit + '::' + ut.GetTime()
	//							+ if(id='','','_'+id);


END;