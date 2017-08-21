/*
  Given gh4 and gh8 weights of a geo point, and radius of a match, calculate score of that match.
https://en.wikipedia.org/wiki/Geohash:
geohash length  km error  mi error
4                +-20     24.8
5                +-2.4    3
6                +-0.61   0.75
7                +-0.076  0.1
gh5 = 40% of gh4-gh8 waight range
gh6 = 70%
gh7 = 90%
*/
EXPORT Fn_LL_DistanceScore_EL(UNSIGNED2 gh4_weight100, UNSIGNED2 gh8_weight100, REAL radius) := FUNCTION
	REAL scale := MAP(radius<=0.1=>0.9 /* gh7 */,radius<=0.75=>0.7/* gh6 */,radius<=3=>0.4 /* gh5 */,0);
	RETURN (UNSIGNED2)(gh4_weight100 + scale*(gh8_weight100-gh4_weight100));
END;
