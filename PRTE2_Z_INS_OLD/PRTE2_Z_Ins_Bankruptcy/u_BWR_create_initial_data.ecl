//--------------------------------------------------------------------
// PRTE2_Bankruptcy.u_BWR_create_initial_data
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------
//---------------------------------------------------
// Initial data creation utility
//---------------------------------------------------
IMPORT PRTE2_Bankruptcy, PRTE2_Header_Ins, PRTE2_X_DataCleanse, PRTE_CSV;
#workunit('name', 'PRTE2 Bankruptcy Initial_Data');

Layout := PRTE2_Bankruptcy.Layouts;

//---------------- Isolate Clean MHDR that have no duplicates did -----------------------------------

MHDR_Layout := PRTE2_X_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
Dirty_MHDR := PRTE2_X_DataCleanse.Files_Alpha.Merged_Headers_SF_DS((integer)addr_ind=1);

MHDR_dup_stat := RECORD
	string dup_stat;
	integer did;
END;
MHDR_dup_stat tr_add_status(MHDR_Layout L) := TRANSFORM
	SELF.dup_stat := '';
	SELF.did := L.did;
END;
MHDR_dup_statDS := PROJECT(Dirty_MHDR, tr_add_status(LEFT));

MHDR_dup_stat tr_dd_MHDR(MHDR_dup_stat L, MHDR_dup_stat R) := TRANSFORM
	SELF.dup_stat := IF(R.did = L.did, 'd','s');
	SELF.did := R.did;
END;
MHDR_dup_stat_info_DS := ITERATE(SORT(MHDR_dup_statDS, did), tr_dd_MHDR(LEFT, RIGHT));

Dirty_did_MHDR_DS := MHDR_dup_stat_info_DS(dup_stat = 'd');
Dirty_unique_did_MHDR_DS := DEDUP(SORT(Dirty_did_MHDR_DS,did));
Dirty_did_MHDR_set := set(Dirty_unique_did_MHDR_DS,did);

Only_Dirty_MHDR := Dirty_MHDR(did IN Dirty_did_MHDR_set);
MHDR := Dirty_MHDR(did NOT IN Dirty_did_MHDR_set);
//----------------- Clean MHDR created as MHDR -------------------------------------
OUTPUT(Only_Dirty_MHDR, NAMED('Only_Dirty_MHDR'));
OUTPUT(MHDR, NAMED('MHDR'));

BB_status 	:= PRTE_CSV.Bankruptcy_Files.status;
BB_comments := PRTE_CSV.Bankruptcy_Files.comments;
BB_main 		:= PRTE_CSV.Bankruptcy_Files.main;
BB_search 	:= PRTE_CSV.Bankruptcy_Files.search;


OUTPUT(BB_status,NAMED('BB_status'));
OUTPUT(BB_comments,NAMED('BB_comments'));
OUTPUT(BB_main,NAMED('BB_main'));
OUTPUT(BB_search,NAMED('BB_search'));


EIR_XREF_BASE_DS := PRTE2_X_DataCleanse.Files.EIR_XREF_BASE_DS;
OUTPUT(EIR_XREF_BASE_DS,NAMED('EIR_XREF_BASE_DS'));

BK_EIR_XREF_BASE_DS := EIR_XREF_BASE_DS(bk_cnt>0);
OUTPUT(BK_EIR_XREF_BASE_DS,NAMED('BK_EIR_XREF_BASE_DS'));

/*
TRC1 := COUNT(BK_EIR_XREF_BASE_DS);
state_dist_rec := RECORD
	BK_EIR_XREF_BASE_DS.st;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC1*100;
END;
state_dist_table := TABLE(BK_EIR_XREF_BASE_DS,state_dist_rec,st,FEW);
OUTPUT(sort(state_dist_table,-GrpCount), NAMED('XREF_state_dist'));
*/

TRC2 := COUNT(BB_main);
BB_main_state_dist_rec := RECORD
	BB_main.filing_jurisdiction;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC2*100;
END;
BB_main_state_dist_table := TABLE(BB_main,BB_main_state_dist_rec,filing_jurisdiction,FEW);
OUTPUT(sort(BB_main_state_dist_table,-GrpCount), NAMED('BB_main_state_dist'));



rec := RECORD
	string DS_name;
	integer DS_count;
END;

DS_count := DATASET([	 {'MHDR',COUNT(MHDR)}
											,{'Dirty_MHDR',COUNT(Dirty_MHDR)}
											,{'BB_status',COUNT(BB_status)}
											,{'BB_comments',COUNT(BB_comments)}
											,{'BB_main',COUNT(BB_main)}
											,{'BB_search',COUNT(BB_search)}
											,{'EIR_XREF_BASE_DS',COUNT(EIR_XREF_BASE_DS)}
											,{'BK_EIR_XREF_BASE_DS',COUNT(BK_EIR_XREF_BASE_DS)}
											], rec);
OUTPUT(DS_count, NAMED('DS_count'));


/*
check_data_set := [888809043463
,888809026254
,888809023607
,888809006544
,888809009892
,888809008710
,888809003811
,888809042906
,888809032589
,888809018698
,888809046646
,888809010177
,888809046061
,888809018478
,888809018905
,888809045213
,888809050094
,888809002971
,888809027414
,888809046254
,888809014389
,888809033549
,888809024453
,888809037390
,888809046778
,888809002920
,888809008281
,888809013443
,888809006896
,888809038984
,888809023919
,888809034395
,888809012323

,888809040477
,888809020345
,888809017254
,888809021997
,888809033161
,888809014348
,888809037400
,888809001890
,888809040866
,888809031718
,888809050095
];

check_MHDR := MHDR(did IN check_data_set);

OUTPUT(check_MHDR, NAMED('check_MHDR'));


fname_MHDR_set 	:= ['GEORGE','SERGIO','JANE'];
lname_MHDR_set 	:= ['BROWN','BARTRAND','MARSUPIAL'];
zip_MHDR_set 		:= ['02324','28792','45817'];

mising_did := MHDR(fname IN fname_MHDR_set, lname IN lname_MHDR_set, zip[1..5] IN zip_MHDR_set);
OUTPUT(mising_did, NAMED('mising_did'));
*/
