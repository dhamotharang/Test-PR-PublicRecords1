import ut;

ixi.layouts.l_assessor t1(ixi.get_tax le) := transform
 self.aid                    := le.aid;
 self.tax_amt                := le.tax_amount;
 self.tax_yr                 := (integer)le.tax_year;
 self.assd_land_value        := (integer)le.assessed_land_value;
 self.assd_improvement_value := (integer)le.assessed_improvement_value;
 self.assd_total_value       := (integer)le.assessed_total_value;
 self.assd_value_year        := (integer)le.assessed_value_year;
 self.mkt_land_value         := (integer)le.market_land_value;
 self.mkt_improvement_value  := (integer)le.market_improvement_value;
 self.mkt_total_value        := (integer)le.market_total_value;
 self.mkt_value_year         := (integer)le.market_value_year;
end;

p1 := project(ixi.get_tax,t1(left));

ut.mac_sf_buildprocess(p1,'~thor_data400::base::ixi_tax',ixi_tax,2,,true);

export return_ixi_tax := ixi_tax;