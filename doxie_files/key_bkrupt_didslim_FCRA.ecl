//WARNING: THIS KEY IS AN FCRA KEY...
import bankrupt, Doxie;

slim_f := table (bankrupt.File_BK_Search,{debtor_did,court_code,case_number});

f := distributed(slim_f((unsigned)debtor_did != 0),hash(debtor_did));

sort_f := sort(f,debtor_did,court_code,case_number);

dedp_f := dedup(sort_f,all);

//old name: '~thor_Data400::key::bankrupt_didslim_' + doxie.Version_SuperKey
export key_bkrupt_didslim_FCRA := index (dedp_f,{unsigned6 s_did := (unsigned)debtor_did},
                                         {court_code, case_number}, 
                                         '~thor_Data400::key::bankrupt::fcra::didslim_' + doxie.Version_SuperKey);
