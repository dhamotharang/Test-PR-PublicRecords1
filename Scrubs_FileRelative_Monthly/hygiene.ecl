IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_type_cnt := COUNT(GROUP,h.type <> (TYPEOF(h.type))'');
    populated_type_pcnt := AVE(GROUP,IF(h.type = (TYPEOF(h.type))'',0,100));
    maxlength_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.type)));
    avelength_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.type)),h.type<>(typeof(h.type))'');
    populated_confidence_cnt := COUNT(GROUP,h.confidence <> (TYPEOF(h.confidence))'');
    populated_confidence_pcnt := AVE(GROUP,IF(h.confidence = (TYPEOF(h.confidence))'',0,100));
    maxlength_confidence := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.confidence)));
    avelength_confidence := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.confidence)),h.confidence<>(typeof(h.confidence))'');
    populated_did1_cnt := COUNT(GROUP,h.did1 <> (TYPEOF(h.did1))'');
    populated_did1_pcnt := AVE(GROUP,IF(h.did1 = (TYPEOF(h.did1))'',0,100));
    maxlength_did1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did1)));
    avelength_did1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did1)),h.did1<>(typeof(h.did1))'');
    populated_did2_cnt := COUNT(GROUP,h.did2 <> (TYPEOF(h.did2))'');
    populated_did2_pcnt := AVE(GROUP,IF(h.did2 = (TYPEOF(h.did2))'',0,100));
    maxlength_did2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did2)));
    avelength_did2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did2)),h.did2<>(typeof(h.did2))'');
    populated_cohabit_score_cnt := COUNT(GROUP,h.cohabit_score <> (TYPEOF(h.cohabit_score))'');
    populated_cohabit_score_pcnt := AVE(GROUP,IF(h.cohabit_score = (TYPEOF(h.cohabit_score))'',0,100));
    maxlength_cohabit_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cohabit_score)));
    avelength_cohabit_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cohabit_score)),h.cohabit_score<>(typeof(h.cohabit_score))'');
    populated_cohabit_cnt_cnt := COUNT(GROUP,h.cohabit_cnt <> (TYPEOF(h.cohabit_cnt))'');
    populated_cohabit_cnt_pcnt := AVE(GROUP,IF(h.cohabit_cnt = (TYPEOF(h.cohabit_cnt))'',0,100));
    maxlength_cohabit_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cohabit_cnt)));
    avelength_cohabit_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cohabit_cnt)),h.cohabit_cnt<>(typeof(h.cohabit_cnt))'');
    populated_coapt_score_cnt := COUNT(GROUP,h.coapt_score <> (TYPEOF(h.coapt_score))'');
    populated_coapt_score_pcnt := AVE(GROUP,IF(h.coapt_score = (TYPEOF(h.coapt_score))'',0,100));
    maxlength_coapt_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coapt_score)));
    avelength_coapt_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coapt_score)),h.coapt_score<>(typeof(h.coapt_score))'');
    populated_coapt_cnt_cnt := COUNT(GROUP,h.coapt_cnt <> (TYPEOF(h.coapt_cnt))'');
    populated_coapt_cnt_pcnt := AVE(GROUP,IF(h.coapt_cnt = (TYPEOF(h.coapt_cnt))'',0,100));
    maxlength_coapt_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coapt_cnt)));
    avelength_coapt_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coapt_cnt)),h.coapt_cnt<>(typeof(h.coapt_cnt))'');
    populated_copobox_score_cnt := COUNT(GROUP,h.copobox_score <> (TYPEOF(h.copobox_score))'');
    populated_copobox_score_pcnt := AVE(GROUP,IF(h.copobox_score = (TYPEOF(h.copobox_score))'',0,100));
    maxlength_copobox_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.copobox_score)));
    avelength_copobox_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.copobox_score)),h.copobox_score<>(typeof(h.copobox_score))'');
    populated_copobox_cnt_cnt := COUNT(GROUP,h.copobox_cnt <> (TYPEOF(h.copobox_cnt))'');
    populated_copobox_cnt_pcnt := AVE(GROUP,IF(h.copobox_cnt = (TYPEOF(h.copobox_cnt))'',0,100));
    maxlength_copobox_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.copobox_cnt)));
    avelength_copobox_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.copobox_cnt)),h.copobox_cnt<>(typeof(h.copobox_cnt))'');
    populated_cossn_score_cnt := COUNT(GROUP,h.cossn_score <> (TYPEOF(h.cossn_score))'');
    populated_cossn_score_pcnt := AVE(GROUP,IF(h.cossn_score = (TYPEOF(h.cossn_score))'',0,100));
    maxlength_cossn_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cossn_score)));
    avelength_cossn_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cossn_score)),h.cossn_score<>(typeof(h.cossn_score))'');
    populated_cossn_cnt_cnt := COUNT(GROUP,h.cossn_cnt <> (TYPEOF(h.cossn_cnt))'');
    populated_cossn_cnt_pcnt := AVE(GROUP,IF(h.cossn_cnt = (TYPEOF(h.cossn_cnt))'',0,100));
    maxlength_cossn_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cossn_cnt)));
    avelength_cossn_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cossn_cnt)),h.cossn_cnt<>(typeof(h.cossn_cnt))'');
    populated_copolicy_score_cnt := COUNT(GROUP,h.copolicy_score <> (TYPEOF(h.copolicy_score))'');
    populated_copolicy_score_pcnt := AVE(GROUP,IF(h.copolicy_score = (TYPEOF(h.copolicy_score))'',0,100));
    maxlength_copolicy_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.copolicy_score)));
    avelength_copolicy_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.copolicy_score)),h.copolicy_score<>(typeof(h.copolicy_score))'');
    populated_copolicy_cnt_cnt := COUNT(GROUP,h.copolicy_cnt <> (TYPEOF(h.copolicy_cnt))'');
    populated_copolicy_cnt_pcnt := AVE(GROUP,IF(h.copolicy_cnt = (TYPEOF(h.copolicy_cnt))'',0,100));
    maxlength_copolicy_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.copolicy_cnt)));
    avelength_copolicy_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.copolicy_cnt)),h.copolicy_cnt<>(typeof(h.copolicy_cnt))'');
    populated_coclaim_score_cnt := COUNT(GROUP,h.coclaim_score <> (TYPEOF(h.coclaim_score))'');
    populated_coclaim_score_pcnt := AVE(GROUP,IF(h.coclaim_score = (TYPEOF(h.coclaim_score))'',0,100));
    maxlength_coclaim_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coclaim_score)));
    avelength_coclaim_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coclaim_score)),h.coclaim_score<>(typeof(h.coclaim_score))'');
    populated_coclaim_cnt_cnt := COUNT(GROUP,h.coclaim_cnt <> (TYPEOF(h.coclaim_cnt))'');
    populated_coclaim_cnt_pcnt := AVE(GROUP,IF(h.coclaim_cnt = (TYPEOF(h.coclaim_cnt))'',0,100));
    maxlength_coclaim_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coclaim_cnt)));
    avelength_coclaim_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coclaim_cnt)),h.coclaim_cnt<>(typeof(h.coclaim_cnt))'');
    populated_coproperty_score_cnt := COUNT(GROUP,h.coproperty_score <> (TYPEOF(h.coproperty_score))'');
    populated_coproperty_score_pcnt := AVE(GROUP,IF(h.coproperty_score = (TYPEOF(h.coproperty_score))'',0,100));
    maxlength_coproperty_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coproperty_score)));
    avelength_coproperty_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coproperty_score)),h.coproperty_score<>(typeof(h.coproperty_score))'');
    populated_coproperty_cnt_cnt := COUNT(GROUP,h.coproperty_cnt <> (TYPEOF(h.coproperty_cnt))'');
    populated_coproperty_cnt_pcnt := AVE(GROUP,IF(h.coproperty_cnt = (TYPEOF(h.coproperty_cnt))'',0,100));
    maxlength_coproperty_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coproperty_cnt)));
    avelength_coproperty_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coproperty_cnt)),h.coproperty_cnt<>(typeof(h.coproperty_cnt))'');
    populated_bcoproperty_score_cnt := COUNT(GROUP,h.bcoproperty_score <> (TYPEOF(h.bcoproperty_score))'');
    populated_bcoproperty_score_pcnt := AVE(GROUP,IF(h.bcoproperty_score = (TYPEOF(h.bcoproperty_score))'',0,100));
    maxlength_bcoproperty_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoproperty_score)));
    avelength_bcoproperty_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoproperty_score)),h.bcoproperty_score<>(typeof(h.bcoproperty_score))'');
    populated_bcoproperty_cnt_cnt := COUNT(GROUP,h.bcoproperty_cnt <> (TYPEOF(h.bcoproperty_cnt))'');
    populated_bcoproperty_cnt_pcnt := AVE(GROUP,IF(h.bcoproperty_cnt = (TYPEOF(h.bcoproperty_cnt))'',0,100));
    maxlength_bcoproperty_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoproperty_cnt)));
    avelength_bcoproperty_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoproperty_cnt)),h.bcoproperty_cnt<>(typeof(h.bcoproperty_cnt))'');
    populated_coforeclosure_score_cnt := COUNT(GROUP,h.coforeclosure_score <> (TYPEOF(h.coforeclosure_score))'');
    populated_coforeclosure_score_pcnt := AVE(GROUP,IF(h.coforeclosure_score = (TYPEOF(h.coforeclosure_score))'',0,100));
    maxlength_coforeclosure_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coforeclosure_score)));
    avelength_coforeclosure_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coforeclosure_score)),h.coforeclosure_score<>(typeof(h.coforeclosure_score))'');
    populated_coforeclosure_cnt_cnt := COUNT(GROUP,h.coforeclosure_cnt <> (TYPEOF(h.coforeclosure_cnt))'');
    populated_coforeclosure_cnt_pcnt := AVE(GROUP,IF(h.coforeclosure_cnt = (TYPEOF(h.coforeclosure_cnt))'',0,100));
    maxlength_coforeclosure_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coforeclosure_cnt)));
    avelength_coforeclosure_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coforeclosure_cnt)),h.coforeclosure_cnt<>(typeof(h.coforeclosure_cnt))'');
    populated_bcoforeclosure_score_cnt := COUNT(GROUP,h.bcoforeclosure_score <> (TYPEOF(h.bcoforeclosure_score))'');
    populated_bcoforeclosure_score_pcnt := AVE(GROUP,IF(h.bcoforeclosure_score = (TYPEOF(h.bcoforeclosure_score))'',0,100));
    maxlength_bcoforeclosure_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoforeclosure_score)));
    avelength_bcoforeclosure_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoforeclosure_score)),h.bcoforeclosure_score<>(typeof(h.bcoforeclosure_score))'');
    populated_bcoforeclosure_cnt_cnt := COUNT(GROUP,h.bcoforeclosure_cnt <> (TYPEOF(h.bcoforeclosure_cnt))'');
    populated_bcoforeclosure_cnt_pcnt := AVE(GROUP,IF(h.bcoforeclosure_cnt = (TYPEOF(h.bcoforeclosure_cnt))'',0,100));
    maxlength_bcoforeclosure_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoforeclosure_cnt)));
    avelength_bcoforeclosure_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoforeclosure_cnt)),h.bcoforeclosure_cnt<>(typeof(h.bcoforeclosure_cnt))'');
    populated_colien_score_cnt := COUNT(GROUP,h.colien_score <> (TYPEOF(h.colien_score))'');
    populated_colien_score_pcnt := AVE(GROUP,IF(h.colien_score = (TYPEOF(h.colien_score))'',0,100));
    maxlength_colien_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.colien_score)));
    avelength_colien_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.colien_score)),h.colien_score<>(typeof(h.colien_score))'');
    populated_colien_cnt_cnt := COUNT(GROUP,h.colien_cnt <> (TYPEOF(h.colien_cnt))'');
    populated_colien_cnt_pcnt := AVE(GROUP,IF(h.colien_cnt = (TYPEOF(h.colien_cnt))'',0,100));
    maxlength_colien_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.colien_cnt)));
    avelength_colien_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.colien_cnt)),h.colien_cnt<>(typeof(h.colien_cnt))'');
    populated_bcolien_score_cnt := COUNT(GROUP,h.bcolien_score <> (TYPEOF(h.bcolien_score))'');
    populated_bcolien_score_pcnt := AVE(GROUP,IF(h.bcolien_score = (TYPEOF(h.bcolien_score))'',0,100));
    maxlength_bcolien_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcolien_score)));
    avelength_bcolien_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcolien_score)),h.bcolien_score<>(typeof(h.bcolien_score))'');
    populated_bcolien_cnt_cnt := COUNT(GROUP,h.bcolien_cnt <> (TYPEOF(h.bcolien_cnt))'');
    populated_bcolien_cnt_pcnt := AVE(GROUP,IF(h.bcolien_cnt = (TYPEOF(h.bcolien_cnt))'',0,100));
    maxlength_bcolien_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcolien_cnt)));
    avelength_bcolien_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcolien_cnt)),h.bcolien_cnt<>(typeof(h.bcolien_cnt))'');
    populated_cobankruptcy_score_cnt := COUNT(GROUP,h.cobankruptcy_score <> (TYPEOF(h.cobankruptcy_score))'');
    populated_cobankruptcy_score_pcnt := AVE(GROUP,IF(h.cobankruptcy_score = (TYPEOF(h.cobankruptcy_score))'',0,100));
    maxlength_cobankruptcy_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cobankruptcy_score)));
    avelength_cobankruptcy_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cobankruptcy_score)),h.cobankruptcy_score<>(typeof(h.cobankruptcy_score))'');
    populated_cobankruptcy_cnt_cnt := COUNT(GROUP,h.cobankruptcy_cnt <> (TYPEOF(h.cobankruptcy_cnt))'');
    populated_cobankruptcy_cnt_pcnt := AVE(GROUP,IF(h.cobankruptcy_cnt = (TYPEOF(h.cobankruptcy_cnt))'',0,100));
    maxlength_cobankruptcy_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cobankruptcy_cnt)));
    avelength_cobankruptcy_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cobankruptcy_cnt)),h.cobankruptcy_cnt<>(typeof(h.cobankruptcy_cnt))'');
    populated_bcobankruptcy_score_cnt := COUNT(GROUP,h.bcobankruptcy_score <> (TYPEOF(h.bcobankruptcy_score))'');
    populated_bcobankruptcy_score_pcnt := AVE(GROUP,IF(h.bcobankruptcy_score = (TYPEOF(h.bcobankruptcy_score))'',0,100));
    maxlength_bcobankruptcy_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcobankruptcy_score)));
    avelength_bcobankruptcy_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcobankruptcy_score)),h.bcobankruptcy_score<>(typeof(h.bcobankruptcy_score))'');
    populated_bcobankruptcy_cnt_cnt := COUNT(GROUP,h.bcobankruptcy_cnt <> (TYPEOF(h.bcobankruptcy_cnt))'');
    populated_bcobankruptcy_cnt_pcnt := AVE(GROUP,IF(h.bcobankruptcy_cnt = (TYPEOF(h.bcobankruptcy_cnt))'',0,100));
    maxlength_bcobankruptcy_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcobankruptcy_cnt)));
    avelength_bcobankruptcy_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcobankruptcy_cnt)),h.bcobankruptcy_cnt<>(typeof(h.bcobankruptcy_cnt))'');
    populated_covehicle_score_cnt := COUNT(GROUP,h.covehicle_score <> (TYPEOF(h.covehicle_score))'');
    populated_covehicle_score_pcnt := AVE(GROUP,IF(h.covehicle_score = (TYPEOF(h.covehicle_score))'',0,100));
    maxlength_covehicle_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.covehicle_score)));
    avelength_covehicle_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.covehicle_score)),h.covehicle_score<>(typeof(h.covehicle_score))'');
    populated_covehicle_cnt_cnt := COUNT(GROUP,h.covehicle_cnt <> (TYPEOF(h.covehicle_cnt))'');
    populated_covehicle_cnt_pcnt := AVE(GROUP,IF(h.covehicle_cnt = (TYPEOF(h.covehicle_cnt))'',0,100));
    maxlength_covehicle_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.covehicle_cnt)));
    avelength_covehicle_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.covehicle_cnt)),h.covehicle_cnt<>(typeof(h.covehicle_cnt))'');
    populated_coexperian_score_cnt := COUNT(GROUP,h.coexperian_score <> (TYPEOF(h.coexperian_score))'');
    populated_coexperian_score_pcnt := AVE(GROUP,IF(h.coexperian_score = (TYPEOF(h.coexperian_score))'',0,100));
    maxlength_coexperian_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coexperian_score)));
    avelength_coexperian_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coexperian_score)),h.coexperian_score<>(typeof(h.coexperian_score))'');
    populated_coexperian_cnt_cnt := COUNT(GROUP,h.coexperian_cnt <> (TYPEOF(h.coexperian_cnt))'');
    populated_coexperian_cnt_pcnt := AVE(GROUP,IF(h.coexperian_cnt = (TYPEOF(h.coexperian_cnt))'',0,100));
    maxlength_coexperian_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coexperian_cnt)));
    avelength_coexperian_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coexperian_cnt)),h.coexperian_cnt<>(typeof(h.coexperian_cnt))'');
    populated_cotransunion_score_cnt := COUNT(GROUP,h.cotransunion_score <> (TYPEOF(h.cotransunion_score))'');
    populated_cotransunion_score_pcnt := AVE(GROUP,IF(h.cotransunion_score = (TYPEOF(h.cotransunion_score))'',0,100));
    maxlength_cotransunion_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cotransunion_score)));
    avelength_cotransunion_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cotransunion_score)),h.cotransunion_score<>(typeof(h.cotransunion_score))'');
    populated_cotransunion_cnt_cnt := COUNT(GROUP,h.cotransunion_cnt <> (TYPEOF(h.cotransunion_cnt))'');
    populated_cotransunion_cnt_pcnt := AVE(GROUP,IF(h.cotransunion_cnt = (TYPEOF(h.cotransunion_cnt))'',0,100));
    maxlength_cotransunion_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cotransunion_cnt)));
    avelength_cotransunion_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cotransunion_cnt)),h.cotransunion_cnt<>(typeof(h.cotransunion_cnt))'');
    populated_coenclarity_score_cnt := COUNT(GROUP,h.coenclarity_score <> (TYPEOF(h.coenclarity_score))'');
    populated_coenclarity_score_pcnt := AVE(GROUP,IF(h.coenclarity_score = (TYPEOF(h.coenclarity_score))'',0,100));
    maxlength_coenclarity_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coenclarity_score)));
    avelength_coenclarity_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coenclarity_score)),h.coenclarity_score<>(typeof(h.coenclarity_score))'');
    populated_coenclarity_cnt_cnt := COUNT(GROUP,h.coenclarity_cnt <> (TYPEOF(h.coenclarity_cnt))'');
    populated_coenclarity_cnt_pcnt := AVE(GROUP,IF(h.coenclarity_cnt = (TYPEOF(h.coenclarity_cnt))'',0,100));
    maxlength_coenclarity_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coenclarity_cnt)));
    avelength_coenclarity_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coenclarity_cnt)),h.coenclarity_cnt<>(typeof(h.coenclarity_cnt))'');
    populated_coecrash_score_cnt := COUNT(GROUP,h.coecrash_score <> (TYPEOF(h.coecrash_score))'');
    populated_coecrash_score_pcnt := AVE(GROUP,IF(h.coecrash_score = (TYPEOF(h.coecrash_score))'',0,100));
    maxlength_coecrash_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coecrash_score)));
    avelength_coecrash_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coecrash_score)),h.coecrash_score<>(typeof(h.coecrash_score))'');
    populated_coecrash_cnt_cnt := COUNT(GROUP,h.coecrash_cnt <> (TYPEOF(h.coecrash_cnt))'');
    populated_coecrash_cnt_pcnt := AVE(GROUP,IF(h.coecrash_cnt = (TYPEOF(h.coecrash_cnt))'',0,100));
    maxlength_coecrash_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coecrash_cnt)));
    avelength_coecrash_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coecrash_cnt)),h.coecrash_cnt<>(typeof(h.coecrash_cnt))'');
    populated_bcoecrash_score_cnt := COUNT(GROUP,h.bcoecrash_score <> (TYPEOF(h.bcoecrash_score))'');
    populated_bcoecrash_score_pcnt := AVE(GROUP,IF(h.bcoecrash_score = (TYPEOF(h.bcoecrash_score))'',0,100));
    maxlength_bcoecrash_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoecrash_score)));
    avelength_bcoecrash_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoecrash_score)),h.bcoecrash_score<>(typeof(h.bcoecrash_score))'');
    populated_bcoecrash_cnt_cnt := COUNT(GROUP,h.bcoecrash_cnt <> (TYPEOF(h.bcoecrash_cnt))'');
    populated_bcoecrash_cnt_pcnt := AVE(GROUP,IF(h.bcoecrash_cnt = (TYPEOF(h.bcoecrash_cnt))'',0,100));
    maxlength_bcoecrash_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoecrash_cnt)));
    avelength_bcoecrash_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.bcoecrash_cnt)),h.bcoecrash_cnt<>(typeof(h.bcoecrash_cnt))'');
    populated_cowatercraft_score_cnt := COUNT(GROUP,h.cowatercraft_score <> (TYPEOF(h.cowatercraft_score))'');
    populated_cowatercraft_score_pcnt := AVE(GROUP,IF(h.cowatercraft_score = (TYPEOF(h.cowatercraft_score))'',0,100));
    maxlength_cowatercraft_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cowatercraft_score)));
    avelength_cowatercraft_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cowatercraft_score)),h.cowatercraft_score<>(typeof(h.cowatercraft_score))'');
    populated_cowatercraft_cnt_cnt := COUNT(GROUP,h.cowatercraft_cnt <> (TYPEOF(h.cowatercraft_cnt))'');
    populated_cowatercraft_cnt_pcnt := AVE(GROUP,IF(h.cowatercraft_cnt = (TYPEOF(h.cowatercraft_cnt))'',0,100));
    maxlength_cowatercraft_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cowatercraft_cnt)));
    avelength_cowatercraft_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cowatercraft_cnt)),h.cowatercraft_cnt<>(typeof(h.cowatercraft_cnt))'');
    populated_coaircraft_score_cnt := COUNT(GROUP,h.coaircraft_score <> (TYPEOF(h.coaircraft_score))'');
    populated_coaircraft_score_pcnt := AVE(GROUP,IF(h.coaircraft_score = (TYPEOF(h.coaircraft_score))'',0,100));
    maxlength_coaircraft_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coaircraft_score)));
    avelength_coaircraft_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coaircraft_score)),h.coaircraft_score<>(typeof(h.coaircraft_score))'');
    populated_coaircraft_cnt_cnt := COUNT(GROUP,h.coaircraft_cnt <> (TYPEOF(h.coaircraft_cnt))'');
    populated_coaircraft_cnt_pcnt := AVE(GROUP,IF(h.coaircraft_cnt = (TYPEOF(h.coaircraft_cnt))'',0,100));
    maxlength_coaircraft_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coaircraft_cnt)));
    avelength_coaircraft_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coaircraft_cnt)),h.coaircraft_cnt<>(typeof(h.coaircraft_cnt))'');
    populated_comarriagedivorce_score_cnt := COUNT(GROUP,h.comarriagedivorce_score <> (TYPEOF(h.comarriagedivorce_score))'');
    populated_comarriagedivorce_score_pcnt := AVE(GROUP,IF(h.comarriagedivorce_score = (TYPEOF(h.comarriagedivorce_score))'',0,100));
    maxlength_comarriagedivorce_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.comarriagedivorce_score)));
    avelength_comarriagedivorce_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.comarriagedivorce_score)),h.comarriagedivorce_score<>(typeof(h.comarriagedivorce_score))'');
    populated_comarriagedivorce_cnt_cnt := COUNT(GROUP,h.comarriagedivorce_cnt <> (TYPEOF(h.comarriagedivorce_cnt))'');
    populated_comarriagedivorce_cnt_pcnt := AVE(GROUP,IF(h.comarriagedivorce_cnt = (TYPEOF(h.comarriagedivorce_cnt))'',0,100));
    maxlength_comarriagedivorce_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.comarriagedivorce_cnt)));
    avelength_comarriagedivorce_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.comarriagedivorce_cnt)),h.comarriagedivorce_cnt<>(typeof(h.comarriagedivorce_cnt))'');
    populated_coucc_score_cnt := COUNT(GROUP,h.coucc_score <> (TYPEOF(h.coucc_score))'');
    populated_coucc_score_pcnt := AVE(GROUP,IF(h.coucc_score = (TYPEOF(h.coucc_score))'',0,100));
    maxlength_coucc_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coucc_score)));
    avelength_coucc_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coucc_score)),h.coucc_score<>(typeof(h.coucc_score))'');
    populated_coucc_cnt_cnt := COUNT(GROUP,h.coucc_cnt <> (TYPEOF(h.coucc_cnt))'');
    populated_coucc_cnt_pcnt := AVE(GROUP,IF(h.coucc_cnt = (TYPEOF(h.coucc_cnt))'',0,100));
    maxlength_coucc_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.coucc_cnt)));
    avelength_coucc_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.coucc_cnt)),h.coucc_cnt<>(typeof(h.coucc_cnt))'');
    populated_lname_score_cnt := COUNT(GROUP,h.lname_score <> (TYPEOF(h.lname_score))'');
    populated_lname_score_pcnt := AVE(GROUP,IF(h.lname_score = (TYPEOF(h.lname_score))'',0,100));
    maxlength_lname_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname_score)));
    avelength_lname_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname_score)),h.lname_score<>(typeof(h.lname_score))'');
    populated_phone_score_cnt := COUNT(GROUP,h.phone_score <> (TYPEOF(h.phone_score))'');
    populated_phone_score_pcnt := AVE(GROUP,IF(h.phone_score = (TYPEOF(h.phone_score))'',0,100));
    maxlength_phone_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone_score)));
    avelength_phone_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone_score)),h.phone_score<>(typeof(h.phone_score))'');
    populated_dl_nbr_score_cnt := COUNT(GROUP,h.dl_nbr_score <> (TYPEOF(h.dl_nbr_score))'');
    populated_dl_nbr_score_pcnt := AVE(GROUP,IF(h.dl_nbr_score = (TYPEOF(h.dl_nbr_score))'',0,100));
    maxlength_dl_nbr_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dl_nbr_score)));
    avelength_dl_nbr_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dl_nbr_score)),h.dl_nbr_score<>(typeof(h.dl_nbr_score))'');
    populated_total_cnt_cnt := COUNT(GROUP,h.total_cnt <> (TYPEOF(h.total_cnt))'');
    populated_total_cnt_pcnt := AVE(GROUP,IF(h.total_cnt = (TYPEOF(h.total_cnt))'',0,100));
    maxlength_total_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.total_cnt)));
    avelength_total_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.total_cnt)),h.total_cnt<>(typeof(h.total_cnt))'');
    populated_total_score_cnt := COUNT(GROUP,h.total_score <> (TYPEOF(h.total_score))'');
    populated_total_score_pcnt := AVE(GROUP,IF(h.total_score = (TYPEOF(h.total_score))'',0,100));
    maxlength_total_score := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.total_score)));
    avelength_total_score := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.total_score)),h.total_score<>(typeof(h.total_score))'');
    populated_cluster_cnt := COUNT(GROUP,h.cluster <> (TYPEOF(h.cluster))'');
    populated_cluster_pcnt := AVE(GROUP,IF(h.cluster = (TYPEOF(h.cluster))'',0,100));
    maxlength_cluster := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.cluster)));
    avelength_cluster := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.cluster)),h.cluster<>(typeof(h.cluster))'');
    populated_generation_cnt := COUNT(GROUP,h.generation <> (TYPEOF(h.generation))'');
    populated_generation_pcnt := AVE(GROUP,IF(h.generation = (TYPEOF(h.generation))'',0,100));
    maxlength_generation := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.generation)));
    avelength_generation := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.generation)),h.generation<>(typeof(h.generation))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_lname_cnt_cnt := COUNT(GROUP,h.lname_cnt <> (TYPEOF(h.lname_cnt))'');
    populated_lname_cnt_pcnt := AVE(GROUP,IF(h.lname_cnt = (TYPEOF(h.lname_cnt))'',0,100));
    maxlength_lname_cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname_cnt)));
    avelength_lname_cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname_cnt)),h.lname_cnt<>(typeof(h.lname_cnt))'');
    populated_rel_dt_first_seen_cnt := COUNT(GROUP,h.rel_dt_first_seen <> (TYPEOF(h.rel_dt_first_seen))'');
    populated_rel_dt_first_seen_pcnt := AVE(GROUP,IF(h.rel_dt_first_seen = (TYPEOF(h.rel_dt_first_seen))'',0,100));
    maxlength_rel_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rel_dt_first_seen)));
    avelength_rel_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rel_dt_first_seen)),h.rel_dt_first_seen<>(typeof(h.rel_dt_first_seen))'');
    populated_rel_dt_last_seen_cnt := COUNT(GROUP,h.rel_dt_last_seen <> (TYPEOF(h.rel_dt_last_seen))'');
    populated_rel_dt_last_seen_pcnt := AVE(GROUP,IF(h.rel_dt_last_seen = (TYPEOF(h.rel_dt_last_seen))'',0,100));
    maxlength_rel_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.rel_dt_last_seen)));
    avelength_rel_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.rel_dt_last_seen)),h.rel_dt_last_seen<>(typeof(h.rel_dt_last_seen))'');
    populated_overlap_months_cnt := COUNT(GROUP,h.overlap_months <> (TYPEOF(h.overlap_months))'');
    populated_overlap_months_pcnt := AVE(GROUP,IF(h.overlap_months = (TYPEOF(h.overlap_months))'',0,100));
    maxlength_overlap_months := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.overlap_months)));
    avelength_overlap_months := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.overlap_months)),h.overlap_months<>(typeof(h.overlap_months))'');
    populated_hdr_dt_first_seen_cnt := COUNT(GROUP,h.hdr_dt_first_seen <> (TYPEOF(h.hdr_dt_first_seen))'');
    populated_hdr_dt_first_seen_pcnt := AVE(GROUP,IF(h.hdr_dt_first_seen = (TYPEOF(h.hdr_dt_first_seen))'',0,100));
    maxlength_hdr_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.hdr_dt_first_seen)));
    avelength_hdr_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.hdr_dt_first_seen)),h.hdr_dt_first_seen<>(typeof(h.hdr_dt_first_seen))'');
    populated_hdr_dt_last_seen_cnt := COUNT(GROUP,h.hdr_dt_last_seen <> (TYPEOF(h.hdr_dt_last_seen))'');
    populated_hdr_dt_last_seen_pcnt := AVE(GROUP,IF(h.hdr_dt_last_seen = (TYPEOF(h.hdr_dt_last_seen))'',0,100));
    maxlength_hdr_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.hdr_dt_last_seen)));
    avelength_hdr_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.hdr_dt_last_seen)),h.hdr_dt_last_seen<>(typeof(h.hdr_dt_last_seen))'');
    populated_age_first_seen_cnt := COUNT(GROUP,h.age_first_seen <> (TYPEOF(h.age_first_seen))'');
    populated_age_first_seen_pcnt := AVE(GROUP,IF(h.age_first_seen = (TYPEOF(h.age_first_seen))'',0,100));
    maxlength_age_first_seen := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.age_first_seen)));
    avelength_age_first_seen := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.age_first_seen)),h.age_first_seen<>(typeof(h.age_first_seen))'');
    populated_isanylnamematch_cnt := COUNT(GROUP,h.isanylnamematch <> (TYPEOF(h.isanylnamematch))'');
    populated_isanylnamematch_pcnt := AVE(GROUP,IF(h.isanylnamematch = (TYPEOF(h.isanylnamematch))'',0,100));
    maxlength_isanylnamematch := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.isanylnamematch)));
    avelength_isanylnamematch := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.isanylnamematch)),h.isanylnamematch<>(typeof(h.isanylnamematch))'');
    populated_isanyphonematch_cnt := COUNT(GROUP,h.isanyphonematch <> (TYPEOF(h.isanyphonematch))'');
    populated_isanyphonematch_pcnt := AVE(GROUP,IF(h.isanyphonematch = (TYPEOF(h.isanyphonematch))'',0,100));
    maxlength_isanyphonematch := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.isanyphonematch)));
    avelength_isanyphonematch := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.isanyphonematch)),h.isanyphonematch<>(typeof(h.isanyphonematch))'');
    populated_isearlylnamematch_cnt := COUNT(GROUP,h.isearlylnamematch <> (TYPEOF(h.isearlylnamematch))'');
    populated_isearlylnamematch_pcnt := AVE(GROUP,IF(h.isearlylnamematch = (TYPEOF(h.isearlylnamematch))'',0,100));
    maxlength_isearlylnamematch := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.isearlylnamematch)));
    avelength_isearlylnamematch := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.isearlylnamematch)),h.isearlylnamematch<>(typeof(h.isearlylnamematch))'');
    populated_iscurrlnamematch_cnt := COUNT(GROUP,h.iscurrlnamematch <> (TYPEOF(h.iscurrlnamematch))'');
    populated_iscurrlnamematch_pcnt := AVE(GROUP,IF(h.iscurrlnamematch = (TYPEOF(h.iscurrlnamematch))'',0,100));
    maxlength_iscurrlnamematch := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.iscurrlnamematch)));
    avelength_iscurrlnamematch := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.iscurrlnamematch)),h.iscurrlnamematch<>(typeof(h.iscurrlnamematch))'');
    populated_ismixedlnamematch_cnt := COUNT(GROUP,h.ismixedlnamematch <> (TYPEOF(h.ismixedlnamematch))'');
    populated_ismixedlnamematch_pcnt := AVE(GROUP,IF(h.ismixedlnamematch = (TYPEOF(h.ismixedlnamematch))'',0,100));
    maxlength_ismixedlnamematch := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ismixedlnamematch)));
    avelength_ismixedlnamematch := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ismixedlnamematch)),h.ismixedlnamematch<>(typeof(h.ismixedlnamematch))'');
    populated_ssn1_cnt := COUNT(GROUP,h.ssn1 <> (TYPEOF(h.ssn1))'');
    populated_ssn1_pcnt := AVE(GROUP,IF(h.ssn1 = (TYPEOF(h.ssn1))'',0,100));
    maxlength_ssn1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn1)));
    avelength_ssn1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn1)),h.ssn1<>(typeof(h.ssn1))'');
    populated_ssn2_cnt := COUNT(GROUP,h.ssn2 <> (TYPEOF(h.ssn2))'');
    populated_ssn2_pcnt := AVE(GROUP,IF(h.ssn2 = (TYPEOF(h.ssn2))'',0,100));
    maxlength_ssn2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn2)));
    avelength_ssn2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn2)),h.ssn2<>(typeof(h.ssn2))'');
    populated_dob1_cnt := COUNT(GROUP,h.dob1 <> (TYPEOF(h.dob1))'');
    populated_dob1_pcnt := AVE(GROUP,IF(h.dob1 = (TYPEOF(h.dob1))'',0,100));
    maxlength_dob1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob1)));
    avelength_dob1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob1)),h.dob1<>(typeof(h.dob1))'');
    populated_dob2_cnt := COUNT(GROUP,h.dob2 <> (TYPEOF(h.dob2))'');
    populated_dob2_pcnt := AVE(GROUP,IF(h.dob2 = (TYPEOF(h.dob2))'',0,100));
    maxlength_dob2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob2)));
    avelength_dob2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob2)),h.dob2<>(typeof(h.dob2))'');
    populated_current_lname1_cnt := COUNT(GROUP,h.current_lname1 <> (TYPEOF(h.current_lname1))'');
    populated_current_lname1_pcnt := AVE(GROUP,IF(h.current_lname1 = (TYPEOF(h.current_lname1))'',0,100));
    maxlength_current_lname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.current_lname1)));
    avelength_current_lname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.current_lname1)),h.current_lname1<>(typeof(h.current_lname1))'');
    populated_current_lname2_cnt := COUNT(GROUP,h.current_lname2 <> (TYPEOF(h.current_lname2))'');
    populated_current_lname2_pcnt := AVE(GROUP,IF(h.current_lname2 = (TYPEOF(h.current_lname2))'',0,100));
    maxlength_current_lname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.current_lname2)));
    avelength_current_lname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.current_lname2)),h.current_lname2<>(typeof(h.current_lname2))'');
    populated_early_lname1_cnt := COUNT(GROUP,h.early_lname1 <> (TYPEOF(h.early_lname1))'');
    populated_early_lname1_pcnt := AVE(GROUP,IF(h.early_lname1 = (TYPEOF(h.early_lname1))'',0,100));
    maxlength_early_lname1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.early_lname1)));
    avelength_early_lname1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.early_lname1)),h.early_lname1<>(typeof(h.early_lname1))'');
    populated_early_lname2_cnt := COUNT(GROUP,h.early_lname2 <> (TYPEOF(h.early_lname2))'');
    populated_early_lname2_pcnt := AVE(GROUP,IF(h.early_lname2 = (TYPEOF(h.early_lname2))'',0,100));
    maxlength_early_lname2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.early_lname2)));
    avelength_early_lname2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.early_lname2)),h.early_lname2<>(typeof(h.early_lname2))'');
    populated_addr_ind1_cnt := COUNT(GROUP,h.addr_ind1 <> (TYPEOF(h.addr_ind1))'');
    populated_addr_ind1_pcnt := AVE(GROUP,IF(h.addr_ind1 = (TYPEOF(h.addr_ind1))'',0,100));
    maxlength_addr_ind1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_ind1)));
    avelength_addr_ind1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_ind1)),h.addr_ind1<>(typeof(h.addr_ind1))'');
    populated_addr_ind2_cnt := COUNT(GROUP,h.addr_ind2 <> (TYPEOF(h.addr_ind2))'');
    populated_addr_ind2_pcnt := AVE(GROUP,IF(h.addr_ind2 = (TYPEOF(h.addr_ind2))'',0,100));
    maxlength_addr_ind2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_ind2)));
    avelength_addr_ind2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.addr_ind2)),h.addr_ind2<>(typeof(h.addr_ind2))'');
    populated_r2rdid_cnt := COUNT(GROUP,h.r2rdid <> (TYPEOF(h.r2rdid))'');
    populated_r2rdid_pcnt := AVE(GROUP,IF(h.r2rdid = (TYPEOF(h.r2rdid))'',0,100));
    maxlength_r2rdid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.r2rdid)));
    avelength_r2rdid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.r2rdid)),h.r2rdid<>(typeof(h.r2rdid))'');
    populated_r2cnt_cnt := COUNT(GROUP,h.r2cnt <> (TYPEOF(h.r2cnt))'');
    populated_r2cnt_pcnt := AVE(GROUP,IF(h.r2cnt = (TYPEOF(h.r2cnt))'',0,100));
    maxlength_r2cnt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.r2cnt)));
    avelength_r2cnt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.r2cnt)),h.r2cnt<>(typeof(h.r2cnt))'');
    populated_personal_cnt := COUNT(GROUP,h.personal <> (TYPEOF(h.personal))'');
    populated_personal_pcnt := AVE(GROUP,IF(h.personal = (TYPEOF(h.personal))'',0,100));
    maxlength_personal := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.personal)));
    avelength_personal := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.personal)),h.personal<>(typeof(h.personal))'');
    populated_business_cnt := COUNT(GROUP,h.business <> (TYPEOF(h.business))'');
    populated_business_pcnt := AVE(GROUP,IF(h.business = (TYPEOF(h.business))'',0,100));
    maxlength_business := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.business)));
    avelength_business := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.business)),h.business<>(typeof(h.business))'');
    populated_other_cnt := COUNT(GROUP,h.other <> (TYPEOF(h.other))'');
    populated_other_pcnt := AVE(GROUP,IF(h.other = (TYPEOF(h.other))'',0,100));
    maxlength_other := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.other)));
    avelength_other := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.other)),h.other<>(typeof(h.other))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.title)),h.title<>(typeof(h.title))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_type_pcnt *   0.00 / 100 + T.Populated_confidence_pcnt *   0.00 / 100 + T.Populated_did1_pcnt *   0.00 / 100 + T.Populated_did2_pcnt *   0.00 / 100 + T.Populated_cohabit_score_pcnt *   0.00 / 100 + T.Populated_cohabit_cnt_pcnt *   0.00 / 100 + T.Populated_coapt_score_pcnt *   0.00 / 100 + T.Populated_coapt_cnt_pcnt *   0.00 / 100 + T.Populated_copobox_score_pcnt *   0.00 / 100 + T.Populated_copobox_cnt_pcnt *   0.00 / 100 + T.Populated_cossn_score_pcnt *   0.00 / 100 + T.Populated_cossn_cnt_pcnt *   0.00 / 100 + T.Populated_copolicy_score_pcnt *   0.00 / 100 + T.Populated_copolicy_cnt_pcnt *   0.00 / 100 + T.Populated_coclaim_score_pcnt *   0.00 / 100 + T.Populated_coclaim_cnt_pcnt *   0.00 / 100 + T.Populated_coproperty_score_pcnt *   0.00 / 100 + T.Populated_coproperty_cnt_pcnt *   0.00 / 100 + T.Populated_bcoproperty_score_pcnt *   0.00 / 100 + T.Populated_bcoproperty_cnt_pcnt *   0.00 / 100 + T.Populated_coforeclosure_score_pcnt *   0.00 / 100 + T.Populated_coforeclosure_cnt_pcnt *   0.00 / 100 + T.Populated_bcoforeclosure_score_pcnt *   0.00 / 100 + T.Populated_bcoforeclosure_cnt_pcnt *   0.00 / 100 + T.Populated_colien_score_pcnt *   0.00 / 100 + T.Populated_colien_cnt_pcnt *   0.00 / 100 + T.Populated_bcolien_score_pcnt *   0.00 / 100 + T.Populated_bcolien_cnt_pcnt *   0.00 / 100 + T.Populated_cobankruptcy_score_pcnt *   0.00 / 100 + T.Populated_cobankruptcy_cnt_pcnt *   0.00 / 100 + T.Populated_bcobankruptcy_score_pcnt *   0.00 / 100 + T.Populated_bcobankruptcy_cnt_pcnt *   0.00 / 100 + T.Populated_covehicle_score_pcnt *   0.00 / 100 + T.Populated_covehicle_cnt_pcnt *   0.00 / 100 + T.Populated_coexperian_score_pcnt *   0.00 / 100 + T.Populated_coexperian_cnt_pcnt *   0.00 / 100 + T.Populated_cotransunion_score_pcnt *   0.00 / 100 + T.Populated_cotransunion_cnt_pcnt *   0.00 / 100 + T.Populated_coenclarity_score_pcnt *   0.00 / 100 + T.Populated_coenclarity_cnt_pcnt *   0.00 / 100 + T.Populated_coecrash_score_pcnt *   0.00 / 100 + T.Populated_coecrash_cnt_pcnt *   0.00 / 100 + T.Populated_bcoecrash_score_pcnt *   0.00 / 100 + T.Populated_bcoecrash_cnt_pcnt *   0.00 / 100 + T.Populated_cowatercraft_score_pcnt *   0.00 / 100 + T.Populated_cowatercraft_cnt_pcnt *   0.00 / 100 + T.Populated_coaircraft_score_pcnt *   0.00 / 100 + T.Populated_coaircraft_cnt_pcnt *   0.00 / 100 + T.Populated_comarriagedivorce_score_pcnt *   0.00 / 100 + T.Populated_comarriagedivorce_cnt_pcnt *   0.00 / 100 + T.Populated_coucc_score_pcnt *   0.00 / 100 + T.Populated_coucc_cnt_pcnt *   0.00 / 100 + T.Populated_lname_score_pcnt *   0.00 / 100 + T.Populated_phone_score_pcnt *   0.00 / 100 + T.Populated_dl_nbr_score_pcnt *   0.00 / 100 + T.Populated_total_cnt_pcnt *   0.00 / 100 + T.Populated_total_score_pcnt *   0.00 / 100 + T.Populated_cluster_pcnt *   0.00 / 100 + T.Populated_generation_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_lname_cnt_pcnt *   0.00 / 100 + T.Populated_rel_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_rel_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_overlap_months_pcnt *   0.00 / 100 + T.Populated_hdr_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_hdr_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_age_first_seen_pcnt *   0.00 / 100 + T.Populated_isanylnamematch_pcnt *   0.00 / 100 + T.Populated_isanyphonematch_pcnt *   0.00 / 100 + T.Populated_isearlylnamematch_pcnt *   0.00 / 100 + T.Populated_iscurrlnamematch_pcnt *   0.00 / 100 + T.Populated_ismixedlnamematch_pcnt *   0.00 / 100 + T.Populated_ssn1_pcnt *   0.00 / 100 + T.Populated_ssn2_pcnt *   0.00 / 100 + T.Populated_dob1_pcnt *   0.00 / 100 + T.Populated_dob2_pcnt *   0.00 / 100 + T.Populated_current_lname1_pcnt *   0.00 / 100 + T.Populated_current_lname2_pcnt *   0.00 / 100 + T.Populated_early_lname1_pcnt *   0.00 / 100 + T.Populated_early_lname2_pcnt *   0.00 / 100 + T.Populated_addr_ind1_pcnt *   0.00 / 100 + T.Populated_addr_ind2_pcnt *   0.00 / 100 + T.Populated_r2rdid_pcnt *   0.00 / 100 + T.Populated_r2cnt_pcnt *   0.00 / 100 + T.Populated_personal_pcnt *   0.00 / 100 + T.Populated_business_pcnt *   0.00 / 100 + T.Populated_other_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title');
  SELF.populated_pcnt := CHOOSE(C,le.populated_type_pcnt,le.populated_confidence_pcnt,le.populated_did1_pcnt,le.populated_did2_pcnt,le.populated_cohabit_score_pcnt,le.populated_cohabit_cnt_pcnt,le.populated_coapt_score_pcnt,le.populated_coapt_cnt_pcnt,le.populated_copobox_score_pcnt,le.populated_copobox_cnt_pcnt,le.populated_cossn_score_pcnt,le.populated_cossn_cnt_pcnt,le.populated_copolicy_score_pcnt,le.populated_copolicy_cnt_pcnt,le.populated_coclaim_score_pcnt,le.populated_coclaim_cnt_pcnt,le.populated_coproperty_score_pcnt,le.populated_coproperty_cnt_pcnt,le.populated_bcoproperty_score_pcnt,le.populated_bcoproperty_cnt_pcnt,le.populated_coforeclosure_score_pcnt,le.populated_coforeclosure_cnt_pcnt,le.populated_bcoforeclosure_score_pcnt,le.populated_bcoforeclosure_cnt_pcnt,le.populated_colien_score_pcnt,le.populated_colien_cnt_pcnt,le.populated_bcolien_score_pcnt,le.populated_bcolien_cnt_pcnt,le.populated_cobankruptcy_score_pcnt,le.populated_cobankruptcy_cnt_pcnt,le.populated_bcobankruptcy_score_pcnt,le.populated_bcobankruptcy_cnt_pcnt,le.populated_covehicle_score_pcnt,le.populated_covehicle_cnt_pcnt,le.populated_coexperian_score_pcnt,le.populated_coexperian_cnt_pcnt,le.populated_cotransunion_score_pcnt,le.populated_cotransunion_cnt_pcnt,le.populated_coenclarity_score_pcnt,le.populated_coenclarity_cnt_pcnt,le.populated_coecrash_score_pcnt,le.populated_coecrash_cnt_pcnt,le.populated_bcoecrash_score_pcnt,le.populated_bcoecrash_cnt_pcnt,le.populated_cowatercraft_score_pcnt,le.populated_cowatercraft_cnt_pcnt,le.populated_coaircraft_score_pcnt,le.populated_coaircraft_cnt_pcnt,le.populated_comarriagedivorce_score_pcnt,le.populated_comarriagedivorce_cnt_pcnt,le.populated_coucc_score_pcnt,le.populated_coucc_cnt_pcnt,le.populated_lname_score_pcnt,le.populated_phone_score_pcnt,le.populated_dl_nbr_score_pcnt,le.populated_total_cnt_pcnt,le.populated_total_score_pcnt,le.populated_cluster_pcnt,le.populated_generation_pcnt,le.populated_gender_pcnt,le.populated_lname_cnt_pcnt,le.populated_rel_dt_first_seen_pcnt,le.populated_rel_dt_last_seen_pcnt,le.populated_overlap_months_pcnt,le.populated_hdr_dt_first_seen_pcnt,le.populated_hdr_dt_last_seen_pcnt,le.populated_age_first_seen_pcnt,le.populated_isanylnamematch_pcnt,le.populated_isanyphonematch_pcnt,le.populated_isearlylnamematch_pcnt,le.populated_iscurrlnamematch_pcnt,le.populated_ismixedlnamematch_pcnt,le.populated_ssn1_pcnt,le.populated_ssn2_pcnt,le.populated_dob1_pcnt,le.populated_dob2_pcnt,le.populated_current_lname1_pcnt,le.populated_current_lname2_pcnt,le.populated_early_lname1_pcnt,le.populated_early_lname2_pcnt,le.populated_addr_ind1_pcnt,le.populated_addr_ind2_pcnt,le.populated_r2rdid_pcnt,le.populated_r2cnt_pcnt,le.populated_personal_pcnt,le.populated_business_pcnt,le.populated_other_pcnt,le.populated_title_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_type,le.maxlength_confidence,le.maxlength_did1,le.maxlength_did2,le.maxlength_cohabit_score,le.maxlength_cohabit_cnt,le.maxlength_coapt_score,le.maxlength_coapt_cnt,le.maxlength_copobox_score,le.maxlength_copobox_cnt,le.maxlength_cossn_score,le.maxlength_cossn_cnt,le.maxlength_copolicy_score,le.maxlength_copolicy_cnt,le.maxlength_coclaim_score,le.maxlength_coclaim_cnt,le.maxlength_coproperty_score,le.maxlength_coproperty_cnt,le.maxlength_bcoproperty_score,le.maxlength_bcoproperty_cnt,le.maxlength_coforeclosure_score,le.maxlength_coforeclosure_cnt,le.maxlength_bcoforeclosure_score,le.maxlength_bcoforeclosure_cnt,le.maxlength_colien_score,le.maxlength_colien_cnt,le.maxlength_bcolien_score,le.maxlength_bcolien_cnt,le.maxlength_cobankruptcy_score,le.maxlength_cobankruptcy_cnt,le.maxlength_bcobankruptcy_score,le.maxlength_bcobankruptcy_cnt,le.maxlength_covehicle_score,le.maxlength_covehicle_cnt,le.maxlength_coexperian_score,le.maxlength_coexperian_cnt,le.maxlength_cotransunion_score,le.maxlength_cotransunion_cnt,le.maxlength_coenclarity_score,le.maxlength_coenclarity_cnt,le.maxlength_coecrash_score,le.maxlength_coecrash_cnt,le.maxlength_bcoecrash_score,le.maxlength_bcoecrash_cnt,le.maxlength_cowatercraft_score,le.maxlength_cowatercraft_cnt,le.maxlength_coaircraft_score,le.maxlength_coaircraft_cnt,le.maxlength_comarriagedivorce_score,le.maxlength_comarriagedivorce_cnt,le.maxlength_coucc_score,le.maxlength_coucc_cnt,le.maxlength_lname_score,le.maxlength_phone_score,le.maxlength_dl_nbr_score,le.maxlength_total_cnt,le.maxlength_total_score,le.maxlength_cluster,le.maxlength_generation,le.maxlength_gender,le.maxlength_lname_cnt,le.maxlength_rel_dt_first_seen,le.maxlength_rel_dt_last_seen,le.maxlength_overlap_months,le.maxlength_hdr_dt_first_seen,le.maxlength_hdr_dt_last_seen,le.maxlength_age_first_seen,le.maxlength_isanylnamematch,le.maxlength_isanyphonematch,le.maxlength_isearlylnamematch,le.maxlength_iscurrlnamematch,le.maxlength_ismixedlnamematch,le.maxlength_ssn1,le.maxlength_ssn2,le.maxlength_dob1,le.maxlength_dob2,le.maxlength_current_lname1,le.maxlength_current_lname2,le.maxlength_early_lname1,le.maxlength_early_lname2,le.maxlength_addr_ind1,le.maxlength_addr_ind2,le.maxlength_r2rdid,le.maxlength_r2cnt,le.maxlength_personal,le.maxlength_business,le.maxlength_other,le.maxlength_title);
  SELF.avelength := CHOOSE(C,le.avelength_type,le.avelength_confidence,le.avelength_did1,le.avelength_did2,le.avelength_cohabit_score,le.avelength_cohabit_cnt,le.avelength_coapt_score,le.avelength_coapt_cnt,le.avelength_copobox_score,le.avelength_copobox_cnt,le.avelength_cossn_score,le.avelength_cossn_cnt,le.avelength_copolicy_score,le.avelength_copolicy_cnt,le.avelength_coclaim_score,le.avelength_coclaim_cnt,le.avelength_coproperty_score,le.avelength_coproperty_cnt,le.avelength_bcoproperty_score,le.avelength_bcoproperty_cnt,le.avelength_coforeclosure_score,le.avelength_coforeclosure_cnt,le.avelength_bcoforeclosure_score,le.avelength_bcoforeclosure_cnt,le.avelength_colien_score,le.avelength_colien_cnt,le.avelength_bcolien_score,le.avelength_bcolien_cnt,le.avelength_cobankruptcy_score,le.avelength_cobankruptcy_cnt,le.avelength_bcobankruptcy_score,le.avelength_bcobankruptcy_cnt,le.avelength_covehicle_score,le.avelength_covehicle_cnt,le.avelength_coexperian_score,le.avelength_coexperian_cnt,le.avelength_cotransunion_score,le.avelength_cotransunion_cnt,le.avelength_coenclarity_score,le.avelength_coenclarity_cnt,le.avelength_coecrash_score,le.avelength_coecrash_cnt,le.avelength_bcoecrash_score,le.avelength_bcoecrash_cnt,le.avelength_cowatercraft_score,le.avelength_cowatercraft_cnt,le.avelength_coaircraft_score,le.avelength_coaircraft_cnt,le.avelength_comarriagedivorce_score,le.avelength_comarriagedivorce_cnt,le.avelength_coucc_score,le.avelength_coucc_cnt,le.avelength_lname_score,le.avelength_phone_score,le.avelength_dl_nbr_score,le.avelength_total_cnt,le.avelength_total_score,le.avelength_cluster,le.avelength_generation,le.avelength_gender,le.avelength_lname_cnt,le.avelength_rel_dt_first_seen,le.avelength_rel_dt_last_seen,le.avelength_overlap_months,le.avelength_hdr_dt_first_seen,le.avelength_hdr_dt_last_seen,le.avelength_age_first_seen,le.avelength_isanylnamematch,le.avelength_isanyphonematch,le.avelength_isearlylnamematch,le.avelength_iscurrlnamematch,le.avelength_ismixedlnamematch,le.avelength_ssn1,le.avelength_ssn2,le.avelength_dob1,le.avelength_dob2,le.avelength_current_lname1,le.avelength_current_lname2,le.avelength_early_lname1,le.avelength_early_lname2,le.avelength_addr_ind1,le.avelength_addr_ind2,le.avelength_r2rdid,le.avelength_r2cnt,le.avelength_personal,le.avelength_business,le.avelength_other,le.avelength_title);
