# python HackOMatic.py -H INS_EL_Hacks.py -D "c:\users\limaam\git\dev\thor\Insurance\InsuranceHeader_xlink" -d
##---------------------------------------------------------------------------
##CONFIGHACK
##Config change
##---------------------------------------------------------------------------
def dConfig(): 
	return [
		('config','EXPORT DOB_Force := 3;'			,'HACK01a','EXPORT DOB_Force := 3;\nEXPORT DOB_NotUseForce := IF (Environment.Current=Environment.Values.ALPHA, TRUE, FALSE)/*HACK01a*/;','testing DobForce hack'),
		('config','(EXPORT STRING PayloadKeyName_sf := )(.*?;)','HACK01b','\g<1> InsuranceHeader_xLink.KeyNames().header_super;/*HACK01b*/;','payload keyname'),
		('config','END;'					,'HACK01c','EXPORT INTEGER FNAME_LENGTH_EDIT2 := 6; // fname length to use edit2\nEXPORT INTEGER LNAME_LENGTH_EDIT2 := 8; // lname length to use edit2\nEXPORT NAME_WEIGHT := 0.8;\nEXPORT AddrPenalty := 1.0; /*HACK01c*/\nEND;','Additional configs')	
	]

##---------------------------------------------------------------------------
##RawFetch_fnameEditDistance
##Key hacks 
#---------------------------------------------------------------------------
def dRawFetchFnameEditDist():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch'),
		('Key_InsuranceHeader_DLN'		,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch'),
		('Key_InsuranceHeader_PH'		,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch'),
		('Key_InsuranceHeader_RELATIVE'	,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch'),
		('Key_InsuranceHeader_SSN'		,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch'),
		('Key_InsuranceHeader_DOB'		,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch'),
		('Key_InsuranceHeader_ZIP_PR'	,'Config\.WithinEditN\(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1, 0\)','HACK02','Config.WithinEditN(FNAME,FNAME_len,param_FNAME,param_FNAME_len,1,Config.FNAME_LENGTH_EDIT2) /*HACK02*/','Conditional Edit Distance for fname in RawFetch')
	]

##---------------------------------------------------------------------------
##j0j1_fnameEditDist
##Key hacks
##---------------------------------------------------------------------------
def dJ0J1FnameEditDist():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1'),
		('Key_InsuranceHeader_DLN'		,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1'),
		('Key_InsuranceHeader_PH'		,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1'),
		('Key_InsuranceHeader_RELATIVE'	,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1'),
		('Key_InsuranceHeader_SSN'		,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1'),
		('Key_InsuranceHeader_DOB'		,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1'),
		('Key_InsuranceHeader_ZIP_PR'	,'Config\.WithinEditN\(RIGHT\.FNAME,RIGHT\.FNAME_len,LEFT\.FNAME,LEFT.FNAME_len,1, 0\)','HACK05','Config.WithinEditN(RIGHT.FNAME,RIGHT.FNAME_len,LEFT.FNAME,LEFT.FNAME_len,1, Config.FNAME_LENGTH_EDIT2) /*HACK05*/', 'Conditional Edit Distance for fname joins J0 and J1')
	]


##---------------------------------------------------------------------------
##rawFetch_lnameEditDist
##Key hacks
##---------------------------------------------------------------------------
def dRawFetchLnameEditDist():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch'),
		('Key_InsuranceHeader_DLN'		,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch'),
		('Key_InsuranceHeader_PH'		,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch'),
		('Key_InsuranceHeader_RELATIVE'	,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch'),
		('Key_InsuranceHeader_SSN'		,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch'),
		('Key_InsuranceHeader_DOBF'		,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch'),
		('Key_InsuranceHeader_ZIP_PR'	,'Config\.WithinEditN\(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1, 0\)','HACK06','Config.WithinEditN(LNAME,LNAME_len,param_LNAME,param_LNAME_len,1,Config.LNAME_LENGTH_EDIT2) /*HACK06*/', 'Conditional Edit Distance for lname in RawFetch')
	]


##---------------------------------------------------------------------------
##j0j1_lnameEditDist
##Key hacks
##---------------------------------------------------------------------------
def dJ0J1LnameEditDist():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1'),
		('Key_InsuranceHeader_DLN'		,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1'),
		('Key_InsuranceHeader_PH'		,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1'),
		('Key_InsuranceHeader_RELATIVE'	,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1'),
		('Key_InsuranceHeader_SSN'		,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1'),
		('Key_InsuranceHeader_DOBF'		,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1'),
		('Key_InsuranceHeader_ZIP_PR'	,'Config\.WithinEditN\(RIGHT\.LNAME,RIGHT\.LNAME_len,LEFT\.LNAME,LEFT\.LNAME_len,1, 0\)','HACK09','Config.WithinEditN(RIGHT.LNAME,RIGHT.LNAME_len,LEFT.LNAME,LEFT.LNAME_len,1, Config.LNAME_LENGTH_EDIT2) /*HACK09*/', 'Conditional Edit Distance for lname joins J0 and J1')
	]

##---------------------------------------------------------------------------
##key_name
##Key hacks
##---------------------------------------------------------------------------
def dKeyName():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_DLN'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_PH'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_NAME'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_SRC_RID'	,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_SRC_RID'	,',KeyName_sf\);','HACK10a',',KeyName_sf, OPT); /*HACK10a*/', 'Optional key in Public Records'),
		('Key_InsuranceHeader_SSN4'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_RELATIVE'	,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_SSN'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_DOB'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_DOBF'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_LFZ'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Process_xIDL_Layouts'			,'(EXPORT KeyName_sf )([^;]*?)(::DID::meow\';)','HACK10','EXPORT KeyName_sf := KeyNames().header_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_ZIP_PR'	,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Key_InsuranceHeader_VIN'		,'(EXPORT KeyName_sf := )(.*?Refs::)(.*?)(\';)','HACK10','\g<1>KeyNames().\g<3>_super; /*HACK10*/', 'Superfile reference'),
		('Keys', '(Name_sf := )(\'~\'\+)(KeyPrefix \+)(\'::\' \+ \'key::)(.*?;)', 'HACK51', 'Name_sf := \g<3> \'key::\g<5> /*HACK51*/', 'Superfile reference')
	]

def dKeyNameLogical():
	return [
	('Key_InsuranceHeader_ADDRESS'	,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_DLN'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_PH'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_NAME'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_SRC_RID'	,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_SSN4'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_RELATIVE'	,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_SSN'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_DOB'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_DOBF'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_LFZ'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Process_xIDL_Layouts'			,'(EXPORT KeyName := )([^;]*?)(::DID::meow\';)','HACK40','EXPORT KeyName := KeyNames().header_logical; /*HACK40*/', 'Logical file reference'),
	('Process_xIDL_Layouts'			,'(EXPORT KeyIDHistoryName := )([^;]*?)(::DID::sup::RID\';)','HACK40a','EXPORT KeyIDHistoryName := KeyNames().id_history_logical; /*HACK40a*/', 'Logical file reference'),
	('Process_xIDL_Layouts'			,'(EXPORT Key0Name := )([^;]*?)(::DID::meow::DID0\';)','HACK40b','EXPORT Key0Name := KeyNames().header0_logical; /*HACK40b*/', 'Logical file reference'),
	('Process_xIDL_Layouts'			,'(EXPORT Key1Name := )([^;]*?)(::DID::meow::DID1\';)','HACK40c','EXPORT Key1Name := KeyNames().header1_logical; /*HACK40c*/', 'Logical file reference'),
	('Key_InsuranceHeader_ZIP_PR' 	,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Key_InsuranceHeader_VIN'		,'(EXPORT KeyName := )(.*?Refs::)(.*?)(\';)','HACK40','\g<1>KeyNames().\g<3>_logical; /*HACK40*/', 'Logical file reference'),
	('Keys', '(Name := )(\'~\'\+)(KeyPrefix \+)(\'::\' \+ \'key::)(.*?;)', 'HACK50', 'Name := \g<3> \'key::\g<5> /*HACK50*/', 'Logical file reference')
	]

##---------------------------------------------------------------------------
##rawFetch_wordbag
##Key hacks
##---------------------------------------------------------------------------
def dRawFetchWordbag():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)FNAME,FNAME_MAINNAME_weight100,true,0,true,FNAME_initial_char_weight100','HACK11','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,false,FNAME_initial_char_weight100/*HACK11*/', 'First Initial wordbag match in RawFetch'),
		('Key_InsuranceHeader_DLN'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)FNAME,FNAME_MAINNAME_weight100,true,0,true,FNAME_initial_char_weight100','HACK11','(SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,false,FNAME_initial_char_weight100/*HACK11*/', 'First Initial wordbag match in RawFetch'),
		('Key_InsuranceHeader_PH'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)FNAME,FNAME_MAINNAME_weight100,true,0,true,FNAME_initial_char_weight100','HACK11','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,false,FNAME_initial_char_weight100/*HACK11*/', 'First Initial wordbag match in RawFetch'),
		('Key_InsuranceHeader_SSN'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)FNAME,FNAME_MAINNAME_weight100,true,0,true,FNAME_initial_char_weight100','HACK11','(SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)FNAME,FNAME_MAINNAME_weight100,true,0,false,FNAME_initial_char_weight100/*HACK11*/', 'First Initial wordbag match in RawFetch')	
	]

##---------------------------------------------------------------------------
##ScoreDidFetch_wordbag
##Key hacks
##---------------------------------------------------------------------------
def dScoreDidFetchWordbag():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)le\.FNAME,le\.FNAME_MAINNAME_weight100,true,0,true','HACK12','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,FALSE /*HACK12*/', 'First Initial wordbag match in ScoredDIDFetch'),
		('Key_InsuranceHeader_DLN'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)le\.FNAME,le\.FNAME_MAINNAME_weight100,true,0,true','HACK12','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,FALSE /*HACK12*/', 'First Initial wordbag match in ScoredDIDFetch'),
		('Key_InsuranceHeader_PH'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)le\.FNAME,le\.FNAME_MAINNAME_weight100,true,0,true','HACK12','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,FALSE /*HACK12*/', 'First Initial wordbag match in ScoredDIDFetch'),
		('Key_InsuranceHeader_SSN'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)le\.FNAME,le\.FNAME_MAINNAME_weight100,true,0,true','HACK12','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)le.FNAME,le.FNAME_MAINNAME_weight100,true,0,FALSE /*HACK12*/', 'First Initial wordbag match in ScoredDIDFetch')
	]

##---------------------------------------------------------------------------
##JoinJ0J1_wordbag
##Key hacks
##---------------------------------------------------------------------------
def dJ0J1WordBag():
	return [
		('Key_InsuranceHeader_ADDRESS'	,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)RIGHT\.FNAME,RIGHT\.FNAME_MAINNAME_weight100,true,0,true','HACK13','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,false/*HACK13*/', 'First Initial wordbag match in joins J0 and J1'),
		('Key_InsuranceHeader_DLN'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)RIGHT\.FNAME,RIGHT\.FNAME_MAINNAME_weight100,true,0,true','HACK13','(SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,false/*HACK13*/', 'First Initial wordbag match in joins J0 and J1'),
		('Key_InsuranceHeader_PH'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)RIGHT\.FNAME,RIGHT\.FNAME_MAINNAME_weight100,true,0,true','HACK13','SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,false/*HACK13*/', 'First Initial wordbag match in joins J0 and J1'),
		('Key_InsuranceHeader_SSN'		,'SALT311\.fn_concept_wordbag_EditN_EL\.Match3\(\(SALT311\.StrType\)RIGHT\.FNAME,RIGHT\.FNAME_MAINNAME_weight100,true,0,true','HACK13','(SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)RIGHT.FNAME,RIGHT.FNAME_MAINNAME_weight100,true,0,false/*HACK13*/', 'First Initial wordbag match in joins J0 and J1')
	]	
	
##---------------------------------------------------------------------------
##Key_InsuranceHeader_SSN hacks
##Key hacks
##---------------------------------------------------------------------------
def dKeyInsuranceHeaderSSN():
	return [
		('Key_InsuranceHeader_SSN'		,'\) > 0\)\),Config\.SSN_MAXBLOCKLIMIT'	,'HACK14a',') > 0\nOR FNAME = param_FNAME))),Config.SSN_MAXBLOCKLIMIT /*HACK14a*/', 'SSN key rawfetch2'),
		('Key_InsuranceHeader_SSN'		,'\) > 0\)\),Score_Batch'			,'HACK14b',') > 0\n OR LEFT.FNAME = RIGHT.FNAME)) ),/*HACK14b*/Score_Batch', 		'J0 and J1 wordbag hack2')
	]	
	
##---------------------------------------------------------------------------
##Key_InsuranceHeader_SSN hacks
##Key hacks
##---------------------------------------------------------------------------
def dKeyInsuranceHeaderDLN():
	return [
		('Key_InsuranceHeader_DLN'		,'\) > 0\)\),Config\.DLN_MAXBLOCKLIMIT'	,'HACK14c',') > 0\nOR FNAME = param_FNAME))),Config.DLN_MAXBLOCKLIMIT /*HACK14c*/', 'DLN key rawfetch2'),
		('Key_InsuranceHeader_DLN'		,'\) > 0\)\),Score_Batch'			,'HACK14d',') > 0\n OR LEFT.FNAME = RIGHT.FNAME))),/*HACK14d*/Score_Batch', 		'J0 and J1 wordbag hack2')
	]	
	
##---------------------------------------------------------------------------
##Key_InsuranceHeader_LFZ hacks
##Key hacks
##---------------------------------------------------------------------------
def dKeyInsuranceHeaderLFZ():
	return [
		('Key_InsuranceHeader_LFZ'		,'SHARED DataForKey := DataForKey0;'	,'HACK15','SHARED DataForKey := project(DataForKey0, transform(layout,	BOOLEAN emptyConcept :=  left.CITY = \'\' and 	left.PRIM_NAME = \'\';  \n\t // 10-19 => zipweight/3 or 20 and greater => zipweight/4 \n\t	self.ZIP_weight100 := IF (emptyConcept AND left.ZIP_weight100 >=1000 AND left.ZIP_weight100<2000,  \n\t				left.ZIP_weight100/3, IF (emptyConcept AND left.ZIP_weight100>=2000, left.ZIP_weight100/4, left.ZIP_weight100)); \n\t	self := left)); /*HACK15*/', 'LFZ_Key weights hacked')
	]


##---------------------------------------------------------------------------
##Mac_External_AddPcnt score to 29 in Meow_xIDL and Process_xIDL_Layouts
##Key hacks
##---------------------------------------------------------------------------
def dMacExternalAddPcnt():
	return [
		('Process_xIDL_Layouts'		,'SALT311\.MAC_External_AddPcnt\(R2,LayoutScoredFetch,Results,OutputLayout_Batch,30,R3\);','HACK16a','SALT311.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,29,R3);/*HACK16*/', 'Mac_External_AddPcnt score to 29 in Process_xIDL_Layouts'),
		('Meow_xIDL'				,'SALT311\.MAC_External_AddPcnt\(RR3,Process_xIDL_Layouts\(\)\.LayoutScoredFetch,Results,Process_xIDL_Layouts\(\)\.OutputLayout,30,RR4\);','HACK16b','SALT311.MAC_External_AddPcnt(RR3,Process_xIDL_Layouts().LayoutScoredFetch,Results,Process_xIDL_Layouts().OutputLayout,29,RR4);/*HACK16*/', 'Mac_External_AddPcnt score to 29 in Meow_xIDL')
	]

##---------------------------------------------------------------------------
##dMatchCodeLnameEditDist
##match_methods
##---------------------------------------------------------------------------
def dMatchCodeLnameEditDist():
	return [
		('match_methods'		,'(EXPORT match_LNAME)([^;]*)(Config\.WithinEditN\(L,LL,R,RL,1,0\))(=> SALT311\.MatchCode.EditDistanceMatch,)'	,'HACK17a','\g<1>\g<2>Config.WithinEditN(L,LL,R,RL,1,Config.LNAME_LENGTH_EDIT2, 0)\g<4> /*HACK17a*/', 'LNAME edit distance match_code')
	]

##---------------------------------------------------------------------------
##dMatchCodeFnameEditDist
##match_methods
##---------------------------------------------------------------------------
def dMatchCodeFnameEditDist():
	return [
		('match_methods'		,'(EXPORT match_FNAME)([^;]*)(Config\.WithinEditN\(L,LL,R,RL,1,0\))(=> SALT311\.MatchCode.EditDistanceMatch,)'	,'HACK17b','\g<1>\g<2>Config.WithinEditN(L,LL,R,RL,1,Config.FNAME_LENGTH_EDIT2, 0)\g<4> /*HACK17b*/', 'FNAME edit distance match_code')
	]

##---------------------------------------------------------------------------
##DOB not use force hack
##Key hacks
##---------------------------------------------------------------------------
def dDOBNotUseForce():
	return [
		('MAC_MEOW_xIDL_Batch', 	'In_disableForce = \'false\'','HACK18','In_disableForce = \'InsuranceHeader_xLink.Config.DOB_NotUseForce\' /*HACK18*/', 'DOB not use force'),
		('MAC_MEOW_xIDL_Online',	'In_disableForce = \'false\'','HACK18','In_disableForce = \'InsuranceHeader_xLink.Config.DOB_NotUseForce\' /*HACK18*/', 'DOB not use force'),
		('MEOW_xIDL_Service', 		'Input_disableForce := FALSE : STORED\(\'disableForce\', FORMAT\(SEQUENCE\([^;]*\)\)\);','HACK18','Input_disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce : STORED(\'disableForce\');/*HACK18*/', 'DOB not use force'),
		('Process_xIDL_Layouts',   	'disableForce := FALSE;','HACK18','disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce;/*HACK18*/', 'DOB not use force'),
		('xIDL_Header_Service', 	'Input_disableForce := FALSE : STORED\(\'disableForce\', FORMAT\(SEQUENCE\([^;]*\)\)\);','HACK18','Input_disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce : STORED(\'disableForce\');/*HACK18*/', 'DOB not use force')
	]

##---------------------------------------------------------------------------
##Webservice Declaration
##Services hacks
##---------------------------------------------------------------------------
def dWebService():
	return [
		('MEOW_xIDL_Service'		,'EXPORT MEOW_xIDL_Service := MACRO','HACK19','EXPORT MEOW_xIDL_Service := MACRO\n'
			+'  #WEBSERVICE(FIELDS(\n'
			+'	\'SNAME\', \'FNAME\', \'MNAME\', \'LNAME\', \'NAME\', \'DERIVED_GENDER\',\n'
			+'	\'ADDRESS1\', \'ADDRESS2\', \'PRIM_RANGE\', \'PRIM_NAME\', \'SEC_RANGE\', \'CITY\',\n'
			+'	\'ST\', \'ZIP\', \'ZIP_cases\', \'SSN\', \'DOB\', \'PHONE\', \'DL_STATE\', \'DL_NBR\', \'fname2\', \'lname2\', \'SRC\', \'SOURCE_RID\', \'RID\', \'VIN\',\n'
			+'	\'disableForce\',\'MaxIds\', \'LeadThreshold\', \'UniqueID\'\n'
			+'	),\n'
			+'	DESCRIPTION(\'SALT V3.11 <p/> Attempt to resolve or find DIDs. <p>The more data input the better\' + ' + 
				'\'</p><p>fields name, address1 and address2 are cleaned before using as input\' + ' +
				'\'</p><p>Debug option is always false, but if on it will show the outputs that follows the process to append a LexID\'));/*HACK19*/', 'Webservice declaration'),
		('xIDL_Header_Service'		,'EXPORT xIDL_Header_Service := MACRO','HACK19','/*--RESULT-- InsuranceHeader_xLink.Format_Header_Service */\n' 
			+ 'EXPORT xIDL_Header_Service := MACRO\n'
			+'  #WEBSERVICE(FIELDS(\n'
			+'	\'SNAME\', \'FNAME\', \'MNAME\', \'LNAME\', \'NAME\', \'DERIVED_GENDER\',\n'
			+'	\'ADDRESS1\', \'ADDRESS2\', \'PRIM_RANGE\', \'PRIM_NAME\', \'SEC_RANGE\', \'CITY\',\n'
			+'	\'ST\', \'ZIP\', \'SSN\', \'DOB\', \'PHONE\', \'DL_STATE\', \'DL_NBR\', \'fname2\', \'lname2\', \'RID\', \'VIN\', \'DID\', \'SortBy\',\n'
			+'	\'disableForce\', \'MatchAllInOneRecord\', \'RecordsOnly\', \'MaxIds\', \'LeadThreshold\', \'UniqueID\'\n'
			+'	),\n'
			+'	HELP(\'<p>NAME:full name to be cleaned (for ex: John A Smith)</p>\' +\n'
			+'	\'<p>DOB format: YYYYMMDD (for ex: 19710101)</p>\'+\n'
			+'	\'<p>ADDRESS1:first part of address to be cleaned (for ex: 123 Main Street)</p>\'+\n'
			+'	\'<p>ADDRESS2:second part of address to be cleaned (for ex: Miami, FL, 12345)</p>\'+\n'
			+'	\'<p>SortBy:RID|Source|FirstSeenDate|LastSeenDate|ADRIndicator|DLNIndicator|DOBIndicator|SSNIndicator|LastName|City</p>\' + \n'
			+'	\'<p>Minimum Requirements:<ul style="list-style-type:none">\'+\n'
			+'	\'<li>FNAME,LNAME,ST</li><li>PRIM_RANGE,PRIM_NAME,ZIP</li><li>SSN</li><li>SSN4,FNAME,LNAME</li>\'+ \n'
			+'	\'<li>DOB,LNAME</li><li>DOB,FNAME</li><li>ZIP,PRIM_RANGE</li><li>DL_NBR,DL_STATE</li><li>PHONE</li><li>LNAME,FNAME,ZIP</li>\'+\n'
			+'	\'<li>RID<br/><li>fname2:lname2</li><li>VIN</li></ul>\'),\n'
			+'	DESCRIPTION(\'<p>SALT V3.11</p>\' + \n'
			+'	\'<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>\'));/*FIELDS HACK*/	/*HACK19*/', 'Webservice declaration')
	]

##---------------------------------------------------------------------------
##Clean Address Name
##Services hacks
##---------------------------------------------------------------------------
def dCleanAddressName():
	return [
		('MEOW_xIDL_Service'		,'(UNSIGNED Input_UniqueID := 0)([^&]*?)(STORED\(\'RID\', FORMAT\(SEQUENCE\([^;]*\)\)\);)','HACK20','STRING Input_NAME := \'\' : STORED(\'NAME\'); /*HACK20*/ \n'
			+'	clean_n := address.CleanPersonFML73(Input_NAME);\n'
			+'	clean_n_parsed := Address.CleanNameFields(clean_n);\n'
			+'	nameLine := Input_name != \'\';\n'
			+'	STRING sSname := \'\' : STORED(\'SNAME\');\n'
			+'	SALT311.StrType Input_SNAME := IF(nameLine, clean_n_parsed.name_suffix, sSname);\n'
			+'	STRING sFname := \'\' : STORED(\'FNAME\');\n'
			+'	SALT311.StrType Input_FNAME := IF(nameLine, clean_n_parsed.fname, sFname);\n'
			+'	STRING sMname := \'\' : STORED(\'MNAME\');\n'
			+'	SALT311.StrType Input_MNAME := IF(nameLine, clean_n_parsed.mname, sMname);\n'
			+'	STRING sLname := \'\' : STORED(\'LNAME\');\n'
			+'	SALT311.StrType Input_LNAME := IF(nameLine, clean_n_parsed.lname, sLname); /*CLEAN NAME HACK*/\n'
			+'  SALT311.StrType Input_DERIVED_GENDER := \'\' : STORED(\'DERIVED_GENDER\');\n'
			+'  STRING addressLine1 := \'\' : STORED(\'ADDRESS1\');\n'
			+'	STRING addressLine2 := \'\' : STORED(\'ADDRESS2\');\n'
			+'	CleanedAddress		:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;\n'
			+'	addressLine 		:= addressLine1 != \'\' and addressLine2 != \'\';\n'
			+'	STRING sPrim_range := \'\' : STORED(\'PRIM_RANGE\');\n'
			+'	SALT311.StrType Input_PRIM_RANGE := IF(addressLine,  CleanedAddress.prim_range, sPrim_range);\n'
			+'	STRING sPrim_name :=  \'\' : STORED(\'PRIM_NAME\');\n'
			+'	SALT311.StrType Input_PRIM_NAME := IF(addressLine,  CleanedAddress.prim_name, sPrim_name);\n'
			+'	STRING sSec_range :=  \'\' : STORED(\'SEC_RANGE\');\n'
			+'	SALT311.StrType Input_SEC_RANGE := IF(addressLine,  CleanedAddress.sec_range, sSec_range);\n'
			+'	STRING sCity :=  \'\' : STORED(\'CITY\');\n'
			+'	SALT311.StrType Input_CITY := IF(addressLine,  CleanedAddress.v_city_name, sCity);\n'
			+'	STRING sSt :=  \'\' : STORED(\'ST\');\n'
			+'	SALT311.StrType Input_ST := IF(addressLine,  CleanedAddress.st, sSt);\n'
			+'	STRING sZip :=  \'\' : STORED(\'ZIP\');\n'
			+'	SALT311.StrType Input_ZIP := IF(addressLine,  CleanedAddress.zip, sZip); /*CLEAN ADDRESS HACK*/\n'
			+'	SALT311.StrType Input_SSN := \'\' : STORED(\'SSN\');\n'
			+'	INTEGER ssnInt := (INTEGER)Input_SSN;\n'
			+'	SALT311.StrType Input_SSN5 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN5, \'\');/* HACK SSN5 */\n'
			+' 	SALT311.StrType Input_SSN4 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN4, \'\'); /* HACK SSN4 */\n'
			+'	SALT311.StrType Input_DOB := \'\' : STORED(\'DOB\');\n'
			+'  SALT311.StrType Input_PHONE := \'\' : STORED(\'PHONE\');\n'
			+'  SALT311.StrType Input_DL_STATE := \'\' : STORED(\'DL_STATE\');\n'
			+'  SALT311.StrType Input_DL_NBR := \'\' : STORED(\'DL_NBR\');\n'
			+'  SALT311.StrType Input_SRC := \'\' : STORED(\'SRC\');\n'
			+'  SALT311.StrType Input_SOURCE_RID := \'\' : STORED(\'SOURCE_RID\');\n'
			+'  SALT311.StrType Input_DT_FIRST_SEEN := \'\' : STORED(\'DT_FIRST_SEEN\');\n'
			+'  SALT311.StrType Input_DT_LAST_SEEN := \'\' : STORED(\'DT_LAST_SEEN\');\n'
			+'  SALT311.StrType Input_DT_EFFECTIVE_FIRST := \'\' : STORED(\'DT_EFFECTIVE_FIRST\');\n'
			+'  SALT311.StrType Input_DT_EFFECTIVE_LAST := \'\' : STORED(\'DT_EFFECTIVE_LAST\');\n'
			+'  SALT311.StrType Input_MAINNAME := \'\' : STORED(\'MAINNAME\');\n'
			+'  SALT311.StrType Input_FULLNAME := \'\' : STORED(\'FULLNAME\');\n'
			+'  SALT311.StrType Input_ADDRESS := \'\' : STORED(\'ADDRESS\');\n'
			+'  SALT311.StrType Input_ADDR1 := \'\' : STORED(\'ADDR1\');\n'
			+'  SALT311.StrType Input_LOCALE := \'\' : STORED(\'LOCALE\');\n'
			+'  SALT311.StrType Input_fname2 := \'\' : STORED(\'fname2\');\n'
			+'  SALT311.StrType Input_lname2 := \'\' : STORED(\'lname2\');	\n'
			+'  SALT311.StrType Input_VIN := \'\' : STORED(\'VIN\');\n'
			+'  UNSIGNED Input_UniqueID := 0 : STORED(\'UniqueID\');\n'
			+'  UNSIGNED InputMaxIds0 := 0 : STORED(\'MaxIds\');\n'
			+'  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);\n'
			+'  UNSIGNED Input_LeadThreshold := 0 : STORED(\'LeadThreshold\');	\n'
			+'  UNSIGNED e_DID := 0 : STORED(\'DID\');\n'
			+'  UNSIGNED e_RID := 0 : STORED(\'RID\');', 'clean address and clean name hack'),
		('xIDL_Header_Service'		,'(UNSIGNED Input_UniqueID := 0)([^&]*?)(STORED\(\'RID\', FORMAT\(SEQUENCE\([^;]*\)\)\);)','HACK20', 'STRING Input_NAME := \'\' : STORED(\'NAME\'); /*HACK20*/ \n'
			+'	clean_n := address.CleanPersonFML73(Input_NAME);\n'
			+'	clean_n_parsed := Address.CleanNameFields(clean_n);\n'
			+'	nameLine := Input_name != \'\';\n'
			+'	STRING sSname := \'\' : STORED(\'SNAME\');\n'
			+'	SALT311.StrType Input_SNAME := IF(nameLine, clean_n_parsed.name_suffix, sSname);\n'
			+'	STRING sFname := \'\' : STORED(\'FNAME\');\n'
			+'	SALT311.StrType Input_FNAME := IF(nameLine, clean_n_parsed.fname, sFname);\n'
			+'	STRING sMname := \'\' : STORED(\'MNAME\');\n'
			+'	SALT311.StrType Input_MNAME := IF(nameLine, clean_n_parsed.mname, sMname);\n'
			+'	STRING sLname := \'\' : STORED(\'LNAME\');\n'
			+'	SALT311.StrType Input_LNAME := IF(nameLine, clean_n_parsed.lname, sLname); /*CLEAN NAME HACK*/\n'
			+'  SALT311.StrType Input_DERIVED_GENDER := \'\' : STORED(\'DERIVED_GENDER\');\n'
			+'  STRING addressLine1 := \'\' : STORED(\'ADDRESS1\');\n'
			+'	STRING addressLine2 := \'\' : STORED(\'ADDRESS2\');\n'
			+'	CleanedAddress		:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;\n'
			+'	addressLine 		:= addressLine1 != \'\' and addressLine2 != \'\';\n'
			+'	STRING sPrim_range := \'\' : STORED(\'PRIM_RANGE\');\n'
			+'	SALT311.StrType Input_PRIM_RANGE := IF(addressLine,  CleanedAddress.prim_range, sPrim_range);\n'
			+'	STRING sPrim_name :=  \'\' : STORED(\'PRIM_NAME\');\n'
			+'	SALT311.StrType Input_PRIM_NAME := IF(addressLine,  CleanedAddress.prim_name, sPrim_name);\n'
			+'	STRING sSec_range :=  \'\' : STORED(\'SEC_RANGE\');\n'
			+'	SALT311.StrType Input_SEC_RANGE := IF(addressLine,  CleanedAddress.sec_range, sSec_range);\n'
			+'	STRING sCity :=  \'\' : STORED(\'CITY\');\n'
			+'	SALT311.StrType Input_CITY := IF(addressLine,  CleanedAddress.v_city_name, sCity);\n'
			+'	STRING sSt :=  \'\' : STORED(\'ST\');\n'
			+'	SALT311.StrType Input_ST := IF(addressLine,  CleanedAddress.st, sSt);\n'
			+'	STRING sZip :=  \'\' : STORED(\'ZIP\');\n'
			+'	SALT311.StrType Input_ZIP := IF(addressLine,  CleanedAddress.zip, sZip); /*CLEAN ADDRESS HACK*/\n'
			+'	DATASET(InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases) Input_ZIP_cases := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases)  : STORED(\'ZIP_cases\');\n'
			+'	zip_casesDs := IF(Input_Zip<>\'\', DATASET([{Input_ZIP, 100}],InsuranceHeader_xLink.process_xIDL_layouts().layout_ZIP_cases), Input_ZIP_cases);\n'
			+'	SALT311.StrType Input_SSN := \'\' : STORED(\'SSN\');\n'
			+'	INTEGER ssnInt := (INTEGER)Input_SSN;\n'
			+'	SALT311.StrType Input_SSN5 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN5, \'\');/* HACK SSN5 */\n'
			+'  SALT311.StrType Input_SSN4 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN4, \'\'); /* HACK SSN4 */\n'
			+'	SALT311.StrType Input_DOB := \'\' : STORED(\'DOB\');\n'
			+'  SALT311.StrType Input_PHONE := \'\' : STORED(\'PHONE\');\n'
			+'  SALT311.StrType Input_DL_STATE := \'\' : STORED(\'DL_STATE\');\n'
			+'  SALT311.StrType Input_DL_NBR := \'\' : STORED(\'DL_NBR\');\n'
			+'  SALT311.StrType Input_SRC := \'\' : STORED(\'SRC\');\n'
			+'  SALT311.StrType Input_SOURCE_RID := \'\' : STORED(\'SOURCE_RID\');\n'
			+'  UNSIGNED e_RID := 0 : STORED(\'RID\');\n'
			+'  SALT311.StrType Input_DT_FIRST_SEEN := \'\' : STORED(\'DT_FIRST_SEEN\');\n'
			+'  SALT311.StrType Input_DT_LAST_SEEN := \'\' : STORED(\'DT_LAST_SEEN\');\n'
			+'  SALT311.StrType Input_DT_EFFECTIVE_FIRST := \'\' : STORED(\'DT_EFFECTIVE_FIRST\');\n'
			+'  SALT311.StrType Input_DT_EFFECTIVE_LAST := \'\' : STORED(\'DT_EFFECTIVE_LAST\');\n'
			+'  SALT311.StrType Input_MAINNAME := \'\' : STORED(\'MAINNAME\');\n'
			+'  SALT311.StrType Input_FULLNAME := \'\' : STORED(\'FULLNAME\');\n'
			+'  SALT311.StrType Input_ADDRESS := \'\' : STORED(\'ADDRESS\');\n'
			+'  SALT311.StrType Input_ADDR1 := \'\' : STORED(\'ADDR1\');\n'
			+'  SALT311.StrType Input_LOCALE := \'\' : STORED(\'LOCALE\');\n'
			+'  SALT311.StrType Input_fname2 := \'\' : STORED(\'fname2\');\n'
			+'  SALT311.StrType Input_lname2 := \'\' : STORED(\'lname2\');	\n'
			+'  SALT311.StrType Input_VIN := \'\' : STORED(\'VIN\');\n'
			+'  UNSIGNED Input_UniqueID := 0 : STORED(\'UniqueID\');\n'
			+'  UNSIGNED InputMaxIds0 := 0 : STORED(\'MaxIds\');\n'
			+'  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);\n'
			+'  UNSIGNED Input_LeadThreshold := 0 : STORED(\'LeadThreshold\');	\n'
			+'  UNSIGNED e_DID := 0 : STORED(\'DID\');\n'
			+'  BOOLEAN FullMatch := FALSE : STORED(\'MatchAllInOneRecord\');\n'
			+'  BOOLEAN RecordsOnly := FALSE: STORED(\'RecordsOnly\');\n'
			+'  SALT311.StrType Input_SortBy := \'\' : STORED(\'SortBy\');', 'clean address and clean name hack'), 
		('MEOW_xIDL_Service', ',Input_ZIP', 'HACK26', ',zip_casesDs /*HACK26*/', 'zip dataset'),
		('xIDL_Header_Service', ',Input_ZIP', 'HACK27', ',DATASET([{Input_ZIP, 100}],InsuranceHeader_xLink.process_xIDL_layouts().layout_ZIP_cases) /*HACK27*/', 'zip dataset')
	]

##---------------------------------------------------------------------------
##ToUpperCase added to the code 
##Service HACK 
##---------------------------------------------------------------------------
def dToUpperCase():
	return [
		('MEOW_xIDL_Service', '(Template :=)(.*?;)','HACK21a','\g<1>\g<2>\n	ToUpperCase(STRING aString) := STD.Str.ToUpperCase(aString); /*HACK21a*/', 'ToUpperCase added to the code'),
		('xIDL_Header_Service', '(Template :=)(.*?;)','HACK21a','\g<1>\g<2>\n	ToUpperCase(STRING aString) := STD.Str.ToUpperCase(aString); /*HACK21a*/', 'ToUpperCase added to the code')
	]

##---------------------------------------------------------------------------
##ToUpperCase added to the code 
##Service HACK 
##---------------------------------------------------------------------------
def dAddUpperCase1():
	return [
		('MEOW_xIDL_Service', '(  ,\(TYPEOF\(Template\.)(SNAME|FNAME|MNAME|LNAME|DERIVED_GENDER|PRIM_RANGE|PRIM_NAME|SEC_RANGE|CITY|ST|DL_STATE|DL_NBR)(\)\))(.*?)(\(\(SALT311\.StrType\))(.*?\))','HACK21b','\g<1>\g<2>\g<3>\g<4>(ToUpperCase\g<5>\g<6>) /*HACK21b*/', 'ToUpperCase added to the code'),
		('xIDL_Header_Service', '(  ,\(TYPEOF\(Template\.)(SNAME|FNAME|MNAME|LNAME|DERIVED_GENDER|PRIM_RANGE|PRIM_NAME|SEC_RANGE|CITY|ST|DL_STATE|DL_NBR)(\)\))(.*?)(\(\(SALT311\.StrType\))(.*?\))','HACK21b','\g<1>\g<2>\g<3>\g<4>(ToUpperCase\g<5>\g<6>) /*HACK21b*/', 'ToUpperCase added to the code')
	]

##---------------------------------------------------------------------------
##ToUpperCase added to the code 
##Service HACK 
##---------------------------------------------------------------------------
def dAddUpperCase2():
	return [
		('MEOW_xIDL_Service', '(  ,\(TYPEOF\(Template\.)(fname2|lname2)(\)\))(Input_fname2|Input_lname2)','HACK21c','\g<1>\g<2>\g<3>ToUpperCase(\g<4>)/*HACK21c*/', 'ToUpperCase added to the code'),
		('xIDL_Header_Service', '(  ,\(TYPEOF\(Template\.)(fname2|lname2)(\)\))(Input_fname2|Input_lname2)','HACK21c','\g<1>\g<2>\g<3>ToUpperCase(\g<4>)/*HACK21c*/', 'ToUpperCase added to the code')
	]
	
##---------------------------------------------------------------------------
##Process_xIDL_Layouts
##Process_xIDL_Layouts change
##---------------------------------------------------------------------------
def dProcessXidlLayouts():
	return [
    	('Process_xIDL_Layouts','IMPORT SALT311,STD;','PHACK01','IMPORT SALT311,STD,IDL_Header; /*PHACK01*/', 'Import Hack'),
		('Process_xIDL_Layouts','SHARED h := File_InsuranceHeader;//The input file','PHACK02','SHARED h := File_InsuranceHeader;//The input file\n'
			+'SHARED h0 := PROJECT(h,TRANSFORM(recordof(left),\n\t' 
			+'isUt := IDL_Header.SourceTools.SourceIsUtility(LEFT.src);\n\t'
			+'isWP := IDL_Header.SourceTools.SourceIsPublicHeader(LEFT.src) AND LEFT.src[4..] = MDR.SourceTools.src_Targus_White_pages;\n\t'
			+'SELF.ssn:=IF(isUt,\'\',LEFT.ssn);\n\t' 
			+'SELF.ssn_ind:=IF(isUt,\'\',LEFT.ssn_ind);\n\t' 
			+'SELF.phone:=IF(isWP,\'\',LEFT.phone);\n\t'
			+'SELF.phone_ind:=IF(isWP,\'\',LEFT.phone_ind);\n\t'
			+'SELF:=LEFT));//The input file /*PHACK02*/','Suppressing UT SSN and WP phones'),
		('Process_xIDL_Layouts','EXPORT Key := INDEX\(h,\{DID\},\{h\},KeyName_sf\);','PHACK03','EXPORT Key := INDEX(h0,{DID},{h0},KeyName_sf); /*PHACK03*/', 'Key Definition Hack'),
		('Process_xIDL_Layouts','SELF\.Weight := IF\(Weight\>0,Weight,MAX\(0,le\.Weight\)\);','PHACK04','SELF.Weight := Weight; /*PHACK04*/', 'weight adjustment for too many matches - Salt issue 2355'),
		('Process_xIDL_Layouts', 'SALT311\.UIDType DID;', 'PHACK05', 'TYPEOF(h.did) DID; /*PHACK05*/', 'change DID datatype'),
		##('Process_xIDL_Layouts', 'J0 := JOIN\( d,k,\(LEFT\.DID = RIGHT\.DID\),tr\(LEFT,RIGHT\), LEFT OUTER, KEEP\(10000\), LIMIT\(Config\.JoinLimit\)\);', 'PHACK06','J0 := JOIN( d,k,(LEFT.DID = RIGHT.DID),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));/*PHACK06*/', 'Config.JoinLimit changed to 0'),
		('Process_xIDL_Layouts', '(EXPORT KeyIDHistoryName_sf )(.*?;)', 'PHACK07','EXPORT KeyIDHistoryName_sf := KeyNames().id_history_super; /*PHACK07*/', 'KeyID history name'),
		('Process_xIDL_Layouts', '(EXPORT Key0Name_sf [:][=])(.*?;)', 'PHACK08','EXPORT Key0Name_sf := KeyNames().header0_super; /*PHACK08*/', 'Key0Name'),	
		('Process_xIDL_Layouts', '(EXPORT Key1Name_sf [:][=])(.*?;)', 'PHACK08b','EXPORT Key1Name_sf := KeyNames().header1_super; /*PHACK08b*/', 'Key1Name'),
		('Process_xIDL_Layouts', '(SHARED sIDHist)(.*?;)', 'PHACK09','\g<1>Inc\g<2>\n'
			+'SHARED sIDHistFull := InsuranceHeader_xLink.IdHistoryFull(h);\n'
			+'SHARED sIDHist := IF(incremental, sIDHistInc, sIDHistFull);/*PHACK09*/ \n', 'Id history'),
		('Process_xIDL_Layouts', '(SELF\.modifyDate :=)(.*?;)', 'PHACK10','//\g<1>\g<2>\n'
			+'SELF.modifyDate   := (UNSIGNED4)L.name[STD.Str.Find(L.name,\'_xlink\',1) + 8..IF(STD.Str.Find(L.name,\'did\',1)> 0 , STD.Str.Find(L.name,\'did\',1), STD.Str.Find(L.name,\'idl\',1)) -3]; /*PHACK10*/\n', 'Modify date'),
		('Process_xIDL_Layouts', 'SALT311\.UIDType RID', 'PHACK11','TYPEOF(h.rid)  RID/*PHACK11*/', 'change DID datatype'),
		('Process_xIDL_Layouts', '(JEntKeyed0|JRecKeyed_20|JEntPull0|JRecPull_20)( :=)(.*?)(\);)', 'PHACK12','\g<1>\g<2>\g<3>, KEEP(10000), LIMIT(0));/*PHACK12*/', 'add keep(10000) and limit(0)'),
		##('Process_xIDL_Layouts', 'BOOLEAN MAINNAMEWeightForcedDown :=[^\n]*', 'PHACK13', 'BOOLEAN MAINNAMEWeightForcedDown := false; /*PHACK13*/', 'set mainname weight force false per github issue 3594'),
		##('Process_xIDL_Layouts', 'BOOLEAN FULLNAMEWeightForcedDown :=[^\n]*', 'PHACK14', 'BOOLEAN FULLNAMEWeightForcedDown := false; /*PHACK14*/', 'set fullname weight force false per github issue 3594'),
		##('Process_xIDL_Layouts', 'BOOLEAN ADDR1WeightForcedDown :=[^\n]*',    'PHACK15', 'BOOLEAN ADDR1WeightForcedDown := false; /*PHACK15*/',    'set addr1 weight force false per github issue 3594'),
		##('Process_xIDL_Layouts', 'BOOLEAN LOCALEWeightForcedDown :=[^\n]*',   'PHACK16', 'BOOLEAN LOCALEWeightForcedDown := false; /*PHACK16*/',   'set locale weight force false per github issue 3594')		
		('Process_xIDL_Layouts', 'R2 := ROLLUP\( TOPN\(r1', 'PHACK17', 'R12 := InsuranceHeader_xlink.patch_specificities(r1); /*PHACK17*/\n\tR2 := ROLLUP( TOPN(R12', 'Add patch_specificities call'),
		('Process_xIDL_Layouts', '~incremental', 'PHACK18', 'incremental /*PHACK18*/', 'Add patch_specificities call')
 	]

##---------------------------------------------------------------------------
## Process_xIDL_Layouts
## SALT git issue - 6046 Inconsistent concept weights for the same match amongs candidates
## SPC change: HACK:ADJUST_CONCEPT_WEIGHT:WITH_SORT_ON_WEIGHT starting form SALT 4.3.0
## HACK:SALTMODULE:SALT311
##---------------------------------------------------------------------------


def dConceptForceDown() :
		return[
		('Process_xIDL_Layouts', '(BOOLEAN DirectMAINNAMEWeightForcedDown := )(.*?;)', 'HACK41a', '\g<1>\g<2> \n\tBOOLEAN MAINNAMEWeightForcedDown := FNAMEWeightForcedDown OR MNAMEWeightForcedDown OR LNAMEWeightForcedDown; /*HACK41a*/', 'mainname hack'),
		('Process_xIDL_Layouts', '(SELF.MAINNAMEWeight :=)([^)]*) \),(.*?ri.MAINNAMEWeight \),)', 'HACK41b', '\g<1>\g<2> ),\g<3>\n\t\tMAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) => MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight),/*HACK41b*/', 'mainame hack'),
		('Process_xIDL_Layouts', '(SELF.MAINNAME_match_code :=)([^)]*) \),(.*?ri.MAINNAME_match_code \),)', 'HACK41c', '\g<1>\g<2> ),\g<3>\n\t\tMAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) AND MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight)=le.MAINNAMEWeight => le.MAINNAME_match_code,\n\t\t' 
			+'MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) AND MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight)=ri.MAINNAMEWeight => ri.MAINNAME_match_code, /*HACK41c*/', 'mainame hack'),
		
		('Process_xIDL_Layouts', '(BOOLEAN DirectFULLNAMEWeightForcedDown := )(.*?;)', 'HACK42a', '\g<1>\g<2> \n\tBOOLEAN FULLNAMEWeightForcedDown := MAINNAMEWeightForcedDown OR SNAMEWeightForcedDown; /*HACK42a*/', 'mainname hack'),
		('Process_xIDL_Layouts', '(SELF.FULLNAMEWeight :=)([^)]*) \),(.*?ri.FULLNAMEWeight \),)', 'HACK42b', '\g<1>\g<2> ),\g<3>\n\t\tFULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) => MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight),/*HACK42b*/', 'mainame hack'),
		('Process_xIDL_Layouts', '(SELF.FULLNAME_match_code :=)([^)]*) \),(.*?ri.FULLNAME_match_code \),)', 'HACK42c', '\g<1>\g<2> ),\g<3>\n\t\tFULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) AND MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight)=le.FULLNAMEWeight => le.FULLNAME_match_code,\n\t\t' 
			+'FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) AND MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight)=ri.FULLNAMEWeight => ri.FULLNAME_match_code, /*HACK42c*/', 'mainame hack'),
			
		('Process_xIDL_Layouts', '(BOOLEAN DirectADDR1WeightForcedDown := )(.*?;)', 'HACK43a', '\g<1>\g<2> \n\tBOOLEAN ADDR1WeightForcedDown := PRIM_RANGEWeightForcedDown OR SEC_RANGEWeightForcedDown OR PRIM_NAMEWeightForcedDown; /*HACK43a*/', 'mainname hack'),
		('Process_xIDL_Layouts', '(SELF.ADDR1Weight :=)([^)]*) \),(.*?ri.ADDR1Weight \),)', 'HACK43b', '\g<1>\g<2> ),\g<3>\n\t\tADDR1WeightForcedDown AND (le.ADDR1_match_code = ri.ADDR1_match_code) => MIN(le.ADDR1Weight, ri.ADDR1Weight),/*HACK43b*/', 'mainame hack'),
		('Process_xIDL_Layouts', '(SELF.ADDR1_match_code :=)([^)]*) \),(.*?ri.ADDR1_match_code \),)', 'HACK43c', '\g<1>\g<2> ),\g<3>\n\t\tADDR1WeightForcedDown AND (le.ADDR1_match_code = ri.ADDR1_match_code) AND MIN(le.ADDR1Weight, ri.ADDR1Weight)=le.ADDR1Weight => le.ADDR1_match_code,\n\t\t'
			+'ADDR1WeightForcedDown AND (le.ADDR1_match_code = ri.ADDR1_match_code) AND MIN(le.ADDR1Weight, ri.ADDR1Weight)=ri.ADDR1Weight => ri.ADDR1_match_code, /*HACK43c*/', 'mainame hack'),
			
		('Process_xIDL_Layouts', '(BOOLEAN DirectLOCALEWeightForcedDown := )(.*?;)', 'HACK44a', '\g<1>\g<2> \n\tBOOLEAN LOCALEWeightForcedDown := CITYWeightForcedDown OR STWeightForcedDown; /*HACK44a*/', 'mainname hack'),
		('Process_xIDL_Layouts', '(SELF.LOCALEWeight :=)([^)]*) \),(.*?ri.LOCALEWeight \),)', 'HACK44b', '\g<1>\g<2> ),\g<3>\n\t\tLOCALEWeightForcedDown AND (le.LOCALE_match_code = ri.LOCALE_match_code) => MIN(le.LOCALEWeight, ri.LOCALEWeight),/*HACK44b*/', 'mainame hack'),
		('Process_xIDL_Layouts', '(SELF.LOCALE_match_code :=)([^)]*) \),(.*?ri.LOCALE_match_code \),)', 'HACK44c', '\g<1>\g<2> ),\g<3>\n\t\tLOCALEWeightForcedDown AND (le.LOCALE_match_code = ri.LOCALE_match_code) AND MIN(le.LOCALEWeight, ri.LOCALEWeight)=le.LOCALEWeight => le.LOCALE_match_code,\n\t\t'
			+'LOCALEWeightForcedDown AND (le.LOCALE_match_code = ri.LOCALE_match_code) AND MIN(le.LOCALEWeight, ri.LOCALEWeight)=ri.LOCALEWeight => ri.LOCALE_match_code, /*HACK44c*/', 'mainame hack'),
			
		('Process_xIDL_Layouts', '(BOOLEAN DirectADDRESSWeightForcedDown := )(.*?;)', 'HACK45a', '\g<1>\g<2> \n\tBOOLEAN ADDRESSWeightForcedDown := ADDR1WeightForcedDown OR LOCALEWeightForcedDown; /*HACK45a*/', 'mainname hack'),
		('Process_xIDL_Layouts', '(SELF.ADDRESSWeight :=)([^)]*) \),(.*?ri.ADDRESSWeight \),)', 'HACK45b', '\g<1>\g<2> ),\g<3>\n\t\tADDRESSWeightForcedDown AND (le.ADDRESS_match_code = ri.ADDRESS_match_code) => MIN(le.ADDRESSWeight, ri.ADDRESSWeight),/*HACK45b*/', 'mainame hack'),
		('Process_xIDL_Layouts', '(SELF.ADDRESS_match_code :=)([^)]*) \),(.*?ri.ADDRESS_match_code \),)', 'HACK45c', '\g<1>\g<2> ),\g<3>\n\t\tADDRESSWeightForcedDown AND (le.ADDRESS_match_code = ri.ADDRESS_match_code) AND MIN(le.ADDRESSWeight, ri.ADDRESSWeight)=le.ADDRESSWeight => le.ADDRESS_match_code,\n\t\t'
			+'ADDRESSWeightForcedDown AND (le.ADDRESS_match_code = ri.ADDRESS_match_code) AND MIN(le.ADDRESSWeight, ri.ADDRESSWeight)=ri.ADDRESSWeight => ri.ADDRESS_match_code, /*HACK45c*/', 'mainame hack'),
		]
##---------------------------------------------------------------------------
##MAC_MEOW_xIDL_Batch 
##HACK 
##---------------------------------------------------------------------------
def dMacMeowXidlBatch():
	return [    	
		('MAC_MEOW_xIDL_Batch',',Input_DT_FIRST_SEEN = \'\',Input_DT_LAST_SEEN = \'\',Input_DT_EFFECTIVE_FIRST = \'\',Input_DT_EFFECTIVE_LAST = \'\',Input_MAINNAME = \'\',Input_FULLNAME = \'\',Input_ADDR1 = \'\',Input_LOCALE = \'\',Input_ADDRESS = \'\'','MMXBHACK01','/*MMXBHACK01*/','Remove Concepts'),
		('MAC_MEOW_xIDL_Batch','#IF \( #TEXT\(Input_MAINNAME\) <> \'\' \)\n    SELF.MAINNAME := \(TYPEOF\(SELF.MAINNAME\)\)le.Input_MAINNAME;\n  #ELSE\n    SELF.MAINNAME := \(TYPEOF\(SELF.MAINNAME\)\)\'\';\n  #END','MMXBHACK02a','SELF.MAINNAME :=   \'\';/*MMXBHACK02a*/','Remove Concepts'),
		('MAC_MEOW_xIDL_Batch','#IF \( #TEXT\(Input_FULLNAME\) <> \'\' \)\n    SELF.FULLNAME := \(TYPEOF\(SELF.FULLNAME\)\)le.Input_FULLNAME;\n  #ELSE\n    SELF.FULLNAME := \(TYPEOF\(SELF.FULLNAME\)\)\'\';\n  #END','MMXBHACK02b','SELF.FULLNAME :=   \'\';/*MMXBHACK02b*/','Remove Concepts'),
		('MAC_MEOW_xIDL_Batch','#IF \( #TEXT\(Input_ADDR1\) <> \'\' \)\n    SELF.ADDR1 := \(TYPEOF\(SELF.ADDR1\)\)le.Input_ADDR1;\n  #ELSE\n    SELF.ADDR1 := \(TYPEOF\(SELF.ADDR1\)\)\'\';\n  #END','MMXBHACK02c','SELF.ADDR1 :=   \'\';/*MMXBHACK02c*/','Remove Concepts'),
		('MAC_MEOW_xIDL_Batch','#IF \( #TEXT\(Input_LOCALE\) <> \'\' \)\n    SELF.LOCALE := \(TYPEOF\(SELF.LOCALE\)\)le.Input_LOCALE;\n  #ELSE\n    SELF.LOCALE := \(TYPEOF\(SELF.LOCALE\)\)\'\';\n  #END','MMXBHACK02d','SELF.LOCALE :=   \'\';/*MMXBHACK02d*/','Remove Concepts'),
		('MAC_MEOW_xIDL_Batch','#IF \( #TEXT\(Input_ADDRESS\) <> \'\' \)\n    SELF.ADDRESS := \(TYPEOF\(SELF.ADDRESS\)\)le.Input_ADDRESS;\n  #ELSE\n    SELF.ADDRESS := \(TYPEOF\(SELF.ADDRESS\)\)\'\';\n  #END','MMXBHACK02e','SELF.ADDRESS :=   \'\';/*MMXBHACK02e*/','Remove Concepts'),
		##('MAC_MEOW_xIDL_Batch', 'UpdateIDs=','MMXBHACK03','/*MMXBHACK03*/ input_UpdateIDs=', 'updateids changed to input_updateids'),
		('MAC_MEOW_xIDL_Batch', '(#IF \( #TEXT\(Input_DT_FIRST_SEEN\) <> \'\' \))([^&]*?)(  #END)','MMXBHACK04a','SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))\'\'; /*MMXBHACK04a*/', 'remove concept Input_DT_FIRST_SEEN'),
		('MAC_MEOW_xIDL_Batch', '(#IF \( #TEXT\(Input_DT_LAST_SEEN\) <> \'\' \))([^&]*?)(  #END)','MMXBHACK04b','SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))\'\'; /*MMXBHACK04b*/', 'remove concept Input_DT_LAST_SEEN'),
		('MAC_MEOW_xIDL_Batch', '(#IF \( #TEXT\(Input_DT_EFFECTIVE_FIRST\) <> \'\' \))([^&]*?)(  #END)','MMXBHACK04c','SELF.DT_EFFECTIVE_FIRST := (TYPEOF(SELF.DT_EFFECTIVE_FIRST))\'\'; /*MMXBHACK04c*/', 'remove concept Input_DT_EFFECTIVE_FIRST'),
		('MAC_MEOW_xIDL_Batch', '(#IF \( #TEXT\(Input_DT_EFFECTIVE_LAST\) <> \'\' \))([^&]*?)(  #END)','MMXBHACK04d','SELF.DT_EFFECTIVE_LAST := (TYPEOF(SELF.DT_EFFECTIVE_LAST))\'\'; /*MMXBHACK04d*/', 'remove concept Input_DT_EFFECTIVE_LAST'),
		('MAC_MEOW_xIDL_Batch', '#IF \( #TEXT\(Input_DL_STATE\) <> \'\' \)','MMXBHACK05','#IF ( #TEXT(Input_DL_STATE) <> \'\' and #TEXT(Input_DL_NBR) <> \'\' ) /*MMXBHACK05*/', 'extra DL_NBR check to set DL_STATE')
		]
	
##---------------------------------------------------------------------------
##Specificities 
##Hacks
##---------------------------------------------------------------------------
def dSpecificities():
    return [
		('Specificities','EXPORT ([^\n]+)ValuesIndexKeyName :=[^\n]*', 		'SPECHACK01', 'EXPORT \g<1>ValuesIndexKeyName := KeyNames().\g<1>_spc_logical;/*SPECHACK01*/', 'logical index name hack'),
		('Specificities','EXPORT ([^\n]+)ValuesIndexKeyName_sf :=[^\n]*', 	'SPECHACK02', 'EXPORT \g<1>ValuesIndexKeyName_sf := KeyNames().\g<1>_spc_super;/*SPECHACK02*/', 'superfile index name hack'),
		# ('Specificities','(EXPORT [^\n]+_values_index :=[^\n]+[}],[^\n]+ValuesIndexKeyName)','SPECHACK03', '\g<1>_sf/*SPECHACK03*/', 'index references superfile hack'),
		# ('Specificities','BUILDINDEX\(([^\n,]+)_values_index, OVERWRITE\)',	'SPECHACK04','BUILDINDEX(\g<1>_values_index, \g<1>ValuesIndexKeyName, OVERWRITE)/*SPECHACK04*/','index build use logical name hack'),
		('Specificities','EXPORT SpecIndexKeyName :=[^\n]+',					'SPECHACK05','EXPORT SpecIndexKeyName := KeyNames().main_spc_logical;/*SPECHACK05*/','logical spec index name hack'),
		('Specificities','EXPORT SpecIndexKeyName_sf :=[^\n]+',				'SPECHACK06','EXPORT SpecIndexKeyName_sf := KeyNames().main_spc_super;/*SPECHACK06*/','superfile spec index name hack'),
		# ('Specificities','(EXPORT Specificities_Index :=[^\n]+\},SpecIndexKeyName)','SPECHACK07','\g<1>_sf/*SPECHACK07*/','specificities index reference superfile hack'),
		('Specificities','EXPORT Build :=[^\n]+',								'SPECHACK08','EXPORT Build := SEQUENTIAL(BuildAll,\n' 
			+'createUpdateSuperFile().updateFieldSpecificitiesSuperFiles,\n'
			+'createUpdateSuperFile().updateAttrSpecificitiesSuperFiles,\n' 
			+'BUILDINDEX(Specificities_Index, SpecIndexKeyName, OVERWRITE, FEW),\n'
			+'createUpdateSuperFile().updateMainSpecificitiesSuperFiles);/*SPECHACK08*/','modify build sequence hack')
	]
	
##---------------------------------------------------------------------------
##xIDL_Header_Service - Update 
##MatchHistory change
##---------------------------------------------------------------------------
def dXidlHeaderService():
	return [
		('xIDL_Header_Service', 'ds := pm\.Data_;', 'XIDLHACK01','ds1 := pm.Data_; \n'
			+'	outputLayout := RECORDOF(ds1);\n'
			+'	outputNewLayout := RECORD\n'
			+'		InsuranceHeader_xLink.Process_xIDL_Layouts().id_stream_layout;\n'
			+'		STRING Segmentation;\n'
			+'		STRING KeysUsedDesc;\n'
			+'		STRING KeysFailedDesc;\n'
			+'		outputLayout -InsuranceHeader_xLink.Process_xIDL_Layouts().id_stream_layout;\n'
			+'	END;\n'
			+'	segKey := InsuranceHeader_PostProcess.segmentation_keys.key_did;\n'
			+'	newOutputRes := project(ds1, \n'
			+'			TRANSFORM(outputNewLayout, \n'
			+'			self.KeysUsedDesc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.KeysUsed);\n'
			+'			self.KeysFailedDesc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.KeysFailed);\n'
			+'			self.Segmentation := segKey(DID=left.did)[1].ind;\n'
			+'			self := LEFT));	\n'
			+'  ds := IDLExternalLinking.xIDL_getDeltaBestRecs(newOutputRes, rid);/*XIDLHACK01*/', 'additional code for segmentation, keys used and update best indicators'),
		('xIDL_Header_Service', '(FieldNumber\(SALT311\.StrType fn\) := CASE\(fn)(.*?;)','XIDLHACK02','FieldNumber(SALT311.StrType fn) := CASE(fn,\'SNAME\' => 1,\'FNAME\' => 2,\'MNAME\' => 3,\'LNAME\' => 4,\'DERIVED_GENDER\' => 5,\'PRIM_RANGE\' => 6,\'PRIM_NAME\' => 7,\'SEC_RANGE\' => 8,\'CITY\' => 9,\'ST\' => 10,\'ZIP\' => 11,\'SSN5\' => 12,\'SSN4\' => 13,\'DOB\' => 14,\'PHONE\' => 15,\'DL_STATE\' => 16,\'DL_NBR\' => 17,\'SRC\' => 18, \'Source\' =>18, \'SOURCE_RID\' => 19,\n'
			+'                /*Begin XIDLHACK02*/\n'
			+'                \'DT_FIRST_SEEN\' => 20, \'FirstSeenDate\' => 20,\n'
			+'                \'DT_LAST_SEEN\' => 21, \'LastSeenDate\' => 21, \n'     
			+'                \'DT_EFFECTIVE_FIRST\' => 22,\'DT_EFFECTIVE_LAST\' => 23, \n'
			+'                \'SSN_IND\' => 24, \'SSNIndicator\' => 24,\n'
			+'                \'DLNO_IND\' => 25, \'DLNIndicator\' => 25, \n'
			+'                \'DOB_IND\' => 26, \'DOBIndicator\' => 26, \n'
			+'                \'ADDR_IND\' => 27, \'ADRIndicator\' => 27,\n'
			+'                \'RID\'=>28, 31); /*End XIDLHACK02*/', 'adding parameters'),
		('xIDL_Header_Service', '(result := CHOOSE\(FieldNumber\(Input_SortBy\))(.*?;)','XIDLHACK03','result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,DID,SNAME,RECORD),SORT(ds,-weight,DID,FNAME,RECORD),SORT(ds,-weight,DID,MNAME,RECORD),SORT(ds,-weight,DID,LNAME,RECORD),SORT(ds,-weight,DID,DERIVED_GENDER,RECORD),SORT(ds,-weight,DID,PRIM_RANGE,RECORD),SORT(ds,-weight,DID,PRIM_NAME,RECORD),SORT(ds,-weight,DID,SEC_RANGE,RECORD),SORT(ds,-weight,DID,CITY,RECORD),SORT(ds,-weight,DID,ST,RECORD),SORT(ds,-weight,DID,ZIP,RECORD),SORT(ds,-weight,DID,SSN5,RECORD),SORT(ds,-weight,DID,SSN4,RECORD),SORT(ds,-weight,DID,DOB,RECORD),SORT(ds,-weight,DID,PHONE,RECORD),SORT(ds,-weight,DID,DL_STATE,RECORD),SORT(ds,-weight,DID,DL_NBR,RECORD),SORT(ds,-weight,DID,SRC,RECORD),SORT(ds,-weight,DID,SOURCE_RID,RECORD),SORT(ds,-weight,DID,DT_FIRST_SEEN,RECORD),SORT(ds,-weight,DID,DT_LAST_SEEN,RECORD),SORT(ds,-weight,DID,DT_EFFECTIVE_FIRST,RECORD),SORT(ds,-weight,DID,DT_EFFECTIVE_LAST,RECORD),SORT(ds,-weight,DID,SSN_IND,RECORD),SORT(ds,-weight,DID,(UNSIGNED)DLNO_IND,RECORD),SORT(ds,-weight,DID,DOB_IND,RECORD),SORT(ds,-weight,DID,(UNSIGNED)ADDR_IND,RECORD), SORT(ds,-weight,DID,RID,RECORD), SORT(ds,-weight,DID,RECORD));\n'
			+'	recCount := {integer Total_Records}; \n'
			+' output(DATASET([{count(result)}], recCount),named(\'RecordCount\')); /*XIDLHACK03*/ \n', 'adding parameters'),
		('xIDL_Header_Service', 'OUTPUT\(pm\.Data_0,NAMED\(\'Attribute0\'\)\);','XIDLHACK04a','OUTPUT(pm.Data_0,NAMED(\'Relatives\'));/*XIDLHACK04a*/', 'comment the code'),
		('xIDL_Header_Service', 'OUTPUT\(pm\.Data_1,NAMED\(\'Attribute1\'\)\);','XIDLHACK04b','OUTPUT(pm.Data_1,NAMED(\'VIN\'));/*XIDLHACK04b*/', 'comment the code')		
	]

##---------------------------------------------------------------------------
##MEOW_xIDL_Service - Update 
##Result formatted code change
##---------------------------------------------------------------------------
def dformattedResult():
	return [
		('MEOW_xIDL_Service', 'OUTPUT\(pm\.Raw_Results,NAMED\(\'Results\'\)\);', 'MXIDLHACK01','outputResults := pm.Raw_Results;\n'
			+'	OUTPUT(outputResults,NAMED(\'Results\'));\n'
			+'	// add segmentation and keys_used description\n'
			+'	segKey := InsuranceHeader_PostProcess.segmentation_keys.key_did;\n'
			+'	LayoutScoredFetch := RECORD\n'
			+'		InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch.did;\n'
			+'		STRING10 Segmentation;\n'
			+'		InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch-did;\n'
			+'		STRING keys_used_desc;\n'
			+'	END;\n'
			+'	OutputLayout_Base := RECORD,MAXLENGTH(32000)\n'
			+'		BOOLEAN Verified := FALSE; // has found possible results\n'
			+'		BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best\n'
			+'		BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best\n'
			+'		BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best\n'
			+'		BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy\n'
			+'		DATASET(LayoutScoredFetch) Results;\n'
			+'		UNSIGNED4 keys_tried := 0;\n'
			+'		STRING keys_tried_desc;\n'
			+'	END;\n'
			+'	OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)\n'
			+'		InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout;\n'
			+'	END;\n'
			+'	resultsFormatted := project(outputResults, TRANSFORM(OutputLayout, \n'
			+'		res := project(left.results, TRANSFORM(LayoutScoredFetch, \n'
			+'				SELF.Segmentation := segKey(DID=left.did)[1].ind;\n'
			+'				SELF.keys_used_desc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.Keys_used);\n'
			+'				SELF := LEFT));\n'
			+'				self.Keys_tried_desc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.Keys_tried);\n'
			+'				self.results := res;\n'
			+'			self := left));\n'
			+'	output(resultsFormatted, named(\'FormattedResults\'));/*MXIDLHACK01*/', 'Result formatted code added')
	]

##---------------------------------------------------------------------------
##Attribute file Linkpaths CSV fields 
##Key Hack
##---------------------------------------------------------------------------
def dKeyAttributeCSVfields():
	return [
		('Key_InsuranceHeader_RELATIVE', 'STRING csv_fields := \'fname2,lname2,FNAME,LNAME,DID\';','RELHACK','STRING csv_fields := \'FNAME,LNAME,DID\'; /*RELHACK*/', 'removed fname2 and lname2 from csv fields'),
		('Key_InsuranceHeader_VIN', 'STRING csv_fields := \'VIN,FNAME,DID\';','VINHACK','STRING csv_fields := \'FNAME,DID\'; /*VINHACK*/', 'removed fname2 and lname2 from csv fields')
	]
	
##---------------------------------------------------------------------------
##Layout_Specificities 
##Max Count changed from 100 to 150
##---------------------------------------------------------------------------
def dMaxcountNullSS5():
	return [
		('Layout_Specificities', 'DATASET\(SSN5_ChildRec\) nulls_SSN5 \{MAXCOUNT\(100\)\};','LHACK','DATASET(SSN5_ChildRec) nulls_SSN5 {MAXCOUNT(150)}; /*LHACK*/', 'change from 100 to 150')	
	]

##---------------------------------------------------------------------------
##DL match_code
##Key hacks
##---------------------------------------------------------------------------
def dDLMatchCode():
	return [
		('Key_InsuranceHeader_DOB'	,'SELF\.DL_STATE_match_code := MAP\(','HACK22a','SELF.DL_STATE_MATCH_CODE := IF(SELF.DL_NBRWeight>0, MAP( /*HACK22a*/', 'DL_STATE match code is set only if DL_NBR matches'),
		('Key_InsuranceHeader_DOB'	,'DL_STATE,FALSE\)\)','HACK22b','DL_STATE,FALSE)), 0) /*HACK22b*/', 'DL_STATE match code close IF'),
		('Key_InsuranceHeader_DOBF'	,'SELF\.DL_STATE_match_code := MAP\(','HACK22a','SELF.DL_STATE_MATCH_CODE := IF(SELF.DL_NBRWeight>0, MAP( /*HACK22a*/', 'DL_STATE match code is set only if DL_NBR matches'),
		('Key_InsuranceHeader_DOBF'	,'DL_STATE,FALSE\)\)','HACK22b','DL_STATE,FALSE)), 0) /*HACK22b*/', 'DL_STATE match code close IF')
	]
	
##---------------------------------------------------------------------------
##Use DL_state only if DL_NBR has value
##MAC_MEOW_xIDL_Batch
##---------------------------------------------------------------------------
def dDLMatchWeight():
	return [
		('Key_InsuranceHeader_DOB'	,'SELF\.DL_STATEWeight := \(50\+MAP \(','HACK23a','SELF.DL_STATEWeight := IF(SELF.DL_NBRWeight>0, (50+MAP ( /*HACK23a*/', 'DL_state weight'),
		('Key_InsuranceHeader_DOB'	,'DL_STATE_weight100\)\)/100;','HACK23b','DL_STATE_weight100))/100, 0); /*HACK23b*/', 'DL_NBR weight close IF'),
		('Key_InsuranceHeader_DOBF'	,'SELF\.DL_STATEWeight := \(50\+MAP \(','HACK23a','SELF.DL_STATEWeight := IF(SELF.DL_NBRWeight>0, (50+MAP ( /*HACK23a*/', 'DL_state weight'),
		('Key_InsuranceHeader_DOBF'	,'DL_STATE_weight100\)\)/100;','HACK23b','DL_STATE_weight100))/100, 0); /*HACK23b*/', 'DL_NBR weight close IF')
	]	
	
##----------------------------------------------------------------------------
##Add parameter aBlockLimit to keys signature
##keys hack for person search
##-----------------------------------------------------------------------------
def dBlockLimitSignature():
	return [
		('Key_InsuranceHeader_ADDRESS', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.ADDRESS_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit ADDRESS key module'),
		('Key_InsuranceHeader_DLN', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.DLN_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit DLN key module'),
		('Key_InsuranceHeader_DOB', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.DOB_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit DOB key module'),
		('Key_InsuranceHeader_DOBF', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.DOBF_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit DOBF key module'),
		('Key_InsuranceHeader_LFZ', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.LFZ_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit LFZ key module'),
		('Key_InsuranceHeader_NAME', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.NAME_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit NAME key module'),
		('Key_InsuranceHeader_PH', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.PH_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit PH key module'),
		('Key_InsuranceHeader_RELATIVE', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.RELATIVE_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit RELATIVE key module'),
		('Key_InsuranceHeader_SSN', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.SSN_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit SSN key module'),
		('Key_InsuranceHeader_SSN4', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.SSN4_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit SSN4 key module'),
		('Key_InsuranceHeader_ZIP_PR', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.ZIP_PR_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit ZIP_PR key module'),
		('Key_InsuranceHeader_VIN', '\) := MODULE', 'HACK25', ', UNSIGNED2  aBlockLimit= Config.VIN_MAXBLOCKLIMIT) := MODULE/*HACK25*/', 'Add limit ZIP_PR key module')
	]

##----------------------------------------------------------------------------
##Key fetch limit change to variable
##keys hack for person search
##-----------------------------------------------------------------------------
def dBlockLimitLimit():
	return [
		('Key_InsuranceHeader_ADDRESS', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.ADDRESS_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change ADDRESS limit, atmost to variable'),
		('Key_InsuranceHeader_ADDRESS', ',Config.ADDRESS_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change ADDRESS limit, atmost to variable'),
		('Key_InsuranceHeader_DLN', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.DLN_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change DLN limit, atmost to variable'),
		('Key_InsuranceHeader_DLN', ',Config.DLN_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit DLN, atmost to variable'),
		('Key_InsuranceHeader_DOB', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.DOB_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change DOB limit, atmost to variable'),
		('Key_InsuranceHeader_DOB', ',Config.DOB_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit DOB, atmost to variable'),
		('Key_InsuranceHeader_DOBF', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.DOBF_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change DOBF limit, atmost to variable'),
		('Key_InsuranceHeader_DOBF', ',Config.DOBF_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit DOBF, atmost to variable'),
		('Key_InsuranceHeader_LFZ', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.LFZ_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change LFZ limit, atmost to variable'),
		('Key_InsuranceHeader_LFZ', ',Config.LFZ_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit LFZ, atmost to variable'),
		('Key_InsuranceHeader_NAME', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.NAME_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change NAME limit, atmost to variable'),
		('Key_InsuranceHeader_NAME', ',Config.NAME_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit NAME, atmost to variable'),
		('Key_InsuranceHeader_PH', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.PH_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change PH limit, atmost to variable'),
		('Key_InsuranceHeader_PH', ',Config.PH_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit PH, atmost to variable'),
		('Key_InsuranceHeader_RELATIVE', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.RELATIVE_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change RELATIVE limit, atmost to variable'),
		('Key_InsuranceHeader_RELATIVE', ',Config.RELATIVE_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit RELATIVE, atmost to variable'),
		('Key_InsuranceHeader_SSN', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.SSN_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change SSN limit, atmost to variable'),
		('Key_InsuranceHeader_SSN', ',Config.SSN_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit SSN, atmost to variable'),
		('Key_InsuranceHeader_SSN4', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.SSN4_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change SSN4 limit, atmost to variable'),
		('Key_InsuranceHeader_SSN4', ',Config.SSN4_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit SSN4, atmost to variable'),
		('Key_InsuranceHeader_ZIP_PR', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.ZIP_PR_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change ZIP_PR limit, atmost to variable'),
		('Key_InsuranceHeader_ZIP_PR', ',Config.ZIP_PR_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit ZIP_PR, atmost to variable'),
		('Key_InsuranceHeader_VIN', 'EXPORT CanSearch', 'HACK24a', 'EXPORT MAX_BLOCKLIMIT := IF (aBlockLimit=0,  Config.VIN_MAXBLOCKLIMIT, aBlockLimit);/*HACK24a*/\nEXPORT CanSearch', 'Change VIN limit, atmost to variable'),
		('Key_InsuranceHeader_VIN', ',Config.VIN_MAXBLOCKLIMIT', 'HACK24b', ',MAX_BLOCKLIMIT/*HACK24b*/', 'Change limit VIN, atmost to variable')
	]
	
##---------------------------------------------------------------------------
##MEOW_xIDL
##hack for person search
##---------------------------------------------------------------------------
def dMeowXidl():
	return [
		
			
		('Meow_xIDL', 'Key_InsuranceHeader_ADDRESS\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_ADDRESS(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'ADDRESS key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_DLN\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_DLN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'DLN key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_DOB\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_DOB(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'DOB key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_DOBF\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_DOBF(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'DOBF key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_LFZ\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_LFZ(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'LFZ key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_NAME\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_NAME(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'NAME key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_PH\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_PH(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'PH key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_RELATIVE\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_RELATIVE(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'RELATIVE key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_SSN\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_SSN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'SSN key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_SSN4\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_SSN4(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'SSN4 key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_ZIP_PR\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_ZIP_PR(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'ZIP_PR key call with BlockLimit'),
		('Meow_xIDL', 'Key_InsuranceHeader_VIN\(\).ScoredDIDFetch', 'MEOWHACK5', 'Key_InsuranceHeader_VIN(,aBlockLimit/*MEOWHACK05*/).ScoredDIDFetch', 'VIN key call with BlockLimit'),
		('Meow_xIDL', '\) := MODULE', 'MEOWHACK5', ', UNSIGNED2 aBlockLimit=0) := MODULE /*MEOWHACK05*/', 'Add Blocklimit parameter'),
		## zipcases and patch_specificities
		('Meow_xIDL', 'fetchResults := TOPN\(fetchResults0\(DID > 0\),le\.MaxIDs \+ 1,-Weight\) & fetchResults0\(DID = 0\);', 'ZIPPATCHHACK01d', 
					'\tfetchResults11 := Process_xIDL_Layouts().combine_Zip(fetchResults0);\n' + 
					'\tfetchResults1 := UNGROUP(InsuranceHeader_xlink.patch_specificities(fetchResults11));\n'+
					'\tfetchResults := TOPN(fetchResults1(DID > 0),le.MaxIDs + 1,-Weight) & fetchResults1(DID = 0); /*ZIPPATCHHACK01d*/', 'Roxie call for combine_zip and patch_specificities')
	]	

##---------------------------------------------------------------------------
##Scaled_Candidates
##hack for person search
##---------------------------------------------------------------------------
def dScaled_Candidates():
	return [
		('Scaled_Candidates', 'INTEGER2', 'LAYOUTHACK01', 'UNSIGNED2', 'To avoid layout change in the xlink keys for SALT 3.11 upgrade')		
	]	

def dZipCases() :
	return [
		('Process_xIDL_Layouts', 'EXPORT LayoutScoredFetch combine_scores', 'ZIPCASESHACK01a', '\tEXPORT LayoutScoredFetch combine_Zip(DATASET(LayoutScoredFetch) le) := FUNCTION\n' + 
				'\t\tfetchResults := project(le, transform(LayoutScoredFetch,\n'+
					 '\t\t\tSELF.ZIP_cases := DEDUP(SORT(left.ZIP_cases, ZIP,-weight ),ZIP);\n'+
					 '\t\t\tSELF := LEFT));\n'+
		'\t\t\tRETURN fetchResults;\n'+
		'\tEND; /*ZIPCASESHACK01*/\n' + 
		'\tEXPORT LayoutScoredFetch combine_scores' , 'combine_zip code'), 
		('Process_xIDL_Layouts', 'SELF\.ZIP_cases := DEDUP\(SORT\(le\.ZIP_cases & ri\.ZIP_cases, ZIP,-weight \),ZIP\);', 'ZIPCASESHACK01b', 'SELF.ZIP_cases := le.ZIP_cases + ri.ZIP_cases; /*ZIPCASESHACK01b*/', 'Remove DEDUP(SORT()) in transform'),
		('Process_xIDL_Layouts', 'r1 := AdjustScoresForNonExactMatches\(UNGROUP\(r0\)\);', 'ZIPCASESHACK01c', 'r11:= combine_Zip(UNGROUP(r0));\n' + 
			'\tR1 := AdjustScoresForNonExactMatches(r11);/*ZIPCASESHACK01c*/', 'thor call for combine_zip')
	]

# this hack was introduced with removal of address concept in the SPC file, but as of right now it is not used yet																												  
def dAddrPenalty() :
	return [
		('Key_InsuranceHeader_ADDRESS', 'PRIM_RANGE_weight100\)\)/100;', 'HACK28a', 'PRIM_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK28a*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ADDRESS', 'PRIM_NAME_weight100\)\)/100;', 'HACK28b', 'PRIM_NAME_weight100))/100 * Config.AddrPenalty; /*HACK28b*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ADDRESS', 'ZIP_weight100\)\)/100;', 'HACK28c', 'ZIP_weight100))/100 * Config.AddrPenalty; /*HACK28c*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ADDRESS', 'SEC_RANGE_weight100\)\)/100;', 'HACK28d', 'SEC_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK28d*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ADDRESS', 'CITY_weight100\)\)/100;', 'HACK28e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK28e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ADDRESS', 'ST_weight100\)\)/100;', 'HACK28f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK28f*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_DOB', 'CITY_weight100\)\)/100;', 'HACK29e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK29e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_DOB', 'ST_weight100\)\)/100;', 'HACK29f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK29f*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_DOBF', 'CITY_weight100\)\)/100;', 'HACK30e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK30e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_DOBF', 'ST_weight100\)\)/100;', 'HACK30f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK30f*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_LFZ', 'PRIM_RANGE_weight100\)\)/100;', 'HACK31a', 'PRIM_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK31a*/', 'AddrPenalty'),
		('Key_InsuranceHeader_LFZ', 'PRIM_NAME_weight100\)\)/100;', 'HACK31b', 'PRIM_NAME_weight100))/100 * Config.AddrPenalty; /*HACK31b*/', 'AddrPenalty'),
		('Key_InsuranceHeader_LFZ', 'ZIP_weight100\)\)/100;', 'HACK31c', 'ZIP_weight100))/100 * Config.AddrPenalty; /*HACK31c*/', 'AddrPenalty'),
		('Key_InsuranceHeader_LFZ', 'SEC_RANGE_weight100\)\)/100;', 'HACK31d', 'SEC_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK31d*/', 'AddrPenalty'),
		('Key_InsuranceHeader_LFZ', 'CITY_weight100\)\)/100;', 'HACK31e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK31e*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_NAME', 'PRIM_RANGE_weight100\)\)/100;', 'HACK32a', 'PRIM_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK32a*/', 'AddrPenalty'),
		('Key_InsuranceHeader_NAME', 'PRIM_NAME_weight100\)\)/100;', 'HACK32b', 'PRIM_NAME_weight100))/100 * Config.AddrPenalty; /*HACK32b*/', 'AddrPenalty'),		
		('Key_InsuranceHeader_NAME', 'SEC_RANGE_weight100\)\)/100;', 'HACK32d', 'SEC_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK32d*/', 'AddrPenalty'),
		('Key_InsuranceHeader_NAME', 'CITY_weight100\)\)/100;', 'HACK32e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK32e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_NAME', 'ST_weight100\)\)/100;', 'HACK32f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK32f*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_PH', 'CITY_weight100\)\)/100;', 'HACK33e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK33e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_PH', 'ST_weight100\)\)/100;', 'HACK33f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK33f*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_SSN', 'CITY_weight100\)\)/100;', 'HACK34e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK34e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_SSN', 'ST_weight100\)\)/100;', 'HACK34f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK34f*/', 'AddrPenalty'),
		
		('Key_InsuranceHeader_ZIP_PR', 'PRIM_RANGE_weight100\)\)/100;', 'HACK35a', 'PRIM_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK35a*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ZIP_PR', 'PRIM_NAME_weight100\)\)/100;', 'HACK35b', 'PRIM_NAME_weight100))/100 * Config.AddrPenalty; /*HACK35b*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ZIP_PR', 'ZIP_weight100\)\)/100;', 'HACK35c', 'ZIP_weight100))/100 * Config.AddrPenalty; /*HACK35c*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ZIP_PR', 'SEC_RANGE_weight100\)\)/100;', 'HACK35d', 'SEC_RANGE_weight100))/100 * Config.AddrPenalty; /*HACK35d*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ZIP_PR', 'CITY_weight100\)\)/100;', 'HACK35e', 'CITY_weight100))/100 * Config.AddrPenalty; /*HACK35e*/', 'AddrPenalty'),
		('Key_InsuranceHeader_ZIP_PR', 'ST_weight100\)\)/100;', 'HACK35f', 'ST_weight100))/100 * Config.AddrPenalty; /*HACK35f*/', 'AddrPenalty')
		
	]
 
def dMainameFuzzy() :
 	return [
 		('match_candidates', 'log\(ri.cnt/ri.MAINNAME_fuzzy_cnt\)', 'HACK36',  'log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt) /*HACK36*/', 'Mainname fuzzy match calculation')
 	]
	
##---------------------------------------------------------------------------
##DOB weight hack, issue #5070
##Key hacks 
#---------------------------------------------------------------------------
def dDobMatchcode():
	return [
		# online changes
		('Key_InsuranceHeader_ADDRESS'	,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DLN'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DOB'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DOBF'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_LFZ'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_NAME'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_PH'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SRC_RID'	,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SSN'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SSN4'		,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_ZIP_PR'	,'DOB_year = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK01','DOB_year = 0 OR ((UNSIGNED)param_DOB) DIV 10000 = 0 /*DOBHACK01*/','Dob Hack to not penalize zeros online'),		
		
		('Key_InsuranceHeader_ADDRESS'	,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DLN'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DOB'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DOBF'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_LFZ'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_NAME'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_PH'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SRC_RID'	,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SSN'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SSN4'		,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_ZIP_PR'	,'DOB_month = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK02','DOB_month = 0 OR ((UNSIGNED)param_DOB) DIV 100 % 100 = 0 /*DOBHACK02*/','Dob Hack to not penalize zeros online'),		
		
		('Key_InsuranceHeader_ADDRESS'	,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DLN'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DOB'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_DOBF'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_LFZ'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_NAME'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_PH'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SRC_RID'	,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SSN'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_SSN4'		,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),
		('Key_InsuranceHeader_ZIP_PR'	,'MAP\(\s*le.DOB_day = 0 OR param_DOB = \(TYPEOF\(param_DOB\)\)\'\'','DOBHACK03','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)param_DOB) % 100 = 0 /*DOBHACK03*/','Dob Hack to not penalize zeros online'),		
		
		('Key_InsuranceHeader_ADDRESS'	,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DLN'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DOB'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DOBF'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_LFZ'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_NAME'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_PH'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SRC_RID'	,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SSN'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SSN4'		,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_ZIP_PR'	,'DOB_year = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK04','DOB_year = 0 OR ((UNSIGNED)ri.DOB) DIV 10000 = 0 /*DOBHACK04*/','Dob Hack to not penalize zeros batch'),
		
		('Key_InsuranceHeader_ADDRESS'	,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DLN'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DOB'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DOBF'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_LFZ'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_NAME'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_PH'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SRC_RID'	,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SSN'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SSN4'		,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_ZIP_PR'	,'DOB_month = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK05','DOB_month = 0 OR ((UNSIGNED)ri.DOB) DIV 100 % 100 = 0 /*DOBHACK05*/','Dob Hack to not penalize zeros batch'),
		
		('Key_InsuranceHeader_ADDRESS'	,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DLN'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DOB'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_DOBF'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_LFZ'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_NAME'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_PH'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SRC_RID'	,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SSN'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_SSN4'		,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch'),
		('Key_InsuranceHeader_ZIP_PR'	,'MAP\(\s*le.DOB_day = 0 OR ri\.DOB = \(TYPEOF\(ri\.DOB\)\)\'\'','DOBHACK06','MAP(\n\t\tle.DOB_day = 0 OR ((UNSIGNED)ri.DOB) % 100 = 0 /*DOBHACK06*/','Dob Hack to not penalize zeros batch')
		
	]

## change InsuranceHeader_xLink.MAC_MEOW_xIDL_Online to accept service name as parameter.
##  this is very usefull for testing different versions of the service.
def dMacMeowOnlineSoap() :
 	return [	
 		('MAC_MEOW_xIDL_Online', 'Soapcall_RoxieIP = \'\'', 'HACK37a',  'serviceName=\'MEOW_xIDL_Service\' /*Hack37a*/, Soapcall_RoxieIP = \'\' /*HACK37a*/', 'Add service name as parameter'),
		('MAC_MEOW_xIDL_Online', 'ServiceModule\+\'MEOW_xIDL_Service\'', 'HACK37b', 'ServiceModule+serviceName /*HACK37b*/',  'use service name parameter')
 	]

def dVinWeight() :
		return [
		('Key_InsuranceHeader_VIN', 'le\.VIN_weight100\)\)/100', 'HACK38', 'le.VIN_weight100))/100*1.15 /*HACK38*/', 'add weight to vin so it will have enough'),
		]
		
def dGoExternal() :
	return [
		('Proc_GoExternal', 'Keys\(File_InsuranceHeader, incremental\)\.BuildAll,', 'GOEXTERNAL01', '/*GOEXTERNAL01*/', 'remove unecessary keys')
	]		

##---------------------------------------------------------------------------
##Key_InsuranceHeader_NAME hacks
##Key hacks
##---------------------------------------------------------------------------
def dKeyInsuranceHeaderNAME():
	return [
		('Key_InsuranceHeader_NAME'		,'SHARED DataForKey := DataForKey0;'	,'HACK39','SHARED DataForKey := project(DataForKey0, transform(layout,	BOOLEAN emptyConcept :=  left.CITY = \'\' and 	left.PRIM_NAME = \'\';  \n\t // 10-19 => st_weight/2 or 20 and greater => st_weight/3 \n\t	self.st_weight100 := IF (emptyConcept AND left.st_weight100 >=1000 AND left.st_weight100<2000,  \n\t				left.st_weight100/2, IF (emptyConcept AND left.st_weight100>=2000, left.st_weight100/3, left.st_weight100)); \n\t	self := left)); /*HACK39*/', 'NAME_Key weights hacked')
	]
	
def dTest1():
	return [
		#('Meow_xIDL', ',SORTED\(Key_InsuranceHeader_SRC_RID\(\)\.ScoredDIDFetch\(param_SRC := le\.\SRC,param_SOURCE_RID := le\.SOURCE_RID,param_FNAME := le\.FNAME,param_FNAME_len := FNAME_len,param_DOB := \(UNSIGNED4\)le\.DOB,param_CITY := le\.CITY,param_DERIVED_GENDER := le\.DERIVED_GENDER,param_SNAME := le\.SNAME,param_ST := le\.ST,param_disableForce := In_disableForce\),DID\)','MEOWHACK01', '#IF (InsuranceHeader_xLink.Environment.isCurrentAlpha) \n\t\t'
		#	+ '  ,SORTED(Key_InsuranceHeader_SRC_RID().ScoredDIDFetch(param_SRC := le.SRC,param_SOURCE_RID := le.SOURCE_RID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_ST := le.ST,param_disableForce := In_disableForce),DID) \n\t\t'
		#	+ '#END/*MEOWHACK01*/', 'Remove SRC_RID key not available for Public Records in MEOW_xIDL'),
		#('Meow_xIDL', ',SORTED\(IF\(InsuranceHeader_xLink\.Key_InsuranceHeader_SRC_RID\(\)\.CanSearch\(le\),Key_InsuranceHeader_SRC_RID\(\)\.ScoredDIDFetch\(param_SRC := le\.SRC,param_SOURCE_RID := le\.SOURCE_RID,param_FNAME := le\.FNAME,param_FNAME_len := FNAME_len,param_DOB := \(UNSIGNED4\)le\.DOB,param_CITY := le\.CITY,param_DERIVED_GENDER := le\.DERIVED_GENDER,param_SNAME := le\.SNAME,param_ST := le\.ST,param_disableForce := In_disableForce\)\),DID\)','MEOWHACK01', '#IF (InsuranceHeader_xLink.Environment.isCurrentAlpha) \n\t\t'
		#	+ '  ,SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().CanSearch(le),Key_InsuranceHeader_SRC_RID().ScoredDIDFetch(param_SRC := le.SRC,param_SOURCE_RID := le.SOURCE_RID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_ST := le.ST,param_disableForce := In_disableForce)),DID) \n\t\t'
		#	+ '#END/*MEOWHACK01*/', 'Remove SRC_RID key not available for Public Records in MEOW_xIDL'),
		#('Meow_xIDL', '(LinkPathName = \'SRC_RID\' => IF\(Key_InsuranceHeader_SRC_RID\(\).CanSearch\(le\))(.*?)(,Process_xIDL_Layouts\(\).LayoutScoredFetch\)\),)','MEOWHACK02','\g<1>\n'
		#	+ '#IF (InsuranceHeader_xLink.Environment.isCurrentAlpha)  \n\t\t'
		#	+ ',SORTED(Key_InsuranceHeader_SRC_RID().ScoredDIDFetch(param_SRC := le.SRC,param_SOURCE_RID := le.SOURCE_RID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_ST := le.ST,param_disableForce := In_disableForce),DID) \n'
		#	+ '#END/*MEOWHACK02*/,DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),', 'Linkpath name Src_RID'),
	
		#('Meow_xIDL', '(LinkPathName = \'SRC_RID\' => IF\(Key_InsuranceHeader_SRC_RID\(\).CanSearch\(le\))(.*?)(,Process_xIDL_Layouts\(\).LayoutScoredFetch\)\),)','MEOWHACK02','\g<1>\n'
		#	+ '#IF (InsuranceHeader_xLink.Environment.isCurrentAlpha)  \n\t\t'
		#	+ 'IF(Key_InsuranceHeader_SRC_RID().CanSearch(le),SORTED(IF(InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().CanSearch(le),Key_InsuranceHeader_SRC_RID().ScoredDIDFetch(param_SRC := le.SRC,param_SOURCE_RID := le.SOURCE_RID,param_FNAME := le.FNAME,param_FNAME_len := FNAME_len,param_DOB := (UNSIGNED4)le.DOB,param_CITY := le.CITY,param_DERIVED_GENDER := le.DERIVED_GENDER,param_SNAME := le.SNAME,param_ST := le.ST,param_disableForce := In_disableForce)),DID) \n'
		#	+ '#END/*MEOWHACK02*/,DATASET([],Process_xIDL_Layouts().LayoutScoredFetch)),', 'Linkpath name Src_RID')				
	]
		
getHacks = dConfig() + \
			dRawFetchFnameEditDist() + \
			dJ0J1FnameEditDist() + \
			dRawFetchLnameEditDist() +\
			dJ0J1LnameEditDist() +\
			dKeyName() +\
			dKeyNameLogical() +\
			dRawFetchWordbag() + \
			dScoreDidFetchWordbag() + \
			dJ0J1WordBag() + \
			dKeyInsuranceHeaderSSN() + \
			dKeyInsuranceHeaderLFZ() + \
			dMacExternalAddPcnt() + \
			dMatchCodeLnameEditDist() + \
			dMatchCodeFnameEditDist() + \
			dDOBNotUseForce() + \
			dWebService() + \
			dCleanAddressName() + \
			dToUpperCase() + \
			dAddUpperCase1() + \
			dAddUpperCase2() + \
			dProcessXidlLayouts() + \
			dConceptForceDown () + \
			dMacMeowXidlBatch() + \
			dSpecificities() + \
			dXidlHeaderService() + \
			dformattedResult() + \
			dMaxcountNullSS5() + \
			dDLMatchCode() + \
			dDLMatchWeight() + \
			dKeyInsuranceHeaderDLN() + \
			dBlockLimitLimit() + \
			dBlockLimitSignature()+ \
			dMeowXidl() + \
			dScaled_Candidates() +  \
			dZipCases() + \
			dMainameFuzzy() + \
			dDobMatchcode() + \
			dMacMeowOnlineSoap() +\
			dVinWeight() + \
			dGoExternal() + \
			dKeyInsuranceHeaderNAME()
			
getHacks1 = dConceptForceDown()
			
