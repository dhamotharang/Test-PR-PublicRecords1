import _Control,versioncontrol;
export fn_despray	(string pSourceFile			=	'thor_data400::in::hdr_west_20100419'
					,string pDestinationpath	=	'/data_lib/despray/'
					,string pDestinationIP		=	_Control.IPAddress.edata14		) := function

Destinationpath	:=	pDestinationpath + pSourceFile[stringlib.stringfind(pSourceFile,':',4)+1..];

myfilestodespray:=dataset([{'~'+pSourceFile, pDestinationIP, Destinationpath}],	versioncontrol.Layout_DKCs.Input);

return versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo',true);

end;