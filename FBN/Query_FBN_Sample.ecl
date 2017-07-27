// Query to select sample records from FBN
Layout_FBN_Sample := RECORD
STRING2  file_st;
STRING15 location_cd;
STRING20 filing_num;
STRING8  filing_dt;
STRING6  contrib_no;
STRING1  name_cd;
STRING1  name_typ;
STRING50 display_name;
END;

Layout_FBN_Sample InitFBN(FBN.Layout_FBN L) := TRANSFORM
SELF := L;
END;


FBN_Init := PROJECT(FBN.File_FBN, InitFBN(LEFT));

Layout_FBN_Stat := RECORD
FBN_Init.file_st;
FBN_Init.location_cd;
FBN_Init.filing_num;
FBN_Init.filing_dt;
INTEGER4 reccnt := COUNT(GROUP);
END;

FBN_Stat := TABLE(FBN_Init, Layout_FBN_Stat, file_st, location_cd, filing_num, filing_dt);

// Join to select FBN groups with only 1 record
Layout_FBN_Sample SelectFBNGroups(Layout_FBN_Sample L, Layout_FBN_Stat R) := TRANSFORM
SELF := L;
END;

FBN_Singles := JOIN(FBN_Init,
                    FBN_Stat(reccnt = 1),
                    LEFT.file_st = RIGHT.file_st AND
                      LEFT.location_cd = RIGHT.location_cd AND
                      LEFT.filing_num = RIGHT.filing_num AND
                      LEFT.filing_dt = RIGHT.filing_dt,
                    SelectFBNGroups(LEFT, RIGHT),
                    LOOKUP);

FBN_Remainder := JOIN(FBN_Init,
                      FBN_Stat(reccnt = 1),
                      LEFT.file_st = RIGHT.file_st AND
                        LEFT.location_cd = RIGHT.location_cd AND
                        LEFT.filing_num = RIGHT.filing_num AND
                        LEFT.filing_dt = RIGHT.filing_dt,
                      SelectFBNGroups(LEFT, RIGHT),
                      LEFT ONLY,
                      LOOKUP);

// Now select Random Samples from each state
FBN_AL := ENTH(FBN_Remainder(file_st='AL'), 20);
FBN_AK := ENTH(FBN_Remainder(file_st='AK'), 20);
FBN_AZ := ENTH(FBN_Remainder(file_st='AZ'), 20);
FBN_AR := ENTH(FBN_Remainder(file_st='AR'), 20);
FBN_CA := ENTH(FBN_Remainder(file_st='CA'), 20);
FBN_CO := ENTH(FBN_Remainder(file_st='CO'), 20);
FBN_CT := ENTH(FBN_Remainder(file_st='CT'), 20);
FBN_DE := ENTH(FBN_Remainder(file_st='DE'), 20);
FBN_DC := ENTH(FBN_Remainder(file_st='DC'), 20);
FBN_FL := ENTH(FBN_Remainder(file_st='FL'), 20);
FBN_GA := ENTH(FBN_Remainder(file_st='GA'), 20);
FBN_HI := ENTH(FBN_Remainder(file_st='HI'), 20);
FBN_ID := ENTH(FBN_Remainder(file_st='ID'), 20);
FBN_IL := ENTH(FBN_Remainder(file_st='IL'), 20);
FBN_IN := ENTH(FBN_Remainder(file_st='IN'), 20);
FBN_IA := ENTH(FBN_Remainder(file_st='IA'), 20);
FBN_KS := ENTH(FBN_Remainder(file_st='KS'), 20);
FBN_KY := ENTH(FBN_Remainder(file_st='KY'), 20);
FBN_LA := ENTH(FBN_Remainder(file_st='LA'), 20);
FBN_ME := ENTH(FBN_Remainder(file_st='ME'), 20);
FBN_MD := ENTH(FBN_Remainder(file_st='MD'), 20);
FBN_MA := ENTH(FBN_Remainder(file_st='MA'), 20);
FBN_MI := ENTH(FBN_Remainder(file_st='MI'), 20);
FBN_MN := ENTH(FBN_Remainder(file_st='MN'), 20);
FBN_MS := ENTH(FBN_Remainder(file_st='MS'), 20);
FBN_MO := ENTH(FBN_Remainder(file_st='MO'), 20);
FBN_MT := ENTH(FBN_Remainder(file_st='MT'), 20);
FBN_NE := ENTH(FBN_Remainder(file_st='NE'), 20);
FBN_NV := ENTH(FBN_Remainder(file_st='NV'), 20);
FBN_NH := ENTH(FBN_Remainder(file_st='NH'), 20);
FBN_NJ := ENTH(FBN_Remainder(file_st='NJ'), 20);
FBN_NM := ENTH(FBN_Remainder(file_st='NM'), 20);
FBN_NY := ENTH(FBN_Remainder(file_st='NY'), 20);
FBN_NC := ENTH(FBN_Remainder(file_st='NC'), 20);
FBN_ND := ENTH(FBN_Remainder(file_st='ND'), 20);
FBN_OH := ENTH(FBN_Remainder(file_st='OH'), 20);
FBN_OK := ENTH(FBN_Remainder(file_st='OK'), 20);
FBN_OR := ENTH(FBN_Remainder(file_st='OR'), 20);
FBN_PA := ENTH(FBN_Remainder(file_st='PA'), 20);
FBN_RI := ENTH(FBN_Remainder(file_st='RI'), 20);
FBN_SC := ENTH(FBN_Remainder(file_st='SC'), 20);
FBN_SD := ENTH(FBN_Remainder(file_st='SD'), 20);
FBN_TN := ENTH(FBN_Remainder(file_st='TN'), 20);
FBN_TX := ENTH(FBN_Remainder(file_st='TX'), 20);
FBN_UT := ENTH(FBN_Remainder(file_st='UT'), 20);
FBN_VT := ENTH(FBN_Remainder(file_st='VT'), 20);
FBN_VA := ENTH(FBN_Remainder(file_st='VA'), 20);
FBN_WA := ENTH(FBN_Remainder(file_st='WA'), 20);
FBN_WV := ENTH(FBN_Remainder(file_st='WV'), 20);
FBN_WI := ENTH(FBN_Remainder(file_st='WI'), 20);
FBN_WY := ENTH(FBN_Remainder(file_st='WY'), 20);