END;
EXPORT invSummary := NORMALIZE(summary0, 88, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.type),TRIM((SALT39.StrType)le.confidence),IF (le.did1 <> 0,TRIM((SALT39.StrType)le.did1), ''),IF (le.did2 <> 0,TRIM((SALT39.StrType)le.did2), ''),IF (le.cohabit_score <> 0,TRIM((SALT39.StrType)le.cohabit_score), ''),IF (le.cohabit_cnt <> 0,TRIM((SALT39.StrType)le.cohabit_cnt), ''),IF (le.coapt_score <> 0,TRIM((SALT39.StrType)le.coapt_score), ''),IF (le.coapt_cnt <> 0,TRIM((SALT39.StrType)le.coapt_cnt), ''),IF (le.copobox_score <> 0,TRIM((SALT39.StrType)le.copobox_score), ''),IF (le.copobox_cnt <> 0,TRIM((SALT39.StrType)le.copobox_cnt), ''),IF (le.cossn_score <> 0,TRIM((SALT39.StrType)le.cossn_score), ''),IF (le.cossn_cnt <> 0,TRIM((SALT39.StrType)le.cossn_cnt), ''),IF (le.copolicy_score <> 0,TRIM((SALT39.StrType)le.copolicy_score), ''),IF (le.copolicy_cnt <> 0,TRIM((SALT39.StrType)le.copolicy_cnt), ''),IF (le.coclaim_score <> 0,TRIM((SALT39.StrType)le.coclaim_score), ''),IF (le.coclaim_cnt <> 0,TRIM((SALT39.StrType)le.coclaim_cnt), ''),IF (le.coproperty_score <> 0,TRIM((SALT39.StrType)le.coproperty_score), ''),IF (le.coproperty_cnt <> 0,TRIM((SALT39.StrType)le.coproperty_cnt), ''),IF (le.bcoproperty_score <> 0,TRIM((SALT39.StrType)le.bcoproperty_score), ''),IF (le.bcoproperty_cnt <> 0,TRIM((SALT39.StrType)le.bcoproperty_cnt), ''),IF (le.coforeclosure_score <> 0,TRIM((SALT39.StrType)le.coforeclosure_score), ''),IF (le.coforeclosure_cnt <> 0,TRIM((SALT39.StrType)le.coforeclosure_cnt), ''),IF (le.bcoforeclosure_score <> 0,TRIM((SALT39.StrType)le.bcoforeclosure_score), ''),IF (le.bcoforeclosure_cnt <> 0,TRIM((SALT39.StrType)le.bcoforeclosure_cnt), ''),IF (le.colien_score <> 0,TRIM((SALT39.StrType)le.colien_score), ''),IF (le.colien_cnt <> 0,TRIM((SALT39.StrType)le.colien_cnt), ''),IF (le.bcolien_score <> 0,TRIM((SALT39.StrType)le.bcolien_score), ''),IF (le.bcolien_cnt <> 0,TRIM((SALT39.StrType)le.bcolien_cnt), ''),IF (le.cobankruptcy_score <> 0,TRIM((SALT39.StrType)le.cobankruptcy_score), ''),IF (le.cobankruptcy_cnt <> 0,TRIM((SALT39.StrType)le.cobankruptcy_cnt), ''),IF (le.bcobankruptcy_score <> 0,TRIM((SALT39.StrType)le.bcobankruptcy_score), ''),IF (le.bcobankruptcy_cnt <> 0,TRIM((SALT39.StrType)le.bcobankruptcy_cnt), ''),IF (le.covehicle_score <> 0,TRIM((SALT39.StrType)le.covehicle_score), ''),IF (le.covehicle_cnt <> 0,TRIM((SALT39.StrType)le.covehicle_cnt), ''),IF (le.coexperian_score <> 0,TRIM((SALT39.StrType)le.coexperian_score), ''),IF (le.coexperian_cnt <> 0,TRIM((SALT39.StrType)le.coexperian_cnt), ''),IF (le.cotransunion_score <> 0,TRIM((SALT39.StrType)le.cotransunion_score), ''),IF (le.cotransunion_cnt <> 0,TRIM((SALT39.StrType)le.cotransunion_cnt), ''),IF (le.coenclarity_score <> 0,TRIM((SALT39.StrType)le.coenclarity_score), ''),IF (le.coenclarity_cnt <> 0,TRIM((SALT39.StrType)le.coenclarity_cnt), ''),IF (le.coecrash_score <> 0,TRIM((SALT39.StrType)le.coecrash_score), ''),IF (le.coecrash_cnt <> 0,TRIM((SALT39.StrType)le.coecrash_cnt), ''),IF (le.bcoecrash_score <> 0,TRIM((SALT39.StrType)le.bcoecrash_score), ''),IF (le.bcoecrash_cnt <> 0,TRIM((SALT39.StrType)le.bcoecrash_cnt), ''),IF (le.cowatercraft_score <> 0,TRIM((SALT39.StrType)le.cowatercraft_score), ''),IF (le.cowatercraft_cnt <> 0,TRIM((SALT39.StrType)le.cowatercraft_cnt), ''),IF (le.coaircraft_score <> 0,TRIM((SALT39.StrType)le.coaircraft_score), ''),IF (le.coaircraft_cnt <> 0,TRIM((SALT39.StrType)le.coaircraft_cnt), ''),IF (le.comarriagedivorce_score <> 0,TRIM((SALT39.StrType)le.comarriagedivorce_score), ''),IF (le.comarriagedivorce_cnt <> 0,TRIM((SALT39.StrType)le.comarriagedivorce_cnt), ''),IF (le.coucc_score <> 0,TRIM((SALT39.StrType)le.coucc_score), ''),IF (le.coucc_cnt <> 0,TRIM((SALT39.StrType)le.coucc_cnt), ''),IF (le.lname_score <> 0,TRIM((SALT39.StrType)le.lname_score), ''),IF (le.phone_score <> 0,TRIM((SALT39.StrType)le.phone_score), ''),IF (le.dl_nbr_score <> 0,TRIM((SALT39.StrType)le.dl_nbr_score), ''),IF (le.total_cnt <> 0,TRIM((SALT39.StrType)le.total_cnt), ''),IF (le.total_score <> 0,TRIM((SALT39.StrType)le.total_score), ''),TRIM((SALT39.StrType)le.cluster),TRIM((SALT39.StrType)le.generation),TRIM((SALT39.StrType)le.gender),IF (le.lname_cnt <> 0,TRIM((SALT39.StrType)le.lname_cnt), ''),IF (le.rel_dt_first_seen <> 0,TRIM((SALT39.StrType)le.rel_dt_first_seen), ''),IF (le.rel_dt_last_seen <> 0,TRIM((SALT39.StrType)le.rel_dt_last_seen), ''),IF (le.overlap_months <> 0,TRIM((SALT39.StrType)le.overlap_months), ''),IF (le.hdr_dt_first_seen <> 0,TRIM((SALT39.StrType)le.hdr_dt_first_seen), ''),IF (le.hdr_dt_last_seen <> 0,TRIM((SALT39.StrType)le.hdr_dt_last_seen), ''),IF (le.age_first_seen <> 0,TRIM((SALT39.StrType)le.age_first_seen), ''),TRIM((SALT39.StrType)le.isanylnamematch),TRIM((SALT39.StrType)le.isanyphonematch),TRIM((SALT39.StrType)le.isearlylnamematch),TRIM((SALT39.StrType)le.iscurrlnamematch),TRIM((SALT39.StrType)le.ismixedlnamematch),TRIM((SALT39.StrType)le.ssn1),TRIM((SALT39.StrType)le.ssn2),IF (le.dob1 <> 0,TRIM((SALT39.StrType)le.dob1), ''),IF (le.dob2 <> 0,TRIM((SALT39.StrType)le.dob2), ''),TRIM((SALT39.StrType)le.current_lname1),TRIM((SALT39.StrType)le.current_lname2),TRIM((SALT39.StrType)le.early_lname1),TRIM((SALT39.StrType)le.early_lname2),TRIM((SALT39.StrType)le.addr_ind1),TRIM((SALT39.StrType)le.addr_ind2),IF (le.r2rdid <> 0,TRIM((SALT39.StrType)le.r2rdid), ''),IF (le.r2cnt <> 0,TRIM((SALT39.StrType)le.r2cnt), ''),TRIM((SALT39.StrType)le.personal),TRIM((SALT39.StrType)le.business),TRIM((SALT39.StrType)le.other),IF (le.title <> 0,TRIM((SALT39.StrType)le.title), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,88,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 88);
  SELF.FldNo2 := 1 + (C % 88);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.type),TRIM((SALT39.StrType)le.confidence),IF (le.did1 <> 0,TRIM((SALT39.StrType)le.did1), ''),IF (le.did2 <> 0,TRIM((SALT39.StrType)le.did2), ''),IF (le.cohabit_score <> 0,TRIM((SALT39.StrType)le.cohabit_score), ''),IF (le.cohabit_cnt <> 0,TRIM((SALT39.StrType)le.cohabit_cnt), ''),IF (le.coapt_score <> 0,TRIM((SALT39.StrType)le.coapt_score), ''),IF (le.coapt_cnt <> 0,TRIM((SALT39.StrType)le.coapt_cnt), ''),IF (le.copobox_score <> 0,TRIM((SALT39.StrType)le.copobox_score), ''),IF (le.copobox_cnt <> 0,TRIM((SALT39.StrType)le.copobox_cnt), ''),IF (le.cossn_score <> 0,TRIM((SALT39.StrType)le.cossn_score), ''),IF (le.cossn_cnt <> 0,TRIM((SALT39.StrType)le.cossn_cnt), ''),IF (le.copolicy_score <> 0,TRIM((SALT39.StrType)le.copolicy_score), ''),IF (le.copolicy_cnt <> 0,TRIM((SALT39.StrType)le.copolicy_cnt), ''),IF (le.coclaim_score <> 0,TRIM((SALT39.StrType)le.coclaim_score), ''),IF (le.coclaim_cnt <> 0,TRIM((SALT39.StrType)le.coclaim_cnt), ''),IF (le.coproperty_score <> 0,TRIM((SALT39.StrType)le.coproperty_score), ''),IF (le.coproperty_cnt <> 0,TRIM((SALT39.StrType)le.coproperty_cnt), ''),IF (le.bcoproperty_score <> 0,TRIM((SALT39.StrType)le.bcoproperty_score), ''),IF (le.bcoproperty_cnt <> 0,TRIM((SALT39.StrType)le.bcoproperty_cnt), ''),IF (le.coforeclosure_score <> 0,TRIM((SALT39.StrType)le.coforeclosure_score), ''),IF (le.coforeclosure_cnt <> 0,TRIM((SALT39.StrType)le.coforeclosure_cnt), ''),IF (le.bcoforeclosure_score <> 0,TRIM((SALT39.StrType)le.bcoforeclosure_score), ''),IF (le.bcoforeclosure_cnt <> 0,TRIM((SALT39.StrType)le.bcoforeclosure_cnt), ''),IF (le.colien_score <> 0,TRIM((SALT39.StrType)le.colien_score), ''),IF (le.colien_cnt <> 0,TRIM((SALT39.StrType)le.colien_cnt), ''),IF (le.bcolien_score <> 0,TRIM((SALT39.StrType)le.bcolien_score), ''),IF (le.bcolien_cnt <> 0,TRIM((SALT39.StrType)le.bcolien_cnt), ''),IF (le.cobankruptcy_score <> 0,TRIM((SALT39.StrType)le.cobankruptcy_score), ''),IF (le.cobankruptcy_cnt <> 0,TRIM((SALT39.StrType)le.cobankruptcy_cnt), ''),IF (le.bcobankruptcy_score <> 0,TRIM((SALT39.StrType)le.bcobankruptcy_score), ''),IF (le.bcobankruptcy_cnt <> 0,TRIM((SALT39.StrType)le.bcobankruptcy_cnt), ''),IF (le.covehicle_score <> 0,TRIM((SALT39.StrType)le.covehicle_score), ''),IF (le.covehicle_cnt <> 0,TRIM((SALT39.StrType)le.covehicle_cnt), ''),IF (le.coexperian_score <> 0,TRIM((SALT39.StrType)le.coexperian_score), ''),IF (le.coexperian_cnt <> 0,TRIM((SALT39.StrType)le.coexperian_cnt), ''),IF (le.cotransunion_score <> 0,TRIM((SALT39.StrType)le.cotransunion_score), ''),IF (le.cotransunion_cnt <> 0,TRIM((SALT39.StrType)le.cotransunion_cnt), ''),IF (le.coenclarity_score <> 0,TRIM((SALT39.StrType)le.coenclarity_score), ''),IF (le.coenclarity_cnt <> 0,TRIM((SALT39.StrType)le.coenclarity_cnt), ''),IF (le.coecrash_score <> 0,TRIM((SALT39.StrType)le.coecrash_score), ''),IF (le.coecrash_cnt <> 0,TRIM((SALT39.StrType)le.coecrash_cnt), ''),IF (le.bcoecrash_score <> 0,TRIM((SALT39.StrType)le.bcoecrash_score), ''),IF (le.bcoecrash_cnt <> 0,TRIM((SALT39.StrType)le.bcoecrash_cnt), ''),IF (le.cowatercraft_score <> 0,TRIM((SALT39.StrType)le.cowatercraft_score), ''),IF (le.cowatercraft_cnt <> 0,TRIM((SALT39.StrType)le.cowatercraft_cnt), ''),IF (le.coaircraft_score <> 0,TRIM((SALT39.StrType)le.coaircraft_score), ''),IF (le.coaircraft_cnt <> 0,TRIM((SALT39.StrType)le.coaircraft_cnt), ''),IF (le.comarriagedivorce_score <> 0,TRIM((SALT39.StrType)le.comarriagedivorce_score), ''),IF (le.comarriagedivorce_cnt <> 0,TRIM((SALT39.StrType)le.comarriagedivorce_cnt), ''),IF (le.coucc_score <> 0,TRIM((SALT39.StrType)le.coucc_score), ''),IF (le.coucc_cnt <> 0,TRIM((SALT39.StrType)le.coucc_cnt), ''),IF (le.lname_score <> 0,TRIM((SALT39.StrType)le.lname_score), ''),IF (le.phone_score <> 0,TRIM((SALT39.StrType)le.phone_score), ''),IF (le.dl_nbr_score <> 0,TRIM((SALT39.StrType)le.dl_nbr_score), ''),IF (le.total_cnt <> 0,TRIM((SALT39.StrType)le.total_cnt), ''),IF (le.total_score <> 0,TRIM((SALT39.StrType)le.total_score), ''),TRIM((SALT39.StrType)le.cluster),TRIM((SALT39.StrType)le.generation),TRIM((SALT39.StrType)le.gender),IF (le.lname_cnt <> 0,TRIM((SALT39.StrType)le.lname_cnt), ''),IF (le.rel_dt_first_seen <> 0,TRIM((SALT39.StrType)le.rel_dt_first_seen), ''),IF (le.rel_dt_last_seen <> 0,TRIM((SALT39.StrType)le.rel_dt_last_seen), ''),IF (le.overlap_months <> 0,TRIM((SALT39.StrType)le.overlap_months), ''),IF (le.hdr_dt_first_seen <> 0,TRIM((SALT39.StrType)le.hdr_dt_first_seen), ''),IF (le.hdr_dt_last_seen <> 0,TRIM((SALT39.StrType)le.hdr_dt_last_seen), ''),IF (le.age_first_seen <> 0,TRIM((SALT39.StrType)le.age_first_seen), ''),TRIM((SALT39.StrType)le.isanylnamematch),TRIM((SALT39.StrType)le.isanyphonematch),TRIM((SALT39.StrType)le.isearlylnamematch),TRIM((SALT39.StrType)le.iscurrlnamematch),TRIM((SALT39.StrType)le.ismixedlnamematch),TRIM((SALT39.StrType)le.ssn1),TRIM((SALT39.StrType)le.ssn2),IF (le.dob1 <> 0,TRIM((SALT39.StrType)le.dob1), ''),IF (le.dob2 <> 0,TRIM((SALT39.StrType)le.dob2), ''),TRIM((SALT39.StrType)le.current_lname1),TRIM((SALT39.StrType)le.current_lname2),TRIM((SALT39.StrType)le.early_lname1),TRIM((SALT39.StrType)le.early_lname2),TRIM((SALT39.StrType)le.addr_ind1),TRIM((SALT39.StrType)le.addr_ind2),IF (le.r2rdid <> 0,TRIM((SALT39.StrType)le.r2rdid), ''),IF (le.r2cnt <> 0,TRIM((SALT39.StrType)le.r2cnt), ''),TRIM((SALT39.StrType)le.personal),TRIM((SALT39.StrType)le.business),TRIM((SALT39.StrType)le.other),IF (le.title <> 0,TRIM((SALT39.StrType)le.title), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.type),TRIM((SALT39.StrType)le.confidence),IF (le.did1 <> 0,TRIM((SALT39.StrType)le.did1), ''),IF (le.did2 <> 0,TRIM((SALT39.StrType)le.did2), ''),IF (le.cohabit_score <> 0,TRIM((SALT39.StrType)le.cohabit_score), ''),IF (le.cohabit_cnt <> 0,TRIM((SALT39.StrType)le.cohabit_cnt), ''),IF (le.coapt_score <> 0,TRIM((SALT39.StrType)le.coapt_score), ''),IF (le.coapt_cnt <> 0,TRIM((SALT39.StrType)le.coapt_cnt), ''),IF (le.copobox_score <> 0,TRIM((SALT39.StrType)le.copobox_score), ''),IF (le.copobox_cnt <> 0,TRIM((SALT39.StrType)le.copobox_cnt), ''),IF (le.cossn_score <> 0,TRIM((SALT39.StrType)le.cossn_score), ''),IF (le.cossn_cnt <> 0,TRIM((SALT39.StrType)le.cossn_cnt), ''),IF (le.copolicy_score <> 0,TRIM((SALT39.StrType)le.copolicy_score), ''),IF (le.copolicy_cnt <> 0,TRIM((SALT39.StrType)le.copolicy_cnt), ''),IF (le.coclaim_score <> 0,TRIM((SALT39.StrType)le.coclaim_score), ''),IF (le.coclaim_cnt <> 0,TRIM((SALT39.StrType)le.coclaim_cnt), ''),IF (le.coproperty_score <> 0,TRIM((SALT39.StrType)le.coproperty_score), ''),IF (le.coproperty_cnt <> 0,TRIM((SALT39.StrType)le.coproperty_cnt), ''),IF (le.bcoproperty_score <> 0,TRIM((SALT39.StrType)le.bcoproperty_score), ''),IF (le.bcoproperty_cnt <> 0,TRIM((SALT39.StrType)le.bcoproperty_cnt), ''),IF (le.coforeclosure_score <> 0,TRIM((SALT39.StrType)le.coforeclosure_score), ''),IF (le.coforeclosure_cnt <> 0,TRIM((SALT39.StrType)le.coforeclosure_cnt), ''),IF (le.bcoforeclosure_score <> 0,TRIM((SALT39.StrType)le.bcoforeclosure_score), ''),IF (le.bcoforeclosure_cnt <> 0,TRIM((SALT39.StrType)le.bcoforeclosure_cnt), ''),IF (le.colien_score <> 0,TRIM((SALT39.StrType)le.colien_score), ''),IF (le.colien_cnt <> 0,TRIM((SALT39.StrType)le.colien_cnt), ''),IF (le.bcolien_score <> 0,TRIM((SALT39.StrType)le.bcolien_score), ''),IF (le.bcolien_cnt <> 0,TRIM((SALT39.StrType)le.bcolien_cnt), ''),IF (le.cobankruptcy_score <> 0,TRIM((SALT39.StrType)le.cobankruptcy_score), ''),IF (le.cobankruptcy_cnt <> 0,TRIM((SALT39.StrType)le.cobankruptcy_cnt), ''),IF (le.bcobankruptcy_score <> 0,TRIM((SALT39.StrType)le.bcobankruptcy_score), ''),IF (le.bcobankruptcy_cnt <> 0,TRIM((SALT39.StrType)le.bcobankruptcy_cnt), ''),IF (le.covehicle_score <> 0,TRIM((SALT39.StrType)le.covehicle_score), ''),IF (le.covehicle_cnt <> 0,TRIM((SALT39.StrType)le.covehicle_cnt), ''),IF (le.coexperian_score <> 0,TRIM((SALT39.StrType)le.coexperian_score), ''),IF (le.coexperian_cnt <> 0,TRIM((SALT39.StrType)le.coexperian_cnt), ''),IF (le.cotransunion_score <> 0,TRIM((SALT39.StrType)le.cotransunion_score), ''),IF (le.cotransunion_cnt <> 0,TRIM((SALT39.StrType)le.cotransunion_cnt), ''),IF (le.coenclarity_score <> 0,TRIM((SALT39.StrType)le.coenclarity_score), ''),IF (le.coenclarity_cnt <> 0,TRIM((SALT39.StrType)le.coenclarity_cnt), ''),IF (le.coecrash_score <> 0,TRIM((SALT39.StrType)le.coecrash_score), ''),IF (le.coecrash_cnt <> 0,TRIM((SALT39.StrType)le.coecrash_cnt), ''),IF (le.bcoecrash_score <> 0,TRIM((SALT39.StrType)le.bcoecrash_score), ''),IF (le.bcoecrash_cnt <> 0,TRIM((SALT39.StrType)le.bcoecrash_cnt), ''),IF (le.cowatercraft_score <> 0,TRIM((SALT39.StrType)le.cowatercraft_score), ''),IF (le.cowatercraft_cnt <> 0,TRIM((SALT39.StrType)le.cowatercraft_cnt), ''),IF (le.coaircraft_score <> 0,TRIM((SALT39.StrType)le.coaircraft_score), ''),IF (le.coaircraft_cnt <> 0,TRIM((SALT39.StrType)le.coaircraft_cnt), ''),IF (le.comarriagedivorce_score <> 0,TRIM((SALT39.StrType)le.comarriagedivorce_score), ''),IF (le.comarriagedivorce_cnt <> 0,TRIM((SALT39.StrType)le.comarriagedivorce_cnt), ''),IF (le.coucc_score <> 0,TRIM((SALT39.StrType)le.coucc_score), ''),IF (le.coucc_cnt <> 0,TRIM((SALT39.StrType)le.coucc_cnt), ''),IF (le.lname_score <> 0,TRIM((SALT39.StrType)le.lname_score), ''),IF (le.phone_score <> 0,TRIM((SALT39.StrType)le.phone_score), ''),IF (le.dl_nbr_score <> 0,TRIM((SALT39.StrType)le.dl_nbr_score), ''),IF (le.total_cnt <> 0,TRIM((SALT39.StrType)le.total_cnt), ''),IF (le.total_score <> 0,TRIM((SALT39.StrType)le.total_score), ''),TRIM((SALT39.StrType)le.cluster),TRIM((SALT39.StrType)le.generation),TRIM((SALT39.StrType)le.gender),IF (le.lname_cnt <> 0,TRIM((SALT39.StrType)le.lname_cnt), ''),IF (le.rel_dt_first_seen <> 0,TRIM((SALT39.StrType)le.rel_dt_first_seen), ''),IF (le.rel_dt_last_seen <> 0,TRIM((SALT39.StrType)le.rel_dt_last_seen), ''),IF (le.overlap_months <> 0,TRIM((SALT39.StrType)le.overlap_months), ''),IF (le.hdr_dt_first_seen <> 0,TRIM((SALT39.StrType)le.hdr_dt_first_seen), ''),IF (le.hdr_dt_last_seen <> 0,TRIM((SALT39.StrType)le.hdr_dt_last_seen), ''),IF (le.age_first_seen <> 0,TRIM((SALT39.StrType)le.age_first_seen), ''),TRIM((SALT39.StrType)le.isanylnamematch),TRIM((SALT39.StrType)le.isanyphonematch),TRIM((SALT39.StrType)le.isearlylnamematch),TRIM((SALT39.StrType)le.iscurrlnamematch),TRIM((SALT39.StrType)le.ismixedlnamematch),TRIM((SALT39.StrType)le.ssn1),TRIM((SALT39.StrType)le.ssn2),IF (le.dob1 <> 0,TRIM((SALT39.StrType)le.dob1), ''),IF (le.dob2 <> 0,TRIM((SALT39.StrType)le.dob2), ''),TRIM((SALT39.StrType)le.current_lname1),TRIM((SALT39.StrType)le.current_lname2),TRIM((SALT39.StrType)le.early_lname1),TRIM((SALT39.StrType)le.early_lname2),TRIM((SALT39.StrType)le.addr_ind1),TRIM((SALT39.StrType)le.addr_ind2),IF (le.r2rdid <> 0,TRIM((SALT39.StrType)le.r2rdid), ''),IF (le.r2cnt <> 0,TRIM((SALT39.StrType)le.r2cnt), ''),TRIM((SALT39.StrType)le.personal),TRIM((SALT39.StrType)le.business),TRIM((SALT39.StrType)le.other),IF (le.title <> 0,TRIM((SALT39.StrType)le.title), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),88*88,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'type'}
      ,{2,'confidence'}
      ,{3,'did1'}
      ,{4,'did2'}
      ,{5,'cohabit_score'}
      ,{6,'cohabit_cnt'}
      ,{7,'coapt_score'}
      ,{8,'coapt_cnt'}
      ,{9,'copobox_score'}
      ,{10,'copobox_cnt'}
      ,{11,'cossn_score'}
      ,{12,'cossn_cnt'}
      ,{13,'copolicy_score'}
      ,{14,'copolicy_cnt'}
      ,{15,'coclaim_score'}
      ,{16,'coclaim_cnt'}
      ,{17,'coproperty_score'}
      ,{18,'coproperty_cnt'}
      ,{19,'bcoproperty_score'}
      ,{20,'bcoproperty_cnt'}
      ,{21,'coforeclosure_score'}
      ,{22,'coforeclosure_cnt'}
      ,{23,'bcoforeclosure_score'}
      ,{24,'bcoforeclosure_cnt'}
      ,{25,'colien_score'}
      ,{26,'colien_cnt'}
      ,{27,'bcolien_score'}
      ,{28,'bcolien_cnt'}
      ,{29,'cobankruptcy_score'}
      ,{30,'cobankruptcy_cnt'}
      ,{31,'bcobankruptcy_score'}
      ,{32,'bcobankruptcy_cnt'}
      ,{33,'covehicle_score'}
      ,{34,'covehicle_cnt'}
      ,{35,'coexperian_score'}
      ,{36,'coexperian_cnt'}
      ,{37,'cotransunion_score'}
      ,{38,'cotransunion_cnt'}
      ,{39,'coenclarity_score'}
      ,{40,'coenclarity_cnt'}
      ,{41,'coecrash_score'}
      ,{42,'coecrash_cnt'}
      ,{43,'bcoecrash_score'}
      ,{44,'bcoecrash_cnt'}
      ,{45,'cowatercraft_score'}
      ,{46,'cowatercraft_cnt'}
      ,{47,'coaircraft_score'}
      ,{48,'coaircraft_cnt'}
      ,{49,'comarriagedivorce_score'}
      ,{50,'comarriagedivorce_cnt'}
      ,{51,'coucc_score'}
      ,{52,'coucc_cnt'}
      ,{53,'lname_score'}
      ,{54,'phone_score'}
      ,{55,'dl_nbr_score'}
      ,{56,'total_cnt'}
      ,{57,'total_score'}
      ,{58,'cluster'}
      ,{59,'generation'}
      ,{60,'gender'}
      ,{61,'lname_cnt'}
      ,{62,'rel_dt_first_seen'}
      ,{63,'rel_dt_last_seen'}
      ,{64,'overlap_months'}
      ,{65,'hdr_dt_first_seen'}
      ,{66,'hdr_dt_last_seen'}
      ,{67,'age_first_seen'}
      ,{68,'isanylnamematch'}
      ,{69,'isanyphonematch'}
      ,{70,'isearlylnamematch'}
      ,{71,'iscurrlnamematch'}
      ,{72,'ismixedlnamematch'}
      ,{73,'ssn1'}
      ,{74,'ssn2'}
      ,{75,'dob1'}
      ,{76,'dob2'}
      ,{77,'current_lname1'}
      ,{78,'current_lname2'}
      ,{79,'early_lname1'}
      ,{80,'early_lname2'}
      ,{81,'addr_ind1'}
      ,{82,'addr_ind2'}
      ,{83,'r2rdid'}
      ,{84,'r2cnt'}
      ,{85,'personal'}
      ,{86,'business'}
      ,{87,'other'}
      ,{88,'title'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_type((SALT39.StrType)le.type),
    Fields.InValid_confidence((SALT39.StrType)le.confidence),
    Fields.InValid_did1((SALT39.StrType)le.did1),
    Fields.InValid_did2((SALT39.StrType)le.did2),
    Fields.InValid_cohabit_score((SALT39.StrType)le.cohabit_score),
    Fields.InValid_cohabit_cnt((SALT39.StrType)le.cohabit_cnt),
    Fields.InValid_coapt_score((SALT39.StrType)le.coapt_score),
    Fields.InValid_coapt_cnt((SALT39.StrType)le.coapt_cnt),
    Fields.InValid_copobox_score((SALT39.StrType)le.copobox_score),
    Fields.InValid_copobox_cnt((SALT39.StrType)le.copobox_cnt),
    Fields.InValid_cossn_score((SALT39.StrType)le.cossn_score),
    Fields.InValid_cossn_cnt((SALT39.StrType)le.cossn_cnt),
    Fields.InValid_copolicy_score((SALT39.StrType)le.copolicy_score),
    Fields.InValid_copolicy_cnt((SALT39.StrType)le.copolicy_cnt),
    Fields.InValid_coclaim_score((SALT39.StrType)le.coclaim_score),
    Fields.InValid_coclaim_cnt((SALT39.StrType)le.coclaim_cnt),
    Fields.InValid_coproperty_score((SALT39.StrType)le.coproperty_score),
    Fields.InValid_coproperty_cnt((SALT39.StrType)le.coproperty_cnt),
    Fields.InValid_bcoproperty_score((SALT39.StrType)le.bcoproperty_score),
    Fields.InValid_bcoproperty_cnt((SALT39.StrType)le.bcoproperty_cnt),
    Fields.InValid_coforeclosure_score((SALT39.StrType)le.coforeclosure_score),
    Fields.InValid_coforeclosure_cnt((SALT39.StrType)le.coforeclosure_cnt),
    Fields.InValid_bcoforeclosure_score((SALT39.StrType)le.bcoforeclosure_score),
    Fields.InValid_bcoforeclosure_cnt((SALT39.StrType)le.bcoforeclosure_cnt),
    Fields.InValid_colien_score((SALT39.StrType)le.colien_score),
    Fields.InValid_colien_cnt((SALT39.StrType)le.colien_cnt),
    Fields.InValid_bcolien_score((SALT39.StrType)le.bcolien_score),
    Fields.InValid_bcolien_cnt((SALT39.StrType)le.bcolien_cnt),
    Fields.InValid_cobankruptcy_score((SALT39.StrType)le.cobankruptcy_score),
    Fields.InValid_cobankruptcy_cnt((SALT39.StrType)le.cobankruptcy_cnt),
    Fields.InValid_bcobankruptcy_score((SALT39.StrType)le.bcobankruptcy_score),
    Fields.InValid_bcobankruptcy_cnt((SALT39.StrType)le.bcobankruptcy_cnt),
    Fields.InValid_covehicle_score((SALT39.StrType)le.covehicle_score),
    Fields.InValid_covehicle_cnt((SALT39.StrType)le.covehicle_cnt),
    Fields.InValid_coexperian_score((SALT39.StrType)le.coexperian_score),
    Fields.InValid_coexperian_cnt((SALT39.StrType)le.coexperian_cnt),
    Fields.InValid_cotransunion_score((SALT39.StrType)le.cotransunion_score),
    Fields.InValid_cotransunion_cnt((SALT39.StrType)le.cotransunion_cnt),
    Fields.InValid_coenclarity_score((SALT39.StrType)le.coenclarity_score),
    Fields.InValid_coenclarity_cnt((SALT39.StrType)le.coenclarity_cnt),
    Fields.InValid_coecrash_score((SALT39.StrType)le.coecrash_score),
    Fields.InValid_coecrash_cnt((SALT39.StrType)le.coecrash_cnt),
    Fields.InValid_bcoecrash_score((SALT39.StrType)le.bcoecrash_score),
    Fields.InValid_bcoecrash_cnt((SALT39.StrType)le.bcoecrash_cnt),
    Fields.InValid_cowatercraft_score((SALT39.StrType)le.cowatercraft_score),
    Fields.InValid_cowatercraft_cnt((SALT39.StrType)le.cowatercraft_cnt),
    Fields.InValid_coaircraft_score((SALT39.StrType)le.coaircraft_score),
    Fields.InValid_coaircraft_cnt((SALT39.StrType)le.coaircraft_cnt),
    Fields.InValid_comarriagedivorce_score((SALT39.StrType)le.comarriagedivorce_score),
    Fields.InValid_comarriagedivorce_cnt((SALT39.StrType)le.comarriagedivorce_cnt),
    Fields.InValid_coucc_score((SALT39.StrType)le.coucc_score),
    Fields.InValid_coucc_cnt((SALT39.StrType)le.coucc_cnt),
    Fields.InValid_lname_score((SALT39.StrType)le.lname_score),
    Fields.InValid_phone_score((SALT39.StrType)le.phone_score),
    Fields.InValid_dl_nbr_score((SALT39.StrType)le.dl_nbr_score),
    Fields.InValid_total_cnt((SALT39.StrType)le.total_cnt),
    Fields.InValid_total_score((SALT39.StrType)le.total_score),
    Fields.InValid_cluster((SALT39.StrType)le.cluster),
    Fields.InValid_generation((SALT39.StrType)le.generation),
    Fields.InValid_gender((SALT39.StrType)le.gender),
    Fields.InValid_lname_cnt((SALT39.StrType)le.lname_cnt),
    Fields.InValid_rel_dt_first_seen((SALT39.StrType)le.rel_dt_first_seen),
    Fields.InValid_rel_dt_last_seen((SALT39.StrType)le.rel_dt_last_seen),
    Fields.InValid_overlap_months((SALT39.StrType)le.overlap_months),
    Fields.InValid_hdr_dt_first_seen((SALT39.StrType)le.hdr_dt_first_seen),
    Fields.InValid_hdr_dt_last_seen((SALT39.StrType)le.hdr_dt_last_seen),
    Fields.InValid_age_first_seen((SALT39.StrType)le.age_first_seen),
    Fields.InValid_isanylnamematch((SALT39.StrType)le.isanylnamematch),
    Fields.InValid_isanyphonematch((SALT39.StrType)le.isanyphonematch),
    Fields.InValid_isearlylnamematch((SALT39.StrType)le.isearlylnamematch),
    Fields.InValid_iscurrlnamematch((SALT39.StrType)le.iscurrlnamematch),
    Fields.InValid_ismixedlnamematch((SALT39.StrType)le.ismixedlnamematch),
    Fields.InValid_ssn1((SALT39.StrType)le.ssn1),
    Fields.InValid_ssn2((SALT39.StrType)le.ssn2),
    Fields.InValid_dob1((SALT39.StrType)le.dob1),
    Fields.InValid_dob2((SALT39.StrType)le.dob2),
    Fields.InValid_current_lname1((SALT39.StrType)le.current_lname1),
    Fields.InValid_current_lname2((SALT39.StrType)le.current_lname2),
    Fields.InValid_early_lname1((SALT39.StrType)le.early_lname1),
    Fields.InValid_early_lname2((SALT39.StrType)le.early_lname2),
    Fields.InValid_addr_ind1((SALT39.StrType)le.addr_ind1),
    Fields.InValid_addr_ind2((SALT39.StrType)le.addr_ind2),
    Fields.InValid_r2rdid((SALT39.StrType)le.r2rdid),
    Fields.InValid_r2cnt((SALT39.StrType)le.r2cnt),
    Fields.InValid_personal((SALT39.StrType)le.personal),
    Fields.InValid_business((SALT39.StrType)le.business),
    Fields.InValid_other((SALT39.StrType)le.other),
    Fields.InValid_title((SALT39.StrType)le.title),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,88,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','Unknown','Unknown','Unknown','Unknown','colien_score','colien_cnt','Unknown','Unknown','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','Unknown','Unknown','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_type(TotalErrors.ErrorNum),Fields.InValidMessage_confidence(TotalErrors.ErrorNum),Fields.InValidMessage_did1(TotalErrors.ErrorNum),Fields.InValidMessage_did2(TotalErrors.ErrorNum),Fields.InValidMessage_cohabit_score(TotalErrors.ErrorNum),Fields.InValidMessage_cohabit_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coapt_score(TotalErrors.ErrorNum),Fields.InValidMessage_coapt_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_copobox_score(TotalErrors.ErrorNum),Fields.InValidMessage_copobox_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_cossn_score(TotalErrors.ErrorNum),Fields.InValidMessage_cossn_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_copolicy_score(TotalErrors.ErrorNum),Fields.InValidMessage_copolicy_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coclaim_score(TotalErrors.ErrorNum),Fields.InValidMessage_coclaim_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coproperty_score(TotalErrors.ErrorNum),Fields.InValidMessage_coproperty_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_bcoproperty_score(TotalErrors.ErrorNum),Fields.InValidMessage_bcoproperty_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coforeclosure_score(TotalErrors.ErrorNum),Fields.InValidMessage_coforeclosure_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_bcoforeclosure_score(TotalErrors.ErrorNum),Fields.InValidMessage_bcoforeclosure_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_colien_score(TotalErrors.ErrorNum),Fields.InValidMessage_colien_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_bcolien_score(TotalErrors.ErrorNum),Fields.InValidMessage_bcolien_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_cobankruptcy_score(TotalErrors.ErrorNum),Fields.InValidMessage_cobankruptcy_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_bcobankruptcy_score(TotalErrors.ErrorNum),Fields.InValidMessage_bcobankruptcy_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_covehicle_score(TotalErrors.ErrorNum),Fields.InValidMessage_covehicle_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coexperian_score(TotalErrors.ErrorNum),Fields.InValidMessage_coexperian_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_cotransunion_score(TotalErrors.ErrorNum),Fields.InValidMessage_cotransunion_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coenclarity_score(TotalErrors.ErrorNum),Fields.InValidMessage_coenclarity_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coecrash_score(TotalErrors.ErrorNum),Fields.InValidMessage_coecrash_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_bcoecrash_score(TotalErrors.ErrorNum),Fields.InValidMessage_bcoecrash_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_cowatercraft_score(TotalErrors.ErrorNum),Fields.InValidMessage_cowatercraft_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coaircraft_score(TotalErrors.ErrorNum),Fields.InValidMessage_coaircraft_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_comarriagedivorce_score(TotalErrors.ErrorNum),Fields.InValidMessage_comarriagedivorce_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_coucc_score(TotalErrors.ErrorNum),Fields.InValidMessage_coucc_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_lname_score(TotalErrors.ErrorNum),Fields.InValidMessage_phone_score(TotalErrors.ErrorNum),Fields.InValidMessage_dl_nbr_score(TotalErrors.ErrorNum),Fields.InValidMessage_total_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_total_score(TotalErrors.ErrorNum),Fields.InValidMessage_cluster(TotalErrors.ErrorNum),Fields.InValidMessage_generation(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_lname_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_rel_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_rel_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_overlap_months(TotalErrors.ErrorNum),Fields.InValidMessage_hdr_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_hdr_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_age_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_isanylnamematch(TotalErrors.ErrorNum),Fields.InValidMessage_isanyphonematch(TotalErrors.ErrorNum),Fields.InValidMessage_isearlylnamematch(TotalErrors.ErrorNum),Fields.InValidMessage_iscurrlnamematch(TotalErrors.ErrorNum),Fields.InValidMessage_ismixedlnamematch(TotalErrors.ErrorNum),Fields.InValidMessage_ssn1(TotalErrors.ErrorNum),Fields.InValidMessage_ssn2(TotalErrors.ErrorNum),Fields.InValidMessage_dob1(TotalErrors.ErrorNum),Fields.InValidMessage_dob2(TotalErrors.ErrorNum),Fields.InValidMessage_current_lname1(TotalErrors.ErrorNum),Fields.InValidMessage_current_lname2(TotalErrors.ErrorNum),Fields.InValidMessage_early_lname1(TotalErrors.ErrorNum),Fields.InValidMessage_early_lname2(TotalErrors.ErrorNum),Fields.InValidMessage_addr_ind1(TotalErrors.ErrorNum),Fields.InValidMessage_addr_ind2(TotalErrors.ErrorNum),Fields.InValidMessage_r2rdid(TotalErrors.ErrorNum),Fields.InValidMessage_r2cnt(TotalErrors.ErrorNum),Fields.InValidMessage_personal(TotalErrors.ErrorNum),Fields.InValidMessage_business(TotalErrors.ErrorNum),Fields.InValidMessage_other(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FileRelative_Monthly, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
