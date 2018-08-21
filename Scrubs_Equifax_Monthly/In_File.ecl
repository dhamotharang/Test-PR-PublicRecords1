IMPORT Data_Services,EQ_Hist,header;

rec := EQ_Hist.Layout.current_raw;

monthly_file :=	header.file_header_in().monthly_file;

c1(ebcdic string1 _c) := header.Cid_Converter(_c);
convert_cid(ebcdic string9  id) := c1(id[1])+c1(id[2])+c1(id[3])+c1(id[4])
																	+c1(id[5])+c1(id[6])+c1(id[7])+c1(id[8])+c1(id[9]);
	 

file := project(monthly_file,transform(recordof(monthly_file),self.cid:= convert_cid(left.cid),self:=left));

EXPORT In_File := file;