// getSingleResidentProperitiesWithHedonicData.ecl
import doxie, LN_PropertyV2, property, ut, Risk_Indicators, advo, address, address_attributes, PropertyFieldFillInByLA2,PropertyCharacteristics;
// #option ('singlePersistInstances', true)
/*
   EXAMPLE USAGE:
   
   SomeStates_ADVO_BASE_with_AverageHedonics:=getSingleResidentProperitiesWithAverageHedonics(SomeStates);
*/
EXPORT PropertyFieldFillInByLA2.layouts.layout_BaseWithAverageHedonics 
   getSingleResidentProperitiesWithHedonicData( 
                     set of string SomeStates=[]
                     ,string PersistFilename
                     ,dataset(Advo.Layouts.Layout_Common_Out) in_advo_base=advo.files(,false).file_cleaned_base
										 ,dataset(PropertyCharacteristics.Layouts.Base) File_PropInfo_Addresses=PropertyFieldFillInByLA2.file_Property_in
   ) := FUNCTION


ADVO_BASE := 
   dedup(
         sort(
              distribute(
                         in_advo_base(Address_Type = '1', Residential_or_Business_Ind = 'A', geo_blk<>'')
                         ,hash64(cleanaid)
              )
              ,cleanaid,-date_last_seen // if there are more than 1 record with a given cleanaid, this sort puts the lastest at the top.
              ,local
         )
         ,cleanaid
         ,local
   );

STATE_ADVO_BASE := IF(SomeStates=[],ADVO_BASE,ADVO_BASE( st IN SomeStates ));


//Single Family Residence Land Use Codes
set_single_family := ['SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];


// File_PropInfo_Best := File_PropInfo_Addresses(vendor_source = 'B', st IN SomeStates,land_use_code in set_single_family);
File_PropInfo_Best := File_PropInfo_Addresses(vendor_source = 'B', land_use_code in set_single_family);

//Convert Codes
Convert_File_PropInfo := PropertyFieldFillInByLA2.map_property_codes(File_PropInfo_Best);
 

layout_output := PropertyFieldFillInByLA2.layouts.layout_BaseWithAverageHedonics;

layout_output addHedonic(STATE_ADVO_BASE l, Convert_File_PropInfo r) := TRANSFORM
  self.geolink 						:= l.st + l.county + l.geo_blk;
	// self.seqno							:= 0;
  self := l;
	self.standardized_land_use_code := r.land_use_code;
	self.property_type_code	:= r.property_type_code;
	
  vCurrentYear := (integer)ut.GetDate[1..4] + 1;
	self.BuildingAge 				:= if(r.year_built !='',vCurrentYear - (integer)r.year_built[1..4], 0);
	
  self.AssessedAmount 		:= (integer)r.total_assessed_value;
  self.BuildingArea 			:= (integer)r.building_square_footage;
  self.Stories						:= (integer)r.no_of_stories;
  self.Rooms 							:= (integer)r.no_of_rooms;
  self.Bedrooms 					:= (integer)r.no_of_bedrooms;
  self.Baths							:= (real)r.no_of_baths;

// New fields required	
	self.Fireplaces					:=	(integer)r.no_of_fireplaces;											
	self.Garage							:=	(integer)r.cnvrt_Garage;
	self.Construction_Type	:=	(integer)r.cnvrt_construction_type;
	self.Exterior_Walls			:=	(integer)r.cnvrt_exterior_wall;
	self.Foundation					:=	(integer)r.cnvrt_foundation;
	self.Roof_Cover					:=	(integer)r.cnvrt_roof_cover;
	self.Heating						:=	(integer)r.cnvrt_heating;
	self.Fuel_Type					:=	(integer)r.cnvrt_fuel_type;
	self.Air_Conditioning_Type	:=	(integer)r.cnvrt_air_conditioning_type;
	
	self.Basement						:=	(integer)r.cnvrt_basement_finish;
	self.Floor_Cover				:=	(integer)r.cnvrt_floor_type;
	self.garage_sqft 				:= 	(integer)r.garage_square_footage;
	self.basement_sqft			:= 	(integer)r.basement_square_footage;	
	
// Future Phase
	self.Style							:=	(integer)r.cnvrt_style_type;
	self.Pool								:=	(integer)r.cnvrt_pool_type;
	self.Water							:=	(integer)r.cnvrt_water;
	self.Sewer							:=	(integer)r.cnvrt_sewer;
 	self :=[];
end;


STATE_ADVO_BASE_with_Hedonics := 
   dedup(
         sort(
              distribute(
                         join(
                              STATE_ADVO_BASE
                              ,Convert_File_PropInfo
                              , left.prim_range = right.prim_range
                                and left.prim_name = right.prim_name
                                and left.sec_range = right.sec_range
                                and left.zip = right.zip 
                                and left.addr_suffix = right.addr_suffix
                                and left.predir = right.predir 
                                and left.postdir = right.postdir
                                and left.prim_range !='' 
                                and left.prim_name !='' 
                                and left.zip !='' 
                              ,addHedonic(left, right)
                              ,LEFT OUTER
                              ,KEEP(1)
                         )
                         ,hash64(geolink)
              )
              ,geolink,cleanaid
              ,local
         ) 
         ,geolink,cleanaid
         ,local
    ) 
    : persist(PersistFilename);  
		

output(STATE_ADVO_BASE_with_Hedonics,,'~thor_data400::out::propertyfieldfillinbyla2::getsingleresidentproperitieswithhedonicdata',overwrite);

return STATE_ADVO_BASE_with_Hedonics; 
END;