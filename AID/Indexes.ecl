export Indexes
 :=
  module
		shared	dRawWithPayload	:=	project(Files.RawCacheQA,Layouts.rRawIndexPayload);
		shared	dStdWithPayload	:=	project(Files.StdCacheQA,Layouts.rStdIndexPayload);
		shared	dACEWithPayload	:=	project(Files.ACECacheQA,Layouts.rACEIndexPayload);

		rCombined
		 :=
			record
				Layouts.rRawIndexPayload.AID;
				Layouts.rRawIndexPayload	Raw;
				Layouts.rStdIndexPayload	Std;
				Layouts.rACEIndexPayload	ACE;
			end
		 ;

		rCombined	tCombinedRawStd(dRawWithPayload pRaw, dStdWithPayload pStd)
		 :=
			transform
				self.AID	:=	pRaw.AID;
				self.Raw	:=	pRaw;
				self.Std	:=	pStd;
				self.ACE	:=	[];
			end
		 ;

		dCombinedRawStd	:=	join(dRawWithPayload,dStdWithPayload,
														 left.StdAID = right.AID,
														 tCombinedRawStd(left,right)
														);

		rCombined	tCombinedRawStdACE(dCombinedRawStd pRawStd, dACEWithPayload pACE)
		 :=
			transform
				self.ACE	:=	pACE;
				self			:=	pRawStd;
			end
		 ;

		dCombined	:=	join(distribute(dCombinedRawStd,Std.CleanAID),distribute(dACEWithPayload,AID),
											 left.Std.CleanAID = right.AID,
							 				 tCombinedRawStdACE(left,right),
							 				 local
											);

		export	Key_Raw_Mapped		:=	index(dCombined, {AID}, {dCombined}, '~thor::key::aid::raw::qa::aid.full');

		export	Key_Raw_AID				:=	index(dRawWithPayload, {AID}, {dRawWithPayload},'~thor::key::aid::raw::qa::aid');
		export	Key_Raw_Hash			:=	index(dRawWithPayload, {Hash32_Full}, {dRawWithPayload},'~thor::key::aid::raw::qa::hash');
		export	Key_Raw_Lines			:=	index(dRawWithPayload, {Line1,Line2,Line3,LineLast}, {AID},'~thor::key::aid::raw::qa::lines');
		export	Key_Raw_StdAID		:=	index(dRawWithPayload, {StdAID}, {AID},'~thor::key::aid::raw::qa::stdaid');

		export	Key_Std_AID				:=	index(dStdWithPayload, {AID}, {dStdWithPayload},'~thor::key::aid::std::qa::aid');
		export	Key_Std_Hash			:=	index(dStdWithPayload, {Hash32_Full}, {dStdWithPayload},'~thor::key::aid::std::qa::hash');
		export	Key_Std_Lines			:=	index(dStdWithPayload, {Line1,LineLast}, {AID},'~thor::key::aid::std::qa::lines');
		export	Key_Std_CleanAID	:=	index(dStdWithPayload, {CleanAID}, {AID},'~thor::key::aid::std::qa::cleanaid');

		export	Key_ACE_AID				:=	index(dACEWithPayload, {AID}, {dACEWithPayload},'~thor::key::aid::ACE::qa::aid');
		export	Key_ACE_Hash			:=	index(dACEWithPayload, {Hash32_Full}, {AID}, '~thor::key::aid::ACE::qa::hash');
		export	Key_ACE_Lines			:=	index(dACEWithPayload, {prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip5,zip4}, {AID}, '~thor::key::aid::ACE::qa::lines');
		export	Key_ACE_ZipAddr		:=	index(dACEWithPayload, {zip5,prim_name,prim_range}, {AID}, '~thor::key::aid::ACE::qa::zip_addr');
  end
 ;
