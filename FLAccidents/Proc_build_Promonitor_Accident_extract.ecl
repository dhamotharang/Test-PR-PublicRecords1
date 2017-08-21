import _control,ut,address,DID_Add,lib_stringlib,header_slimsort, watchdog,lib_date;

/*
 1) Extract the Accidents records for certain states where and clean name is populated. 
 2) denormalize the vehicles involved 
 3) Append the DOB and SSN from watchdog - filebest
 4) Create a file and store it in thor
 5) Create a delta using the previous file and current file. 
 6) Despray the (new records and updated records) to be sent to Promonitor.
 
*/
//#workunit('name','FL Accidents Promonitor Extract');
DestinationIP       := _control.IPAddress.bctlpedata11; 

// ds := dataset(ut.foreign_prod +'~thor_data400::base::alpharetta::national_accidents_20100923',FLAccidents.Layout_NtlAccidents_Alpharetta.clean,thor);
// ds_Accidents := ds(state_abbr in ['AK','AL','AR','CO','CT','DC','DE','FL','GA','HI','ID','IL','IN','KS','MA','MD','ME',
								                  // 'MI','MO','NC','ND','NE','NJ','NM','NY','OH','OK','OR','PA','SC','SD','TN','UT','VA','VT','WI','WV','WY']);
								
ds_Accidents := FLAccidents.BaseFile_NtlAccidents_Alpharetta(state_abbr in ['AK','AL','AR','CO','CT','DC','DE','FL','GA','HI','ID','IL','IN','KS','MA','MD','ME',
								                                                            'MI','MO','NC','ND','NE','NJ','NM','NY','OH','OK','OR','PA','SC','SD','TN','UT','VA',
																																						'VT','WI','WV','WY'] and 
																																						LIB_Date.DaysApart( ut.GetDate ,loss_date[7..10]+loss_date[1..2]+loss_date[4..5] )< 31); 

Accidents_Promonitor_rec := RECORD, MAXLENGTH(4096)
    string50   EXTERNAL_ID;
	  String9	   SSN;
    string2    DOB_MONTH;
    string2    DOB_DAY;
		string4    DOB_YEAR;
		string50   FIRST_NAME;
		string50   MIDDLE_NAME;
		string50   LAST_NAME;
		string50   STREET_1;
		string50   STREET_2;
		string50   STREET_3;
		string50   CITY;
		string2    STATE;
		string5    POSTAL_CODE;
		String1    COUNTRY;
		string11   ACCOUNT_ID;
		string20   USERNAME;
		string1    OPERATION_TYPE;
		string50   REFERENCE_ID;
		string50   DL_NUM;
		string2    DL_STATE;
		string3    CELL_PHONE_AREA_CODE;
		string7    CELL_PHONE_NUMBER;
		string3    WORK_PHONE_AREA_CODE;
		string7    WORK_PHONE_NUMBER;
		string3    HOME_PHONE_AREA_CODE;
		string7    HOME_PHONE_NUMBER;
		unsigned8  LINK_ID;
    string10   LOSS_DATE; 
    string10   LOSS_TIME; 
    string20   LOCATION_HOUSE_NBR; 
    string50   LOCATION_STREET; 
    string20   LOCATION_APT_NBR; 
    string50   LOCATION_CROSS_STREET; 
    string50   LOCATION_CITY; 
    string2    LOCATION_STATE; 
    string5    LOCATION_ZIP5; 
    string4    LOCATION_ZIP4; 
    string50   LOCATION_COUNTY; 
		string     TAG; 
    string2    TAG_STATE; 
    string25   VIN1; 
    string40   MAKE1; 
    string30   MODEL1; 
    string4    YEAR1; 
    string20   COLOR1;
    string25   VIN2; 
    string40   MAKE2; 
    string30   MODEL2; 
    string4    YEAR2; 
    string20   COLOR2;
    string25   VIN3; 
    string40   MAKE3; 
    string30   MODEL3; 
    string4    YEAR3; 
    string20   COLOR3;
    string20   PARTY_TYPE;
    string50   FIRST_NAME_2; 
    string50   MIDDLE_NAME_2; 
    string50   LAST_NAME_2; 
    string50   FIRST_NAME_3; 
    string50   MIDDLE_NAME_3; 
    string50   LAST_NAME_3;  
		string30   BUSINESS_NAME;
end;
 
