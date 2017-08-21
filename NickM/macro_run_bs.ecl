export macro_run_bs(archive_date, fcra) := macro

#uniquename(infile_name)
#uniquename(outfile_name)
%infile_name% :=  '~nmontpetit::in::first_inv_857_bs_in_'+fcra+'_'+(string)archive_date;
%outfile_name% :=  '~nmontpetit::in::first_inv_857_bs_out_'+fcra+'_'+(string)archive_date+'_test';

#uniquename(p_f)
%p_f% := dataset (%infile_name%, layout_input, csv(quote('"')));

#uniquename(s)
%s% := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (	%p_f%, 
															TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, 
																SELF := LEFT)),	
															bs_service_#EXPAND(fcra), 'roxieIP_'+fcra, parallel_calls);

#uniquename(res)
#uniquename(res_err)
%res% := JOIN (%s%, %p_f%, LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
%res_err% := %res%(errorcode<>'');

OUTPUT (%res%, NAMED ('result'));

IF (EXISTS (%res_err%), OUTPUT (%res_err%, NAMED ('res_err')));
IF (EXISTS (%res_err%), OUTPUT (%res_err%, , %outfile_name% + '_err', CSV(QUOTE('"')), overwrite));


// the conversion portion-----------------------------------------------------------------------
#uniquename(edina)
%edina% := project(%res%, convertToEdina_fcra(left));
output(%edina%, named('edina'));
output(%edina%,, %outfile_name%,CSV(QUOTE('"')), overwrite);

endmacro;