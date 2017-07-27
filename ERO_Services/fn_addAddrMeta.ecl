 import Advo_Services;
 export fn_addAddrMeta( dataset(ERO_Services.Layouts.LookupId) in_ids = dataset([],Layouts.LookupId) ) :=
		function		  
				
				Advo_Services.Advo_Batch_Service_Layouts.batch_in filladdr(in_ids L, INTEGER C) := TRANSFORM
					SELF.acctno := l.acctNo;
					SELF.city   := choose(c, l.addr_City_1, l.addr_City_2);
					SELF.state  := choose(c, l.addr_State_1,l.addr_State_2);
					SELF.zip    := choose(c, l.addr_Zip_1, l.addr_Zip_2);
					SELF.addr   := choose(c, l.addr_Address_1,l.addr_Address_2);
				END;
  
        addrs1 := project(in_ids, filladdr(LEFT,1));
				addrs2 := project(in_ids, filladdr(LEFT,2));
				
				addrMetadata1 := Advo_Services.Advo_Batch_Service_Records(addrs1,TRUE /*doBadSecRange*/);
				addrMetadata2 := Advo_Services.Advo_Batch_Service_Records(addrs2,TRUE /*doBadSecRange*/);
				getAddrType(Advo_Services.Advo_Batch_Service_Layouts.Batch_Out advoData) := function
				   vacant := if (advoData.Address_Vacancy_Indicator = 'Y','V' ,'');
					 throwback := if (advoData.Throw_Back_Indicator = 'Y','TB' ,'');
					 seasonal := if (advoData.Seasonal_Delivery_Indicator = 'Y','S' ,'');
					 dnd := if (advoData.DND_Indicator = 'Y','DND' ,'');
					 college := if (advoData.College_Indicator = 'Y','C' ,'');
					 res := if (advoData.Residential_or_Business_Ind = 'A','R' ,'');
					 bus := if (advoData.Residential_or_Business_Ind = 'B','B' ,'');
					 prb := if (advoData.Residential_or_Business_Ind = 'C','PRB' ,'');
					 pbr := if (advoData.Residential_or_Business_Ind = 'D','PBR' ,'');
					 owgm := if (advoData.OWGM_Indicator = 'Y','OWGM' ,'');
				   addrtype := vacant+','+throwback+','+seasonal+','+dnd+','+college+','+res+','+bus+','+prb+','+pbr+','+owgm;
					 addrtypeFiltered := if (stringlib.stringfilterout(addrtype,',') <> '', addrtype, '');
				   return addrtypeFiltered;
				end;
			
			  in_ids fillMeta1(in_ids l, addrMetadata1 r1) := transform
				    self.addr_Delivery_Type_Indicator_1 := getAddrType(r1);
						self.addr_POBox_Indicator_1 := if (r1.Route_Num[1] = 'B' or r1.record_type_code = 'P' or r1.address_type = '9', 'Y','');
						self := l;
				end;
				outrecs1 := join(in_ids, addrMetadata1, left.acctno = right.acctno, fillMeta1(left,right), left outer);
			
			  in_ids fillMeta2(in_ids l, addrMetadata2 r2) := transform
						self.addr_Delivery_Type_Indicator_2 := getAddrType(r2);
						self.addr_POBox_Indicator_2 := if (r2.Route_Num[1] = 'B' or r2.record_type_code = 'P' or r2.address_type = '9', 'Y','');
						self := l;
				end;
				outrecs2 := join(outrecs1, addrMetadata2, left.acctno = right.acctno, fillMeta2(left,right), left outer);
				
				return outrecs2;
	  end;