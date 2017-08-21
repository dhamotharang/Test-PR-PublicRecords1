//run on hthor
/*
tools.fun_AMT('bipv2_tools','',pShouldSaveAtts := false,pOverrideWarnings := false);

*/
export fun_AMT(

	 string		pModuleName
	,string 	pAttributeNamesRegex	= ''
	,boolean	pShouldSaveAtts				= false 
	,boolean	pSandboxed				    = false 
  ,boolean  pSave2OtherEnvironment= false
  ,string   pSourceEsp            = if(_Constants.IsDataland = true ,'10.241.3.242:8145'  ,'10.173.84.202:8145' ) //optimized for dataland and prod
  ,string   pDestinationEsp       = if(_Constants.IsDataland = true ,'10.173.84.202:8145' ,'10.241.3.242:8145'  ) //optimized for dataland and prod
  ,boolean  pOverrideWarnings     = false
) :=
function

  //Pull attributes from source and destination
	dattsSource       := tools.mod_Soapcalls.fFindAttributes(pModuleName,pAttributeNamesRegex,pSourceEsp     ,,pSandboxed);
	dattsDestination  := tools.mod_Soapcalls.fFindAttributes(pModuleName,pAttributeNamesRegex,pDestinationEsp,,pSandboxed);
	
	dattsSource_proj := project(dattsSource, transform(
	{string fullname,string modulename, string attributename,string ModifiedDate, string ModifiedBy,boolean IsSandbox,boolean IsLocked,boolean IsCheckedOut,boolean IsOrphaned  ,string importtext {maxlength(1000000)}, string actualtext {maxlength(1000000)}}
	,attname := left.fullname;
	
	 self.fullname 		  := left.fullname;
	 self.modulename 		:= pModuleName;
	 self.attributename := left.attributename;
	 self.importtext 		:= 		'//Import:' + attname + '\n'
													+ left.text
													;
	 self.actualtext 		:= left.text;
   self := left;
	));

	dattsDest_proj := project(dattsDestination, transform(
	{string fullname,string modulename, string attributename,string ModifiedDate, string ModifiedBy,boolean IsSandbox,boolean IsLocked,boolean IsCheckedOut,boolean IsOrphaned  ,string importtext {maxlength(1000000)}, string actualtext {maxlength(1000000)}}
	,attname := left.fullname;
	
	 self.fullname 		  := left.fullname;
	 self.modulename 		:= pModuleName;
	 self.attributename := left.attributename;
	 self.importtext 		:= 		'//Import:' + attname + '\n'
													+ left.text
													;
	 self.actualtext 		:= left.text;
   self := left;
	));

  djoin := join(
     dattsSource_proj
    ,dattsDest_proj
    ,     stringlib.stringtouppercase(left.fullname) = stringlib.stringtouppercase(right.fullname)
    ,transform(
      {string ModifiedDateSource,string ModifiedDateDestination,boolean IsSandboxSource,boolean IsSandboxDestination, string ModifiedBySource, string ModifiedByDestination
      ,boolean IsLockedSource     ,boolean IsLockedDestination
      ,boolean IsCheckedOutSource ,boolean IsCheckedOutDestination
      ,boolean IsOrphanedSource   ,boolean IsOrphanedDestination
      ,recordof(left),string remotetext {maxlength(1000000)}}
      ,self := left
      ,self.ModifiedDateSource      := left.ModifiedDate;
      ,self.ModifiedDateDestination := right.ModifiedDate;
      ,self.IsSandboxSource         := left.IsSandbox;
      ,self.IsSandboxDestination    := right.IsSandbox;
      ,self.ModifiedBySource        := left.ModifiedBy;
      ,self.ModifiedByDestination   := right.ModifiedBy;

      ,self.IsLockedSource          := left.IsLocked;
      ,self.IsLockedDestination     := right.IsLocked;
      ,self.IsCheckedOutSource      := left.IsCheckedOut;
      ,self.IsCheckedOutDestination := right.IsCheckedOut;
      ,self.IsOrphanedSource        := left.IsOrphaned;
      ,self.IsOrphanedDestination   := right.IsOrphaned;
      ,self.remotetext              := right.actualtext
    )
    ,left outer
  );
  
  joinfilt             := (djoin.actualtext != djoin.remotetext) and (djoin.actualtext != '');  //make sure it is non-blank and not equal
  BlankSourceAttribute := (djoin.actualtext != djoin.remotetext) and (djoin.actualtext  = '');  //don't want to migrate blank attributes over populated ones
  AttributesAreSame    := (djoin.actualtext  = djoin.remotetext) and (djoin.actualtext != '');  //don't want to migrate blank attributes over populated ones
  warningDestNewer     := (djoin.ModifiedDateSource < djoin.ModifiedDateDestination) ;  //don't want to migrate attributes where the destination attribute is newer
  DestSandboxed        := (djoin.IsSandboxDestination    = true);
  SourceSandboxed      := (djoin.IsSandboxSource         = true);
  DestIsLocked         := (djoin.IsLockedDestination     = true);
  SourceIsLocked       := (djoin.IsLockedSource          = true);
  DestIsCheckedOut     := (djoin.IsCheckedOutDestination = true);
  SourceIsCheckedOut   := (djoin.IsCheckedOutSource      = true);
  DestIsOrphaned       := (djoin.IsOrphanedDestination   = true);
  SourceIsOrphaned     := (djoin.IsOrphanedSource        = true);
  allfilt              := joinfilt and not(warningDestNewer or DestSandboxed or SourceSandboxed or DestIsLocked or SourceIsLocked or DestIsCheckedOut or SourceIsCheckedOut or DestIsOrphaned or SourceIsOrphaned);
  allfiltNot           := joinfilt ;
  
  djoinfilt             := djoin(joinfilt                   );
  dBlankSourceAttribute := djoin(BlankSourceAttribute       );
  dAttributesAreSame    := djoin(AttributesAreSame          );
  dwarningDestNewer     := djoin(joinfilt,warningDestNewer  );
  dDestSandboxed        := djoin(joinfilt,DestSandboxed     );
  dSourceSandboxed      := djoin(joinfilt,SourceSandboxed   );
  dDestIsLocked         := djoin(joinfilt,DestIsLocked      );
  dSourceIsLocked       := djoin(joinfilt,SourceIsLocked    );
  dDestIsCheckedOut     := djoin(joinfilt,DestIsCheckedOut  );
  dSourceIsCheckedOut   := djoin(joinfilt,SourceIsCheckedOut);
  dDestIsOrphaned       := djoin(joinfilt,DestIsOrphaned    );
  dSourceIsOrphaned     := djoin(joinfilt,SourceIsOrphaned  );
  djoinfiltall          := djoin(allfilt);
  djoinfiltallNot       := djoin(allfiltNot);

  dwarnings             := 
    dBlankSourceAttribute  
  + dwarningDestNewer      
  + dwarningDestNewer      
  + dDestSandboxed         
  + dSourceSandboxed     
  + dDestIsLocked        
  + dSourceIsLocked      
  + dDestIsCheckedOut      
  + dSourceIsCheckedOut    
  + dDestIsOrphaned        
  + dSourceIsOrphaned      
  ;
  
  dout := if(pOverrideWarnings = true  ,djoinfiltallNot ,djoinfiltall );
  
	saveatts := apply(dout	,output(tools.mod_Soapcalls.fSaveAttribute(modulename,attributename,actualtext,pDestinationEsp),NAMED('SaveAtts'),EXTEND));

  outputwarnings := parallel(
     if(exists(dBlankSourceAttribute  ) ,output(dBlankSourceAttribute ,named('BlankAttributesToMigrate0'        )))
    ,if(exists(dAttributesAreSame     ) ,output(dAttributesAreSame    ,named('AttributesAreSame'                )))
    ,if(exists(dwarningDestNewer      ) ,output(dwarningDestNewer     ,named('DestinationAttributeIsNewer0'     )))
    ,if(exists(dDestSandboxed         ) ,output(dDestSandboxed        ,named('DestinationAttributeIsSandboxed0' )))
    ,if(exists(dSourceSandboxed       ) ,output(dSourceSandboxed      ,named('SourceAttributeIsSandboxed0'      )))
    ,if(exists(dDestIsLocked          ) ,output(dDestIsLocked         ,named('DestinationAttributeIsLocked0'    )))
    ,if(exists(dSourceIsLocked        ) ,output(dSourceIsLocked       ,named('SourceAttributeIsLocked0'         )))
    ,if(exists(dDestIsCheckedOut      ) ,output(dDestIsCheckedOut     ,named('DestinationAttributeIsCheckedOut0')))
    ,if(exists(dSourceIsCheckedOut    ) ,output(dSourceIsCheckedOut   ,named('SourceAttributeIsCheckedOut0'     )))
    ,if(exists(dDestIsOrphaned        ) ,output(dDestIsOrphaned       ,named('DestinationAttributeIsOrphaned0'  )))
    ,if(exists(dSourceIsOrphaned      ) ,output(dSourceIsOrphaned     ,named('SourceAttributeIsOrphaned0'       )))
  );
  
  outputstuff := sequential(output(dout,named('NoIssues'),all),output(dout+ dSourceSandboxed,named('NoIssuesPlusSourceSandboxed'),all),outputwarnings);

	return iff(pShouldSaveAtts	= false	,outputstuff
																			,saveatts
				);
	
end;
