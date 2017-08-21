export MAC_Convert_File_Number(infile, outfile) := macro

 #uniquename(O_F_N)
 #uniquename(pre_conv_rec_temp)
 %pre_conv_rec_temp% := record
		infile;
		STRING9	%O_F_N%;	
  end;

 #uniquename(_move_file_number)
 %_move_file_number% := PROJECT(infile,
                              TRANSFORM(%pre_conv_rec_temp%,
                                        self.%O_F_N% := left.file_number;
					 			        self := LEFT));										


#uniquename(New_File_Number)
#uniquename(Old_File_Number)
#uniquename(lTmp1)
#uniquename(_bin)
									
%lTmp1% := RECORD,MAXSIZE(19)
 STRING9 %Old_File_Number%;
 STRING10 %New_File_Number%;
end;

%_bin% := DATASET('~thor_data400::sprayed::experian::filetobin',%lTmp1%,THOR);	
   
#uniquename(_joined_file)  
%_joined_file% := JOIN(%_move_file_number%,%_bin%,
                       trim(StringLib.StringToUpperCase(LEFT.%O_F_N%)) = 
	   			       trim(StringLib.StringToUpperCase(RIGHT.%Old_File_Number%)),
                       TRANSFORM(%pre_conv_rec_temp%,
				                 self.file_number := IF(RIGHT.%New_File_Number% <> '',
						                                RIGHT.%New_File_Number%,
									   			        LEFT.File_Number);
						         self := LEFT;),
				       LEFT OUTER,HASH);//(%O_F_N% <> ''); 



outfile := PROJECT(%_joined_file%,
                   TRANSFORM(%pre_conv_rec_temp%,
			                 SELF.file_number := if(regexreplace('[^[:alnum:]]',LEFT.file_number,'') <> '',
											                                    LEFT.file_number,
																				LEFT.%o_f_n%);
														 SELF := LEFT;)); 
											                                    


endmacro;