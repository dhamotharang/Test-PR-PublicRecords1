EXPORT types := MODULE 
	EXPORT productMask := ENUM(UNSIGNED8, none = 0,
																				bankruptcy = 1,                      //    1
																				deceased = bankruptcy << 1,          //    2
																				phone = deceased << 1,               //    4
																				address = phone << 1,                //    8
																				paw = address << 1,                  //   16
																				property = paw << 1,                 //   32
																				litigiousdebtor = property << 1,     //   64
																				liens = litigiousdebtor << 1,        //  128
																				criminal = liens << 1,               //  256
																				phonefeedback = criminal << 1,       //  512
																				foreclosure = phonefeedback << 1,    // 1024
																				workplace   = foreclosure << 1,		   // 2048
																				allProducts = (workplace << 1) - 1); // 4095

	EXPORT BOOLEAN testPMBits(productMask pm, productMask tstBits) := pm & tstBits <> 0;
END;