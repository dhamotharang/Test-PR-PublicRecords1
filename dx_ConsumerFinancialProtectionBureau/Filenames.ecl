import $;
export Filenames(boolean isfcra = false) := module
	export keyCensus_surnames :=  '~thor::' +'key::CFPB::' + if(isfcra,'fcra::','') + 'qa' + '::census_surnames' ;
	export keyBLKGRP :=  '~thor::' +'key::CFPB::' + if(isfcra,'fcra::','') + 'qa' + '::BLKGRP' ;
	export keyBLKGRP_attr_over18 :=  '~thor::' +'key::CFPB::' + if(isfcra,'fcra::','') + 'qa' + '::BLKGRP_attr_over18' ;
end;
