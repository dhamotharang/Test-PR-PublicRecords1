import _control,tools;
////////////////////////////////////////////////////////////////////////////////////////////
// -- mInputFileNameVersions module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your Input. 
// 								i.e. '~thor_data400::in_rolling::BBB::@version@::Member'
// 
// -- This module will give you access to all versions of an Input filename.
// -- i.e., 
// -- export Input	:= mInputFileNameVersions('~thor_data400::in_rolling::BBB::@version@::Member');
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
export mInputFileNameVersions(

	 string			ptemplatename
	,string			pSourceIP							= ''
	,string			pSourceDirectory			= ''
	,string			pDirectory_filter			= ''					
	,unsigned4	precord_size					= 0	
	,string			pSuperfilesMask				= '^(?!.*(using|used|delete)).*$'
	,string			pGroupName						= Groupname()
	,string			pFileDate							= ''
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
  tools.mod_FilenamesInput(
     ptemplatename
    ,pFileDate
    ,pSourceIP						
    ,pSourceDirectory		
    ,pDirectory_filter		
    ,precord_size				
    ,pSuperfilesMask			
    ,pGroupName			
    ,pFileDate						
    ,pdate_regex					
    ,pfile_type					
    ,psourceRowTagXML		
    ,psourceMaxRecordSize
    ,psourceCsvSeparate	
    ,psourceCsvTerminate	
    ,psourceCsvQuote			
    ,pcompress						
    ,pshouldoverwrite		
    ,pShouldSprayZeroByteFiles
);