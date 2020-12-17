import dx_common;

export Layout_6000_Inquiries_Base := 
record
   Layout_Base;
   string8   process_date;
   string10  FILE_NUMBER;
   string4   SEGMENT_CODE;
   string5   SEQUENCE_NUMBER;
   string4   BUS_CODE;
   string10  BUS_DESC;
   string2   INQ_MM;
   string2   INQ_YY;
   string3   INQ_COUNT;
  dx_common.layout_metadata - [global_sid, record_sid];
end;