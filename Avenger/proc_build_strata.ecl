 IMPORT STRATA, UT,Avenger;

export proc_build_strata(STRING version)
 := function
	
	avenger_base := avenger.file_base;

	layout_avenger_stats := record
	avenger_base.tran_type;
	integer CountGroup			:= COUNT(GROUP);
	 discovery_identity_unique_cnt	:= SUM(GROUP,IF(avenger_base.discovery_identity_unique_count<>'',1,0));	
	 auth_fail_cnt := SUM(GROUP, if(avenger_base.auth_fail <> '', 1, 0));
	 auth_fail_status_cnt := SUM(GROUP, if(avenger_base.auth_fail_status <> '', 1, 0));
   tran_date_cnt := SUM(GROUP, if(avenger_base.tran_date <> '', 1, 0));
   quiz_outcome_cnt := SUM(GROUP, if(avenger_base.quiz_outcome <> '', 1, 0));
   auth_outcome_cnt := SUM(GROUP, if(avenger_base.auth_outcome <> '', 1, 0));
   verif_outcome_cnt := SUM(GROUP, if(avenger_base.verif_outcome <> '', 1, 0));
   auth_score := SUM(GROUP, if(avenger_base.auth_score <> '', 1, 0));
   tran_verif_prod_used_cnt := SUM(GROUP, if(avenger_base.tran_verif_prod_used <> '', 1, 0));
   discovery_lexid_returned_cnt := SUM(GROUP, if(avenger_base.discovery_lexid_returned <> '', 1, 0));
   auth_lexid_returned_cnt := SUM(GROUP, if(avenger_base.auth_lexid_returned <> '', 1, 0));
   tran_channel_type_cnt := SUM(GROUP, if(avenger_base.tran_channel_type <> '', 1, 0));
   Tran_Channel_API_ReqType_cnt := SUM(GROUP, if(avenger_base.Tran_Channel_API_ReqType <> '', 1, 0));
   Tran_source_Type_cnt := SUM(GROUP, if(avenger_base.Tran_source_Type <> '', 1, 0));
   question_category_string_cnt := SUM(GROUP, if(avenger_base.question_category_string <> '', 1, 0));
		
	END;
	
	avenger_base_stats := TABLE(avenger_base, layout_avenger_stats, tran_type, few);

strata.createXMLStats(avenger_base_stats,'Avenger','base',version,'wenhong.ma@lexisnexis.com',strataResults_avenger);

basefile_tran_date :=project(avenger_base, transform(recordof(avenger.file_base), self.tran_date := left.tran_date[1..8],
self := left));

tran_date_stats := output(sort(table(basefile_tran_date, {tran_date, cnt := count(group)},  tran_date, few),tran_date), all, named('list_transaction_date'));

  RETURN sequential(strataResults_avenger, tran_date_stats);
	
END;
