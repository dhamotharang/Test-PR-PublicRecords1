import	_control, PRTE_CSV;

export	Proc_Build_DOCImages_Keys(string pIndexVersion)	:=

function

	rKeyDOC__matrix_images_base	:=
		record
			PRTE_CSV.DOCImages.rimages__base__DOC__matrix_images;
		end;
	
	rKeyDOC__matrix_images	:=
		record
			PRTE_CSV.DOCImages.rimages__key__DOC__matrix_images;
		end;

	rKeyDOC__matrix_images_did	:=
		record
			PRTE_CSV.DOCImages.rimages__key__DOC__matrix_images_did;
		end;
		
	// rKeyDOC_v2__matrix_images_base	:=
		// record
			// PRTE_CSV.DOCImages.rimages_v2__base__DOC__matrix_images;
		// end;
	
	// rKeyDOC_v2__matrix_images	:=
		// record
			// PRTE_CSV.DOCImages.rimages_v2__key__DOC__matrix_images;
		// end;

	// rKeyDOC_v2__matrix_images_did	:=
		// record
			// PRTE_CSV.DOCImages.rimages_v2__key__DOC__matrix_images_did;
		// end;
	
	dKeyDOC__matrix_images_base		:= 	project(PRTE_CSV.DOCImages.dimages__base__DOC__matrix_images, rKeyDOC__matrix_images_base);
	dKeyDOC__matrix_images				:= 	project(PRTE_CSV.DOCImages.dimages__key__DOC__matrix_images, rKeyDOC__matrix_images);
	dKeyDOC__matrix_images_did		:= 	project(PRTE_CSV.DOCImages.dimages__key__DOC__matrix_images_did, rKeyDOC__matrix_images_did);
	
	// dKeyDOC_v2__matrix_images_base	:= 	project(PRTE_CSV.DOCImages.dimages_v2__base__DOC__matrix_images, rKeyDOC_v2__matrix_images_base);
	// dKeyDOC_v2__matrix_images				:= 	project(PRTE_CSV.DOCImages.dimages_v2__key__DOC__matrix_images, rKeyDOC_v2__matrix_images);
	// dKeyDOC_v2__matrix_images_did		:= 	project(PRTE_CSV.DOCImages.dimages_v2__key__DOC__matrix_images_did, rKeyDOC_v2__matrix_images_did);
		
	kKeyDOC__matrix_images				:=	index(dKeyDOC__matrix_images, {dKeyDOC__matrix_images}, '~prte::criminal_images::key::criminal::' + pIndexVersion + '::matrix_images');
	kKeyDOC__matrix_images_did		:=	index(dKeyDOC__matrix_images_did, {dKeyDOC__matrix_images_did}, '~prte::criminal_images::key::criminal::' + pIndexVersion + '::matrix_images_did');
	
	// kKeyDOC_v2__matrix_images			:=	index(dKeyDOC_v2__matrix_images, {dKeyDOC_v2__matrix_images}, '~prte::criminal_images_v2::key::criminal::' + pIndexVersion + '::matrix_images');
	// kKeyDOC_v2__matrix_images_did	:=	index(dKeyDOC_v2__matrix_images_did, {dKeyDOC_v2__matrix_images_did}, '~prte::criminal_images_v2::key::criminal::' + pIndexVersion + '::matrix_images_did');
	
return	sequential(
				parallel(
						output(dKeyDOC__matrix_images_base,, '~prte::criminal_images::base::criminal::' + pIndexVersion + '::matrix_images_base'),
						build(kKeyDOC__matrix_images		, update),
						build(kKeyDOC__matrix_images_did	, update)//,
						// output(dKeyDOC_v2__matrix_images_base,, '~prte::criminal_images_v2::base::criminal::' + pIndexVersion + '::matrix_images_base'),
						// build(kKeyDOC_v2__matrix_images		, update),
						// build(kKeyDOC_v2__matrix_images_did	, update)
						),				
							PRTE.UpdateVersion('DOCImagesKeys',										//	Package name
												pIndexVersion,							//	Package version
												_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
												'B',									//	B = Boca, A = Alpharetta
												'N',									//	N = Non-FCRA, F = FCRA
												'N'										//	N = Do not also include boolean, Y = Include boolean, too
												)
												);


end :DEPRECATED('Use PRET2_DOC_IMAGES.PROC_BUILD_ALL');  
