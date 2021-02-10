/*2014-03-24T19:00:45Z (Jaideep Habbu)

*/
#stored('did_add_force','thor');
import address,
			 bipv2,
	     business_header,
	     business_header_ss,
	     did_add,
		   SAM,
			 //needed for DID  macro
			 Health_Provider_Services;


export Proc_Build_Base(string8 filedate) := function

// XML now comes from SAM and is in the format of what the Worldcheck Bridger uses.
ds_Standardized_GSA := StandardizeInputFile.fPreProcess(filedate);

layout_std_gsa_uniqueid := record
	unsigned8	uniqueid;
	ds_Standardized_GSA;
end;

ds_Standardized_GSA_uniqueid := project(ds_Standardized_GSA,transform(layout_std_gsa_uniqueid,self.uniqueid := COUNTER, SELF:=LEFT));

export Layout_Clean_Name := record
		GSA.layouts_gsa.slim_clean_gsa;
		string1         name_flag;
		string5         cln_title;
		string20        cln_fname;
		string20        cln_mname;
		string20        cln_lname;
		string5         cln_suffix;
		string5         cln_title2;
		string20        cln_fname2;
		string20        cln_mname2;
		string20        cln_lname2;
		string5         cln_suffix2;
end;

ds_slim_clean_gsa   := project(ds_Standardized_GSA_uniqueid,transform(Layout_Clean_Name, SELF:=LEFT, SELF := []));

//Call Mac_Is_Business and determine whether the Name is a Business or Person's name.
Address.Mac_Is_Business(ds_slim_clean_gsa,Name,ds_cleaned_name,name_flag,false,true );

Layout_Clean_Name trfNameInfo(Layout_Clean_Name l) := TRANSFORM
		self.bdid					:= 0;
		self.did					:= 0;
		self.name_flag		:= l.name_flag;
		//the name field has been changed to only contain the business name.  Person names are mapped to fname,mname,lname,etc.
		// self.name					:= IF (l.name_flag = 'B',StringLib.StringCleanSpaces(trim(l.name)),'');
		self.fname				:= IF (l.name_flag = 'P',StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.cln_fname))),'');
		self.mname				:= IF (l.name_flag = 'P',StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.cln_mname))),'');
		self.lname				:= IF (l.name_flag = 'P',StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.cln_lname))),'');
		self.name_suffix	:= IF (l.name_flag = 'P',StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.cln_suffix))),'');
		name_score 				:= Business_Header.CleanName(self.fname, self.mname, self.lname, self.name_suffix)[142];
		self.name_score 	:= name_score;
		self 							:= l;
end;

//Populate fields in GSA.Layouts_GSA.Base fields with cln_* fields
ds_clean_gsa		:= project(ds_cleaned_name,trfNameInfo(LEFT));

ds_business 		:= ds_clean_gsa(name_flag = 'B');
ds_non_business := ds_clean_gsa(name_flag <> 'B');

business_matchset := ['A','N'];

Business_Header_SS.MAC_Add_BDID_Flex(
			 ds_business		 									// Input Dataset
			,business_matchset                // BDID Matchset what fields to match on
			,name	                    				// company_name
			,prim_range		                    // prim_range
			,prim_name		                    // prim_name
			,zip					            				// zip5
			,sec_range		                    // sec_range
			,st				                				// state
			,foo				               				// phone
			,foo					                    // fein
			,bdid															// bdid
			,layouts_gsa.slim_clean_gsa				// Output Layout
			,false                            // output layout has bdid score field?
			,score_field                      // bdid_score
			,dBdidOut                         // Output Dataset
			,																	// default threscold
			,																	// use prod version of superfiles
			,																	// default is to hit prod from dataland, and on prod hit prod.
			,bipv2.xlink_version_set					// boolean indicator set to create bdid's & xlinkids
			,																	// url
			,																	// email
			,p_city_name											// city
			,fname														// fname
			,mname														// mname
			,lname														// lname
);

person_matchset := ['A'];

did_Add.MAC_Match_Flex(
	ds_non_business,
	person_matchset,
	'','',
	fname, mname, lname, name_suffix,
	prim_range, prim_name, sec_range, zip, st, '',
	did,
	layouts_gsa.slim_clean_gsa,
	false, bdid_score,
	75,
	didOut);

ds_dist_full_gsa := distribute(ds_Standardized_GSA_uniqueid,hash(uniqueid));
ds_dist_slim_gsa := distribute((dBdidOut + didOut),hash(uniqueid));

layouts_gsa.clean_gsa joinIDs(ds_dist_full_gsa L,ds_dist_slim_gsa R) := transform
	self.did 				:= if(r.did					<> 0, r.did					, 0);
	self.bdid 			:= if(r.bdid				<> 0, r.bdid				, 0);
	self.DotID			:= if(r.DotID				<> 0, r.DotID				, 0);
	self.DotScore		:= if(r.DotScore		<> 0, r.DotScore		, 0);
	self.DotWeight	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
	self.EmpID			:= if(r.EmpID				<> 0, r.EmpID				, 0);
	self.EmpScore		:= if(r.EmpScore		<> 0, r.EmpScore		, 0);
	self.EmpWeight	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
	self.POWID			:= if(r.POWID				<> 0, r.POWID				, 0);
	self.POWScore		:= if(r.POWScore		<> 0, r.POWScore		, 0);
	self.POWWeight	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
	self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, 0);
	self.ProxScore	:= if(r.ProxScore		<> 0, r.ProxScore		, 0);
	self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
	self.SELEID			:= if(r.SELEID			<> 0, r.SELEID			, 0);
	self.SELEScore	:= if(r.SELEScore		<> 0, r.SELEScore		, 0);
	self.SELEWeight	:= if(r.SELEWeight	<> 0, r.SELEWeight	, 0);
	self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, 0);
	self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, 0);
	self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
	self.UltID			:= if(r.UltID				<> 0, r.UltID				, 0);
	self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, 0);
	self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
	self.fname			:= r.fname;
	self.mname			:= r.mname;
	self.lname			:= r.lname;
	self.name_suffix:= r.name_suffix;
	self.name_score := r.name_score;
	self.name				:= r.name; //name contains only business names
	self 						:= L;
end;

all_recs := join(ds_dist_full_gsa,ds_dist_slim_gsa,
                   left.uniqueid = right.uniqueid,
				           joinIDs(left,right),
				           left outer,
									 local);
Health_Provider_Services.mac_get_best_lnpid_on_thor (
			all_recs
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,//best_SSN
			,//clean_DOB
			,//phone1
			,//LIC_STATE
			,//LIC_Num_in
			,//TAX_ID
			,//DEA_NUM
			,//gsa_id
			,//NPI_NUM
			,//UPIN
			,DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,out_final,false,38
			);


baseFile := project(out_final,transform(gsa.Layouts_GSA.layout_base, self := left, self := []));
//baseFile := project(out_final,transform(gsa.Layouts_GSA.clean_gsa, self := left, self := []));

return baseFile;

end;
