export explodeIds := module


	/*
	 * This function is to explode out proxids at the beginning of the build. This
	 * will set the proxids back to dotid and will reset lgid3 to 0. An lgid3 of 0
	 * will cause hrchy to rebuild the lgid3/seleids for these proxids. This function
	 * should only be used prior to building the hierarchies b/c of how lgid3 is 
	 * handled. This also assumes that empid and powid are not persistent.
   *
   * inputDs - must contain fields for dotid, proxid, and lgid3
	 * proxidDs - must contain proxid field - these are the proxids to explode.
	 */
	export proxidPreHrchy(inputDs, proxidDs) := functionmacro
		local lgid3sToExplodeDups := 
			join(inputDs, proxidDs,
				left.proxid = right.proxid,
				transform({inputDs.lgid3},
				  self.lgid3 := left.lgid3),
				keep(1), smart);

		local lgid3sToExplode := dedup(lgid3sToExplodeDups, lgid3, all);

		local explodeProxid :=
			join(inputDs, proxidDs,
				left.proxid = right.proxid,
				transform(recordof(left),
				  self.proxid := if(right.proxid != 0, left.dotid, left.proxid);
				  self := left),
				keep(1), smart, left outer);

		local explodeLgid3 := BipV2_Tools.explodeIds.lgid3PreHrchy(explodeProxid, lgid3sToExplode);

		return explodeLgid3;

	endmacro;

	/*
	 * This function is to explode out lgid3s at the beginning of the build. This
	 * will reset the lgid3s to 0. An lgid3 of 0 will cause hrchy to rebuild the
	 * lgid3/seleids for these proxids. This function should only be used prior to
	 * building the hierarchies b/c of how lgid3 is handled. This also assumes that
	 * empid and powid are not persistent.
   *
   * inputDs - must contain field for lgid3
	 * lgid3Ds - must contain lgid3 field - these are the lgid3 to explode.
	 */
	export lgid3PreHrchy(inputDs, lgid3Ds) := functionmacro

		local explodeLgid3 :=
			join(inputDs, lgid3Ds,
				left.lgid3 = right.lgid3,
				transform(recordof(left),
				  self.lgid3 := if(right.lgid3 != 0, 0, left.lgid3);
				  self := left),
				keep(1), smart, left outer);

		return explodeLgid3;

	endmacro;

end;