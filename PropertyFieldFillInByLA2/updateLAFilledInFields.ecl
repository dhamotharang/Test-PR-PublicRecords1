// updateLAFilledInFields.ecl
import PropertyFieldFillInByLA2;
/*

This function allows as many as 8 input datasets all assumed to have the layout, layout_PropertyFillInVariables.
But, only the 1st two datasets are required. (note. 8 are allowed because 1) seven files
are created by the calls to the macro, mac_FillinSpecificEmptyVariables, and 2) the first is assumed
to be the property dataset before mac_FillinSpecificEmptyVariables does its thing -- for the 1st updateLAFilledInField
call, just after the 7 calls that use Adaptive Distance, the 1st file is NormalizedPropertyVariablesDSToUpdate;
for the 2nd call of updateLAFilledInField, its 1st input file is the
output of the 1st call to updateLAFilledInField.

la2_UpdatedPropertyVariablesDS := 
   PropertyFieldFillInByLA2.updateLAFilledInFields(
                          la1_UpdatedPropertyVariablesDS
                          ,la2_AssessedAmount_outdata
                          ,la2_Baths_outdata
                          ,la2_Bedrooms_outdata
                          ,la2_BuildingAge_outdata
                          ,la2_BuildingArea_outdata
                          ,la2_Rooms_outdata
                          ,la2_Stories_outdata
												   );
*/
		
											
EXPORT 
  updateLAFilledInFields(
                         dataset(layout_PropertyFillInVariables) a
                         , dataset(layout_PropertyFillInVariables) b
                         , dataset(layout_PropertyFillInVariables) c=dataset([],layout_PropertyFillInVariables) // AssessedAmount
                         , dataset(layout_PropertyFillInVariables) d=dataset([],layout_PropertyFillInVariables) // Baths
                         , dataset(layout_PropertyFillInVariables) e=dataset([],layout_PropertyFillInVariables) // Bedrooms
                         , dataset(layout_PropertyFillInVariables) f=dataset([],layout_PropertyFillInVariables) // BuildingAge
                         , dataset(layout_PropertyFillInVariables) g=dataset([],layout_PropertyFillInVariables) // BuildingArea
                         , dataset(layout_PropertyFillInVariables) h=dataset([],layout_PropertyFillInVariables) // Rooms
												 , dataset(layout_PropertyFillInVariables) i=dataset([],layout_PropertyFillInVariables) // Stories
												 , dataset(layout_PropertyFillInVariables) j=dataset([],layout_PropertyFillInVariables) // AirConditioning
												 , dataset(layout_PropertyFillInVariables) k=dataset([],layout_PropertyFillInVariables) // Basement                       
												 , dataset(layout_PropertyFillInVariables) l=dataset([],layout_PropertyFillInVariables) // BasementSqft
												 , dataset(layout_PropertyFillInVariables) m=dataset([],layout_PropertyFillInVariables) // Construction
												 , dataset(layout_PropertyFillInVariables) n=dataset([],layout_PropertyFillInVariables) // Exterior
												 , dataset(layout_PropertyFillInVariables) o=dataset([],layout_PropertyFillInVariables) // Fireplaces
												 , dataset(layout_PropertyFillInVariables) p=dataset([],layout_PropertyFillInVariables) // FloorCover
												 , dataset(layout_PropertyFillInVariables) q=dataset([],layout_PropertyFillInVariables) // Foundation
												 , dataset(layout_PropertyFillInVariables) r=dataset([],layout_PropertyFillInVariables) // FuelType
												 , dataset(layout_PropertyFillInVariables) s=dataset([],layout_PropertyFillInVariables) // Garage
												 , dataset(layout_PropertyFillInVariables) t=dataset([],layout_PropertyFillInVariables) // GarageSqft
												 , dataset(layout_PropertyFillInVariables) u=dataset([],layout_PropertyFillInVariables) // Heating
												 , dataset(layout_PropertyFillInVariables) v=dataset([],layout_PropertyFillInVariables) // Roof_Cover 
                        ) := FUNCTION
												
mac_keepOneVariableField( Field, v_ftype) := MACRO
self.Field := 
 	IF( (l.v_ftype='') or (r.v_ftype='LA1')
				, r.Field
				, IF( (r.v_ftype='') or (l.v_ftype='LA1')
            , l.Field
            , r.Field
        )
		);
	
ENDMACRO;
mac_fillOneVariable( Variable, Variable_ftype, VariableBit ) := MACRO
   mac_keepOneVariableField(VariableBit, Variable_ftype);
   mac_keepOneVariableField(Variable_ftype, Variable_ftype);
   mac_keepOneVariableField(Variable, Variable_ftype);
	 
ENDMACRO;

x := a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s+t+u+v;
// x := a+b+c+d+e+f+g+h+i;

recordof(x) updateLAFilledInFields( recordof(x) l, recordof(x) r ) := TRANSFORM
  mac_fillOneVariable( AssessedAmount, AssessedAmount_ftype, AssessedAmountBit );
  mac_fillOneVariable( Baths, Baths_ftype, BathsBit );
  mac_fillOneVariable( Bedrooms, Bedrooms_ftype, BedroomsBit  );
  mac_fillOneVariable( BuildingAge, BuildingAge_ftype, BuildingAgeBit );
  mac_fillOneVariable( BuildingArea, BuildingArea_ftype, BuildingAreaBit  );
  mac_fillOneVariable( Rooms, Rooms_ftype, RoomsBit  );
  mac_fillOneVariable( Stories, Stories_ftype, StoriesBit  );
	
	mac_fillOneVariable( Air_Conditioning_Type, Air_Conditioning_ftype, Air_ConditioningBit );
	mac_fillOneVariable( Basement, Basement_ftype, BasementBit );
	mac_fillOneVariable( Basement_sqft, Basement_sqft_ftype,	Basement_sqftBit );  
	mac_fillOneVariable( Construction, Construction_ftype, ConstructionBit );
	mac_fillOneVariable( Exterior, Exterior_ftype, ExteriorBit );
	mac_fillOneVariable( Fireplaces, Fireplaces_ftype, FireplacesBit );
  mac_fillOneVariable( Floor_Cover, Floor_Cover_ftype, Floor_CoverBit );
	mac_fillOneVariable( Foundation, Foundation_ftype, FoundationBit );
	mac_fillOneVariable( Fuel_Type, Fuel_Type_ftype, Fuel_TypeBit );
  mac_fillOneVariable( Garage, Garage_ftype, GarageBit );
	mac_fillOneVariable( Garage_sqft, Garage_sqft_ftype, Garage_sqftBit );
  mac_fillOneVariable( Heating, Heating_ftype, HeatingBit );
	mac_fillOneVariable( Roof_Cover, Roof_Cover_ftype, Roof_CoverBit );		
  
  self := l;
END;

// output(x,,'~thor_data400::temp::PropertyFieldFillinByLA2::updateLAFilledInFields',OVERWRITE);	 	 

/*
  When we get here, we have all the datasets output by mac_FillinSpecificEmptyVariable.
*/
UpdatedPropertyVariablesDS := 
   rollup(
          sort(
               distribute(x,hash64(geolink,cleanaid))
               ,geolink,cleanaid
               ,local
          )
          ,(left.geolink=right.geolink) and (left.cleanaid=right.cleanaid)
          ,updateLAFilledInFields(left,right)
          ,local
   );

// output(UpdatedPropertyVariablesDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::UpdatedPropertyVariablesDS_derived',OVERWRITE);	 	 

return UpdatedPropertyVariablesDS;
END;

