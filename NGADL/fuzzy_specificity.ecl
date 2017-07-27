/*	unsigned all_cnt := sum(group,%aj%.count2);
	unsigned e1_cnt := sum(group,if(%aj%.distance<=1,%aj%.count2,0));
	unsigned e2_cnt := sum(group,if(%aj%.distance<=2,%aj%.count2,0));
	unsigned e1p_cnt := sum(group,if(%aj%.distance<=1 and %aj%.phonetic,%aj%.count2,0));
	unsigned e2p_cnt := sum(group,if(%aj%.distance<=2 and %aj%.phonetic,%aj%.count2,0));
	unsigned p_cnt := sum(group,if(%aj%.phonetic,%aj%.count2,0));
export fuzzy_specificity(string f1,unsigned spec1,unsigned cnt1,unsigned all_cnt1,unsigned e1_cnt1,unsigned e2_cnt1,unsigned e1p_cnt,unsigned e2p_cnt1,unsigned p_cnt1,
                         string f2,unsigned spec2,unsigned cnt2,unsigned all_cnt2,unsigned e1_cnt2,unsigned e2_cnt2,unsigned e1p_cnt2,unsigned e2p_cnt2,unsigned p_cnt2) := 
       MAP ( f1 = f2 => spec1, // The simple case
			       metaphonelib.dmetaphone1(f1) = metaphonelib.dmetaphone1(f2) and ut.StringSimilar(f1,f2)>2 => mergenum(spec1,cnt1,p_cnt1,spec2,cnt2,p_cnt2),
						 metaphonelib.dmetaphone1(f1) = metaphonelib.dmetaphone1(f2) and ut.StringSimilar(f1,f2)=2 => mergenum(spec1,cnt1,e2p_cnt1,spec2,cnt2,e2p_cnt2),
 						 metaphonelib.dmetaphone1(f1) = metaphonelib.dmetaphone1(f2) => mergenum(spec1,cnt1,e1p_cnt1,spec2,cnt2,e1p_cnt2),
						 ut.St

	*/
	
export fuzzy_specificity(unsigned spec1,real8 cnt1, unsigned gcnt1,unsigned spec2,real8 cnt2, unsigned gcnt2) :=
			(spec1 + log(cnt1/gcnt2)/log(2)) * cnt1 / (cnt1+cnt2) +
			(spec2 + log(cnt2/gcnt1)/log(2)) * cnt2 / (cnt1+cnt2);