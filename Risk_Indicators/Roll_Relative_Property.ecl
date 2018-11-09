//

export Roll_Relative_Property(GROUPED DATASET(Layouts.Layout_Relat_Prop_Plus_BusInd) ds)  := FUNCTION

// first roll to get relative count
Layouts.Layout_Relat_Prop_Plus_BusInd roll_relat_property(Layouts.Layout_Relat_Prop_Plus_BusInd le, Layouts.Layout_Relat_Prop_Plus_BusInd ri) :=
TRANSFORM
	SELF.property_count := le.property_count+IF(le.did=ri.did,0,ri.property_count);
	SELF.property_total := le.property_total+ri.property_total;
	SELF.property_owned_purchase_total := le.property_owned_purchase_total+
											ri.property_owned_purchase_total;
	SELF.property_owned_purchase_count := le.property_owned_purchase_count+
											ri.property_owned_purchase_count;
	SELF.property_owned_assessed_total := le.property_owned_assessed_total+
											ri.property_owned_assessed_total;
	SELF.property_owned_assessed_count := le.property_owned_assessed_count+
											ri.property_owned_assessed_count;
	SELF := le;
END;
roll1 := ROLLUP(SORT(ds(property_status_family<>' '),seq,did,property_status_family),
															roll_relat_property(LEFT,RIGHT), seq,property_status_family);
															
// project for final roll
{Layout_Boca_Shell_ids.seq, Layout_Relatives_Property_Values}
convert(roll1 le) := TRANSFORM
	SELF.seq := le.seq;
	SELF.owned.relatives_property_count 								:= IF(le.property_status_family='O', le.property_count, 0);
	SELF.owned.relatives_property_total 								:= IF(le.property_status_family='O', le.property_total, 0);
	SELF.owned.relatives_property_owned_purchase_total	:= IF(le.property_status_family='O', le.property_owned_purchase_total, 0);
	SELF.owned.relatives_property_owned_purchase_count	:= IF(le.property_status_family='O', le.property_owned_purchase_count, 0);
	SELF.owned.relatives_property_owned_assessed_total	:= IF(le.property_status_family='O', le.property_owned_assessed_total, 0);
	SELF.owned.relatives_property_owned_assessed_count	:= IF(le.property_status_family='O', le.property_owned_assessed_count, 0);
	SELF.sold.relatives_property_count 								:= IF(le.property_status_family='S', le.property_count, 0);
	SELF.sold.relatives_property_total 								:= IF(le.property_status_family='S', le.property_total, 0);
	SELF.sold.relatives_property_owned_purchase_total	:= IF(le.property_status_family='S', le.property_owned_purchase_total, 0);
	SELF.sold.relatives_property_owned_purchase_count	:= IF(le.property_status_family='S', le.property_owned_purchase_count, 0);
	SELF.sold.relatives_property_owned_assessed_total	:= IF(le.property_status_family='S', le.property_owned_assessed_total, 0);
	SELF.sold.relatives_property_owned_assessed_count	:= IF(le.property_status_family='S', le.property_owned_assessed_count, 0);
	SELF.ambiguous.relatives_property_count 								:= IF(le.property_status_family='A', le.property_count, 0);
	SELF.ambiguous.relatives_property_total 								:= IF(le.property_status_family='A', le.property_total, 0);
	SELF.ambiguous.relatives_property_owned_purchase_total	:= IF(le.property_status_family='A', le.property_owned_purchase_total, 0);
	SELF.ambiguous.relatives_property_owned_purchase_count	:= IF(le.property_status_family='A', le.property_owned_purchase_count, 0);
	SELF.ambiguous.relatives_property_owned_assessed_total	:= IF(le.property_status_family='A', le.property_owned_assessed_total, 0);
	SELF.ambiguous.relatives_property_owned_assessed_count	:= IF(le.property_status_family='A', le.property_owned_assessed_count, 0);
END;

details := PROJECT(roll1, convert(LEFT));


{Layout_Boca_Shell_ids.seq, Layout_Relatives_Property_Values} 
totalDetails(details le, details ri) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.owned.relatives_property_count 								:= le.owned.relatives_property_count 									+ ri.owned.relatives_property_count;
	SELF.owned.relatives_property_total 								:= le.owned.relatives_property_total									+ ri.owned.relatives_property_total;
	SELF.owned.relatives_property_owned_purchase_total	:= le.owned.relatives_property_owned_purchase_total		+ ri.owned.relatives_property_owned_purchase_total;
	SELF.owned.relatives_property_owned_purchase_count	:= le.owned.relatives_property_owned_purchase_count		+ ri.owned.relatives_property_owned_purchase_count;
	SELF.owned.relatives_property_owned_assessed_total	:= le.owned.relatives_property_owned_assessed_total		+ ri.owned.relatives_property_owned_assessed_total;
	SELF.owned.relatives_property_owned_assessed_count	:= le.owned.relatives_property_owned_assessed_count		+ ri.owned.relatives_property_owned_assessed_count;
	SELF.sold.relatives_property_count 								:= le.sold.relatives_property_count									+ ri.sold.relatives_property_count;
	SELF.sold.relatives_property_total 								:= le.sold.relatives_property_total									+ ri.sold.relatives_property_total;
	SELF.sold.relatives_property_owned_purchase_total	:= le.sold.relatives_property_owned_purchase_total	+ ri.sold.relatives_property_owned_purchase_total;
	SELF.sold.relatives_property_owned_purchase_count	:= le.sold.relatives_property_owned_purchase_count	+ ri.sold.relatives_property_owned_purchase_count;
	SELF.sold.relatives_property_owned_assessed_total	:= le.sold.relatives_property_owned_assessed_total	+ ri.sold.relatives_property_owned_assessed_total;
	SELF.sold.relatives_property_owned_assessed_count	:= le.sold.relatives_property_owned_assessed_count	+ ri.sold.relatives_property_owned_assessed_count;
	SELF.ambiguous.relatives_property_count 								:= le.ambiguous.relatives_property_count								+ ri.ambiguous.relatives_property_count;
	SELF.ambiguous.relatives_property_total 								:= le.ambiguous.relatives_property_total								+ ri.ambiguous.relatives_property_total;
	SELF.ambiguous.relatives_property_owned_purchase_total	:= le.ambiguous.relatives_property_owned_purchase_total	+ ri.ambiguous.relatives_property_owned_purchase_total;
	SELF.ambiguous.relatives_property_owned_purchase_count	:= le.ambiguous.relatives_property_owned_purchase_count	+ ri.ambiguous.relatives_property_owned_purchase_count;
	SELF.ambiguous.relatives_property_owned_assessed_total	:= le.ambiguous.relatives_property_owned_assessed_total	+ ri.ambiguous.relatives_property_owned_assessed_total;
	SELF.ambiguous.relatives_property_owned_assessed_count	:= le.ambiguous.relatives_property_owned_assessed_count	+ ri.ambiguous.relatives_property_owned_assessed_count;
END;

RETURN rollup(details, totalDetails(LEFT,RIGHT), seq);

END;

