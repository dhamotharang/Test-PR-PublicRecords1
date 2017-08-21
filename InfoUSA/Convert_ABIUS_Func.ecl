

//This is USABIZ  this is just a copy / paste  it has not been started / needs plenty of work





// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search,ut,codes;
import Property,USAbizV2_Services;


 


export Convert_ABIUS_Func(DATASET(InfoUSA.Layout_ABIUS_Company_Base)ds) := FUNCTION


indata_county_state := record
InfoUSA.Layout_ABIUS_Company_Base;
	STRING2  fips_state_desc;
	STRING18 fips_county_desc;
	string50 gender_desc := '';
	string35 contact_title_desc := ''; 
end;



indata_county_state join_state_county(InfoUSA.File_ABIUS_Company_Base l,
						Property.Layout_County_Code_Names r ) := transform
self.fips_state_desc := r.state;
self.fips_county_desc := r.county_name;
self.contact_title_desc := USAbizV2_Services.GetContactTitle (l.contact_title);
self := l
end;	
	
join_out := join(ds,Property.File_County_Code_Names,
        (integer)left.COUNTY_CD = (integer)right.fips_county_code and
		(integer) left.STATE_CD = (integer) right.state_fips,
        join_state_county(left,right),left outer, lookup);


ut.Mac_Convert_Codes_To_Desc(join_out,indata_county_state,gender_ds,'GENERAL',
																					'GENDER',gender_desc,
																					gender_cd,gender_cd);




	Text_Search.Layout_Document cvt(indata_county_state l) := TRANSFORM
		SELF.docRef.src := 0; // need stuff here
		SELF.docRef.doc := (unsigned6)hash32(l.ABI_NUMBER);
		SELF.segs := DATASET([
		
		{1,0,l.contact_name},
		{2,0,l.company_name},
		{3,0,l.contact_name + '; '+l.company_name +'; '+l.CONTACT_LNAME + '; ' +
						l.CONTACT_FNAME},
		//{4,0,l.city1 + '; '+l.SECONDARY_CITY},
		//{5,0,l.state1 + '; ' + l.SECONDARY_STATE},
		//{6,0,l.zip1_5 + '; '+ l.SECONDARY_ZIP_CODE},
		//{7,0,l.zip1_4},
		{8,0,l.street1 + ' ' + l.city1 + ' ' + l.state1 + ' '+ l.zip1_5+' '+ l.zip1_4+';'+
					l.secondary_address+' '+l.secondary_city+' '+l.secondary_state+
					' '+l.secondary_zip_code},
		//{9,0,l.zip1_5+'-'+l.zip1_4+'; '+l.secondary_zip_code},
		{10,0,l.carrier_cd},
		{11,0,l.fips_state_desc},
		{12,0,l.fips_county_desc},
		{13,0,l.sic_desc},
		{14,0,Infousa.Decode_Franchise(l.sic_cd+l.Franchise_CD)},
		{15,0,l.AD_SIZE},	
		{16,0,l.POPULATION},
		{17,0,l.YEAR_STARTED},
		{18,0,l.CONTACT_LNAME + ' '+ l.CONTACT_FNAME},		
		{19,0,l.CONTACT_TITLE_desc},
		{20,0,l.GENDER_DESC},
		{21,0,l.EMPLOYEE_SIZE+ ';' + l.TOTAL_EMPLOYEE_SIZE + '; '+l.NUM_EMPLOYEES_ACTUAL
							+ '; ' + l.TOTAL_EMPLOYEES_ACTUAL},
		{22,0,l.SALES_VOLUME},
		{23,0,l.INDUSTRY_desc},
		{24,0,l.BUSINESS_STATUS},		
		{25,0,l.FAX},
		{26,0,l.OFFICE_SIZE},
		{27,0,l.PRODUCTION_DATE},		
		{28,0,l.ABI_NUMBER},
		{29,0,l.SUBSIDIARY_PARENT_NUM},
		{30,0,l.ULTIMATE_PARENT_NUM},
		//{31,0,l.PRIMARY_SIC},
		//{32,0,l.SECONDARY_SIC_1 +'; '+l.SECONDARY_SIC_2 +'; '+l.SECONDARY_SIC_3 +'; '+
			//			l.SECONDARY_SIC_4 },
		{33,0,l.TOTAL_OUTPUT_SALES},
		{34,0,l.PUBLIC_CO_INDICATOR},
		{35,0,l.STOCK_EXCHANGE},
		{36,0,l.CREDIT_DESC},
		{37,0,l.PHONE}
		

//vesa: doxie_build.key_prep_Vehicles

		], Text_Search.Layout_Segment);
	END;

	reslt := PROJECT(gender_ds, cvt(LEFT));
	
	// transform to normalize this data into layout.DocSeg  see liens
	
	//call to do the normalize
	
	// returned normalized data
	
	
Text_Search.layout_DocSeg flatten(Text_Search.Layout_Document l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
END;
	
norm_fein := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	

	
	
	RETURN norm_fein;
END;