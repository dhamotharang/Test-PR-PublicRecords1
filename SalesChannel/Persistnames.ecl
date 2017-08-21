import lib_fileservices;
export Persistnames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	
	export Root := _Constants(pUseOtherEnvironment).persistTemplate;
	
	export AsPOE								:= root + 'As_POE'								;
	export IngestIt							:= root + 'Ingest'								;
	export AppendAID						:= root + 'Append_AID'						;
	export AppendDID						:= root + 'Append_DID'						;
	export AppendBDID						:= root + 'Append_BDID'						;

	export All := dataset([

		  {AsPOE			}
		 ,{IngestIt		}
		 ,{AppendAID	}
		 ,{AppendDID	}
		 ,{AppendBDID	}

		], lib_fileservices.FsLogicalFileNameRecord);
	
end;