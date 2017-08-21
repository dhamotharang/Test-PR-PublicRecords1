import ut, Address, BIPV2, Business_Header, Business_Header_SS, did_add,lib_stringlib,idl_header;

dDemo_Input_File:= EBR.BDID_5610_Demo_Input_Norm;
segment_code 		:= '5610';

// -- Get Base File
ebr.GetSegmentFile_Base(segment_code, dDemo_Base_File);

// -- Append Input File to Base File
combined_demo 		:= dDemo_Base_File + dDemo_Input_File;

// -- Slim Layout
slim_demo_layout := record
  string8		process_date;
  string10	file_number;
  address.layout_clean_name clean_officer_name;
end;

dSlim_Demo 				:= project(combined_demo,transform(slim_demo_layout,self := left));

// -- Remove duplicate records
dedup_dSlim_Demo 	:= dedup(dSlim_Demo,record);

export BDID_5610_Demo_For_Header := dedup_dSlim_Demo;