﻿MODULE:MyModule
FILENAME:Sample
IDFIELD:EXISTS:BDID
RIDFIELD:rcid
RECORDS:200000
POPULATION:7000
NINES:3
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:ALPHA:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):
FIELDTYPE:WORDBAG:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN):
FIELDTYPE:CITY:LIKE(WORDBAG):LENGTHS(0,4..):ONFAIL(CLEAN):
FIELD:source:CARRY:
FIELD:vendor_id:CARRY:
FIELD:dt_first_seen:RECORDDATE(FIRST):
FIELD:dt_last_seen:RECORDDATE(LAST):
FIELD:company_name:BAGOFWORDS:LIKE(WORDBAG):TYPE(STRING120):INITIAL:ABBR:EDIT1:FORCE(+4):7,0
FIELD:prim_range:EDIT1:8,0
FIELD:predir:4,0
FIELD:prim_name:EDIT1:3,0
FIELD:addr_suffix:LIKE(ALPHA):CONTEXT(prim_name):1,0
FIELD:postdir:11,0
FIELD:unit_desig:7,0
FIELD:sec_range:9,0
FIELD:CITY:2,0
FIELD:state:LIKE(ALPHA):2,0
FIELD:zip:LIKE(NUMBER):2,0
FIELD:zip4:LIKE(NUMBER):CONTEXT(zip):8,0
FIELD:county:2,0
FIELD:msa:LIKE(NUMBER):7,0
FIELD:phone:LIKE(NUMBER):PROP:14,0
FIELD:fein:LIKE(NUMBER):PROP:14,0
CONCEPT:locale:+:zip:state:city:msa:2,0
CONCEPT:address:prim_range+:sec_range:prim_name+:zip4:unit_desig:addr_suffix:9,0
SOURCEFIELD:source:CONSISTENT(company_name,prim_name,prim_range,sec_range,city,state)
ATTRIBUTEFILE:VEHICLES:NAMED(SALT_Examples.File_Vehicle_Matches_Sample):VALUES(vin):IDFIELD(BDID):17,0
ATTRIBUTEFILE:PROPERTY:NAMED(SALT_Examples.File_Property_Matches_Sample):VALUES(LN_FARES_id):IDFIELD(BDID):17,0
ATTRIBUTEFILE:BANKRUPTCY:NAMED(SALT_Examples.File_Bankruptcy_Matches_Sample):VALUES(court_case_number):IDFIELD(BDID):17,0
