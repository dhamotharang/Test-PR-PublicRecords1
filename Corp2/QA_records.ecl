export QA_records(

	dataset(Layout_Corporate_Direct_Corp_Base) pDataset

) :=
function

	corp_AK := pDataset(corp_state_origin = 'AK');
	corp_AL := pDataset(corp_state_origin = 'AL');
	corp_AR := pDataset(corp_state_origin = 'AR');
	corp_AZ := pDataset(corp_state_origin = 'AZ');
	corp_CA := pDataset(corp_state_origin = 'CA');
	corp_CO := pDataset(corp_state_origin = 'CO');
	corp_CT := pDataset(corp_state_origin = 'CT');
	corp_DC := pDataset(corp_state_origin = 'DC');
	corp_FL := pDataset(corp_state_origin = 'FL');
	corp_GA := pDataset(corp_state_origin = 'GA');
	corp_HI := pDataset(corp_state_origin = 'HI');
	corp_IA := pDataset(corp_state_origin = 'IA');
	corp_ID := pDataset(corp_state_origin = 'ID');
	corp_IL := pDataset(corp_state_origin = 'IL');
	corp_IN := pDataset(corp_state_origin = 'IN');
	corp_KS := pDataset(corp_state_origin = 'KS');
	corp_KY := pDataset(corp_state_origin = 'KY');
	corp_LA := pDataset(corp_state_origin = 'LA');
	corp_MA := pDataset(corp_state_origin = 'MA');
	corp_MD := pDataset(corp_state_origin = 'MD');
	corp_ME := pDataset(corp_state_origin = 'ME');
	corp_MI := pDataset(corp_state_origin = 'MI');
	corp_MN := pDataset(corp_state_origin = 'MN');
	corp_MO := pDataset(corp_state_origin = 'MO');
	corp_MS := pDataset(corp_state_origin = 'MS');
	corp_MT := pDataset(corp_state_origin = 'MT');
	corp_NC := pDataset(corp_state_origin = 'NC');
	corp_ND := pDataset(corp_state_origin = 'ND');
	corp_NE := pDataset(corp_state_origin = 'NE');
	corp_NH := pDataset(corp_state_origin = 'NH');
	corp_NJ := pDataset(corp_state_origin = 'NJ');
	corp_NM := pDataset(corp_state_origin = 'NM');
	corp_NV := pDataset(corp_state_origin = 'NV');
	corp_NY := pDataset(corp_state_origin = 'NY');
	corp_OH := pDataset(corp_state_origin = 'OH');
	corp_OK := pDataset(corp_state_origin = 'OK');
	corp_OR := pDataset(corp_state_origin = 'OR');
	corp_PA := pDataset(corp_state_origin = 'PA');
	corp_RI := pDataset(corp_state_origin = 'RI');
	corp_SC := pDataset(corp_state_origin = 'SC');
	corp_SD := pDataset(corp_state_origin = 'SD');
	corp_TN := pDataset(corp_state_origin = 'TN');
	corp_TX := pDataset(corp_state_origin = 'TX');
	corp_UT := pDataset(corp_state_origin = 'UT');
	corp_VA := pDataset(corp_state_origin = 'VA');
	corp_VT := pDataset(corp_state_origin = 'VT');
	corp_WA := pDataset(corp_state_origin = 'WA');
	corp_WI := pDataset(corp_state_origin = 'WI');
	corp_WV := pDataset(corp_state_origin = 'WV');
	corp_WY := pDataset(corp_state_origin = 'WY');

	samplefile_AK := topn(corp_AK, 20, -dt_first_seen);
	samplefile_AL := topn(corp_AL, 20, -dt_first_seen);
	samplefile_AR := topn(corp_AR, 20, -dt_first_seen);
	samplefile_AZ := topn(corp_AZ, 20, -dt_first_seen);
	samplefile_CA := topn(corp_CA, 20, -dt_first_seen);
	samplefile_CO := topn(corp_CO, 20, -dt_first_seen);
	samplefile_CT := topn(corp_CT, 20, -dt_first_seen);
	samplefile_DC := topn(corp_DC, 20, -dt_first_seen);
	samplefile_FL := topn(corp_FL, 20, -dt_first_seen);
	samplefile_GA := topn(corp_GA, 20, -dt_first_seen);
	samplefile_HI := topn(corp_HI, 20, -dt_first_seen);
	samplefile_IA := topn(corp_IA, 20, -dt_first_seen);
	samplefile_ID := topn(corp_ID, 20, -dt_first_seen);
	samplefile_IL := topn(corp_IL, 20, -dt_first_seen);
	samplefile_IN := topn(corp_IN, 20, -dt_first_seen);
	samplefile_KS := topn(corp_KS, 20, -dt_first_seen);
	samplefile_KY := topn(corp_KY, 20, -dt_first_seen);
	samplefile_LA := topn(corp_LA, 20, -dt_first_seen);
	samplefile_MA := topn(corp_MA, 20, -dt_first_seen);
	samplefile_MD := topn(corp_MD, 20, -dt_first_seen);
	samplefile_ME := topn(corp_ME, 20, -dt_first_seen);
	samplefile_MI := topn(corp_MI, 20, -dt_first_seen);
	samplefile_MN := topn(corp_MN, 20, -dt_first_seen);
	samplefile_MO := topn(corp_MO, 20, -dt_first_seen);
	samplefile_MS := topn(corp_MS, 20, -dt_first_seen);
	samplefile_MT := topn(corp_MT, 20, -dt_first_seen);
	samplefile_NC := topn(corp_NC, 20, -dt_first_seen);
	samplefile_ND := topn(corp_ND, 20, -dt_first_seen);
	samplefile_NE := topn(corp_NE, 20, -dt_first_seen);
	samplefile_NH := topn(corp_NH, 20, -dt_first_seen);
	samplefile_NJ := topn(corp_NJ, 20, -dt_first_seen);
	samplefile_NM := topn(corp_NM, 20, -dt_first_seen);
	samplefile_NV := topn(corp_NV, 20, -dt_first_seen);
	samplefile_NY := topn(corp_NY, 20, -dt_first_seen);
	samplefile_OH := topn(corp_OH, 20, -dt_first_seen);
	samplefile_OK := topn(corp_OK, 20, -dt_first_seen);
	samplefile_OR := topn(corp_OR, 20, -dt_first_seen);
	samplefile_PA := topn(corp_PA, 20, -dt_first_seen);
	samplefile_RI := topn(corp_RI, 20, -dt_first_seen);
	samplefile_SC := topn(corp_SC, 20, -dt_first_seen);
	samplefile_SD := topn(corp_SD, 20, -dt_first_seen);
	samplefile_TN := topn(corp_TN, 20, -dt_first_seen);
	samplefile_TX := topn(corp_TX, 20, -dt_first_seen);
	samplefile_UT := topn(corp_UT, 20, -dt_first_seen);
	samplefile_VA := topn(corp_VA, 20, -dt_first_seen);
	samplefile_VT := topn(corp_VT, 20, -dt_first_seen);
	samplefile_WA := topn(corp_WA, 20, -dt_first_seen);
	samplefile_WI := topn(corp_WI, 20, -dt_first_seen);
	samplefile_WV := topn(corp_WV, 20, -dt_first_seen);
	samplefile_WY := topn(corp_WY, 20, -dt_first_seen);
														
	all_new_records := 
			samplefile_AK
		+ samplefile_AL
		+ samplefile_AR
		+ samplefile_AZ
		+ samplefile_CA
		+ samplefile_CO
		+ samplefile_CT
		+ samplefile_DC
		+ samplefile_FL
		+ samplefile_GA
		+ samplefile_HI
		+ samplefile_IA
		+ samplefile_ID
		+ samplefile_IL
		+ samplefile_IN
		+ samplefile_KS
		+ samplefile_KY
		+ samplefile_LA
		+ samplefile_MA
		+ samplefile_MD
		+ samplefile_ME
		+ samplefile_MI
		+ samplefile_MN
		+ samplefile_MO
		+ samplefile_MS
		+ samplefile_MT
		+ samplefile_NC
		+ samplefile_ND
		+ samplefile_NE
		+ samplefile_NH
		+ samplefile_NJ
		+ samplefile_NM
		+ samplefile_NV
		+ samplefile_NY
		+ samplefile_OH
		+ samplefile_OK
		+ samplefile_OR
		+ samplefile_PA
		+ samplefile_RI
		+ samplefile_SC
		+ samplefile_SD
		+ samplefile_TN
		+ samplefile_TX
		+ samplefile_UT
		+ samplefile_VA
		+ samplefile_VT
		+ samplefile_WA
		+ samplefile_WI
		+ samplefile_WV
		+ samplefile_WY
		;

	return output(all_new_records, named('SampleNewRecordsForQA'), all);

end;