IMPORT _control, PRTE_CSV;

EXPORT Proc_Build_IP_Metadata_Keys(string pIndexVersion) := function
	
	rKeyIP_Metadata := record
		PRTE_CSV.IP_Metadata.rthor_data400_key_IP_Metadata;
	end;
	
	dKeyIP_Metadata	:= 	project(PRTE_CSV.IP_Metadata.dthor_data400_key_IP_Metadata, rKeyIP_Metadata);
	kKeyIP_Metadata	:=	index(dKeyIP_Metadata, {beg_octet1, end_octet1, beg_octet2, end_octet2, beg_octets34, end_octets34}, {dKeyIP_Metadata}, '~prte::key::' + pIndexVersion + '::IP_Metadata');	
	
	return	sequential( build(kKeyIP_Metadata, update),
											PRTE.UpdateVersion('IP_MetadataKeys',													//	Package name
																					pIndexVersion,														//	Package version
																					_control.MyInfo.EmailAddressNormal,				//	Who to email with specifics
																					'B',																			//	B = Boca, A = Alpharetta
																					'N',																			//	N = Non-FCRA, F = FCRA
																					'N'																				//	N = Do not also include boolean, Y = Include boolean, too
																					)
										 );

end;