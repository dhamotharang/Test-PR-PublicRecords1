EXPORT sample_phonemart_base := FUNCTION

  base 					:= DATASET('~thor_data400::base::phonemart',PhoneMart.Layouts.base,THOR);
  father 				:= DATASET('~thor_data400::base::phonemart_father',PhoneMart.Layouts.base,THOR);
	//get records that are in new base and not in base_father
	base_sorted 	:= SORT(DISTRIBUTE(base(did<>0),did),did,LOCAL);
	father_sorted := SORT(DISTRIBUTE(father(did<>0),did),did,LOCAL);
	left_only 		:= JOIN(base_sorted,
											  father_sorted,
											  LEFT.did = RIGHT.did,
											  TRANSFORM({base_sorted},SELF:=LEFT;),
											  LEFT ONLY, LOCAL);
	sample_new		:= CHOOSEN(SAMPLE(left_only(record_type='1'),100,1),100) +
									 CHOOSEN(SAMPLE(left_only(record_type='2'),100,1),100) +
									 CHOOSEN(SAMPLE(left_only(record_type='4'),100,1),100);
	
	//get new and dropped ID (CID, CSD, SSN) counts
	base_cid_sorted 	:= SORT(DISTRIBUTE(base(CID_NUMBER<>'' AND record_type='1' AND HISTORY_FLAG=''),HASH(CID_NUMBER)),CID_NUMBER,LOCAL);
	father_cid_sorted := SORT(DISTRIBUTE(father(CID_NUMBER<>'' AND record_type='1'),HASH(CID_NUMBER)),CID_NUMBER,LOCAL);
	left_cid_only 		:= JOIN(base_cid_sorted,
											      father_cid_sorted,
														LEFT.CID_NUMBER = RIGHT.CID_NUMBER,
														TRANSFORM({base_cid_sorted},SELF:=LEFT;),
														LEFT ONLY, LOCAL);
	right_cid_only 		:= JOIN(base_cid_sorted,
											      father_cid_sorted,
														LEFT.CID_NUMBER = RIGHT.CID_NUMBER,
														TRANSFORM({father_cid_sorted},SELF:=RIGHT;),
														RIGHT ONLY, LOCAL);
	new_cid_cnt				:= COUNT(TABLE(left_cid_only,{CID_NUMBER,COUNT(GROUP)},CID_NUMBER));
	dropped_cid_cnt				:= COUNT(TABLE(right_cid_only,{CID_NUMBER,COUNT(GROUP)},CID_NUMBER));
	
	base_csd_sorted 	:= SORT(DISTRIBUTE(base(CSD_REF_NUMBER<>'' AND record_type='2' AND HISTORY_FLAG=''),HASH(CSD_REF_NUMBER)),CSD_REF_NUMBER,LOCAL);
	father_csd_sorted := SORT(DISTRIBUTE(father(CSD_REF_NUMBER<>'' AND record_type='2'),HASH(CSD_REF_NUMBER)),CSD_REF_NUMBER,LOCAL);
	left_csd_only 		:= JOIN(base_csd_sorted,
											      father_csd_sorted,
														LEFT.CSD_REF_NUMBER = RIGHT.CSD_REF_NUMBER,
														TRANSFORM({base_csd_sorted},SELF:=LEFT;),
														LEFT ONLY, LOCAL);
	right_csd_only 		:= JOIN(base_csd_sorted,
											      father_csd_sorted,
														LEFT.CSD_REF_NUMBER = RIGHT.CSD_REF_NUMBER,
														TRANSFORM({father_csd_sorted},SELF:=RIGHT;),
														RIGHT ONLY, LOCAL);
	new_csd_cnt				:= COUNT(TABLE(left_csd_only,{CSD_REF_NUMBER,COUNT(GROUP)},CSD_REF_NUMBER));
	dropped_csd_cnt		:= COUNT(TABLE(right_csd_only,{CSD_REF_NUMBER,COUNT(GROUP)},CSD_REF_NUMBER));
	
	//The 3 file is update only. Use the input file to shorten the process time
	indv							:= PhoneMart.Files.PhoneMart_Indv;
	indv_sorted			 	:= SORT(DISTRIBUTE(indv(SSN<>''),HASH(SSN)),SSN,LOCAL);
	father_ssn_sorted := SORT(DISTRIBUTE(father(SSN<>'' AND record_type='4'),HASH(SSN)),SSN,LOCAL);
	left_ssn_only 		:= JOIN(indv_sorted,
											      father_ssn_sorted,
														LEFT.SSN = RIGHT.SSN,
														TRANSFORM({indv_sorted},SELF:=LEFT;),
														LEFT ONLY, LOCAL);
	new_ssn_cnt				:= COUNT(TABLE(left_ssn_only,{SSN,COUNT(GROUP)},SSN));
	
	RETURN SEQUENTIAL(OUTPUT('# of new records in base file = ' + COUNT(left_only)),
										OUTPUT('CMS: # of new CIDs = ' + new_cid_cnt + ', # of dropped CIDs = ' + dropped_cid_cnt + '.',NAMED('CID_count')),
										output(right_cid_only),
										OUTPUT('CSD: # of new CSDs = ' + new_csd_cnt + ', # of dropped CSDs = ' + dropped_csd_cnt + '.',NAMED('CSD_count')),
										output(right_csd_only);
										OUTPUT('SSN: # of new SSNs = ' + new_ssn_cnt + '.',NAMED('SSN_count')),
	                  OUTPUT(sample_new,,NAMED('sample_phonemart_base_new_records'))
										);

END;