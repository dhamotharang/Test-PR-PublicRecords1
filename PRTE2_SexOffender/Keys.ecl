IMPORT doxie, bipv2, ut, Data_Services, PRTE2_SexOffender, SexOffender, PRTE, AutoKeyB2, autokey, AutoKeyI, Hygenics_search;

EXPORT Keys := MODULE

	df_exp_rec := RECORD
			unsigned8	did;
			string60	seisint_primary_key;
			real			lat;
			real			long;
		END;

	SHARED df_exp := PROJECT(Files.SexOffender_base, TRANSFORM({df_exp_rec}, 
													self := left, 
													self.lat := (real)left.geo_lat,
													self.long := (real)left.geo_long));

	EXPORT Key_SexOffender_DID(BOOLEAN IsFCRA = FALSE) := FUNCTION
		
		df_final := dedup(sort(df_exp(did != 0), record), record);
		df_all 		:= df_final;
		
	RETURN	IF(IsFCRA, INDEX(df_all,{did},{seisint_primary_key, lat, long},PRTE2_SexOffender.Constants.KEY_PREFIX + 'fcra::'+ doxie.Version_SuperKey + '::didpublic'),
								     INDEX(df_all,{did},{seisint_primary_key, lat, long},PRTE2_SexOffender.Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::didpublic'));
	END;

		//FDID
	xl := RECORD
		SexOffender.Layout_fdid;
	END;
	xl xpand(Layouts.AltLayout le,integer cntr) := TRANSFORM 
		SELF.did := cntr + autokey.did_adder('SEX'); 
		self.lat := (real)le.geo_lat;
		self.long := (real)le.geo_long;
		SELF := le; 
	END;
	
	SexOffender_fdid := PROJECT(file_ENH_key,xpand(LEFT,COUNTER));
	
	EXPORT Key_SexOffender_fdid := INDEX(SexOffender_fdid,{did}, {seisint_primary_key, lat, long},
																			PRTE2_SexOffender.Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::fdid_public');
																			
	EXPORT key_sexoffender_offenses(BOOLEAN IsFCRA = FALSE) := FUNCTION
	
		unsigned8 GetOffenseCategory (string3 off_cat) := MAP (
			off_cat ='ABD' => SexOffender.Constants.OffenseCategory.ABDUCTION,
			off_cat ='BUR' => SexOffender.Constants.OffenseCategory.BURGLARY, 
			off_cat ='COM' => SexOffender.Constants.OffenseCategory.COMPUTER_CRIME, 
			off_cat ='CON' => SexOffender.Constants.OffenseCategory.CONTRIBUTING, 
			off_cat ='COR' => SexOffender.Constants.OffenseCategory.CORRUPTION, 
			off_cat ='END' => SexOffender.Constants.OffenseCategory.ENDANGER_WELFARE_OF_MINORS, 
			off_cat ='EXP' => SexOffender.Constants.OffenseCategory.EXPLOITATION, 
			off_cat ='EXS' => SexOffender.Constants.OffenseCategory.EXPOSURE, 
			off_cat ='FAI' => SexOffender.Constants.OffenseCategory.FAILURE_TO_COMPLY, 
			off_cat ='FAL' => SexOffender.Constants.OffenseCategory.FALSE_IMPRISONMENT, 
			off_cat ='IMP' => SexOffender.Constants.OffenseCategory.IMPORTUNING, 
			off_cat ='INC' => SexOffender.Constants.OffenseCategory.INCEST, 
			off_cat ='MUR' => SexOffender.Constants.OffenseCategory.MURDER, 
			off_cat ='OTH' => SexOffender.Constants.OffenseCategory.OTHER, 
			off_cat ='POR' => SexOffender.Constants.OffenseCategory.PORNOGRAPHY, 
			off_cat ='PRO' => SexOffender.Constants.OffenseCategory.PROSTITUTION, 
			off_cat ='RAP' => SexOffender.Constants.OffenseCategory.RAPE, 
			off_cat ='REG' => SexOffender.Constants.OffenseCategory.REGISTRATION, 
			off_cat ='RET' => SexOffender.Constants.OffenseCategory.RESTRAINT, 
			off_cat ='ROB' => SexOffender.Constants.OffenseCategory.ROBBERY, 
			off_cat ='SEX' => SexOffender.Constants.OffenseCategory.SEXUAL_ASSAULT, 
			off_cat ='SAM' => SexOffender.Constants.OffenseCategory.SEXUAL_ASSAULT_MINOR, 
			off_cat ='SOL' => SexOffender.Constants.OffenseCategory.SOLICITATION, 
			off_cat ='UNL' => SexOffender.Constants.OffenseCategory.UNLAWFUL_COMMUNICATION_MINOR, 
			0);



		pGetCategory	:= PROJECT(Files.SexOffense_base, TRANSFORM(Layouts.lOffenseKey, self.sspk := left.seisint_primary_key; self.offense_category := GetOffenseCategory (left.offense_category[1..3]) +
																												GetOffenseCategory (left.offense_category[5..7]); self := left;));

// DF-21920 Blank out specified fields in prte::key::sexoffender::fcra::offenses_public_qa
	ut.MAC_CLEAR_FIELDS(pGetCategory, pGetCategory_cleared, constants.fields_to_clear_offenses_public);
										
	add_all		:= if(isFCRA, pGetCategory_cleared, pGetCategory);

	RETURN INDEX(add_all, {sspk},{add_all},
								if(isFCRA, PRTE2_SexOffender.Constants.KEY_PREFIX + 'fcra::', 
											     PRTE2_SexOffender.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::offenses_public');
	END;
	
	
	EXPORT Key_SexOffender_SPK(BOOLEAN IsFCRA = FALSE) := FUNCTION
		l_ofdr_exp	:= RECORD
			Layouts.SexOffender_out - [lat, long];
			real lat;
			real long;
		END;	

		Ofdr_exp := PROJECT(Files.SexOffender_base, TRANSFORM(l_ofdr_exp,
											self.lat := (real)left.geo_lat;
											self.long	:= (real)left.geo_long;
                      self := left));

   ofdr_prj := Ofdr_exp;
	// DF-21920 Blank out specified fields in prte::key::sexoffender::fcra::spkpublic_qa
	ut.MAC_CLEAR_FIELDS(ofdr_prj, ofdr_prj_cleared, constants.fields_to_clear_spkpublic);
										
	Ofdr_all		:= if(isFCRA, ofdr_prj_cleared, ofdr_prj);

	RETURN INDEX(Ofdr_all, 
							{string60 sspk := Ofdr_all.seisint_primary_key},
							{Ofdr_all},
							if(isFCRA, PRTE2_SexOffender.Constants.KEY_PREFIX + 'fcra::', 
											   PRTE2_SexOffender.Constants.KEY_PREFIX) + doxie.Version_SuperKey + '::spkpublic');
	END;
	
	
	//ENH key
	r := RECORD
		string60 	seisint_primary_key;
		sexoffender.Layout_in_Alt;
	END;
	
	pSPK_ENH	:= PROJECT(file_ENH_key, TRANSFORM(r, SELF := LEFT));
	
	EXPORT Key_SexOffender_SPK_Enh := INDEX(pSPK_ENH, {string60 sspk := pSPK_ENH.seisint_primary_key}, {pSPK_ENH}, 
																					PRTE2_SexOffender.Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::enhpublic');
																					
	xl := RECORD
		Layouts.AltLayout;
		zero := 0;
		unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SEX'))| ut.bit_set(0,0);
		real lat;
		real long;
	END;

	xl xpand(file_ENH_key le,integer cntr) := TRANSFORM 
		SELF.did := cntr + autokey.did_adder('SEX'); 
		self.lat := (real)(ziplib.ZipToGeo21(le.alt_zip)[1..9]),
		self.long := (real)(ziplib.ZipToGeo21(le.alt_zip)[11..]),
		SELF := le; 
	END;

	DS := PROJECT(file_ENH_key,xpand(LEFT,COUNTER));
		
	f_zip_type_base 			:= project(DS,transform(sexoffender.layout_zip_type_key,
														self.alt_zip := (INTEGER4)left.alt_zip,
														self.yob := (UNSIGNED2)(left.dob[1..4]),
														self.dob := (INTEGER4)left.dob, 
														self := left))(alt_zip<>0);
														
	EXPORT Key_SexOffender_Zip_Type := INDEX(f_zip_type_base, {alt_zip, alt_type, yob, dob}, {did},
																					PRTE2_SexOffender.Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::zip_type_public');
																					
END;
										