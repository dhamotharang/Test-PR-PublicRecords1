/*2016-09-22T23:10:14Z (Wendy Ma)

*/
import header,data_services,Std;

export Watercraft_as_Source(dataset(Watercraft.Layout_Watercraft_Search_Base) pWatercraftSearch = dataset([],Watercraft.Layout_Watercraft_Search_Base),
							dataset(Watercraft.Layout_Watercraft_Main_Base) pWatercraftMain = dataset([],Watercraft.Layout_Watercraft_Main_Base),
							dataset(Watercraft.Layout_Watercraft_CoastGuard_Base) pWatercraftCG = dataset([],Watercraft.Layout_Watercraft_CoastGuard_Base),
							boolean pForHeaderBuild=false,
							boolean pForFCRAHeaderBuild=false
              )
 :=
  function
	threshld :=18;

	integer YYYYMMDDToDays(string pInput) := 
	 (((integer)(pInput[1..4])*365) + ((integer)(pInput[5..6])*30)+ ((integer)(pInput[7..8])));

	today := YYYYMMDDToDays((STRING8)Std.Date.Today());

	dSourceDataSearch	:=	map(pForHeaderBuild =>
							   project(dataset('~thor_data400::Base::WatercraftSrchHeader_Building',Watercraft.Layout_Scrubs.Search_Base,flat),Watercraft.Layout_Watercraft_Search_Base)(
																																				lname<>''
																																			and fname<>''
																																			and prim_name<>''
																																			and	(state_origin<>'FL'
																																					or (state_origin='FL'
																																						and gender<>'B'
																																						and (integer)((today - YYYYMMDDToDays(dob)) / 365) >= threshld)
																																				)
																																			),
									pForFCRAHeaderBuild =>																										
									project(dataset(data_services.foreign_prod + 'thor_data400::Base::WatercraftSrchFCRAHeader_Building',Watercraft.Layout_Scrubs.Search_Base,flat),Watercraft.Layout_Watercraft_Search_Base)(
																																				lname<>''
																																			and fname<>''
																																			and prim_name<>''
																																			and	(unsigned)did != 0 and state_origin = 'OR'),																										
																																			
							   pWatercraftSearch(lname<>'' and fname<>'' and prim_name<>''));
	dSourceDataMain		:=	map(pForHeaderBuild =>
							   project(dataset('~thor_data400::Base::WatercraftMainHeader_Building',Watercraft.Layout_Scrubs.Main_Base,flat),Watercraft.Layout_Watercraft_Main_Base),
							   pForFCRAHeaderBuild =>
							   project(dataset(data_services.foreign_prod + 'thor_data400::Base::WatercraftMainFCRAHeader_Building',Watercraft.Layout_Scrubs.Main_Base,flat),Watercraft.Layout_Watercraft_Main_Base)(state_origin = 'OR'),
								 pWatercraftMain
							  );

	dSourceDataCG		:=	map(pForHeaderBuild =>
							   project(dataset('~thor_data400::Base::WatercraftCGHeader_Building',Watercraft.Layout_Scrubs.Coastguard_Base,flat),Watercraft.Layout_Watercraft_CoastGuard_Base),
							   pForFCRAHeaderBuild =>
							   project(dataset(data_services.foreign_prod + 'thor_data400::Base::WatercraftCGFCRAHeader_Building',Watercraft.Layout_Scrubs.Coastguard_Base,flat),Watercraft.Layout_Watercraft_CoastGuard_Base)(state_origin = 'OR'),
								 pWatercraftCG
							  );
							  
	dis_srch := distribute(dSourceDataSearch(source_code != 'W1'),hash(state_origin,watercraft_key,sequence_key,source_code));
	dis_main := distribute(dSourceDataMain(source_code != 'W1'),  hash(state_origin,watercraft_key,sequence_key,source_code));
	dis_cg   := distribute(dSourceDataCG,    hash(state_origin,watercraft_key,sequence_key,source_code));

	tmp_rec := record
	 header.layout_Source_ID;
	 watercraft.layout_watercraft_source;
	end;
	
    tmp_rec getall(dis_srch L, dis_main R) := transform
     self := r;
     self := l;
     self := [];
    end;

    j1 := join(dis_srch,dis_main,
				    left.state_origin = right.state_origin 
				and	left.watercraft_key = right.watercraft_key
				and	left.sequence_key = right.sequence_key
				and left.source_code = right.source_code,
				getall(left,right),local);

		src_rec:=header.layouts_SeqdSrc.WA_src_rec;

    src_rec getall1(j1 L, dis_cg R) := transform
     self.watercraft_key := l.watercraft_key;
     self.sequence_key := l.sequence_key;
     self.state_origin := l.state_origin;
     self := l;
     self := r;
     self := [];
    end;

    j := join(j1,dis_cg,
				    left.state_origin = right.state_origin 
				and	left.watercraft_key = right.watercraft_key
				and	left.sequence_key = right.sequence_key
				and left.source_code = right.source_code,
				getall1(left,right),left outer,local);

	header.Mac_Set_Header_Source(j,watercraft.Layout_Watercraft_Full,src_rec,watercraft.Header_Source_Code(l.source_code,l.State_Origin),withID)

	return withID;
  end
 ;
