import header,eq_hist,transunioncred,experiancred,ut,doxie;

export Mod_CreditBureau_address := module

export layouts := module
	export prepped_nlr:=record
			string2 src:=''
			,string8 region:=''
			,string18 vendor_id:=''
			,string8 dt_vendor_first_reported := ''
			,string8 dt_vendor_last_reported := ''
			,nlr0:=false
			,string72 curr_addr:=''
			,nlr1:=false
			,string72 prev_addr1:=''
			,nlr2:=false
			,string72 prev_addr2:=''
			,nlr3:=false
			,string72 prev_addr3:=''
			,nlr4:=false
			,string72 prev_addr4:=''
			,nlr5:=false
			,string72 prev_addr5:=''
			,nlr6:=false
			,string72 prev_addr6:=''
			,nlr7:=false
			,string72 prev_addr7:=''
			end;
end;

export files := module
	export prepped_nlr:=dataset('~thor_data400::prepped::nlr_addresses',layouts.prepped_nlr,flat,opt);
end;

r:=record
	string18 cid;
	string72 current_address;
	string72 former1_address;
	string72 former2_address;
	string75 fn { virtual(logicalfilename)};
end;

rw:={header.File_Header_In().monthly_file};
inw:=DATASET('~thor_data400::in::quickhdr_raw',             {string75 fn { virtual(logicalfilename)},rw}, THOR);

#if (IsFullUpdate = false)
EqFiles0
	:=
	  inw
	;

EqFiles:=project(EqFiles0
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		));
#else
EqFiles0
	:=
    inw            
	+ project(DATASET('~thor_data400::in::quickhdr_raw_father',      {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR), transform({inw},self:=left,self:=[]))
	+ project(DATASET('~thor_data400::in::quickhdr_raw_history',     {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR), transform({inw},self:=left,self:=[]))
	;

	;
EqFiles1
	:=
	DATASET('~thor_data400::in::quickhdr_raw_history_608', {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.old_raw},     THOR)
	;

EqFiles:=project(EqFiles0
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		))
		+
		project(EqFiles1
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		));
#end

EnFiles
	:=
	DATASET(ExperianCred.SuperFile_List.Source_File_History, {string75 fn { virtual(logicalfilename)},ExperianCred.Layouts.Layout_In}, THOR, opt)
	;

TnFiles
	:=
	  DATASET(TransunionCred.SuperFile_List.Updates_history_compressed, {string75 fn { virtual(logicalfilename)},TransunionCred.Layouts.update-cr}, THOR)
	+ DATASET(TransunionCred.SuperFile_List.Updates_father,             {string75 fn { virtual(logicalfilename)},TransunionCred.Layouts.update-cr}, THOR)
	+ DATASET(TransunionCred.SuperFile_List.load_father,                {string75 fn { virtual(logicalfilename)},TransunionCred.Layouts.load-cr},   THOR)
	;

fn_addresFromParts(String10	prim_range,String2	predir,String32	prim_name,String4	suffix,String2	postdir,String4	Unit_desig,String8	sec_range
):=function
	return	(string72)stringlib.stringcleanspaces(
									trim(prim_range)
								+' '+trim(predir)
								+' '+trim(prim_name)
								+' '+trim(suffix)
								+' '+trim(postdir)
								+' '+trim(unit_desig)
								+' '+trim(sec_range)
								);
end;

fn_file_date(string75 fn):=function
	return (string8)stringlib.stringfindreplace(
						stringlib.stringfilterout(
								stringlib.stringtouppercase(
															map( 
																fn = 'thor_data400::in::hdr_all_4thqtr_1992' => '19920000'
																,fn = 'thor_data400::in::hdr_all_1983' => '19830000'
																,fn = 'thor_data400::in::hdr_all_1984' => '19840000'
																,fn = 'thor_data400::in::hdr_all_1985' => '19850000'
																,fn = 'thor_data400::in::hdr_all_1986' => '19860000'
																,fn = 'thor_data400::in::hdr_all_1987' => '19870000'
																,fn = 'thor_data400::in::hdr_all_1990' => '19900000'
																,fn = 'thor_data400::in::hdr_all_1991' => '19910000'
																,stringlib.stringfind(fn, '_20', 1)>0 => fn[stringlib.stringfind(fn, '_20', 1)..]
																,stringlib.stringfind(fn, '_19', 1)>0 => fn[stringlib.stringfind(fn, '_19', 1)..]
																,stringlib.stringfind(fn, 'f20', 1)>0 => fn[stringlib.stringfind(fn, 'f20', 1)..]
																,stringlib.stringfind(fn, 'f19', 1)>0 => fn[stringlib.stringfind(fn, 'f19', 1)..]
																,'00000000'
																)
															)
							,'ABCDEFGHIJKLMNOPQRSTUVWXYZ_')
						,' ','0');

