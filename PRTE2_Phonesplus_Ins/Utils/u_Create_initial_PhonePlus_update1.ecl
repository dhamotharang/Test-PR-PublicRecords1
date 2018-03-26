//***********************************************************************
// PRTE2_Phonesplus_Ins.u_Create_initial_PhonePlus_update1
// merging update1 to initial data for PhonePlus
//***********************************************************************
IMPORT PRTE2_Phonesplus_Ins, PRTE2_Header_Ins, PRTE2_X_DataCleanse, PRTE_CSV, Address, PRTE2_Common,ut;
Layouts := PRTE2_Phonesplus_Ins.Layouts;
Files   := PRTE2_Phonesplus_Ins.Files;
u_Files   := PRTE2_Phonesplus_Ins.u_Files;

PhonesPlus_Layout := Layouts.Alpha_CSV_Layout;
PP_DS	:=	PRTE2_Phonesplus_Ins.u_Files.INITIAL_PPLUS_CSV_DS; // New initial data frm u_Create_initial_PhonePlus_data
LIVE_DS0 := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_Prod;
LIVE_DS := DEDUP(SORT(LIVE_DS0,did),did);  // for a few this might affect that final join updating fields but we'll live with that.

cr_rec := RECORD
	string did;
	string phone;
	string fname;
	string lname;
END;

cr_ds := DATASET(
[{'888809043463',	'9075551212',	'SHAWNA', 	'DUNLAVY'}             
,{'888809026254',	'2055551212',	'KEITH', 		'CODELLA'}             
,{'888809023607',	'6025551212',	'JOHN', 		'SIMPSON'}             
,{'888809006544',	'9705551212',	'CHAD',			'FAIRCHILD'}           
,{'888809009892',	'8605551212',	'DAVID',		'BOMANI'}              
,{'888809008710',	'2025551212',	'CYNTHIA',	'CHAPPELL'}            
,{'888809003811',	'3025551212',	'BEVERLY',	'ENGLAND'}             
,{'888809042906',	'2395551212',	'SCOTT',		'HOWELL'}              
,{'888809032589',	'7705551212',	'MARY',			'RUBY'}                
,{'888809018698',	'3195551212',	'ISIAH',		'MEZA'}                
,{'888809046646',	'2085551212',	'THOMAS',		'PETERS'}              
,{'888809010177',	'7735551212',	'DAVID',		'KOCH'}                
,{'888809046061',	'8125551212',	'TERRY',		'GEISER'}
,{'888809018478',	'6205551212',	'HUNTER',		'HACK'}                
,{'888809018905',	'5025551212',	'JACK',			'CLEM'}                
,{'888809045213',	'3185551212',	'SUSAN',		'RAUCCI'}              
,{'888809050094',	'5085551212',	'GEORGE',		'BROWN'}               
,{'888809002971',	'4105551212',	'BARBARA',	'TRUITT'}              
,{'888809027414',	'2075551212',	'KRISTEN',	'STRAUSS'}             
,{'888809046254',	'2315551212',	'THERESA',	'BOURNE'}              
,{'888809014389',	'7635551212',	'ERAL',			'BREAUX'}              
,{'888809033549',	'3145551212',	'MICHAEL',	'BOYER'}               
,{'888809024453',	'6015551212',	'JOSEPH',		'SOUTHLAND'}           
,{'888809037390',	'4065551212',	'PETER',		'BALL'}                
,{'888809046778',	'2525551212',	'TIKI',			'BIRCH'}               
,{'888809002920',	'7015551212',	'BARBARA',	'PINTO'}               
,{'888809008281',	'4025551212',	'CONNIE',		'ALFANO'}              
,{'888809013443',	'8565551212',	'EDNA',			'SPENCER'}             
,{'888809006896',	'5055551212',	'CHARLES',	'MUNTZ'}               
,{'888809038984',	'7025551212',	'RICHARD',	'BATER'}               
,{'888809023919',	'5185551212',	'JONATHAN',	'NATOLI'}              
,{'888809034395',	'3305551212',	'MICKEY',		'BRITTON'}             
,{'888809012323',	'5415551212',	'DONALD',		'TREES'}               
// ,{'xxxxxxxxxxxx 4015551212',	'SERGIO',		'BERTRAND'}            
,{'888809040477',	'8645551212',	'ROBERT',		'OPPERMAN'}            
,{'888809020345',	'6055551212',	'JANET',		'LANDON'}              
,{'888809017254',	'4235551212',	'GREG',			'AUGUSTYN'}            
,{'888809021997',	'9035551212',	'JIM',			'BEAVER'}              
,{'888809033161',	'8015551212',	'MELISSA',	'BIKER'}               
,{'888809014348',	'8025551212',	'EMMALEE',	'BROWN'}               
,{'888809037400',	'6085551212',	'PETER',		'BENT'}                
,{'888809001890',	'3045551212',	'ANNETTE',	'WARD'}                
,{'888809040866',	'3075551211',	'ROCCO',		'BARTHORPE'}           
,{'888809031718',	'',						'MARK',			'MARSUPIAL'}
,{'888809050095',	'',						'JANE',			'MARSUPIAL'}
],cr_rec);

