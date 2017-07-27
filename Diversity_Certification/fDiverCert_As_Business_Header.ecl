 import Business_Header, ut,mdr,address,AID;

export fDiverCert_As_Business_Header(dataset(Diversity_Certification.layouts.keybuild) pBasefile) :=
function

	
		newKeyBuild	:=	record
			Diversity_Certification.Layouts.keybuild;
			string10	prim_range; 
			string2		predir;	
			string28	prim_name;	
			string4		addr_suffix; 
			string2		postdir;	
			string10	unit_desig;	
			string8		sec_range;	
			string25	p_city_name;	
			string25	v_city_name; 
			string2		st;	
			string5		zip;	
			string4		zip4;	
			string4		cart;	
			string1		cr_sort_sz;	
			string4		lot;	
			string1		lot_order;	
			string2		dbpc;	
			string1		chk_digit;	
			string2		rec_type;	
			string2		fips_state;	
			string3		fips_county;	
			string10	geo_lat;	
			string11	geo_long;	
			string4		msa;	
			string7		geo_blk;	
			string1		geo_match;	
			string4		err_stat;
			AID.Common.xAID RawAID;
	end;
	
	newKeyBuild tNormalizeAddress(Diversity_Certification.Layouts.keybuild l, unsigned1 cnt)	:=	transform
			self.prim_range		:=	choose(cnt	,l.m_prim_range	,l.p_prim_range);
			self.predir				:=	choose(cnt	,l.m_predir,l.p_predir  );
			self.prim_name		:=	choose(cnt	,l.m_prim_name , l.p_prim_name);
			self.addr_suffix	:=	choose(cnt	,l.m_addr_suffix , l.p_addr_suffix  );
			self.postdir			:=	choose(cnt	,l.m_postdir , l.p_postdir  );
			self.unit_desig		:=	choose(cnt	,l.m_unit_desig , l.p_unit_desig  );
			self.sec_range		:=	choose(cnt	,l.m_sec_range , l.p_sec_range  );		
			self.p_city_name	:=	choose(cnt	,l.m_p_city_name , l.p_p_city_name  );	
			self.v_city_name	:=	choose(cnt	,l.m_v_city_name , l.p_v_city_name  );	
			self.st						:=	choose(cnt	,l.m_st , l.p_st  );	
			self.zip					:=	choose(cnt	,l.m_zip , l.p_zip  );
			self.zip4					:=	choose(cnt	,l.m_zip4 , l.p_zip4  );	
			self.cart					:=	choose(cnt	,l.m_cart , l.p_cart  );
			self.cr_sort_sz		:=	choose(cnt	,l.m_cr_sort_sz , l.p_cr_sort_sz  );	
			self.lot					:=	choose(cnt	,l.m_lot , l.p_lot  );				
			self.lot_order		:=	choose(cnt	,l.m_lot_order , l.p_lot_order  );
			self.dbpc					:=	choose(cnt	,l.m_dbpc , l.p_dbpc  );	
			self.chk_digit		:=	choose(cnt	,l.m_chk_digit , l.p_chk_digit  );	
			self.rec_type			:=	choose(cnt	,l.m_rec_type , l.p_rec_type  );
			self.fips_state		:=	choose(cnt	,l.m_fips_state , l.p_fips_state  );	
			self.fips_county	:=	choose(cnt	,l.m_fips_county , l.p_fips_county  );	
			self.geo_lat			:=	choose(cnt	,l.m_geo_lat , l.p_geo_lat  );	
			self.geo_long			:=	choose(cnt	,l.m_geo_long , l.p_geo_long  );	
			self.msa					:=	choose(cnt	,l.m_msa , l.p_msa  );	
			self.geo_blk			:=	choose(cnt	,l.m_geo_blk , l.p_geo_blk  );	
			self.geo_match		:=	choose(cnt	,l.m_geo_match , l.p_geo_match  );
			self.err_stat			:=	choose(cnt	,l.m_err_stat , l.p_err_stat  );
			self.RawAID      	:=	choose(cnt	,l.Append_MailRawAID, l.Append_PhyRawAID );
			self							:=	l;
																					 
	end;
	dNormAddress				  :=normalize(pBasefile,  if((trim(left.m_prim_range,left,right)   = trim(left.p_prim_range,left,right) and
																										 trim(left.m_prim_name,left,right)   = trim(left.p_prim_name,left,right) and
																										 trim(left.m_p_city_name,left,right) = trim(left.p_p_city_name,left,right) and
																										 trim(left.m_st,left,right)          = trim(left.p_st,left,right) and
																										 trim(left.m_zip,left,right)         = trim(left.p_zip,left,right)) or
																										(trim(left.p_p_city_name) + trim(left.p_st) + trim(left.p_zip) = '')
																										,1,2),tNormalizeAddress(left,counter)); 
	
	
	Business_Header.Layout_Business_Header_New Translate_DC_To_BHF(newKeyBuild L) := transform

			self.bdid                     := l.bdid;
			self.source               		:= MDR.sourceTools.src_Diversity_Cert ;          // WB	Source file type
			self.vl_id                		:= 'DivCert'+' '+l.BusinessName;
			self.group1_id            		:= l.unique_id;
    	self.vendor_id            		:= 'DivCert'+' '+l.BusinessName;
   		self.prim_range           		:= l.prim_range;
   		self.predir               		:= l.predir;
   		self.prim_name            		:= l.prim_name;
   		self.addr_suffix          		:= l.addr_suffix;
   		self.postdir              		:= l.postdir;
   		self.unit_desig           		:= l.unit_desig;
   		self.sec_range            		:= l.sec_range;
   		self.city                 		:= l.v_city_name;
   		self.state                		:= l.st;
   		self.zip                  		:= (unsigned3)l.zip;
   		self.zip4                 		:= (unsigned2)l.zip4;
   		self.county               		:= l.fips_county;
   		self.msa                  		:= l.msa;
   		self.geo_lat              		:= l.geo_lat;
   		self.geo_long             		:= l.geo_long;
   		self.phone                		:=(integer)l.phone;
			self.phone_score         	    :=if(l.phone<>'',1,0);
			self.company_name		  				:=l.businessName;
   	  SELF.dt_first_seen 		  			:= (UNSIGNED4)L.dt_first_seen;
   	  SELF.dt_last_seen  		  			:= (UNSIGNED4)L.dt_last_seen;
   	  SELF.dt_vendor_first_reported := (UNSIGNED4)L.dt_vendor_first_reported;
   	  SELF.dt_vendor_last_reported  := (UNSIGNED4)L.dt_vendor_last_reported;
   	  SELF.fein         						:= 0;
   	  SELF.current       						:= TRUE;
			self.RawAID         	  			:= l.RawAID ;
			self													:=l;
		
	END;

 	DivCert_Firms := project(dNormAddress, Translate_DC_To_BHF(left));
	
	Business_Header.Layout_Business_Header_New RollupDivCert(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
		SELF.dt_first_seen 						:= ut.EarliestDate(L.dt_last_seen,R.dt_last_seen);
		SELF.dt_last_seen  					  := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		SELF.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.company_name  						:= IF(L.company_name = '', R.company_name, L.company_name);
		SELF.group1_id     						:= IF(L.group1_id = 0, R.group1_id, L.group1_id);
		SELF.vl_id         						:= IF(L.vl_id = '', R.vl_id, L.vl_id);
		SELF.vendor_id     						:= IF( L.vendor_id = '', R.vendor_id, L.vendor_id);
		SELF.phone         						:= IF(L.phone = 0, R.phone, L.phone);
		SELF.phone_score  					  := IF(L.phone = 0, R.phone_score, L.phone_score);
		SELF.prim_range    						:= IF(l.prim_range = '' , r.prim_range, l.prim_range);
		SELF.predir       					  := IF(l.predir = '' , r.predir, l.predir);
		SELF.prim_name     						:= IF(l.prim_name = '' , r.prim_name, l.prim_name);
		SELF.addr_suffix   						:= IF(l.addr_suffix = '' , r.addr_suffix, l.addr_suffix);
		SELF.postdir       						:= IF(l.postdir = '' , r.postdir, l.postdir);
		SELF.unit_desig   					  := IF(l.unit_desig = '', r.unit_desig, l.unit_desig);
		SELF.sec_range     						:= IF(l.sec_range = '' , r.sec_range, l.sec_range);
		SELF.city          						:= IF(l.city = '' , r.city, l.city);
		SELF.state        						:= IF(l.state = '' , r.state, l.state);
		SELF.zip           						:= IF(l.zip = 0 , r.zip, l.zip);
		SELF.zip4          						:= IF(l.zip4 = 0, r.zip4, l.zip4);
		SELF.county        						:= IF(l.county = '' , r.county, l.county);
		SELF.msa           						:= IF(l.msa = '' , r.msa, l.msa);
		SELF.geo_lat       						:= IF(l.geo_lat = '' , r.geo_lat, l.geo_lat);
		SELF.geo_long      						:= IF(l.geo_long = '' , r.geo_long, l.geo_long);
		SELF              					  := L;
	END;
	DivCert_Companies_Dist   := DISTRIBUTE(DivCert_Firms,HASH(zip, TRIM(prim_name), TRIM(prim_range),  TRIM(company_name)));
	DivCert_Companies_Sort   := SORT(DivCert_Companies_Dist, zip, prim_name,prim_range,  company_name,
																   dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	DivCert_Companies_Rollup := ROLLUP( DivCert_Companies_Sort,
																			left.zip = right.zip and
																			left.prim_name = right.prim_name and
																			left.prim_range = right.prim_range and
																			left.company_name = right.company_name , 
																			RollupDivCert(LEFT, RIGHT),
																			LOCAL);
	return DivCert_Companies_Rollup ;
end;
