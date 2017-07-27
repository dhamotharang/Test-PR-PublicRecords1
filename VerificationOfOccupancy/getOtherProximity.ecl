import Risk_Indicators, ut, LN_PropertyV2, RiskWise, Address;

EXPORT getOtherProximity(DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) rollHeader, boolean fares_ok = true) := FUNCTION

// ******************************************************************************************************************************
// For attribute 'OtherOwnedPropertyProximity' - 
// ******************************************************************************************************************************

//go get all of our input subject's owned/sold properties
	propsOwned	:= VerificationOfOccupancy.getPropOwnership(rollHeader, fares_ok); 
	
//get just target property if it is one of the owned/sold properties (dedup just to be safe)
	targetOwned := dedup(propsOwned(property_match), seq); 

//join the target property to append the owned/sold indicators for the target property
	VerificationOfOccupancy.Layouts.Layout_VOOShell getTargetProp(rollHeader le, targetOwned ri) := TRANSFORM
		SELF.target_addr_owned 			:= ri.property_owned;
		SELF.target_addr_sold				:= ri.property_sold;
		SELF 												:= le;
	END;	

	with_Target := join(rollHeader, targetOwned, 
				left.seq = right.seq,
				getTargetProp(left,right),left outer, ATMOST(riskwise.max_atmost));

//now get the closest other owned property if there is one
	closestOtherOwned := dedup(sort(propsOwned(~property_match and property_sold <> '1'), seq, other_prox_distance), seq); 

//join the other owned property and append the owned/sold indicators for it
	VerificationOfOccupancy.Layouts.Layout_VOOShell getOwnedProps(with_Target le, propsOwned ri) := TRANSFORM
		SELF.other_prox_owned				:= if(~ri.property_match, ri.property_owned, '0');
		SELF.other_prox_sold				:= if(~ri.property_match, ri.property_sold, '0');		
		SELF.other_prox_prim_range	:= ri.property_prim_range; 	
		SELF.other_prox_predir			:= ri.property_predir;		
		SELF.other_prox_prim_name		:= ri.property_prim_name;	
		SELF.other_prox_suffix			:= ri.property_suffix;  
		SELF.other_prox_postdir			:= ri.property_postdir;		
		SELF.other_prox_sec_range		:= ri.property_sec_range;	
		SELF.other_prox_city				:= ri.property_city;	
		SELF.other_prox_st					:= ri.property_st;	
		SELF.other_prox_zip					:= ri.property_zip;	
		SELF.other_prox_lat  				:= ri.property_lat;	
		SELF.other_prox_long  			:= ri.property_long;
		SELF.other_prox_date				:= ri.property_date; // Contains the purchase or sale date
		self.other_prox_distance  	:= if(le.target_addr_owned='1' and le.target_addr_sold<>'1', ri.other_prox_distance, 9999999);
		SELF 												:= le;
	END;	

	with_Owned := join(with_Target, closestOtherOwned, 
				left.seq = right.seq,
				getOwnedProps(left,right),left outer, ATMOST(riskwise.max_atmost));
				
  // output(propsOwned, named('proxpropsOwned'));
  // output(with_Owned, named('proxwith_Owned'));
	
	return with_Owned;	
	
END;