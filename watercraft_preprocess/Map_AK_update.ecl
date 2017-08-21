import watercraft,ut,address,AID,header,address;

// translates ak_phase01_update.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.AK ; 

temp_rec := {Watercraft.layout_Ak,string115 concat_name,string1 name_format}; 

fprecelan := project( fIn_raw, transform({temp_rec}, 

               self.concat_name   := StringLib.StringToUpperCase(trim(trim(left.FIRST_NAME,left,right)+' '+trim(left.MID,left,right)+' '+trim(left.LAST_NAME),left,right));
               self.name_format := if(StringLib.stringfind(self.concat_name,',',1)!=0 , 'F' , 'U');
     		   self := left));

ut.Mac_Clean_Dual_Names(fprecelan,concat_name,fcelanDname,name_format);

fcelanname := project(fcelanDname , transform({ Watercraft.Layout_AK_clean_in }, 
               
			   
			    self.owner2_pname := Address.CleanPersonFML73(trim(left.OwnerNameFirst2,left,right)+' '+ trim(left.OwnerNameMiddle2,left,right)+' '+trim(left.OwnerNameLast2,left,right)+' '+trim(left.OwnerNameSuffix2,left,right));
				self.owner3_pname := Address.CleanPersonFML73(trim(left.OwnerNameFirst3,left,right)+' '+ trim(left.OwnerNameMiddle3,left,right)+' '+trim(left.OwnerNameLast3,left,right)+' '+trim(left.OwnerNameSuffix3,left,right));
				self.owner4_pname := Address.CleanPersonFML73(trim(left.OwnerNameFirst4,left,right)+' '+ trim(left.OwnerNameMiddle4,left,right)+' '+trim(left.OwnerNameLast4,left,right)+' '+trim(left.OwnerNameSuffix4,left,right));
				self.owner5_pname := Address.CleanPersonFML73(trim(left.OwnerNameFirst5,left,right)+' '+ trim(left.OwnerNameMiddle4,left,right)+' '+trim(left.OwnerNameLast5,left,right)+' '+trim(left.OwnerNameSuffix5,left,right));

				self.company1_cname := trim(left.Company1,left,right);
				self.company2_cname := trim(left.OwnerNameCompany2,left,right);
				self.company3_cname := trim(left.OwnerNameCompany3,left,right);
				self.company4_cname := trim(left.OwnerNameCompany4,left,right);
				self.company5_cname := trim(left.OwnerNameCompany5,left,right);
  
				self.clean_address := Address.CleanAddress182(
										(left.ADDRESS_1+' '+ left.Address2),
										(left.CITY+' '+ left.STATE+' '+ left.ZIP));

				self.clean_resaddress :=  Address.CleanAddress182(
										(left.AddressRes1+' '+ left.AddressRes2),
										(left.CityRes+' '+ left.StateRes+' '+left.ZipRes+left.Zip4Res));

				self.clean_lienaddress := '';/*Address.CleanAddress182(
                     (left.LienAddress1+' '+ left.LienAddress2),
                     (left.LienCity+' '+ left.LienState+' '+ left.LienZip+ left.LienZip4));
               */ 
				self.pname1 := left.pname1+left.pname1_score;
				self.pname2 := left.pname2+left.pname2_score;
				self.pname3 := left.pname3+left.pname3_score;
				self.pname4 := left.pname4+left.pname4_score;
				self.pname5 := left.pname5+left.pname5_score;
                self.state_origin := 'AK'; 
				self.process_date := watercraft_preprocess.version; 
				self := left)); 

export Map_AK_update := sequential(output(fcelanname,,watercraft.Cluster_In+'in::watercraft_ak_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_ak', watercraft.Cluster_In+'in::watercraft_ak_'+watercraft_preprocess.version)
								  ) ;