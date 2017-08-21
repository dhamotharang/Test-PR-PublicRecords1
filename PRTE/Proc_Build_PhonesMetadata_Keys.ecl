import	_control, PRTE_CSV;

EXPORT Proc_Build_PhonesMetadata_Keys(string pIndexVersion) := function

	//Phone Metadata Key
	rKeyPhones_ported_metadata := record
		PRTE_CSV.PhonesMetadata.rthor_data400_key_phones_ported_metadata;
	end;
	
	dKeyPhones_ported_metadata				:= 	project(PRTE_CSV.PhonesMetadata.dthor_data400_key_phones_ported_metadata, rKeyPhones_ported_metadata);
	kKeyPhones_ported_metadata				:=	index(dKeyPhones_ported_metadata, {phone}, {dKeyPhones_ported_metadata}, '~prte::key::' + pIndexVersion + '::phones_ported_metadata');
	
	//Phone Carrier Reference Key
	rKeyPhones_metadata_carrier_reference := record
		PRTE_CSV.PhonesMetadata.rthor_data400_key_phones_metadata_carrier_reference;
	end;
	
	dKeyPhones_metadata_carrier_reference	:= 	project(PRTE_CSV.PhonesMetadata.dthor_data400_key_phones_metadata_carrier_reference, rKeyPhones_metadata_carrier_reference);
	kKeyPhones_metadata_carrier_reference	:=	index(dKeyPhones_metadata_carrier_reference, {ocn, name}, {dKeyPhones_metadata_carrier_reference}, '~prte::key::' + pIndexVersion + '::phonesmetadata::carrier_reference');	
	
	return	sequential(
											parallel(
																build(kKeyPhones_ported_metadata, update),
																build(kKeyPhones_metadata_carrier_reference, update),
															 ),
																					PRTE.UpdateVersion('PhonesMetadataKeys',	//	Package name
																					pIndexVersion,														//	Package version
																					_control.MyInfo.EmailAddressNormal,				//	Who to email with specifics
																					'B',																			//	B = Boca, A = Alpharetta
																					'N',																			//	N = Non-FCRA, F = FCRA
																					'N'																				//	N = Do not also include boolean, Y = Include boolean, too
																					)
										 );

end;
