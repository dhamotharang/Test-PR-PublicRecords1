<html><head><title>Shellpoint Custom Model (previous_nonHE segment)</title></head><body>
<h1>Shellpoint Custom Model (previous_nonHE segment)(RVC2004_2_0)</h1><p>
<h2>Whole Model Information</h2>
This is a single scorecard model.</p>
<p>This model uses reason method AscendingNonZeroWithInquiry.</p>
LUCI made the following notes while compiling the .CSV: <ul>
<li>Line: 46, Severity: WARNING, Message: RC [C12] used with multiple Inds</li><li>Line: 46, Severity: WARNING, Message: RC [Z01] used with multiple Inds</li>
</ul>
</body></html>
<h2>Exceptions</h2>There are also exception conditions in which the scorecards are bypassed, defined as follows:
<ul><li><b>RV5_Attr_200 - </b>
If <code>(real) ssndeceased = 1 or (real) subjectdeceased = 1</code> is true then the score is set to 200
 and a reason code of  is set.</li><li><b>RV5_Attr_222 - </b>
If <code>(real) confirmationsubjectfound = -998 or (real) confirmationsubjectfound < 1</code> is true then the score is set to 222
 and a reason code of  is set.</li></ul>
<h2>ScoreCard - SCORECARD_model12</h2>
This scorecard is a linear model.
<ul><li>The weights for each variable are computed as defined below</li><li>Combined_score is then calculated by adding the individual weights together</li>
<li>Raw_point is then calculated by adding the Combined_score to the Constant -1.80641556868857</li>
<li>The score is then processed according to the formula (700 + 20 * ((Raw_point - 0 - LN(0.049227)) / LN(2))).</li>
<li>The value is then rounded to the nearest integer.</li>
<li>If the value is less than 501 it is set to 501.</li>
<li>If the value is greater than 900 it is set to 900.</li>

<h3>Independant Variables</h3>
<p><b>ChargeOffAmount</b> is defined in 8 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td>Z01</td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td></td></tr><tr><td>-999999999</td><td>4432.92</td><td>-0.368397706825698</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td>Z04</td></tr><tr><td>4432.92</td><td>11517.91</td><td>-0.124064717201017</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td>Z04</td></tr><tr><td>11517.91</td><td>16063.795</td><td>-0.0427750798132533</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td>Z04</td></tr><tr><td>16063.795</td><td>24316.115</td><td>0.0735522392490668</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td>Z04</td></tr><tr><td>24316.115</td><td>47222.515</td><td>0.196296354816782</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td>Z04</td></tr><tr><td>47222.515</td><td>HIGH</td><td>0.307355877385115</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.307355877385115</td><td></td></tr>
</table></p>
<p><b>OutOfStatuteIndicator</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.522622593458921</td><td>Z01</td></tr><tr><td>N</td><td>N</td><td>0.522622593458921</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.522622593458921</td><td></td></tr><tr><td>Y</td><td>Y</td><td>-0.52216878252275</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.522622593458921</td><td>Z03</td></tr><tr><td></td><td>HIGH</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.522622593458921</td><td>Z03</td></tr>
</table></p>
<p><b>addrinputownershipindex</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.123004769601752</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.123004769601752</td><td>C12</td></tr><tr><td>-999999999</td><td>3.5</td><td>-0.0530990948270477</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.123004769601752</td><td>A44</td></tr><tr><td>3.5</td><td>HIGH</td><td>0.123004769601752</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.123004769601752</td><td></td></tr>
</table></p>
<p><b>confirmationinputaddress</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0923792591262736</td><td></td></tr><tr><td>-1</td><td>-1</td><td>-0.337887501368304</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0923792591262736</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-3.92028713838522E-4</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0923792591262736</td><td>F01</td></tr><tr><td>0.5</td><td>HIGH</td><td>0.0923792591262736</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.0923792591262736</td><td></td></tr>
</table></p>
<p><b>dayssince_LastPaymentDate</b> is defined in 7 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td>Z01</td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td></td></tr><tr><td>-999999999</td><td>13.5</td><td>2.90868702779944</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td></td></tr><tr><td>13.5</td><td>25.5</td><td>2.79160099181279</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td>Z06</td></tr><tr><td>25.5</td><td>63.5</td><td>1.8704884685878</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td>Z06</td></tr><tr><td>63.5</td><td>227.5</td><td>0.148985327141811</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td>Z06</td></tr><tr><td>227.5</td><td>HIGH</td><td>-2.28956824523366</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>2.90868702779944</td><td>Z06</td></tr>
</table></p>
<p><b>derogcount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.206897909402591</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.206897909402591</td><td>C12</td></tr><tr><td>-999999999</td><td>1.5</td><td>0.206897909402591</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.206897909402591</td><td></td></tr><tr><td>1.5</td><td>HIGH</td><td>-0.206841677937945</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.206897909402591</td><td>D30</td></tr>
</table></p>
<p><b>inputprovidedphone</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.11595697711271</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.11595697711271</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.115997439845944</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.11595697711271</td><td>F05</td></tr><tr><td>0.5</td><td>HIGH</td><td>0.11595697711271</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.11595697711271</td><td></td></tr>
</table></p>
<p><b>sourcecredheadertimeoldest</b> is defined in 5 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.188800668917611</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.188800668917611</td><td>C12</td></tr><tr><td>-999999999</td><td>293.5</td><td>-0.135530518722703</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.188800668917611</td><td>C20</td></tr><tr><td>293.5</td><td>421.5</td><td>-0.0694870572956636</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.188800668917611</td><td>C20</td></tr><tr><td>421.5</td><td>HIGH</td><td>0.188800668917611</td><td>0.0</td><td>NUMBER</td><td>0.0</td><td>0.188800668917611</td><td></td></tr>
</table></p>

</ul>
