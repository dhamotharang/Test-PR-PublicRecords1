import LN_PropertyV2,ut;
EXPORT changeControl := MODULE

	EXPORT epic := MODULE
			EXPORT layoutNewFields := MODULE
					EXPORT assessment := RECORD
						
							string3	 ln_ownership_rights;
							string2	 ln_relationship_type;
							string3	 ln_mailing_country_code;
							string50 ln_property_name;
							string1	 ln_property_name_type;
							string1	 ln_land_use_category;
							string20 ln_lot;
							string20 ln_block;
							string6	 ln_unit;
							string1  ln_subfloor;
							string3  ln_floor_cover;
							string1	 ln_mobile_home_indicator;
							string1	 ln_condo_indicator;
							string1	 ln_property_tax_exemption;
							string1	 ln_veteran_status;
							string1	 ln_old_apn_indicator;
							
					END;
					EXPORT deed := RECORD
						string3	 ln_ownership_rights;
						string2	 ln_relationship_type;
						string3	 ln_buyer_mailing_country_code;
						string3	 ln_seller_mailing_country_code;
					END;
			END;
			SHARED p:= '';//'ut.foreign_prod'
			EXPORT oldFileAssessment := 
					dataset(p+'~thor_data400::in::ln_propertyv2::assessor',LN_PropertyV2.Layout_Property_Common_Model_BASE - 
					layoutNewFields.assessment,thor);
			EXPORT oldFileAssessmentRepl := 
					dataset(p+'~thor_data400::in::ln_propertyv2::assessor_repl',LN_PropertyV2.Layout_Property_Common_Model_BASE - 
					layoutNewFields.assessment,thor);
			EXPORT oldFileDeed :=
					dataset(p+'~thor_data400::in::ln_propertyv2::deed',LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE - 
					layoutNewFields.deed,thor);
			EXPORT oldFileDeedRepl :=
					dataset(p+'~thor_data400::in::ln_propertyv2::deed_repl',LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE - 
					layoutNewFields.deed,thor);
			EXPORT oldFileMortgage :=
					dataset(p+'~thor_data400::in::ln_propertyv2::deed',LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE - 
					layoutNewFields.deed,thor);
			EXPORT oldFileMortgageRepl :=
					dataset(p+'~thor_data400::in::ln_propertyv2::deed_repl',LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE - 
					layoutNewFields.deed,thor);
	END;
END;