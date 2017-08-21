IMPORT landflip;

layout_landflipFlippedRec	tIdentifyPossibleFlips(mapping_landflipGetBaseRecs pLeft, mapping_landflipGetBaseRecs pRight)
 :=
  TRANSFORM
		self.LeftRec	:=	pLeft;
		self.RightRec	:=	pRight;
	END
 ;
 
//Distribute based on fips_cd and apn_num before join to make join and dedupe local
rsLandflipBaseRecsDist	:=	DISTRIBUTE(mapping_landflipGetBaseRecs, HASH(fips_cd, apn_num));
 
rsLandflipPossibleFlips	:=	JOIN(rsLandflipBaseRecsDist,rsLandflipBaseRecsDist,
														 left.fips_cd = right.fips_cd
												 AND left.apn_num = right.apn_num
												 AND left.ln_fares_id != right.ln_fares_id
												 AND left.transfer_dt <= right.transfer_dt,
														 tIdentifyPossibleFlips(left,right),
														 local
														);

rsLandflipPossibleFlipsDedup	:=	DEDUP(rsLandflipPossibleFlips,leftrec.fips_cd,leftrec.apn_num,all,local);

rsLandflipFlips	:=	rsLandflipPossibleFlipsDedup(
											(rightrec.buyer[1..3] = leftrec.seller[1..3]
									  OR rightrec.seller[1..3] = leftrec.buyer[1..3])
									 AND ((((unsigned4)rightrec.transfer_value - (unsigned4)leftrec.transfer_value)*100/(unsigned4)leftrec.transfer_value) > 25)
								    );

export mapping_landflipProcessBaseRecs := rsLandflipFlips;