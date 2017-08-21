import Vina, ut, scrubs, _control, std, tools;

EXPORT Proc_Scrubs_Report(string filedate=(string)std.date.today(), string emailList='') := FUNCTION
return Scrubs.ScrubsPlus('VINA','Scrubs_Vina','Scrubs_Vina','BaseFile',filedate,emailList);
end;
