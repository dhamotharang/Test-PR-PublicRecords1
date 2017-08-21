EXPORT mac_landflipOutputBLJFOFile(STATE, FO) := MACRO

	IMPORT landflip		
	   , header_slimsort
		 , address
		 , lib_stringlib;

	#uniquename(filename)
	string %filename% := '' : stored('filename');

	//Project records with FO into BLJ layout without FO
 	#uniquename(pLandflipBLJRec)
	#uniquename(pCleanedBLJRec)
	#uniquename(tBLJclean)
	#uniquename(tCleanToBLJRec)
	
	landflip.layout_CleanedBLJRec %tBLJclean%(landflip.mapping_landflipFORecs pInput)
		:=
			TRANSFORM
				self.clean_address	:=	address.CleanAddress182(TRIM(pInput.str_info), TRIM(pInput.str_city) + ' ' + TRIM(pInput.str_zip9));
				self								:= 	pInput;
			END
	;
	
	%pCleanedBLJRec%	:=	PROJECT(landflip.mapping_landflipFORecs(state_cd = STATE AND field_office = FO AND transfer_days = ''), %tBLJclean%(left));
	
	landflip.layout_landflipBLJRec %tCleanToBLJRec%(%pCleanedBLJRec% pInput)
		:=
			TRANSFORM
			self.str_num			:=	pInput.clean_address[1..10];
			self.str_dir			:=	pInput.clean_address[11..12];
			self.str_name			:=	pInput.clean_address[13..40];
			self.str_suffix		:=	pInput.clean_address[41..44];
			self.str_post_dir	:=	pInput.clean_address[45..46];
			self.str_unit			:=	TRIM(TRIM(pInput.clean_address[47..56]) + ' ' + TRIM(pInput.clean_address[57..64]));
			self.str_city			:=	pInput.clean_address[90..114];
			self.str_zip_4		:=	pInput.str_zip9[7..10];
			self							:=	pInput;
			END
	;
	
  %pLandflipBLJRec%	:=	PROJECT(%pCleanedBLJRec%, %tCleanToBLJRec%(left));
   
   	OUTPUT(%pLandflipBLJRec%
   	     ,
   			 , '~thor_data400::out::BLJ_RPT_' + FO + '_' + %filename% + '.txt'
   			 , CSV(SEPARATOR('|'), TERMINATOR('\n'), QUOTE(''))
   			 , OVERWRITE
   			 );


ENDMACRO;