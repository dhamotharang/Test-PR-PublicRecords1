import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates fl_mz.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.FL ; 

fnameRef := project(fIn_raw , transform({fIn_raw} , 

                self.NAME := if(length(trim(left.NAME,left,right)) - length(regexreplace('[0-9]',trim(left.NAME,left,right),'')) < 4 AND
                                length(trim(left.OWN2_CUSTOMER_NAME,left,right)) - length(regexreplace('[0-9]',trim(left.OWN2_CUSTOMER_NAME,left,right),'')) >= 4 OR  
                                REGEXFIND('-$',trim(left.NAME,left,right))=true, 
                                trim(regexreplace('-$',trim(left.NAME,left,right),'')+trim(left.OWN2_CUSTOMER_NAME,left,right))[1..100], 
                                trim(left.NAME,left,right));

                self.OWN2_CUSTOMER_NAME := if(length(trim(left.NAME,left,right)) - length(regexreplace('[0-9]',trim(left.NAME,left,right),'')) < 4 AND
                                            length(trim(left.OWN2_CUSTOMER_NAME,left,right)) - length(regexreplace('[0-9]',trim(left.OWN2_CUSTOMER_NAME,left,right),'')) >= 4 OR 
                                            REGEXFIND('-$',trim(left.NAME,left,right)) = true , 
                                            '', 
                                            trim(left.OWN2_CUSTOMER_NAME,left,right));

                self := left)); 

watercraft_preprocess.layout_temp.fl_normalize  tnorm(fnameRef  l,integer1 C ):= transform 

		t_name_2 := if(l.OWN2_CUST_TYPE='I',
						trim(l.OWN2_CUSTOMER_NAME,left,right)[1..20]+' '+
						trim(l.OWN2_CUSTOMER_NAME,left,right)[21..35]+' '+
						trim(l.OWN2_CUSTOMER_NAME,left,right)[36..50]+' '+
						trim(l.OWN2_CUSTOMER_NAME,left,right)[51..53],l.OWN2_CUSTOMER_NAME); 

		t_NAME_3 :=  if(l.REGSTRANT1_TYPE='I', 
							trim(l.REG1_NAME,left,right)[1..20]+' '+
							trim(l.REG1_NAME,left,right)[21..35]+' '+
							trim(l.REG1_NAME,left,right)[36..50]+' '+
							trim(l.REG1_NAME,left,right)[51..53] , l.REG1_NAME);

		t_NAME_4 := if(l.REGIST2_CUST_TYPE='I', 
							trim(l.REG2_NAME,left,right)[1..20]+' '+
							trim(l.REG2_NAME,left,right)[21..35]+' '+
							trim(l.REG2_NAME,left,right)[36..50]+' '+
							trim(l.REG2_NAME,left,right)[51..53] ,l.REG2_NAME);

		self.NAME 					:= choose(C, l.name, t_name_2,t_NAME_3,t_NAME_4) ;
		self.ADDRESS_1  			:= choose(C,l.ADDRESS_1,l.OWN2_ADDRESS,l.REG1_ADDRESS,l.REG2_ADDRESS); 
		self.ADDRESS_2 				:= choose(C,l.OWN1_APT_NUMBER,l.OWN2_APT_NUMBER,l.REG1_APT_NO,l.REG2_APT_NO);
		self.CITY  					:= choose(C ,l.city,l.OWN2_CITY,l.REG1_CITY,l.REG2_CITY);
		self.STATE 					:= choose(C,l.state, l.OWN2_STATE,l.REG1_STATE, l.REG2_STATE);
		self.ZIP 					:= choose(C,l.zip, l.OWN2_ZIP, l.REG1_ZIP, l.REG2_ZIP);
		self.COUNTY 				:= choose(C,l.county ,l.OWN2_COUNTY,l.REG1_COUNTY,l.REG2_COUNTY); 
		self.NM_CUST_TYPE 			:= choose(C,l.OWN1_CUST_TYPE,l.OWN2_CUST_TYPE,l.REGSTRANT1_TYPE,l.REGIST2_CUST_TYPE);
		self.NM_CUSTOMER_NUMBER 	:= choose(C,l.OWN1_CUSTOMER_NUMBER,l.OWN2_CUSTOMER_NO,l.REG1_CUST_NO,l.REG2_CUST_NO) ;
		self.NM_FEID_SSN  			:= choose(C,l.OWN1_FEID_SSN,l.OWN2_FEID_SSN,l.REG1_FEID_SSN,l.REG2_FEID_SSN);
		self.NM_DEALER_LIC_NUM 		:=  choose(C,l.OWN1_DEALER_LIC_NUM,l.OWN2_DEALER_NO,l.REG1_DEALER_NO,l.REG2_DEALER_NO);
		self.NM_DRIV_LIC_NUM 		:= choose(C,l.OWN1_DRIV_LIC_NUM,l.OWN2_DRIVER_LIC,l.REG1_DRIV_LIC_NO,l.REG2_DRIV_LIC_NO);
		self.NM_DOB  				:= choose(C,l.OWN1_DOB,l.OWN2_DOB,l.REG1_DOB,l.REG2_DOB);
		self.NM_SEX 				:= choose(C,l.OWN1_SEX,l.OWN2_SEX,l.REG1_SEX,l.REG2_SEX);
		self.NM_SEX_PREDATOR_FLAG 	:= choose(C,l.OWN1_SEX_PREDATOR_FLAG,l.OWN2_SEX_PREDATOR,l.REG1_SEX_PREDATOR,l.REG2_SEX_PREDATOR);
		self.NM_MAIL_SUPP_FLAG 		:= choose(C,l.OWN1_MAIL_SUPP_FLAG,l.OWN2_MAIL_SUPP_FLAG,l.REG1_MAIL_SUPPRESS,l.REG2_MAIL_SUPPRESSION);
		self.NM_ADDR_NON_DISCLOSE 	:= choose(C,l.OWN1_ADDR_NON_DISCLOSE,l.OWN2_ADDR_NON_DISCLOS,l.REG1_ADD_NO_RELEASE,l.REG2_ADD_NO_RELEASE);
		self.NM_LAW_ENFOR_FLAG 		:= choose(C,l.OWN1_LAW_ENFOR_FLAG,l.OWN2_LAW_ENFOR_FLAG,l.REG1_LAW_ENFORCE,l.REG2_LAW_ENFORCEMENT);
		self.NM_ADDRESS_NUMBER 		:= choose(C,l.OWN1_ADDRESS_NUMBER,l.OWN2_ADDRESS_NUMBER,l.REG1_ADDRESS_NO,l.REG2_ADDRESS_NO);
		self.NM_FOREIGN_FLAG 		:= choose(C,l.OWN1_FOREIGN_FLAG,l.OWN2_FOREIGN_FLAG,l.REG1_FOREIGN_FLAG,l.REG2_FOREIGN_FLAG);
		self.NM_APT_NUMBER 			:= choose(C,l.OWN1_APT_NUMBER,l.OWN2_APT_NUMBER,l.REG1_APT_NO,l.REG2_APT_NO);
		self.NM_STPS 				:= choose(C,l.OWN1_STPS,l.OWN2_STOPS,l.REG1_STOPS,l.REG2_STOPS);
		self.NM_Source 				:= choose(C,'O1','O2','R1','R2');
		self.state_origin 			:= 'FL' ; 
		self.process_date 			:= watercraft_preprocess.version; 
		self := l ;  
