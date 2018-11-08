EXPORT Layouts := MODULE
  EXPORT LnpidToLnpidAssocRec := RECORD
    unsigned8 person_lnpid;
    string38 person_group_key;
    string38 assoc_group_key;
    unsigned8 assoc_lnpid;
    unsigned8 person_lexid;
    unsigned8 assoc_lexid;
    string20 relationship;
    unsigned4 assoc_count;
    unsigned4 bad_assoc_count;
    integer4 caf_addr_rank;
    string20 addr_key;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string8 sec_range;
    string25 v_city_name;
    string2 st;
    string5 zip;
    string50 person_name;
    string50 assoc_name;
    string1 hasactiveexclusion;
    string1 hasactiverevocation;
    string1 hasreinstatedexclusion;
    string1 hasreinstatedrevocation;
    string1 hasbackruptcy;
    string1 hascriminalhistory;
    string1 hasrelativeconvictions;
    string1 hasrelativebankruptcy;
    string1 hasdeceased;
    integer2 score;
	END;
END;