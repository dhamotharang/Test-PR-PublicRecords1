import	std, ut;

EXPORT proc_merge_attr(dataset(Cortera.Layout_Attributes_Out) current, dataset(Cortera.Layout_Attributes_Out) allprevious, string8 version) := FUNCTION
	previous := allprevious(current_rec);			// previously current
	curr := DISTRIBUTE(PROJECT(current, cortera.Layout_Attributes),ULTIMATE_LINKID);
	prev := DISTRIBUTE(PROJECT(previous, cortera.Layout_Attributes),ULTIMATE_LINKID);
	not_curr := allprevious(NOT current_rec);
	
	// find new, lost, changed
	new := JOIN(current,previous, left.ULTIMATE_LINKID = right.ULTIMATE_LINKID,
							TRANSFORM(Cortera.Layout_Attributes_Out, 
								self.current_rec := true;
								self.dt_vendor_first_reported := (unsigned4)version;
								self := left;),
							LEFT ONLY, LOCAL);
							
	lost := JOIN(previous,current, left.ULTIMATE_LINKID = right.ULTIMATE_LINKID,
							TRANSFORM(Cortera.Layout_Attributes_Out, 
									self.current_rec := false;
									self := left;),
							LEFT ONLY, LOCAL);
	
	rDelta := RECORD
		integer4		ULTIMATE_LINKID;
		integer			n_diff;
		string			diff;
	END;
	
	delta := JOIN(curr,prev, left.ULTIMATE_LINKID = right.ULTIMATE_LINKID, TRANSFORM(rDelta,
							self.ULTIMATE_LINKID := left.ULTIMATE_LINKID;
							self.diff := ROWDIFF(left, right, COUNT);
							self.n_diff := Std.Str.FindCount(self.diff,'1');
							), INNER, LOCAL);
	// set previous changed to not current and add to output
	archived := JOIN(previous, delta(n_diff<>0), left.ULTIMATE_LINKID=right.ULTIMATE_LINKID,
								TRANSFORM(Cortera.Layout_Attributes_Out,
										self.current_rec := false;
										self := left;), INNER, LOCAL);
	// set new current values
	changed := JOIN(current, delta(n_diff<>0), left.ULTIMATE_LINKID=right.ULTIMATE_LINKID,
								TRANSFORM(Cortera.Layout_Attributes_Out,
										self.current_rec := true;
										self.dt_vendor_first_reported := (unsigned4)version;
										self := left;), INNER, LOCAL);
	// for unchanged update the date first seen
	unchanged_prev := JOIN(previous, delta(n_diff=0), left.ULTIMATE_LINKID=right.ULTIMATE_LINKID,
								TRANSFORM(Cortera.Layout_Attributes_Out,
										self := left;), INNER, LOCAL);
	unchanged := JOIN(current, unchanged_prev, left.ULTIMATE_LINKID=right.ULTIMATE_LINKID,
								TRANSFORM(Cortera.Layout_Attributes_Out,
										self.current_rec := true;
										self.dt_vendor_first_reported := IF(ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported)=0,(unsigned4)version,
																				ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported));
										self := left;), INNER, LOCAL);	
										
	result := new + lost + changed + unchanged + archived + not_curr;
										
	return result;
END;