bh := business_header.File_Business_Header;

/////////////////////////////////////////////////////////////
// -- Slim down record to just company name
/////////////////////////////////////////////////////////////
layout_company :=
record
	bh.company_name;
end;

bh_company := table(bh(trim(company_name) != ''), layout_company, company_name) : persist('temp::lbentley::businesswordsresearch');

/////////////////////////////////////////////////////////////
// -- Get number of spaces between words in company name
/////////////////////////////////////////////////////////////
layout_company_spaces :=
record
	layout_company;
	unsigned4 nSpaces := 0;
end;
alpha := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ';

layout_company_spaces tcleancompany(layout_company l) := 
transform
	self.company_name := StringLib.StringFilter(trim(StringLib.StringCleanSpaces(l.company_name), left,right), alpha);
	//self.company_name := trim(StringLib.StringCleanSpaces(l.company_name), left,right);
	self.nSpaces := length(StringLib.StringFilter(trim(self.company_name,left,right), ' '));
end;

bh_words := project(bh_company, tcleancompany(left));

/////////////////////////////////////////////////////////////
// -- Get indexes of spaces in company name, normalize
/////////////////////////////////////////////////////////////
layout_index :=
record
	layout_company;
end;

beginspaceindex := 0;

layout_index tgetindex(layout_company_spaces l, integer pindex) :=
transform
	savelastindex 		:= if(pindex = 1, 1, StringLib.StringFind(trim(l.company_name,left,right), ' ', pindex - 1));
	beginspaceindex 	:= StringLib.StringFind(trim(l.company_name,left,right), ' ', pindex);
	company_name 		:= trim(if(beginspaceindex = 0, trim(l.company_name,left,right)[savelastindex..],
													trim(l.company_name,left,right)[savelastindex..(beginspaceindex - 1)]),left,right);
	self.company_name 	:= company_name;
end;

bh_norm_words := normalize(bh_words, left.nSpaces + 1, tgetindex(left, counter));

bh_4letters := bh_norm_words(length(trim(company_name, left,right)) < 5 and length(trim(company_name, left,right)) > 1);

layout_4letter :=
record
	string4 word;
end;
layout_4letter tto4letter(layout_index l) := transform
	self.word := trim(l.company_name, left,right);
end;

bh_4letterword := project(bh_4letters, tto4letter(left));

layout_words_rollup :=
record
	bh_4letterword.word;
	unsigned4 cnt := count(group);
end;

bh_word_counts := table(bh_4letterword, layout_words_rollup, word);

output(count(bh_word_counts) + ' 4 or less letter company words in business header');

output(topn(bh_word_counts, 1000, -cnt), named('Top100Business4LetterWords'), all);

