import lib_fileservices;
export Persistnames :=
module
	
	shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export GlB5				    := root + 'Append_name::Glb5'					;
	export AppendAID      := root + 'AppendAddress_Id'       ; 
	export AppendIds			:= root + 'Append_Ids::Bdid'				;
  export AppendDIds			:= root + 'Append_Ids::did'				;                     

		export All := dataset([
		 {GlB5			},
		 {AppendAID    }, 
		 {AppendIds			},
		 {AppendDIds			}
		      
	], lib_fileservices.FsLogicalFileNameRecord);


end;