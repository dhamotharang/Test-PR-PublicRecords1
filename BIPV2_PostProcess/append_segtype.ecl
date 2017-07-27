import BIPV2;

recGold := recordof(BIPV2_PostProcess.segmentation_gold()._gold);
recSeg  := recordof(BIPv2_PostProcess.segmentation().result_w_desc);
recH	  := BIPV2.CommonBase.layout;
recAns	:= record
	typeof(recH.seleid) ultid := 0;
	typeof(recH.seleid) orgid := 0;
	typeof(recH.seleid) seleid := 0;
	typeof(recH.seleid) proxid := 0;
	string1 sele_gold := '';	
	
	string1 ult_seg := '';
	string1 org_seg := '';
	string1 sele_seg := '';
	string1 prox_seg := '';
	string1 pow_seg := '';
	
	string1 ult_prob := '';
	string1 org_prob := '';
	string1 sele_prob := '';
	string1 prox_prob := '';
	string1 pow_prob := '';	
end;
recSeg2 := record
	recSeg.id;
	recSeg.s1code;
	string1 prob := '';
end;
	
//TEMP? - well, the "OR" should allow it to gracefully handle the addition of these fields to the base later on
recOut := record
	BIPV2.CommonBase.layout OR recAns;
end;

EXPORT append_segtype(
	dataset(recH)														pInput
	,dataset(recGold)												sGold
	,dataset(recSeg)												uSeg0		//ult
	,dataset(recSeg)												uSegP //ult probation
	,dataset(recSeg)												oSeg0
	,dataset(recSeg)												oSegP
	,dataset(recSeg)												sSeg0
	,dataset(recSeg)												sSegP
	,dataset(recSeg)												pSeg0 	//prox
	,dataset(recSeg)												pSegP //prox probation
	,dataset(recSeg)												wSeg0 	//pow
	,dataset(recSeg)												wSegP //pow probation
) := 
MODULE

//add both sets of segmentation errors together, but keep track of the diff between probation and regular
uSeg := project(uSeg0, recSeg2) + project(uSegP, transform(recSeg2, self.prob := BIPV2_PostProcess.constants.mProbation.s1, self := left));
oSeg := project(oSeg0, recSeg2) + project(oSegP, transform(recSeg2, self.prob := BIPV2_PostProcess.constants.mProbation.s1, self := left));
sSeg := project(sSeg0, recSeg2) + project(sSegP, transform(recSeg2, self.prob := BIPV2_PostProcess.constants.mProbation.s1, self := left));
pSeg := project(pSeg0, recSeg2) + project(pSegP, transform(recSeg2, self.prob := BIPV2_PostProcess.constants.mProbation.s1, self := left));
wSeg := project(wSeg0, recSeg2) + project(wSegP, transform(recSeg2, self.prob := BIPV2_PostProcess.constants.mProbation.s1, self := left));

	//seleid has two types of segmentation (regular and gold) so it needs a prep join
	js :=
	join(
		sSeg,
		sGold,
		left.id = right.id,
		transform(
			recAns,
			self.seleID := left.id,
			self.sele_seg := left.s1code,
			self.sele_prob := left.prob,
			self.sele_gold := if(right.id > 0, BIPV2_PostProcess.constants.mGold.s1, '')
		),
		hash,
		left outer
	);

	//add sele info
	jsresult :=
	join(
		pInput,
		js,
		left.seleid = right.seleid,
			transform(
			recOut,
			self.sele_seg := right.sele_seg,
			self.sele_gold := right.sele_gold,
			self.sele_prob := right.sele_prob,
			self := left
		),
		hash
    ,left outer
	);	
	
	//add ult,org,etc info
	fadd(inf, seg, fseg, fprob, fid) :=
	functionmacro
		return 
		join(
			inf,
			seg,
			left.fid = right.id,
				transform(
				recOut,
				self.fseg := right.s1code,
				self.fprob := right.prob,
				self := left
			),
			// smart //failed - https://track.hpccsystems.com/browse/HPCC-11693
			hash
      ,left outer
		);	
	endmacro;
	
	
	juresult := fadd(jsresult, uSeg, ult_seg, ult_prob, ultid);
	joresult := fadd(juresult, oSeg, org_seg, org_prob, orgid);
	jpresult := fadd(joresult, pSeg, prox_seg, prox_prob, proxid);
	jwresult := fadd(jpresult, wSeg, pow_seg, pow_prob, powid);
	
	jresult := jwresult;
	export result := if(count(jresult) = count(pInput), jresult);//just make sure we didnt add records


end;//append_segtype