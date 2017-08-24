import header, ut;

export	proflic_as_header(dataset(layout_prolic_out_with_AID) pProfLic = dataset([],layout_prolic_out_with_AID)
, boolean pForHeaderBuild=false,boolean isPRCT=false,boolean pForFCRAHeaderBuild=false)
 :=
  function
	dProfLicAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().PL,Prof_License.ProfLic_as_Source(pProfLic,pForHeaderBuild,pForFCRAHeaderBuild));

	Header.Layout_New_Records into(dProfLicAsSource L) := transform
	  SELF.did := If(IsPRCT,(integer)l.DID,0);	
		//self.did := 0;
		self.rid := 0;
		self.vendor_id := L.license_number[1..18];
		self.dt_first_seen := if((integer)l.date_first_seen=0,0,(unsigned3)(l.date_first_seen[1..6]));
		self.dt_last_seen := if((integer)l.date_last_seen=0,0,(unsigned3)(l.date_last_seen[1..6]));
		self.dt_vendor_first_reported := if((integer)l.date_first_seen=0,0,(unsigned3)(l.date_first_seen[1..6]));
		self.dt_vendor_last_reported := if((integer)l.date_last_seen=0,0,(unsigned3)(l.date_last_seen[1..6]));
		self.dt_nonglb_last_seen := if((integer)l.date_last_seen=0,0,(unsigned3)(l.date_last_seen[1..6]));
		self.rec_type := '2';
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := If(l.vendor='INFUTOR','I','');
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
		self.ssn := '';
		self.dob := (integer)L.dob;
		self.city_name := L.p_city_name;
		self.cbsa := if(l.msa='','',l.msa+'0');
		self.RawAID	:=	l.RawAID;
		self := L;
	end;

	ProfLic_In := project(dProfLicAsSource,into(LEFT))(prim_name!='' and lname!='');

  // The code for this function came from HealthCare_Provider_Header_AsHeader.Mac_dedup and was
	//   adjusted for Professional License use.
	Special_Dedup(DATASET(Header.Layout_New_Records) infile) := FUNCTION
		infile_dis := DISTRIBUTE(infile, HASH(fname, lname, st, prim_name, zip));

		infile_ddp := DEDUP(SORT(infile_dis, RECORD, LOCAL), RECORD, LOCAL);

		ut.MAC_Sequence_Records(infile_ddp, rid, me_use);

		layout := RECORD
			UNSIGNED8 new_rid;
			UNSIGNED8 old_rid;
		END;

		layout xform(me_use L, me_use R) := TRANSFORM
			SELF.new_rid := L.rid;
			SELF.old_rid := R.rid;
		END;

		j := join(me_use, me_use,
								  LEFT.rid < RIGHT.rid
							AND left.fname      =right.fname

							AND ut.nneq(LEFT.mname, RIGHT.mname)

							AND left.lname      =right.lname

							AND left.name_suffix=right.name_suffix
							AND ut.nneq(LEFT.phone, RIGHT.phone)

							AND left.ssn        =right.ssn  
							AND left.dob        =right.dob  
							AND left.prim_range =right.prim_range
							AND left.predir     =right.predir  
							AND left.prim_name  =right.prim_name 
							AND left.suffix     =right.suffix  
							AND left.postdir    =right.postdir 
							AND left.unit_desig =right.unit_desig
							AND left.sec_range  =right.sec_range 
							AND left.city_name  =right.city_name 
							AND left.st         =right.st   
							AND left.zip        =right.zip  
							AND left.county     =right.county
							,xform(LEFT, RIGHT)
							,LOCAL);

		sj := SORT(DISTRIBUTE(j, old_rid), old_rid, new_rid, LOCAL);

		rolled_rids := DEDUP(sj, old_rid, LOCAL);

		ut.MAC_Patch_Id(me_use, rid, rolled_rids, old_rid, new_rid, old_and_new);

		dinfile := DISTRIBUTE(old_and_new, HASH(rid));

		BR_s := SORT(dinfile, rid, LOCAL);

		Header.Layout_New_Records t_rollup(Header.Layout_New_Records L, Header.Layout_New_Records R) := TRANSFORM
			SELF.MNAME 										:= IF(L.MNAME <> '', L.MNAME, R.MNAME);
			SELF.PHONE 										:= IF(L.PHONE	 <> '', L.PHONE, R.PHONE);
			SELF.name_suffix 							:= IF(L.name_suffix	 <> '', L.name_suffix, R.name_suffix);
			self.vendor_id                := map(Header.Vendor_Id_Null(l.vendor_id) => r.vendor_id
                                        ,Header.Vendor_Id_Null(r.vendor_id) => l.vendor_id
                                        ,l.dt_vendor_last_reported > r.dt_vendor_last_reported => l.vendor_id
                                        ,r.vendor_id);
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported	:= MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF.dt_first_seen						:= ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
			SELF.dt_last_seen							:= MAX(L.dt_last_seen, R.dt_last_seen);
			
			SELF := L;
		END;

		ofile := ROLLUP(BR_s, LEFT.rid = RIGHT.rid, t_rollup(LEFT, RIGHT), LOCAL);

		RETURN ofile;
	END;

	ProfLic_Dedup := Special_Dedup(ProfLic_In);

	return ProfLic_Dedup;
end;