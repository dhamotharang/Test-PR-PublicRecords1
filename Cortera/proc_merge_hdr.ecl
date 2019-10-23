/**

merge previous header build in order to update first/last seen dates

**/
import ut, std;
EXPORT proc_merge_hdr(dataset(Cortera.Layout_Header_Out) allcurrent, dataset(Cortera.Layout_Header_Out) allprevious, string8 version) := FUNCTION
	current := DISTRIBUTE(allcurrent,link_id);			// now current
	previous := DISTRIBUTE(allprevious(current=true),link_id);			// previously current
	curr := DISTRIBUTE(PROJECT(current, cortera.Layout_Header),link_id);
	prev := DISTRIBUTE(PROJECT(previous, cortera.Layout_Header),link_id);
	not_curr := allprevious(NOT current);

	// find new, lost, changed
	new := JOIN(current,previous, left.link_id = right.link_id,
							TRANSFORM(Cortera.Layout_Header_Out, 
								self.current := true;
								self := left;),
							LEFT ONLY, LOCAL);
							
	lost := JOIN(previous,current, left.link_id = right.link_id,
							TRANSFORM(Cortera.Layout_Header_Out, 
									self.current := false;
									self := left;),
							LEFT ONLY, LOCAL);

	rDelta := RECORD
		integer4		link_id;
		boolean			n_diff;
		string			diff;
	END;
	
	delta := JOIN(curr,prev, left.link_id = right.link_id, TRANSFORM(rDelta,
							self.link_id := left.link_id;
							self.diff := ROWDIFF(left, right);
							self.n_diff := IF(self.diff='' OR self.diff='loc_date_last_seen',false,true);
							), INNER, LOCAL);

	// set previous changed to not current and add to output
	archived := JOIN(previous, delta(n_diff=true), left.link_id=right.link_id,
								TRANSFORM(Cortera.Layout_Header_Out,
										self.current := false;
										self := left;), INNER, LOCAL);
	// set new current values
	changed_prev := JOIN(previous, delta(n_diff=true), left.link_id=right.link_id,
								TRANSFORM(Cortera.Layout_Header_Out,
										self := left;), INNER, LOCAL);
	changed := JOIN(current, changed_prev, left.link_id=right.link_id,
								TRANSFORM(Cortera.Layout_Header_Out,
										self.current := true;
										self.dt_vendor_first_reported := (unsigned4)version;
										self.dt_first_seen := ut.Min2(left.dt_first_seen, right.dt_first_seen);
										self.dt_last_seen := Max(left.dt_last_seen, right.dt_last_seen);
										self.persistent_record_id := (left.link_id << 32) + self.dt_vendor_first_reported;
										self := left;), INNER, LOCAL);
	// for unchanged update the date first seen
	unchanged_prev := JOIN(previous, delta(n_diff=false), left.link_id=right.link_id,
								TRANSFORM(Cortera.Layout_Header_Out,
										self := left;), INNER, LOCAL);
	unchanged := JOIN(current, unchanged_prev, left.link_id=right.link_id,
								TRANSFORM(Cortera.Layout_Header_Out,
										self.current := true;
										self.dt_vendor_first_reported := IF(ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported)=0,(unsigned4)version,
																				ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported));
										self.dt_first_seen := ut.Min2(left.dt_first_seen, right.dt_first_seen);
										self.dt_last_seen := Max(left.dt_last_seen, right.dt_last_seen);
										self.persistent_record_id := (left.link_id << 32) + self.dt_vendor_first_reported;
										self := left;), INNER, LOCAL);	
										
	result := new + lost + changed + unchanged + archived + not_curr;
/*	
	hdr := JOIN(curr, prev, left.link_id=right.link_id, TRANSFORM(Cortera.Layout_Header_Out,
						self.dt_first_seen := ut.min2(left.dt_first_seen, right.dt_first_seen);
						self.dt_vendor_first_reported := ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported);
						self := left;), LEFT OUTER, LOCAL);
*/						
	return result;

END;