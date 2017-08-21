IMPORT Business_Header, ut,mdr, header;

export fAs_Business_Header(

	dataset(Layout_Utility_Bus_Base) pDataset = files().base.QA, boolean IsPRCT = false

) :=
function

	f := if(IsPRCT, pDataset, pDataset(~header.IsOldUtil(ut.GetDate,false,record_date)));

	Layout_Utility_Local := record
		unsigned6 record_id := 0;
		f;
	end;

	Layout_Utility_Local InitUtility(f l) := transform
		self := l;
	end;

	Utility_Init := project(f, InitUtility(left));

	ut.MAC_Sequence_Records(Utility_Init, record_id, Utility_Seq)


	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout tAsBusinessHeader(Layout_Utility_Local L, unsigned2 cnt) := transform
	
		phone := map(cnt = 1 and l.Phone			!= '' =>	l.Phone
								,cnt = 2 and l.Work_Phone != '' =>	l.Work_Phone
								,cnt = 1 and l.Phone			 = '' =>	l.Work_Phone
								,																		l.Phone
				);
		
		SELF.group1_id 								:= l.record_id;
		SELF.vl_id 								    := l.ID;
		SELF.vendor_id 								:= l.id;
		SELF.phone 										:= (unsigned6)phone;
		SELF.phone_score 							:= IF((unsigned6)l.Phone = 0, 0, 1);
		SELF.source 									:= mdr.sourceTools.src_Utilities;
		SELF.source_group 						:= trim(l.source) + l.ID;
		SELF.bdid 										:= if(isPRCT, (unsigned6)l.bdid, 0);
		SELF.company_name 						:= trim(l.COMPANY_NAME,left,right);
		SELF.dt_first_seen 						:= (UNSIGNED4)l.date_first_seen;
		SELF.dt_last_seen 						:= (UNSIGNED4)l.date_first_seen;
		SELF.dt_vendor_first_reported	:= (UNSIGNED4)l.date_added_to_exchange;
		SELF.dt_vendor_last_reported	:= (UNSIGNED4)l.date_added_to_exchange;
		SELF.fein 										:= 0;
		SELF.current 									:= TRUE;
		SELF.prim_range 							:= l.prim_range;
		SELF.predir 									:= l.predir;
		SELF.prim_name 								:= l.prim_name;
		SELF.addr_suffix 							:= l.addr_suffix;
		SELF.postdir 									:= l.postdir;
		SELF.unit_desig 							:= l.unit_desig;
		SELF.sec_range 								:= l.sec_range;
		SELF.city 										:= l.v_city_name;
		SELF.state 										:= l.st;
		SELF.zip 											:= (UNSIGNED3)l.zip;
		SELF.zip4 										:= (UNSIGNED2)l.zip4;
		SELF.county 									:= l.county;
		SELF.msa 											:= l.msa;
		SELF.geo_lat 									:= l.geo_lat;
		SELF.geo_long 								:= l.geo_long;
		self.dppa											:= false;
		
	end;
	
		choosey(string pPhone, string pCompany_Phone) := 
		map(			pPhone					!= ''
					and pCompany_Phone	!= '' => 2, 1);
									
	dAsBusinessHeader	:= normalize(
													 Utility_Seq
													,choosey(left.Phone, left.work_Phone)
													,tAsBusinessHeader(left,counter)
													);

	ded_dAsBusinessHeader := dedup(sort(dAsBusinessHeader(vendor_id != ''),company_name, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, source, -dt_last_seen),
	             company_name, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, source);
	
	return 	ded_dAsBusinessHeader((trim(prim_range) + trim(prim_name) + trim(addr_suffix) + trim(city) + trim(state) <> ''and zip <> 0) or phone <> 0);

end;