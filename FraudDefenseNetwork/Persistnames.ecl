import lib_fileservices;
export Persistnames :=
module
	
	shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export GlB5				    := root + 'Append_name::Glb5'					;

		export All := dataset([
		 {GlB5			}
		      
	], lib_fileservices.FsLogicalFileNameRecord);


end;