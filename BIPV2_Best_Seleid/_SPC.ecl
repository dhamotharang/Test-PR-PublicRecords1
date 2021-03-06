MODULE:BIPV2_Best_Seleid
FILENAME:Base
// Uncomment up to NINES for internal or external adl
IDFIELD:EXISTS:Seleid
RIDFIELD:rcid
RECORDS:3000000000
POPULATION:3000000000
NINES:3
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
FIELDTYPE:wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)
FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:upper:CAPS:ONFAIL(CLEAN)
FIELDTYPE:cname:CAPS:ONFAIL(CLEAN)
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
FIELD:source_for_votes:CARRY
SOURCEFIELD:source_for_votes:PERMITS(fn_sources,10)
//BESTTYPE statements declare methods of generating the best value for a given cluster
//Company Name
BESTTYPE:BestCompanyNameLegal:BASIS(Seleid):VOTED(fn_Best_Name_Legal_Votes):FUZZY:VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameVotedSeleLevel:BASIS(Seleid):VOTED(fn_Best_Sele_Level_Votes,2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameCommon:BASIS(Seleid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameCurrent:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:MINIMUM(2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameVoted:BASIS(Seleid):VOTED(fn_Best_Name_Source_Votes,2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameLength:BASIS(Seleid):LONGEST:FUZZY:VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameStrong:BASIS(Seleid):UNIQUE:FUZZY:VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameCurrent2:BASIS(Seleid):RECENT(dt_last_seen):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameVotedUnrestricted:BASIS(Seleid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_cname):EXTEND
//Address
BESTTYPE:BestCompanyAddressVotedSeleLevel:BASIS(Seleid):VOTED(fn_Best_Sele_Level_Votes,2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressVoted:BASIS(Seleid):VOTED(fn_Best_Address_Fields_Votes,2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressCurrent:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:MINIMUM(2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressVotedSrc:BASIS(Seleid):VOTED(fn_Best_Address_Source_Votes,2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressCommon:BASIS(Seleid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressLength:BASIS(Seleid):LONGEST:FUZZY:VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressStrong:BASIS(Seleid):UNIQUE:FUZZY:VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestSecRange:BASIS(Seleid:company_prim_range:company_prim_name:company_zip5):COMMONEST:FUZZY:EXTEND
BESTTYPE:BestCompanyAddressCurrent2:BASIS(Seleid):RECENT(dt_last_seen):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressVotedUnrestricted:BASIS(Seleid):VOTED(fn_Best_Source_Unrestricted_Votes,2):FUZZY:VALID(fn_valid_caddress):EXTEND
//Phone
BESTTYPE:BestPhoneVotedSeleLevelWithNpa:BASIS(Seleid):VOTED(fn_Best_Sele_Level_Votes,2):VALID(fn_valid_cphone10):EXTEND
BESTTYPE:BestPhoneCurrentWithNpa:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_cphone10):EXTEND
BESTTYPE:BestPhoneCurrent:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneVoted:BASIS(Seleid):VOTED(fn_Best_Phone_Votes,2):FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneLongest:BASIS(Seleid):LONGEST:FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneStrong:BASIS(Seleid):UNIQUE:FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneVotedUnrestricted:BASIS(Seleid):VOTED(fn_Best_Source_Unrestricted_Votes,2):FUZZY:VALID(fn_valid_cphone10):EXTEND
BESTTYPE:BestPhoneCommon:BASIS(Seleid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_cphone10):EXTEND
//TIN
BESTTYPE:BestFeinStrong:BASIS(Seleid):UNIQUE:FUZZY:VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinCommon:BASIS(Seleid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinCurrent:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinVotedUnrestricted:BASIS(Seleid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinMin:BASIS(Seleid):VOTED(fn_Best_Fein_Votes_Min,2):FUZZY:VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinMax:BASIS(Seleid):VOTED(fn_Best_Fein_Votes_Max,2):FUZZY:VALID(fn_valid_cfein):EXTEND
//BESTTYPE:BestFeinVoted:BASIS(Seleid):VOTED(BestFeinVotes,2):FUZZY:VALID(fn_valid_cfein):PROP
//URL
BESTTYPE:BestUrlCommon:BASIS(Seleid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlCurrent:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlLength:BASIS(Seleid):LONGEST:FUZZY:VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlStrong:BASIS(Seleid):UNIQUE:FUZZY:VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlVotedUnrestricted:BASIS(Seleid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_curl):EXTEND
//DUN_NUMBER
BESTTYPE:BestDunsCommon:BASIS(Seleid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_duns):EXTEND
BESTTYPE:BestDunsCurrent:BASIS(Seleid):RECENT(dt_last_seen):FUZZY:MINIMUM(2):VALID(fn_valid_duns):EXTEND
BESTTYPE:BestDunsCurrent2:BASIS(Seleid):RECENT(dt_last_seen):VALID(fn_valid_duns):EXTEND
BESTTYPE:BestDunsVotedUnrestricted:BASIS(Seleid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_duns):EXTEND
// FUZZY can be used to create new types of FUZZY linking
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
// ------------------------------------
//  1. Company fields
// ------------------------------------
//FIELD:company_name:LIKE(cname):EDIT1:BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:FLAG:19,137
//FIELD:company_name:LIKE(cname):BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:FLAG:19,137
FIELD:company_name:LIKE(cname):BestCompanyNameLegal:BestCompanyNameVotedSeleLevel:BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:BestCompanyNameStrong:BestCompanyNameCurrent2:BestCompanyNameVotedUnrestricted:FLAG:26,371
//FIELD:cnp_name:LIKE(cname):0,0
//FIELD:cnp_number:LIKE(alpha):0, 0
//FIELD:cnp_btype:LIKE(alpha):0,0
//FIELD:cnp_lowv:LIKE(alpha):0,0
//CONCEPT:company_name_clean:LIKE(cname):EDIT2:BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:BestCompanyNameStrong:BestCompanyNameCurrent2:BestCompanyNameVotedUnrestricted:FLAG:25,360
FIELD:company_fein:LIKE(number):right4:EDIT1:BestFeinStrong:BestFeinCommon:BestFeinCurrent:BestFeinVotedUnrestricted:BestFeinMin:BestFeinMax:OWNED:FLAG:27,136
FIELD:company_phone:LIKE(number):EDIT1:BestPhoneVotedSeleLevelWithNpa:BestPhoneCurrentWithNpa:BestPhoneCurrent:BestPhoneVoted:BestPhoneLongest:BestPhoneStrong:BestPhoneVotedUnrestricted:BestPhoneCommon:FLAG:26,295
FIELD:company_url:BestUrlCommon:BestUrlCurrent:BestUrlLength:BestUrlStrong:BestUrlVotedUnrestricted:FLAG:27,27
// ------------------------------------
//  2. company Address fields
// ------------------------------------
FIELD:prim_range:13,111
FIELD:predir:4,56
FIELD:prim_name:15,128
FIELD:addr_suffix:3,89
FIELD:postdir:7,42
FIELD:unit_desig:5,64
FIELD:sec_range:FORCE(--):12,167
FIELD:p_city_name:12,100
FIELD:v_city_name:11,77
FIELD:st:LIKE(alpha):5,16
FIELD:zip:LIKE(number):14,99
FIELD:zip4:LIKE(number):13,177
FIELD:fips_state:LIKE(number):5,16
FIELD:fips_county:LIKE(number):7,89
CONCEPT:address:prim_range:predir:prim_name:addr_suffix:postdir:unit_desig:sec_range:st:zip:BestCompanyAddressVotedSeleLevel:BestCompanyAddressVoted:BestCompanyAddressCurrent:BestCompanyAddressVotedSrc:BestCompanyAddressCommon:BestCompanyAddressStrong:BestCompanyAddressCurrent2:BestCompanyAddressVotedUnrestricted:FLAG:25,226
FIELD:duns_number:EDIT1:LIKE(number):BestDunsCommon:BestDunsCurrent:BestDunsCurrent2:BestDunsVotedUnrestricted:FLAG:0,0
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
// DotID
// a contact name (or the absence of a contact) at a company name at a physical address.  Separate legal entities within an office will consist of //separate //Dots.
// Seleid
// 1. A legal entity at a physical address. (fuzzy matching to account for typos and different representations of same name)
// 2. has no more than 1 active charter for a given state (fuzzy matching to account for typos).  Now this should allow for charters from different states
//    to be ok, but not two charters in the same state.
// 3. has no more than 1 active Duns or LNCA lowest level ID.
// 4. Has no more than 1 status (active vs defunct).
// 5. Has no more than 1 legal name.
// 6. FEIN is sometimes useful for pulling records together, but won't be pushed to push records apart.
// 7. Unincorporated businesses will need more than just company name & address to bring them together into a Prox.  Address + contact is enough.
// Beyond Seleid
// 1. LNCA hierarchy
// 2. Duns hierarchy
// Business Relatives (outside of hierarchy - linkable from a report)
// TBD, but essentially any other connection we come across in this process but do not feel is strong enough for Seleid linking.