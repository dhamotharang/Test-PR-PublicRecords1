import	_control, PRTE_CSV, ut;

export	Proc_Build_Header_Source_Keys(string pIndexVersion,string pIndexOldVersion)	:=
function
	
	return	sequential( PRTE.CopyMissingKeys('SourceKeys',pIndexVersion,pIndexOldVersion)
											,PRTE.UpdateVersion( 'SourceKeys', pIndexVersion, _control.MyInfo.EmailAddressNormal, 'B', 'N', 'N')
										 );

end;