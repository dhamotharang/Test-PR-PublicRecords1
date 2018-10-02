import	_control, PRTE_CSV;

export	Proc_Build_SexOffenderImages_Keys(string pIndexVersion)	:=

function

  rBaseSexOffender__matrix_images_base	:=
		record
			PRTE_CSV.SexOffenderImages.rimages__base__sexoffender__matrix_images_base;
		end;	
	
	rKeySexOffender__matrix_images	:=
		record
			PRTE_CSV.SexOffenderImages.rimages__key__sexoffender__matrix_images;
		end;

	rKeySexOffender__matrix_images_did	:=
		record
			PRTE_CSV.SexOffenderImages.rimages__key__sexoffender__matrix_images_did;
		end;
		
	rBaseSexOffender_v2__matrix_images_base	:=
		record
			PRTE_CSV.SexOffenderImages.rimages__base__sexoffender__matrix_images_base;
		end;	
	
	rKeySexOffender_v2__matrix_images	:=
		record
			PRTE_CSV.SexOffenderImages.rimages__key__sexoffender__matrix_images;
		end;

	rKeySexOffender_v2__matrix_images_did	:=
		record
			PRTE_CSV.SexOffenderImages.rimages__key__sexoffender__matrix_images_did;
		end;
	
  dBaseSexOffender__matrix_images_base			:= 	project(PRTE_CSV.SexOffenderImages.dimages__base__sexoffender__matrix_images_base, rBaseSexOffender__matrix_images_base);	
	dKeySexOffender__matrix_images						:= 	project(PRTE_CSV.SexOffenderImages.dimages__key__sexoffender__matrix_images, rKeySexOffender__matrix_images);
	dKeySexOffender__matrix_images_did				:= 	project(PRTE_CSV.SexOffenderImages.dimages__key__sexoffender__matrix_images_did, rKeySexOffender__matrix_images_did);
	
	dBaseSexOffender_v2__matrix_images_base		:= 	project(PRTE_CSV.SexOffenderImages.dimages__base__sexoffender__matrix_images_base, rBaseSexOffender_v2__matrix_images_base);	
	dKeySexOffender_v2__matrix_images					:= 	project(PRTE_CSV.SexOffenderImages.dimages__key__sexoffender__matrix_images, rKeySexOffender_v2__matrix_images);
	dKeySexOffender_v2__matrix_images_did			:= 	project(PRTE_CSV.SexOffenderImages.dimages__key__sexoffender__matrix_images_did, rKeySexOffender_v2__matrix_images_did);
		
  kKeySexOffender__matrix_images						:=	index(dKeySexOffender__matrix_images, {dKeySexOffender__matrix_images}, '~prte::images::key::sexoffender::' + pIndexVersion + '::matrix_images');
	kKeySexOffender__matrix_images_did				:=	index(dKeySexOffender__matrix_images_did, {dKeySexOffender__matrix_images_did}, '~prte::images::key::sexoffender::' + pIndexVersion + '::matrix_images_did');
	
	kKeySexOffender_v2__matrix_images					:=	index(dKeySexOffender_v2__matrix_images, {dKeySexOffender_v2__matrix_images}, '~prte::images_v2::key::sexoffender::' + pIndexVersion + '::matrix_images');
	kKeySexOffender_v2__matrix_images_did			:=	index(dKeySexOffender_v2__matrix_images_did, {dKeySexOffender_v2__matrix_images_did}, '~prte::images_v2::key::sexoffender::' + pIndexVersion + '::matrix_images_did');
	
return	sequential(
				parallel(
						output(dBaseSexOffender__matrix_images_base,, '~prte::images::base::sexoffender::' + pIndexVersion + '::matrix_images_base'),	
						build(kKeySexOffender__matrix_images		, update),
						build(kKeySexOffender__matrix_images_did	, update),
						output(dBaseSexOffender_v2__matrix_images_base,, '~prte::images_v2::base::sexoffender::' + pIndexVersion + '::matrix_images_base'),	
						build(kKeySexOffender_v2__matrix_images		, update),
						build(kKeySexOffender_v2__matrix_images_did	, update)
						),				
							PRTE.UpdateVersion('SexOffenderImagesKeys',										//	Package name
												pIndexVersion,							//	Package version
												_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
												'B',									//	B = Boca, A = Alpharetta
												'N',									//	N = Non-FCRA, F = FCRA
												'N'										//	N = Do not also include boolean, Y = Include boolean, too
												)
												);

end :DEPRECATED('Use PRET2_SEXOFFENDER_IMAGES.PROC_BUILD_KEYS');
