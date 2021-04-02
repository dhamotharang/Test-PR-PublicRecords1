import _control, Data_Services, std,VersionControl;

EXPORT _Constants(boolean pUseProd=false)  := module

	export currenttime                        :=  STD.Date.CurrentTime(True); 
	export DatasetName 				          :=  'IDA';
	export thor_cluster_Files			      :=  trim('~thor_data400::');
	export PROD_ESP                           :=  trim('prod_esp.br.seisint.com');
	export DATALAND_ESP                       :=  trim('dataland_esp.br.seisint.com');
	export LZ				                  :=  trim('bctlpbatchio04.noam.lnrm.net');
    export thisDaliIP         		          :=  _Control.ThisEnvironment.ThisDaliIp;
	export foreign_prod   	                  :=  Data_Services.foreign_prod;
	export foreign_dataland   	              :=  Data_Services.foreign_dataland;
	export enviroment                         :=  If(pUseProd,'Production','Dataland');
	export IsDataland                         :=  if(regexfind('Dataland', enviroment, nocase),true,false);

	
	export dataland_dali	                  :=  trim('dataland_dali.br.seisint.com');			// 10.173.14.201
	export dataland_dali_ip                   :=  trim('10.173.14.201');
	export prod_thor_dali	                  :=  trim('uspr-prod-thor-dali.risk.regn.net');				// 10.173.84.201

	export PROD_THOR          		          :=  trim('thor400_36');
	export DATALAND_THOR       		          :=  trim('thor400_dev01');
	export PROD_THOR_GIT                      :=  trim('thor400_36_eclcc');
	export DATALAND_THOR_GIT                  :=  trim('thor400_dev_eclcc');
		
	export Source_IP                          :=  if(pUseProd,TRIM('bctlpbatchio04.noam.lnrm.net'),TRIM('10.121.149.194'));
	export GROUPNAME			      	      :=  ThorLib.Group();
	export ROOTDIR 					          :=  if(pUseProd,TRIM('/data/prod_r3/b1032422/'),TRIM('/data/temp/petrvl01/IDA/'));
	export spray_path		  	              :=  if(pUseProd,TRIM(ROOTDIR + 'outgoing/'),TRIM(ROOTDIR +'outgoing/'));
	export done_path                          :=  if(pUseProd,TRIM('/data/prod_r3/b1032422/done/'),TRIM('/data/temp/petrvl01/IDA/done/'));
	export despray_path                       :=  if(pUseProd,TRIM('/data/prod_r3/b1032432/dali_files/'),TRIM('/data/temp/petrvl01/IDA/dali_files/'));	
	export despray_incoming_path              :=  if(pUseProd,TRIM('/data/prod_r3/b1032432/incoming/'),TRIM('/data/temp/petrvl01/IDA/incoming/'));
	
	export RD                                 :=STD.File.RemoteDirectory(Source_IP,spray_path);
	export SRT                                :=SORT(RD,name);
    export RDF                                :=SRT[1];                                      
    export filesdate                          :=REGEXFIND('[0-9]{8}'+'_'+'[0-9]{6}',RDF.name,0);
	export despray_filename                   :='IDA_LEXID_APPEND_'+filesdate+'_response.txt';
	
	export IsValidVersion(string pversion)    := regexfind('^[[:digit:]]{6,8}_[[:digit:]]{6}[[:alpha:]]?$',pversion);

	export name                               := trim('thor_data400::base::ida::daily::*');	                                                                            	
    export rawFilesinThor                     := NOTHOR(STD.File.LogicalFileList(name,true,false,false));
    export monthlyversion                     := Max(rawFilesinThor,(string)std.str.splitwords(name,'::')[5][1..15]);
	export despray_change_filename            :='IDA_LEXID_REFRESH_'+monthlyversion+'_response.txt';

	
END;