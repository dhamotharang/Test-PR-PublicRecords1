import lib_stringlib,lib_FileServices;

export MAC_Keys_CopyProcess(basename, source_cluster, destination_cluster, filedate, seq_name) := macro

#uniquename(src_cluster_name)
#uniquename(dest_cluster_name)

%src_cluster_name%  := '~' + source_cluster + '::key';
%dest_cluster_name% := '~' + destination_cluster + '::key';
//get the subfile name on source data location
//copy subfile on destination data location and add to superfile

 seq_name := sequential(fileservices.Copy(%src_cluster_name%  + basename + '_built', destination_cluster, %dest_cluster_name% + '::'+filedate + basename,,,,,true,true),             
						FileServices.ClearSuperFile(%dest_cluster_name% + basename	+	'_father',true),
						FileServices.AddSuperFile(%dest_cluster_name% + basename	+	'_father', %dest_cluster_name% + basename + '_built',,true),
						FileServices.ClearSuperFile(%dest_cluster_name% + basename +'_built'),
                        fileservices.addsuperfile(%dest_cluster_name% + basename + '_built', %dest_cluster_name% + '::'+filedate + basename));
 endmacro; 
 


