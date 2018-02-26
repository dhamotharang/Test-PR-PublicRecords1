/*
 Encode a pair of latitude and longitude into geohash. The third argument is optional, 
 you can specify a length of this hash string, which also affect on the precision of the geohash.
*/
EXPORT STRING Fn_LatLongEncode(REAL latitude, REAL longitude, UNSIGNED precision=12) := BEGINC++
//using namespace std;
namespace ns_SALT39_Fn_LatLongEncode {
// Static array of 0-9, a-z
char base32_codes[] = "0123456789bcdefghjkmnpqrstuvwxyz";
// note there are characters missing, ots not a complete alphabet
#define TABLE_SIZE 32
// Convert the index position to the character in the array
char base32_codes_value_of(int index)
{
	if(index >= TABLE_SIZE)
		return(0x00);
	return base32_codes[index];
}
}//namespace
using namespace ns_SALT39_Fn_LatLongEncode;
#body
#option pure
{
	double maxlat = 90;
	double maxlon = 180;
	double minlat = -90;
	double minlon = -180;
	double mid        = 0;
	int   islon      = true;
	int    num_bits   = 0;
	int    hash_index = 0;
	unsigned int output_length = 0;
	char * out = (char*)rtlMalloc(precision);
	while(output_length < precision) 
	{
		if (islon) 
		{
			mid = (maxlon + minlon) / 2;
			if(longitude > mid) 
			{
				hash_index = (hash_index << 1) + 1;
				minlon=mid;
			} 
			else 
			{
				hash_index = (hash_index << 1) + 0;
				maxlon=mid;
			}
		} 
		else 
		{
			mid = (maxlat + minlat) / 2;
			if(latitude > mid ) 
			{
				hash_index = (hash_index << 1) + 1;
				minlat = mid;
			} 
			else 
			{
				hash_index = (hash_index << 1) + 0;
				maxlat = mid;
			}
		}
		islon = !islon;
		++num_bits;
		if (5 == num_bits) 
		{
			out[output_length] = base32_codes_value_of(hash_index);
			output_length++;
			num_bits   = 0;
			hash_index = 0;
		}
	}
	__lenResult = precision;
	__result = out;
}
ENDC++;
