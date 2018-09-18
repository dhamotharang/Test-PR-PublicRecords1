import AutoStandardI,VehicleV2_Services,doxie,iesp;

export Comp_RealTime_Vehicles (dataset(doxie.layout_references) dids,
	dataset(Layout_Comp_Addresses) ds_addrs = dataset([],Layout_Comp_Addresses),
	dataset(doxie.layout_NameDID) ds_names = dataset([],doxie.layout_NameDID)) := module

shared  input_params := AutoStandardI.GlobalModule();
//shared	subj_Addrs := if(exists(ds_addrs),ds_addrs,doxie.Comp_Subject_Addresses(dids,,input_params.DPPApurpose,input_params.GLBpurpose,,,false,input_params.industryclass,,).addresses);

//TODO: not likely needed, but have to reset few values to be on the safe side:
mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (input_params))
                EXPORT unsigned3 date_threshold := 0;
                EXPORT boolean ln_branded := FALSE;
                EXPORT boolean probation_override := FALSE;
              END;
 
shared comp_subj := doxie.Comp_Subject_Addresses(dids, mod_access := mod_access);
subj_Addrs := if(exists(ds_addrs),ds_addrs,comp_subj.addresses);
shared	Addrs := topn(subj_addrs,2,-dt_last_seen);
shared	Names := if(exists(ds_names),ds_names,topn(comp_subj.names,1,-name_occurences));

export load_module(string10 prim_range,string2 predir,string28 prim_name,string4 suffix,
			    		string2 postdir,string8 sec_range,string25 city_name,string2 st,string5 zip) := function
      
 		  tempmod := module(project(input_params,VehicleV2_Services.IParam.polkParams,opt))
			EXPORT string30 firstname := names[1].fname;
			EXPORT string30 middlename :='';
			EXPORT string30 lastname := names[1].lname;
			EXPORT string120 companyname := '';
			EXPORT string200 addr := trim(^.prim_range) + ' ' +
																						 trim(^.predir) + ' ' +			
																						 trim(^.prim_name) + ' ' +			
																						 trim(^.suffix) + ' ' +			
																						 trim(^.postdir) + ' ' +			
																						 trim(^.sec_range);	
			EXPORT string25 city := ^.city_name;
			EXPORT string2 state := ^.st;
			EXPORT string6 zip := ^.zip;
			 EXPORT string50	ReferenceCode := '' : stored('ReferenceCode');
			 EXPORT string20	BillingCode := '' : stored('BillingCode');
			 EXPORT string50	QueryId := '' : stored('QueryId');
			 EXPORT string RealTimePermissibleUse := '' : stored('RealTimePermissibleUse');
			 EXPORT string SubCustomerID:='' :stored('SubCustomerID');
			 EXPORT string ModelYear:=''; 
			 EXPORT string Make:=''; 
			 EXPORT string Model:=''; 
			 EXPORT string LicensePlateNum := '';
			 EXPORT string vin_in := '';
			 EXPORT string name_suffix := '';
			 EXPORT string DataSource := VehicleV2_Services.Constant.report_val;
			EXPORT BOOLEAN noFail := TRUE;
	end;
	return tempmod;
end;	

export do := function
  send_params := load_module(Addrs[1].prim_range,Addrs[1].predir,Addrs[1].prim_name,Addrs[1].suffix,Addrs[1].postdir,
											Addrs[1].sec_range,Addrs[1].city_name,Addrs[1].st,Addrs[1].zip);	
	GatewayData := VehicleV2_Services.Get_Gateway_Data(send_params);
  final_results := iesp.transform_vehiclesV2(project(GatewayData, VehicleV2_Services.Layout_Report));
	return final_results;
											
end;											
	
end;	
