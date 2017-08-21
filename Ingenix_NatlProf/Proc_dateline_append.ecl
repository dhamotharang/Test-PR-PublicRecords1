import watchdog,ut,_control ; 
ds := Ingenix_NatlProf.Basefile_Sanctions(          (StringLib.StringFind(StringLib.StringToUpperCase(sanc_type),'DENIED',1)!=0 or  
                                                    StringLib.StringToUpperCase(trim(sanc_type,left,right))='DEBARRED/EXCLUDED' or
                                                    StringLib.StringToUpperCase(trim(sanc_type,left,right))='PROBATION') and
                                                    sanc_sancdte_form between '20100101' and '20101231');
                                                                                                                                                                                                                                                                                                                   
SlimLayout := record
              string Date_first_seen; 
              string Date_last_seen;
              string did ; 
			  string  Sanc_tin;
              string Sanc_upin;
              string  Sanc_unamb_ind;
	          string Prov_clean_title;
              string Prov_clean_fname;
              string Prov_clean_mname;
              string best_phone := ''; 
              string best_street_address := ''; 
              string best_city:=''; 
			  string best_st:= '' ; 
			  string best_zip := ''; 
			  string best_zip4 := ''; 
              string  SANC_ID;
              string  SANC_LNME;
              string  SANC_FNME;
              string  SANC_MID_I_NM ;
              string  SANC_BUSNME   ;
              string  SANC_DOB      ;
             string  CLEAN_STREET   ; 
              string  CLEAN_CITY     ;
              string  CLEAN_ZIP      ;
			  string  CLEAN_ZIP4      ;
			  string  CLEAN_STATE ;
              string  SANC_PROVTYPE ;
              string SANC_SANCDTE_form;
              string  SANC_SANCDTE ;
              string  SANC_SANCST ;
              string  SANC_LICNBR ;
              string  SANC_BRDTYPE ;
              string  SANC_SRC_DESC ;
              string  SANC_TYPE ;
             string  SANC_REAS ;
             string  SANC_TERMS ;
              string  SANC_COND ;
              string  SANC_FINES ;
              string  SANC_FAB ;
              string SANC_UPDTE_form;
              string  SANC_UPDTE ;
end;