FBN_Sample_1 := FBN_AL+
FBN_AK+
FBN_AZ+
FBN_AR+
FBN_CA+
FBN_CO+
FBN_CT+
FBN_DE+
FBN_DC+
FBN_FL+
FBN_GA+
FBN_HI+
FBN_ID+
FBN_IL+
FBN_IN+
FBN_IA+
FBN_KS+
FBN_KY+
FBN_LA+
FBN_ME+
FBN_MD+
FBN_MA+
FBN_MI+
FBN_MN+
FBN_MS+
FBN_MO+
FBN_MT+
FBN_NE+
FBN_NV+
FBN_NH+
FBN_NJ+
FBN_NM+
FBN_NY+
FBN_NC+
FBN_ND+
FBN_OH+
FBN_OK+
FBN_OR+
FBN_PA+
FBN_RI+
FBN_SC+
FBN_SD+
FBN_TN+
FBN_TX+
FBN_UT+
FBN_VT+
FBN_VA+
FBN_WA+
FBN_WV+
FBN_WI+
FBN_WY;

FBNS_AL := ENTH(FBN_Singles(file_st='AL'), 10);
FBNS_AK := ENTH(FBN_Singles(file_st='AK'), 10);
FBNS_AZ := ENTH(FBN_Singles(file_st='AZ'), 10);
FBNS_AR := ENTH(FBN_Singles(file_st='AR'), 10);
FBNS_CA := ENTH(FBN_Singles(file_st='CA'), 10);
FBNS_CO := ENTH(FBN_Singles(file_st='CO'), 10);
FBNS_CT := ENTH(FBN_Singles(file_st='CT'), 10);
FBNS_DE := ENTH(FBN_Singles(file_st='DE'), 10);
FBNS_DC := ENTH(FBN_Singles(file_st='DC'), 10);
FBNS_FL := ENTH(FBN_Singles(file_st='FL'), 10);
FBNS_GA := ENTH(FBN_Singles(file_st='GA'), 10);
FBNS_HI := ENTH(FBN_Singles(file_st='HI'), 10);
FBNS_ID := ENTH(FBN_Singles(file_st='ID'), 10);
FBNS_IL := ENTH(FBN_Singles(file_st='IL'), 10);
FBNS_IN := ENTH(FBN_Singles(file_st='IN'), 10);
FBNS_IA := ENTH(FBN_Singles(file_st='IA'), 10);
FBNS_KS := ENTH(FBN_Singles(file_st='KS'), 10);
FBNS_KY := ENTH(FBN_Singles(file_st='KY'), 10);
FBNS_LA := ENTH(FBN_Singles(file_st='LA'), 10);
FBNS_ME := ENTH(FBN_Singles(file_st='ME'), 10);
FBNS_MD := ENTH(FBN_Singles(file_st='MD'), 10);
FBNS_MA := ENTH(FBN_Singles(file_st='MA'), 10);
FBNS_MI := ENTH(FBN_Singles(file_st='MI'), 10);
FBNS_MN := ENTH(FBN_Singles(file_st='MN'), 10);
FBNS_MS := ENTH(FBN_Singles(file_st='MS'), 10);
FBNS_MO := ENTH(FBN_Singles(file_st='MO'), 10);
FBNS_MT := ENTH(FBN_Singles(file_st='MT'), 10);
FBNS_NE := ENTH(FBN_Singles(file_st='NE'), 10);
FBNS_NV := ENTH(FBN_Singles(file_st='NV'), 10);
FBNS_NH := ENTH(FBN_Singles(file_st='NH'), 10);
FBNS_NJ := ENTH(FBN_Singles(file_st='NJ'), 10);
FBNS_NM := ENTH(FBN_Singles(file_st='NM'), 10);
FBNS_NY := ENTH(FBN_Singles(file_st='NY'), 10);
FBNS_NC := ENTH(FBN_Singles(file_st='NC'), 10);
FBNS_ND := ENTH(FBN_Singles(file_st='ND'), 10);
FBNS_OH := ENTH(FBN_Singles(file_st='OH'), 10);
FBNS_OK := ENTH(FBN_Singles(file_st='OK'), 10);
FBNs_OR := ENTH(FBN_Singles(file_st='OR'), 10);
FBNS_PA := ENTH(FBN_Singles(file_st='PA'), 10);
FBNS_RI := ENTH(FBN_Singles(file_st='RI'), 10);
FBNS_SC := ENTH(FBN_Singles(file_st='SC'), 10);
FBNS_SD := ENTH(FBN_Singles(file_st='SD'), 10);
FBNS_TN := ENTH(FBN_Singles(file_st='TN'), 10);
FBNS_TX := ENTH(FBN_Singles(file_st='TX'), 10);
FBNS_UT := ENTH(FBN_Singles(file_st='UT'), 10);
FBNS_VT := ENTH(FBN_Singles(file_st='VT'), 10);
FBNS_VA := ENTH(FBN_Singles(file_st='VA'), 10);
FBNS_WA := ENTH(FBN_Singles(file_st='WA'), 10);
FBNS_WV := ENTH(FBN_Singles(file_st='WV'), 10);
FBNS_WI := ENTH(FBN_Singles(file_st='WI'), 10);
FBNS_WY := ENTH(FBN_Singles(file_st='WY'), 10);

