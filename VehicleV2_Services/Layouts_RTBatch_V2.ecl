import doxie;

export Layouts_RTBatch_V2 := module

	export rec := record(VehicleV2_Services.Batch_Layout.RealTime_InLayout)
		doxie.layout_inBatchMaster.prim_range;
		doxie.layout_inBatchMaster.predir;
		doxie.layout_inBatchMaster.prim_name;
		doxie.layout_inBatchMaster.addr_suffix;
		doxie.layout_inBatchMaster.postdir;
		doxie.layout_inBatchMaster.unit_desig;
		doxie.layout_inBatchMaster.sec_range;
		doxie.layout_inBatchMaster.zip4;
	end;
	
	export rec_V2 := record(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2)
		doxie.layout_inBatchMaster.prim_range;
		doxie.layout_inBatchMaster.predir;
		doxie.layout_inBatchMaster.prim_name;
		doxie.layout_inBatchMaster.addr_suffix;
		doxie.layout_inBatchMaster.postdir;
		doxie.layout_inBatchMaster.unit_desig;
		doxie.layout_inBatchMaster.sec_range;
		doxie.layout_inBatchMaster.zip4;
	end;
	
	export rec_out := record
		unsigned		seq := 0;
		string3 		hit_flag;
		string50    reg_1_best_addr1;
		string25  	reg_1_best_city;
		string2   	reg_1_best_state;
		string9   	reg_1_best_zip;
		string10		reg_1_best_phone;
		string50    reg_2_best_addr1;
		string25  	reg_2_best_city;
		string2   	reg_2_best_state;
		string9   	reg_2_best_zip;
		string10		reg_2_best_phone;
		VehicleV2_Services.Batch_Layout.final_layout;		
	end;

end;