currentwordlist := [
 'COMPANY'
,'CO'
,'CORP'
,'CORPORATION'
,'CORPORATE'
,'SERVICE'
,'SERVICES'
,'SER'
,'INC'
,'INCORPORATED'
,'INTL'
,'INTERNATIONAL'
,'GLOBAL'
,'INTERCONTINENTAL'
,'WORLDWIDE'
,'ASSOC'
,'ASSOCIATES'
,'ASSOCIATION'
,'BOUTIQUE'
,'INDUSTRIES'
,'INDUSTRIAL'
,'IND'
,'ENTERPRISES'
,'ENTERPRISE'
,'TRADING'
,'LLP'
,'COOP'
,'FACTORY'
,'GRP'
,'GROUP'
,'LLC'
,'BUILDING'
,'COMMISSION'
,'CLUB'
,'DEPT'
,'DEPARTMENT'
,'DEPARTMENTS'
,'NATIONAL'
,'NATIONWIDE'
,'CONTRACTORS'
,'CONTRACTING'
,'WORLD'
,'ADVANCED'
,'STORE'
,'STORES'
,'THE'
,'MALL'
,'LTD'
,'LIMITED'
,'LIABILITY'
,'PARTNERSHIP'
,'PARTNERS'
,'PARTNER'
,'FRANCHISE'
,'INDUSTRY'
,'INDUSTRIES'
,'VENTURE'
,'VENTURES'
,'HOLDING'
,'HOLDINGS'
,'NA'
,'NEIGHBORHOOD'
,'COOPERATIVE'
,'AGENCY'
,'RLLP'
,'LP'
,'GP'
,'RET'
,'REIT'
,'OF'
,'AT'
,'INSTITUTE'
,'SOCIETY'
,'AND'
,'COM'
,'FASHION'
,'CLOTHING'
,'TEXTILES'
,'APPAREL'
,'FREIGHT'
,'SHIPPING'
,'PACKAGING'
,'PACKING'
,'CARGO'
,'DISTRIBUTION'
,'DISTRIBUTERS'
,'DISTRIBUTORS'
,'DISTRIBUTER'
,'DISTRIBUTOR'
,'TRANSPORT'
,'TRANSPORTATION'
,'DEVICES'
,'INSTRUMENTS'
,'INST'
,'RESOURCES'
,'EQUIPMENT'
,'APPLIANCES'
,'APPLIANCE'
,'CUSTOMS'
,'BROKER'
,'BROKERAGE'
,'BROKERS'
,'SYSTEMS'
,'AUTOMATION'
,'LAB'
,'LABORATORIES'
,'FURNITURE'
,'MANUFACTURING'
,'TECHNOLOGY'
,'TECHNOLOGIES'
,'ENGINEERING'
,'MACHINING'
,'METALS'
,'STEEL'
,'EXTRUDERS'
,'TELECOM'
,'TELECOMMUNICATION'
,'TELECOMMUNICATIONS'
,'WIRELESS'
,'CELLULAR'
,'TELEPHONE'
,'COMMUNICATION'
,'COMMUNICATIONS'
,'BROADCASTING'
,'RECORDING'
,'MEDIA'
,'PRODUCTIONS'
,'ADVERTISING'
,'SUPPLY'
,'MARKETING'
,'EQUITY'
,'EQUITIES'
,'WHOLESALE'
,'CHEMICAL'
,'SCIENTIFIC'
,'MEDICAL'
,'CONSTRUCTION'
,'BUILDERS'
,'BUILDING'
,'AVIATION'
,'AIRCRAFT'
,'AIRLINE'
,'AIRLINES'
,'AMUSEMENT'
,'DANCERS'
,'MUSIC'
,'ACCOUNTS'
,'AMBULANCE'
,'ADMINISTRATION'
,'BOOKKEEPING'
,'ALIGNMENT'
,'ANTIQUE'
,'ANTIQUES'
,'ARCHITECT'
,'ARCHETECT'
,'AUTO'
,'AUTOMOTIVE'
,'MOTOR'
,'MOTORS'
,'BOOKBINDER'
,'BOOKBINDING'
,'PRODUCTS'
,'PRODUCERS'
,'PROPERTY'
,'PROPERTIES'
,'PARTS'
,'FARMERS'
,'FARMING'
,'TRUCKING'
,'ENERGY'
,'ELECTRIC'
,'FUEL'
,'FUELS'
,'OIL'
,'GAS'
,'PETROLEUM'
,'FINANCE'
,'FINANCIAL'
,'FINANCING'
,'TRAVEL'
,'ELECTRONICS'
,'ELECTRICAL'
,'COMPUTER'
,'COMPUTERS'
,'NETWORK'
,'NETWORKS'
,'COFFEE'
,'EXPRESSO'
,'ESPRESSO'
,'DESIGN'
,'DESIGNS'
,'CONDO'
,'CONDOMINIUM'
,'CONDOMINIUMS'
,'APARTMENTS'
,'VALET'
,'MAINTENANCE'
,'CLEANING'
,'CLEANERS'
,'CLEANER'
,'PIZZA'
,'PIZZARIA'
,'PIZZERIA'
,'CHURCH'
,'ONLINE'
,'CHIROPRACTIC'
,'CRUISES'
,'SPORT'
,'SPORTS'
,'SOCCER'
,'RACQUET'
,'FOOTBALL'
,'RESEARCH'
,'DEVELOPMENT'
,'SWITCHBOARD'
,'SHUTTERS'
,'MINERAL'
,'MINERALS'
,'STONE'
,'SOILS'
,'CRAFT'
,'HANDICRAFT'
,'HANDYCRAFT'
,'FOILCRAFT'
,'HYDRAULICS'
,'ASBESTOS'
,'FLOORING'
,'RECYCLING'
,'DISPLAY'
,'DISPLAYS'
,'SIGNS'
,'SEWING'
,'STITCH'
,'NEEDLEWORK'
,'EMBROIDERY'
,'MILLWORK'
,'CABLE'
,'FIBRE'
,'PLASTIC'
,'PLASTICS'
,'FOUNDATION'
,'FUND'
,'MORTGAGE'
,'BANK'
,'AMERICA'
,'AMERICAN'
,'AMERICAS'
,'FEDERAL'
,'FORWARDING'
,'EXPRESS'
,'LOGISTICS'
,'MARINE'
,'USA'
,'TRADING'
,'MANAGEMENT'
,'HOTEL'
,'HOTELS'
,'COUNSELING'
,'COUNSELORS'
,'CARRIER'
,'OPERATING'
,'TRANSIT'
,'CREDIT'
,'ASSET'
,'PUBLIC'
,'STORAGE'
,'CAPITAL'
,'FUNDING'
,'INVESTORS'
,'INVESTMENT'
,'LENDING'
,'LEASING'
,'COMMERCIAL'
,'REALTY'
,'BUSINESS'
,'MACHINE'
,'TOOL'
,'GENERAL'
,'TELEVISION'
,'INSURANCE'
,'ACQUISITION'
,'VEGETATION'
,'RETIREMENT'
,'FISHING'
,'PAINTING'
,'REPAIR'
,'GOVERNMENT'
,'HAIRCUTTER'
,'HAIRCUTTERS'
,'HOUSING'
,'FACILITIES'
,'GREENERY'
,'SEWER'
,'CITY'
,'TOWN'
,'TOWNSHIP'
,'COUNTY'
,'STATE'
,'METRO'
,'OFFICE'
,'LAWN'
,'LANDSCAPING'
,'LUMBER'
,'EXTERMINATOR'
,'XTERMINATOR'
,'X-TERMINATOR'
,'SURVEYING'
,'GUTTER'
,'GUTTERS'
,'PRINTING'
,'PRESS'
,'GARDENING'
,'HEATING'
,'AIR'
,'CONDITIONING'
,'CONCRETE'
,'PUMPING'
,'TREASURER'
,'PUBLISHING'
,'PUBLISHERS'
,'INFORMATION'
];


output(topn(bh_word_counts(trim(word,left,right) not in currentwordlist), 1000, -cnt), named('Top100Business4LetterWordsFiltered'), all);

