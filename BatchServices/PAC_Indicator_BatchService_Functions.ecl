import address, autokey_batch, BatchServices, AutoStandardI;

export PAC_Indicator_BatchService_Functions := module

	//Function to get clean addresses
	export clean_batch(dataset(PAC_Indicator_BatchService_layouts.rec_batch_input) in_rec) := FUNCTION

			Autokey_batch.Layouts.rec_inBatchMaster clean_batch_in(PAC_Indicator_BatchService_layouts.rec_batch_input l, integer C) := TRANSFORM

				/* --- ADDRESS INFORMATION --- */
				addr1			 				:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
		                                     l.addr_suffix, l.postdir,
																				 '', l.sec_range);
				addr2 						:= Address.Addr2FromComponents(l.city, l.st, l.z5);
				addr1_final 			:= if (addr1 = '', l.addr, addr1);
				clean_addr 				:= address.GetCleanAddress(addr1_final,addr2,0);
				ca								:= clean_addr.results;

				self.prim_range 	:= ca.prim_range;
				self.prim_name 		:= ca.prim_name;
				self.sec_range 		:= ca.sec_range;
				self.addr_suffix 	:= ca.suffix;
				self.predir 			:= ca.predir;
				self.postdir 			:= ca.postdir;
				self.unit_desig 	:= ca.unit_desig;
				self.p_city_name 	:= ca.p_city;
				self.z5						:= ca.zip;

				/* --- PHONE INFORMATION ---   */
				clean_phone 			:= Stringlib.StringFilterOut(l.phoneno, '()-');
				self.homephone    := clean_phone;
				self.workphone 		:= clean_phone;

				self.acctno 			:= if(L.acctno = '', 'Z'+intformat(C,4,1) , L.acctno);

				self 							:= l;
			END;

		result :=  project(in_rec, clean_batch_in(LEFT, COUNTER));
		RETURN  result;

	END;

	shared global_module := AutoStandardI.GlobalModule();
	// Function to calculate the penalty based on address and phone.
	export penalt_func_calculate(Autokey_batch.Layouts.rec_inBatchMaster l,
													BatchServices.PAC_Indicator_BatchService_Layouts.joined_layout r)  := FUNCTION

				tempAddrMod := MODULE(PROJECT(global_module,
															 AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
				//	The 'input' address:
									EXPORT predir       	  := l.predir;
									EXPORT prim_name    	  := l.prim_name;
									EXPORT prim_range   	  := l.prim_range;
									EXPORT postdir        	:= l.postdir;
									EXPORT addr_suffix   		:= l.addr_suffix;
									EXPORT sec_range      	:= l.sec_range;
									EXPORT p_city_name    	:= l.p_city_name;
									EXPORT st            		:= l.st;
									EXPORT z5            		:= l.z5;

					//	The address in the matching record:
									EXPORT allow_wildcard	 	:= FALSE;
									EXPORT city_field      	:= r.clean_address.p_city_name;
									EXPORT city2_field     	:= '';
									EXPORT pname_field    	:= r.clean_address.prim_name;
									EXPORT postdir_field   	:= r.clean_address.postdir;
									EXPORT prange_field    	:= r.clean_address.prim_range;
									EXPORT predir_field   	:= r.clean_address.predir;
									EXPORT state_field    	:= r.clean_address.st;
									EXPORT sec_range_field	:= r.clean_address.sec_range;
									EXPORT suffix_field   	:= r.clean_address.addr_suffix;
									EXPORT zip_field      	:= r.clean_address.zip;
									EXPORT useGlobalScope 	:= FALSE;
						END;

						tempPhoneMod := module(project(global_module,
																	AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
						// The 'input' phone number:
									export phone 					:= L.homePhone;

						// The phone number in the matching record:
									export phone_field 		:= R.rawfields.phone;
						end;

					 return  AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempAddrMod)
									 + AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempPhoneMod);

						 // represents just one row penalty.
	END;

end;
