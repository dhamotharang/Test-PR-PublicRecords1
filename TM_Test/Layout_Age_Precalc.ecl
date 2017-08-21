export Layout_Age_Precalc := record
// From best file
unsigned6    did := 0;
qstring9     ssn := '';
integer4     dob := 0;               // date of birth YYYYMMDD
unsigned1    dob_age := 0;           // age calculated from best dob;
qstring8	 DOD := '';              // date of death YYYYMMDD
qstring15	 DL_number := '';
// From header records
unsigned3    dt_first_seen := 0;     // earliest date first seen from header YYYYMM
unsigned3    dt_first_seen_cb := 0;  // earliest date first seen from a credit bureau source in header YYYYMM
unsigned4    dob_cb := 0;            // eariliest dob from a credit bureau record
unsigned1    dob_age_cb := 0;        // age calculated from earliest dob from a credit bureau record
// From SSN Table
unsigned3    ssn_issue_date := 0;    // official first seen (date of issue) YYYYMM
unsigned3    ssn_dt_first_seen := 0; // date SSN first appears in header YYYYMM
integer4     ssn_decs_dod := 0;      // SSN deceased date of death YYYYMMDD
integer4     ssn_decs_dob := 0;      // SSN deceased dob YYYYMMDD
unsigned1    ssn_decs_dod_age := 0;  // age calculated at date of death
// From DL File
unsigned3    dl_dt_first_seen := 0;  // earliest date first seen YYYYMM
unsigned4    dl_issue_date := 0;     // earliest Drivers License issue date YYYYMMDD
unsigned4    dl_dob := 0;            // Current DL dob YYYYMMDD
unsigned1    dl_dob_age := 0;        // age calculated from current DL dob
// From Voters Reg File
unsigned4    vr_dt_first_seen := 0;  // earliest Voters Reg date first seen YYYYMMDD
unsigned4    vr_dob := 0  ;          // Current VR dob YYYYMMDD
unsigned1    vr_dob_age := 0;        // age calculated from current VR dob
unsigned4    vr_reg_date := 0;       // earliest Voters Reg registration date YYYYMMDD
// From Official Records - Marriages and Divorces
//unsigned4    ofr_doc_filed_dt := 0;   // earliest filing date for marriage or divorce official record
//unsigned4    ofr_dob := 0;            // earliest dob from marriage or divorce record
//unsigned1    ofr_dob_age := 0;        // age calculated from marriage or divorce record dob
//
// From pConsumer
unsigned3    pcn_dob := 0;               // date of birth YYYYMM
unsigned1    pcn_dob_age := 0;           // age caclulated from pConsumer date of birth
unsigned2    pcn_hh_arrival_date := 0;   // YYYY
unsigned3    pcn_refresh_date := 0;      // YYYYMM
unsigned3  	 pcn_hh_income := 0;         // 
string1  	 pcn_spouse_indicator := ''; // Y or N
// From American Student List
unsigned4    asl_dt_first_seen := 0;  // earliest American Student List date first seen YYYYMMDD
unsigned4    asl_dob := 0  ;          // Current American Student List dob YYYYMMDD
unsigned1    asl_dob_age := 0;        // age calculated from current American Student List dob
string2      asl_hs_class := '';      // High School Class code YY-year high school graduation or code
                                      // GR - graduate, UN - unknown, etc.
string2      asl_college_class := ''; // FR, SO, JR, SR, GR, UN
// From Infutor file
unsigned4    infu_dob := 0;           // earliest dob from Infutor file
unsigned1    infu_dob_age := 0;       // age calculated from Infutor dob
end;
