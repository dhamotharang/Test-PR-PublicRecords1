import ln_propertyv2;

lookup_loan_type(string pIn) :=
case(pIn,
'D' => '2ND MORTGAGE MADE TO COVER DOWN PAYMENT',
'A' => 'ASSUMPTION',
'H' => 'BALLOON',
'B' => 'BUILDING OR CONSTRUCTION',
'C' => 'CASH',
'E' => 'CREDIT LINE',
'G' => 'FANNIE MAE/FREDDIE MAC',
'I' => 'FARMERS HOME ADMINISTRATION',
'F' => 'FHA',
'M' => 'HULA MAE (HAWAII)',
'L' => 'LAND CONTRACT',
'N' => 'NEW CONVENTIONAL',
'S' => 'SELLER TAKE-BACK',
'1' => 'STAND-ALONE FIRST',
'R' => 'STAND-ALONE REFINANCE',
'2' => 'STAND-ALONE SECOND',
'Y' => 'STATE VETERAN',
'X' => 'TRADE',
'Q' => 'UNDEFINED/MULTIPLE AMOUNTS',
'P' => 'UNDETERMINED',
'+' => 'UNDETERMINED',
'U' => 'UNKNOWN',
'V' => 'VA',
'');

ln_fid    := distribute(ixi.get_fid,hash(ln_fares_id));
ln_tax    := ln_propertyv2.File_Assessment(vendor_source_flag in variables.vendor);
ln_deed   := ln_propertyv2.File_Deed      (vendor_source_flag in variables.vendor);
ln_people := distribute(ixi.get_people,hash(ln_fares_id));

r1 := record
 string1  tax_or_deed;
 string12 ln_fares_id;
 string1  current_record;
 string1  date_type;
 string8  date_;
 string11 sales_price;
 string11 first_loan     :='';        
 string11 second_loan    :='';
 string5  loan_type_cd   :='';
 string30 loan_type_desc :='';
 boolean  is_2nd_mortgage:=false;
end;

r1 t_tax(ln_tax le) := transform
 self.tax_or_deed    := 'T';
 self.ln_fares_id    := le.ln_fares_id;
 self.current_record := le.current_record;
 self.date_type := if(le.recording_date<>'','R',
                   if(le.transfer_date<>'' ,'C',				
				   ''));
 self.date_     := if(le.recording_date<>'',le.recording_date,
				   if(le.transfer_date<>'' ,le.transfer_date,
				   ''));
 self.sales_price := le.sales_price;
end;

r1 t_deed(ln_deed le) := transform
 self.tax_or_deed    := le.from_file;
 self.ln_fares_id    := le.ln_fares_id;
 self.current_record := le.current_record;
 self.date_type      := if(le.recording_date<>'','R',if(le.contract_date<>'','C',''));
 self.date_          := if(le.recording_date<>'',le.recording_date,if(le.contract_date<>'',le.contract_date,''));
 self.sales_price    := le.sales_price;
 self.first_loan     := le.first_td_loan_amount;
 self.second_loan    := le.second_td_loan_amount;
 self.loan_type_cd   := le.first_td_loan_type_code;
 self.loan_type_desc := lookup_loan_type(le.first_td_loan_type_code);
 self.is_2nd_mortgage := trim(self.loan_type_cd) in ['D','2'] or (trim(self.sales_price)='' and trim(self.loan_type_cd)='E');
end;

p_tax  := project(ln_tax, t_tax(left));
p_deed := project(ln_deed,t_deed(left));

tax_minimum  := p_tax (sales_price<>'');
deed_minimum := p_deed(sales_price<>'' or first_loan<>'' or second_loan<>'');

concat := distribute(tax_minimum+deed_minimum,hash(ln_fares_id));

r2 := record
 concat;
 ln_people.did;
end;

r2 append_people(concat le, ln_people ri) := transform
 self := le;
 self := ri;
end;

j1 := join(concat,ln_people,left.ln_fares_id=right.ln_fares_id,append_people(left,right),local);

r3 := record
 ln_fid.aid;
 j1;
end;

r3 keep_these(j1 le, ln_fid ri) := transform
 self := le;
 self := ri;
end;

j2 := join(j1,ln_fid,left.ln_fares_id=right.ln_fares_id,keep_these(left,right),local,keep(1)) : persist('persist::ixi_get_deed'+variables.pst_suffix);

export get_deed := j2;