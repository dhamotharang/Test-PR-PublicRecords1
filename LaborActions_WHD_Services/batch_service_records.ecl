
IMPORT Autokey_batch, AutoStandardI, BatchServices, Doxie, ut, LaborActions_WHD, LaborActions_WHD_Services;

// Local functions.

get_companyname_penalty(LaborActions_WHD_Services.layouts_batch.Batch_in le, layouts_batch.layout_for_batch_records ri) :=
	FUNCTION
		RETURN ut.mod_penalize.company_name(le.comp_name, ri.employername);
	END;
	
get_address_penalty(LaborActions_WHD_Services.layouts_batch.Batch_in le, layouts_batch.layout_for_batch_records ri) :=
	FUNCTION

		mod_input_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := le.prim_range;  
			EXPORT predir      := le.predir;      
			EXPORT prim_name   := le.prim_name;  
			EXPORT addr_suffix := le.addr_suffix;
			EXPORT postdir     := le.postdir;     
			EXPORT sec_range   := le.sec_range;   
			EXPORT p_city_name := le.p_city_name; 
			EXPORT st          := le.st;          
			EXPORT z5          := le.z5;          
		END;

		mod_matched_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := ri.m_prim_range;
			EXPORT predir      := ri.m_predir;
			EXPORT prim_name   := ri.m_prim_name;
			EXPORT addr_suffix := ri.m_addr_suffix;
			EXPORT postdir     := ri.m_postdir;
			EXPORT sec_range   := ri.m_sec_range;
			EXPORT p_city_name := ri.m_p_city_name;
			EXPORT st          := ri.m_st;
			EXPORT z5          := ri.m_zip;
		END;
		
		RETURN ut.mod_penalize.address(mod_input_address, mod_matched_address);
	END;



EXPORT batch_service_records( DATASET(LaborActions_WHD_Services.layouts_batch.Batch_in) ds_batch_in = DATASET([], LaborActions_WHD_Services.layouts_batch.Batch_in) ) :=
	FUNCTION
		
		// 1.  Search the Autokeys.
		cons := LaborActions_WHD.Constants( filedate := '' );

		ak_keyname := cons.str_autokeyname;
		ak_dataset := cons.ak_dataset;
		ak_typeStr := cons.ak_typeStr;

		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export skip_set := cons.ak_skipSet;
		END;
							
		// 2. Get autokey 'fake' ids (fids) based on batch input.
		ds_fids := Autokey_batch.get_fids( PROJECT(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), ak_keyname, ak_config_data);

		// 3. Obtain the autokey payload.
		fids_deduped := dedup(sort(ds_fids, id), id);
		
		by_Autokey := 
			join(
				fids_deduped, 
				LaborActions_WHD.key_AutokeyPayload,
				keyed(left.id = right.FakeID), 
				TRANSFORM( layouts_batch.layout_for_batch_records,
					SELF.acctno      := LEFT.acctno,
					SELF             := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
			
		// 4. Search by bdid
		by_BDID := 
			JOIN(
				ds_batch_in(bdid != 0),
				LaborActions_WHD.Key_BDID,
				KEYED(LEFT.bdid = RIGHT.bdid),
				TRANSFORM( layouts_batch.layout_for_batch_records,
					SELF.acctno      := LEFT.acctno,
					SELF             := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
		
		// Union; penalize.
		by_all := by_Autokey + by_BDID;
		
		by_all_penalized := 
			JOIN(
				ds_batch_in,
				by_all,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( layouts_batch.layout_for_batch_records,
					SELF.comp_name_penalty     := IF( TRIM(LEFT.comp_name) != '', get_companyname_penalty(LEFT,RIGHT), 0 ),
					SELF.address_penalty       := IF( TRIM(LEFT.prim_name) != '', get_address_penalty(LEFT,RIGHT)    , 0 ),
					SELF                       := RIGHT
				),
				RIGHT OUTER
			);

		recs := by_all_penalized( (comp_name_penalty + address_penalty) < ak_config_data.PenaltThreshold );

		RETURN recs;
		
	END;