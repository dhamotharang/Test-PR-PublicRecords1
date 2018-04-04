/*
  find_Attributes()
    if attribute is sandboxed, it will flag it in the returned dataset and give you the sandboxed code.
*/
EXPORT find_Attributes(

   string		pModuleName			= ''
  ,string		pAttributeName	= ''
  ,boolean	pGetText   			= true
  ,boolean	pIsSandbox    	= false
  ,string		pEsp						= _Config().Esp
  ,string		pUrl						= _Config(pEsp).Url
  ,string		pUserName     	= ''
  ,string		pPattern      	= ''
  ,string		pRegexp       	= ''
  ,string		pChangedSince 	= ''
  ,boolean	pLocked      		= false
  ,boolean	pCheckedOut  		= false
  ,boolean	pOrphaned    		= false
  ,boolean	pGetHistory     = false
  ,set of string  pTypes = ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']  //// esdl, xslt, kel, dud, cmp
  
) :=
function

// --------------------------------------------
	matched_lines_layout :=
	record
		unsigned4 LineNumber	{xpath('LineNumber'	)};
		string		LineText		{xpath('LineText'		)};
	end;
	eclResultLayout :=
	record, maxlength(5000000)
	
		string		ModuleName			{xpath('ModuleName'		 )};
		string		attributename   {xpath('Name'          )};
		string		attributeType   {xpath('Type'          )};
		unsigned4 Version         {xpath('Version'       )};
		unsigned4 LatestVersion   {xpath('LatestVersion' )};
		unsigned4 SandboxVersion  {xpath('SandboxVersion')};
		unsigned4 Flags           {xpath('Flags'         )};
		unsigned4 Access          {xpath('Access'        )};
		boolean		IsLocked        {xpath('IsLocked'      )};
		boolean		IsCheckedOut    {xpath('IsCheckedOut'  )};
		boolean		IsSandbox       {xpath('IsSandbox'     )};
		boolean		IsOrphaned      {xpath('IsOrphaned'    )};
		unsigned4 ResultType      {xpath('ResultType'    )};
		string		LockedBy        {xpath('LockedBy'      )};
		string		ModifiedBy      {xpath('ModifiedBy'    )};
		string		ModifiedDate    {xpath('ModifiedDate'  )};
		string		Description     {xpath('Description'   )};
		string		Checksum        {xpath('Checksum'      )};
		string		Text            {xpath('Text'          )};
		// dataset(matched_lines_layout) MatchedLines{xpath('MatchedLines/Line')};
                           
	end;
	
	InfoOutRecord :=
	record, maxlength(200000000)
	
		string exception_code{xpath('Exceptions/Exception/Code')};
		string exception_source{xpath('Exceptions/Exception/Source')};
		string exception_msg{xpath('Exceptions/Exception/Message')};
		
		dataset(eclResultLayout) results{xpath('outAttributes/ECLAttribute')};
	
	end;

  item_layout :=
  record
    string		Item		{xpath('Item'		)};
  end;

  InfoInRecord :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset([{'ECL'}],item_layout);
                                                   
  end;                
  
  InfoInRecord2 :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['SALT'],item_layout);
                                                   
  end;                

  InfoInRecord3 :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['ESDL'],item_layout);
                                                   
  end;                

  InfoInRecord4 :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['XSLT'],item_layout);
                                                   
  end;                

  InfoInRecord5 :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['KEL'],item_layout);
                                                   
  end;                

  InfoInRecord6 :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['DUD'],item_layout);
                                                   
  end;                

  InfoInRecord7 :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= '';//pAttributeName	;
    string UserName     {xpath('UserName'			)}	:= pUserName     	;
    string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
    string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
    string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
    boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
    boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
    boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
    boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
    boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
    boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pGetHistory   		;
    dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['CMP'],item_layout);
                                                   
  end;                
// esdl, xslt, kel, dud, cmp
// ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']
  
  results := 
    if('ECL'  in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord ,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  + if('SALT' in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord2,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  + if('ESDL' in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord3,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  + if('XSLT' in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord4,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  + if('KEL'  in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord5,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  + if('DUD'  in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord6,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  + if('CMP'  in pTypes  ,SOAPCALL(pUrl,'FindAttributes',InfoInRecord7,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
  ;
		
  resultlayout := 
  record, maxlength(5000000)

    eclResultLayout;
    string fullname;

  end;
  resultlayout tNormfiles(InfoOutRecord l, eclResultLayout r) :=
  transform
    self := r;
    self.fullname := r.modulename + '.' + r.attributename;
  end;
  
  dnormresults := normalize(results, left.results,tNormfiles(left,right)) ;//: global;

  // LatestVersion = total number of checked-in versions
  // IsSandbox     = if it is sandboxed, this will be set to true and all records returned will be the same, so need to dedup them and get rest of history
  ds_sandboxed      := dnormresults(IsSandbox = true );
  ds_not_sandboxed  := dnormresults(IsSandbox = false);
  
  ds_dedup_sandboxed := dedup(ds_sandboxed,all);
  
  ds_norm_sandboxed  := normalize(ds_dedup_sandboxed  ,(unsigned)left.LatestVersion ,transform(
     resultlayout
     ,ds_getatt := project(Repository.get_Attribute(left.ModuleName,left.attributename,counter,false),transform(resultlayout,self := left,self := []));
      self := ds_getatt[1];
    // ,self.LockedBy := '';
    // ,self := [];
  ));

  ds_result_prep := if(pGetHistory = false ,dnormresults ,ds_dedup_sandboxed + ds_norm_sandboxed + ds_not_sandboxed);
  ds_result := project(ds_result_prep,transform({unsigned4 _version,recordof(left)},self._version := if(left.IsSandbox = true, 0, left.latestversion - left.version + 1),self := left));
  
  return sort(ds_result(pAttributeName = '' or regexfind(pAttributeName,attributename,nocase))  ,modulename ,attributename  ,if(issandbox,0,1)  ,version  );
		
end;