OUTPUT(cr_ds, NAMED('cr_ds'));


PhonesPlus_Layout tr_cr(PhonesPlus_Layout L, cr_rec R) := TRANSFORM
	SELF.homephone 				:=	IF(R.did != '', R.phone, L.homephone);			//string10
	SELF.cellphone 				:=	IF(R.did != '', R.phone, L.cellphone);			//string10
	SELF := L;
END;
PhonesPlus_Layout tr_live(PhonesPlus_Layout L, PhonesPlus_Layout R) := TRANSFORM
	SELF.activeflag := 'Y';	// not sure but let's start with all active
	SELF.datevendorfirstreported := IF(R.did=0, L.datevendorfirstreported, R.datevendorfirstreported);								//unsigned integer3
	SELF.datevendorlastreported := IF(R.did=0, L.datevendorlastreported, R.datevendorlastreported);								//unsigned integer3
	SELF.name_score := IF(R.did=0, L.name_score, R.name_score);			
	SELF.did_score := IF(R.did=0, L.did_score, R.did_score);					
	SELF.listingtype := IF(R.did=0, L.listingtype, R.listingtype);					
	SELF := L;
END;
// -------- First correct the phone numbers for those few records
PP0 := JOIN(PP_DS, cr_ds,
						(string)LEFT.l_did = RIGHT.did,
						tr_cr(Left,Right),LEFT OUTER)						
						: PERSIST('~CT::PERSIST::PhonesPlus_update1',EXPIRE(1),SINGLE);

// -------- Then join with live DS to pull a few fields from the old PP file.
PP := JOIN(PP0, LIVE_DS,
						LEFT.l_did = RIGHT.did,
						tr_live(Left,Right),LEFT OUTER)						
						: PERSIST('~CT::PERSIST::PhonesPlus_update2',EXPIRE(1),SINGLE);

OUTPUT(PP,,u_Files.INITIAL_PPLUS_CSV_update1_FILE, OVERWRITE , NAMED('INITIAL_PPLUS_CSV_update1_FILE'));

OUTPUT(PP(l_did=0),NAMED('ANY_ZEROS'));

rec := RECORD
	string DS_name;
	integer DS_count;
END;

DS_count := DATASET([	 {'PP_DS',COUNT(PP_DS)}
											,{'cr_ds',COUNT(cr_ds)}
											,{'PP0',COUNT(PP0)}
											,{'PP',COUNT(PP)}
											], rec);
OUTPUT(DS_count, NAMED('DS_count'));

/*
EXPORT_DS := SORT(PP,l_did);
dateString			:= ut.GetDate;
desprayName 				:= 'PhonesPlus_NEW_TRIAL_2_'+dateString+'.csv';
LandingZoneIP 	:= PRTE2_Phonesplus_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Phonesplus_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
lzFilePathGatewayFile	:= PRTE2_Phonesplus_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);


// this portion is fot testing only

did_set := [
888809052173
,888809052174
,888809054130
,888809028252
,888809054131
,888809054132
,888809054133
,888809054134
,888809054135
,888809054136
,888809054137
,888809054138
,888809054139
,888809052175
,888809052176
,888809052177
,888809052178
,888809054140
,888809054141
];

OUTPUT(PP_DS(l_did IN did_set), NAMED('PP_DS_set'));
OUTPUT(PP(l_did IN did_set), NAMED('PP_set'));
Dirty_MHDR := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_DS;

OUTPUT(Dirty_MHDR(did IN did_set), NAMED('Dirty_MHDR_set'));
*/