 import Business_Header, ut,mdr,address,aid;

export fDiverCert_As_Business_Contact(dataset(Diversity_Certification.layouts.keybuild) pBasefile ) :=function

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
			self.RawAID       :=	choose(cnt	,l.Append_MailRawAID, l.Append_PhyRawAID );
			self							:=	l;
																					 
	end;
		
	 
	dNormAddress				  :=  normalize(pBasefile, if((trim(left.m_prim_range,left,right)  = trim(left.p_prim_range,left,right) and
																										 trim(left.m_prim_name,left,right)   = trim(left.p_prim_name,left,right) and
																										 trim(left.m_p_city_name,left,right) = trim(left.p_p_city_name,left,right) and
																										 trim(left.m_st,left,right)          = trim(left.p_st,left,right) and
																										 trim(left.m_zip,left,right)         = trim(left.p_zip,left,right)) or
																										(trim(left.p_p_city_name) + trim(left.p_st) + trim(left.p_zip) = '')
																										,1,2),tNormalizeAddress(left,counter)); 
	 
	
	Business_Header.Layout_Business_Contact_Full_New Translate_DC_To_BC(newKeyBuild l) := transform
		  self.bdid                 := l.bdid;
		  self.did                  := l.did;
		  self.source               := MDR.sourceTools.src_Diversity_Cert ;          // WB	Source file type
 		  self.vl_id                := 'DivCert'+' '+l.BusinessName;
    	self.vendor_id            := 'DivCert'+' '+l.BusinessName;
   		self.dt_first_seen        := (unsigned4)L.dt_first_seen;
   		self.dt_last_seen         := (unsigned4)l.dt_last_seen;
   		self.title                := l.title;
   		self.fname                := l.fname;
   		self.mname                := l.mname;
   		self.lname                := l.lname;
   		self.name_suffix          := l.suffix;
   		self.prim_range           := l.prim_range;
   		self.predir               := l.predir;
   		self.prim_name            := l.prim_name;
   		self.addr_suffix          := l.addr_suffix;
   		self.postdir              := l.postdir;
   		self.unit_desig           := l.unit_desig;
   		self.sec_range            := l.sec_range;
   		self.city                 := l.v_city_name;
   		self.state                := l.st;
   		self.zip                  := (unsigned3)l.zip;
   		self.zip4                 := (unsigned2)l.zip4;
   		self.county               := l.fips_county;
   		self.msa                  := l.msa;
   		self.geo_lat              := l.geo_lat;
   		self.geo_long             := l.geo_long;
   		self.phone                :=(integer)l.phone;
   		self.email_address        :=l.email ;
   		//self.company_title      := '';
   		self.company_source_group := 'DivCert'+' '+l.BusinessName; 
   		self.company_name         := l.businessName;
   		self.company_prim_range   := l.prim_range;
   		self.company_predir       := l.predir;
   		self.company_prim_name    := l.prim_name;
   		self.company_addr_suffix  := l.addr_suffix;
   		self.company_postdir      := l.postdir;
   		self.company_unit_desig   := l.unit_desig;
   		self.company_sec_range    := l.sec_range;
   		self.company_city         := l.v_city_name;
   		self.company_state        := l.st;
   		self.company_zip          := (unsigned3)l.zip;
   		self.company_zip4         := (unsigned2)l.zip4;
   		self.company_phone        := (integer)l.phone;
   		self.record_type          := 'C';          // Current/Historical indicator
		  self.RawAID         	    := l.RawAID ;
   		self                      := l;
		  self					            :=[];
	end;

ds_BusinessCont := project(dNormAddress,Translate_DC_To_BC(left));
	
return dedup(sort(ds_BusinessCont,record),record);
end;
