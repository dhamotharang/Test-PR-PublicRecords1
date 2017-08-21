/*
**********************************************************************************
Created by    Comments
Vani 		    This attribute 
            1)Joins the addresses and HRA file to get sic_code
							
***********************************************************************************
*/	

import address,Business_header;
   Temp_Layout_Address_list := RECORD 
    Layout_Address_list;
    Files_used.layout_Header_file.phone;
  end;

  //D_Combined_Address_list := Mapping_Dedup_Address;
	D_Combined_Address_list := DISTRIBUTE(Mapping_Dedup_Address,HASH(prim_range,predir,prim_name ,addr_suffix,postdir,zip));
	//DISTRIBUTE(Mapping_Dedup_Address,HASH(prim_range,predir,prim_name ,addr_suffix,postdir,unit_desig,zip));
  D_HRA_File := DISTRIBUTE(Files_used.Risk_indicators_HRA_file,HASH(prim_range,predir,prim_name ,addr_suffix,postdir,zip));
  Layout_HRA_list Join_Addr_HRA(Temp_Layout_Address_list L, Files_used.Layout_HRA R) := TRANSFORM
    
		SELF.sic_code := R.sic_code;
    SELf.sic_desc := IF (R.sic_code <> '',Business_header.Decode_SIC4(R.sic_code),'');
		SELF:=L;
  end;	
	
	Address_list_HRA  	  := JOIN(D_Combined_Address_list, D_HRA_File, 
	                              trim(LEFT.prim_range)  = trim(RIGHT.prim_range) and
																trim(LEFT.predir)      = trim(RIGHT.predir) and
																trim(LEFT.prim_name)   = trim(RIGHT.prim_name) and 
																trim(LEFT.addr_suffix) = trim(RIGHT.addr_suffix) and
																trim(LEFT.postdir)     = trim(RIGHT.postdir) and 
																//trim(LEFT.unit_desig)  = trim(RIGHT.unit_desig) and  (Not required per Jill)
																//trim(LEFT.sec_range)   = trim(RIGHT.sec_range) and   (Not required per Jill)
																trim(LEFT.zip)         = trim(RIGHT.zip),
								                Join_Addr_HRA(LEFT,RIGHT), LOCAL);	
export Mapping_Extract_HRA_List := Address_list_HRA ;//: persist ('persist::IMAP::HRA_List');