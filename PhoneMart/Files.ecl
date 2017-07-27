IMPORT PhoneMart, ut, header;

EXPORT Files := MODULE

	//Convert CID HEX field
	PhoneMart_CMS_in := dataset('~thor_data400::in::phonemart::cms', PhoneMart.Layouts.CMS_RAW, flat);
	
	PhoneMart.Layouts.CMS ConvertCID(PhoneMart_CMS_in L) := TRANSFORM
		self.CID_NUMBER := Header.Cid_Converter(L.CID_NUMBER[1])+
											 Header.Cid_Converter(L.CID_NUMBER[2])+
											 Header.Cid_Converter(L.CID_NUMBER[3])+
											 Header.Cid_Converter(L.CID_NUMBER[4])+
											 Header.Cid_Converter(L.CID_NUMBER[5])+
											 Header.Cid_Converter(L.CID_NUMBER[6])+
											 Header.Cid_Converter(L.CID_NUMBER[7])+
											 Header.Cid_Converter(L.CID_NUMBER[8])+
											 Header.Cid_Converter(L.CID_NUMBER[9]);
		self := L;
	END;
	
	EXPORT PhoneMart_CMS 		:= project(PhoneMart_CMS_in, ConvertCID(left));
	EXPORT PhoneMart_CSD 		:= dataset('~thor_data400::in::phonemart::csd', PhoneMart.Layouts.CSD, flat);
	// EXPORT PhoneMart_CSD 		:= dataset(ut.foreign_prod+'thor_data400::in::phonemart_ln::phonemart2ln.03_24_2015_154701', PhoneMart.Layouts.CSD, flat);
	EXPORT PhoneMart_Indv 	:= dataset('~thor_data400::in::phonemart::indv', PhoneMart.Layouts.Indv, flat);
	// EXPORT PhoneMart_Indv 	:= dataset(ut.foreign_prod+'thor_data400::in::phonemart_ln::phonemart3ln.03_24_2015_155001', PhoneMart.Layouts.Indv, flat);
	EXPORT base						 	:= dataset('~thor_data400::base::phonemart', PhoneMart.Layouts.base, flat);
	
END;