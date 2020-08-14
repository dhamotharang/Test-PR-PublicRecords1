IMPORT doxie;

EXPORT Layouts_RTBatch_V2 := MODULE

  EXPORT rec := RECORD(VehicleV2_Services.Batch_Layout.RealTime_InLayout)
    doxie.layout_inBatchMaster.prim_range;
    doxie.layout_inBatchMaster.predir;
    doxie.layout_inBatchMaster.prim_name;
    doxie.layout_inBatchMaster.addr_suffix;
    doxie.layout_inBatchMaster.postdir;
    doxie.layout_inBatchMaster.unit_desig;
    doxie.layout_inBatchMaster.sec_range;
    doxie.layout_inBatchMaster.zip4;
  END;
  
  EXPORT rec_V2 := RECORD(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2)
    doxie.layout_inBatchMaster.prim_range;
    doxie.layout_inBatchMaster.predir;
    doxie.layout_inBatchMaster.prim_name;
    doxie.layout_inBatchMaster.addr_suffix;
    doxie.layout_inBatchMaster.postdir;
    doxie.layout_inBatchMaster.unit_desig;
    doxie.layout_inBatchMaster.sec_range;
    doxie.layout_inBatchMaster.zip4;
  END;
  
  EXPORT rec_out := RECORD
    UNSIGNED seq := 0;
    STRING3 hit_flag;
    STRING50 reg_1_best_addr1;
    STRING25 reg_1_best_city;
    STRING2 reg_1_best_state;
    STRING9 reg_1_best_zip;
    STRING10 reg_1_best_phone;
    STRING50 reg_2_best_addr1;
    STRING25 reg_2_best_city;
    STRING2 reg_2_best_state;
    STRING9 reg_2_best_zip;
    STRING10 reg_2_best_phone;
    VehicleV2_Services.Batch_Layout.final_layout;
  END;

END;
