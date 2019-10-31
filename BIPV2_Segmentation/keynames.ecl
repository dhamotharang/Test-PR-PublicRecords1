import tools;

EXPORT keynames(

   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false
  ,string   pCluster              = ''	
  
) :=
module

	shared lprefix	:= _Constants(pUseOtherEnvironment).prefix;

  shared lcluster := lprefix + if(pCluster = ''  ,'thor_data400'
                                                 ,pCluster
                               ) 
                     + '::';

	export seg_linkids  := tools.mod_FilenamesBuild(lcluster + 'key::bipv2::business_header::@version@::segmentation_linkids'            ,pversion    );

  export dall_filenames := seg_linkids.dall_filenames;

end;