slimLayout        trfstandardize(ds l)         :=         transform

            self.SANC_ID                                        :=         StringLib.StringToUpperCase(l.SANC_ID  );
            self.SANC_LNME                                  := StringLib.StringToUpperCase(StringLib.stringfilter(l.SANC_LNME, ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'));
            self.SANC_FNME                                  := StringLib.StringToUpperCase(StringLib.stringfilter(l.SANC_FNME, ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'));
            self.SANC_MID_I_NM    := StringLib.StringToUpperCase(StringLib.stringfilter(l.SANC_MID_I_NM, ' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'));
            self.SANC_BUSNME                 := StringLib.StringToUpperCase(l.SANC_BUSNME           );
            self.SANC_DOB                                                := StringLib.StringToUpperCase(l.SANC_DOB      );
            self.CLEAN_STREET                 := StringLib.StringToUpperCase(StringLib.StringCleanSpaces(            l.ProvCo_Address_Clean_prim_range       + ' ' +
                                                          l.ProvCo_Address_Clean_predir                           + ' ' +
                                                          l.ProvCo_Address_Clean_prim_name                         + ' ' +
                                                          l.ProvCo_Address_Clean_addr_suffix             + ' ' +
                                                          l.ProvCo_Address_Clean_postdir                         + ' ' +
                                                          l.ProvCo_Address_Clean_unit_desig             + ' ' +
                                                          l.ProvCo_Address_Clean_sec_range));

            self.CLEAN_CITY                                   := StringLib.StringToUpperCase(l.ProvCo_Address_Clean_p_city_name);
            self.CLEAN_ZIP                         := StringLib.StringToUpperCase(l.ProvCo_Address_Clean_zip);
            self.CLEAN_STATE                   := StringLib.StringToUpperCase(l.ProvCo_Address_Clean_st);
            self.CLEAN_ZIP4                  := l.ProvCo_Address_Clean_zip4; 
			self.SANC_PROVTYPE  := StringLib.StringToUpperCase(l.SANC_PROVTYPE       );
            self.SANC_SANCDTE_form        := StringLib.StringToUpperCase(l.SANC_SANCDTE_form  );
            self.SANC_SANCDTE                := StringLib.StringToUpperCase(l.SANC_SANCDTE          );
            self.SANC_SANCST                  := StringLib.StringToUpperCase(l.SANC_SANCST            );
            self.SANC_LICNBR                    := StringLib.StringToUpperCase(l.SANC_LICNBR );
            self.SANC_BRDTYPE                := StringLib.StringToUpperCase(l.SANC_BRDTYPE          );
            self.SANC_SRC_DESC  := StringLib.StringToUpperCase(l.SANC_SRC_DESC       );
            self.SANC_TYPE                                   := StringLib.StringToUpperCase(l.SANC_TYPE    );
            self.SANC_REAS                                  := StringLib.StringToUpperCase(l.SANC_REAS    );
            self.SANC_TERMS                                := StringLib.StringToUpperCase(l.SANC_TERMS  );
            self.SANC_COND                                  := StringLib.StringToUpperCase(l.SANC_COND    );
            self.SANC_FINES                                  := StringLib.StringToUpperCase(l.SANC_FINES   );
            self.SANC_FAB                                     := StringLib.StringToUpperCase(l.SANC_FAB      );
            self.SANC_UPDTE_form := StringLib.StringToUpperCase(l.SANC_UPDTE_form      );
            self.SANC_UPDTE                     := StringLib.StringToUpperCase(l.SANC_UPDTE  );
			
            self := l ; 
end;

slim_file := PROJECT(ds,trfstandardize(LEFT));

// append best address and best phone 
fbest := Watchdog.File_Best ; 

j := join( fbest , distribute(slim_file ,hash((unsigned)did)) , left.did =(unsigned) right.did 
                             , transform ( { slimLayout} , 
							  self.best_street_address := StringLib.StringToUpperCase(StringLib.StringCleanSpaces(            left.prim_range       + ' ' +
                                                          left.predir                           + ' ' +
                                                          left.prim_name                         + ' ' +
                                                          left.suffix             + ' ' +
                                                          left.postdir                         + ' ' +
                                                          left.unit_desig             + ' ' +
                                                          left.sec_range));
							  self.best_st := left.st; 
							  self.best_city := left.city_name ; 
							  self.best_zip := left.zip; 
							  self.best_zip4 := left.zip4 ; 
							  self.best_phone := left.phone; 
							  self := right), right outer , local):persist('ingenix_best') ; 
							  

file_v_ingenix := output(j,,'~thor_data::out::ingenix_bestappend_'+ut.GetDate,csv(
HEADING('date_first_seen|date_last_seen|did|sanc_tin|sanc_upin|sanc_unamb_ind|prov_clean_title|prov_clean_fname|prov_clean_mname|best_phone|best_street_address|best_city|best_st|best_zip|best_zip4|sanc_id|sanc_lnme|sanc_fnme|sanc_mid_i_nm|sanc_busnme|sanc_dob|clean_street|clean_city|clean_zip|clean_zip4|clean_state|sanc_provtype|sanc_sancdte_form|sanc_sancdte|sanc_sancst|sanc_licnbr|sanc_brdtype|sanc_src_desc|sanc_type|sanc_reas|sanc_terms|sanc_cond|sanc_fines|sanc_fab|sanc_updte_form|sanc_updte\n','',SINGLE)
,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

DestinationIP := _control.IPAddress.edata12;

ing_d := fileservices.despray('~thor_data::out::ingenix_bestappend_'+ut.GetDate, DestinationIP, '/hds_180/prop_guide_one/ingenix_'+ut.GetDate+'.txt',,,,TRUE); 

export Proc_dateline_append := sequential(file_v_ingenix,ing_d); 