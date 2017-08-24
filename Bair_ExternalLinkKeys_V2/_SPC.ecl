﻿OPTIONS:-ma
MODULE:Bair_ExternalLinkKeys_V2 
FILENAME:Classify_PS
IDNAME:EID_HASH
IDFIELD:EXISTS:EID_HASH
RECORDS:300000000
POPULATION:270000000
NINES:3
PROCESS:PS:UBER(NEVER)
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):ONFAIL(CLEAN):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:T_ALLCAPS:CAPS:ONFAIL(CLEAN)
FIELDTYPE:T_ALPHANUM:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
// FUZZY
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
FIELD:NAME_SUFFIX:PROP:LIKE(T_ALPHANUM):6,54 //Changed from sname to NAME_Suffix
FIELD:FNAME:TYPE(STRING20):INITIAL:PHONETIC:EDIT1:PreferredName:WEIGHT(0.8):LIKE(T_ALPHANUM):9,263
FIELD:MNAME:TYPE(STRING20):INITIAL:PROP:EDIT2:WEIGHT(0.8):LIKE(T_ALPHANUM):8,228
FIELD:LNAME:TYPE(STRING28):BAGOFWORDS(ANY):WEIGHT(2):LIKE(T_ALPHANUM):11,383
//Address
FIELD:PRIM_RANGE:TYPE(STRING10):EDIT1:11,463
FIELD:PRIM_NAME:TYPE(STRING28):EDIT1:11,469
FIELD:SEC_RANGE:TYPE(STRING8):CONTEXT(PRIM_NAME):HYPHEN2:8,371
FIELD:P_CITY_NAME:TYPE(STRING25):CONTEXT(ST):10,420
FIELD:ST:TYPE(STRING2):5,310
FIELD:ZIP:TYPE(STRING5):LIKE(NUMBER):14,0
DATEFIELD:DOB:SOFT1(4.0):YEARSHIFT13(4.0):MDDM:PROP:FORCE(--3):15,0
FIELD:PHONE:TYPE(STRING10):LIKE(NUMBER):WEIGHT(0.5):PROP:21,420
FIELD:DL_ST:TYPE(STRING15):9,25
FIELD:DL:CONTEXT(DL_ST):23,124
//
FIELD:LEXID:15,350
FIELD:POSSIBLE_SSN:TYPE(STRING9):EDIT1:PROP:24,35
FIELD:CRIME:TYPE(STRING):10,45
FIELD:NAME_TYPE:TYPE(STRING):10,45
FIELD:CLEAN_GENDER:TYPE(STRING):10,45
FIELD:CLASS_CODE:10,0
FIELD:DT_FIRST_SEEN:1,0
FIELD:DT_LAST_SEEN:1,0
FIELD:DATA_PROVIDER_ORI:10,120
//vehicle
FIELD:VIN:TYPE(STRING27):12,450
FIELD:PLATE:TYPE(STRING):1,0
//LATLONG
FIELD:LATITUDE:TYPE(STRING):1,0
FIELD:LONGITUDE:TYPE(STRING):1,0
FIELD:SEARCH_ADDR1:TYPE(STRING):18,576
FIELD:SEARCH_ADDR2:TYPE(STRING):20,520
FIELD:CLEAN_COMPANY_NAME:TYPE(STRING100):22,550
// Concept
CONCEPT:MAINNAME:FNAME:MNAME:LNAME:22,691
CONCEPT:FULLNAME:MAINNAME:NAME_SUFFIX:22,529
HACK:KEYPREFIX
HACK:KEYINFIX
HACK:KEYSUPERFILE
HACK:MAXBLOCKSIZE(5000)
LINKPATH:NAME:FNAME:LNAME:ST:?:NAME_SUFFIX:MNAME:+:PRIM_RANGE:PRIM_NAME:SEC_RANGE:P_CITY_NAME:DOB:SEARCH_ADDR1:SEARCH_ADDR2:LEXID:MAXBLOCKSIZE(500)
LINKPATH:ADDRESS:PRIM_RANGE:PRIM_NAME:ZIP:?:SEC_RANGE:MAINNAME:+:P_CITY_NAME:ST:NAME_SUFFIX:DOB
LINKPATH:DOB:DOB:LNAME:?:FNAME:MNAME:+:ST:P_CITY_NAME:NAME_SUFFIX
LINKPATH:ZIP_PR:ZIP:PRIM_RANGE:?:FNAME:LNAME:+:PRIM_NAME:SEC_RANGE:P_CITY_NAME:ST:NAME_SUFFIX:DOB
LINKPATH:DLN:DL:DL_ST:?:MAINNAME:+:NAME_SUFFIX:DOB
LINKPATH:PH:PHONE:?:MAINNAME:DOB:+:P_CITY_NAME:ST
LINKPATH:LFZ:LNAME:FNAME:ZIP:+:P_CITY_NAME:PRIM_RANGE:PRIM_NAME:MNAME:SEC_RANGE:NAME_SUFFIX:DOB
LINKPATH:VIN:VIN:?:LNAME:+:P_CITY_NAME
LINKPATH:LEXID:LEXID:?:MAINNAME:+:NAME_SUFFIX:DOB:DL
LINKPATH:SSN:POSSIBLE_SSN:?:MAINNAME:+:SEARCH_ADDR1:P_CITY_NAME:ST:DOB
LINKPATH:LATLONG:LATITUDE:LONGITUDE:?:MAINNAME:+:POSSIBLE_SSN
LINKPATH:PLATE:PLATE:?:MAINNAME:+:P_CITY_NAME:ST
LINKPATH:COMPANY:CLEAN_COMPANY_NAME:?:SEARCH_ADDR1(HASBASE):+:P_CITY_NAME:ST:SEARCH_ADDR2:LEXID
