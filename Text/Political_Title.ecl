Ministrys :=[
'AGRICULTURE',
'AVIATION',
'CABINET',
'CIVIL SERVICE',
'COMMERCE',
'COMMUNICATIONS',
'CULTURE',
'DEFENSE',
'DEFENSE PROCUREMENT',
'DEVELOPMENT COOPERATION',
'ECONOMIC',
'ECONOMY',
'EDUCATION',
'ELECTRICITY',
'ENERGY',
'ENVIRONMENT',
'EXTERNAL LIASON',
'FAMILIES',
'FINANCE',
'FOREIGN',
'FOREIGN TRADE',
'GAS',
'HEALTH',
'HIGHER EDUCATION',
'HOUSING',
'IMMIGRATION',
'INDUSTRY',
'INFORMATION',
'INSURANCE',
'INTERIOR',
'INTERNATIONAL COOPERATION',
'IRRIGATION',
'ISLAMIC TRUST',
'JUSTICE',
'LABOR',
'LABOUR',
'LOCAL DEVELOPMENT',
'MARITIME FISHERIES',
'MELTING',
'METEOROLOGY',
'MINERAL RESOURCES',
'MINERAL WEALTH',
'MULTICULTURAL',
'NATIONAL ASSEMBLY',
'NATIONAL SOLIDARITY',
'NATURAL RESOURCES',
'OIL',
'PETROLEUM',
'PLANNING',
'POST',
'PRESIDENTIAL',
'PRIME',
'PUBLIC BUSINESS',
'PUBLIC BUSINESS SECTOR',
'PUBLIC ENTERPRISES',
'PUBLIC ENTERPRISES SECTOR',
'PUBLIC WORKS',
'REGIONAL COOPERATION',
'SEA TRANSPORT',
'SECURITY',
'SOCIAL',
'SOCIAL DEVELOPMENT',
'SUPPLY',
'TOURISM',
'TRADE',
'TRADITIONAL INDUSTRIES',
'TRANSPORT',
'TRANSPORTATION',
'VILLAGE',
'WAR',
'WATERS',
'WATER RESOURCES'
];
Dignatary := 
['ENVOY',
'SPECIAL ENVOY',
'CHANCELLOR',
'SECRETARY OF STATE',
'PRESIDENT-ELECT',
'PRESIDENT',
'KING',
'PRINCE',
'QUEEN',
'MONARCH',
'RULER',
'GENERAL',
'PRINCESS',
'FIRST LADY',
'ACTIVIST',
'SPOKESWOMAN',
'SPOKESMAN',
'PREMIER'
];

pattern pre_qual := 
( validate(text.word,stringlib.stringtouppercase(matchtext) IN 
['ASSISTANT',
'CROWN',
'DEPUTY',
'DEMOCRATIC',
'OPPOSITION',
'FORMER',
'REPUBLICAN',
'VICE'
]) ws )*;

m_names := ['minister','Minister','secretary','Secretary'];

pattern minist := validate(word (opt(ws word OPT(ws word))),stringlib.stringtouppercase(matchtext) IN ministrys);

pattern minist_list := minist (ws ['And','and'] ws minist)*;

pattern h_title := 
  pre_qual 
  (
  validate(word opt(ws word OPT(ws word)),stringlib.stringtouppercase(matchtext) IN Dignatary)
  |
  m_names ws ['of','Of','of the','Of The'] OPT(ws ['State For','state for','state For']) ws minist_list OPT(ws ['Affairs','affairs'])
  |
  minist_list ws m_names
  |
  ['AMBASSADOR TO','Ambassador To','ambassador to'] ws proper_noun
  );

export pattern Political_title := h_title (ws ['and','And','&'] ws h_title)*;