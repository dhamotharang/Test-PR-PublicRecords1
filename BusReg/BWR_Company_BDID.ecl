//#workunit('name','Accutrend Company Build ' + busreg.BusReg_Build_Date);
import ut;

base := BusReg.File_BusReg_Base;

//Project into Company layout
busreg.Layout_BusReg_Company co_slim(busreg.layout_busreg_temp L) := transform
 self := l;
 self := [];
end;

//******** Create Company File ******************//
new_company := project(base,co_slim(left))(company_name != '');

//Add to current file
//old := busreg.File_BusReg_Company;

//output(new_company(company_name!=''),,'BASE::BusReg_Company_' + busreg.BusReg_Build_Date,overwrite);
ut.mac_sf_buildprocess(new_company,'~thor_data400::base::busreg_company',do1,2);
export BWR_Company_BDID := do1;
