import eMerges,address,ut,versioncontrol;

layout_raw:=layouts.Fein_LN_Clean_raw;

export FEIN_Map_ExtractLayout(
	 string					filedate
	,dataset(layout_raw)	Raw_in			= FEIN_CP_Extract.FEIN_LN_Clean
	,boolean				pOverwrite      = false
) :=function 

  
 Layouts.Fein_Extract_out Trans_map(Raw_in l):=Transform 
 
		self.TAX_ID_NO 		:=l.Tax_ID_Number 				;        
		self.SRC_DUN_NBR 	:=l.Source_Duns_Number         	;        
		self.NAME_BUS  		:=l.Business_Name         		;   
		self.ADR_ADDRESS 	:=trim(Address.Addr1FromComponents(
   																 l.Bus_prim_range
   																,l.Bus_predir
   																,l.Bus_prim_name
   																,l.Bus_addr_suffix
   																,l.Bus_postdir
   																,l.Bus_unit_desig
																,l.Bus_sec_range 
   															),left,right);       				     
		self.ADR_CITY 		:=l.Bus_v_city_name         	;   
		self.ADR_STATE  	:=l.Bus_st         				;        
		self.ADR_ZIP    	:=if(l.Bus_zip5<>'',trim(l.Bus_zip5,left,right) + if(l.Bus_zip4<>'',trim(l.Bus_zip4,left,right),''),'');
		self.REF_NAME_SRC  	:=l.Reference_Name_Source       ; 
		self.DATE_Input    	:=l.Date_of_Input_data	        ;       
		self.DATE_CL_IMP  	:=l.Date_of_Input_data			;           
		self.CASE_DUN_NBR   :=l.Case_Duns_Number         	;       
		self.PAR_DUN_NBR    :=l.Headquarter_Paren_Duns_Nbr	;        
		self.HDQ_DUN_NBR   	:=l.Headquarter_Paren_Duns_Nbr	;        
		self.PHONE_NO     	:=l.Telephone_Number         	;      
		self.NAME_EXEC  	:=l.Top_Contact_Name         	;   
		self.NAME_COMPANY 	:=l.Company_Name         		;       
		self.TRADE_STYLE 	:=l.tradestyle	         		;       
		self.SIC_CODE     	:=l.SIC_Code         			;        
		self.TMP_HOUSENO  	:=''     						;
		self.lf             :='\r\n'                       ;
		
 
 end;
 
 FEIN_Out_map:=project(Raw_in,Trans_map(left));
 
VersionControl.macBuildNewLogicalFile('~thor_data400::out::'+filedate+'::FEIN_Extract',FEIN_Out_map,BuildExtractFile,,,pOverwrite,);
super_main := sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile('~thor_data400::base::FEINScank_Extract',true)
				,FileServices.AddSuperFile('~thor_data400::base::FEINScank_Extract', 
				                          '~thor_data400::out::'+filedate+'::FEIN_Extract'), 
				FileServices.FinishSuperFileTransaction());

Add_super := if(FileServices.FindSuperFileSubName('~thor_data400::base::FEINScank_Extract', '~thor_data400::out::'+filedate+'::FEIN_Extract') = 0,super_main); 

	

return sequential(output('FEIN Extract Results Follow'	,named('__'							))
				 ,BuildExtractFile ,Add_super) ;

end;