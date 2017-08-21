import header,mdr;

export	dls_as_header(dataset(drivers.layout_dl) pDLs = dataset([],drivers.layout_dl), boolean pForHeaderBuild=false)
 :=
  function
	dDLsAsSource	:=	Drivers.DLs_as_Source(pDLs,pForHeaderBuild);

	header.Layout_New_Records trans(dDLsAsSource le) := transform
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
	 
	p := project(dDLsAsSource(~(orig_state = 'FL' and dt_first_seen = 200209 and dt_last_seen = 200209 and 
								dt_vendor_last_reported  = 200209 and dt_vendor_first_reported = 200209)
							   ),trans(left));

	isn(string a) := a <> '' and stringlib.StringFilterOut(a,'0123456789') = '';

	DLs_Filtered	:=	p(mdr.Source_is_DPPA(src),
						  ~(isn(fname) and isn(lname)),
						  ~(fname = '' and lname = ''),
						  prim_name <> ''
						 );
    return DLs_Filtered;
  end
 ;
