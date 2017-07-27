
IMPORT Autokey_batch, BatchServices, DriversV2, DriversV2_Services, STD, Govt_Collections_Services, lib_stringlib;

EXPORT fn_getDriversLicenseRecs(dataset(Govt_Collections_Services.Layouts.batch_working) ds_batch_in,
                                Govt_Collections_Services.IParams.BatchParams in_mod ) := 
	FUNCTION
		
		// Fulfills _documentation, Req. 4.1.12

		// The following #STOREDs, etc., are read from global scope by DriversV2_Services
		// .Batch_Service_Records. They cannot be passed as formal parameters.
		#STORED('IncludeNonDMVSources', TRUE);
		
		today := (UNSIGNED4)StringLib.getDateYYYYMMDD() : GLOBAL;

		// --------------------[ LOCAL LAYOUTS, FUNCTIONS ]--------------------

		layout_dl_result_narrow := RECORD
			STRING20 acctno := '';
			DriversV2_Services.layouts.result_narrow;
		END;
		
		fn_addresses_are_equivalent(Govt_Collections_Services.Layouts.batch_working le, layout_dl_result_narrow ri) :=
			FUNCTION
				same_addr := 
					STD.Str.FilterOut( le.best_addr1, ' ' ) = STD.Str.FilterOut( ri.addr1, ' ' ) AND
					STD.Str.FilterOut( le.best_city, ' ' )  = STD.Str.FilterOut( ri.city, ' ' ) AND
					STD.Str.FilterOut( le.best_state, ' ' ) = STD.Str.FilterOut( ri.st, ' ' ) AND
					STD.Str.FilterOut( le.best_zip, ' ' )   = STD.Str.FilterOut( ri.zip, ' ' );
				RETURN same_addr;
			END;
		
		// --------------------[ END LOCAL LAYOUTS, FUNCTIONS ]--------------------
		
		// 1. Transform input required by DrvicersV2 batch service.
		data_in := PROJECT( ds_batch_in, Govt_Collections_Services.Transforms.xfm_to_DriversV2_batchIn(LEFT) );
		
		cfgs := MODULE(DriversV2_Services.GetDLParams.batch_params)
			EXPORT useAllLookups := TRUE;
			EXPORT skip_set      := DriversV2.Constants.autokey_skipSet;
			EXPORT RunDeepDive   := FALSE;
			EXPORT boolean return_current_only	:= TRUE;
			EXPORT UNSIGNED8 MaxResultsPerAcct := in_mod.MaxResultsPerAcct;
		END;
		
		// 2. Get the DL records (narrow view).
		ds_dl_recs_pre := DriversV2_Services.Batch_Service_Records(data_in, cfgs);
		
		// 3. Project into a layout equivalent to the (local) output layout from the batch
		// service to pass to a function in this attribute.		
		ds_dl_recs := PROJECT(ds_dl_recs_pre(penalt < in_mod.PenaltThreshold), layout_dl_result_narrow);
		
		// 4. Check DL record. If DL expiration date > today, and if DL address != Best Address, 
		// fill DL address fields.
		Layouts.batch_working 
				xfm(Govt_Collections_Services.Layouts.batch_working le, layout_dl_result_narrow ri) :=
					TRANSFORM
							same_addr_as_best := fn_addresses_are_equivalent(le, ri);
							expired_license   := (UNSIGNED4)ri.expiration_date <= today;
						SELF.dl_addr1    := IF( same_addr_as_best OR expired_license, '', ri.addr1);		
						SELF.dl_city     := IF( same_addr_as_best OR expired_license, '', ri.city);			
						SELF.dl_st       := IF( same_addr_as_best OR expired_license, '', ri.st);  // 'ri.state' is sometimes numeric	
						SELF.dl_zip      := IF( same_addr_as_best OR expired_license, '', ri.zip);			
						SELF.dl_exp_date := IF( ri.expiration_date > 0, (STRING)ri.expiration_date, '' ); // as YYYYMMDD
						SELF             := le;
					END;
		
		// 5. Join back to batch_in and return.
		ds_dl_results := 
			JOIN(
				ds_batch_in, ds_dl_recs,
				LEFT.acctno = RIGHT.acctno,
				xfm(LEFT, RIGHT),
				LEFT OUTER,
				KEEP(1)
			);
				
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_dl_recs_pre, NAMED('ds_DL_intm_recs') ) );
		
		RETURN ds_dl_results;
		
	END;