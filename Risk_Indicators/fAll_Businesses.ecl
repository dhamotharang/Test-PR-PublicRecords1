import ut, aca, business_header, header, fcra, versioncontrol,paw,corp2,mdr;

lbizpnames			:= business_header.persistnames().BHBDIDSIC			;
pACAPersistname	:= '~thor_data400::persist::aca::file_aca_clean_new.fAll_Businesses';
use_prod 				:= versioncontrol._Flags.IsDataland							;
thor_cluster 		:= business_header._dataset().thor_cluster_Persists;

export fAll_Businesses(

	 boolean																							pUseDatasets		= false
	,string																								pPersistUnique	= ''
	,string																								pPersistname		= persistnames().fAllBusinesses + '::'
	,string																								pBhVersion			= 'qa'
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base		)	pInactiveCorps 	= paw.fCorpInactives()
	,dataset(business_header.layout_sic_code						)	pBh_bdid_sic		= business_header.bh_bdid_sic(pBhVersion,pUseDatasets := pUseDatasets,pPersistname := lbizpnames + '::' + pPersistUnique[1..length(pPersistUnique) - 2],pInactiveCorps := pInactiveCorps)
	,dataset(aca.Layout_ACA_Clean												) pAca_Clean 			= aca.File_ACA_Clean_New(pPersistname := pACAPersistname)
	,dataset(business_header.Layout_Business_Header_base) pBH							= business_header.files(pBhVersion,use_prod).Base.business_headers.new
	,dataset(risk_indicators.Layout_PBSA.base						) pPBSA_Clean 		= Risk_Indicators.File_PBSA.base
//	,dataset(Layouts.SicLookup													) pSicLookup			= Files().SicLookup.qa
	
) := function


	// -- Slim down BH BDID SIC record, remove D&B, dedup on sic code, bdid
	sic_rec :=
	record
		unsigned6 bdid;
		string2 source;
		string8 sic_code;
	end;
	
	dSic_filt 	:= pBh_bdid_sic(sic_code<>'',not (MDR.sourceTools.SourceIsDunn_Bradstreet(source)));
	dSic_slim 	:= project		(dSic_filt	,transform(sic_rec, self := left));
	dSic_dist		:= distribute	(dSic_slim	,bdid								);
	dSic_sort		:= sort				(dSic_dist	,bdid,sic_code,local);
	dSic_dedup	:= dedup			(dSic_sort	,bdid,sic_code,local);
	
	// Take BH file, remove restricted sources, get best address per bdid
	dbh_filt			:= pBH(~fcra.Restricted_BusHeader_Src(source, vendor_id[1..2]));
	dBestAddress	:= business_header.BestAddress(dbh_filt) : persist(pPersistname + 'BestAddress');

	// Join back to sic code file, append best address
	out_rec := Layouts.AddressSicCode;
	
	dJoin4Sics := join(
		 dSic_dedup
		,distribute(dBestAddress, bdid)
		,left.bdid = right.bdid
		,transform(
			out_rec
			,self									:= left	;
			 self.zip							:= intformat(right.zip,5,1);
			 self.zip4						:= intformat(right.zip4,4,1);
			 self									:= right;
		)
		,local
	);
	
	// Add ACA addresses
	out_rec get_ACAs(pAca_Clean L) := transform
		self.sic_code := '9223';
		self.city := 	L.v_city_name;
		Self.Source := MDR.sourceTools.src_Correctional_Facilities;
		self := l;
	end;

	dAca_Sics := project(pAca_Clean, get_ACAs(LEFT));
	
	// Add PBSA addresses
	dPBSA_Clean_ded := dedup(sort(project(pPBSA_Clean, Risk_Indicators.Layout_PBSA.base_slim),record),record);
	
	out_rec get_PBSAs(dPBSA_Clean_ded L) := transform
		self.sic_code := '4311';
		self.city 		:= L.v_city_name;
		self.state		:= L.st;
		self.Source := MDR.sourceTools.src_PBSA;
		self 					:= l;
	end;
	dPBSA_Sics := project(dPBSA_Clean_ded, get_PBSAs(LEFT));

	// concatenate
	dall_sics := (dJoin4Sics + dAca_Sics + dPBSA_Sics)(prim_name != '');	
	return dall_sics;
end;