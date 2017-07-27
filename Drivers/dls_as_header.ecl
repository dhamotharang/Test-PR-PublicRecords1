import header,mdr;

f := Dls_as_Source;

header.Layout_New_Records trans(f le) := transform
 self.did := 0;
 self.rid := 0;
 self.dt_first_seen := IF( le.dt_first_seen < 200109 and
						   (le.dt_first_Seen <> 0 and le.dt_last_seen <> 0), 
						   200109, 
						   le.dt_first_seen );
 self.dt_nonglb_last_seen:= le.dt_last_seen;
 self.rec_type := IF(le.history='','1','2');
 self.vendor_id := le.dl_number;
 self.phone := '';
 self.city_name := le.v_city_name;
 self.ssn := if ( (unsigned8)le.ssn_safe=0,'',le.ssn_safe );
 self.cbsa := if(le.msa!='',le.msa + '0','');
 self := le;
  end;
 
p := project(f(~(orig_state = 'FL' and dt_first_seen = 200209 and dt_last_seen = 200209 and 
			   dt_vendor_last_reported  = 200209 and dt_vendor_first_reported = 200209))
,trans(left));

isn(string a) := a <> '' and stringlib.StringFilterOut(a,'0123456789') = '';

export dls_as_header := p(mdr.Source_is_DPPA(src),
~(isn(fname) and isn(lname)),
~(fname = '' and lname = ''),
prim_name <> ''
);