string v_process_date := ut.GetDate[1..8];
//string v_process_date := '20100923';

 Temp_rec := record
    Accidents_Promonitor_rec;
		string process_date := '';
    unsigned1 did_score;
 End;
  
 Temp_vehicle_Rec := record
     string ORDER_ID; 
		 string SEQUENCE_NBR;
		 string VEHICLE_INCIDENT_ID;
		 string VEHICLE_NBR;
 		 string vehVIN;
     string vehYEAR;
     string vehMAKE;
     string vehMODEL;
     string COLOR;
 End; 		

Proj_accident_slim  := project(ds_Accidents , Temp_vehicle_Rec);
accident_slim_sorted:= sort(Proj_accident_slim,order_id,sequence_nbr,vehicle_incident_id,vehicle_nbr);

Filebest := Watchdog.File_Best ; 

Temp_rec changelayout (ds_Accidents l	) :=
		transform
		self.EXTERNAL_ID    := trim(l.ORDER_ID+l.SEQUENCE_NBR);
		//Commenting the following code since we cannot use any field coming from order table.
		self.SSN   			    := '';//if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,l.ssn_1,'');
		self.DOB_MONTH      := IF(regexfind('^([0-9]{8})$',trim(l.DOB)),l.DOB[5..6],'');
    self.DOB_DAY        := IF(regexfind('^([0-9]{8})$',trim(l.DOB)),l.DOB[7..8],'');
		self.DOB_YEAR       := IF(regexfind('^([0-9]{8})$',trim(l.DOB)),l.DOB[1..4],'');
															 
    // concatnamLFMS := stringlib.stringfindreplace(stringlib.stringfindreplace(trim(L.LAST_NAME_1)  + ' '+ trim(L.FIRST_NAME_1)  + ' '+ trim(L.MIDDLE_NAME_1), '  ',' '), '  ',' ');
  	// concatnamFMLS := stringlib.stringfindreplace(stringlib.stringfindreplace(trim(L.FIRST_NAME_1) + ' '+ trim(L.MIDDLE_NAME_1) + ' '+ trim(L.LAST_NAME_1), '  ',' '), '  ',' ');
	
		// self.FIRST_NAME     := trim(tempName[6..25]);
		// self.MIDDLE_NAME    := if(L.MIDDLE_NAME_1 = '' and trim(tempName[26..45]) in ['SR','JR'] , '', trim(tempName[26..45]));
		// self.LAST_NAME      := if(trim(tempName[46..48]) in ['JR ','SR '],trim(tempName[49..65]),trim(tempName[46..65]));
		self.FIRST_NAME     := l.fname;
		self.MIDDLE_NAME    := l.mname;
		self.LAST_NAME      := l.lname;
	
	  self.STREET_1       := '';																
		self.STREET_2       := '';
		self.STREET_3       := '';
		self.CITY           := '';
		self.STATE          := '';
		self.POSTAL_CODE    := '';
		
		self.COUNTRY        := '';
		self.ACCOUNT_ID     := '210';
		self.USERNAME       := 'PSDataLoad';
		self.OPERATION_TYPE := '';
		self.REFERENCE_ID   := '';
		self.DL_NUM         := trim(l.PTY_DRIVERS_LICENSE);
		self.DL_STATE       := trim(l.PTY_DRIVERS_LICENSE_ST); 
		self.LINK_ID               := l.did;
		//Commenting the following code since we cannot use any field coming from order table. 
		self.LOCATION_HOUSE_NBR    := '';//trim(l.HOUSE_NBR);
    self.LOCATION_STREET       := '';//trim(l.STREET);
    self.LOCATION_APT_NBR      := '';//trim(l.APT_NBR); 
    self.LOCATION_CROSS_STREET := '';//trim(l.CROSS_STREET); 
		
		//as per Julie's request. Get the city and state from incident
		self.LOCATION_CITY  := trim(l.inc_CITY);//trim(l.CITY); 
    self.LOCATION_STATE := trim(l.STATE_ABBR);//trim(l.STATE); 
    self.LOCATION_ZIP5  := '';//trim(l.ZIP5); 
    self.LOCATION_ZIP4  := '';//trim(l.ZIP4); 
    self.LOCATION_COUNTY:= '';//trim(l.COUNTY); 
		self.TAG            := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,l.tag,''); 
    self.TAG_STATE      := if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,l.tag_state,'');
		
		//Commenting the following code since we cannot use any field coming from order table. 
		//Loss date and time sometimes have value from order table. 
		self.FIRST_NAME_2   := '';//If(l.FIRST_NAME_2  ='', r.FIRST_NAME_2 ,l.FIRST_NAME_2 );
    self.MIDDLE_NAME_2  := '';//If(l.MIDDLE_NAME_2  ='', r.MIDDLE_NAME_2 ,l.MIDDLE_NAME_2 );
    self.LAST_NAME_2    := '';//If(l.LAST_NAME_2  ='', r.LAST_NAME_2 ,l.LAST_NAME_2 );
    self.FIRST_NAME_3   := '';//If(l.FIRST_NAME_3  ='', r.FIRST_NAME_3 ,l.FIRST_NAME_3 );
    self.MIDDLE_NAME_3  := '';//If(l.MIDDLE_NAME_3  ='', r.MIDDLE_NAME_3 ,l.MIDDLE_NAME_3 );
    self.LAST_NAME_3    := '';//If(l.LAST_NAME_3  ='', r.LAST_NAME_3 ,l.LAST_NAME_3 );
		self.LOSS_DATE      := l.loss_date;
    self.LOSS_TIME      := l.loss_time; 
		self.party_type     := l.party_type;
		self.business_name  := l.business_name;
		self.did_score      := l.did_score; 
		self.process_date   := v_process_date;
		self.cell_phone_area_code := '';
		self.cell_phone_number := '';
		self.work_phone_area_code := '';
		self.work_phone_number := '';
		self.home_phone_area_code := '';
		self.home_phone_number := '';
		self.VIN1    := '';
    self.MAKE1   := ''; 
    self.MODEL1  := ''; 
    self.YEAR1   := ''; 
    self.COLOR1  := '';
		self.VIN2    := '';
    self.MAKE2   := ''; 
    self.MODEL2  := ''; 
    self.YEAR2   := '';
    self.COLOR2  := '';
    self.VIN3    := '';
    self.MAKE3   := ''; 
    self.MODEL3  := ''; 
    self.YEAR3   := '';
    self.COLOR3  := '';
		//self := l;
		//self := [];
		end;
		