end;

fn_file_region(string75 fn):=function
	return (string8)stringlib.stringfindreplace(
								stringlib.stringtouppercase(
															map( 
																stringlib.stringfind(fn, 'east', 1)>0 => fn[stringlib.stringfind(fn, 'east', 1)..stringlib.stringfind(fn, 'east', 1)+3]
																,stringlib.stringfind(fn, 'west', 1)>0 => fn[stringlib.stringfind(fn, 'west', 1)..stringlib.stringfind(fn, 'west', 1)+3]
																,stringlib.stringfind(fn, 'south', 1)>0 => fn[stringlib.stringfind(fn, 'south', 1)..stringlib.stringfind(fn, 'south', 1)+4]
																,stringlib.stringfind(fn, 'central', 1)>0 => fn[stringlib.stringfind(fn, 'central', 1)..stringlib.stringfind(fn, 'central', 1)+6]
																,'all'
																)
															)
						,' ','0');

end;

//////////////////////////////////equifax//////////////////////////////////////
EQ:=project(EqFiles(~Header.Vendor_Id_Null(header.make_new_vendor(cid)))
		,transform(layouts.prepped_nlr
			,self.src:='EQ'
			,self.region:=fn_file_region(left.fn)
			,self.vendor_id:=trim(left.cid)
			,self.dt_vendor_first_reported := fn_file_date(left.fn)
			,self.dt_vendor_last_reported := fn_file_date(left.fn)
			,self.curr_addr:=left.current_address
			,self.prev_addr1:=left.former1_address
			,self.prev_addr2:=left.former2_address
		  ,self:=left));
///////////////////////////experian/////////////////////////////////////////////////////////////////////
EN:=project(EnFiles
		,transform(layouts.prepped_nlr
			,self.src:='EN'
			,self.region:='ALL'
			,self.vendor_id:=trim(left.Encrypted_Experian_PIN)
			,self.dt_vendor_first_reported := fn_file_date(left.fn)
			,self.dt_vendor_last_reported := fn_file_date(left.fn)
			,self.curr_addr:=fn_addresFromParts(left.Street_Address,left.Street_Predirectional,left.Street_Name,left.Street_Suffix,left.Street_PostDirectional,left.Unit_Type,left.Unit_ID)
			,self.prev_addr1:=fn_addresFromParts(left.Street_Address_Previous1,left.Street_Predirectional1,left.Street_Name1,left.Street_Suffix1,left.Street_PostDirectional1,left.Unit_Type1,left.Unit_ID1)
			,self.prev_addr2:=fn_addresFromParts(left.Street_Address_Previous2,left.Street_Predirectional2,left.Street_Name2,left.Street_Suffix2,left.Street_PostDirectional2,left.Unit_Type2,left.Unit_ID2)
			,self.prev_addr3:=fn_addresFromParts(left.Street_Address_Previous3,left.Street_Predirectional3,left.Street_Name3,left.Street_Suffix3,left.Street_PostDirectional3,left.Unit_Type3,left.Unit_ID3)
			,self.prev_addr4:=fn_addresFromParts(left.Street_Address_Previous4,left.Street_Predirectional4,left.Street_Name4,left.Street_Suffix4,left.Street_PostDirectional4,left.Unit_Type4,left.Unit_ID4)
			,self.prev_addr5:=fn_addresFromParts(left.Street_Address_Previous5,left.Street_Predirectional5,left.Street_Name5,left.Street_Suffix5,left.Street_PostDirectional5,left.Unit_Type5,left.Unit_ID5)
			,self.prev_addr6:=fn_addresFromParts(left.Street_Address_Previous6,left.Street_Predirectional6,left.Street_Name6,left.Street_Suffix6,left.Street_PostDirectional6,left.Unit_Type6,left.Unit_ID6)
			,self.prev_addr7:=fn_addresFromParts(left.Street_Address_Previous7,left.Street_Predirectional7,left.Street_Name7,left.Street_Suffix7,left.Street_PostDirectional7,left.Unit_Type7,left.Unit_ID7)
		  ,self:=left));
