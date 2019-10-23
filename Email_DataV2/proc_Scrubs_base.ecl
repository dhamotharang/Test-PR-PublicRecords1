import Scrubs, Scrubs_Email_Data, Orbit3SOA, SALT30, ut, Email_DataV2, PromoteSupers, tools, std;

EXPORT proc_Scrubs_base(string version, string emailList='') := FUNCTION
#workunit('name', 'Scrubs Email_DataV2 Base');
#option('multiplePersistInstances',FALSE);


RecordsToScrub := Email_DataV2.File_Email_Base_Scrubs(version);
ScrubsRun :=Scrubs.ScrubsPlus_PassFile(recordstoScrub,'Email_DataV2','Scrubs_Email_DataV2','Scrubs_Email_DataV2','',version,emailList);

BitmapInfile:=dataset('~thor_data::Scrubs_Email_DataV2::Scrubs_Bits',Scrubs_Email_DataV2.Scrubs.Bitmap_Layout,thor);
	
	//map back to base layout and append bitmap
	Email_DataV2.Layouts.Scrubs_bits_base AppendBit(BitmapInfile input) := TRANSFORM
			self.clean_name.title  					:= input.title;
			self.clean_name.fname  					:= input.fname;
			self.clean_name.mname  					:= input.mname;
			self.clean_name.lname  					:= input.lname;
			self.clean_name.name_suffix  		:= input.name_suffix;
			self.clean_name.name_score  		:= input.name_score;
			self.clean_address.prim_range  	:= input.prim_range;
			self.clean_address.predir  			:= input.predir;
			self.clean_address.prim_name  	:= input.prim_name;
			self.clean_address.addr_suffix  := input.addr_suffix;
			self.clean_address.postdir  		:= input.postdir;
			self.clean_address.unit_desig  	:= input.unit_desig;
			self.clean_address.sec_range  	:= input.sec_range;
			self.clean_address.p_city_name  := input.p_city_name;
			self.clean_address.v_city_name  := input.v_city_name;
			self.clean_address.st  					:= input.st;
			self.clean_address.zip  				:= input.zip;
			self.clean_address.zip4  				:= input.zip4;
			self.clean_address.cart  				:= input.cart;
			self.clean_address.cr_sort_sz   := input.cr_sort_sz;
			self.clean_address.lot  				:= input.lot;
			self.clean_address.lot_order  	:= input.lot_order;
			self.clean_address.dbpc  				:= input.dbpc;
			self.clean_address.chk_digit  	:= input.chk_digit;
			self.clean_address.rec_type  		:= input.rec_type;
			self.clean_address.county  			:= input.county;
			self.clean_address.geo_lat  		:= input.geo_lat;
			self.clean_address.geo_long  		:= input.geo_long;
			self.clean_address.msa  				:= input.msa;
			self.clean_address.geo_blk  		:= input.geo_blk;
			self.clean_address.geo_match  	:= input.geo_match;
			self.clean_address.err_stat  		:= input.err_stat;
			//DF-16472
			self.orig_email									:= REGEXREPLACE('[\n|\r]',input.orig_email,'');
			self := input;
	END;
	
	dbuildbase := project(BitmapInfile, AppendBit(left));
	
	PromoteSupers.MAC_SF_BuildProcess(dbuildbase,'~thor_data400::base::email_datav2',build_email_base,2,,true);

 RETURN sequential(ScrubsRun
									,build_email_base);
END;