import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_NE(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_NE_Update(fileDate);

	layout_out := DriversV2.Layouts_DL_NE_In.Layout_NE_With_Clean;


			TrimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;
			
	layout_out mapClean(in_file l) := transform
	
		self.DLN       	      := if((integer)stringlib.stringfilter(l.DLN,'0123456789')<>0,trim(l.DLN,left,right),'');                     
		self.NAME       	  := trimUpper(l.NAME)  ;                    		
		self.DOB              := if((integer)stringlib.stringfilter(l.DOB,'0123456789')<>0,trim((l.DOB[7..10] + l.DOB[1..2] + l.DOB[4..5]),left,right),''); 
		self.ADDRESS_STREET   := trimUpper(l.ADDRESS_STREET)  ; 				
		self.ADDRESS_CITY     := trimUpper(l.ADDRESS_CITY)  ;            	    
		self.ADDRESS_STATE    := trimUpper(l.ADDRESS_STATE)  ;           	   
		self.ADDRESS_ZIP5     := if((integer)stringlib.stringfilter(l.ADDRESS_ZIP5,'0123456789')<>0,stringlib.stringfilter(l.ADDRESS_ZIP5,'0123456789'),'');   			    
		self.ADDRESS_ZIP4     := if((integer)stringlib.stringfilter(l.ADDRESS_ZIP4,'0123456789')<>0,stringlib.stringfilter(l.ADDRESS_ZIP4,'0123456789'),''); 			    
		self.GENDER        	  := trimUpper(l.GENDER)  ;                	    
		self.HEIGHT           := if((integer)stringlib.stringfilter(l.HEIGHT,'0123456789')<>0,trim(l.HEIGHT,left,right),'');                  	   
		self.WEIGHT           := if((integer)stringlib.stringfilter(l.WEIGHT,'0123456789')<>0,trim(l.WEIGHT,left,right),'');                  	    
		self.EYE_COLOR        := trimUpper(l.EYE_COLOR)  ;              	                       
		self.HAIR_COLOR       := trimUpper(l.HAIR_COLOR)  ;
		self.License_Type	  := trimUpper(l.LICENSE_TYPE)  ;
		string73 tempName     := stringlib.StringToUpperCase(if(trim(l.Name,left,right) <> '',
															Address.CleanPersonLFM73(trim(l.Name,left,right)),
															''));
		
		self.title           := tempName[1..5];
		self.fname           := tempName[6..25];
		self.mname           := tempName[26..45];
		self.lname           := tempName[46..65];
		self.name_suffix	 := tempName[66..70];
		self.cleaning_score	 := tempName[71..73];
		self.prim_range      := '';
		self.predir 	       := '';
		self.prim_name 	     := '';
		self.suffix          := '';
		self.postdir 	       := '';
		self.unit_desig 	   := '';
		self.sec_range 	     := '';
		self.p_city_name	   := '';
		self.v_city_name	   := '';
		self.state	         := '';
		self.zip 		         := '';
		self.zip4 		       := '';
		self.cart 		       := '';
		self.cr_sort_sz 	   := '';
		self.lot 		         := '';
		self.lot_order 	     := '';
		self.dpbc 		       := '';
		self.chk_digit 	     := '';
		self.rec_type	       := '';
		self.ace_fips_st	   := '';
		self.county     	   := '';
		self.geo_lat 	       := '';
		self.geo_long 	     := '';
		self.msa 		         := '';
		self.geo_blk         := '';
		self.geo_match 	     := '';
		self.err_stat 	     := '';
		self.process_date    :=processDate;
		self                 := l;		
	end;

	Cleaned_NE_File := project(in_file, mapClean(left));
	
	return Cleaned_NE_File;
end;