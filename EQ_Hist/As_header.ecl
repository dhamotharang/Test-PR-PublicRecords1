import Header,ut,std;

export	As_header(dataset(layout.base) pFile = dataset([],layout.base), boolean pForHeaderBuild=false)
 :=
  function
	deq_histAsSource	:=	EQ_Hist.fn_Not_Primary_EQ(File.base);

	Header.Layout_New_Records Translate_eq_hist_to_Header(deq_histAsSource l) := transform
		self.did                      := 0;
		self.rid                      := 0;
		self.src:='EQ';
		self.dt_first_seen:=(unsigned)((string)l.dt_first_seen)[1..6];
		self.dt_last_seen:=(unsigned)((string)l.dt_last_seen)[1..6];
		self.dt_vendor_first_reported:=(unsigned)((string)l.dt_vendor_first_reported)[1..6];
		self.dt_vendor_last_reported:=(unsigned)((string)l.dt_vendor_last_reported)[1..6];
		self.rec_type:=l.rec_tp;
		self.phone:=l.clean_phone;
		valid_dob                     := if((unsigned)l.clean_dob between 18000101 and (unsigned)(STRING8)Std.Date.Today()
																					,(unsigned)l.clean_dob
																					,0);
		self.dob:=valid_dob;
		self.ssn:=if(l.clean_ssn in ut.Set_BadSSN ,'',l.clean_ssn);
		self.dt_nonglb_last_seen:=if(self.dt_first_seen > 200106,0,(unsigned)self.dt_last_seen);
		self.suffix:=l.addr_suffix;
		self.city_name:=l.v_city_name;
		self                          := L;
	end;

	eq_hist_project := project(deq_histAsSource,Translate_eq_hist_to_Header(left));
	dist_file_eq    := distribute(eq_hist_project,hash(fname,lname,prim_name,prim_range,sec_range,st,zip));
	srt_file_eq     := sort(dist_file_eq,record,except uid,local);

	Header.Layout_New_Records t_rollup(srt_file_eq le, srt_file_eq ri) := transform
		self.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
		self.dt_last_seen := max(le.dt_last_seen,ri.dt_last_seen);
		self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
		self.dt_vendor_last_reported := max(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
		self.dt_nonglb_last_seen := ut.Min2(le.dt_nonglb_last_seen,ri.dt_nonglb_last_seen);
		self:=le;
	end;

	dedup_file_eq   := rollup(srt_file_eq
									, left.vendor_id=right.vendor_id
								  and left.fname=right.fname
								  and left.lname=right.lname
								  and left.name_suffix=right.name_suffix
								  and left.prim_range=right.prim_range
								  and left.prim_name=right.prim_name
								  and left.sec_range=right.sec_range
								  and left.st=right.st
								  and left.zip=right.zip
								  and left.mname=right.mname
								  and left.phone=right.phone
								  and left.ssn=right.ssn
								  and left.dob=right.dob
								  and left.predir=right.predir
								  and left.suffix=right.suffix
								  and left.postdir=right.postdir
								  and left.unit_desig=right.unit_desig
								  and left.city_name=right.city_name
								  and left.jflag3=right.jflag3
								  ,t_rollup(left,right)
									,local);


	junk1:='0123456789~!@#$%^&*()_+-={}[]|\\:";\'<>?,./ 	';//includes tab and space
	junk2:='0123456789~!@#$%^&*()_+={}[]|\\:";\'<>?,./	';//includes tab but not space or hyphen

	eq_hist_filtered0 := dedup_file_eq
				(
				length(stringlib.stringfilter(trim(fname),junk1))=0
				,length(stringlib.stringfilter(trim(mname),junk1))=0
				,length(stringlib.stringfilter(trim(lname),junk2))=0
				,length(stringlib.stringfilter(trim(lname),' -'))<2
				,length(trim(fname))>1
				,length(trim(lname))>1
				,prim_name<>''
				,prim_name<>''
				,(unsigned)zip4>0
				,zip4<>'9999'
				,length(trim(zip4))=4
				);

	eq_hist_filtered	:=	eq_hist_filtered0;

    return eq_hist_filtered;
  end;