FBN_Sample_2 := FBNS_AL+
FBNS_AK+
FBNS_AZ+
FBNS_AR+
FBNS_CA+
FBNS_CO+
FBNS_CT+
FBNS_DE+
FBNS_DC+
FBNS_FL+
FBNS_GA+
FBNS_HI+
FBNS_ID+
FBNS_IL+
FBNS_IN+
FBNS_IA+
FBNS_KS+
FBNS_KY+
FBNS_LA+
FBNS_ME+
FBNS_MD+
FBNS_MA+
FBNS_MI+
FBNS_MN+
FBNS_MS+
FBNS_MO+
FBNS_MT+
FBNS_NE+
FBNS_NV+
FBNS_NH+
FBNS_NJ+
FBNS_NM+
FBNS_NY+
FBNS_NC+
FBNS_ND+
FBNS_OH+
FBNS_OK+
FBNS_OR+
FBNS_PA+
FBNS_RI+
FBNS_SC+
FBNS_SD+
FBNS_TN+
FBNS_TX+
FBNS_UT+
FBNS_VT+
FBNS_VA+
FBNS_WA+
FBNS_WV+
FBNS_WI+
FBNS_WY;

OUTPUT(CHOOSEN(FBN_Sample_1, 0));
OUTPUT(CHOOSEN(FBN_Sample_2, 0));