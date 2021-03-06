export Code2Make(INTEGER i) :=
CASE(i,
1 => 'ACUR',
2 => 'ALFA',
3 => 'ALLA',
4 => 'AMGE',
5 => 'AMGN',
6 => 'AMCL',
7 => 'AMGC',
8 => 'AMER',
9 => 'ANGL',
10 => 'APOL',
11 => 'APRI',
12 => 'ARGO',
13 => 'ASVE',
14 => 'ASTO',
15 => 'AUBU',
16 => 'AUDI',
17 => 'AURR',
18 => 'AUST',
19 => 'AUHE',
20 => 'AVTI',
21 => 'AVEN',
22 => 'BMC',
23 => 'BANT',
24 => 'BRTT',
25 => 'BARR',
26 => 'BATA',
27 => 'BCW',
28 => 'BEAH',
29 => 'BENT',
30 => 'BESA',
31 => 'BLAK',
32 => 'BMW',
33 => 'BRUS',
34 => 'BSA',
35 => 'BUGA',
36 => 'BUIC',
37 => 'CADI',
38 => 'CADL',
39 => 'CALI',
40 => 'CAML',
41 => 'CAME',
42 => 'CATE',
43 => 'CHEC',
44 => 'CHER',
45 => 'CHEV',
46 => 'CHRY',
47 => 'CITR',
48 => 'CLAI',
49 => 'CLCO',
50 => 'CLAC',
51 => 'CLAS',
52 => 'CLEN',
53 => 'COBR',
54 => 'COLU',
55 => 'COMP',
56 => 'COCL',
57 => 'CROS',
58 => 'CRMA',
59 => 'CUSH',
60 => 'CUST',
61 => 'DAEW',
62 => 'DAIH',
63 => 'DAIM',
64 => 'DATS',
65 => 'DESO',
66 => 'DEVI',
67 => 'DODG',
68 => 'DUCA',
69 => 'DUNE',
70 => 'DUPO',
71 => 'EAGL',
72 => 'EASR',
73 => 'ENCO',
74 => 'ERA',
75 => 'EVER',
76 => 'EXCL',
77 => 'FERR',
78 => 'FIAT',
79 => 'FIBE',
80 => 'FORD',
81 => 'FRAN',
82 => 'FRAZ',
83 => 'FRHT',
84 => 'GAZ',
85 => 'GAZE',
86 => 'GENA',
87 => 'GENE',
88 => 'GMC',
89 => 'GLAS',
90 => 'GRAP',
91 => 'HD',
92 => 'HERC',
93 => 'HOND',
94 => 'HUMB',
95 => 'HYUN',
96 => 'IMCA',
97 => 'IMPE',
98 => 'INDI',
99 => 'INFI',
100 => 'INME',
101 => 'INTL',
102 => 'INTR',
103 => 'ISLA',
104 => 'ISU',
105 => 'ITAL',
107 => 'JAGU',
108 => 'JEEP',
109 => 'JENS',
110 => 'KAIS',
111 => 'KAWK',
112 => 'KIA',
113 => 'LANC',
114 => 'LAND',
115 => 'LECL',
116 => 'LEXS',
117 => 'LINC',
118 => 'LOND',
119 => 'LOTU',
120 => 'MACK',
121 => 'MARM',
122 => 'MAXL',
123 => 'MAZD',
124 => 'MERZ',
125 => 'MERC',
126 => 'MERR',
127 => 'MESS',
128 => 'METZ',
129 => 'MG',
130 => 'MGTD',
131 => 'MINM',
132 => 'MITS',
133 => 'MORG',
134 => 'MORR',
135 => 'NATL',
137 => 'OAKL',
138 => 'OLDS',
139 => 'ALLE',
140 => 'MALL',
141 => 'PACK',
142 => 'PANO',
143 => 'PANT',
144 => 'PEUG',
145 => 'PLYM',
146 => 'PONT',
147 => 'PORS',
148 => 'PUCH',
149 => 'RAMB',
150 => 'RECO',
151 => 'RENA',
152 => 'REO',
153 => 'REPL',
154 => 'RICK',
155 => 'ROAD',
156 => 'ROAR',
157 => 'ROLL',
158 => 'ROOT',
159 => 'ROV',
160 => 'SAA',
161 => 'SAFA',
162 => 'STRN',
163 => 'SATU',
164 => 'SAXO',
165 => 'SEAT',
166 => 'SEBR',
167 => 'SGV',
168 => 'SHAY',
169 => 'SHEB',
170 => 'CARP',
171 => 'SPNT',
172 => 'SPEC',
173 => 'STAN',
174 => 'STEP',
175 => 'STER',
176 => 'STU',
177 => 'SUBA',
178 => 'SUNB',
179 => 'SUZI',
180 => 'SUZU',
181 => 'TEMP',
182 => 'TIGE',
183 => 'TORE',
184 => 'TOTA',
185 => 'TOYT',
186 => 'TRAN',
187 => 'TRID',
188 => 'TRUM',
189 => 'TROP',
190 => 'UNIQ',
191 => 'UNIT',
192 => 'UNIV',
193 => 'VANH',
194 => 'VNDN',
195 => 'VINT',
196 => 'VOLK',
197 => 'VOLV',
198 => 'WHAR',
199 => 'WHCO',
200 => 'WHEE',
201 => 'WHIT',
202 => 'WHGM',
203 => 'WILD',
204 => 'WLLS',
205 => 'WILL',
206 => 'WILS',
207 => 'WILY',
208 => 'WINN',
209 => 'YAMA',
210 => 'YUGO',
211 => 'ZIPP',
212 => 'GEO',
213 => 'RANG',
214 => 'MINI',
215 => 'LEXU',
216 => 'JEP',
217 => 'KAW',
218 => 'LNDR',
219 => 'MERK',
220 => 'HINO',
221 => 'YAM',
222 => 'RIVA',
223 => 'NISS',
224 => 'MINC',
225 => 'HUMM',
226 => 'VESP',
227 => 'ASUN',
228 => 'AUTC',
229 => 'AUTO',
230 => 'CPIU',
231 => 'EGIL',
232 => 'GEM',
233 => 'GM',
234 => 'IVEC',
235 => 'KW',
236 => 'LADA',
237 => 'LAFR',
238 => 'LAMO',
239 => 'LNCI',
240 => 'MASE',
241 => 'MAYB',
242 => 'MIN',
243 => 'MNNI',
244 => 'OSHK',
245 => 'PASS',
246 => 'PTRB',
247 => 'ROL',
248 => 'SPNR',
249 => 'STLG',
250 => 'STRG',
251 => 'TRIU',
252 => 'UD',
253 => 'VCTY',
254 => 'WSTR',
255 => 'ZONG',
'OTHER');

