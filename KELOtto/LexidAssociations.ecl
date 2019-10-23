  IMPORT Relationship;
  
  EXPORT LexidAssociations := PROJECT(PULL(Relationship.key_relatives_v3), 
                                TRANSFORM(  
                                  {
                                    UNSIGNED2 fdn_file_info_id := 999;
                                    UNSIGNED4 FromPerson := LEFT.did1;
                                    UNSIGNED4 ToPerson := LEFT.did2;
                                    integer1 publicrecords := 1;
                                    string15 type;
                                    string10 confidence;
                                    integer2 lname_score;
                                    integer2 phone_score;
                                    integer2 dl_nbr_score;
                                    unsigned2 total_cnt;
                                    integer2 total_score;
                                    string10 cluster;
                                    string2 generation;
                                    string1 gender;
                                    unsigned4 lname_cnt;
                                    unsigned4 rel_dt_first_seen;
                                    unsigned4 rel_dt_last_seen;
                                    unsigned2 overlap_months;
                                    unsigned4 hdr_dt_first_seen;
                                    unsigned4 hdr_dt_last_seen;
                                    unsigned2 age_first_seen;
                                    boolean isanylnamematch;
                                    boolean isanyphonematch;
                                    boolean isearlylnamematch;
                                    boolean iscurrlnamematch;
                                    boolean ismixedlnamematch;
                                    string9 ssn1;
                                    string9 ssn2;
                                    unsigned4 dob1;
                                    unsigned4 dob2;
                                    string28 current_lname1;
                                    string28 current_lname2;
                                    string28 early_lname1;
                                    string28 early_lname2;
                                    string2 addr_ind1;
                                    string2 addr_ind2;
                                    unsigned6 r2rdid;
                                    unsigned6 r2cnt;
                                    boolean personal;
                                    boolean business;
                                    boolean other;
                                    unsigned1 title;
                                 }, 
                                 SELF.FromPerson := LEFT.did1,
                                 SELF.ToPerson := LEFT.did2,
                                 SELF := LEFT));

