/* 
This module is the conversion of a SAS program created by Scott Zrebiec, scott.zrebiec@lexisnexis.com.
The conversion was done by Timothy Humphrey, timothy.humphrey@lexisnexis.com

This software uses local averaging to fill-in property fields that don't have values for single
family dwellings.(SFDs) It currently will fill-in: Assessed Value (AssessedAmount), Number
of Bathrooms (Baths), Number of Bedrooms (Bedrooms), Age of Dwelling (BuildingAge),
Area of Dwelling (BuildingArea), Number of Rooms (Rooms), and Number of Stories (Stories).

The software finds 10 properties close to a property missing a value for one of the above fields.
These 10 properties must be similar to the one needing the value and have a value for
the field that needs a value. When it finds 10, it computes a weighted average for the
field and inserts it into the field.

ATTRIBUTES IN THIS MODULE

A. a_readme
B. BWR_ALL_FL_NY_GA_OH_MA_mac_fillinPropertyVariables
C. BWR_ALL_NY_mac_fillinPropertyVariables
D. BWR_showCleanaidWithMultipleGeoblocks
E. BWR_verify_mac_replacePropertyGeolinkWithGlinkGroupName
F. calcAdaptiveAndEuclideanDistanceForUseInLA
G. calcEuclideanDistance
H. GeoLinkToGeoLinkDistanceAndSFDsCount
I. getSingleResidentProperitiesWithHedonicData
J. GroupGeoBlockDS
K. layout_PropertyFillInVariables
L. layout_PropertyPairs
M. layouts
N. mac_fillinPropertyVariables
O. mac_FillinSpecificEmptyVariable
P. mac_prepPropertiesAndProcessWithLA
Q. mac_replacePropertyGeolinkWithGlinkGroupName
R. mac_standardizePropertyFillinVariables
S. updateLAFilledInFields

CALLING TREES:

1. BWR_ALL_NY_mac_fillinPropertyVariables
1.1. mac_prepPropertiesAndProcessWithLA

1. BWR_ALL_FL_NY_GA_OH_MA_mac_fillinPropertyVariables
1.1. mac_prepPropertiesAndProcessWithLA

1. mac_prepPropertiesAndProcessWithLA
1.1. getSingleResidentProperitiesWithHedonicData
1.2. mac_fillinPropertyVariables
1.2.1. mac_standardizePropertyFillinVariables
1.2.2. mac_replacePropertyGeolinkWithGlinkGroupName
1.2.2.1 GroupGeoBlockDS
1.2.3. calcAdaptiveAndEuclideanDistanceForUseInLA
1.2.3.1. calcEuclideanDistance
1.2.4. mac_FillinSpecificEmptyVariable
1.2.5. updateLAFilledInFields

SHORT DESCRIPTION OF EACH ATTRIBUTE FOLLOWS:

A. a_readme - This attribute provides an introduction to this module and a brief description
   of the attributes in this module.

B. BWR_ALL_FL_NY_GA_OH_MA_mac_fillinPropertyVariables - This BWR attribute fills-in variables
   for all SFDs in FL, NY, GA, OH, and MA.

C. BWR_ALL_NY_mac_fillinPropertyVariables - This BWR attribute fills-in variables for all SFDs
   in NY.

D. BWR_showCleanaidWithMultipleGeoblocks

E. BWR_verify_mac_replacePropertyGeolinkWithGlinkGroupName - This attribute is the BWR for
   verifying that geoblock groups were properly created.

F. calcAdaptiveAndEuclideanDistanceForUseInLA -- This attribute calculates the Adaptive and
   Euclidean distances for a property with every other qualifying property.

G. calcEuclideanDistance -- This attribute computes one Euclidean distance given the lat/longs
   of two properties.

I. getSingleResidentProperitiesWithAverageHedonics - This attribute inputs a set of postal
   state codes and returns all SFDs in those states. And, for each record of a SFD contains the
   fields that LA will fill-in.

J. GroupGeoBlockDS - This attribute makes the geoblock groups. Attached to it is a persist
   so geoblock groups donÂ’t need to be made once or when its inputs change.

K. layout_PropertyFillInVariables - This attribute is the record layout for property fields
   to be filled-in.

L. layout_PropertyPairs - This attribute is the record layout for property pair datasets.

M. layouts - This attribute is a module which contains a few other record layouts.

N. mac_fillinPropertyVariables -- This attribute calls mac_standardizePropertyFillinVariables
   to standardize and normalize the values of fields/variables that will be used to fill-in
   missing values. It also calls calcAdaptiveAndEuclideanDistanceForUseInLA to compute the
   adaptive and euclidean distance between a property and all other qualified properties. This
   distance is used by the fill-in macro, mac_FillinSpecificEmptyVariables. Next, this attribute
   calls mac_FillinSpecificPropertyFillinVariables 7 times, once for each field/variable
   that will be filled-in. After mac_FillinSpecificPropertyFillinVariables has filled-in as
   many missing values as possible, any fields/variables not filled-in will be filled in using
   Euclidean distance, instead of Adaptive distance and the same fill-in macro, i.e. 
   mac_FillinSpecificPropertyFillinVariables. Lastly, the inputted property dataset is updated 
   with the newly filled-in fields/variables.

O. mac_FillinSpecificEmptyVariable -- This attribute fills-in missing values for one specific
   field/variable. Currently, that specific field/variable can be: AssessedAmount or Baths
   or Bedrooms or BuildingAge or BuildingArea or Rooms or Stories.

P. mac_prepPropertiesAndProcessWithLA

Q. mac_replacePropertyGeolinkWithGlinkGroupName - This attribute replaces geoblocks with groups
   of geoblocks. The end result is that most (95%) geoblocks now have more than 500 properties.

R. mac_standardizePropertyFillinVariables -- This attribute standardized and normalizing the
   fields/variables used in the fill-in process.

S. updateLAFilledInFields -- This attribute combines or rollups as many as 8 datasets created
   by mac_FillinSpecificEmptyVariables. The result is one dataset with the same record layout
   as that created by mac_FillinSpecificEmptyVariables, where all values that were filled-in
   are in the final dataset.

OTHER NOTES OF INTEREST: Note: 2010/05/18. As far as I know, there are 228,224 geoblocks. But,
the file that comtains geolink1 and geolink2 where geolink2 is a geoblock close to geolink1.
This file only has 214,435 geolink1's. So, this means that some geoblocks won't have
geoblocks close to it. In these cases, the S_geoblock must also be the geoblock. 
*/
