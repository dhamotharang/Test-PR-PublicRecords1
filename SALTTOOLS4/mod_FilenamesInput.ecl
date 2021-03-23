////////////////////////////////////////////////////////////////////////////////////////////
// -- mod_FilenamesInput module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your Input. 
// 								i.e. '~thor_data400::in_rolling::BBB::@version@::Member'
// 
// -- This module will give you access to all versions of an Input filename.
// -- i.e., 
// -- export Input	:= mod_FilenamesInput('~thor_data400::in_rolling::BBB::@version@::Member');
// -- Then,
// -- Input.Root			= '~thor_data400::in_rolling::BBB::Member'
// -- Input.Sprayed			= '~thor_data400::in_rolling::BBB::Sprayed::Member'
// -- Input.Using			= '~thor_data400::in_rolling::BBB::Using::Member'
// -- Input.Used			= '~thor_data400::in_rolling::BBB::Used::Member'
// -- Input.Delete	 		= '~thor_data400::in_rolling::BBB::Delete::Member'
// -- Input.Template		= '~thor_data400::in_rolling::BBB::@version@::Member'
// -- Input.New('20060328') = '~thor_data400::in_rolling::BBB::20060328::Member'
// -- 
// -- Input.dAll_superfilenames	= all of the above filenames(except the template and new) conveniently in a dataset
// --								for your pleasure(for use in apply, etc)
// -- Input.dNew			= The Input.New filename in a dataset
////////////////////////////////////////////////////////////////////////////////////////////
export mod_FilenamesInput(
	 string			ptemplatename
	,string			pFileDate							= ''
	,string			pSourceIP							= ''
	,string			pSourceDirectory			= ''
	,string			pDirectory_filter			= ''					
	,unsigned4	precord_size					= 0	
	,string			pSuperfilesMask				= '^(?!.*(using|used|delete)).*$'
	,string			pfun_Groupname				= ''
	,string			pFileDate2							= ''
	,string			pdate_regex						= '[0-9]{8}'	
	,string			pfile_type						= 'FIXED'			  			// CAN BE 'VARIABLE', OR 'XML'
	,string			psourceRowTagXML			= ''					
	,integer4 	psourceMaxRecordSize	= 8192				
	,string 		psourceCsvSeparate		= '\\,'					
	,string			psourceCsvTerminate		= '\\n,\\r\\n'
	,string			psourceCsvQuote				= '"'						
	,boolean		pcompress							= true				
	,boolean		pshouldoverwrite			= false				
	,boolean		pShouldSprayZeroByteFiles			= false				
) :=
module
	shared fVersion(string pversion) := trim(regexreplace('@version@', ptemplatename, pversion)); 
	
	shared lsprayed	:= 'sprayed';
	shared lusing		:= 'using';
	shared lused		:= 'used';
	shared ldelete	:= 'delete';
	
	export Root									:= regexreplace('::@version@', ptemplatename, '');
	export Sprayed							:= fVersion(lsprayed);
	export Using								:= fVersion(lusing);
	export Used									:= fVersion(lused);
	export Delete								:= fVersion(ldelete);
	export Template							:= ptemplatename;
	export Mask									:= fVersion('*')[2..];
	export Regex								:= fVersion('.*')[2..];
	export Logical							:= fVersion(pFileDate);
	export setRoot		:= [Root		];
	export setSprayed := [Sprayed	];
	export setUsing	 	:= [Using		];
	export setUsed		:= [Used		];
	export setDelete	:= [Delete	];
	export New(	string pdate,
				integer pcnt = 0,
				string pAppend = '')	:=	if(pcnt = 0 and pAppend = '', 
														 fVersion(pdate),
													if(pcnt != 0 and pAppend = '',
														fVersion(pdate) + '_' + (string) pcnt,
													if(pcnt != 0 and pAppend != '',
														fVersion(pdate) + '::' + pAppend + '_' + (string) pcnt,
													fVersion(pdate) + '::' + pAppend
													)));
													
	export setSprayedUsing	:= setSprayed + setUsing;
	export setUsingUsed			:= setUsing + setUsed;
	export setRootSprayed		:= setRoot + setSprayed;
	export setSprayedUsed		:= setSprayed + setUsed;
	
	export dAll_superfilenames := 
	DATASET([
		 (Root)
		,(Sprayed)
		,(Using)
		,(Used)
		,(Delete)
	], Layout_Names);
	
	export dAll_spray_supers := dAll_superfilenames(regexfind(pSuperfilesMask, name, nocase));
	
	export dNew(string pdate, integer pcnt = 0, string pAppend = '') :=
	DATASET([
		 (New(pdate, pcnt, pAppend))
	], Layout_Names);
	export dAll_templates := 
	DATASET([
		 (Template)
	], Layout_Names);
	export dall_filenames :=
	dataset([
	
		{
			 (dAll_superfilenames			)
			,(Template								)
			,(pSourceIP								)
			,(pSourceDirectory				)
			,(if(pdirectory_filter = '',	Mask,		pdirectory_filter)	)
			,(precord_size						)
			,(ptemplatename						)
			,(dAll_spray_supers				)
			,(pfun_Groupname							)
			,(pFileDate							  )
			,(pdate_regex						  )
			,(pfile_type							)
			,(psourceRowTagXML				)
			,(psourceMaxRecordSize		)
			,(psourceCsvSeparate			)
			,(psourceCsvTerminate		  )
			,(psourceCsvQuote				  )
			,(pcompress							  )
			,(pshouldoverwrite				)
			,(pShouldSprayZeroByteFiles				)
                             
		}
	
	], Layout_FilenameVersions.inputs);
	
end;