Promon_accidents := project(ds_Accidents(party_type <> '' and lname <> '' and fname <> '') ,	changelayout(left));

Promon_accidents DeNormVehicle(Promon_accidents L, accident_slim_sorted R, INTEGER C) := TRANSFORM

	  self.VIN1    := IF(C=1, trim(R.vehvin,LEFT,RIGHT),l.vin1);
    self.MAKE1   := IF(C=1, trim(R.vehmake,LEFT,RIGHT),l.make1); 
    self.MODEL1  := IF(C=1, trim(R.vehmodel,LEFT,RIGHT),l.model1); 
    self.YEAR1   := IF(C=1, trim(R.vehyear,LEFT,RIGHT),l.year1); 
    self.COLOR1  := IF(C=1, trim(R.color,LEFT,RIGHT),l.color1);
    self.VIN2    := IF(C=2, trim(R.vehvin,LEFT,RIGHT),l.vin2);
    self.MAKE2   := IF(C=2, trim(R.vehmake,LEFT,RIGHT),l.make2); 
    self.MODEL2  := IF(C=2, trim(R.vehmodel,LEFT,RIGHT),l.model2); 
    self.YEAR2   := IF(C=2, trim(R.vehyear,LEFT,RIGHT),l.year2);
    self.COLOR2  := IF(C=2, trim(R.color,LEFT,RIGHT),l.color2);
    self.VIN3    := IF(C=3, trim(R.vehvin,LEFT,RIGHT),l.vin3);
    self.MAKE3   := IF(C=3, trim(R.vehmake,LEFT,RIGHT),l.make3); 
    self.MODEL3  := IF(C=3, trim(R.vehmodel,LEFT,RIGHT),l.model3); 
    self.YEAR3   := IF(C=3, trim(R.vehyear,LEFT,RIGHT),l.year2);
    self.COLOR3  := IF(C=3, trim(R.color,LEFT,RIGHT),l.color3);
	  SELF := L;
end;
	 
Promon_accidents_with_veh:=   DENORMALIZE(Promon_accidents,accident_slim_sorted(vehvin+vehmodel+vehyear+vehmake+color <>''),
                                 LEFT.external_id = RIGHT.ORDER_ID+right.SEQUENCE_NBR,
  									             DeNormVehicle(LEFT,RIGHT,COUNTER) );

