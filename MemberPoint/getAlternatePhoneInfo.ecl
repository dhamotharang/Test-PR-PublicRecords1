IMPORT MemberPoint, PhoneFinder_Services, Gateway;

		EXPORT getAlternatePhoneInfo(DATASET(MemberPoint.Layouts.BestExtended) inDataSet, MemberPoint.IParam.BatchParams options):= FUNCTION

			gateways:= options.gateways;//DATASET([], Gateway.Layouts.Config);
			// gateways := Gateway.Configuration.Get();
			pfBatchIn := PROJECT(inDataSet, TRANSFORM(PhoneFinder_Services.Layouts.BatchIn,
				SELF.acctno			:= (STRING) LEFT.seq,
				SELF.name_first	:= IF(LEFT.best_fname <> '', LEFT.best_fname, LEFT.fname),
				SELF.name_middle:= IF(LEFT.best_mname <> '', LEFT.best_mname, LEFT.mname),
				SELF.name_last	:= IF(LEFT.best_lname <> '', LEFT.best_lname,LEFT.lname),
				SELF.name_suffix:= LEFT.best_name_suffix,
				SELF.prim_range	:= LEFT.c_best_prim_range,
				SELF.predir			:= LEFT.c_best_predir,
				SELF.prim_name	:= LEFT.c_best_prim_name,
				SELF.addr_suffix:= LEFT.c_best_addr_suffix,
				SELF.postdir		:= LEFT.c_best_postdir,
				SELF.unit_desig	:= LEFT.c_best_unit_desig,
				SELF.sec_range	:= LEFT.c_best_sec_range,
				SELF.p_city_name:= LEFT.c_best_p_city_name,
				SELF.st					:= LEFT.c_best_st,
				SELF.z5					:= LEFT.c_best_z5,
				SELF.z4					:= LEFT.c_best_zip4,
				SELF.ssn				:= IF(LEFT.best_ssn <> '', LEFT.best_ssn, LEFT.ssn),
				SELF.phone			:= LEFT.primary_phone_number,
				SELF.did				:= LEFT.did,
				SELF 						:= []
			));
			pfOptionsIn := MODULE(PROJECT(options, PhoneFinder_Services.iParam.SearchParams, OPT))
				EXPORT BOOLEAN show_minors					:= FALSE;
				EXPORT UNSIGNED PenaltyThreshold			:= options.PenaltThreshold;
				EXPORT BOOLEAN UseInHousePhoneMetadataOnly := TRUE;
			END;
			//PhoneFinder_Services.Layouts.PhoneFinder.BatchOut
			modBatchRecords:= PhoneFinder_Services.PhoneFinder_BatchRecords(pfBatchIn, pfOptionsIn, gateways);
			RETURN (modBatchRecords.dBatchOut);
		END;