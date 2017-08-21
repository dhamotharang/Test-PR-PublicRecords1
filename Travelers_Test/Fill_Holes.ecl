import header,address,did_add,watchdog,DriversV2,VehLic;

export Fill_Holes :=
module

	///////////////////////////////////////////////////////////////////////////
	// -- 1) header.mac_best_address (for former address rec_type=2)
	///////////////////////////////////////////////////////////////////////////
	export Get_Former_Address(
	
		 dataset(Layouts.Temporary.UniqueId	)	pDataset
		,dataset(header.Layout_Header_v2		) pPersonHeaders	= Header.File_Headers
		,string																pPersistname		= persistnames().FillHoles_GetFormerAddress
	
	) :=
	function
		
		ldataset_withdid		:= pDataset.did != 0 and pDataset.Subject.FORMER_ADDRESS.Street_Name = '';
		
		ddataset_withdid		:= pDataset(ldataset_withdid);
		ddataset_withoutdid := pDataset(not(ldataset_withdid));
		
		header.mac_best_address(
			 pPersonHeaders
			,did
			,2
			,dmac_best_address
		);
		
		dformer_addresses := dmac_best_address((unsigned)rec_type = 2);
	
		djoinback := join(
			 distribute(ddataset_withdid	,did)
			,distribute(dformer_addresses	,did)
			,left.did = right.did
			,transform(
				 Layouts.Temporary.UniqueId
				,addrnotequal := 			left.Clean_Subject_address.prim_range != right.prim_range
													and left.Clean_Subject_address.prim_name 	!= right.prim_name
													;
				 self.Subject.FORMER_ADDRESS.Street_Number	 	:= if(addrnotequal	,(string)right.prim_range	,'');
				 self.Subject.FORMER_ADDRESS.Street_Name			:= if(addrnotequal	,
																																									 trim(right.predir		)
																																					 + ' ' + trim(right.prim_name	)
																																					 + ' ' + trim(right.suffix		)
																																					 + ' ' + trim(right.postdir		)
																																					 ,''
																													);
				 self.Subject.FORMER_ADDRESS.APT_Unit_Number 	:= if(addrnotequal	,
																																									 trim(right.unit_desig	)
																																					 + ' ' + trim(right.sec_range		)
																																					,''
																												);
				 self.Subject.FORMER_ADDRESS.City							:= if(addrnotequal	,right.city_name	,'');
				 self.Subject.FORMER_ADDRESS.State 						:= if(addrnotequal	,right.st					,'');
				 self.Subject.FORMER_ADDRESS.Zip_Code					:= if(addrnotequal	,right.zip				,'');
				 self 																				:= left							;
			)
			,left outer
			,keep(1)
			,local
		);
	
		dall := djoinback 
					+ ddataset_withoutdid
					: persist(pPersistname);
		
		return dall;
	
	end;

	///////////////////////////////////////////////////////////////////////////
	// -- did_add.MAC_Add_SSN_By_DID to get ssn
	///////////////////////////////////////////////////////////////////////////
	export Get_SSN(
	
		 dataset(Layouts.Temporary.UniqueId	)	pDataset
		,string																pPersistname		= persistnames().FillHoles_GetSSN
	
	) :=
	function
		
		ldataset_withoutssn		:= pDataset.did != 0 and (unsigned8)pDataset.Subject.SSN = 0;
		
		ddataset_withoutssn		:= pDataset(ldataset_withoutssn);
		ddataset_withssn 			:= pDataset(not(ldataset_withoutssn));

		did_add.MAC_Add_SSN_By_DID(
			 ddataset_withoutssn
			,did
			,Subject.SSN
			,dAppendedSsn
		);
		
		dAppendedSsn_proj := project(dAppendedSsn
			,transform(
			 	 Layouts.Temporary.UniqueId
				,self.Subject.SSN := if(left.Subject.SSN = '', '000000000', left.Subject.SSN);
				 self							:= left;
			)
		);

		dall := dAppendedSsn_proj + ddataset_withssn
			: persist(pPersistname);
	
		return dall;
		
	end;
	
		///////////////////////////////////////////////////////////////////////////
	// -- watchdog.file_best (dob, address, dl number, gender use title field)
	///////////////////////////////////////////////////////////////////////////
	export Get_Misc(
	
		 dataset(Layouts.Temporary.UniqueId	)	pDataset
		,dataset(Watchdog.Layout_Best_v2		) pWatchdogBest	= watchdog.file_best
		,string																pPersistname	= persistnames().FillHoles_GetMisc
	
	) :=
	function
		
		ldataset_withdid		:= pDataset.did != 0;
		
		ddataset_withdid		:= pDataset(ldataset_withdid);
		ddataset_withoutdid := pDataset(not(ldataset_withdid));
		
		isDobValid(string pdob) :=
		function

			lremoveslashes := regexreplace('/',pdob,'');
			
			return if((unsigned)lremoveslashes != 0, true, false);

		end;		
		
		convertdob(unsigned pdob) :=
		function
		
			pdob_string := (string)pdob;
			reorder_it := 	pdob_string[5..6] 
										+ pdob_string[7..8] 
										+ pdob_string[1..4] 
										;
			
			return reorder_it;
		
		end;
		
		converttitle(string ptitle) := 
			map(
				 ptitle = 'MR' => 'M'
				,ptitle = 'MS' => 'F'
				,''
			);
			
		// Join to Watchdog best to get misc data
		djoin2watchdog := join(
		
			 pWatchdogBest
			,ddataset_withdid
			,left.did = right.did
			,transform(
				 Layouts.Temporary.UniqueId
				,
				 stblank					:= right.Subject.CURRENT_ADDRESS.Street_Name = '';
				 Street_Number		:= left.prim_range;
				 Street_Name			:= trim(Address.Addr1FromComponents(
																 left.predir
																,left.prim_name
																,left.suffix
																,left.postdir
																,'','',''
															),left,right);
				 APT_Unit_Number	:= trim(Address.Addr1FromComponents(
																 left.unit_desig
																,left.sec_range
																,'','','','',''
															),left,right);
				 City							:= left.city_name;
				 State 						:= left.st;
				 Zip_Code					:= left.zip;
				 
				 self.Subject.DOB_MMDDYYYY										:= if(isDobValid(right.Subject.DOB_MMDDYYYY)	,right.Subject.DOB_MMDDYYYY	,convertdob(left.dob)													);
				 self.clean_dates.dob													:= if(isDobValid(right.Subject.DOB_MMDDYYYY)	,right.clean_dates.dob			,left.dob																			);
				 self.Subject.DL															:= if(right.Subject.DL					 = ''					,left.DL_number							,right.Subject.DL															);
				 self.Subject.Gender													:= if(right.Subject.Gender			 = ''					,converttitle(left.title)		,right.Subject.Gender													);
				 self.Subject.CURRENT_ADDRESS.Street_Number		:= if(stblank																	,Street_Number							,right.Subject.CURRENT_ADDRESS.Street_Number	);
				 self.Subject.CURRENT_ADDRESS.Street_Name			:= if(stblank																	,Street_Name								,right.Subject.CURRENT_ADDRESS.Street_Name		);
				 self.Subject.CURRENT_ADDRESS.APT_Unit_Number	:= if(stblank																	,APT_Unit_Number						,right.Subject.CURRENT_ADDRESS.APT_Unit_Number);
				 self.Subject.CURRENT_ADDRESS.City						:= if(stblank																	,City												,right.Subject.CURRENT_ADDRESS.City						);
				 self.Subject.CURRENT_ADDRESS.State 					:= if(stblank																	,State 											,right.Subject.CURRENT_ADDRESS.State 					);
				 self.Subject.CURRENT_ADDRESS.Zip_Code				:= if(stblank																	,Zip_Code										,right.Subject.CURRENT_ADDRESS.Zip_Code				);
				                                                                   
				 self := right;
			)
			,right outer
		);
	
		dall := djoin2watchdog + ddataset_withoutdid	
						: persist(pPersistname);
						
		return dall;
	
	end;

	///////////////////////////////////////////////////////////////////////////
	// -- did_add.MAC_Add_SSN_By_DID to get ssn
	///////////////////////////////////////////////////////////////////////////
	export Get_DL_State(
	
		 dataset(Layouts.Temporary.UniqueId	)	pDataset
		,dataset(DriversV2.layout_dl				) pDLFile				= driversv2.file_dl
		,string																pPersistname	= persistnames().FillHoles_GetDLState
	
	) :=
	function
		
		ldataset_withoutDLState		:= pDataset.Subject.DL != '' and pDataset.Subject.DL_State = '';
		
		ddataset_withoutDLState	:= pDataset(ldataset_withoutDLState);
		ddataset_withDLState 		:= pDataset(not(ldataset_withoutDLState));

		djoin2Dls := join(
			 pDLFile
			,ddataset_withoutDLState
			,(string)left.dl_number = (string)right.Subject.DL
			,transform(
				 Layouts.Temporary.UniqueId
				,self.Subject.DL_State	:= left.orig_state;
				 self										:= right;
			)
			,right outer
		
		);

		dall := dedup(djoin2Dls + ddataset_withDLState, unique_id,all)
			: persist(pPersistname);
	
		return dall;
		
	end;

	export Get_Vin_Stuff(
	
		 dataset(Layouts.NormVehicles	)	pDataset
		,dataset(VehLic.Layout_VINA		) pVinaFile			= vehlic.file_vina
		,string													pPersistname	= persistnames().FillHoles_GetVinStuff
	
	) :=
	function
		
		ldataset_withoutVinYrmake		:= 			pDataset.Vehicle.VIN_Num != '' 
																	and (			pDataset.Vehicle.VIN_Yr		= ''
																				or  pDataset.Vehicle.VIN_Make = ''
																			)
																			;
		
		ddataset_withoutVinYrmake	:= pDataset(ldataset_withoutVinYrmake);
		ddataset_withVinYrmake 		:= pDataset(not(ldataset_withoutVinYrmake));

		djoin2Vina := join(
			 pVinaFile
			,ddataset_withoutVinYrmake
			,(string)left.vin = (string)right.Vehicle.VIN_Num
			,transform(
				 Layouts.NormVehicles
				,self.Vehicle.VIN_Yr		:= if((unsigned)right.Vehicle.VIN_Yr 	= 0 , left.model_year					,right.Vehicle.VIN_Yr		);
				 self.Vehicle.VIN_Make	:= if(right.Vehicle.VIN_Make					= '', left.vp_abbrev_make_name,right.Vehicle.VIN_Make	);
				 self										:= right;
			)
			,right outer
		
		);

		dall := dedup(djoin2Vina + ddataset_withVinYrmake, Quoteback,vehicle_num,all)
			: persist(pPersistname);
	
		return dall;
		
	end;


end;