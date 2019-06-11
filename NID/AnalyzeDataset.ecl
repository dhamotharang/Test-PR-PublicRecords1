divide(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
	decimal8_2 x := (dividend*1000)/divisor;
	x1 := ROUND(x);
	decimal6_1 v := x1/10;	
	return v;	
END;
// 
decimal6_1 get_pct(INTEGER	dividend ,INTEGER	divisor)
  :=		
			MAP(
				divisor=0 => -1,
				divide(dividend, divisor)
			);

EXPORT AnalyzeDataset(DATASET(nid.Layout_Repository) result, unsigned samples=5000) :=
		PARALLEL(
			OUTPUT(CHOOSEN(result,samples), named('Sample'));
			OUTPUT(CHOOSEN(result(nametype='B'),samples), named('Business'));
			OUTPUT(CHOOSEN(result(nametype='P'),samples), named('Person'));
			OUTPUT(CHOOSEN(result(nametype='I'),samples), named('Invalid'));
			OUTPUT(CHOOSEN(result(nametype='T'),samples), named('Trust'));
			OUTPUT(CHOOSEN(result(nametype='U'),samples), named('Unclass'));
			OUTPUT(CHOOSEN(result(nametype='D'),samples), named('Dual'));
			OUTPUT(CHOOSEN(result(nametype=''),samples), named('Blank'));

			OUTPUT(COUNT(result),named('n_total'));
			OUTPUT(SORT(TABLE(result, {result.nametype,cnt := COUNT(GROUP),pct := get_pct(COUNT(GROUP),COUNT(result))}, 
											nametype, FEW),nametype),named('Types'))

	);