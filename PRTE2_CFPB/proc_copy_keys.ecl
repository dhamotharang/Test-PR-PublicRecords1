IMPORT _control, STD, data_services;

EXPORT proc_copy_keys := module


SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

//NonFCRA Keys
CopyFiles1('~thor::key::cfpb::qa::census_surnames',			constants.KEY_PREFIX	+ current_version + '::census_surnames', dest_cluster);
CopyFiles1('~thor::key::cfpb::qa::blkgrp_attr_over18',	constants.KEY_PREFIX  + current_version + '::blkgrp_attr_over18', dest_cluster);
CopyFiles1('~thor::key::cfpb::qa::blkgrp',							constants.KEY_PREFIX	+ current_version + '::blkgrp', dest_cluster);


//FCRA Keys
CopyFiles1('~thor::key::cfpb::fcra::qa::census_surnames',			constants.KEY_PREFIX + 'fcra::'+ current_version + '::census_surnames', dest_cluster);
CopyFiles1('~thor::key::cfpb::fcra::qa::blkgrp_attr_over18',	constants.KEY_PREFIX + 'fcra::'+ current_version + '::blkgrp_attr_over18', dest_cluster);
CopyFiles1('~thor::key::cfpb::fcra::qa::blkgrp',							constants.KEY_PREFIX + 'fcra::'+ current_version + '::blkgrp', dest_cluster);
 
 
RETURN 'Success';	
	END;

END;