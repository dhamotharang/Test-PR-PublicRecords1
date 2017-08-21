import header,mdr;

export	dls_as_header(dataset(driversV2.Layout_Base_withAID) pDLs = dataset([],driversv2.Layout_Base_withAID), boolean pForHeaderBuild=false, boolean pFastHeader = false, boolean IsPRCT = false)
 :=
  function
	dDLsAsSource0:=if(pForHeaderBuild or pFastHeader,header.Files_SeqdSrc(pFastHeader).DL,DriversV2.DLs_as_Source(pDLs,pForHeaderBuild,pFastHeader));

// Bug: 173413
// this change is in conjunction with other changes made in:
// Header.New_Header_Records
// Header.Mac_dedup_header
// Header.Header_Joined

	dDLsAsSource1:=sort(dDLsAsSource0,record, except dl_number,  expiration_date);
	dDLsAsSource:=rollup(dDLsAsSource1
												,transform({dDLsAsSource1}
													,self.dl_number:=if(left.expiration_date>right.expiration_date,left.dl_number,right.dl_number)
													,self.expiration_date:=max(left.expiration_date,right.expiration_date)
													,self:=left)
												,record, except dl_number, expiration_date
												);

	header.Layout_New_Records trans(dDLsAsSource le) := transform
	 self.did := if (pFastHeader or IsPRCT, le.did, 0);
	 self.rid := 0;
	 self.dt_first_seen := IF( le.dt_first_seen < 200109 and
							   (le.dt_first_Seen <> 0 and le.dt_last_seen <> 0), 
							   200109, 
							   le.dt_first_seen );
	 self.dt_nonglb_last_seen:= le.dt_last_seen;
	 self.rec_type := map(le.history='' => '1'
												,le.history='E' => '2'
												,le.history='U' => '3'
												,'2'
												);
	 self.vendor_id := le.dl_number;
	 self.phone := '';
	 self.city_name := le.v_city_name;
	 self.ssn := if ( (unsigned8)le.ssn_safe=0,'',le.ssn_safe );
	 self.cbsa := if(le.msa!='',le.msa + '0','');
	 self.RawAID := le.Append_MailRawAID;
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
