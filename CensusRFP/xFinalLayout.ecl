// convert to deliverable layout
import STD;

string AddrLine1(STRING10 prim_range,
					STRING2  predir,
					STRING28 prim_name,
					STRING4  suffix,
					STRING2  postdir,
					STRING10 unit_desig,
					STRING8  sec_range) :=
				STD.Str.CleanSpaces(prim_range + ' ' +
					  predir + ' ' +
					 prim_name + ' ' +
					  suffix + ' ' +
					  postdir + ' ' +
					 unit_desig + ' ' +
					  sec_range);
				
string	reformatDate(string dt) := FUNCTION
			s := TRIM(dt,left,right);
			return MAP(
					s='' => '',
					s='0' => '',
					s[5..8] + s[1..4]);
END;
EXPORT Layout_Final xFinalLayout(Layout_2015 din) := TRANSFORM

		self.LexId := INTFORMAT(din.LexId, 20, 0);
		self.age := IF(din.age=0,'',INTFORMAT(din.age, 3, 0));
		self.dob := IF(din.dob='','', din.dob[1..2]+'XX'+din.dob[5..8]);
		self.sex := din.gender;
//		self.Housing_Tenure := INTFORMAT(din.Housing_Tenure, 2, 0);
//		self.Housing_Population := IF(din.Housing_Population=0,'<1',INTFORMAT(din.Housing_Population, 2, 0));
// reformat dates to mmddyyyy format
		self.listed_phone_status_date := reformatDate(din.listed_phone_status_date);
		self.email_address_activity_date := reformatDate(din.email_address_activity_date);
		
// make cellphone the alternate number
		self.alternate_phone_num 		:= IF(din.alternate_phone_num='',din.cellphone_num,din.alternate_phone_num);
		self.alternate_phone_type		:= IF(din.alternate_phone_num='',IF(din.cellphone_num='','','C'),din.alternate_phone_type);
		self.alternate_phone_status	:= IF(din.alternate_phone_num='',IF(din.cellphone_num='','',din.cellphone_status),din.alternate_phone_status);
		self.alternate_phone_status_date	:= reformatDate(
									IF(din.alternate_phone_num='',IF(din.cellphone_num='','',din.cellphone_status_date),din.alternate_phone_status_date));

		self.addr_curr_address := AddrLine1(
																		din.addr_curr_prim_range,
																		din.addr_curr_predir,
																		din.addr_curr_prim_name,
																		din.addr_curr_postdir,
																		din.addr_curr_suffix,
																		din.addr_curr_unit_desig,
																		din.addr_curr_sec_range);
/*		self.addr_alt_address := AddrLine1(
																		din.addr_alt_prim_range,
																		din.addr_alt_predir,
																		din.addr_alt_prim_name,
																		din.addr_alt_postdir,
																		din.addr_alt_suffix,
																		din.addr_alt_unit_desig,
																		din.addr_alt_sec_range);
		self.addr_hist1_address := AddrLine1(
																		din.addr_hist1_prim_range,
																		din.addr_hist1_predir,
																		din.addr_hist1_prim_name,
																		din.addr_hist1_postdir,
																		din.addr_hist1_suffix,
																		din.addr_hist1_unit_desig,
																		din.addr_hist1_sec_range);
		self.addr_hist2_address := AddrLine1(
																		din.addr_hist2_prim_range,
																		din.addr_hist2_predir,
																		din.addr_hist2_prim_name,
																		din.addr_hist2_postdir,
																		din.addr_hist2_suffix,
																		din.addr_hist2_unit_desig,
																		din.addr_hist2_sec_range);
*/

		self := din;

END;