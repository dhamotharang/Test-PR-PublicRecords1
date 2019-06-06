//  Smartlinx Report Requirement: 380
//  Set premimum phone flag if not found in HD(header) or GH(Gong Header).

IMPORT iesp;
EXPORT fn_smart_setPhoneFlag(dataset(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord) inPhones) := FUNCTION
  
	iesp.smartlinxReport.t_SLRBestPhone setPhoneFlag(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord l) := transform
	  self.PremiumPhoneFlag :=  l.vendorID not in ['HD','GH'];
	  self := l;
  end;
  out_recs := project(inPhones, setPhoneFlag(LEFT));
  return out_recs;
END;
