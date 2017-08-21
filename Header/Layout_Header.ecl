import header;
boolean is_hdrbuild:=true ; // for header build set to true so it will build the file in new layout 
 
header.Mac_layout_header(Header.layout_header_v2,is_hdrbuild,outlayout); 

export Layout_Header :=  outlayout;
