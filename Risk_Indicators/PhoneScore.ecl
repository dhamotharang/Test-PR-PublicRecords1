// Takes in 2 phones and returns a phone score
import ut;

export PhoneScore(STRING10 p, STRING10 p2) := 
FUNCTION

p_clean := (STRING)(INTEGER)p;
p2_clean := (STRING)(INTEGER)p2;

dp1 := LENGTH(TRIM(p_clean,ALL));
dp2 := LENGTH(TRIM(p2_clean,ALL));

STRING dp1_7 := IF(dp1<>10,p_clean,p_clean[4..10]);
STRING dp2_7 := IF(dp2<>10,p2_clean,p2_clean[4..10]);

STRING dp1_7_np := IF(dp1<>10,p_clean,p_clean[1..7]);
STRING dp2_7_np := IF(dp2<>10,p2_clean,p2_clean[1..7]);

boolean np := dp1=7 or dp2=7;

STRING dp1_3 := IF(dp1<>10,'',p_clean[1..3]);
STRING dp2_3 := IF(dp2<>10,'',p2_clean[1..3]);



m := 
MAP(p='' OR p2=''						=> 255,
	dp1_7=dp2_7 AND dp1_3=dp2_3			=> 100,
	dp1_7=dp2_7 AND ut.NNEQ(dp1_3,dp2_3)	=> 95,
	dp1_7_np=dp2_7_np and np				=> 95,
	dp1_7=dp2_7						=> 90,
	100-MAX(ut.StringSimilar100(p_clean,p2_clean), ut.StringSimilar100(p2_clean,p_clean)));

RETURN m;
									 
END;