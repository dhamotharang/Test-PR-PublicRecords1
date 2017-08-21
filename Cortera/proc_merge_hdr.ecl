/**

merge previous header build in order to update first/last seen dates

**/
import ut;
EXPORT proc_merge_hdr(dataset(Cortera.Layout_Header_Out) current, dataset(Cortera.Layout_Header_Out) previous) := FUNCTION

	curr := distribute(current, link_id);
	prev := distribute(previous, link_id);
	
	hdr := JOIN(curr, prev, left.link_id=right.link_id, TRANSFORM(Cortera.Layout_Header_Out,
						self.dt_first_seen := ut.min2(left.dt_first_seen, right.dt_first_seen);
						self.dt_vendor_first_reported := ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported);
						self := left;), LEFT OUTER, LOCAL);
						
	return hdr;

END;