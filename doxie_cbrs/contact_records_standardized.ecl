import census_data;

export contact_records_standardized(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

conr := choosen(sort(doxie_cbrs.contact_records(bdids),-did,bdid),1000);  //help memory consumption

doxie_cbrs.layout_contacts_standardized trans_recs(conr L,Census_Data.Key_Fips2County R) := transform
	self.company_zip := if(l.company_zip > 0, INTFORMAT(l.company_zip,5,1), '');
	self.company_zip4 := if(l.company_zip4 > 0, INTFORMAT(l.company_zip4,5,1), '');
	self.company_phone := if(l.company_phone > 0, (string)l.company_phone, '');
	self.company_fein := if(l.company_fein > 0, (string)l.company_fein, '');
	self.zip := if(l.zip > 0, INTFORMAT(l.zip,5,1), '');
	self.zip4 := if(l.zip4 > 0, INTFORMAT(l.zip4,4,1), '');
	self.phone := if(l.phone > 0, (string)l.phone, '');
	SELF.msaDesc := if(L.msa <> '' and L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
	SELF.county_name := if (L.county <> '', R.county_name, '');
	SELF.msa := if(L.msa <> '0000', L.msa, '');	
	self := l;
end;

return JOIN(conr,Census_Data.Key_Fips2County,
					  KEYED(LEFT.state = RIGHT.state_code and
						LEFT.county = RIGHT.county_fips),
						trans_recs(LEFT,RIGHT), LEFT OUTER, KEEP (1)); 
END;