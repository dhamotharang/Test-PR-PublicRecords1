// translate the vendor source code that was changed from 5 character field to 1 character field										
export Translate_Vendor_Source_Flag(string1 vendor_source_flag) := 		
				map(vendor_source_flag='F' => 'FAR_F',
					vendor_source_flag='S' => 'FAR_s',
					vendor_source_flag='O' => 'OKCTY',
					vendor_source_flag='D' => 'DAYTN',
					'');