accidents_did_ntgood:= Promon_accidents_with_veh(did_score <= 75);      
d_accidents_did_good:= distribute(Promon_accidents_with_veh(did_score > 75 ) ,HASH((INTEGER)link_id)); 

Temp_rec Append_dob_ssn (d_accidents_did_good l	,recordof(Filebest) r) :=
		transform

		self.DOB_MONTH      := MAP(length(trim(l.DOB_MONTH)+trim(l.DOB_DAY)+ trim(l.DOB_YEAR)) = 8  =>l.DOB_MONTH ,
		                           length((string) r.dob) = 8 => (string) r.dob[5..6],
															 l.DOB_MONTH);
    self.DOB_DAY        := MAP(length(trim(l.DOB_MONTH)+trim(l.DOB_DAY)+ trim(l.DOB_YEAR)) = 8 =>l.DOB_DAY,
		                           length((string) r.dob) = 8 => (string) r.dob[7..8] ,
															 l.DOB_DAY);
		self.DOB_YEAR       := MAP(length(trim(l.DOB_MONTH)+trim(l.DOB_DAY)+ trim(l.DOB_YEAR))= 8  =>l.DOB_YEAR,
		                           length((string) r.dob) = 8 => (string) r.dob[1..4],
															 l.DOB_YEAR);
    self.ssn            := r.ssn;//If(l.ssn ='', r.ssn,l.ssn); 
		self := l;
		end;		
Accidents_ds := join( d_accidents_did_good	,Filebest
											,(unsigned6)left.link_id= right.did
											,Append_dob_ssn(left,right)
											,left outer
											,local) ;
											
  
 ut.MAC_SF_BuildProcess(Accidents_ds(ssn <> '' or dob_month+dob_day+dob_year <> '')+
                        accidents_did_ntgood(ssn <> '' or dob_month+dob_day+dob_year <> ''),'~thor_Data400::out::Promonitor::Accidents',OutAccidents,2);
 
 old_Accidents_ds  := distribute(dataset('~thor_Data400::out::Promonitor::Accidents_father', Temp_rec, thor),HASH(LAST_NAME,FIRST_NAME,MIDDLE_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR)) ; 
 new_Accidents_ds  := distribute(dataset('~thor_Data400::out::Promonitor::Accidents'       , Temp_rec, thor),HASH(LAST_NAME,FIRST_NAME,MIDDLE_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR)) ; 
 comb_Accidents_ds := If (nothor(FileServices.GetSuperFileSubCount('~thor_Data400::out::Promonitor::Accidents_father')) <> 0, 
                           Sort(new_Accidents_ds+old_Accidents_ds,LAST_NAME,FIRST_NAME,MIDDLE_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,
														 STREET_1,STREET_2,CITY,STATE,POSTAL_CODE,COUNTRY,
														 ACCOUNT_ID,USERNAME,OPERATION_TYPE,REFERENCE_ID,DL_NUM,DL_STATE,
														 CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,
														 //LINK_ID,
														 LOSS_DATE,
														 //LOSS_TIME,
														 LOCATION_HOUSE_NBR,LOCATION_STREET,LOCATION_APT_NBR,LOCATION_CROSS_STREET,LOCATION_CITY,LOCATION_STATE,LOCATION_ZIP5,LOCATION_ZIP4,LOCATION_COUNTY,
                             TAG,TAG_STATE,VIN1,MAKE1,MODEL1,YEAR1,COLOR1,VIN2,MAKE2,MODEL2,YEAR2,COLOR2,VIN3,MAKE3,MODEL3,YEAR3,COLOR3,
														 PARTY_TYPE,FIRST_NAME_2,MIDDLE_NAME_2,LAST_NAME_2,FIRST_NAME_3,MIDDLE_NAME_3,LAST_NAME_3,BUSINESS_NAME,process_date,local),
														 
													 Sort(new_Accidents_ds,LAST_NAME,FIRST_NAME,MIDDLE_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,
														 STREET_1,STREET_2,CITY,STATE,POSTAL_CODE,COUNTRY,
														 ACCOUNT_ID,USERNAME,OPERATION_TYPE,REFERENCE_ID,DL_NUM,DL_STATE,
														 CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,
														 //LINK_ID,
														 LOSS_DATE,//LOSS_TIME,
														 LOCATION_HOUSE_NBR,LOCATION_STREET,LOCATION_APT_NBR,LOCATION_CROSS_STREET,LOCATION_CITY,LOCATION_STATE,LOCATION_ZIP5,LOCATION_ZIP4,LOCATION_COUNTY,
                             TAG,TAG_STATE,VIN1,MAKE1,MODEL1,YEAR1,COLOR1,VIN2,MAKE2,MODEL2,YEAR2,COLOR2,VIN3,MAKE3,MODEL3,YEAR3,COLOR3,
														 PARTY_TYPE,FIRST_NAME_2,MIDDLE_NAME_2,LAST_NAME_2,FIRST_NAME_3,MIDDLE_NAME_3,LAST_NAME_3,BUSINESS_NAME,process_date,local)
													);
 dedup_set         := dedup(comb_Accidents_ds,LAST_NAME,FIRST_NAME,MIDDLE_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,
														 STREET_1,STREET_2,CITY,STATE,POSTAL_CODE,COUNTRY,
														 ACCOUNT_ID,USERNAME,OPERATION_TYPE,REFERENCE_ID,DL_NUM,DL_STATE,
														 CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,
														 //LINK_ID,
														 LOSS_DATE,
														 //LOSS_TIME,
														 LOCATION_HOUSE_NBR,LOCATION_STREET,LOCATION_APT_NBR,LOCATION_CROSS_STREET,LOCATION_CITY,LOCATION_STATE,LOCATION_ZIP5,LOCATION_ZIP4,LOCATION_COUNTY,
                             TAG,TAG_STATE,VIN1,MAKE1,MODEL1,YEAR1,COLOR1,VIN2,MAKE2,MODEL2,YEAR2,COLOR2,VIN3,MAKE3,MODEL3,YEAR3,COLOR3,
														 PARTY_TYPE,FIRST_NAME_2,MIDDLE_NAME_2,LAST_NAME_2,FIRST_NAME_3,MIDDLE_NAME_3,LAST_NAME_3,BUSINESS_NAME
													   ,left,local);
