import lib_fileservices;

export Persistnames(
	boolean	pUseOtherEnvironment = false
) :=
module
	
	shared root := _Dataset(pUseOtherEnvironment).thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export BWRCreateHRIAddrSic			:= root + 'BWR_Create_HRI_Addr_Sic'				;
	export BWRCreateHRIAddrSicFCRA	:= root + 'BWR_Create_HRI_Addr_Sic_FCRA'	;
	export BWRCreateHRIAddrSic2			:= root + 'BWR_Create_HRI_Addr_Sic2'			;
	export fAllBusinesses						:= root + 'fAll_Businesses'								;

		export All := dataset([
		 {BWRCreateHRIAddrSic			}
		,{BWRCreateHRIAddrSicFCRA	}
		,{BWRCreateHRIAddrSic2		}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;