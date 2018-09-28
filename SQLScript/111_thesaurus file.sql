English file code 1033
English File name: <SQL_Server_data_files_path>\MSSQL12.MSSQLSERVER\MSSQL\FTDATA\tsenu.xml
Neutral file code : 0
Neutral file File name: <SQL_Server_data_files_path>\MSSQL12.MSSQLSERVER\MSSQL\FTDATA\tsglobal.xml




To load an updated thesaurus file
使用 sp_fulltext_load_thesaurus_file 将同义词库文件的内容加载到 tempdb 中
EXEC sys.sp_fulltext_load_thesaurus_file 0;




To edit a thesaurus file
Edit  thesaurus_file



C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\FTData\tsglobal.xml

<XML ID="Microsoft Search Thesaurus">
  <thesaurus xmlns="x-schema:tsSchema.xml">
    <diacritics_sensitive>0</diacritics_sensitive>
    <expansion>
      <sub>AB</sub>
      <sub>Alberta</sub>
    </expansion>
    <expansion>
      <sub>British Columbia</sub>
      <sub>BC</sub>
    </expansion>
    <expansion>
      <sub>MB</sub>
      <sub>Manitoba</sub>
    </expansion>
    <expansion>
      <sub>New Brunswick</sub>
      <sub>NB</sub>
    </expansion>
    <replacement>
      <pat>Newfoundland and Labrador</pat>
      <sub>NL</sub>
    </replacement>
    <expansion>
      <sub>Newfoundland and Labrador</sub>
      <sub>Newfoundland</sub>
      <sub>Labrador</sub>
      <sub>NL</sub>
    </expansion>
    <expansion>
      <sub>Nova Scotia</sub>
      <sub>NS</sub>
    </expansion>
    <expansion>
      <sub>Northwest Territories</sub>
      <sub>Northwest</sub>
      <sub>NT</sub>
    </expansion>
    <expansion>
      <sub>NU</sub>
      <sub>Nunavut</sub>
    </expansion>
    <expansion>
      <sub>on</sub>
      <sub>ont</sub>
      <sub>ontario</sub>
    </expansion>
    <expansion>
      <sub>Prince Edward Island</sub>
      <sub>PE</sub>
      <sub>PEI</sub>
    </expansion>
    <expansion>
      <sub>QC</sub>
      <sub>Quebec</sub>
    </expansion>
    <expansion>
      <sub>SK</sub>
      <sub>Saskatchewan</sub>
    </expansion>
    <expansion>
      <sub>YT</sub>
      <sub>Yukon</sub>
    </expansion>
    <expansion>
      <sub>Sexually transmitted infection</sub>
      <sub>STD</sub>
      <sub>STI</sub>
    </expansion>
    <expansion>
      <sub>Bulimia</sub>
      <sub>Anorexia</sub>
      <sub>Eating Disorders</sub>
    </expansion>
    <expansion>
      <sub>Self Injury</sub>
      <sub>Self Harm</sub>
      <sub>Injury</sub>
      <sub>Harm</sub>
    </expansion>
    <expansion>
      <sub>Helpline</sub>
      <sub>Hotline</sub>
      <sub>Distress Line</sub>
      <sub>Crisis Line</sub>
    </expansion>
    <expansion>
      <sub>Employment</sub>
      <sub>Job</sub>
      <sub>Work</sub>
    </expansion>
    <expansion>
      <sub>Bereavement</sub>
      <sub>Grief and loss</sub>
    </expansion>
    <expansion>
      <sub>Domestic violence</sub>
      <sub>Spousal abuse</sub>
      <sub>Partner abuse</sub>
    </expansion>
    <expansion>
      <sub>LGBTQ</sub>
      <sub>Lesbian</sub>
      <sub>Gay</sub>
      <sub>Trans</sub>
      <sub>Transgender</sub>
      <sub>Queer</sub>
      <sub>Bisexual</sub>
      <sub>Pansexual</sub>
    </expansion>
    <expansion>
      <sub>Drugs</sub>
      <sub>Substance Abuse</sub>
      <sub>Alcohol</sub>
      <sub>Smoking</sub>
    </expansion>
    <expansion>
      <sub>Sexual assault</sub>
      <sub>Rape</sub>
    </expansion>
    <expansion>
      <sub>Domestic violence shelter</sub>
      <sub>Women’s shelter</sub>
      <sub>Women’s centre</sub>
      <sub>Family shelter</sub>
    </expansion>
    <expansion>
      <sub>Contraception</sub>
      <sub>Birth control</sub>
      <sub>Condoms</sub>
    </expansion>
    <expansion>
      <sub>Emergency contraception</sub>
      <sub>Plan B</sub>
      <sub>Morning after pill</sub>
      <sub>The pill</sub>
    </expansion>
    <expansion>
      <sub>Sexual orientation</sub>
      <sub>Gender identity</sub>
    </expansion>
    <expansion>
      <sub>Financial aid</sub>
      <sub>Welfare</sub>
      <sub>Social assistance</sub>
      <sub>Employment insurance</sub>
      <sub>EI</sub>
    </expansion>
  </thesaurus>
</XML>
