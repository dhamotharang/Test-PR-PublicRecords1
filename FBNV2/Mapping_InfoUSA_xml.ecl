IMPORT lib_stringlib;

TempRec :=RECORD

  Layout_File_InfoUsa_in;
  string seq;
End;
TempRec Trans_Flat(File_InfoUSA_Xml pInput) 
:= Transform
		SELF.Process_date := pInput.date_last_updated[7..10]+pInput.date_last_updated[1..2]+pInput.date_last_updated[4..5];
		SELF.bus_name := regexreplace(' ampersand| &amp;',pInput.bus_name,' &');
		SELF.BUS_DESCRIPTION := regexreplace(' ampersand| &amp;',pInput.bus_desc,' &');
		SELF.BUS_STR_ADDR := regexreplace(' ampersand| &amp;',pInput.bus_address_s1,' &');
		SELF.BUS_CITY := regexreplace(' ampersand| &amp;',pInput.bus_address_cy,' &');
		SELF.CNTCT_STR_ADDR := regexreplace(' ampersand| &amp;',pInput.contactpersonaddress_s1,' &');
		SELF.CNTCT_CITY := regexreplace(' ampersand| &amp;',pInput.contactpersonaddress_cy,' &');
		SELF.filingdate_mm := if(StringLib.StringFind(trim(pInput.filingdate,left,right),'/',1)=2,'0'+trim(pInput.filingdate,left,right)[1..1],trim(pInput.filingdate,left,right)[1..2]);
		SELF.filingdate_dd := map(
													StringLib.StringFind(pInput.filingdate,'/',2)= 4 =>'0'+pInput.filingdate[1..1],
													StringLib.StringFind(pInput.filingdate,'/',1)= 2 and StringLib.StringFind(pInput.filingdate,'/',2)= 5 =>pInput.filingdate[3..4],
													StringLib.StringFind(pInput.filingdate,'/',1)= 3 and StringLib.StringFind(pInput.filingdate,'/',2)= 5 =>'0'+pInput.filingdate[4..4],
													pInput.filingdate[4..5]);


		SELF.filingdate_yy := map(
													StringLib.StringFind(pInput.filingdate,'/',2)= 4 =>pInput.filingdate[5..8],
													StringLib.StringFind(pInput.filingdate,'/',2)= 5 =>pInput.filingdate[6..9],
													pInput.filingdate[7..10]);
		SELF.FILING_DATE := 
		//pInput.filingdate;
		SELF.filingdate_yy+SELF.filingdate_mm+SELF.filingdate_dd;
		SELF.InfoUSA_FBN_key := pInput.bus_address_st+pInput.bus_address_cy+hash64(pInput.bus_name,SELF.filingdate);
		//SELF.filingdate1 := 
		//pInput.filingdate;
		SELF.CCT_fullname :=regexreplace(' ampersand| &amp;', trim(pInput.CCT_firstname,left,right)+' '+trim(pInput.CCT_lastname,left,right)+' '+trim(pInput.CCT_suffix,left,right),' &');
		//SELF.Bus_Telephone_full := if(trim(pInput.Bus_Telephone_AreaCode,left,right) !='' or trim(pInput.Bus_Telephone_Number,left,right) !='',trim(pInput.Bus_Telephone_AreaCode,left,right) + '-'+trim(pInput.Bus_Telephone_Number,left,right),'');
		//SELF.ContactTelephone_full := if(trim(pInput.Telephone_AreaCode,left,right)!='' or trim(pInput.Telephone_Number,left,right)!='',trim(pInput.Telephone_AreaCode,left,right) +'-'+trim(pInput.Telephone_Number,left,right),'');
		SELF :=l;
end;

export File_Out_AllFlat := Project(Fictitious_Bus__Names.File_Out_AllwithProcessDate,Trans_Flat(left)):Persist('~thor_data400::persist::Infousa_fbn_flat');export Mapping_InfoUSA_xml := 'todo';