out_changedrecords := dedup_set(process_date = v_process_date);

out_changedrecords rollrecords (out_changedrecords l	,out_changedrecords r) :=		transform
 self.DL_NUM                := If(l.DL_NUM  ='', r.DL_NUM ,l.DL_NUM ); 
 self.DL_STATE              := If(l.DL_STATE  ='', r.DL_STATE ,l.DL_STATE );
 self.LOSS_DATE             := If(l.LOSS_DATE   ='', r.LOSS_DATE  ,l.LOSS_DATE  );
 self.LOSS_TIME             := If(l.LOSS_TIME  ='', r.LOSS_TIME ,l.LOSS_TIME );
 self.LOCATION_HOUSE_NBR    := If(l.LOCATION_HOUSE_NBR  ='', r.LOCATION_HOUSE_NBR ,l.LOCATION_HOUSE_NBR );
 self.LOCATION_STREET       := If(l.LOCATION_STREET  ='', r.LOCATION_STREET ,l.LOCATION_STREET );
 self.LOCATION_APT_NBR      := If(l.LOCATION_APT_NBR  ='', r.LOCATION_APT_NBR ,l.LOCATION_APT_NBR );
 self.LOCATION_CROSS_STREET := If(l.LOCATION_CROSS_STREET  ='', r.LOCATION_CROSS_STREET ,l.LOCATION_CROSS_STREET );
 self.LOCATION_CITY         := If(l.LOCATION_CITY  ='', r.LOCATION_CITY ,l.LOCATION_CITY );
 self.LOCATION_STATE        := If(l.LOCATION_STATE  ='', r.LOCATION_STATE ,l.LOCATION_STATE );
 self.LOCATION_ZIP5         := If(l.LOCATION_ZIP5  ='', r.LOCATION_ZIP5 ,l.LOCATION_ZIP5 );
 self.LOCATION_ZIP4         := If(l.LOCATION_ZIP4  ='', r.LOCATION_ZIP4 ,l.LOCATION_ZIP4 );
 self.LOCATION_COUNTY       := If(l.LOCATION_COUNTY  ='', r.LOCATION_COUNTY ,l.LOCATION_COUNTY );
 self.TAG    							  := If(l.TAG   ='', r.TAG  ,l.TAG  );
 self.TAG_STATE             := If(l.TAG_STATE  ='', r.TAG_STATE ,l.TAG_STATE );
 self.VIN1                  := If(l.VIN1   ='', r.VIN1  ,l.VIN1  );
 self.MAKE1                 := If(l.MAKE1  ='', r.MAKE1 ,l.MAKE1 );
 self.MODEL1                := If(l.MODEL1  ='', r.MODEL1 ,l.MODEL1 );
 self.YEAR1                 := If(l.YEAR1  ='', r.YEAR1 ,l.YEAR1 );
 self.COLOR1    						:= If(l.COLOR1  ='', r.COLOR1 ,l.COLOR1 );
 self.VIN2    							:= If(l.VIN2  ='', r.VIN2 ,l.VIN2 );
 self.MAKE2    							:= If(l.MAKE2  ='', r.MAKE2 ,l.MAKE2 );
 self.MODEL2    						:= If(l.MODEL2  ='', r.MODEL2 ,l.MODEL2 );
 self.YEAR2    							:= If(l.YEAR2  ='', r.YEAR2 ,l.YEAR2 );
 self.COLOR2    						:= If(l.COLOR2  ='', r.COLOR2 ,l.COLOR2 );
 self.VIN3    							:= If(l.VIN3  ='', r.VIN3 ,l.VIN3 );
 self.MAKE3    							:= If(l.MAKE3  ='', r.MAKE3 ,l.MAKE3 );
 self.MODEL3    						:= If(l.MODEL3  ='', r.MODEL3 ,l.MODEL3 );
 self.YEAR3   							:= If(l.YEAR3  ='', r.YEAR3 ,l.YEAR3 );
 self.COLOR3    						:= If(l.COLOR3  ='', r.COLOR3 ,l.COLOR3 );
 self.PARTY_TYPE    				:= If(l.PARTY_TYPE  ='', r.PARTY_TYPE ,l.PARTY_TYPE );
 self.FIRST_NAME_2    			:= '';//If(l.FIRST_NAME_2  ='', r.FIRST_NAME_2 ,l.FIRST_NAME_2 );
 self.MIDDLE_NAME_2    			:= '';//If(l.MIDDLE_NAME_2  ='', r.MIDDLE_NAME_2 ,l.MIDDLE_NAME_2 );
 self.LAST_NAME_2    				:= '';//If(l.LAST_NAME_2  ='', r.LAST_NAME_2 ,l.LAST_NAME_2 );
 self.FIRST_NAME_3    			:= '';//If(l.FIRST_NAME_3  ='', r.FIRST_NAME_3 ,l.FIRST_NAME_3 );
 self.MIDDLE_NAME_3    			:= '';//If(l.MIDDLE_NAME_3  ='', r.MIDDLE_NAME_3 ,l.MIDDLE_NAME_3 );
 self.LAST_NAME_3    				:= '';//If(l.LAST_NAME_3  ='', r.LAST_NAME_3 ,l.LAST_NAME_3 );
 self.BUSINESS_NAME    			:= If(l.BUSINESS_NAME  ='', r.BUSINESS_NAME ,l.BUSINESS_NAME );
 self := l;
