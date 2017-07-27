// Takes in 2 last names and returns a last name score
import ut;



export LnameScore(STRING20 l, STRING20 l2) := 
FUNCTION

sim := 100 - MAX(ut.StringSimilar100(l, l2), ut.StringSimilar100(l2, l));

l_trim := TRIM(l);
l2_trim := TRIM(l2);

l_size := LENGTH(l_trim);
l2_size := LENGTH(l2_trim);

smaller := IF(l_size<=l2_size,l_trim,l2_trim);
larger := IF(smaller=l,l2_trim,l_trim);

m := 
MAP(l='' OR l2=''										=> 255,
    sim >= 80 											=> sim,
    metaphonelib.DMetaphone1(l)=metaphonelib.DMetaphone1(l2) 	=> 85, 
    l_size=1 or l2_size=1	=> 10,	// don't let 1 byte input match per deb geister 
    Stringlib.StringFind(larger,smaller,1)>0					=> 80,
    l<>'' and l2<> '' and sim=0							=> 10,
													sim);
												
RETURN m;
END;