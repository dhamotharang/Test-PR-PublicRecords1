import CollateralAnalytics, PropertyCharacteristics,std,ut;

loadfile:=CollateralAnalytics.file_CollaterialAnalytics_Base;
RemoveBlanks:=loadfile(	prim_range	!=	''	and
																prim_name		!=	''	and
																zip					!=	''
															);

ToBeMapped:=project(RemoveBlanks,transform(CollateralAnalytics.layouts.ToBeMappedPC,Self:=Left; Self:=[];));

FuzzyList:=CollateralAnalytics.file_FuzzyMatch(mls_ratio>75);

ReducedFuzzy:=project(FuzzyList,transform(CollateralAnalytics.layouts.ExceptionListLayout,self:=left;));

ExceptionList:=CollateralAnalytics.file_ExceptionList;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_AIR_CONDITIONING_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_AIR_CONDITIONING_TYPE_MATCHED:=if(L.MLS_AIR_CONDITIONING_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_AIR_CONDITIONING_TYPE_MATCHED);
    Self.MLS_AIR_CONDITIONING_TYPE_MATCHED_CODE:=if(L.MLS_AIR_CONDITIONING_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_AIR_CONDITIONING_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_CONSTRUCTION_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_CONSTRUCTION_TYPE_MATCHED:=if(L.MLS_CONSTRUCTION_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_CONSTRUCTION_TYPE_MATCHED);
    Self.MLS_CONSTRUCTION_TYPE_MATCHED_CODE:=if(L.MLS_CONSTRUCTION_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_CONSTRUCTION_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_FIREPLACE_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_FIREPLACE_TYPE_MATCHED:=if(L.MLS_FIREPLACE_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_FIREPLACE_TYPE_MATCHED);
    Self.MLS_FIREPLACE_TYPE_MATCHED_CODE:=if(L.MLS_FIREPLACE_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_FIREPLACE_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_FLOOR_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_FLOOR_TYPE_MATCHED:=if(L.MLS_FLOOR_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_FLOOR_TYPE_MATCHED);
    Self.MLS_FLOOR_TYPE_MATCHED_CODE:=if(L.MLS_FLOOR_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_FLOOR_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_FOUNDATION(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_FOUNDATION_MATCHED:=if(L.MLS_FOUNDATION_MATCHED='',R.FinalMatchedValue,L.MLS_FOUNDATION_MATCHED);
    Self.MLS_FOUNDATION_MATCHED_CODE:=if(L.MLS_FOUNDATION_MATCHED_CODE='',R.PC_MappedCode,L.MLS_FOUNDATION_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_GARAGE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_GARAGE_MATCHED:=if(L.MLS_GARAGE_MATCHED='',R.FinalMatchedValue,L.MLS_GARAGE_MATCHED);
    Self.MLS_GARAGE_MATCHED_CODE:=if(L.MLS_GARAGE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_GARAGE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_HEATING(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_HEATING_MATCHED:=if(L.MLS_HEATING_MATCHED='',R.FinalMatchedValue,L.MLS_HEATING_MATCHED);
    Self.MLS_HEATING_MATCHED_CODE:=if(L.MLS_HEATING_MATCHED_CODE='',R.PC_MappedCode,L.MLS_HEATING_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_PARKING_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_PARKING_TYPE_MATCHED:=if(L.MLS_PARKING_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_PARKING_TYPE_MATCHED);
    Self.MLS_PARKING_TYPE_MATCHED_CODE:=if(L.MLS_PARKING_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_PARKING_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_POOL_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_POOL_TYPE_MATCHED:=if(L.MLS_POOL_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_POOL_TYPE_MATCHED);
    Self.MLS_POOL_TYPE_MATCHED_CODE:=if(L.MLS_POOL_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_POOL_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_PROP_STYLE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_PROP_STYLE_MATCHED:=if(L.MLS_PROP_STYLE_MATCHED='',R.FinalMatchedValue,L.MLS_PROP_STYLE_MATCHED);
    Self.MLS_PROP_STYLE_MATCHED_CODE:=if(L.MLS_PROP_STYLE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_PROP_STYLE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_PROPERTY_CONDITION(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_PROPERTY_CONDITION_MATCHED:=if(L.MLS_PROPERTY_CONDITION_MATCHED='',R.FinalMatchedValue,L.MLS_PROPERTY_CONDITION_MATCHED);
    Self.MLS_PROPERTY_CONDITION_MATCHED_CODE:=if(L.MLS_PROPERTY_CONDITION_MATCHED_CODE='',R.PC_MappedCode,L.MLS_PROPERTY_CONDITION_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_PROPERTY_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_PROPERTY_TYPE_MATCHED:=if(L.MLS_PROPERTY_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_PROPERTY_TYPE_MATCHED);
    Self.MLS_PROPERTY_TYPE_MATCHED_CODE:=if(L.MLS_PROPERTY_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_PROPERTY_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_ROOF_COVER(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_ROOF_COVER_MATCHED:=if(L.MLS_ROOF_COVER_MATCHED='',R.FinalMatchedValue,L.MLS_ROOF_COVER_MATCHED);
    Self.MLS_ROOF_COVER_MATCHED_CODE:=if(L.MLS_ROOF_COVER_MATCHED_CODE='',R.PC_MappedCode,L.MLS_ROOF_COVER_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_ROOF_TYPE(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_ROOF_TYPE_MATCHED:=if(L.MLS_ROOF_TYPE_MATCHED='',R.FinalMatchedValue,L.MLS_ROOF_TYPE_MATCHED);
    Self.MLS_ROOF_TYPE_MATCHED_CODE:=if(L.MLS_ROOF_TYPE_MATCHED_CODE='',R.PC_MappedCode,L.MLS_ROOF_TYPE_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

CollateralAnalytics.layouts.ToBeMappedPC tMLS_SEWER(CollateralAnalytics.layouts.ToBeMappedPC L,CollateralAnalytics.layouts.ExceptionListLayout R):=transform
    Self.MLS_SEWER_MATCHED:=if(L.MLS_SEWER_MATCHED='',R.FinalMatchedValue,L.MLS_SEWER_MATCHED);
    Self.MLS_SEWER_MATCHED_CODE:=if(L.MLS_SEWER_MATCHED_CODE='',R.PC_MappedCode,L.MLS_SEWER_MATCHED_CODE);
    Self:=L;
    Self:=[];
END;

ExceptionMLS_AIR_CONDITIONING_TYPE:=if(exists(ExceptionList(FieldName='MLS_AIR_CONDITIONING_TYPE')),join(toBeMapped,
                                   ExceptionList(FieldName='MLS_AIR_CONDITIONING_TYPE'),
                                   std.str.touppercase(left.MLS_AIR_CONDITIONING_TYPE)=right.Raw_Value,
                                   tMLS_AIR_CONDITIONING_TYPE(left,right),lookup,left outer),toBeMapped);

ExceptionMLS_CONSTRUCTION_TYPE:=if(exists(ExceptionList(FieldName='MLS_CONSTRUCTION_TYPE')),join(ExceptionMLS_AIR_CONDITIONING_TYPE,
                                   ExceptionList(FieldName='MLS_CONSTRUCTION_TYPE'),
                                   std.str.touppercase(left.MLS_CONSTRUCTION_TYPE)=right.Raw_Value,
                                   tMLS_CONSTRUCTION_TYPE(left,right),lookup,left outer),ExceptionMLS_AIR_CONDITIONING_TYPE);

ExceptionMLS_FIREPLACE_TYPE:=if(exists(ExceptionList(FieldName='MLS_FIREPLACE_TYPE')),join(ExceptionMLS_CONSTRUCTION_TYPE,
                                   ExceptionList(FieldName='MLS_FIREPLACE_TYPE'),
                                   std.str.touppercase(left.MLS_FIREPLACE_TYPE)=right.Raw_Value,
                                   tMLS_FIREPLACE_TYPE(left,right),lookup,left outer),ExceptionMLS_CONSTRUCTION_TYPE);

ExceptionMLS_FLOOR_TYPE:=if(exists(ExceptionList(FieldName='MLS_FLOOR_TYPE')),join(ExceptionMLS_FIREPLACE_TYPE,
                                   ExceptionList(FieldName='MLS_FLOOR_TYPE'),
                                   std.str.touppercase(left.MLS_FLOOR_TYPE)=right.Raw_Value,
                                   tMLS_FLOOR_TYPE(left,right),lookup,left outer),ExceptionMLS_FIREPLACE_TYPE);

ExceptionMLS_FOUNDATION:=if(exists(ExceptionList(FieldName='MLS_FOUNDATION')),join(ExceptionMLS_FLOOR_TYPE,
                                   ExceptionList(FieldName='MLS_FOUNDATION'),
                                   std.str.touppercase(left.MLS_FOUNDATION)=right.Raw_Value,
                                   tMLS_FOUNDATION(left,right),lookup,left outer),ExceptionMLS_FLOOR_TYPE);

ExceptionMLS_GARAGE:=if(exists(ExceptionList(FieldName='MLS_GARAGE')),join(ExceptionMLS_FOUNDATION,
                                   ExceptionList(FieldName='MLS_GARAGE'),
                                   std.str.touppercase(left.MLS_GARAGE)=right.Raw_Value,
                                   tMLS_GARAGE(left,right),lookup,left outer),ExceptionMLS_FOUNDATION);

ExceptionMLS_HEATING:=if(exists(ExceptionList(FieldName='MLS_HEATING')),join(ExceptionMLS_GARAGE,
                                   ExceptionList(FieldName='MLS_HEATING'),
                                   std.str.touppercase(left.MLS_HEATING)=right.Raw_Value,
                                   tMLS_HEATING(left,right),lookup,left outer),ExceptionMLS_GARAGE);

ExceptionMLS_PARKING_TYPE:=if(exists(ExceptionList(FieldName='MLS_PARKING_TYPE')),join(ExceptionMLS_HEATING,
                                   ExceptionList(FieldName='MLS_PARKING_TYPE'),
                                   std.str.touppercase(left.MLS_PARKING_TYPE)=right.Raw_Value,
                                   tMLS_PARKING_TYPE(left,right),lookup,left outer),ExceptionMLS_HEATING);

ExceptionMLS_POOL_TYPE:=if(exists(ExceptionList(FieldName='MLS_POOL_TYPE')),join(ExceptionMLS_PARKING_TYPE,
                                   ExceptionList(FieldName='MLS_POOL_TYPE'),
                                   std.str.touppercase(left.MLS_POOL_TYPE)=right.Raw_Value,
                                   tMLS_POOL_TYPE(left,right),lookup,left outer),ExceptionMLS_PARKING_TYPE);

ExceptionMLS_PROP_STYLE:=if(exists(ExceptionList(FieldName='MLS_PROP_STYLE')),join(ExceptionMLS_POOL_TYPE,
                                   ExceptionList(FieldName='MLS_PROP_STYLE'),
                                   std.str.touppercase(left.MLS_PROP_STYLE)=right.Raw_Value,
                                   tMLS_PROP_STYLE(left,right),lookup,left outer),ExceptionMLS_POOL_TYPE);

ExceptionMLS_PROPERTY_CONDITION:=if(exists(ExceptionList(FieldName='MLS_PROPERTY_CONDITION')),join(ExceptionMLS_PROP_STYLE,
                                   ExceptionList(FieldName='MLS_PROPERTY_CONDITION'),
                                   std.str.touppercase(left.MLS_PROPERTY_CONDITION)=right.Raw_Value,
                                   tMLS_PROPERTY_CONDITION(left,right),lookup,left outer),ExceptionMLS_PROP_STYLE);

ExceptionMLS_PROPERTY_TYPE:=if(exists(ExceptionList(FieldName='MLS_PROPERTY_TYPE')),join(ExceptionMLS_PROPERTY_CONDITION,
                                   ExceptionList(FieldName='MLS_PROPERTY_TYPE'),
                                   std.str.touppercase(left.MLS_PROPERTY_TYPE)=right.Raw_Value,
                                   tMLS_PROPERTY_TYPE(left,right),lookup,left outer),ExceptionMLS_PROPERTY_CONDITION);

ExceptionMLS_ROOF_COVER:=if(exists(ExceptionList(FieldName='MLS_ROOF_COVER')),join(ExceptionMLS_PROPERTY_TYPE,
                                   ExceptionList(FieldName='MLS_ROOF_COVER'),
                                   std.str.touppercase(left.MLS_ROOF_COVER)=right.Raw_Value,
                                   tMLS_ROOF_COVER(left,right),lookup,left outer),ExceptionMLS_PROPERTY_TYPE);

ExceptionMLS_ROOF_TYPE:=if(exists(ExceptionList(FieldName='MLS_ROOF_TYPE')),join(ExceptionMLS_ROOF_COVER,
                                   ExceptionList(FieldName='MLS_ROOF_TYPE'),
                                   std.str.touppercase(left.MLS_ROOF_COVER)=right.Raw_Value,
                                   tMLS_ROOF_TYPE(left,right),lookup,left outer),ExceptionMLS_ROOF_COVER);

ExceptionMLS_SEWER:=if(exists(ExceptionList(FieldName='MLS_SEWER')),join(ExceptionMLS_ROOF_TYPE,
                                   ExceptionList(FieldName='MLS_SEWER'),
                                   std.str.touppercase(left.MLS_SEWER)=right.Raw_Value,
                                   tMLS_SEWER(left,right),lookup,left outer),ExceptionMLS_ROOF_TYPE);

AddMLS_AIR_CONDITIONING_TYPE:=join(ExceptionMLS_SEWER,
                                   ReducedFuzzy(FieldName='MLS_AIR_CONDITIONING_TYPE'),
                                   std.str.touppercase(left.MLS_AIR_CONDITIONING_TYPE)=right.Raw_Value,
                                   tMLS_AIR_CONDITIONING_TYPE(left,right),lookup,left outer);

AddMLS_CONSTRUCTION_TYPE:=join(AddMLS_AIR_CONDITIONING_TYPE,
                                   ReducedFuzzy(FieldName='MLS_CONSTRUCTION_TYPE'),
                                   std.str.touppercase(left.MLS_CONSTRUCTION_TYPE)=right.Raw_Value,
                                   tMLS_CONSTRUCTION_TYPE(left,right),lookup,left outer);

AddMLS_FIREPLACE_TYPE:=join(AddMLS_CONSTRUCTION_TYPE,
                                   ReducedFuzzy(FieldName='MLS_FIREPLACE_TYPE'),
                                   std.str.touppercase(left.MLS_FIREPLACE_TYPE)=right.Raw_Value,
                                   tMLS_FIREPLACE_TYPE(left,right),lookup,left outer);

AddMLS_FLOOR_TYPE:=join(AddMLS_FIREPLACE_TYPE,
                                   ReducedFuzzy(FieldName='MLS_FLOOR_TYPE'),
                                   std.str.touppercase(left.MLS_FLOOR_TYPE)=right.Raw_Value,
                                   tMLS_FLOOR_TYPE(left,right),lookup,left outer);

AddMLS_FOUNDATION:=join(AddMLS_FLOOR_TYPE,
                                   ReducedFuzzy(FieldName='MLS_FOUNDATION'),
                                   std.str.touppercase(left.MLS_FOUNDATION)=right.Raw_Value,
                                   tMLS_FOUNDATION(left,right),lookup,left outer);

AddMLS_GARAGE:=join(AddMLS_FOUNDATION,
                                   ReducedFuzzy(FieldName='MLS_GARAGE'),
                                   std.str.touppercase(left.MLS_GARAGE)=right.Raw_Value,
                                   tMLS_GARAGE(left,right),lookup,left outer);

AddMLS_HEATING:=join(AddMLS_GARAGE,
                                   ReducedFuzzy(FieldName='MLS_HEATING'),
                                   std.str.touppercase(left.MLS_HEATING)=right.Raw_Value,
                                   tMLS_HEATING(left,right),lookup,left outer);

AddMLS_PARKING_TYPE:=join(AddMLS_HEATING,
                                   ReducedFuzzy(FieldName='MLS_PARKING_TYPE'),
                                   std.str.touppercase(left.MLS_PARKING_TYPE)=right.Raw_Value,
                                   tMLS_PARKING_TYPE(left,right),lookup,left outer);

AddMLS_POOL_TYPE:=join(AddMLS_PARKING_TYPE,
                                   ReducedFuzzy(FieldName='MLS_POOL_TYPE'),
                                   std.str.touppercase(left.MLS_POOL_TYPE)=right.Raw_Value,
                                   tMLS_POOL_TYPE(left,right),lookup,left outer);

AddMLS_PROP_STYLE:=join(AddMLS_POOL_TYPE,
                                   ReducedFuzzy(FieldName='MLS_PROP_STYLE'),
                                   std.str.touppercase(left.MLS_PROP_STYLE)=right.Raw_Value,
                                   tMLS_PROP_STYLE(left,right),lookup,left outer);

AddMLS_PROPERTY_CONDITION:=join(AddMLS_PROP_STYLE,
                                   ReducedFuzzy(FieldName='MLS_PROPERTY_CONDITION'),
                                   std.str.touppercase(left.MLS_PROPERTY_CONDITION)=right.Raw_Value,
                                   tMLS_PROPERTY_CONDITION(left,right),lookup,left outer);

AddMLS_PROPERTY_TYPE:=join(AddMLS_PROPERTY_CONDITION,
                                   ReducedFuzzy(FieldName='MLS_PROPERTY_TYPE'),
                                   std.str.touppercase(left.MLS_PROPERTY_TYPE)=right.Raw_Value,
                                   tMLS_PROPERTY_TYPE(left,right),lookup,left outer);

AddMLS_ROOF_COVER:=join(AddMLS_PROPERTY_TYPE,
                                   ReducedFuzzy(FieldName='MLS_ROOF_COVER'),
                                   std.str.touppercase(left.MLS_ROOF_COVER)=right.Raw_Value,
                                   tMLS_ROOF_COVER(left,right),lookup,left outer);

AddMLS_ROOF_TYPE:=join(AddMLS_ROOF_COVER,
                                   ReducedFuzzy(FieldName='MLS_ROOF_TYPE'),
                                   std.str.touppercase(left.MLS_ROOF_COVER)=right.Raw_Value,
                                   tMLS_ROOF_TYPE(left,right),lookup,left outer);

AddMLS_SEWER:=join(AddMLS_ROOF_TYPE,
                                   ReducedFuzzy(FieldName='MLS_SEWER'),
                                   std.str.touppercase(left.MLS_SEWER)=right.Raw_Value,
                                   tMLS_SEWER(left,right),lookup,left outer);
//output(AddMLS_SEWER(prim_range<>''));
//output(AddMLS_SEWER(date_vendor_first_reported<>''));
//output(choosen(AddMLS_SEWER,50));
ConvertToPC:=project(AddMLS_Sewer,transform(PropertyCharacteristics.Layouts.TempBase,
                        self.vendor_source:='E';
                        self.property_raw_aid:=left.RAWAID;
                        self.property_ace_aid:=left.ACEAID;
                        self.property_street_address:=left.MLS_GEO_FULL_ADDRESS;
                        self.property_city_state_zip:=left.MLS_GEO_CITY + ' '+ left.MLS_GEO_STATE + ' ' + left.MLS_GEO_ZIP_CODE;
                        self.dt_vendor_first_reported:=(unsigned4)left.date_vendor_first_reported;
		                self.dt_vendor_last_reported:=(unsigned4)left.date_vendor_last_reported;		
                        self.building_square_footage:=left.MLS_BUILDING_SQUARE_FOOTAGE;
                        self.tax_dt_building_square_footage:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_building_square_footage:='MLS';
                        Self.no_of_baths:=left.MLS_BATH_TOTAL;
                        self.tax_dt_no_of_baths:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_baths:='MLS';
                        self.no_of_full_baths:=left.MLS_BATHS_FULL;
                        self.tax_dt_no_of_full_baths:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_full_baths:='MLS';
                        self.no_of_half_baths:=left.MLS_BATHS_PARTIAL;
                        self.tax_dt_no_of_half_baths:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_half_baths:='MLS';
                        self.no_of_bedrooms:=left.MLS_BEDROOMS;
                        self.tax_dt_no_of_bedrooms:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_bedrooms:='MLS';
                        self.exterior_wall:=left.MLS_CONSTRUCTION_TYPE_MATCHED_CODE;
                        self.exterior_wall_desc:=left.MLS_CONSTRUCTION_TYPE_MATCHED;
                        self.tax_dt_exterior_wall:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_exterior_wall:='MLS';
                        self.fireplace_type:=left.MLS_FIREPLACE_TYPE_MATCHED_CODE;
                        self.fireplace_type_desc:=left.MLS_FIREPLACE_TYPE_MATCHED;
                        self.tax_dt_fireplace_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_fireplace_type:='MLS';
                        self.fireplace_ind:=if(trim(STD.STR.TOUPPERCASE(left.MLS_FIREPLACE_YN),left,right)='NONE','N',
                                            if(trim(STD.STR.TOUPPERCASE(left.MLS_FIREPLACE_YN),left,right)='YES','Y',left.MLS_FIREPLACE_YN));
                        self.tax_dt_fireplace_ind:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_fireplace_ind:='MLS';
                        self.floor_type:=left.MLS_FLOOR_TYPE_MATCHED_CODE;
                        self.floor_type_desc:=left.MLS_FLOOR_TYPE_MATCHED;
                        self.tax_dt_floor_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_floor_type:='MLS';
                        self.foundation:=left.MLS_FOUNDATION_MATCHED_CODE;
                        self.foundation_desc:=left.MLS_FOUNDATION_MATCHED;
                        self.tax_dt_foundation:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_foundation:='MLS';
                        self.garage:=left.MLS_GARAGE_MATCHED_CODE;
                        self.garage_desc:=left.MLS_GARAGE_MATCHED;
                        self.tax_dt_garage:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_garage:='MLS';
                        self.heating:=left.MLS_HEATING_MATCHED_CODE;
                        self.heating_desc:=left.MLS_HEATING_MATCHED;
                        self.tax_dt_heating:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_heating:='MLS';
                        self.air_conditioning_type:=left.MLS_AIR_CONDITIONING_TYPE_MATCHED_CODE;
                        self.air_conditioning_type_desc:=left.MLS_AIR_CONDITIONING_TYPE_MATCHED;
                        self.tax_dt_air_conditioning_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_air_conditioning_type:='MLS';
                        self.living_area_square_footage:=left.MLS_LIVING_AREA;
                        self.tax_dt_living_area_square_footage:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_living_area_square_footage:='MLS';
                        self.lot_size:=left.MLS_LOT_SIZE;
                        self.tax_dt_lot_size:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_lot_size:='MLS';
                        self.acres:=left.MLS_LOT_SIZE_ACRE;
                        self.tax_dt_acres:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_acres:='MLS';
                        self.no_of_stories:=left.MLS_NBR_STORIES;
                        self.tax_dt_no_of_stories:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_stories:='MLS';
                        self.subdivision:=left.MLS_NEIGHBORHOOD;
                        self.tax_dt_subdivision:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_subdivision:='MLS';
                        self.no_of_fireplaces:=left.MLS_NUMBER_OF_FIREPLACES;
                        self.tax_dt_no_of_fireplaces:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_fireplaces:='MLS';
                        self.no_of_rooms:=left.MLS_NUMBER_OF_ROOMS;
                        self.tax_dt_no_of_rooms:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_rooms:='MLS';
                        self.no_of_units:=left.MLS_NUMBER_OF_UNITS;
                        self.tax_dt_no_of_units:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_no_of_units:='MLS';
                        self.parking_type:=left.MLS_PARKING_TYPE_MATCHED_CODE;
                        self.parking_type_desc:=left.MLS_PARKING_TYPE_MATCHED;
                        self.tax_dt_parking_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_parking_type:='MLS';
                        self.pool_type:=left.MLS_POOL_TYPE_MATCHED_CODE;
                        self.pool_type_desc:=left.MLS_POOL_TYPE_MATCHED;
                        self.tax_dt_pool_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_pool_type:='MLS';
                        self.pool_indicator:=if(trim(STD.STR.TOUPPERCASE(left.MLS_POOL_YN),left,right)='NONE','N',
                                            if(trim(STD.STR.TOUPPERCASE(left.MLS_POOL_YN),left,right)='YES','Y',left.MLS_POOL_YN));
                        self.tax_dt_pool_indicator:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_pool_indicator:='MLS';
                        self.style_type:=left.MLS_PROP_STYLE_MATCHED_CODE;
                        self.style_type_desc:=left.MLS_PROP_STYLE_MATCHED;
                        self.tax_dt_style_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_style_type:='MLS';
                        self.structure_quality:=left.MLS_PROPERTY_CONDITION_MATCHED_CODE;
                        self.structure_quality_desc:=left.MLS_PROPERTY_CONDITION_MATCHED;
                        self.tax_dt_structure_quality:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_structure_quality:='MLS';
                        self.property_type_code:=left.MLS_PROPERTY_TYPE_MATCHED_CODE;
                        self.property_type_desc:=left.MLS_PROPERTY_TYPE_MATCHED;
                        self.tax_dt_property_type_code:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_property_type_code:='MLS';
                        self.roof_cover:=left.MLS_ROOF_COVER_MATCHED_CODE;
                        self.roof_cover_desc:=left.MLS_ROOF_COVER_MATCHED;
                        self.tax_dt_roof_cover:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_roof_cover:='MLS';
                        self.roof_type:=left.MLS_ROOF_TYPE_MATCHED_CODE;
                        self.roof_type_desc:=left.MLS_ROOF_TYPE_MATCHED;
                        self.tax_dt_roof_type:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_roof_type:='MLS';
                        self.sewer:=left.MLS_SEWER_MATCHED_CODE;
                        self.sewer_desc:=left.MLS_SEWER_MATCHED;
                        self.tax_dt_sewer:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_sewer:='MLS';
                        self.sale_date:=STD.STR.FilterOut(left.MLS_SOLD_DATE,'-');
                        self.src_sale_date:='MLS';
                        self.sale_amount:=left.MLS_SOLD_PRICE;
                        self.src_sale_amount:='MLS';
                        self.tax_amount:=left.MLS_TAX_AMOUNT;
                        self.tax_dt_tax_amount:=if(left.MLS_TAX_YEAR='','',left.MLS_TAX_YEAR+'0000');
                        self.src_tax_amount:='MLS';
                        self.assessed_year:=left.MLS_TAX_YEAR;
                        self.year_built:=left.MLS_YEAR_BUILT;
                        self:=left;
                        self:=[];
                        ));

PropertyCharacteristics.Layouts.TempBase tFilterInvalid(PropertyCharacteristics.Layouts.TempBase L):=TRANSFORM
		AdjustedArchiveDate:=Std.Date.AdjustCalendar(L.dt_vendor_last_reported,0,0,1);
        self.air_conditioning_type:=if(STD.STR.TOUPPERCASE(L.air_conditioning_type ) in ['UNK','YES','NON','PKG','OTH','PKR','PRT'],'',STD.STR.TOUPPERCASE(L.air_conditioning_type));
        self.air_conditioning_type_desc:=if(STD.STR.TOUPPERCASE(L.air_conditioning_type_desc ) in ['TYPE UNKNOWN','YES','NONE','PACKAGE','OTHER','PACKAGE ROOF','PARTIAL'],'',STD.STR.TOUPPERCASE(L.air_conditioning_type_desc));
        self.exterior_wall:=if(STD.STR.TOUPPERCASE(L.exterior_wall ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.exterior_wall));
        self.exterior_wall_desc:=if(STD.STR.TOUPPERCASE(L.exterior_wall_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.exterior_wall_desc));
        self.fireplace_type:=if(STD.STR.TOUPPERCASE(L.fireplace_type ) in ['UNK','0V0'],'',L.fireplace_type);
        self.fireplace_type_desc:=if(STD.STR.TOUPPERCASE(L.fireplace_type_desc ) in ['TYPE UNKNOWN','MASSIVE'],'',STD.STR.TOUPPERCASE(L.fireplace_type_desc));
		self.fireplace_ind:=if(self.fireplace_type_desc='','',if(STD.STR.TOUPPERCASE(self.fireplace_type_desc)='NONE','N','Y'));
        self.floor_type:=if(STD.STR.TOUPPERCASE(L.floor_type ) in ['UNK','OTH','COV'],'',STD.STR.TOUPPERCASE(L.floor_type));
        self.floor_type_desc:=if(STD.STR.TOUPPERCASE(L.floor_type_desc ) in ['TYPE UNKNOWN','OTHER','COVERED'],'',STD.STR.TOUPPERCASE(L.floor_type_desc));
        self.foundation:=if(STD.STR.TOUPPERCASE(L.foundation ) in ['UNK','OTH','STD'],'',STD.STR.TOUPPERCASE(L.foundation));
        self.foundation_desc:=if(STD.STR.TOUPPERCASE(L.foundation_desc ) in ['TYPE UNKNOWN','OTHER','STANDARD'],'',STD.STR.TOUPPERCASE(L.foundation_desc));
        self.garage:=if(STD.STR.TOUPPERCASE(L.garage ) in ['UD0','NON'],'',STD.STR.TOUPPERCASE(L.garage));
        self.garage_desc:=if(STD.STR.TOUPPERCASE(L.garage_desc ) in ['UNDEFINED TYPE','NONE'],'',STD.STR.TOUPPERCASE(L.garage_desc));
        self.heating:=if(STD.STR.TOUPPERCASE(L.heating ) in ['UNK','YES','NON','OTH'],'',L.heating);
        self.heating_desc:=if(STD.STR.TOUPPERCASE(L.heating_desc ) in ['TYPE UNKNOWN','YES','NONE','OTHER'],'',STD.STR.TOUPPERCASE(L.heating_desc));
        self.parking_type:=if(STD.STR.TOUPPERCASE(L.parking_type ) in ['UNK','UD0'],'',L.parking_type);
        self.parking_type_desc:=if(STD.STR.TOUPPERCASE(L.parking_type_desc ) in ['TYPE UNKNOWN','UNDEFINED TYPE'],'',STD.STR.TOUPPERCASE(L.parking_type_desc));
        self.pool_type:=if(STD.STR.TOUPPERCASE(L.pool_type ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.pool_type));
        self.pool_type_desc:=if(STD.STR.TOUPPERCASE(L.pool_type_desc ) in ['TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.pool_type_desc));
		self.pool_indicator:=if(self.pool_type_desc='','',if(STD.STR.TOUPPERCASE(self.pool_type_desc)='NONE','N','Y'));
        self.style_type:=if(STD.STR.TOUPPERCASE(L.style_type ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.style_type));
        self.style_type_desc:=if(STD.STR.TOUPPERCASE(L.style_type_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.style_type_desc));
        self.structure_quality:=if(STD.STR.TOUPPERCASE(L.structure_quality ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.structure_quality));
        self.structure_quality_desc:=if(STD.STR.TOUPPERCASE(L.structure_quality_desc ) in ['TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.structure_quality_desc));
        self.roof_cover:=if(STD.STR.TOUPPERCASE(L.roof_cover ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.roof_cover));
        self.roof_cover_desc:=if(STD.STR.TOUPPERCASE(L.roof_cover_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.roof_cover_desc));
        self.sewer:=if(STD.STR.TOUPPERCASE(L.sewer ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.sewer));
        self.sewer_desc:=if(STD.STR.TOUPPERCASE(L.sewer_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.sewer_desc));
        self.no_of_full_baths:=if((real)L.no_of_full_baths <1 or (real)L.no_of_full_baths >10,'',STD.STR.TOUPPERCASE(L.no_of_full_baths));
        self.no_of_half_baths:=if((real)L.no_of_half_baths <0 or (real)L.no_of_half_baths >5,'',STD.STR.TOUPPERCASE(L.no_of_half_baths));
        no_of_baths_round_one:=if(self.no_of_full_baths='' and self.no_of_half_baths='',L.no_of_baths,(string)((real)self.no_of_full_baths + (0.5*((real)self.no_of_half_baths))));
		self.no_of_baths:=if((real)no_of_baths_round_one<1 or (real)no_of_baths_round_one >10,'',no_of_baths_round_one);
        self.no_of_bedrooms:=if((real)L.no_of_bedrooms <1 or (real)L.no_of_bedrooms >10,'',STD.STR.TOUPPERCASE(L.no_of_bedrooms));
        self.building_square_footage:=if((real)L.building_square_footage <250 or (real)L.building_square_footage >26136000,'',STD.STR.TOUPPERCASE(L.building_square_footage));
        self.living_area_square_footage:=if((real)L.living_area_square_footage <250 or (real)L.living_area_square_footage >30000,'',STD.STR.TOUPPERCASE(L.living_area_square_footage));
        self.acres:=if((real)L.acres <0.0057 or (real)L.acres >600,'',STD.STR.TOUPPERCASE(L.acres));
		prelot_size:=if(self.acres='',L.lot_size,if((real)L.lot_size<(0.9*((real)L.acres)*43560) or (real)L.lot_size>(1.1*((real)L.acres)*43560),(string)((real)L.acres*43560),STD.STR.TOUPPERCASE(L.lot_size)));
		self.lot_size:=if((real)prelot_size <250 or (real)prelot_size >26136000,'',prelot_size);
        self.no_of_stories:=if((real)L.no_of_stories <0 or (real)L.no_of_stories >100,'',STD.STR.TOUPPERCASE(L.no_of_stories));
        self.no_of_fireplaces:=if((real)L.no_of_fireplaces <0 or (real)L.no_of_fireplaces >11,'',STD.STR.TOUPPERCASE(L.no_of_fireplaces));
        self.no_of_rooms:=if((real)L.no_of_rooms <0 or (real)L.no_of_rooms >62,'',STD.STR.TOUPPERCASE(L.no_of_rooms));
        self.no_of_units:=if((real)L.no_of_units <0 or (real)L.no_of_units >101,'',STD.STR.TOUPPERCASE(L.no_of_units));
        self.sale_date:=if((unsigned4)L.sale_date <20001030 or (unsigned4)L.sale_date > AdjustedArchiveDate,'',L.sale_date);
        self.sale_amount:=if((real)L.sale_amount <1 or (real)L.sale_amount >100000000,'',STD.STR.TOUPPERCASE(L.sale_amount));
        self.tax_amount:=if((real)L.tax_amount <100 or (real)L.tax_amount >10000000,'',STD.STR.TOUPPERCASE(L.tax_amount));
        self.assessed_year:=if((unsigned4)L.assessed_year <1800 or (unsigned4)L.assessed_year >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.assessed_year));
        self.year_built:=if((unsigned4)L.year_built <1800 or (unsigned4)L.year_built >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.year_built));
        //clear out filtered sources and tax/rec dates
        self.src_building_square_footage:=if(self.building_square_footage='','',L.src_building_square_footage);
        self.tax_dt_building_square_footage:=if(self.building_square_footage='','',L.tax_dt_building_square_footage);

        self.src_air_conditioning_type:=if(self.air_conditioning_type='','',L.src_air_conditioning_type);
        self.tax_dt_air_conditioning_type:=if(self.air_conditioning_type='','',L.tax_dt_air_conditioning_type);

        self.src_exterior_wall:=if(self.exterior_wall='','',L.src_exterior_wall);
        self.tax_dt_exterior_wall:=if(self.exterior_wall='','',L.tax_dt_exterior_wall);

        self.src_fireplace_ind:=if(self.fireplace_ind='','',L.src_fireplace_ind);
        self.tax_dt_fireplace_ind:=if(self.fireplace_ind='','',L.tax_dt_fireplace_ind);

        self.src_fireplace_type:=if(self.fireplace_type='','',L.src_fireplace_type);
        self.tax_dt_fireplace_type:=if(self.fireplace_type='','',L.tax_dt_fireplace_type);

        self.src_garage:=if(self.garage='','',L.src_garage);
        self.tax_dt_garage:=if(self.garage='','',L.tax_dt_garage);

        self.src_heating:=if(self.heating='','',L.src_heating);
        self.tax_dt_heating:=if(self.heating='','',L.tax_dt_heating);

        self.src_living_area_square_footage:=if(self.living_area_square_footage='','',L.src_living_area_square_footage);
        self.tax_dt_living_area_square_footage:=if(self.living_area_square_footage='','',L.tax_dt_living_area_square_footage);

        self.src_no_of_baths:=if(self.no_of_baths='','',L.src_no_of_baths);
        self.tax_dt_no_of_baths:=if(self.no_of_baths='','',L.tax_dt_no_of_baths);

        self.src_no_of_bedrooms:=if(self.no_of_bedrooms='','',L.src_no_of_bedrooms);
        self.tax_dt_no_of_bedrooms:=if(self.no_of_bedrooms='','',L.tax_dt_no_of_bedrooms);

        self.src_no_of_fireplaces:=if(self.no_of_fireplaces='','',L.src_no_of_fireplaces);
        self.tax_dt_no_of_fireplaces:=if(self.no_of_fireplaces='','',L.tax_dt_no_of_fireplaces);

        self.src_no_of_full_baths:=if(self.no_of_full_baths='','',L.src_no_of_full_baths);
        self.tax_dt_no_of_full_baths:=if(self.no_of_full_baths='','',L.tax_dt_no_of_full_baths);

        self.src_no_of_half_baths:=if(self.no_of_half_baths='','',L.src_no_of_half_baths);
        self.tax_dt_no_of_half_baths:=if(self.no_of_half_baths='','',L.tax_dt_no_of_half_baths);

        self.src_no_of_stories:=if(self.no_of_stories='','',L.src_no_of_stories);
        self.tax_dt_no_of_stories:=if(self.no_of_stories='','',L.tax_dt_no_of_stories);

        self.src_parking_type:=if(self.parking_type='','',L.src_parking_type);
        self.tax_dt_parking_type:=if(self.parking_type='','',L.tax_dt_parking_type);

        self.src_pool_indicator:=if(self.pool_indicator='','',L.src_pool_indicator);
        self.tax_dt_pool_indicator:=if(self.pool_indicator='','',L.tax_dt_pool_indicator);

        self.src_pool_type:=if(self.pool_type='','',L.src_pool_type);
        self.tax_dt_pool_type:=if(self.pool_type='','',L.tax_dt_pool_type);

        self.src_roof_cover:=if(self.roof_cover='','',L.src_roof_cover);
        self.tax_dt_roof_cover:=if(self.roof_cover='','',L.tax_dt_roof_cover);

        self.src_year_built:=if(self.year_built='','',L.src_year_built);
        self.tax_dt_year_built:=if(self.year_built='','',L.tax_dt_year_built);

        self.src_foundation:=if(self.foundation='','',L.src_foundation);
        self.tax_dt_foundation:=if(self.foundation='','',L.tax_dt_foundation);

        self.src_acres:=if(self.acres='','',L.src_acres);
        self.tax_dt_acres:=if(self.acres='','',L.tax_dt_acres);

        self.src_lot_size:=if(self.lot_size='','',L.src_lot_size);
        self.tax_dt_lot_size:=if(self.lot_size='','',L.tax_dt_lot_size);

        self.src_structure_quality:=if(self.structure_quality='','',L.src_structure_quality);
        self.tax_dt_structure_quality:=if(self.structure_quality='','',L.tax_dt_structure_quality);

        self.src_sewer:=if(self.sewer='','',L.src_sewer);
        self.tax_dt_sewer:=if(self.sewer='','',L.tax_dt_sewer);

        self.src_assessed_year:=if(self.assessed_year='','',L.src_assessed_year);
        self.tax_dt_assessed_year:=if(self.assessed_year='','',L.tax_dt_assessed_year);

        self.src_tax_amount:=if(self.tax_amount='','',L.src_tax_amount);
        self.tax_dt_tax_amount:=if(self.tax_amount='','',L.tax_dt_tax_amount);

        self.src_floor_type:=if(self.floor_type='','',L.src_floor_type);
        self.tax_dt_floor_type:=if(self.floor_type='','',L.tax_dt_floor_type);

        self.src_no_of_rooms:=if(self.no_of_rooms='','',L.src_no_of_rooms);
        self.tax_dt_no_of_rooms:=if(self.no_of_rooms='','',L.tax_dt_no_of_rooms);

        self.src_no_of_units:=if(self.no_of_units='','',L.src_no_of_units);
        self.tax_dt_no_of_units:=if(self.no_of_units='','',L.tax_dt_no_of_units);

        self.src_style_type:=if(self.style_type='','',L.src_style_type);
        self.tax_dt_style_type:=if(self.style_type='','',L.tax_dt_style_type);

        self.src_sale_amount:=if(self.sale_amount='','',L.src_sale_amount);
        self.rec_dt_sale_amount:=if(self.sale_amount='','',L.rec_dt_sale_amount);

        self.src_sale_date:=if(self.sale_date='','',L.src_sale_date);
        self.rec_dt_sale_date:=if(self.sale_date='','',L.rec_dt_sale_date);

        self:=L;
    END;

    FilteredCA:=project(ConvertToPC,tFilterInvalid(left));

    dPropAddrCollapseAceAID	:=	PropertyCharacteristics.Functions.fnCollapseAceAID(FilteredCA);
    PropertyCharacteristics.Mac_Property_Rollup(dPropAddrCollapseAceAID,dCombinedRollup,true,true);
    
   
export fnGenerateCollateralAnalytics:=dCombinedRollup;