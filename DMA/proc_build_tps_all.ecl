import	DMA,RoxieKeyBuild,ut, Delta_Utilities;

export	proc_build_tps_all(string	fileDate)	:=
module
	
	shared	fileTPSBaseNational	:=	DMA.File_suppressionTPS_National(PhoneNumber	!=	'');
	
	export	proc_build_base_national	:=
	function
		fileNationalIn			:=	DMA.File_In_SuppressionTPS_National(PhoneNumber	!=	'');
		
		fileNationalDeletes	:=	fileNationalIn(trim(Indicator)	=		'D');
		fileNationalAdds		:=	fileNationalIn(trim(Indicator)	!=	'D');
		
		DMA.layout_suppressionTPS.Base	t_removeDeletes(fileTPSBaseNational	l,fileNationalDeletes	r)	:=
		transform
			self	:=	l;
		end;
		
		removeDeletes	:=	join(	distribute(fileTPSBaseNational,hash32(phonenumber)),
														distribute(fileNationalDeletes,hash32(phonenumber)),
														left.phonenumber	=	right.phonenumber,
														t_removeDeletes(left,right),
														left only,
														local
													);
		
		DMA.layout_suppressionTPS.Base	filterNationalPhone(fileNationalAdds	l)	:=
		transform
			self.source				:=	'NTL';
			self.phonenumber	:=	REGEXFIND('[0-9]{10}',l.PhoneNumber,0);
		end;
		
		NationalPhone	:=	project(fileNationalAdds,filterNationalPhone(left));
		
		return	NationalPhone+removeDeletes;
	end;
	
	export	proc_build_base	:=
	function
		fileDMAIn						:=	DMA.file_in_suppressionTPS_DMA(PhoneNumber	!=	'');
		
		DMA.layout_suppressionTPS.Base	filterDMAPhone(fileDMAIn l)	:=
		transform
			self.source				:=	'DMA';
			self.phonenumber	:=	REGEXFIND('[0-9]{10}',l.AreaCode+l.PhoneNumber,0);
		end;

		DMAPhone	:=	project(fileDMAIn,filterDMAPhone(left));
		
		baseFile	:=	fileTPSBaseNational+DMAPhone;
        baseFull := dataset('~thor_data400::base::suppression::tps'
		Delta_Utilities.AddRecords( )
		distDNC		:=	distribute(baseFile(PhoneNumber	!=	''	and	(unsigned)PhoneNumber	!=	0),hash32(PhoneNumber));
		srtDNC		:=	sort(distDNC,record,local);
		dedupDNC	:=	dedup(srtDNC,record,local);

		return	dedupDNC;
	end;
	
	export	proc_build_key	:=
	function
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(	DMA.key_DNC_Phone,
																								'~thor_data400::key::DNC::@version@::phone',
																								'~thor_data400::key::DNC::'+fileDate+'::phone',
																								DNCPhoneKeyOut
																							);
											
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	'~thor_data400::key::DNC::@version@::phone',
																						'~thor_data400::key::DNC::'+fileDate+'::phone',
																						mv_dnc
																					);
																				 
		RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::DNC::@version@::phone','Q',mv_dnc_key);
		
		return	sequential(DNCPhoneKeyOut,mv_dnc,mv_dnc_key);
	end;
	
end;