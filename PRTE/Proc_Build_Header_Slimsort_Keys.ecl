import	_control, PRTE_CSV, ut;

export	Proc_Build_Header_Slimsort_Keys(string pIndexVersion,string pIndexOldVersion)	:=
function
	
	return	sequential( PRTE.CopyMissingKeys('PersonSlimsortKeys',pIndexVersion,pIndexOldVersion)
											,PRTE.UpdateVersion( 'PersonSlimsortKeys', pIndexVersion, _control.MyInfo.EmailAddressNormal, 'B', 'N', 'N')
										 );

end;