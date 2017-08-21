import lib_stringlib,lib_FileServices;

export MAC_SF_CopyProcess(basename, source_cluster, destination_cluster, seq_name) := macro
/*
basename is 'base::xxxx' on thor400_84
subname is 'base::xxxx'  + thorlib.WUID on thor400_84
*/
#uniquename(workalreadydone)
#uniquename(subname)
#uniquename(src_cluster_name)
#uniquename(dest_cluster_name)

%src_cluster_name%  := '~' + source_cluster + '::';
%dest_cluster_name% := '~' + destination_cluster + '::';

//get the subfile name on source data location
%workalreadydone%(string sub) :=	sub[stringlib.stringfind(sub, '::', 1)+2..];													//only works on resubmit
%subname% := %workalreadydone%(FileServices.GetSuperFileSubName(%src_cluster_name% + basename,1));
//copy subfile on destination data location and add to superfile
 
 seq_name := sequential(fileservices.Copy(%src_cluster_name%  + basename, destination_cluster, %dest_cluster_name% + %subname%,,,,,true,true,,true), 
                        FileServices.ClearSuperFile(%dest_cluster_name% + basename	+	'_father',true),
						FileServices.AddSuperFile(%dest_cluster_name% + basename	+	'_father', %dest_cluster_name% + basename,,true),
						FileServices.ClearSuperFile(%dest_cluster_name% + basename),
                        fileservices.addsuperfile(%dest_cluster_name% + basename, %dest_cluster_name% + %subname%)
						);
 endmacro;
 


