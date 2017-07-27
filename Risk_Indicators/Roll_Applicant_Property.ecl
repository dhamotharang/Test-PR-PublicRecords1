//
export Roll_Applicant_Property(GROUPED DATASET(Layouts.layout_relat_prop_plusv4) ds) := FUNCTION
															
// project for final roll
{Layout_Boca_Shell_ids.seq, Layout_Applicant_Property_Values}
convert(Layouts.layout_relat_prop_plusv4 le) := TRANSFORM
	SELF.seq := le.seq;
	SELF.owned.property_total 								:= IF(le.property_status_applicant='O', le.property_total, 0);
	SELF.owned.property_owned_purchase_total	:= IF(le.property_status_applicant='O', le.property_owned_purchase_total, 0);
	SELF.owned.property_owned_purchase_count	:= IF(le.property_status_applicant='O', le.property_owned_purchase_count, 0);
	SELF.owned.property_owned_assessed_total	:= IF(le.property_status_applicant='O', le.property_owned_assessed_total, 0);
	SELF.owned.property_owned_assessed_count	:= IF(le.property_status_applicant='O', le.property_owned_assessed_count, 0);
	SELF.sold.property_total 								:= IF(le.property_status_applicant='S', le.property_total, 0);
	SELF.sold.property_owned_purchase_total	:= IF(le.property_status_applicant='S', le.property_owned_purchase_total, 0);
	SELF.sold.property_owned_purchase_count	:= IF(le.property_status_applicant='S', le.property_owned_purchase_count, 0);
	SELF.sold.property_owned_assessed_total	:= IF(le.property_status_applicant='S', le.property_owned_assessed_total, 0);
	SELF.sold.property_owned_assessed_count	:= IF(le.property_status_applicant='S', le.property_owned_assessed_count, 0);
	SELF.ambiguous.property_total 								:= IF(le.property_status_applicant='A', le.property_total, 0);
	SELF.ambiguous.property_owned_purchase_total	:= IF(le.property_status_applicant='A', le.property_owned_purchase_total, 0);
	SELF.ambiguous.property_owned_purchase_count	:= IF(le.property_status_applicant='A', le.property_owned_purchase_count, 0);
	SELF.ambiguous.property_owned_assessed_total	:= IF(le.property_status_applicant='A', le.property_owned_assessed_total, 0);
	SELF.ambiguous.property_owned_assessed_count	:= IF(le.property_status_applicant='A', le.property_owned_assessed_count, 0);
END;

details := PROJECT(ds, convert(LEFT));


{Layout_Boca_Shell_ids.seq, Layout_Applicant_Property_Values} 
totalDetails(details le, details ri) :=
TRANSFORM
	SELF.seq := le.seq;
	SELF.owned.property_total 								:= le.owned.property_total									+ ri.owned.property_total;
	SELF.owned.property_owned_purchase_total	:= le.owned.property_owned_purchase_total		+ ri.owned.property_owned_purchase_total;
	SELF.owned.property_owned_purchase_count	:= le.owned.property_owned_purchase_count		+ ri.owned.property_owned_purchase_count;
	SELF.owned.property_owned_assessed_total	:= le.owned.property_owned_assessed_total		+ ri.owned.property_owned_assessed_total;
	SELF.owned.property_owned_assessed_count	:= le.owned.property_owned_assessed_count		+ ri.owned.property_owned_assessed_count;
	SELF.sold.property_total 								:= le.sold.property_total									+ ri.sold.property_total;
	SELF.sold.property_owned_purchase_total	:= le.sold.property_owned_purchase_total	+ ri.sold.property_owned_purchase_total;
	SELF.sold.property_owned_purchase_count	:= le.sold.property_owned_purchase_count	+ ri.sold.property_owned_purchase_count;
	SELF.sold.property_owned_assessed_total	:= le.sold.property_owned_assessed_total	+ ri.sold.property_owned_assessed_total;
	SELF.sold.property_owned_assessed_count	:= le.sold.property_owned_assessed_count	+ ri.sold.property_owned_assessed_count;
	SELF.ambiguous.property_total 								:= le.ambiguous.property_total								+ ri.ambiguous.property_total;
	SELF.ambiguous.property_owned_purchase_total	:= le.ambiguous.property_owned_purchase_total	+ ri.ambiguous.property_owned_purchase_total;
	SELF.ambiguous.property_owned_purchase_count	:= le.ambiguous.property_owned_purchase_count	+ ri.ambiguous.property_owned_purchase_count;
	SELF.ambiguous.property_owned_assessed_total	:= le.ambiguous.property_owned_assessed_total	+ ri.ambiguous.property_owned_assessed_total;
	SELF.ambiguous.property_owned_assessed_count	:= le.ambiguous.property_owned_assessed_count	+ ri.ambiguous.property_owned_assessed_count;
END;

RETURN rollup(details, totalDetails(LEFT,RIGHT), seq);

END;
