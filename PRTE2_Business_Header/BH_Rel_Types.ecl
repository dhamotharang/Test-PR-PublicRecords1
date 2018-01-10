import Business_Header, ut, PRTE2;

export BH_Rel_Types(

	dataset(Layouts.Out.Layout_BH_Out	)				pIn_BH_Init		= BH_Init()
	//dataset(Layouts.Out.Layout_BH_Out	)				pIn_BH_Init		= dataset('~prte::persist::PRTE2_Business_Header::BH_Init', Layouts.Out.Layout_BH_Out, thor)
	
) :=
function

	//*** For historical records group_id's already exists in the input files, so taking them directly.
	dBH_Init_Historical := pIn_BH_Init(trim(rel1_bdid) <> '' and trim(cust_name) = '');
	
	//*** Taking the New/Current business header records by filtering on cust_name <> ''.
	dBH_Init_Current := pIn_BH_Init(trim(cust_name) <> '');

	dBH_Init_Current_dis := distribute(dBH_Init_Current, hash(link_fein, link_inc_date));

	Layouts.Temporary.Layout_Relatives tMapBH_Rels(dBH_Init_Current l) := transform,
			skip(trim(l.rel1_type) ='' and 
					 trim(l.rel2_type) ='' and 
					 trim(l.rel3_type) ='' and
					 trim(l.rel4_type) ='' and
					 trim(l.rel5_type) ='' and
					 trim(l.rel6_type) ='' and
					 trim(l.rel7_type) ='' and
					 trim(l.rel8_type) ='' and
					 trim(l.rel9_type) ='' and
					 trim(l.rel10_type) ='' and
					 trim(l.rel11_type) =''
					)
			self.bdid1							:= (unsigned6)l.bdid;
			self.link_fein					:= l.link_fein;
			self.link_inc_date			:= l.link_inc_date;
			self.orig_fein					:= l.orig_fein;
			self.bus_name						:= l.bus_name;
			self.long_bus_name			:= l.long_bus_name;
			self.rel_fein						:= trim(l.rel1_fein);
			self.rel_inc_date				:= trim(l.rel1_inc_date);
			self.rel1_type					:= ut.CleanSpacesAndUpper(l.rel1_type);
			self.rel2_type					:= ut.CleanSpacesAndUpper(l.rel2_type);
			self.rel3_type					:= ut.CleanSpacesAndUpper(l.rel3_type);
			self.rel4_type					:= ut.CleanSpacesAndUpper(l.rel4_type);
			self.rel5_type					:= ut.CleanSpacesAndUpper(l.rel5_type);
			self.rel6_type					:= ut.CleanSpacesAndUpper(l.rel6_type);
			self.rel7_type					:= ut.CleanSpacesAndUpper(l.rel7_type);
			self.rel8_type					:= ut.CleanSpacesAndUpper(l.rel8_type);
			self.rel9_type					:= ut.CleanSpacesAndUpper(l.rel9_type);
			self.rel10_type					:= ut.CleanSpacesAndUpper(l.rel10_type);
			self.rel11_type					:= ut.CleanSpacesAndUpper(l.rel11_type);
			self 										:= l;
			self 										:= [];
	end;
	
	dBH_Rels := project(dBH_Init_Current(trim(rel1_fein) <> ''), tMapBH_Rels(left));
	
	dBH_Rel_dis := distribute(dBH_Rels, hash(rel_fein, rel_inc_date));

	//*** Joining to Business Header records to propagete the BDID2 for the new entities
	Layouts.Temporary.Layout_Relatives tGetBDID2(dBH_Init_Current_dis l, dBH_Rel_dis r) := transform
			self.bdid2 := (unsigned6)l.bdid;
			self.bdid1 := r.bdid1;
			self			 := r;
	end;
	
	BH_Rel_W_BDIDs := join(dBH_Init_Current_dis, dBH_Rel_dis,
											 trim(left.link_fein) 		= trim(right.rel_fein) and
											 trim(left.link_inc_date) = trim(right.rel_inc_date),
											 tGetBDID2(left, right), right outer, local);
											 
	//*** Since Historical records have rel1_bdid, no need to join to the Biz header records to propage the bdid2.
	BH_Rel_Hist_W_BDIDs := project(dBH_Init_Historical, 
																 transform(Layouts.Temporary.Layout_Relatives, 
																					 self.bdid1 		:= (unsigned6)left.bdid,
																					 self.bdid2 		:= (unsigned6)left.rel1_bdid,
																					 self.rel1_type := left.rel1_type,
																					 self 					:= left,
																					 self						:= []
																					)
																);																
	
	BH_Rel_W_BDIDs_All := BH_Rel_Hist_W_BDIDs + BH_Rel_W_BDIDs(bdid1 <> 0 and bdid2 <> 0);
	
	return BH_Rel_W_BDIDs_All;
	
end;