end;	

rolled_records := rollup(out_changedrecords(LIB_Date.DaysApart( ut.GetDate ,loss_date[7..10]+loss_date[1..2]+loss_date[4..5] )< 31),
                         left.EXTERNAL_ID = right.EXTERNAL_ID and 
												 left.ssn         = right.ssn and
												 left.DOB_MONTH   = right.DOB_MONTH and 
												 left.DOB_DAY     = right.DOB_DAY and 
												 left.DOB_YEAR    = right.DOB_YEAR and 
												 left.FIRST_NAME  = right.FIRST_NAME and 
												 left.MIDDLE_NAME = right.MIDDLE_NAME  and 
												 left.LAST_NAME   = right.LAST_NAME and 
                         left.LINK_ID     = right.LINK_ID and 
												 (LEFT.DL_NUM = RIGHT.DL_NUM       or LEFT.DL_NUM= ''    or right. DL_NUM='' ) AND 
												 (LEFT.DL_STATE= RIGHT.DL_STATE    or LEFT.DL_STATE= ''  or right. DL_STATE='' ) AND
												 (LEFT.LOSS_DATE= RIGHT.LOSS_DATE  or LEFT.LOSS_DATE= '' or right.LOSS_DATE='' ) AND
												 (LEFT.LOSS_TIME= RIGHT.LOSS_TIME  or LEFT.LOSS_TIME= '' or right. LOSS_TIME ='' ) AND
												 (LEFT.LOCATION_HOUSE_NBR= RIGHT.LOCATION_HOUSE_NBR      or LEFT.LOCATION_HOUSE_NBR= '' or right. LOCATION_HOUSE_NBR ='' ) AND
												 (LEFT.LOCATION_STREET= RIGHT.LOCATION_STREET            or LEFT.LOCATION_STREET= ''    or right. LOCATION_STREET ='' ) AND
												 (LEFT.LOCATION_APT_NBR= RIGHT.LOCATION_APT_NBR          or LEFT.LOCATION_APT_NBR= ''   or right. LOCATION_APT_NBR ='' ) AND
												 (LEFT.LOCATION_CROSS_STREET=RIGHT.LOCATION_CROSS_STREET or LEFT.LOCATION_CROSS_STREET= ''  or right. LOCATION_CROSS_STREET ='' ) AND
												 (LEFT.LOCATION_CITY= RIGHT.LOCATION_CITY      or LEFT.LOCATION_CITY= ''   or right. LOCATION_CITY ='' ) AND
												 (LEFT.LOCATION_STATE= RIGHT.LOCATION_STATE    or LEFT.LOCATION_STATE= ''  or right. LOCATION_STATE ='' ) AND
												 (LEFT.LOCATION_ZIP5= RIGHT.LOCATION_ZIP5      or LEFT.LOCATION_ZIP5= ''   or right. LOCATION_ZIP5 ='' ) AND 
												 (LEFT.LOCATION_ZIP4= RIGHT.LOCATION_ZIP4      or LEFT.LOCATION_ZIP4= ''   or right. LOCATION_ZIP4 ='' ) AND 
												 (LEFT.LOCATION_COUNTY= RIGHT.LOCATION_COUNTY  or LEFT.LOCATION_COUNTY= '' or right. LOCATION_COUNTY='' ) AND 
												 (LEFT.TAG= RIGHT.TAG              or LEFT.TAG= ''        or right.tag='' ) AND 
												 (LEFT.TAG_STATE= RIGHT.TAG_STATE  or LEFT.TAG_STATE= ''  or right.tag_state ='' ) AND 
												 (LEFT.VIN1= RIGHT.VIN1    or LEFT.VIN1= ''     or right.vin1 ='' ) AND   
												 (LEFT.MAKE1= RIGHT.MAKE1  or LEFT.MAKE1= ''    or right.make1='' ) AND 
												 (LEFT.MODEL1= RIGHT.MODEL1  or LEFT.MODEL1= '' or right.model1='' ) AND  
												 (LEFT.YEAR1= RIGHT.YEAR1    or LEFT. YEAR1= '' or right.year1='' ) AND 
												 (LEFT.COLOR1= RIGHT.COLOR1  or LEFT.COLOR1= '' or right.color1='' ) AND 
												 (LEFT.VIN2= RIGHT.VIN2      or LEFT.VIN2= ''  or right.vin2='' ) AND  
												 (LEFT.MAKE2= RIGHT.MAKE2    or LEFT.MAKE2= ''  or right.make2='' ) AND 
												 (LEFT.MODEL2= RIGHT.MODEL2  or LEFT.MODEL2= '' or right.model2='' ) AND 
												 (LEFT.YEAR2= RIGHT.YEAR2    or LEFT.YEAR2= ''  or right.year2='' ) AND  
												 (LEFT.COLOR2= RIGHT.COLOR2  or LEFT.COLOR2= '' or right.color2='' ) AND 
												 (LEFT.VIN3= RIGHT.VIN3      or LEFT.VIN3= ''   or right.vin3='' ) AND  
												 (LEFT.MAKE3= RIGHT.MAKE3    or LEFT.MAKE3= ''  or right.make3='' ) AND  
												 (LEFT.MODEL3= RIGHT.MODEL3  or LEFT.MODEL3= '' or right.model3='' ) AND  
												 (LEFT.YEAR3= RIGHT.YEAR3    or LEFT.YEAR3= ''  or right.year3='' ) AND  
												 (LEFT.COLOR3= RIGHT.COLOR3  or LEFT.COLOR3= '' or right.color3='' ) AND 
												 (LEFT.PARTY_TYPE= RIGHT.PARTY_TYPE       or LEFT.PARTY_TYPE= ''    or right.party_type='' ) AND 
												 (LEFT.FIRST_NAME_2= RIGHT.FIRST_NAME_2   or LEFT.FIRST_NAME_2= ''  or right.first_name_2='' ) AND  
												 (LEFT.MIDDLE_NAME_2= RIGHT.MIDDLE_NAME_2 or LEFT.MIDDLE_NAME_2= '' or right.middle_name_2='' ) AND 
												 (LEFT.LAST_NAME_2= RIGHT.LAST_NAME_2     or LEFT.LAST_NAME_2= ''   or right.last_name_2='' ) AND  
												 (LEFT.FIRST_NAME_3= RIGHT.FIRST_NAME_3   or LEFT.FIRST_NAME_3= ''  or right.first_name_3='' ) AND  
												 (LEFT.MIDDLE_NAME_3= RIGHT.MIDDLE_NAME_3 or LEFT.MIDDLE_NAME_3= '' or right.middle_name_3='' ) AND  
												 (LEFT.LAST_NAME_3= RIGHT. LAST_NAME_3    or LEFT.LAST_NAME_3= ''   or right.last_name_3='' ) AND   
												 (LEFT.BUSINESS_NAME= RIGHT.BUSINESS_NAME or LEFT.BUSINESS_NAME= '' or right.business_name=''),
                         rollrecords(left,right));

 

