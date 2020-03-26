import _control;
export Constants :=
module

	/**************************************************************************************/
	export		xDateNumeric				:=	integer3;
	export		xDateString					:=	string8;
	export		xAID								:=	unsigned8;
	export		xAddressType				:=	string1;
	export		xRecordID						:=	unsigned8;
	export		xFlags							:=	unsigned4;
	export		xVersion						:=	unsigned2;
	export		xWUID								:=	string20;	// w20090102-123456-123 possible
	export		xCleanStatus				:=	string10;	// Will receive err_stat value from ACE cleaning;  future use unknown, but string10 to allow for it

	/**************************************************************************************/
	export		unsigned1	eCache							:=	enum(unsigned1,
																									 ForHeader			=	1,
																									 ForNonHeader		=	2
																									);

	/**************************************************************************************/
	export		string		StoredWhichAIDCache	:=	'AID_Stored_Which_AID_Cache';

	/**************************************************************************************/
	export		unsigned1	WhichAIDCache				:=	eCache.ForHeader	:	stored(StoredWhichAIDCache);

	/**************************************************************************************/
	export		KnownDalis	:=
	module
        export  string              BocaDev             :=  '10.173.14.201'; //'10.241.12.201';  
        export  string              BocaOldDev          :=  '10.241.3.238';
        export  string              BocaProd            :=  '10.173.44.105';
        export  string              AlphaDev            :=  '10.194.10.1';
        export  string              AlphaProd           :=  '10.194.12.1';
        export  set of string    sAll                   :=  [BocaDev, BocaOldDev, BocaProd, AlphaDev, AlphaProd];
	end;
	
	/**************************************************************************************/
	export		eFlags	:=
	enum(xFlags,
			 None						=	00000000000000000000000000000000b,
			 RawNormalized	=	00000000000000000000000000000001b,
			 StdNormalized	=	00000000000000000000000100000000b,
			 ACENormalized	=	00000000000000010000000000000000b
			);

	/**************************************************************************************/
	export	AddressType	:=
	module
		export	xAddressType	Raw 			:=	'R';
		export	xAddressType	Std				:=	'S';
		export	xAddressType	ACE				:=	'A';
		export	xAddressType	Unknown		:=	'U';
	end;

	/**************************************************************************************/
	export	WorkunitState	:=
	module
		export	string				RunningState	:=	'RUNNING';
		export	string				WaitState			:=	'WAIT';
		export	set of string	sActiveStates	:=	[RunningState, WaitState];
	end;

	/**************************************************************************************/
	export	string		EmailTargetErrors	:=	'tony.kirk@lexisnexis.com';

	/**************************************************************************************/
	export	string		NonHeaderPrefix		:=	'NonHeader_';		// Used in workunit name, event trigger, etc

	/**************************************************************************************/
	export	JobName	:=
	module
						// string		WhichCache				:=	choose(WhichAIDCache,
																											 // '',							//	eCache.ForHeader
																											 // 'NonHeader_',		//	eCache.ForNonHeader
																											 // ''
																											// );
						// string		Prefix						:=	'AID';
		// shared	string		Base							:=	WhichCache + Prefix + '-Support - ';
		export	string		Base							:=	'AID-Support - ';
		export	string		AddNewCacheFiles	:=	Base + 'Add New Cache Files';
		export	string		CacheConsolidate	:=	Base + 'Cache Consolidate';
		export	string		RollupUpdates			:=	Base + 'Rollup Updates';
	end;

	/**************************************************************************************/
	export	EventTrigger	:=
	module
		shared	string		Base											:=	'AID-Event - ';
		shared	string		CompleteSuffix						:=	' - Complete';
		export	string		AddNewCacheFiles					:=	Base + 'Add New Cache Files';
		export	string		AddNewCacheFilesComplete	:=	AddNewCacheFiles + CompleteSuffix;
		export	string		CacheConsolidate					:=	Base + 'Cache Consolidate';
		export	string		CacheConsolidateComplete	:=	CacheConsolidate + CompleteSuffix;;
		export	string		RollupUpdates							:=	Base + 'Rollup Updates';
		export	string		RollupUpdatesComplete			:=	RollupUpdates + CompleteSuffix;;
	end;

	export	CronTrigger	:=
	module
		export	string		AddNewCacheFiles	:=	'0-59/12 * * * *';
		export	string		CacheConsolidate	:=	'0 7 * * *';
		export	string		RollupUpdates			:=	'0 9 * * *';
	end;

	/**************************************************************************************/
	export	FileName	:=
	module
		export	string		ClusterPrefix		:=	'thor';
		export	string		Directory				:=	'base';
		#if(_control.ThisEnvironment.Name = 'Prod_Thor');
			export	string		Family					:=	trim(choose(WhichAIDCache,
																												'aidtemp',					//	eCache.ForHeader
																												'aid_nonheader',		//	eCache.ForNonHeader
																												'aidtemp'
																											 )
																								);
		#else;
			export	string		Family					:=	trim(choose(WhichAIDCache,
																												'aid',							//	eCache.ForHeader
																												'aid_nonheader',		//	eCache.ForNonHeader
																												'aidtemp'
																											 )
																								);
		#end;

		export	AddressType	:=
		module
			export	string		Raw					:=	'raw';
			export	string		Std					:=	'std';
			export	string		ACE					:=	'ace';
			export	string		Unknown			:=	'unknown';
		end;

		export	ActivityType	:=
		module
			export	string		New					:=	'new';
			export	string		Update			:=	'update';
			export	string		Cache				:=	'cache';
			export	string		Unknown			:=	'unknown';
		end;

		export	SuperGeneration	:=
		module
			export	string		QA					:=	'qa';
			export	string		Prod				:=	'prod';
			export	string		Father			:=	'father';
			export	string		GrandFather	:=	'grandfather';
			export	string		Discard			:=	'discard';
			export	string		Exception		:=	'exception';	// Used to hold logicals we don't want included
		end;
	end;

end;