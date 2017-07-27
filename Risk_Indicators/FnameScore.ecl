// Takes in 2 first names and returns a first name score
import ut, NID;



export FnameScore(STRING20 l, STRING20 l2) := 
FUNCTION

sim := 100 - MAX(ut.StringSimilar100(l, l2),ut.StringSimilar100(l2, l));

l_trim := TRIM(l);
l2_trim := TRIM(l2);

l_size := LENGTH(l_trim);
l2_size := LENGTH(l2_trim);

smaller := IF(l_size<=l2_size,l_trim,l2_trim);
larger := IF(smaller=l,l2_trim,l_trim);

pSmaller := NID.PreferredFirstNew(smaller);
pLarger := NID.PreferredFirstNew(larger);

m := 
MAP(l='' OR l2=''										=> 255,
    sim >= 80 											=> sim,
    pSmaller=pLarger									=> 90,	// Dan=Daniel
    metaphonelib.DMetaphone1(l)=metaphonelib.DMetaphone1(l2) 	=> 85,	// Dan=Dann
    (l_size=1 and l_trim<>l2_trim[1]) or (l2_size=1 and l_trim[1]<>l2_trim)	=> 10,	// don't let JACKSON and C score an 80 below
    Stringlib.StringFind(larger,smaller,1)>0					=> 80,	// D=Daniel
    Stringlib.StringFind(pLarger,pSmaller,1)>0				=> 80,	// C=Kat
													sim);
												
RETURN m;
END;