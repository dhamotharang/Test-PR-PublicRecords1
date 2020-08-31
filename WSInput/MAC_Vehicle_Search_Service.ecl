EXPORT MAC_Vehicle_Search_Service() := MACRO
IMPORT WSInput;

WSInput.MAC_Vehicle_Tag_Types_Help_Text();

#WEBSERVICE(FIELDS(
    //nested sections
        'motorvehiclesearch2request','gateways',
    //single line text fields
        '_batchjobid','_batchspecid','_queryid','_transactionid',
        'billingcode','asisname',
        'addr','addressorigin','datasource','datefirstseen','datelastseen',
        'agehigh','agelow','deathmasterpurpose','democustomername','dialrecordmatch',
        'anyword1','anyword2','intendeduse','iterationkey',
        'datapermissionmask','datarestrictionmask',
        'applicationtype','dlmask','ssnmask','dppapurpose','glbpurpose','industryclass',
        'bdid','did','didtypemask','dl_number','cn',
        'prim_range','primrange','prim_name','primname','street_name','suffix',
        'sec_range','secrange','city',
        'postdir','postalcode','county','st','st_orig','state','statecityzip','z5','zip','zipradius',
        'fuzzysecrange','othercity1','predir',
        'otherstate1','otherstate2','company','companyname','corpname','lookuptype',
        'dob','ssn','driverslicense','tag','titleissuedate','titlenumber','vehiclekey','vin',
        'year','distancethreshold','penaltthreshold','saltleadthreshold','scorethreshold',
        'entity2_addr','entity2_bdid','entity2_city','entity2_companyname','entity2_did',
        'entity2_firstname','entity2_middlename','entity2_lastname','entity2_ssn','entity2_state',
        'entity2_unparsedfullname','entity2_zip','entity2_zipradius','entrp_month_value',
        'fein','nameasis','namesuffix','rid','sequencekey','setrepaddrbit',
        'firstname','fname3','middlename','lfmname','lname','lname4','lastname','otherlastname1',
        'unparsedfullname','firstword','partytype','phone',
        'lexidsourceoptout','queryid','recordbydate',
        'make','model','mileradius','maxresults','maxresultsthistime','returncount','skiprecords',
        'previoustitleissuedate','realtimepermissibleuse','referencecode','registrationtype',
        'relationship_rellookbackmonths','relationship_transassocmask','relativefirstname1',
        'relativefirstname2','seisintadlservice','startingrecord','subcustomerid',
    //boolean options
        '_blind','allowall','allowdppa','allowglb','allowheaderquick',
        'allowdateseen','allowfuzzydobmatch','allowleadinglname','allownicknames',
        'allowusecnkey','allowwildcard','checknamevariants','cleanfmlname',
        'authenticationusage','blind','bpsleadingnamematch','currentresidentsonly',
        'docombined','donotfillblanks','excludedmvpii','excludelessors',
        'household','insuranceusage','iscrs','isprp','lnbranded',
        'includecriminalindicators','includedevelopedvehicles','includeminors',
        'includenonregulatedvehiclesources','nodeepdive','nonexclusion','onlyexactmatches',
        'keepoldssns','moxievehicles','multifamilydwelling','performgatewaydisallowedstatechecks',
        'phoneticdistancematch','phoneticmatch','probationoverride','raw',
        'reduceddata','relationship_highconfidenceassociatesrelationship_highconfidencerelatives',
        'searcharoundaddress','searchgoodssnonly','setrepaddr','simplifiedcontactreturn',
        'ssntypos','strictmatch','suppressnonmarketingdeathsources','twopartysearch',
        'useonlybestdid','usessnfallback','usetagblur','usingkeepssns',
    //datasets / sets / multiline text fields
        'sortbytagtypes'
),HELP(help_text));

ENDMACRO;