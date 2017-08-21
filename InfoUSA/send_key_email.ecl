export send_key_email(string filedate, string source):= module

msg1 := 'keys:	1) thor_data400::key::infousa::'+source+'::qa::abi_number (thor_data400::key::infousa::'+source+'::'+filedate+'::abi_number),\n'+
					  '			2) thor_data400::key::infousa::'+source+'::qa::autokey::address (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::address),\n'+
					  '			3) thor_data400::key::infousa::'+source+'::qa::autokey::addressb2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::addressb2),\n'+
					  '			4) thor_data400::key::infousa::'+source+'::qa::autokey::citystname (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::citystname),\n'+
					  '			5) thor_data400::key::infousa::'+source+'::qa::autokey::citystnameb2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::citystnameb2),\n'+
					  '			6) thor_data400::key::infousa::'+source+'::qa::autokey::name (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::name),\n'+
					  '			7) thor_data400::key::infousa::'+source+'::qa::autokey::nameb2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::nameb2),\n'+
					  '			8) thor_data400::key::infousa::'+source+'::qa::autokey::namewords2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::namewords2),\n'+
					  '			9) thor_data400::key::infousa::'+source+'::qa::autokey::payload (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::payload),\n'+
					  '			10) thor_data400::key::infousa::'+source+'::qa::autokey::phone2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::phone2),\n'+
					  '			11) thor_data400::key::infousa::'+source+'::qa::autokey::phoneb2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::phoneb2),\n'+
					  '			12) thor_data400::key::infousa::'+source+'::qa::autokey::stname (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::stname),\n'+
					  '			13) thor_data400::key::infousa::'+source+'::qa::autokey::stnameb2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::stnameb2),\n'+
					  '			14) thor_data400::key::infousa::'+source+'::qa::autokey::zip (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::zip),\n'+
					  '			15) thor_data400::key::infousa::'+source+'::qa::autokey::zipb2 (thor_data400::key::infousa::'+source+'::'+filedate+'::autokey::zipb2),\n'+
					  '			16) thor_data400::key::infousa::'+source+'::qa::bdid (thor_data400::key::infousa::'+source+'::'+filedate+'::bdid),\n'+
						'			17) thor_data400::key::infousa::'+source+'::qa::linkids (thor_data400::key::infousa::'+source+'::'+filedate+'::linkids),\n';
					  
msg2 := msg1+'			18) thor_data400::key::'+source+'::qa::fran (thor_data400::key::'+source+'::'+filedate+'::fran ),\n';

body := if(source='DEADCO',msg1, msg2);
							
	export keys_success := fileservices.sendemail(
													'roxiebuilds@seisint.com;tedman@seisint.com',
													'InfoUsa' +source+' Keys Built Succeeded ' + filedate,
													body+
													'			have been built and ready to be deployed to QA.');

	export keys_fail := fileservices.sendemail(
												'tedman@seisint.com',
												'InfoUsa' +source+' Roxie Build FAILED',
												workunit);						
end;