export Common := MODULE

	import _Control, lib_stringlib, ut, Address;

	//**************************************************************************************
		export		xNID					:=	unsigned8;	//string18;
		export		xNameType				:=	string1;
		export		xNameString				:=  string80;
		export		xDateNumeric			:=	integer3;
		export		xDateString				:=	string8;
		export		xVersion				:=	unsigned1;
		export		xWUID					:=	string20;	// w20090102-123456-123 possible

	//**************************************************************************************
	//export	xNID	fGetNextNID()	:=	lib_FileServices.FileServices.getUniqueInteger(eUniqueIntegerDali);
	export integer4 CurrentDate	:=	(integer4)stringlib.getDateYYYYMMDD() : global;	// just to prevent the transforms from calling the function for every record in any transforms below
	
	export string16 ToHexString(unsigned integer8 n) :=
	BEGINC++
	// RETURNS:
	//	char *  __result
	// PARMS:
	//	unsigned __int64 n
	#include <string.h>
	#body
	#option pure
		char	str[18];
		snprintf(str, 18, "%016llX", n);
		memcpy(__result, str, 16);
	ENDC++;
	
	export data8 ToHex(unsigned integer8 n) :=
	BEGINC++
	// RETURNS:
	//	void *  __result
	// PARMS:
	//	unsigned __int64 n
	#include <string.h>
	#body
	#option pure
		//memcpy(__result, &n, 8);
		char *s = (char *)&__result;
		char *t = (char *)&n;
		int i = 7;
		do {
			*s++ = t[i--];
		} while (i >= 0);
	ENDC++;
	
	export string CombineName(string fname, string mname, string lname, string suffix) := 
		 TRIM( 
				TRIM(fname) +
					IF(mname='','',' ' + TRIM(mname)) +
					' ' + lname + 
					IF(suffix='','',' ' + TRIM(suffix))
				, LEFT, RIGHT);	
	
	//export	xNID	fGetNID(string name)	:=	ToHexstring(HASH64(TRIM(name,LEFT,RIGHT))) + '00';
	//export	xNid	fGetNIDParsed(string fname, string mname, string lname, string suffix='') :=
	//				fGetNID(Address.Persons.ReconstructName(fname,mname,lname,suffix));
	//export	xNid	BlankNid := fGetNid('') : stored('BlankNid');
	export	xNID	fGetNID(string name, integer derivation=0)	:=
						if(derivation=0,HASH64(TRIM(name,LEFT,RIGHT)),
										HASH64(TRIM(name,LEFT,RIGHT),derivation));
	string TrimName(string name) := FUNCTION
		t := TRIM(name);
		return IF(t='', '|', t+'|');
	END;
	export	xNid	fGetNIDParsed(string fname, string mname, string lname, string suffix='', integer derivation=0) :=
						if(derivation=0,HASH64(TrimName(fname), TrimName(mname), TrimName(lname), TrimName(suffix)),
									HASH64(TrimName(fname), TrimName(mname), TrimName(lname), TrimName(suffix),derivation));
//					fGetNID(Address.Persons.ReconstructName(fname,mname,lname,suffix));
	export	xNid	BlankNid := fGetNID('') : stored('BlankNid');


	//shared nidCluster :=  IF(_Control.ThisEnvironment.name='Dataland', 
	//						'~' + _Control.ThisCluster.GroupName + '::',	//'~thor400_88::',
	//						'~thor_data400::')  : stored('nidCluster');
	shared nidCluster :=  IF(_Control.ThisEnvironment.name='Dataland', 
							'~thor40_241::',				//'~thor400_88::',
							'~thor_data400::')  : stored('nidCluster');
							
	export filename_NameRepository	  := nidCluster + 'base::nid::repository::prod';
	export filename_NameRepository_Base	  := nidCluster + 'base::nid::repository';
	export filename_NameRepository_Cache  := filename_NameRepository_Base + '::cache';
	export filename_NameRepository_Delete  := filename_NameRepository_Base + '::delete';
	export filename_NameRepository_Version  := filename_NameRepository_Base + '::@version@';
	export filename_NameRepository_Add	  := nidCluster + 'base::nid';
	export filename_NameRepository_Key	  := nidCluster + 'key::nid';
	export filename_NameRepository_Name_Key := nidCluster + 'key::nid::fullname';
	export filename_NameRepository_ParsedName_Key := nidCluster + 'key::nid::parsedname';
	export filename_NameRepository_CleanName_Key := nidCluster + 'key::nid::cleanname';
	//export filename_NameRepository_FirstName_Key := nidCluster + 'key::nid::firstname';
	
	export GetFilename := filename_NameRepository_Add + '::' + workunit + '::' + ut.GetTime();
	export GetFilenameEx(string id) := filename_NameRepository_Add + '::' + workunit + '::' + ut.GetTime()
								+ if(id='','','_'+id);


END;