/*
  Decode a hash string into pair of latitude and longitude. A single record dataset is returned.
*/
EXPORT DATASET({REAL latitude,REAL longitude,REAL latitude_err,REAL longitude_err}) Fn_LatLongDecode(STRING hash_string) := BEGINC++
//using namespace std;
namespace ns_SALT39_Fn_LatLongDecode {
// Static array of 0-9, a-z
char base32_codes[] = "0123456789bcdefghjkmnpqrstuvwxyz";
#define TABLE_SIZE 32
struct DecodedHash {
    double latitude;    
		double longitude;
    double latitude_err;
    double longitude_err;
};
// Convert the character to the index position in the array
int base32_codes_index_of(char c)
{
	char *cptr = base32_codes;
	int x = 0;
	while(*cptr && *cptr != c)
	{
		cptr++;
		x++;
	}
	return(x < TABLE_SIZE ? x : TABLE_SIZE);
}
void decode_bbox(const char *hash_string, unsigned hash_stringLen, double *maxlat, double *minlat, double *maxlon, double *minlon)
{
	int i,bits;
	char buffer[32];
	char *dest;
	dest = buffer;
	while(*hash_string)
		*dest++ = tolower(*hash_string++);
	unsigned srclen = hash_stringLen;
	*maxlat = 90;
	*maxlon = 180;
	*minlat = -90;
	*minlon = -180;
	int islon = true;
	for(unsigned i = 0 ; i < srclen; i++) 
	{
		int char_index = base32_codes_index_of(buffer[i]);
		for (bits = 4; bits >= 0; --bits) 
		{
			int bit = (char_index >> bits) & 1;
			if (islon) 
			{
				double mid = (*maxlon + *minlon) / 2;
				if(bit == 1) 
				{
					*minlon = mid;
				} 
				else 
				{
					*maxlon = mid;
				}
			} 
			else 
			{
				double mid = (*maxlat + *minlat) / 2;
				if(bit == 1) 
				{
					*minlat = mid;
				} 
				else 
				{
					*maxlat = mid;
				}
			}
			islon = !islon;
		}
	}
}
}//namespace
using namespace ns_SALT39_Fn_LatLongDecode;
#body
#option pure
{
	DecodedHash *out = (DecodedHash*)rtlMalloc(sizeof(DecodedHash));
	double maxlat, maxlon, minlat, minlon;
	decode_bbox(hash_string,lenHash_string,&maxlat,&minlat,&maxlon,&minlon);
	out->latitude      = (minlat + maxlat) / 2;
	out->longitude     = (minlon + maxlon) / 2;
	out->latitude_err  = maxlat - out->latitude;
	out->longitude_err = maxlon - out->longitude;
	__lenResult = sizeof(DecodedHash);
	__result = out;
}
ENDC++;
