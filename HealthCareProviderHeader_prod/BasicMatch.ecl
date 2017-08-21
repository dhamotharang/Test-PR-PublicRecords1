IMPORT SALT27,ut;
EXPORT BasicMatch(DATASET(layout_HealthProvider) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates

SHARED  h00 := Specificities(ih).input_file;
MatchCands := JOIN(h00,Specificities(ih).ClusterSizes(InCluster=1),LEFT.LNPID=RIGHT.LNPID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
Rec := RECORD
SALT27.UIDType LNPID1;
SALT27.UIDType LNPID2;
END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
h01 := SORT(h00,DOB_year,DOB_month,DOB_day,SNAME,FNAME,MNAME,LNAME,GENDER,LIC_NBR,PRIM_NAME,PRIM_RANGE,SEC_RANGE,V_CITY_NAME,ST,ZIP,NPI_NUMBER,DEA_NUMBER,VENDOR_ID,TAX_ID,DID,UPIN,LAT_LONG,LNPID);
h02 := DEDUP(h01,DOB_year,DOB_month,DOB_day,SNAME,FNAME,MNAME,LNAME,GENDER,LIC_NBR,PRIM_NAME,PRIM_RANGE,SEC_RANGE,V_CITY_NAME,ST,ZIP,NPI_NUMBER,DEA_NUMBER,VENDOR_ID,TAX_ID,DID,UPIN,LAT_LONG,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
Match := JOIN(h02,MatchCands,LEFT.DOB_year = RIGHT.DOB_year and LEFT.DOB_month = RIGHT.DOB_month and LEFT.DOB_day = RIGHT.DOB_day AND LEFT.SNAME = RIGHT.SNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME AND LEFT.LNAME = RIGHT.LNAME
AND LEFT.GENDER = RIGHT.GENDER AND LEFT.LIC_NBR = RIGHT.LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.SEC_RANGE = RIGHT.SEC_RANGE
AND LEFT.V_CITY_NAME = RIGHT.V_CITY_NAME AND LEFT.ST = RIGHT.ST AND LEFT.ZIP = RIGHT.ZIP AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER
AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.TAX_ID = RIGHT.TAX_ID AND LEFT.DID = RIGHT.DID AND LEFT.UPIN = RIGHT.UPIN AND LEFT.LAT_LONG = RIGHT.LAT_LONG AND LEFT.LNPID < RIGHT.LNPID,TRANSFORM(Rec,SELF.LNPID2 := LEFT.LNPID,SELF.LNPID1 := RIGHT.LNPID));
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(LNPID1) ), LNPID1, LNPID2, LOCAL), LNPID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
ut.MAC_Patch_Id(h00,LNPID,PickOne,LNPID1,LNPID2,o1); // Patch the input file
EXPORT input_file := o1;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,LNPID,ALL))-COUNT(DEDUP(input_file,LNPID,ALL)); // Should equal basic_match_count
END;
