	
export Fn_Fuzzy_Specificity(unsigned spec1,real8 cnt1, unsigned gcnt1,unsigned spec2,real8 cnt2, unsigned gcnt2) :=
			(spec1 + 100*log(cnt1/gcnt2)/log(2)) * cnt1 / (cnt1+cnt2) +
			(spec2 + 100*log(cnt2/gcnt1)/log(2)) * cnt2 / (cnt1+cnt2);