end; 

Fnamenorm	:= normalize(fnameRef,4,tnorm(left,counter)) ; 


Fnamenormnm := project(Fnamenorm, transform({Fnamenorm}, 
                      t_name := if(regexfind(' OR$',trim(left.NAME,left,right)), trim(left.NAME,left,right)[1..(length(trim(left.NAME,left,right))-3)], trim(left.NAME,left,right));
					  self.NAME := StringLib.StringCleanSpaces( t_name) ; 
                      self := left))(NM_CUSTOMER_NUMBER!='0000000000' OR trim(NAME,left,right) <>''); 
					  
fprepsuff :=  project(Fnamenormnm, transform ({Fnamenormnm, string73 clean_O1_pname}, 
       
	               string_last_index := StringLib.StringFind(trim(left.NAME,left,right), ' ',StringLib.StringFindCount(trim(left.NAME,left,right), ' ')); 
                   self.clean_O1_pname := if(string_last_index+1=length(trim(left.NAME,left,right)) AND 
                                             length(trim(left.NAME,left,right))-3 =length(StringLib.StringFilterOut(trim(left.NAME,left,right),' ')) AND
                                             trim(left.NAME,left,right)[string_last_index+1] in ['J','S','1','2','3','4','5']  , 
											 trim(left.NAME,left,right)[1.. length(trim(left.NAME,left,right))-2]+' '+
		                                     watercraft_preprocess.Mod_Clean_Entities.fixsuffix_initial(left.NAME) , 
											 trim(left.NAME,left,right)[1..60]);
      			   self := left)); 
					

Address.Mac_Is_Business(fprepsuff,clean_O1_pname,fNametype,name_type);

fclean :=  project(fNametype, transform ({watercraft.layout_FL_clean_in}, 

                   self.clean_cname := if(left.name_type = 'B', trim(left.clean_O1_pname,left,right)[1..60] ,  '');
                   self.clean_pname := if(left.name_type <>'B' ,Address.CleanPersonLFM73(left.clean_O1_pname),'');
				   self.clean_address := '' ;
				   self := left ));
				   
export Map_FL_Update := sequential(output(fclean,,watercraft.Cluster_In+'in::watercraft_FL_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_fl', watercraft.Cluster_In+'in::watercraft_fl_'+watercraft_preprocess.version)
								  ) ;
        
