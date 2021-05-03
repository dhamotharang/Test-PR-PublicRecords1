import dx_common;

EXPORT Layouts := module

//For CCPA
EXPORT DEFLT_CPA := RECORD
 unsigned4 global_sid;
 unsigned8 record_sid;
 end;

//For the Cloud
EXPORT DELTA_RID := dx_common.layout_ridkey;

EXPORT METADATA := dx_common.layout_metadata; 

end; 