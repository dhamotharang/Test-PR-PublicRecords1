import	data_services;

export Files := 
module
	export	  Input	:=
	module
		export	  gwl	:=
		module
			entity1		:=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::gwl::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
			tbl 			:= table(entity1, 
										{integer addrCount := count(Addresses),
										integer RoutingCodesCount := count(RoutingCodes),
										entity1});
									
			Accuity.Layouts.input.rEntity SplitRecordsIn254(tbl l, integer pos) := transform
				self.id 					:= if(pos = 1, l.id + '1', if(pos = 2, l.id + '11', if(pos = 3, l.id + '111', l.id))); 		
				self.addresses 		:= if(pos = 1, choosen(l.addresses, 254, 255), if(pos = 2, choosen(l.addresses, 254, 509), if(pos = 3, choosen(l.addresses, 254, 763), choosen(l.addresses, 254))));
				self.RoutingCodes := if(pos = 1, choosen(l.RoutingCodes, 254, 255), if(pos = 2, choosen(l.RoutingCodes, 254, 509), if(pos = 3, choosen(l.RoutingCodes, 254, 763), choosen(l.RoutingCodes, 254))));
				self := l;
			end;	
			
			dsEntities 			:= PROJECT(tbl, SplitRecordsIn254(left, 0));
			dsAddrEntites1 	:= PROJECT(tbl(addrCount > 254), SplitRecordsIn254(left, 1));
			dsRoutEntites1 	:= PROJECT(tbl(RoutingCodesCount > 254), SplitRecordsIn254(left, 1));
			dsAddrEntites2 	:= PROJECT(tbl(addrCount > 508), SplitRecordsIn254(left, 2));
			dsRoutEntites2 	:= PROJECT(tbl(RoutingCodesCount > 508), SplitRecordsIn254(left, 2));
			dsAddrEntites3 	:= PROJECT(tbl(addrCount > 762), SplitRecordsIn254(left, 3));
			dsRoutEntites3 	:= PROJECT(tbl(RoutingCodesCount > 762), SplitRecordsIn254(left, 3));
			
			export 	entity	:= 	dedup(sort(dsEntities + dsAddrEntites1 + dsRoutEntites1 + dsAddrEntites2 + dsRoutEntites2 + dsAddrEntites3 + dsRoutEntites3, id), id);
			
			export	groups  :=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::gwl::group', Accuity.Layouts.input.rGroups, XML('xml/groups/group'));
			export	srccode	:=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::gwl::srccode', Accuity.Layouts.input.rSrccode, XML('xml/source-code-maps/source-code-map'));
		end;
	
		export	msb	:=
		module
			export	entity	:=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::msb::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
			export	groups  :=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::msb::group', Accuity.Layouts.input.rGroups, XML('xml/groups/group'));
			export	srccode	:=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::msb::srccode', Accuity.Layouts.input.rSrccode, XML('xml/source-code-maps/source-code-map'));

		end;
	
		export	ofac	:=
		module
			export	entity	:=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::ofac::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
			export	groups  :=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::ofac::group', Accuity.Layouts.input.rGroups, XML('xml/groups/group'));
			export	srccode	:=	dataset(data_services.foreign_prod + 'thor_data400::in::accuity::ofac::srccode', Accuity.Layouts.input.rSrccode, XML('xml/source-code-maps/source-code-map'));
		end;
		
		export buildinfo := 
		module
			//export list_info 					:= dataset({[]}
			export user_info_clientID := dataset([{'kevinu99'}],Accuity.Layouts.input.asBridger.iuser_info_clientID);
			export output_type 				:= dataset([{'W32Bit'}],Accuity.Layouts.input.asBridger.ioutputType);
		
end;
/*	
	export	Base	:=
	module
		export	Entity	:=	dataset(accuity.constants.Cluster	+	'base::accuity::entity',accuity.Layouts.Base.rEntity_Layout,thor);
		export	Country	:=	dataset(accuity.constants.Cluster	+	'base::accuity::country',accuity.Layouts.Base.rCountry_Layout,thor);
	end;
	*/
end;
end;