///////////////////////transunion///////////////////////////////////////////////////////
TN0:=project(TnFiles
		,transform({string2 record_type, string72 addr, layouts.prepped_nlr}
			,self.src:='TN'
			,self.region:='ALL'
			,self.vendor_id:=trim(left.Party_ID)
			,self.dt_vendor_first_reported := fn_file_date(left.fn)
			,self.dt_vendor_last_reported := fn_file_date(left.fn)
			,self.addr:=fn_addresFromParts(left.House_Number,left.Street_Direction,left.Street_Name,left.Street_Type,left.Street_Post_Direction,left.Unit_Type,left.Unit_Number)
		  ,self:=left));

TN1:=project(TnFiles
		,transform(layouts.prepped_nlr
			,self.src:='TN'
			,self.region:='ALL'
			,self.vendor_id:=trim(left.Party_ID)
			,self.dt_vendor_first_reported := fn_file_date(left.fn)
			,self.dt_vendor_last_reported := fn_file_date(left.fn)
		  ,self:=left));

TN:=dedup(
		denormalize(
					dedup(distribute(TN1,hash(vendor_id)),all,local)
					,dedup(distribute(TN0,hash(vendor_id)),all,local)
						,   left.vendor_id=right.vendor_id
						and left.dt_vendor_first_reported=right.dt_vendor_first_reported
						,transform({layouts.prepped_nlr}
								,self.curr_addr:=if(right.record_type='01',right.addr,left.curr_addr)
								,self.prev_addr1:=if(right.record_type='02',right.addr,left.prev_addr1)
								,self.prev_addr2:=if(right.record_type='03',right.addr,left.prev_addr2)
								,self:=left
								)
					,local
		)
		,all,local);
////////////////////////////////////////////////////////////////////////////////
bureau:=distribute(EQ + EN + TN
 #if (IsFullUpdate = false)
 + files.prepped_nlr
 #end
 ,hash(src,vendor_id));

#if (IsFullUpdate = true)
output(bureau(dt_vendor_first_reported='00000000'));
#end

gp:=group(sort(bureau,src,region,vendor_id,curr_addr,prev_addr1,prev_addr2,prev_addr3,prev_addr4,prev_addr5,prev_addr6,prev_addr7,local),src,region,vendor_id)
:independent;
g:=rollup(gp,transform(layouts.prepped_nlr
				,self.dt_vendor_first_reported:=(string)ut.min2((unsigned)left.dt_vendor_first_reported,(unsigned)right.dt_vendor_first_reported)
				,self.dt_vendor_last_reported:=(string)max((unsigned)left.dt_vendor_last_reported,(unsigned)right.dt_vendor_last_reported)
				,self.nlr0:=max(left.nlr0,right.nlr0)
				,self.nlr1:=max(left.nlr1,right.nlr1)
				,self.nlr2:=max(left.nlr2,right.nlr2)
				,self.nlr3:=max(left.nlr3,right.nlr3)
				,self.nlr4:=max(left.nlr4,right.nlr4)
				,self.nlr5:=max(left.nlr5,right.nlr5)
				,self.nlr6:=max(left.nlr6,right.nlr6)
				,self.nlr7:=max(left.nlr7,right.nlr7)
				,self:=left)
				,src,region,vendor_id,curr_addr,prev_addr1,prev_addr2,prev_addr3,prev_addr4,prev_addr5,prev_addr6,prev_addr7);

i1:=iterate(sort(g,-dt_vendor_first_reported,-curr_addr)
			,transform(layouts.prepped_nlr
				,self.nlr0:=left.curr_addr<>'' and left.vendor_id=right.vendor_id
							and right.curr_addr<>''
							and left.curr_addr[1..7]<>right.curr_addr[1..7]
							and left.prev_addr1[1..7]<>right.curr_addr[1..7]
							and left.prev_addr2[1..7]<>right.curr_addr[1..7]
							and left.prev_addr3[1..7]<>right.curr_addr[1..7]
							and left.prev_addr4[1..7]<>right.curr_addr[1..7]
							and left.prev_addr5[1..7]<>right.curr_addr[1..7]
							and left.prev_addr6[1..7]<>right.curr_addr[1..7]
							and left.prev_addr7[1..7]<>right.curr_addr[1..7]
				,self:=right
			));

