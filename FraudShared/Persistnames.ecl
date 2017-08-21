import lib_fileservices;
export Persistnames :=
module

	shared root := Platform.thor_cluster_Persists(false) + 'persist::' + Platform.name(false) + '::';

	
	export AppendAID      := root + 'AppendAddress_Id'       ; 
	export AppendIds			:= root + 'Append_Ids::Bdid'				;
  export AppendDIds			:= root + 'Append_Ids::did'				;                     

		export All := dataset([
		 {AppendAID    }, 
		 {AppendIds			},
		 {AppendDIds			}
		      
	], lib_fileservices.FsLogicalFileNameRecord);


end;