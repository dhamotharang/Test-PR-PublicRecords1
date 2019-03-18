

IMPORT AccountMonitoring;

EXPORT product_configs(
		UNSIGNED8 product_mask, 
		UNSIGNED1 pseudo_environment, 
		DATASET(AccountMonitoring.layouts.portfolio.base) ddpd_portfolio = DATASET([],AccountMonitoring.layouts.portfolio.base),
		AccountMonitoring.i_Job_Config job_config = MODULE(AccountMonitoring.i_Job_Config) END
	) := MODULE

	SHARED define_product_type_config(in_product, cgm, mask, pseudo_env) := MACRO
		
		EXPORT in_product := MODULE(AccountMonitoring.i_Monitoring_Product_Config)
			
			// Scalar values.
			EXPORT UNSIGNED8 product_mask_value   := AccountMonitoring.types.productMask.in_product;
			EXPORT BOOLEAN   product_is_in_mask   := AccountMonitoring.types.testPMBits(mask, product_mask_value);
			EXPORT BOOLEAN   monitorable_entities := AccountMonitoring.types.testPMBits(mask, product_mask_value); // TODO: remove; it's unused.
			EXPORT STRING    history_file_name    := AccountMonitoring.filenames(pseudo_env).history.in_product;
			
			// Datasets.
			EXPORT DATASET(AccountMonitoring.layouts.history) history_file 
			           := AccountMonitoring.files(pseudo_env).history.in_product;
			
			// Portfolio and Document Files.
			SHARED portfolio := ddpd_portfolio(action_code != constants.actions.delete AND AccountMonitoring.types.testPMBits(ddpd_portfolio.product_mask, product_mask_value));
			
			SHARED stored_documents := DEDUP(SORT(AccountMonitoring.files(pseudo_env).documents.in_product.base,pid,rid,hid,-timestamp),pid,rid,hid);
			SHAREd documents := stored_documents(action_code != constants.actions.delete);
			
			SHARED cgm_results := AccountMonitoring.cgm( portfolio, documents, job_config );
			
			// For any records in the portfolio that have the delete indicator on, we are going to create a
			// fake history record that has a 0 hashvalue.
			SHARED delete_results := PROJECT(
				ddpd_portfolio(action_code = AccountMonitoring.constants.actions.delete AND AccountMonitoring.types.testPMBits(ddpd_portfolio.product_mask, product_mask_value)),
				TRANSFORM(AccountMonitoring.layouts.history,
					SELF.pid := LEFT.pid,
					SELF.rid := LEFT.rid,
					SELF.hid := 0,
					SELF.did := 0,
					SELF.bdid := 0,
					SELF.product_mask := product_mask_value,
					SELF.hash_value := 0,
					SELF.timestamp := '')) + PROJECT(
				stored_documents(action_code = AccountMonitoring.constants.actions.delete),
				TRANSFORM(AccountMonitoring.layouts.history,
					SELF.pid := LEFT.pid,
					SELF.rid := LEFT.rid,
					SELF.hid := LEFT.hid,
					SELF.did := 0,
					SELF.bdid := 0,
					SELF.product_mask := product_mask_value,
					SELF.hash_value := 0,
					SELF.timestamp := ''));
					
			// Functions.
			EXPORT DATASET(AccountMonitoring.layouts.history) generate_candidates() :=
				cgm_results + delete_results;
			
		END;
			
	ENDMACRO;
	
	define_product_type_config(bankruptcy,fn_cgm_bankruptcy,product_mask,pseudo_environment);
	define_product_type_config(deceased,fn_cgm_deceased,product_mask,pseudo_environment);
	define_product_type_config(address,fn_cgm_address,product_mask,pseudo_environment);
	define_product_type_config(phone,fn_cgm_phone,product_mask,pseudo_environment);
	define_product_type_config(paw,fn_cgm_paw,product_mask,pseudo_environment);
	define_product_type_config(property,fn_cgm_property,product_mask,pseudo_environment);
	define_product_type_config(litigiousdebtor,fn_cgm_litigiousdebtor,product_mask,pseudo_environment);
	define_product_type_config(liens,fn_cgm_liens,product_mask,pseudo_environment);
	define_product_type_config(criminal,fn_cgm_criminal,product_mask,pseudo_environment);
	define_product_type_config(phonefeedback,fn_cgm_phonefeedback,product_mask,pseudo_environment);
	define_product_type_config(foreclosure,fn_cgm_foreclosure,product_mask,pseudo_environment);
	define_product_type_config(workplace,fn_cgm_workplace,product_mask,pseudo_environment);
	define_product_type_config(reverseaddress,fn_cgm_reverseaddress,product_mask,pseudo_environment);
	define_product_type_config(didupdate,fn_cgm_didupdate,product_mask,pseudo_environment);
	define_product_type_config(bdidupdate,fn_cgm_bdidupdate,product_mask,pseudo_environment);
	define_product_type_config(phoneownership,fn_cgm_phoneownership,product_mask,pseudo_environment);
	define_product_type_config(bipbestupdate,fn_cgm_bipupdate,product_mask,pseudo_environment);
	define_product_type_config(sbfe,fn_cgm_sbfe,product_mask,pseudo_environment);
	define_product_type_config(ucc,fn_cgm_ucc,product_mask,pseudo_environment);
	define_product_type_config(govtdebarred,fn_cgm_govtdebarred,product_mask,pseudo_environment);
	define_product_type_config(inquiry,fn_cgm_inquiry,product_mask,pseudo_environment);
	define_product_type_config(corp,fn_cgm_corp,product_mask,pseudo_environment);
	define_product_type_config(mvr,fn_cgm_mvr,product_mask,pseudo_environment);
	define_product_type_config(aircraft,fn_cgm_aircraft,product_mask,pseudo_environment);
	define_product_type_config(watercraft,fn_cgm_watercraft,product_mask,pseudo_environment);
	define_product_type_config(personheader,fn_cgm_personheader,product_mask,pseudo_environment);
	
END;