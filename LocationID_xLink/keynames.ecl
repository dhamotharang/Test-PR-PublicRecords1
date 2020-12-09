import tools, LocationID;

export keynames(
                 string  pversion               = ''
                ,boolean pUseOtherEnvironment  = false
                ,string  pCluster              = ''
               ) :=
module

  shared lprefix					:= LocationID._Constants(pUseOtherEnvironment).prefix;
  shared lcluster					:= lprefix + if(pCluster = '', 'thor_data400',pCluster) + '::';		
	
  export refs_STATECITY		:= tools.mod_FilenamesBuild(lcluster + 'key::LocationId_xLink::@version@::LocId::Refs::STATECITY' ,pversion);
  export refs_ZIP    			:= tools.mod_FilenamesBuild(lcluster + 'key::LocationId_xLink::@version@::LocId::Refs::ZIP' ,pversion);			
  export refs							:= tools.mod_FilenamesBuild(lcluster + 'key::LocationId_xLink::@version@::LocId::Refs' ,pversion);			
  export words						:= tools.mod_FilenamesBuild(lcluster + 'key::LocationId_xLink::@version@::LocId::Words' ,pversion);			
  export meow							:= tools.mod_FilenamesBuild(lcluster + 'key::LocationId_xLink::@version@::LocId::Meow' ,pversion);			
  export sup_rid					:= tools.mod_FilenamesBuild(lcluster + 'key::LocationId_xLink::@version@::LocId::Sup::Rid' ,pversion);			

  export dall_filenames := 
		refs_STATECITY.dall_filenames
	+ refs_ZIP.dall_filenames
	+ refs.dall_filenames
	+ words.dall_filenames
	+ meow.dall_filenames
	+ sup_rid.dall_filenames
  ;

end;
