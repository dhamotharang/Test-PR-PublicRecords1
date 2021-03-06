EXPORT types := MODULE 

	// Assigns numeric values to available products using bitwise calculations (associated numbers in comment)
	EXPORT productMask := ENUM(UNSIGNED8, none = 0,
                                         bankruptcy = 1,                           //     1
                                         deceased = bankruptcy << 1,               //     2
                                         phone = deceased << 1,                    //     4
                                         address = phone << 1,                     //     8
                                         paw = address << 1,                       //    16
                                         property = paw << 1,                      //    32
                                         litigiousdebtor = property << 1,          //    64
                                         liens = litigiousdebtor << 1,             //   128
                                         criminal = liens << 1,                    //   256
                                         phonefeedback = criminal << 1,            //   512
                                         foreclosure = phonefeedback << 1,         //  1024
                                         workplace   = foreclosure << 1,		       //  2048
                                         reverseaddress = workplace << 1,		       //  4096
																				 didupdate = reverseaddress << 1,          //  8192
																				 bdidupdate = didupdate << 1,         		 //  16384
																				 phoneownership = bdidupdate << 1,				 //	 32768
																				 bipbestupdate = phoneownership << 1,			 //	 65536
																				 sbfe = bipbestupdate << 1,			 					 //	 131072
                                         allProducts = (sbfe << 1) - 1); 					 //  262143

	// Function used to verify whether a customer product mask (tstBits) contains a particular product 
	// ie: 3 contains both bankruptcy and deceased.
	EXPORT BOOLEAN testPMBits(productMask pm, productMask tstBits) := pm & tstBits <> 0;
END;