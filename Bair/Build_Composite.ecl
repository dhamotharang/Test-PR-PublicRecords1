import Bair_composite,PromoteSupers,std;

EXPORT Build_Composite(string version = '', boolean pUseProd = false, boolean pDelta = false) := module
	
	shared NewHeader := Bair.HeaderInfo.IsNew;
	
	shared compDS := Bair.GenerateDID_Payload(version, pUseProd, pDelta);
	PromoteSupers.MAC_SF_BuildProcess(compDS,'~thor400_data::base::composite_public_safety_data_curr_delta', out_delta_comp,2,,true,pVersion:=version);

	clf := '~thor400_data::base::composite_public_safety_data_curr_delta_' + version;
	export bld_curr_delta := if(STD.File.FileExists(clf), output(clf + ' already exist;'), out_delta_comp);
	
	shared linkflags	 		 := 'left.eid = right.eid,left only, local';
		
	comp_prev_d	:= distribute(bair_composite.Files(pUseProd,true).composite_base, hash(eid));
	comp_prev_f	:= distribute(bair_composite.Files(pUseProd,false).composite_base, hash(eid));	
	comp_curr_d := distribute(dataset('~thor400_data::base::composite_public_safety_data_curr_delta', Bair.layouts.rCompositeBase, flat), hash(eid));
	
	prev := if(pDelta, comp_prev_d, comp_prev_f);
	curr := if(pDelta, comp_curr_d, comp_prev_d);
		
	bair.MAC_Join(resNonEve, prev(Prepped_rec_type not in [Bair._Constant.Events_Mo_address_of_crime, Bair._Constant.Events_Persons_persons_address, Bair._Constant.Events_Vehicle_vehicle_address]),curr(Prepped_rec_type not in [Bair._Constant.Events_Mo_address_of_crime, Bair._Constant.Events_Persons_persons_address, Bair._Constant.Events_Vehicle_vehicle_address]),linkflags);
	bair.MAC_Join(resMo,  prev(Prepped_rec_type = Bair._Constant.Events_Mo_address_of_crime),curr(Prepped_rec_type = Bair._Constant.Events_Mo_address_of_crime),linkflags);
	bair.MAC_Join(resPer, prev(Prepped_rec_type = Bair._Constant.Events_Persons_persons_address),curr(Prepped_rec_type = Bair._Constant.Events_Persons_persons_address),linkflags);
	bair.MAC_Join(resVeh, prev(Prepped_rec_type = Bair._Constant.Events_Vehicle_vehicle_address),curr(Prepped_rec_type = Bair._Constant.Events_Vehicle_vehicle_address),linkflags);

	res_ 	:= resNonEve + resMo + resPer + resVeh;
	
	res 	:= if(pDelta
								,if(Bair.BuildInfo.DeltaToBeFlushed
										,comp_curr_d
										,res_
										)
								,if(NewHeader
										,compDS
										,project(res_, transform(Bair.layouts.rCompositeBase,self.Sequence:=0; self:=left;))
										)
							);
	PromoteSupers.MAC_SF_BuildProcess(res, bair_composite.Filenames(pUseProd,pDelta).composite_input, out_comp,2,,true,pVersion:=version);

	lf := '~thor400_data::base::composite_public_safety_data_delta_' + version;	
	export bld_all := if(STD.File.FileExists(lf), output(lf + ' already exist;'), out_comp);	
	
END;