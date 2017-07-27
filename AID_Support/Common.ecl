import	lib_WorkunitServices, lib_StringLib, lib_ThorLib, lib_FileServices, _Control, Std;
export Common :=
module

	/**************************************************************************************/
	export	string		fConstructFilename(Constants.xAddressType pAddressType, string pActivity, string pVersion = 'no_version')
	 :=	Constants.Filename.ClusterPrefix	+	'::'
	 +	Constants.Filename.Directory			+	'::'
	 +	Constants.Filename.Family					+	'::'
	 +	case(pAddressType,
					 Constants.AddressType.Raw		=>	Constants.Filename.AddressType.Raw,
					 Constants.AddressType.Std		=>	Constants.Filename.AddressType.Std,
					 Constants.AddressType.ACE		=>	Constants.Filename.AddressType.ACE,
					 Constants.Filename.AddressType.Unknown
					)					+	'::'
	 +	pActivity			+	'::'
	 +	pVersion
	 ;

	/**************************************************************************************/
	export	boolean		fIsJobActive(string pJobName)	:=
	function
		dOtherWorkunits				:=	nothor(lib_WorkunitServices.WorkunitServices.WorkUnitList('', '', '', '', pJobName));
		dOtherWorkunitsActive	:=	dOtherWorkunits(WUID <> workunit and lib_StringLib.StringLib.StringToUpperCase(state) in Constants.WorkunitState.sActiveStates);
		return	count(dOtherWorkunitsActive) <> 0;
	end;

	/**************************************************************************************/
	export	boolean		fIsJobRunning(string pJobName)	:=
	function
		dOtherWorkunits				:=	nothor(lib_WorkunitServices.WorkunitServices.WorkUnitList('', '', '', '', pJobName));
		dOtherWorkunitsActive	:=	dOtherWorkunits(WUID <> workunit and lib_StringLib.StringLib.StringToUpperCase(state) = Constants.WorkunitState.RunningState);
		return	count(dOtherWorkunitsActive) <> 0;
	end;
	
	/**************************************************************************************/
	export	string		fCurrentDali()	:=
	function
		string	lDaliString	:=	nothor(lib_ThorLib.ThorLib.DaliServers());
		string	lDaliNoPort	:=	regexfind('(^[^:]+)', lDaliString, 1);
		return	lDaliNoPort;
	end;

	/**************************************************************************************/
	export	boolean		fValidEnvironment()	:=	fCurrentDali() in Constants.KnownDalis.sAll;

	/**************************************************************************************
	 ** fGetDateTimeString()
	 ** Returns current date/time as string14 formatted as YYYYMMDDhhmmss
	 ** Can use local(fGetDateTimeString()) if nothor usage to help force unique evaluation
	 **************************************************************************************/
	export	string14	fGetDateTimeString()	:=
	#if(__ECL_VERSION__ >= '5.2')
		Std.Date.SecondsToString(std.date.CurrentSeconds(true), '%Y%m%d%H%M%S');
	#else
		function
			string14 fGetDimeTime()	:=	// 14 characters returned
			beginc++
			#option action
			struct tm localt;		// localtime in "tm" structure
			time_t timeinsecs;  // variable to store time in secs
			time(&timeinsecs);  
			localtime_r(&timeinsecs,&localt);
			strftime(__result, 15, "%Y%m%d%H%M%S", &localt); // Formats the localtime to YYYYMMDDhhmmss
			endc++;
			return fGetDimeTime();
		end;
	#end;

	/**************************************************************************************/
	export	string	fLogicalFileListString(dataset(lib_FileServices.FsLogicalFileInfoRecord) pLogicalFileList) :=
	function
		rFileNames	:=
		record
			string		Name{maxlength(256000)};
		end;
		dFileNames	:=	project(pLogicalFileList, rFileNames);

		rFileNames	tRollupToOneList(dFileNames pLeft, dFileNames pRight)	:=
		transform
			self.Name	:=	pLeft.Name + ',' + pRight.Name;
		end;
		dRollupToOneList	:=	rollup(dFileNames, true, tRollupToOneList(left, right));

		return	dRollupToOneList[1].Name;
	end;

end;