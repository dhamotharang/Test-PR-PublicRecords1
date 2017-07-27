bad_bytes := 	['21','85','0A','5B','5D','7C','A2','A8','AC','DD','4F','15','25','4A','58','BB','B0','BD','BA'];

convertEQ(string2 in_byte) := if(in_byte in bad_bytes,'21',in_byte);



export make_new_vendor(string18 vendor_id) := 
	convertEQ(vendor_id[1..2]) + convertEQ(vendor_id[3..4]) +
	convertEQ(vendor_id[5..6]) + convertEQ(vendor_id[7..8]) +  convertEQ(vendor_id[9..10]) +
	convertEQ(vendor_id[11..12]) + convertEQ(vendor_id[13..14]) + convertEQ(vendor_id[15..16]) +
	convertEQ(vendor_id[17..18]);