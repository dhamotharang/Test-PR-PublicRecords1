import lib_fileservices;
export Persistnames(

	boolean	pUseProd = false

):=
module
	
	shared root := _Dataset(pUseProd).thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export AsBusinessHeader		:= root + 'As_Business_Header'			;
	export AppendAIDForPOE		:= root + 'Append_AID_For_POE.fall'	;
	export AsPOE							:= root + 'As_POE'									;


		export All := dataset([
		 {AsBusinessHeader	}
		,{AppendAIDForPOE		}
		,{AsPOE							}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;