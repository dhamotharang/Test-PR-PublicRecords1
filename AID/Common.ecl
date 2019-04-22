import _control, lib_FileServices, AID_Support, Std;

export Common
 :=
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
		shared		fValideCache(unsigned1 pCache)	:=	pCache between AID_Support.Constants.eCache.ForHeader and AID_Support.Constants.eCache.ForNonHeader;
		
		/**************************************************************************************/
		export		eFlags	:=	enum(xFlags,
															 None						=	00000000000000000000000000000000b,
															 RawNormalized	=	00000000000000000000000000000001b,
															 StdNormalized	=	00000000000000000000000100000000b,
															 ACENormalized	=	00000000000000010000000000000000b
															)
											;

		/**************************************************************************************/
		export	eEvents
		 :=
			module
				shared	string			Prefix				:=	'AIDWork: ';
				export	string			NewCacheFiles	:=	Prefix + 'New Cache Files Ready';
			end
		 ;

		/**************************************************************************************
		 ** Considered ENUM(), but wanted meaningful string values for raw data viewing
		 **************************************************************************************/
		export	eAddressType
		 :=
			module
				export	xAddressType	Raw 			:=	'R';
				export	xAddressType	Std				:=	'S';
				export	xAddressType	ACE				:=	'A';
				export	xAddressType	Unknown		:=	'U';
			end
		 ;

		/**************************************************************************************/
		export	eNormalizeFlag	:=	enum(xFlags,
																		 None						=	00000000000000000000000000000000b,
																		 PrePOBPart			=	00000000000000000000000000000001b,
																		 POBPart				=	00000000000000000000000000000010b,
																		 PostPOBPart		=	00000000000000000000000000000100b,
																		 Concatenated		=	00000000000000000000000000001000b,
																		 Unknown				=	10000000000000000000000000000000b
																		)
														;

		/**************************************************************************************/
		export	eReturnValues	:=	enum(xFlags,
																	 None							=	00000000000000000000000000000000b,
																	 IsInCacheFlags		=	00000000000000000000000000000001b,
																	 AllowMultiple		=	00000000000000000000000000000010b,
																	 RawAID						=	00000000000000000000000100000000b,
																	 RawCacheRecord		=	00000000000000000000001000000000b,
																	 StdAIDs					=	00000000000000010000000000000000b,
																	 StdCacheRecords	=	00000000000000100000000000000000b,
																	 ACEAIDs					=	00000001000000000000000000000000b,
																	 ACECacheRecords	=	00000010000000000000000000000000b,
																	 NoNewCacheFiles	=	10000000000000000000000000000000b,
																	 Default					=	IsInCacheFlags
																										|	AllowMultiple
																										|	RawCacheRecord
																										|	StdCacheRecords
																										|	ACECacheRecords
																	)
													;

		/**************************************************************************************/
		#if(_control.ThisEnvironment.Name <> 'Prod_Thor')
			#warning('Not in Prod Thor environment.  Any AIDs produced in this workunit may conflict or not align with Prod AID records.');
			output('Warning!  Not in Prod Thor environment.  Any AIDs produced in this workunit may conflict or not align with Prod AID records.');
		#end
		export	string		eUniqueIntegerDali	:=	_control.ThisEnvironment.Dali_IPAddress;
		export	string		ePOBoxReplacement		:=	'PO BOX';
		export	xVersion	eStdVersion					:=	1;

		/**************************************************************************************/
		export	eFileName
		 :=
			module
				shared	boolean		IsReadProdFlag	:=	false;//tkirk-20140103-Possibly issue 10513---	: stored('AIDWork_Read_Prod_Cache');
				shared	string		ClusterPrefix		:=	'thor';
				shared	string		Directory				:=	'base';
				assert(fValideCache(AID_Support.Constants.WhichAIDCache), 'Invalid AID cache selection provided via #STORED(AID_Support.Constants.StoredWhichAIDCache...)', fail);
				#if(_control.ThisEnvironment.Name = 'Prod_Thor');
					shared	string		Family					:=	choose(AID_Support.Constants.WhichAIDCache,
																											 'aidtemp',					//	eCache.ForHeader
																											 'aid_nonheader',		//	eCache.ForNonHeader
																											 'aidtemp'
																											);
				#else;
					shared	string		Family					:=	choose(AID_Support.Constants.WhichAIDCache,
																											 'aid',							//	eCache.ForHeader
																											 'aid_nonheader',		//	eCache.ForNonHeader
																											 'aid'
																											);
				#end;
				export	AddressType
				 :=
					module
						export	string		Raw					:=	'raw';
						export	string		Std					:=	'std';
						export	string		ACE					:=	'ace';
						export	string		Unknown			:=	'unknown';
					end
				 ;
				export	ActivityType
				 :=
					module
						export	string		New					:=	'new';
						export	string		Update			:=	'update';
						export	string		Cache				:=	'cache';
						export	string		Unknown			:=	'unknown';
					end
				 ;
				export	SuperGeneration
				 :=
					module
						export	string		QA					:=	'qa';
						export	string		Prod				:=	'prod';
						export	string		Father			:=	'father';
						export	string		GrandFather	:=	'grandfather';
						export	string		Discard			:=	'discard';
						export	string		Exception		:=	'exception';	// Used to hold logicals we don't want included
					end
				 ;
				export	string		fConstruct(xAddressType pAddressType, string pActivity, string pVersion = 'no_version')
				 :=	if(IsReadProdFlag,
							 'foreign::' + _control.IPAddress.prod_thor_dali + '::',
							 ''
							)
				 +	ClusterPrefix +	'::'
				 +	Directory			+	'::'
				 +	Family				+	'::'
				 +	case(pAddressType,
								 eAddressType.Raw		=>	AddressType.Raw,
								 eAddressType.Std		=>	AddressType.Std,
								 eAddressType.ACE		=>	AddressType.ACE,
								 AddressType.Unknown
								)					+	'::'
				 +	pActivity			+	'::'
				 +	pVersion
				 ;

			end
		 ;

		/**************************************************************************************/
		export	xAID	fGetNextAID()	:=	lib_FileServices.FileServices.getUniqueInteger(eUniqueIntegerDali);

		/**************************************************************************************
		 ** fGetDateTimeString()
		 ** Returns current date/time as string14 formatted as YYYYMMDDhhmmss
		 ** Can use local(fGetDateTimeString()) if nothor usage to help force unique evaluation
		 **************************************************************************************/
		export	string14	fGetDateTimeString()	:=
		#if(__ECL_VERSION__ >= '5.2')
			std.date.SecondsToString(std.date.CurrentSeconds(true), '%Y%m%d%H%M%S');
		#else
			function
				string14 fGetDimeTime()	// 14 characters returned
				 :=
					BEGINC++
					#option action
					struct tm localt;	// localtime in "tm" structure
					time_t timeinsecs;  // variable to store time in secs
					time(&timeinsecs);  
					localtime_r(&timeinsecs,&localt);
					strftime(__result, 15, "%Y%m%d%H%M%S", &localt); // Formats the localtime to YYYYMMDDhhmmss
					ENDC++
				 ;
				return fGetDimeTime();
			end
		 ;
		#end

  end
 ;
