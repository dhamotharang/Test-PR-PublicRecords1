Import wk_ut,_Control,INQL_V2;
EXPORT FIDO_change_report := Module;
 
ECL := 	
				'#WORKUNIT(\'protect\',true);\n'+
				'#WORKUNIT(\'name\', \'Inquiry Tracking - FIDO change Report\');\n' +
				
				'curr:=dataset(inquiry_acclogs.foreign_fido_prod + \'thor::red::extract::inquiry_tracking_extract\', inquiry_acclogs.Layout_FIDO.extract_in, flat);\n' +
				'prev:=dataset(inquiry_acclogs.foreign_fido_prod + \'thor::red::extract::father::inquiry_tracking_extract\', inquiry_acclogs.Layout_FIDO.extract_in, flat);\n'+
				't := table(curr,{seq:=\'CURR\',curr}) + table(prev,{seq:=\'PREV\',prev});\n'+
				't1:=table(t,{t,cnt:=count(group)}	,vertical_market,sub_market ,industry,use,opt_out,disable_observation,hh_id,merge,few)(cnt=1);\n' +

				'EXPORT FIDOchangesRep := sort(t1,mbs_gc_id,-seq);\n'+

				'emailList := \'\'\n'+
											'+  \',Jose.bello@lexisnexisrisk.com\'\n'+
											'+  \',Fernando.Incarnacao@lexisnexisrisk.com\'\n'+
											'+  \',Margaret.Worob@lexisnexisrisk.com\'\n'+
					';\n'+

					'EXPORT SendFIDOchangesRep :=\n'+
					'sequential(\n'+
							'output(FIDOchangesRep,all,named(\'FIDOchangesRep\'))\n'+
							',STD.System.Email.SendEmail (\n'+
																						'emailList\n'+
																						',\'Daily FIDO Changes Report\'\n'+
																						',\'Attached is a link to the Daily FIDO Changes Report\'\n'+
																						'+\'\\n\\n  ***  Includes Adds, Deletes, and Changes  ***\'\n'+
																						'+\'\\n\\nhttp://prod_esp.br.seisint.com:8010/WsWorkunits/WUResult?Wuid=\'+workunit+\'&Sequence=1\'\n'+
																						',\n'+
																						',\n'+
																						',\'INQTLreports@LexisNexisRisk.com\'\n'+
																						'));\n'+
					
				'SendFIDOchangesRep;';
				
Thor:= 'thor400_44';
EXPORT proc_FIDO_chg_report := wk_ut.CreateWuid(ECL,THOR,INQL_v2._Constants.PROD_ESP);

End;