output_Accidents   := output(rolled_records,
                            {EXTERNAL_ID,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,FIRST_NAME,MIDDLE_NAME,LAST_NAME,
														 STREET_1,STREET_2,STREET_3,CITY,STATE,POSTAL_CODE,COUNTRY,
														 ACCOUNT_ID,USERNAME,OPERATION_TYPE,REFERENCE_ID,DL_NUM,DL_STATE,
														 CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,
														 LINK_ID,LOSS_DATE,LOSS_TIME,
														 LOCATION_HOUSE_NBR,LOCATION_STREET,LOCATION_APT_NBR,LOCATION_CROSS_STREET,LOCATION_CITY,LOCATION_STATE,LOCATION_ZIP5,LOCATION_ZIP4,LOCATION_COUNTY,
                             TAG,TAG_STATE,VIN1,MAKE1,MODEL1,YEAR1,COLOR1,VIN2,MAKE2,MODEL2,YEAR2,COLOR2,VIN3,MAKE3,MODEL3,YEAR3,COLOR3,
														 PARTY_TYPE,FIRST_NAME_2,MIDDLE_NAME_2,LAST_NAME_2,FIRST_NAME_3,MIDDLE_NAME_3,LAST_NAME_3,BUSINESS_NAME},
                             '~thor_Data400::out::promonitor::AccidentsExtract_'+v_process_date,csv(
                             HEADING('EXTERNAL_ID|SSN|DOB_MONTH|DOB_DAY|DOB_YEAR|FIRST_NAME|MIDDLE_NAME|LAST_NAME|STREET_1|STREET_2|STREET_3|CITY|STATE|POSTAL_CODE|COUNTRY|ACCOUNT_ID|USERNAME|OPERATION_TYPE|REFERENCE_ID|DL_NUM|DL_STATE|CELL_PHONE_AREA_CODE|CELL_PHONE_NUMBER|WORK_PHONE_AREA_CODE|WORK_PHONE_NUMBER|HOME_PHONE_AREA_CODE|HOME_PHONE_NUMBER|LINK_ID|LOSS_DATE|LOSS_TIME|LOCATION_HOUSE_NBR|LOCATION_STREET|LOCATION_APT_NBR|LOCATION_CROSS_STREET|LOCATION_CITY|LOCATION_STATE_ABBR|LOCATION_ZIP5|LOCATION_ZIP4|LOCATION_COUNTY|TAG|TAG_STATE|VIN1|MAKE1|MODEL1|YEAR1|COLOR1|VIN2|MAKE2|MODEL2|YEAR2|COLOR2|VIN3|MAKE3|MODEL3|YEAR3|COLOR3|PARTY_TYPE|FIRST_NAME_2|MIDDLE_NAME_2|LAST_NAME_2|FIRST_NAME_3|MIDDLE_NAME_3|LAST_NAME_3|BUSINESS_NAME\n','',SINGLE)
                             ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);
														 
 Accidents_d := fileservices.despray('~thor_Data400::out::promonitor::AccidentsExtract_'+v_process_date, DestinationIP, '/data/hds_180/pro_monitor/build/accidents/'+'accidents_'+v_process_date+'.txt',,,,TRUE); 
//data/hds_180/pro_monitor/build/Accident/'
//output(phonesplus_ds(Link_id = 23686));
export Proc_build_Promonitor_Accident_extract :=  sequential(OutAccidents,
                                                             output_Accidents,Accidents_d
																														 );