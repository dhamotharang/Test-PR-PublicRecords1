import faa, prte_bip, ut,mdr;

export FAA	(string pversion = '') := module

	export ds_Aircraft_Reg		:= prte_csv.FAA_Files().input_faa_aircraft_reg.using;
	export ds_Airmen					:= prte_csv.FAA_Files().input_faa_airmen.using;
	export ds_Airmen_Certs		:= prte_csv.FAA_Files().input_faa_airmen_certs.using;
	export ds_Aircraft_Engine := faa.file_engine_info_in;
	export ds_Aircraft_Info	 	:= faa.file_aircraft_info_in;

	//Produce autokeys for faa
	export ds_Autokeys 				:= prte_csv.faa_proc_build_autokeys(ds_Aircraft_Reg,ds_Airmen,pversion);

	//Produce autokeys for faa airmen
	export ds_Airmen_Autokeys := prte_csv.faa_airmen_proc_build_autokeys(ds_Airmen,pversion);

	//Produce roxie keys for faa	
	export dthor_data400__key__faa__aircraft_info 		:= project(ds_Aircraft_Info,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__aircraft_info,
																																														self.code									:= left.aircraft_mfr_model_code;
																																														self.__internal_fpos__ 		:= 0;
																																														self 											:= left;
																																														)
																															); 																																																										 
	export dthor_data400__key__faa__engine_info 			:= project(ds_Aircraft_Engine,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__engine_info,
																																														self.code									:= left.engine_mfr_model_code;
																																														self.__internal_fpos__ 		:= 0;
																																														self 											:= left;
																																														)
																															); 
	export dthor_data400__key__faa__aircraft_id 			:= project(ds_Aircraft_Reg,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__aircraft_id,
																																														self.aircraft_id					:= (unsigned6)left.aircraft_id;
																																														self.persistent_record_id	:= (unsigned8)left.persistent_record_id;
																																														self 											:= left;
																																														self											:= [];
																																														)
																															);	
	export dthor_data400__key__faa__aircraft_reg_bdid := project(ds_Aircraft_Reg,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__aircraft_reg_bdid,
																																														self.bd										:= (unsigned6)left.bd;
																																														self.aircraft_id					:= (unsigned6)left.aircraft_id;
																																														self 											:= left;
																																														)
																															);																				
	export dthor_data400__key__faa__aircraft_reg_did 	:= project(ds_Aircraft_Reg,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__aircraft_reg_did,
																																														self.did									:= (unsigned6)left.did;
																																														self.aircraft_id					:= (unsigned6)left.aircraft_id;																																														
																																														self.persistent_record_id	:= (unsigned8)left.persistent_record_id;
																																														self 											:= left;
																																														)
																															);
	export dthor_data400__key__faa__fcra__aircraftreg_did 	:= project(ds_Aircraft_Reg,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__fcra__aircraftreg_did,
																																														self.did									:= (unsigned6)left.did;
																																														self.aircraft_id					:= (unsigned6)left.aircraft_id;
																																														self.persistent_record_id	:= (unsigned8)left.persistent_record_id;
																																														self 											:= left;
																																														)
																															);
	export dthor_data400__key__faa__fcra__aircraft_reg_did 	:= project(ds_Aircraft_Reg,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__fcra__aircraft_reg_did,
																																														self.did									:= (unsigned6)left.did;
																																														self.__fpos								:= 0;																																														
																																														self 											:= left;
																																														)
																															);
	export dthor_data400__key__faa__aircraft_reg_nnum := project(ds_Aircraft_Reg,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__aircraft_reg_nnum,
																																														self.aircraft_id					:= (unsigned6)left.aircraft_id;
																																														self.persistent_record_id	:= (unsigned8)left.persistent_record_id;
																																														self 											:= left;
																																														)
																															);
																															
																															

	temp_layout := record
		unsigned8 	unique_id;
		recordof(ds_Aircraft_Reg);
	end;

	project_2_temp_layout				:= project(ds_Aircraft_Reg, transform(temp_layout, self := left; self.unique_id := 0;));

	ut.MAC_Sequence_Records(project_2_temp_layout, unique_id, project_infile_2_temp_layout_seq );

	project_2_fakeId_layout			:= project(project_infile_2_temp_layout_seq,transform(prte_bip.Layout_Append_FakeIDs.LinkIds
																																									  ,self.company_name 	:= left.compname
																																										,self 							:= left;
																																										,self 							:= [];
																																										)
																				 );

	stamp_infile_with_linkids		:= prte_bip.fn_Append_Fake_LinkIDs(project_2_fakeId_layout);

	prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__aircraft_linkids AssignIDs(temp_layout l, prte_bip.Layout_Append_FakeIDs.LinkIds r) := transform
		self.DotID			:= r.DotID;
		self.DotScore		:= r.DotScore;
		self.DotWeight	:= r.DotWeight;
		self.EmpID			:= r.EmpID;
		self.EmpScore		:= r.EmpScore;
		self.EmpWeight	:= r.EmpWeight;
		self.POWID			:= r.POWID;
		self.POWScore		:= r.POWScore;
		self.POWWeight	:= r.POWWeight;
		self.ProxID			:= r.ProxID;
		self.ProxScore	:= r.ProxScore;
		self.ProxWeight	:= r.ProxWeight;
		self.SELEID			:= r.SELEID;
		self.SELEScore	:= r.SELEScore;
		self.SELEWeight	:= r.SELEWeight;	
		self.OrgID			:= r.OrgID;
		self.OrgScore		:= r.OrgScore;
		self.OrgWeight	:= r.OrgWeight;
		self.UltID			:= r.UltID;
		self.UltScore		:= r.UltScore;
		self.UltWeight	:= r.UltWeight;
		self 						:= l;
		self						:= [];
	end;

	stamped_faa_aircraft_linkids										  := join(project_infile_2_temp_layout_seq,
																														stamp_infile_with_linkids,
																														left.unique_id = right.unique_id,
																														AssignIDs(left, right),
																														left outer
																														);

	export dthor_data400__key__faa__aircraft_linkids	:= stamped_faa_aircraft_linkids(ut.fnTrim2Upper(compname)<>'');
																														
																			 
	export dthor_data400__key__faa__airmen_certs 			:= project(ds_Airmen_Certs,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__airmen_certs,
																																														self.persistent_record_id		:= (unsigned8)left.persistent_record_id;
																																														self 												:= left;
																																														)
																															);
	export dthor_data400__key__faa__airmen_did 				:= project(ds_Airmen,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__airmen_did,
																																														self.did										:= (unsigned8)left.did;
																																														self.airmen_id							:= (unsigned6)left.airmen_id;
																																														self.source									:= mdr.sourcetools.src_Airmen;
																																														self.persistent_record_id		:= (unsigned8)left.persistent_record_id;
																																														self 												:= left;
																																														)
																															);

	export dthor_data400__key__faa__airmen_id 				:= project(ds_Airmen,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__airmen_id,
																																														self.airmen_id						 	:= (unsigned6)left.airmen_id;
																																														self.persistent_record_id		:= (unsigned8)left.persistent_record_id;
																																														self 											 	:= left;
																																														)
																															); 
	export dthor_data400__key__faa__airmen_rid 				:= project(ds_Airmen,transform(prte_csv.FAA_Key_Layouts.rthor_data400__key__faa__airmen_rid,
																																														self.airmen_id							:= (unsigned6)left.airmen_id;
																																														self.persistent_record_id		:= (unsigned8)left.persistent_record_id;
																																														self 												:= left;
																																														)
																															);
end: DEPRECATED('Use PRTE2_FAA.Files instead.');
