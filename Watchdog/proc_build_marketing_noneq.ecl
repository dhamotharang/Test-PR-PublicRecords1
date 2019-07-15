EXPORT proc_build_marketing_noneq :=  function

//#stored ('watchtype', 'marketing_noneq');
//changed from using #stored to just setting the variable.  Something has changed
//at the platform level so in a Sequential 2 variables called watchtype can't be 
//set at the same time.

watchtype := 'marketing_noneq';
import watchdog,ut,RoxieKeyBuild;

boolean isnewheader := Watchdog.proc_Validate_NewHdr.out;


string_rec := record
  string8 fdate;
end;
d := dataset([{ut.GetDate}],string_rec);
//string8 filedt := d[1].fdate : stored('filedt');

wchk := output(d,,'~thor_data400::in::watchdog_check2',overwrite);

fd := dataset('~thor_data400::in::watchdog_check2',{string8 fdate},thor);
string8 filedate := fd[1].fdate : stored('filedate');

set_inputs := output('Setting input files...') : success(watchdog.Input_set);

send_bad_email := fileservices.SendEmail('skasavajjala@seisint.com','Watchdog-marketing Build FAILED','');
send_email := fileservices.SendEmail('skasavajjala@seisint.com','Watchdog-marketing Build FINISHED','');
//updatedops          := RoxieKeyBuild.updateversion('MarketingHeaderKeys',filedate,'skasavajjala@seisint.com',,'N');


 out_all := sequential(wchk,set_inputs,watchdog.BWR_Best(isnewheader)) : FAILURE(send_bad_email);
 return out_all;
end;