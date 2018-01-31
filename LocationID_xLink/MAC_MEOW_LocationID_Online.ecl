 
EXPORT MAC_MEOW_LocationID_Online(infile,Ref='',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_v_city_name = '',Input_st = '',Input_zip5 = '',Soapcall_RoxieIP = '',Soapcall_Timeout = 3600,Soapcall_Time_Limit = 0,Soapcall_Retry = 0,Soapcall_Parallel = 2,OutFile,Stats='',In_MaxIds=50,In_LeadThreshold=0) := MACRO
  IMPORT SALT37,LocationId_xLink;
  ServiceModule := 'LocationId_xLink.';
#uniquename(into)
LocationId_xLink.Process_LocationID_Layouts.InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.Ref;
  SELF.MaxIds := In_MaxIds;
  SELF.LeadThreshold := In_LeadThreshold;
  #IF ( #TEXT(Input_prim_range) <> '' )
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
  #ELSE
    SELF.prim_range := (TYPEOF(SELF.prim_range))'';
  #END
  #IF ( #TEXT(Input_predir) <> '' )
    SELF.predir := (TYPEOF(SELF.predir))le.Input_predir;
  #ELSE
    SELF.predir := (TYPEOF(SELF.predir))'';
  #END
  #IF ( #TEXT(Input_prim_name) <> '' )
    SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
  #ELSE
    SELF.prim_name := (TYPEOF(SELF.prim_name))'';
  #END
  #IF ( #TEXT(Input_addr_suffix) <> '' )
    SELF.addr_suffix := (TYPEOF(SELF.addr_suffix))le.Input_addr_suffix;
  #ELSE
    SELF.addr_suffix := (TYPEOF(SELF.addr_suffix))'';
  #END
  #IF ( #TEXT(Input_postdir) <> '' )
    SELF.postdir := (TYPEOF(SELF.postdir))le.Input_postdir;
  #ELSE
    SELF.postdir := (TYPEOF(SELF.postdir))'';
  #END
  #IF ( #TEXT(Input_unit_desig) <> '' )
    SELF.unit_desig := (TYPEOF(SELF.unit_desig))le.Input_unit_desig;
  #ELSE
    SELF.unit_desig := (TYPEOF(SELF.unit_desig))'';
  #END
  #IF ( #TEXT(Input_sec_range) <> '' )
    SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
  #ELSE
    SELF.sec_range := (TYPEOF(SELF.sec_range))'';
  #END
  #IF ( #TEXT(Input_v_city_name) <> '' )
    SELF.v_city_name := (TYPEOF(SELF.v_city_name))le.Input_v_city_name;
  #ELSE
    SELF.v_city_name := (TYPEOF(SELF.v_city_name))'';
  #END
  #IF ( #TEXT(Input_st) <> '' )
    SELF.st := (TYPEOF(SELF.st))le.Input_st;
  #ELSE
    SELF.st := (TYPEOF(SELF.st))'';
  #END
  #IF ( #TEXT(Input_zip5) <> '' )
    SELF.zip5 := (TYPEOF(SELF.zip5))le.Input_zip5;
  #ELSE
    SELF.zip5 := (TYPEOF(SELF.zip5))'';
  #END
END;
#uniquename(Soapcall_RoxieIP_temp)
  #IF ( #TEXT(Soapcall_RoxieIP) <> '' )
	  %Soapcall_RoxieIP_temp% := Soapcall_RoxieIP;
  #ELSE
      %Soapcall_RoxieIP_temp% := LocationId_xLink.MEOW_roxieip;
  #END
#uniquename(pr)
  %pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT37.MAC_Soapcall(%pr%,LocationId_xLink.Process_LocationID_Layouts.OutputLayout, %Soapcall_RoxieIP_temp%, ServiceModule+'MEOW_LocationID_Service', %res_out%,,,Soapcall_Timeout,Soapcall_Time_Limit,Soapcall_Retry,Soapcall_Parallel);
OutFile := %res_out%;
  #IF (#TEXT(Stats)<>'')
    Stats := LocationId_xLink.Process_LocationID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
