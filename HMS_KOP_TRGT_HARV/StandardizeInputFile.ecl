IMPORT  lib_stringlib, hms_kop_trgt_harv;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE


		EXPORT koptrgtharv	:= FUNCTION

			baseFile := dataset(hms_kop_trgt_harv.Filenames(filedate,pUseProd).trgtharv_lInputTemplate, hms_kop_trgt_harv.layouts.layout_in, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));


   		hms_kop_trgt_harv.Layouts.layout_base tMapping(hms_kop_trgt_harv.Layouts.layout_in L) := TRANSFORM

   			// SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
   			// SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
   			// SELF.Dt_first_seen						:= 0;
   			// SELF.Dt_last_seen							:= 0;

				SELF.append_prep_address1					:= TRIM(Stringlib.StringToUpperCase(trim(L.address1,left,right) + if(trim(L.address2,left,right)<>'',',','') +  trim(L.address2,left,right)), LEFT, RIGHT);
				SELF.append_prep_addresslast          := TRIM(Stringlib.StringToUpperCase(
																							StringLib.StringCleanSpaces(	trim(L.city,left,right) + if(trim(L.city,left,right) <> '',',','')
																		+ ' '+ trim(L.state,left,right)
																		+ ' '+ trim(L.zip,left,right)[..5]
																		)),LEFT,RIGHT);




				SELF.clean_stlic_issue_date				:= (unsigned4)hms_kop_trgt_harv.fn_cleanDate(L.stlic_issue_date);
				SELF.clean_stlic_exp_date	:= (unsigned4)hms_kop_trgt_harv.fn_cleanDate(L.stlic_exp_date);


				SELF  :=  L;
   			SELF  :=  [];
   		END;

   		RETURN PROJECT(baseFile, tMapping(LEFT));

   	END;

END;
