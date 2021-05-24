EXPORT Regulatory := module
import gong_Neustar, Suppress ;

export string_gong_layout := {
						string3           bell_id := 'NEU';		//  
						string11          filedate;						// Use the date we run (weekly or monthly)
						string1           dual_name_flag := 'N';
						string10          sequence_number;
						string1           listing_type_bus := '';
						string1           listing_type_res := 'R';
						string1           listing_type_gov := '';
						string1           publish_code := 'P';
						string1           style_code := 'X';
						string1           indent_code := '0';
						string20          book_neighborhood_code := '';
						string3           prior_area_code := '';
						string10          phone10; 
						string10          prim_range;
						string2           predir;
						string28          prim_name;
						string4           suffix;
						string2           postdir;
						string10          unit_desig;
						string8           sec_range;
						string25          p_city_name;
						string2           v_predir;
						string28          v_prim_name;
						string4           v_suffix;
						string2           v_postdir;
						string25          v_city_name;
						string2           st;
						string5           z5;
						string4           z4 := '';
						string4           cart :='';
						string1           cr_sort_sz := 'N';
						string4           lot := '';
						string1           lot_order := '';
						string2           dpbc := '';
						string1           chk_digit := '';
						string2           rec_type := '';
						string5           county_code;
						string10          geo_lat := '';
						string11          geo_long := '';
						string4           msa := '';
						string7           geo_blk := '';
						string1           geo_match := '';
						string4           err_stat := 'S000';
						string32          designation := '';
						string5           name_prefix;
						string20          name_first;
						string20          name_middle;
						string20          name_last;
						string5           name_suffix;
						string120         listed_name;
						string254         caption_text := '';
						string10          group_id;
						string10          group_seq;
						string1			  		omit_address := 'N';
						string1			  		omit_phone := 'N';
						string1			  		omit_locality := 'N';
						string64          see_also_text := '';
						unsigned6 				did;
						unsigned6 				hhid := 0;
						unsigned6					bdid := 0;
						string8 					dt_first_seen;
						string8 					dt_last_seen;
						string1 					current_record_flag := 'Y';  // This is a must!
						string8 					deletion_date := '';
						unsigned2 				disc_cnt6 := 0;
						unsigned2 				disc_cnt12 := 0;
						unsigned2 				disc_cnt18 := 0;
	
						// business fields linIDs
						/*
	 				  unsigned6 dotid;
						unsigned2 dotscore;
						unsigned2 dotweight;
						unsigned6 empid;
						unsigned2 empscore;
						unsigned2 empweight;
						unsigned6 powid;
						unsigned2 powscore;
						unsigned2 powweight;
						unsigned6 proxid;
						unsigned2 proxscore;
						unsigned2 proxweight;
						unsigned6 seleid;
						unsigned2 selescore;
						unsigned2 seleweight;
						unsigned6 orgid;
						unsigned2 orgscore;
						unsigned2 orgweight;
						unsigned6 ultid;
						unsigned2 ultscore;
						unsigned2 ultweight;
            */
						//
						// CCPA-22 CCPA new fields added  
						unsigned4 global_sid := 0;
						unsigned8 record_sid := 0;
						
						string2  					eor := '';
	};
	
	export applyGongNeustar(baseIn) := functionmacro
	
      import Suppress , Gong_Neustar ;
			      local gong_append_in := Suppress.applyRegulatory.getFile('file_gong_inj.txt', Gong_Neustar.Regulatory.string_gong_layout);
						
            local reformat := recordof(baseIn) ; 
	
            local gong_in := PROJECT(gong_append_in, Transform(reformat,
									self.Persistent_Record_id := (unsigned8)0x7FFFFFFFFFFFFFFF - COUNTER;
									self := left;
									self := [] ));
									
				    return baseIn + gong_in ;
		endmacro ;	
	
	
		export applyGongNeustarSup(baseIn) :=  
				functionmacro
						import suppress;
	         
						local phone_hash(recordof(baseIn) L) := hashmd5(TRIM(l.phone10[4..10]+ l.phone10[1..3], left, right));
						local phone_Suppress := suppress.applyregulatory.simple_sup(baseIn,'gong_sup.txt', phone_hash);
						
						return phone_Suppress;
				endmacro;
				
		export applyGongNeustarInj(baseIn) := functionmacro
	
      import Suppress , Gong_Neustar ;
			      local gong_append_in := Suppress.applyRegulatory.getFile('file_gong_inj.txt', Gong_Neustar.Regulatory.string_gong_layout);
						
            local reformat := recordof(baseIn) ; 
	
            local gong_in := PROJECT(gong_append_in, Transform(reformat,
									self := left;
									self := [] ;));
									
				   return baseIn + gong_in ;
		endmacro ;			
//
// perform get functions using applyRegulatory
//
		export getGongNeustarSup() := 
				functionmacro						
						import suppress;

						return suppress.applyregulatory.getFile('gong_sup.txt', suppress.applyregulatory.layout_in);
				endmacro; 

		export getGongNeustarInj() := 
				functionmacro										
						import suppress;

						return	suppress.applyregulatory.getFile('file_gong_inj.txt', Gong_Neustar.Regulatory.string_gong_layout);
				endmacro; 

	
end ; // end of module