i2:=iterate(sort(i1,-dt_vendor_first_reported,-prev_addr1)
			,transform(layouts.prepped_nlr
				,self.nlr1:=left.prev_addr1<>'' and left.vendor_id=right.vendor_id
							and right.prev_addr1<>''
							and left.curr_addr[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr3[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr4[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr5[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr6[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr7[1..7]<>right.prev_addr1[1..7]
				,self:=right
			));

i3:=iterate(sort(i2,-dt_vendor_first_reported,-prev_addr2)
			,transform(layouts.prepped_nlr
				,self.nlr2:=left.prev_addr2<>'' and left.vendor_id=right.vendor_id
								and right.prev_addr2<>''
							  and if(left.src='EN'
												,   left.curr_addr[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr1[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr2[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr3[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr4[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr5[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr6[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr7[1..7]<>right.prev_addr2[1..7]

												,   left.curr_addr[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr1[1..7]<>right.prev_addr2[1..7]
												and left.prev_addr2[1..7]<>right.prev_addr2[1..7]
												and (left.prev_addr2[1..7]<>right.prev_addr1[1..7]
														or left.prev_addr1[1..7]<>right.curr_addr[1..7])
									)
				,self:=right
			));

i4:=iterate(sort(i3,-dt_vendor_first_reported,-prev_addr3)
			,transform(layouts.prepped_nlr
				,self.nlr3:=left.prev_addr3<>'' and left.vendor_id=right.vendor_id
							and right.prev_addr3<>''
							and left.curr_addr[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr3[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr4[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr5[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr6[1..7]<>right.prev_addr3[1..7]
							and left.prev_addr7[1..7]<>right.prev_addr3[1..7]
				,self:=right
			));

i5:=iterate(sort(i4,-dt_vendor_first_reported,-prev_addr4)
			,transform(layouts.prepped_nlr
				,self.nlr4:=left.prev_addr4<>'' and left.vendor_id=right.vendor_id
							and right.prev_addr4<>''
							and left.curr_addr[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr3[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr4[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr5[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr6[1..7]<>right.prev_addr4[1..7]
							and left.prev_addr7[1..7]<>right.prev_addr4[1..7]
				,self:=right
			));

i6:=iterate(sort(i5,-dt_vendor_first_reported,-prev_addr5)
			,transform(layouts.prepped_nlr
				,self.nlr5:=left.prev_addr5<>'' and left.vendor_id=right.vendor_id
							and right.prev_addr5<>''
							and left.curr_addr[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr3[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr4[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr5[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr6[1..7]<>right.prev_addr5[1..7]
							and left.prev_addr7[1..7]<>right.prev_addr5[1..7]
				,self:=right
			));

i7:=iterate(sort(i6,-dt_vendor_first_reported,-prev_addr6)
			,transform(layouts.prepped_nlr
				,self.nlr6:=left.prev_addr6<>'' and left.vendor_id=right.vendor_id
							and right.prev_addr6<>''
							and left.curr_addr[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr3[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr4[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr5[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr6[1..7]<>right.prev_addr6[1..7]
							and left.prev_addr7[1..7]<>right.prev_addr6[1..7]
				,self:=right
			));

i8:=iterate(sort(i7,-dt_vendor_first_reported,-prev_addr7)
			,transform(layouts.prepped_nlr
				,self.nlr7:=left.prev_addr7<>'' and left.vendor_id=right.vendor_id
							and right.prev_addr7<>''
							and left.curr_addr[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr3[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr4[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr5[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr6[1..7]<>right.prev_addr7[1..7]
							and left.prev_addr7[1..7]<>right.prev_addr7[1..7]
							and (
									   left.prev_addr7[1..7]<>right.prev_addr6[1..7]
									or left.prev_addr6[1..7]<>right.prev_addr5[1..7]
									or left.prev_addr5[1..7]<>right.prev_addr4[1..7]
									or left.prev_addr4[1..7]<>right.prev_addr3[1..7]
									or left.prev_addr3[1..7]<>right.prev_addr2[1..7]
									or left.prev_addr2[1..7]<>right.prev_addr1[1..7]
									or left.prev_addr1[1..7]<>right.curr_addr[1..7]
									)
				,self:=right
			));

export flagged_nlr_addresses := i8:independent;

i8eq1:=group(sort(group(files.prepped_nlr(src='EQ')),src,vendor_id,curr_addr[1..7],prev_addr1[1..7],prev_addr2[1..7],prev_addr3[1..7],prev_addr4[1..7],prev_addr5[1..7],prev_addr6[1..7],prev_addr7[1..7],local),src,vendor_id);
i8eq:=rollup(i8eq1,transform(layouts.prepped_nlr
				,self.dt_vendor_first_reported:=(string)ut.min2((unsigned)left.dt_vendor_first_reported,(unsigned)right.dt_vendor_first_reported)
				,self.dt_vendor_last_reported:=(string)max((unsigned)left.dt_vendor_last_reported,(unsigned)right.dt_vendor_last_reported)
				,self.nlr0:=min(left.nlr0,right.nlr0)
				,self.nlr1:=min(left.nlr1,right.nlr1)
				,self.nlr2:=min(left.nlr2,right.nlr2)
				,self.nlr3:=min(left.nlr3,right.nlr3)
				,self.nlr4:=min(left.nlr4,right.nlr4)
				,self.nlr5:=min(left.nlr5,right.nlr5)
				,self.nlr6:=min(left.nlr6,right.nlr6)
				,self.nlr7:=min(left.nlr7,right.nlr7)
				,self:=left)
				,src,vendor_id,curr_addr[1..7],prev_addr1[1..7],prev_addr2[1..7],prev_addr3[1..7],prev_addr4[1..7],prev_addr5[1..7],prev_addr6[1..7],prev_addr7[1..7]);

ii1:=iterate(sort(i8eq,-dt_vendor_first_reported,-curr_addr)
			,transform(layouts.prepped_nlr
				,self.nlr0:=left.curr_addr<>'' and left.vendor_id=right.vendor_id and right.nlr0
							and right.curr_addr<>''
							and left.curr_addr[1..7]<>right.curr_addr[1..7]
							and left.prev_addr1[1..7]<>right.curr_addr[1..7]
							and left.prev_addr2[1..7]<>right.curr_addr[1..7]
				,self:=right
			));

ii2:=iterate(sort(ii1,-dt_vendor_first_reported,-prev_addr1)
			,transform(layouts.prepped_nlr
				,self.nlr1:=left.prev_addr1<>'' and left.vendor_id=right.vendor_id and right.nlr1
							and right.prev_addr1<>''
							and left.curr_addr[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr1[1..7]<>right.prev_addr1[1..7]
							and left.prev_addr2[1..7]<>right.prev_addr1[1..7]
				,self:=right
			));

ii3:=iterate(sort(ii2,-dt_vendor_first_reported,-prev_addr2)
			,transform(layouts.prepped_nlr
				,self.nlr2:=left.prev_addr2<>'' and left.vendor_id=right.vendor_id and right.nlr2
								and right.prev_addr2<>''
								and left.curr_addr[1..7]<>right.prev_addr2[1..7]
								and left.prev_addr1[1..7]<>right.prev_addr2[1..7]
								and left.prev_addr2[1..7]<>right.prev_addr2[1..7]
								and (left.prev_addr2[1..7]<>right.prev_addr1[1..7]
										or left.prev_addr1[1..7]<>right.curr_addr[1..7])
				,self:=right
			));

export flagged_nlr_addresses_patched := group(files.prepped_nlr)(src<>'EQ') + group(ii3);

//////////////////////////////

r:=record
	string2 src;
	string18 vendor_id;
	boolean nlr;
	string72 addr;
end;

all_norm:=normalize(
			flagged_nlr_addresses_patched(nlr0 or nlr1 or nlr2 or nlr3 or nlr4 or nlr5 or nlr6 or nlr7)
			,7
			,transform(r
							,self.nlr:=choose(counter,left.nlr0
													,left.nlr1,left.nlr2
													,left.nlr3,left.nlr4
													,left.nlr5,left.nlr6
													,left.nlr7)
							,self.addr:=choose(counter,left.curr_addr
													,left.prev_addr1,left.prev_addr2
													,left.prev_addr3,left.prev_addr4
													,left.prev_addr5,left.prev_addr6
													,left.prev_addr7)
							,self:=left)
				,local);

export suppressed := dedup(project(all_norm(nlr,addr<>''),{all_norm}-nlr),all,local);

export stats := table(suppressed,{src,cnt:=count(group)},src,few);

export Key_flagged_nlr_addresses:=index(files.prepped_nlr,{src,vendor_id},{files.prepped_nlr},'~thor_data400::key::quickheader::flagged_nlr_addresses_' + Doxie.Version_SuperKey);

end;