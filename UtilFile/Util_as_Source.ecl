import header, business_header, address, _control,AID,ut;
d :=  dataset('~thor_data400::Base::UtilityHeader_Building',utilfile.layout_util.base,flat)
	(prim_name <> '', v_city_name <> '', 
	 fname <> '', lname <> '',
     name_flag = 'P',
	 id<>'396560000173759'	 ,ssn<>'653325555' //block bad util record from being re-ingested bug #39714
	);

//project data thru the old layout -> only difference is the csa_indicator field
//csa_indicator not relevant for display and/or worth changing the src key for

src_rec := header.layouts_SeqdSrc.UT_src_rec;

//convert util_type from â€˜3â€™ to â€˜Zâ€™ b/c we keep the original value in util type in base file.

d_convert := project(d, transform(utilfile.layout_util.base, self.util_type := stringlib.stringfindreplace(left.util_Type, '3', 'Z'),
self := left));

src_rec asSrc(d_convert l, boolean iswork) := transform
 //csa_indicator='U' represent inquiries, not true connections
 self.date_first_seen := if(l.csa_indicator='U','',l.date_first_seen);
 self.uid := 0;
 self.src := map( iswork and l.util_type= 'Z' => 'ZK'
								,~iswork and l.util_type= 'Z' => 'ZT'
								,~iswork and l.util_type<>'Z' => 'UT'
								,'UW');
 self := l;
end;

util_dups := project(d_convert,asSrc(left, false)) + 
			 project(d_convert((integer)work_phone > 1000000),asSrc(LEFT, true));

util_dis := distribute(util_dups,hash(id))(~header.IsOldUtil(header.version_build,false,record_date,,7));
util_noID := dedup(util_dis, all,local);

header.Mac_Set_Header_Source(util_noID(src='UW'),src_rec,src_rec,'UW',withID1);
header.Mac_Set_Header_Source(util_noID(src='UT'),src_rec,src_rec,'UT',withID2);
header.Mac_Set_Header_Source(util_noID(src='ZT'),src_rec,src_rec,'ZT',withID3);
header.Mac_Set_Header_Source(util_noID(src='ZK'),src_rec,src_rec,'ZK',withID4);

export Util_as_Source := withID1 + withID2 + withID3 + withID4;