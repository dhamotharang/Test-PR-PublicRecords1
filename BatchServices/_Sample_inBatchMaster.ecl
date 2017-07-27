IMPORT Autokey_batch, BatchServices, Doxie;

EXPORT _Sample_inBatchMaster(STRING sample_type = '') := 
	FUNCTION
	
		ds_input_raw := CASE( StringLib.StringToUpperCase(sample_type),
													'ADDRESS'      => BatchServices._Sample_Records.Address.ds_sample_input,
													'AKA'          => BatchServices._Sample_Records.AKA.ds_sample_input,
													'BANKRUPTCY' 					=> BatchServices._Sample_Records.Bankruptcy.ds_sample_input,
													'BENEFIT_ASSESSMENT'	=> BatchServices._Sample_Records.Benefit_Assessment.ds_sample_input,
		                      'BUSINESS'     => BatchServices._Sample_Records.Business.ds_sample_input,
													'COMPSFORPER'  => BatchServices._Sample_Records.CompaniesForPerson.ds_sample_input,
													'CORP2'        => BatchServices._Sample_Records.Corp2.ds_sample_input,
													'CRIMINAL'     => BatchServices._Sample_Records.Criminal.ds_sample_input,
													'DEA'          => BatchServices._Sample_Records.Dea.ds_sample_input,
													'DEATH'     	 => BatchServices._Sample_Records.Death.ds_sample_input,
													'DIVERSITYCERT'=> BatchServices._Sample_Records.DiversityCert.ds_sample_input,
													'EMAIL'        => BatchServices._Sample_Records.Email.ds_sample_input,
													'FIRMOGRAPHICS'=> BatchServices._Sample_Records.Firmographics.ds_sample_input,
												'JUDGEMENTSLIENS'=> BatchServices._Sample_Records.JudgementsLiens.ds_sample_input,
													'MEDLIC'       => BatchServices._Sample_Records.Medlic.ds_sample_input,
													'MEDLICPL'     => BatchServices._Sample_Records.MedlicPL.ds_sample_input,
													'NONREGVEH'    => BatchServices._Sample_Records.NonRegVeh.ds_sample_input,
													'PAW'          => BatchServices._Sample_Records.PeopleAtWork.ds_sample_input,
													'POSSIBLELITIGIOUSDEBTOR' => BatchServices._Sample_Records.PossibleLitigiousDebtor.ds_sample_input,
													'PROFLIC'      => BatchServices._Sample_Records.Proflic.ds_sample_input,
		                      'PROPERTY'     => BatchServices._Sample_Records.Property.ds_sample_input,
													'SEARCHPOINT_OUTLET'  => BatchServices._Sample_Records.SearchPoint_OUTLET.ds_sample_input,
													'SEARCHPOINT_PRACTITIONER'  => BatchServices._Sample_Records.SearchPoint_PRACTITIONER.ds_sample_input,
													'SEXPREDATOR'  => BatchServices._Sample_Records.SexPredator.ds_sample_input,
													'WP'           => BatchServices._Sample_Records.WorkPlace.ds_sample_input,
		                      /* ELSE ..... */  BatchServices._Sample_Records.ds_default_sample_input
		                     );

		rec_input_prepped_for_cleaning := RECORD
			BatchServices._Sample_layout_input_raw;
			STRING200 clean_address := '';
		END;

		rec_input_prepped_for_cleaning xfm_preclean_batch(BatchServices._Sample_layout_input_raw l) := 
			TRANSFORM
				SELF := l;
				SELF.clean_address := doxie.cleanaddress182( l.addr, TRIM(l.zip) );
			END;
			
		ds_input_prepped_for_cleaning := PROJECT(ds_input_raw, xfm_preclean_batch(LEFT));

		Autokey_batch.Layouts.rec_inBatchMaster xfm_clean_batch(rec_input_prepped_for_cleaning l) := 
			TRANSFORM
				SELF.acctno            := l.acctno;
				SELF.name_last         := l.name_last;
				SELF.prim_range        := l.clean_address[1..10];
				SELF.predir            := l.clean_address[11..12];
				SELF.prim_name         := l.clean_address[13..40];
				SELF.addr_suffix       := l.clean_address[41..44];
				SELF.postdir           := l.clean_address[45..46];
				SELF.unit_desig        := l.clean_address[47..56];
				SELF.sec_range         := l.clean_address[57..64];
				SELF.p_city_name       := IF( TRIM(l.clean_address[90..114],LEFT,RIGHT) != '', l.clean_address[90..114], l.city );
				SELF.st                := IF( TRIM(l.clean_address[115..116],LEFT,RIGHT) != '', l.clean_address[115..116], l.state );
				SELF.z5                := IF( TRIM(l.clean_address[117..121],LEFT,RIGHT) != '', l.clean_address[117..121], l.zip[1..5] ); 
				SELF.zip4              := l.clean_address[122..125];
				SELF.DOB							 := (String8)l.DOB;
				SELF.score			       := l.score_did;
				SELF.score_bdid 	     := l.score_bdid;
				SELF                   := l;
			END;
				
		ds_input_cleaned := PROJECT(ds_input_prepped_for_cleaning, xfm_clean_batch(LEFT));

		RETURN CHOOSEN(ds_input_cleaned, 100);

	END;
