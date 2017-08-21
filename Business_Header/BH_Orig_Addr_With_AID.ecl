
export BH_Orig_Addr_With_AID( 

	 dataset(Layout_Business_Header_Temp		)	pBH_Basic_Match_Clean			= BH_Basic_Match_Clean	()
	,dataset(Layout_Business_Header_Temp		)	pBH_Match_Init						= BH_Match_Init					()
) :=
function

		dBH_Clean := pBH_Basic_Match_Clean;
		dBH_Init  := pBH_Match_Init;
		
		//*** Replacing the best address got from the AID process with the Orig address for writing
		//*** out to business base.
		Layout_Business_Header_Temp getOrigAddr (dBH_Clean l, dBH_Init r) := transform
			self.prim_range		:=  r.prim_range;
			self.predir				:= 	r.predir;
			self.prim_name		:=	r.prim_name;
			self.addr_suffix	:=	r.addr_suffix;
			self.postdir			:=	r.postdir;
			self.unit_desig		:=	r.unit_desig;
			self.sec_range		:=	r.sec_range;
			self.city					:=	r.city;
			self.state				:=	r.state;
			self.zip					:=	r.zip;
			self.zip4					:=	r.zip4;			
			self 							:=	l;			
		end;
		
		dBH_Orig_Addr_For_Base := join(distribute(dBH_Clean,rcid), distribute(dBH_Init,rcid),
																	 left.rcid = right.rcid,
																	 getOrigAddr(left,right), local
																	);
		
		return (dBH_Orig_Addr_For_Base);
end;
	