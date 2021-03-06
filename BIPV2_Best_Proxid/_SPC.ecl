OPTIONS:-gh -ga
MODULE:BIPV2_Best_Proxid
FILENAME:Base
// Uncomment up to NINES for internal or external adl
IDFIELD:EXISTS:Proxid
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
BESTTYPE:BestCompanyNameLegal:BASIS(Proxid):VOTED(fn_Best_Name_Legal_Votes):FUZZY:VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameCommon:BASIS(Proxid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameCurrent:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:MINIMUM(2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameVoted:BASIS(Proxid):VOTED(fn_Best_Name_Source_Votes,2):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameLength:BASIS(Proxid):LONGEST:FUZZY:VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameStrong:BASIS(Proxid):UNIQUE:FUZZY:VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameCurrent2:BASIS(Proxid):RECENT(dt_last_seen):VALID(fn_valid_cname):EXTEND
BESTTYPE:BestCompanyNameVotedUnrestricted:BASIS(Proxid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_cname):EXTEND
//Address
BESTTYPE:BestCompanyAddressVoted:BASIS(Proxid):VOTED(fn_Best_Address_Fields_Votes,2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressCurrent:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:MINIMUM(2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressVotedSrc:BASIS(Proxid):VOTED(fn_Best_Address_Source_Votes,2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressCommon:BASIS(Proxid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressLength:BASIS(Proxid):LONGEST:FUZZY:VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressStrong:BASIS(Proxid):UNIQUE:FUZZY:VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestSecRange:BASIS(Proxid:company_prim_range:company_prim_name:company_zip5):COMMONEST:FUZZY:EXTEND
BESTTYPE:BestCompanyAddressCurrent2:BASIS(Proxid):RECENT(dt_last_seen):VALID(fn_valid_caddress):EXTEND
BESTTYPE:BestCompanyAddressVotedUnrestricted:BASIS(Proxid):VOTED(fn_Best_Source_Unrestricted_Votes,2):FUZZY:VALID(fn_valid_caddress):EXTEND
//Phone
BESTTYPE:BestPhoneCurrentWithNpa:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_cphone10):EXTEND
BESTTYPE:BestPhoneCurrent:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneVoted:BASIS(Proxid):VOTED(fn_Best_Phone_Votes,2):FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneLongest:BASIS(Proxid):LONGEST:FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneStrong:BASIS(Proxid):UNIQUE:FUZZY:VALID(fn_valid_cphone7):EXTEND
BESTTYPE:BestPhoneVotedUnrestricted:BASIS(Proxid):VOTED(fn_Best_Source_Unrestricted_Votes,2):FUZZY:VALID(fn_valid_cphone10):EXTEND
BESTTYPE:BestPhoneCommon:BASIS(Proxid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_cphone10):EXTEND
//TIN
BESTTYPE:BestFeinStrong:BASIS(Proxid):UNIQUE:FUZZY:VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinCommon:BASIS(Proxid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinCurrent:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinVotedUnrestricted:BASIS(Proxid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinMin:BASIS(Proxid):VOTED(fn_Best_Fein_Votes_Min,2):FUZZY:VALID(fn_valid_cfein):EXTEND
BESTTYPE:BestFeinMax:BASIS(Proxid):VOTED(fn_Best_Fein_Votes_Max,2):FUZZY:VALID(fn_valid_cfein):EXTEND
//BESTTYPE:BestFeinVoted:BASIS(Proxid):VOTED(BestFeinVotes,2):FUZZY:VALID(fn_valid_cfein):PROP
//URL
BESTTYPE:BestUrlCommon:BASIS(Proxid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlCurrent:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlLength:BASIS(Proxid):LONGEST:FUZZY:VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlStrong:BASIS(Proxid):UNIQUE:FUZZY:VALID(fn_valid_curl):EXTEND
BESTTYPE:BestUrlVotedUnrestricted:BASIS(Proxid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_curl):EXTEND
//DUN_NUMBER
BESTTYPE:BestDunsCommon:BASIS(Proxid):COMMONEST:FUZZY:MINIMUM(2):VALID(fn_valid_duns):EXTEND
BESTTYPE:BestDunsCurrent:BASIS(Proxid):RECENT(dt_last_seen):FUZZY:MINIMUM(2):VALID(fn_valid_duns):EXTEND
BESTTYPE:BestDunsCurrent2:BASIS(Proxid):RECENT(dt_last_seen):VALID(fn_valid_duns):EXTEND
BESTTYPE:BestDunsVotedUnrestricted:BASIS(Proxid):VOTED(fn_Best_Source_Unrestricted_Votes,2):VALID(fn_valid_duns):EXTEND
// FUZZY can be used to create new types of FUZZY linking
FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)
FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)
// ------------------------------------
//  1. Company fields
// ------------------------------------
//FIELD:company_name:LIKE(cname):EDIT1:BestCompanyNameLegal:BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:FLAG:19,137
//FIELD:company_name:LIKE(cname):BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:FLAG:19,137
FIELD:company_name:LIKE(cname):BestCompanyNameLegal:BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:BestCompanyNameStrong:BestCompanyNameCurrent2:BestCompanyNameVotedUnrestricted:FLAG:26,373
//FIELD:cnp_name:LIKE(cname):0,0
//FIELD:cnp_number:LIKE(alpha):0, 0
//FIELD:cnp_btype:LIKE(alpha):0,0
//FIELD:cnp_lowv:LIKE(alpha):0,0
//CONCEPT:company_name_clean:LIKE(cname):EDIT2:BestCompanyNameCommon:BestCompanyNameCurrent:BestCompanyNameVoted:BestCompanyNameLength:BestCompanyNameStrong:BestCompanyNameCurrent2:BestCompanyNameVotedUnrestricted:FLAG:25,360
FIELD:company_fein:LIKE(number):right4:EDIT1:BestFeinStrong:BestFeinCommon:BestFeinCurrent:BestFeinVotedUnrestricted:BestFeinMin:BestFeinMax:OWNED:FLAG:26,106
FIELD:company_phone:LIKE(number):EDIT1:BestPhoneCurrentWithNpa:BestPhoneCurrent:BestPhoneVoted:BestPhoneLongest:BestPhoneStrong:BestPhoneVotedUnrestricted:BestPhoneCommon:FLAG:26,275
FIELD:company_url:BestUrlCommon:BestUrlCurrent:BestUrlLength:BestUrlStrong:BestUrlVotedUnrestricted:FLAG:27,17
// ------------------------------------
//  2. company Address fields
// ------------------------------------
FIELD:prim_range:13,0
FIELD:predir:5,8
FIELD:prim_name:15,0
FIELD:addr_suffix:4,2
FIELD:postdir:7,11
FIELD:unit_desig:5,37
FIELD:sec_range:FORCE(--):12,112
FIELD:p_city_name:12,32
FIELD:v_city_name:11,10
FIELD:st:LIKE(alpha):5,0
FIELD:zip:LIKE(number):14,6
FIELD:zip4:LIKE(number):13,62
FIELD:fips_state:LIKE(number):5,0
FIELD:fips_county:LIKE(number):7,44
CONCEPT:address:prim_range:predir:prim_name:addr_suffix:postdir:unit_desig:sec_range:st:zip:BestCompanyAddressVoted:BestCompanyAddressCurrent:BestCompanyAddressVotedSrc:BestCompanyAddressCommon:BestCompanyAddressStrong:BestCompanyAddressCurrent2:BestCompanyAddressVotedUnrestricted:FLAG:25,113
FIELD:duns_number:EDIT1:LIKE(number):BestDunsCommon:BestDunsCurrent:BestDunsCurrent2:BestDunsVotedUnrestricted:FLAG:0,0
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
// DotID
// a contact name (or the absence of a contact) at a company name at a physical address.  Separate legal entities within an office will consist of //separate //Dots.
// ProxID
// 1. A legal entity at a physical address. (fuzzy matching to account for typos and different representations of same name)
// 2. has no more than 1 active charter for a given state (fuzzy matching to account for typos).  Now this should allow for charters from different states
//    to be ok, but not two charters in the same state.
// 3. has no more than 1 active Duns or LNCA lowest level ID.
// 4. Has no more than 1 status (active vs defunct).
// 5. Has no more than 1 legal name.
// 6. FEIN is sometimes useful for pulling records together, but won't be pushed to push records apart.
// 7. Unincorporated businesses will need more than just company name & address to bring them together into a Prox.  Address + contact is enough.
// Beyond ProxID
// 1. LNCA hierarchy
// 2. Duns hierarchy
// Business Relatives (outside of hierarchy - linkable from a report)
// TBD, but essentially any other connection we come across in this process but do not feel is strong enough for ProxID linking.
//SeleID
// 1.   It is the Smallest Encapsulating Legal Entity.
// 2.   Scenario 1: if I am a branch location of Arby??????s, my SELE is the corporate office I report to.
// 3.   Scenario 2: if I am a Subsidiary of Reed Elsevier, I am my own SELE.
// 4    The SELEID above ProxidID and below Org and Ult.