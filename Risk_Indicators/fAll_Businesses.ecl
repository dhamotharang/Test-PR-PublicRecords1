import aca, business_header, header, fcra, versioncontrol,paw,corp2,mdr;

lbizpnames			:= business_header.persistnames().BHBDIDSIC			;
pACAPersistname	:= '~thor_data400::persist::aca::file_aca_clean';
use_prod 				:= versioncontrol._Flags.IsDataland							;
thor_cluster 		:= business_header._dataset().thor_cluster_Persists;

export fAll_Businesses(

	 string																								pPersistUnique	= ''
	,boolean																							pUseDatasets		= false
	,string																								pPersistname		= thor_cluster + 'persist::Risk_Indicators::fAll_Businesses::'
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base		)	pInactiveCorps 	= paw.fCorpInactives()
	,dataset(business_header.layout_sic_code						)	pBh_bdid_sic		= business_header.bh_bdid_sic(pUseDatasets := pUseDatasets,pPersistname := lbizpnames + '::' + pPersistUnique[1..length(pPersistUnique) - 2],pInactiveCorps := pInactiveCorps)
	,dataset(aca.Layout_ACA_Clean												) pAca_Clean 			= aca.File_ACA_Clean(pUseDatasets := pUseDatasets, pPersistname := pACAPersistname)
	,dataset(business_header.Layout_Business_Header_base) pBH							= business_header.files(,use_prod).Base.business_headers.built
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
	out_rec get_ACAs(aca.Layout_ACA_Clean L) := transform
		self.sic_code := '9223';
		self.city := 	L.v_city_name;
		self := l;
	end;

	dAca_Sics := project(pAca_Clean, get_ACAs(LEFT));

	// concatenate
	dall_sics := (dJoin4Sics + dAca_Sics)(prim_name != '');
	
	dall_sics_dedup := dedup(dall_sics, all);

	return dall_sics_dedup;
	
end;