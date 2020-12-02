import _control, Data_Services, std,VersionControl;

EXPORT _Constants(string pversion='',boolean pUseProd=false)  := module

  export version                            :=  IF(pversion='',trim((string8)std.date.today()),pversion);
	export currenttime                        :=  STD.Date.CurrentTime(True); 
	export DatasetName 				                :=  'IDA';
	export thor_cluster_Files			            := 	trim('~thor_data400::');
	export PROD_ESP                           :=  trim('prod_esp.br.seisint.com');
	export DATALAND_ESP                       :=  trim('dataland_esp.br.seisint.com');
	export LZ									                :=  trim('bctlpbatchio04.noam.lnrm.net');
  export thisDaliIP         		            :=  _Control.ThisEnvironment.ThisDaliIp;
	export foreign_prod   	                  :=  Data_Services.foreign_prod;
	export foreign_dataland   	              :=  Data_Services.foreign_dataland;
	export enviroment                         :=  If(pUseProd,'Production','Dataland');
	export IsDataland                         :=  if(regexfind('Dataland', enviroment, nocase),true,false);

	
	export dataland_dali	                    :=	trim('dataland_dali.br.seisint.com');			// 10.173.14.201
	export dataland_dali_ip                   :=  trim('10.173.14.201');
	export prod_thor_dali	                    :=	trim('uspr-prod-thor-dali.risk.regn.net');				// 10.173.84.201

	export PROD_THOR          		            :=  trim('thor400_36');
	export DATALAND_THOR       		            :=  trim('thor400_dev01');
	export PROD_THOR_GIT                      :=  trim('thor400_36_eclcc');
	export DATALAND_THOR_GIT                  :=  trim('thor400_dev_eclcc');
		
	export Source_IP                          :=  if(pUseProd,TRIM('bctlpbatchio04.noam.lnrm.net'),TRIM('10.121.149.194'));
	export GROUPNAME			      	            :=  ThorLib.Group();
	export ROOTDIR 					                  :=  if(pUseProd,TRIM('/data/prod_r3/b1064987/'),TRIM('/data/temp/petrvl01/IDA/'));
	export spray_path		  	                  :=  if(pUseProd,TRIM(ROOTDIR + 'outgoing/'),TRIM(ROOTDIR +'outgoing/'));
	export done_path                          :=  if(pUseProd,TRIM('/data/prod_r3/b1064987/done'),TRIM('/data/temp/petrvl01/IDA/done/'));
	export despray_filename                   :=  'IDA_LEXID_APPEND_'+version+'_'+currenttime+'_response.csv';
	export despray_path                       :=  if(pUseProd,TRIM('/data/prod_r3/b1064987/incoming/'),TRIM('/data/temp/petrvl01/IDA/incoming/'));	
	
END;