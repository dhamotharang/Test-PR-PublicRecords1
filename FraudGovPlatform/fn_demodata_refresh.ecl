import STD,ut,tools;
//Ensure transaction dates are recent so they will appear in web. GRP-5276, GRP-5144
export fn_demodata_refresh (
          string pversion
        ) := 
Function 
		Demo := dataset('~fraudgov::base::main_demo_anon',FraudGovPlatform.Layouts.base.main,thor);
		pmain := project(Demo,transform(recordof(left)
						,self.reported_date := (string)std.date.adjustdate((unsigned)(pversion[1..6]+left.reported_date[7..8]),,-1)
						,self.event_date		:= (string)std.date.adjustdate((unsigned)(pversion[1..6]+left.reported_date[7..8]),,-1)
						,self.dt_first_seen	:= std.date.adjustdate((unsigned)(pversion[1..6]+left.reported_date[7..8]),,-1)
						,self.dt_last_seen	:= std.date.adjustdate((unsigned)(pversion[1..6]+left.reported_date[7..8]),,-1)
						,self.process_date	:= (unsigned)pversion
						,self.dt_vendor_last_reported		:= std.date.adjustdate((unsigned)(pversion[1..6]+left.reported_date[7..8]),,-1)
						,self.dt_vendor_first_reported	:= std.date.adjustdate((unsigned)(pversion[1..6]+left.reported_date[7..8]),,-1)
						,self:=left));
		
		finalrecs := FraudGovPlatform.fn_dedup_main(pmain);
return finalrecs;
end;
